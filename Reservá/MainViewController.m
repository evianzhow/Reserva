//
//  ViewController.m
//  Reservá
//
//  Created by Yifei Zhou on 9/9/16.
//  Copyright © 2016 Aladdin Inc. All rights reserved.
//

#import "MainViewController.h"
#import "Store.h"

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

@end
