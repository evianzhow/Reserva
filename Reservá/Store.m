//
//  Store.m
//  Reserva
//
//  Created by Yifei Zhou on 9/9/16.
//  Copyright © 2016 Aladdin Inc. All rights reserved.
//

#import "Store.h"
#import <AFNetworking/AFNetworking.h>
#import "URLConstants.h"

NSString *const StoreGetReadyNotification = @"StoreGetReadyNotification";
NSString *const StoreGetLoadingNotification = @"StoreGetLoadingNotification";

@interface Store ()

@property (nonatomic, readwrite) NSArray *stores;

@end

@implementation Store

@synthesize stores = _stores;

+ (instancetype)sharedStore
{
    static Store *store = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        store = [[self alloc] init];
    });
    return store;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self getStores];
    }
    return self;
}

- (void)dealloc
{
    NSLog(@"%@ get dealloced!\n", NSStringFromClass([self class]));
}

- (void)getStores
{
    NSURL *URL = [NSURL URLWithString:API_STORES_URL];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:URL.absoluteString parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            [self setStoresResponse:responseObject];
        }
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    [[NSNotificationCenter defaultCenter] postNotificationName:StoreGetReadyNotification object:nil];
}

- (void)setStoresResponse:(NSDictionary *)response
{
    NSMutableArray *stores = [@[] mutableCopy];
    
    for (NSDictionary *store in response[@"stores"]) {
        [stores addObject:@{
                           @"storeNumber": store[@"storeNumber"],
                           @"storeName": store[@"storeName"],
                           @"storeCity": store[@"storeCity"],
                           }];
    }
    _stores = [NSArray arrayWithArray:stores];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:StoreGetReadyNotification object:nil];
}

+ (NSDictionary *)storeInfoFromNumber:(NSString *)numberString;
{
    if ([numberString isEqualToString:@""] || !numberString) return nil;
    
    Store *sharedStore = [self sharedStore];
    if (!sharedStore || !sharedStore.stores) return nil;
    
    for (NSDictionary *store in sharedStore.stores) {
        if ([store[@"storeNumber"] isEqualToString:numberString]) {
            return store;
        }
    }
    
    return nil;
}

@end
