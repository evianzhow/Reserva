//
//  AvailabilityTableViewController.m
//  Reserva
//
//  Created by Yifei Zhou on 9/9/16.
//  Copyright © 2016 Aladdin Inc. All rights reserved.
//

#import "ModelAvailabilityTableViewController.h"
#import "Store.h"
#import "URLConstants.h"
#import <AFNetworking/AFNetworking.h>
#import <SVProgressHUD/SVProgressHUD.h>

static NSString *const AVAILABLE_STATUS_STRING = @"ALL";
static NSString *const NONAVAILABLE_STATUS_STRING = @"NONE";

static const NSTimeInterval refreshTimeInterval = 5.0f;

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
    self.refreshTimer = [NSTimer timerWithTimeInterval:refreshTimeInterval repeats:YES block:^(NSTimer * _Nonnull timer) {
        if (weakSelf.fetching) return;
        [weakSelf checkAvailabilityForModel:weakSelf.modelString];
    }];
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

    NSURL *URL = [NSURL URLWithString:API_AVAILABILITY_URL];
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
    
    NSMutableArray *results = [@[] mutableCopy];
    
    for (NSString *storeKey in [response allKeys]) {
        if (![storeKey hasPrefix:@"R"]) continue;
        NSDictionary *storeStatus = response[storeKey];
        if (!storeStatus[self.modelString]) continue;
        [results addObject:@{
                             @"storeInfo": [Store storeInfoFromNumber:storeKey] ? : [NSNull null],
                             @"availability": storeStatus[self.modelString],
                             @"timeSlot": storeStatus[@"timeSlot"] ? (storeStatus[@"timeSlot"][@"zh_CN"] ? (storeStatus[@"timeSlot"][@"zh_CN"][@"timeslotTime"] ? : [NSNull null]) : [NSNull null]) : [NSNull null]
                             }];
    }
    
    self.results = [NSArray arrayWithArray:results];
    [self.tableView reloadData];
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
    pickupTimeLabel.text = itemInfo[@"timeSlot"];
    setupAvailabilityStatusLabelFromStatus(itemInfo[@"availability"], availabilityStatusLabel);
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:RESERVATION_URL] options:@{} completionHandler:^(BOOL success) {
    }];
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
