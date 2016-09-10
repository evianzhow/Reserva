//
//  Model.h
//  Reserva
//
//  Created by Yifei Zhou on 9/10/16.
//  Copyright © 2016 Aladdin Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Model : NSObject

@property (nonatomic, readonly) NSArray *models;

+ (instancetype)sharedModel;

+ (NSDictionary *)modelInfoFromModelString:(NSString *)modelString;

@end
