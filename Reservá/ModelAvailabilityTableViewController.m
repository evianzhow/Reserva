//
//  AvailabilityTableViewController.m
//  Reserva
//
//  Created by Yifei Zhou on 9/9/16.
//  Copyright © 2016 Aladdin Inc. All rights reserved.
//

#import "ModelAvailabilityTableViewController.h"
#import "Store.h"
#import "Constants.h"
#import <AFNetworking/AFNetworking.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import <AudioToolbox/AudioServices.h>

static NSString *const AVAILABLE_STATUS_STRING = @"ALL";
static NSString *const NONAVAILABLE_STATUS_STRING = @"NONE";

static const NSTimeInterval defaultRefreshTimeInterval = 30.0f;

@interface ModelAvailabilityTableViewController ()

@property (strong, nonatomic) UISegmentedControl *segmentControl;

@property (strong, nonatomic) UIActivityIndicatorView *indicator;

@property (strong, nonatomic) NSArray *results;

@property (assign, nonatomic) BOOL stockOnly;

@property (assign, nonatomic) BOOL firstLoad;

@property (assign, nonatomic) BOOL fetching;

@property (strong, nonatomic) NSTimer *refreshTimer;

@end

@implementation ModelAvailabilityTableViewController

+ (NSTimeInterval)refreshTimeInterval
{
    NSUInteger storedTime = [[NSUserDefaults standardUserDefaults] integerForKey:REFRESH_TIME_INTERVAL_STORED_KEY];
    if (storedTime == 0) {
        return defaultRefreshTimeInterval;
    } else {
        return (NSTimeInterval)storedTime;
    }
}

- (UISegmentedControl *)segmentControl
{
    if (!_segmentControl) {
        _segmentControl = [[UISegmentedControl alloc] initWithItems:@[@"全部", @"仅有货"]];
        [_segmentControl addTarget:self action:@selector(didChangedFilter:) forControlEvents:UIControlEventValueChanged];
        _segmentControl.selectedSegmentIndex = 0;
    }
    return _segmentControl;
}

- (UIActivityIndicatorView *)indicator
{
    if (!_indicator) {
        _indicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        _indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    }
    return _indicator;
}

- (NSArray *)results
{
    if (self.stockOnly && self.modelString && ![self.modelString isEqualToString:@""]) {
        NSMutableArray *array = [@[] mutableCopy];
        for (NSDictionary *dict in _results) {
            if ([dict[@"availability"] isEqualToString:AVAILABLE_STATUS_STRING]) {
                [array addObject:dict];
            }
        }
        return [NSArray arrayWithArray:array];
    }
    
    return _results;
}

- (void)setStockOnly:(BOOL)stockOnly
{
    _stockOnly = stockOnly;
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.stockOnly = NO;
    self.firstLoad = YES;
    
    self.clearsSelectionOnViewWillAppear = YES;
    
    self.navigationItem.titleView = self.segmentControl;
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:self.indicator];
    self.navigationItem.rightBarButtonItem = barButton;

    [self checkAvailabilityForModel:self.modelString];
    
    __weak __typeof__(self) weakSelf = self;
    if (SYSTEM_VERSION_GREATER_THAN(@"10")) {
        self.refreshTimer = [NSTimer timerWithTimeInterval:[[self class] refreshTimeInterval] repeats:YES block:^(NSTimer * _Nonnull timer) {
            if (weakSelf.fetching) return;
            [weakSelf checkAvailabilityForModel:weakSelf.modelString];
        }];
    } else {
        self.refreshTimer = [NSTimer timerWithTimeInterval:[[self class] refreshTimeInterval] target:weakSelf selector:@selector(refreshTimerInvoked:) userInfo:nil repeats:YES];
    }
}

// iOS 9 Compatibility
- (IBAction)refreshTimerInvoked:(id)sender
{
    if (self.fetching) return;
    [self checkAvailabilityForModel:self.modelString];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [SVProgressHUD dismiss];
}

- (void)dealloc
{
    [self.refreshTimer invalidate];
    self.refreshTimer = nil;
}

- (void)setFetching:(BOOL)fetching
{
    _fetching = fetching;
    if (fetching && self.firstLoad) {
        [SVProgressHUD show];
        self.indicator.hidden = YES;
    } else if (fetching && !self.firstLoad) {
        [SVProgressHUD dismiss];
        self.indicator.hidden = NO;
        [self.indicator startAnimating];
    } else {
        [SVProgressHUD dismiss];
        self.indicator.hidden = YES;
        [self.indicator stopAnimating];
    }
}

- (void)checkAvailabilityForModel:(NSString *)modelString
{
    if ([modelString isEqualToString:@""] || !modelString) return;
    
    self.fetching = YES;
    
    NSString *interpolation = @"CN";
    id obj = [[NSUserDefaults standardUserDefaults] objectForKey:REGION_STORED_KEY];
    if ([obj isKindOfClass:[NSString class]] && [(NSString *)obj isEqualToString:@"HK"]) {
        interpolation = @"HK";
    }

    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:API_AVAILABILITY_URL, interpolation, interpolation]];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:URL.absoluteString parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        self.fetching = NO;
        NSLog(@"JSON: %@", responseObject);
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            [self handleFetchResults:responseObject];
        }
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        self.fetching = NO;
        NSLog(@"Error: %@", error);
    }];
}

- (void)handleFetchResults:(NSDictionary *)response
{
    if ([self.modelString isEqualToString:@""] || !self.modelString) return;

    if (self.firstLoad) {
        [[NSRunLoop currentRunLoop] addTimer:self.refreshTimer forMode:NSRunLoopCommonModes];
        self.firstLoad = NO;
    }
    
    NSString *interpolation = @"zh_CN";
    id obj = [[NSUserDefaults standardUserDefaults] objectForKey:REGION_STORED_KEY];
    if ([obj isKindOfClass:[NSString class]] && [(NSString *)obj isEqualToString:@"HK"]) {
        interpolation = @"zh_HK";
    }
    
    NSMutableArray *results = [@[] mutableCopy];
    
    for (NSString *storeKey in [response allKeys]) {
        if (![storeKey hasPrefix:@"R"]) continue;
        NSDictionary *storeStatus = response[storeKey];
        if (!storeStatus[self.modelString]) continue;
        [results addObject:@{
                             @"storeInfo": [Store storeInfoFromNumber:storeKey] ? : [NSNull null],
                             @"availability": storeStatus[self.modelString],
                             @"timeSlot": IS_NIL_OBJECT(storeStatus[@"timeSlot"])
                             ? [NSNull null]
                             : IS_NIL_OBJECT(storeStatus[@"timeSlot"][interpolation])
                                ? [NSNull null]
                                : IS_NIL_OBJECT(storeStatus[@"timeSlot"][interpolation][@"timeslotTime"])
                                   ? [NSNull null]
                                   : storeStatus[@"timeSlot"][interpolation][@"timeslotTime"]
                             }];
    }
    
    [self compareAndReload:results];
}

- (void)compareAndReload:(NSArray *)results
{
    NSArray *oldResults = [self.results copy];
    
    self.results = [NSArray arrayWithArray:results];
    [self.tableView reloadData];

    NSArray *newResults = [self.results copy];
    
    if (![newResults isEqualToArray:oldResults] && self.segmentControl.selectedSegmentIndex == 1) {
        AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
    }
}

- (IBAction)didChangedFilter:(id)sender
{
    self.stockOnly = self.segmentControl.selectedSegmentIndex == 1;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.results.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseIdentifier = @"reuseIdentifier1";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    NSDictionary *itemInfo = self.results[indexPath.row];
    
    // Configure the cell...
    UILabel *storeNameLabel = [cell viewWithTag:1];
    UILabel *pickupTimeLabel = [cell viewWithTag:2];
    UILabel *availabilityStatusLabel = [cell viewWithTag:3];
    
    NSDictionary *storeInfo = itemInfo[@"storeInfo"];
    if ([storeInfo isKindOfClass:[NSDictionary class]]) {
        storeNameLabel.text = [NSString stringWithFormat:@"%@，%@", storeInfo[@"storeCity"], storeInfo[@"storeName"]];
    }
    pickupTimeLabel.text = IS_NIL_OBJECT(itemInfo[@"timeSlot"]) ? @"不可用" : [NSString stringWithFormat:@"%@", itemInfo[@"timeSlot"]];
    setupAvailabilityStatusLabelFromStatus(itemInfo[@"availability"], availabilityStatusLabel);
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *interpolation = @"CN";
    id obj = [[NSUserDefaults standardUserDefaults] objectForKey:REGION_STORED_KEY];
    if ([obj isKindOfClass:[NSString class]] && [(NSString *)obj isEqualToString:@"HK"]) {
        interpolation = @"HK";
    }
    
    if ([self.modelString isEqualToString:@""] || !self.modelString) return;
    
    NSDictionary *itemInfo = self.results[indexPath.row];
    NSDictionary *storeInfo = itemInfo[@"storeInfo"];

    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:RESERVATION_URL_TEMPLATE, [interpolation lowercaseString], interpolation, interpolation, [self.modelString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLPathAllowedCharacterSet]], storeInfo[@"storeNumber"]]];

    if (SYSTEM_VERSION_GREATER_THAN(@"10")) {
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:^(BOOL success) {
        }];
    } else {
        [[UIApplication sharedApplication] openURL:url];
    }
}

void setupAvailabilityStatusLabelFromStatus(NSString *string, UILabel *label) {
    string = [string uppercaseString];
    if ([string isEqualToString:AVAILABLE_STATUS_STRING]) {
        label.text = @"有货";
        label.textColor = TRAFFIC_GREEN_COLOR;
    } else if ([string isEqualToString:NONAVAILABLE_STATUS_STRING]) {
        label.text = @"无货";
        label.textColor = TRAFFIC_RED_COLOR;
    } else {
        label.text = @"未知";
        label.textColor = TRAFFIC_YELLOW_COLOR;
    }
}

@end
