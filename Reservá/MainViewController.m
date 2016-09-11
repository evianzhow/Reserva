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
        self.nextButton.enabled = NO;
        self.indicator.hidden = NO;
        [self.indicator startAnimating];
        
        UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(didTappedRefreshSettings:)];
        self.navigationItem.rightBarButtonItem = barItem;
    }
    
    self.sharedStore = [Store sharedStore];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceivedStores:) name:StoreGetReadyNotification object:nil];
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

@end
