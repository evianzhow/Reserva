//
//  ViewController.m
//  Reservá
//
//  Created by Yifei Zhou on 9/9/16.
//  Copyright © 2016 Aladdin Inc. All rights reserved.
//

#import "MainViewController.h"
#import "Store.h"
#import "Constants.h"

NSString *const RegionGetChangedNotification = @"RegionGetChanged";

@interface MainViewController ()

@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;

@property (strong, nonatomic) Store *sharedStore;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    {
        self.title = @"Reservation";
        [self didStartLoadingStores:nil];
        
        UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(didTappedRefreshSettings:)];
        self.navigationItem.rightBarButtonItem = leftBarItem;
        
        UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithTitle:@"Region" style:UIBarButtonItemStylePlain target:self action:@selector(didTappedRegionSettings:)];
        self.navigationItem.leftBarButtonItem = rightBarItem;
    }
    
    self.sharedStore = [Store sharedStore];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didStartLoadingStores:) name:StoreGetLoadingNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceivedStores:) name:StoreGetReadyNotification object:nil];
}

- (void)didStartLoadingStores:(NSNotification *)noti
{
    self.nextButton.enabled = NO;
    self.indicator.hidden = NO;
    [self.indicator startAnimating];
}

- (void)didReceivedStores:(NSNotification *)noti
{
    {
        self.indicator.hidden = YES;
        [self.indicator stopAnimating];
        BOOL enabled = NO;
        for (NSDictionary *store in self.sharedStore.stores) {
            enabled |= [store[@"storeEnabled"] boolValue];
        }
        self.nextButton.enabled = enabled;
    }
}

- (IBAction)didTappedRefreshSettings:(id)sender
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Refresh Interval" message:@"Choose the refresh interval you preferred. " preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"10 Seconds" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[NSUserDefaults standardUserDefaults] setInteger:10 forKey:REFRESH_TIME_INTERVAL_STORED_KEY];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"30 Seconds - Default" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [[NSUserDefaults standardUserDefaults] setInteger:30 forKey:REFRESH_TIME_INTERVAL_STORED_KEY];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"1 Minute" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[NSUserDefaults standardUserDefaults] setInteger:60 forKey:REFRESH_TIME_INTERVAL_STORED_KEY];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"No refresh" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[NSUserDefaults standardUserDefaults] setInteger:NSIntegerMax forKey:REFRESH_TIME_INTERVAL_STORED_KEY];
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}

- (IBAction)didTappedRegionSettings:(id)sender
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Refresh Interval" message:@"Choose the refresh interval you preferred. " preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"Mainland China - Default" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [[NSUserDefaults standardUserDefaults] setObject:@"CN" forKey:REGION_STORED_KEY];
        [[NSNotificationCenter defaultCenter] postNotificationName:RegionGetChangedNotification object:nil];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"Hong Kong PRC" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[NSUserDefaults standardUserDefaults] setObject:@"HK" forKey:REGION_STORED_KEY];
        [[NSNotificationCenter defaultCenter] postNotificationName:RegionGetChangedNotification object:nil];
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
