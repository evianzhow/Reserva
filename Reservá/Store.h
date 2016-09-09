//
//  Store.h
//  Reserva
//
//  Created by Yifei Zhou on 9/9/16.
//  Copyright © 2016 Aladdin Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const StoreGetReadyNotification;
extern NSString *const StoreGetLoadingNotification;

@interface Store : NSObject

@property (nonatomic, readonly) NSArray *stores;

+ (instancetype)sharedStore;

+ (NSDictionary *)storeInfoFromNumber:(NSString *)numberString;

@end
