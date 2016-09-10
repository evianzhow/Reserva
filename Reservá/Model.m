//
//  Model.m
//  Reserva
//
//  Created by Yifei Zhou on 9/10/16.
//  Copyright © 2016 Aladdin Inc. All rights reserved.
//

#import "Model.h"

@interface Model ()

@end

@implementation Model

+ (instancetype)sharedModel
{
    static Model *model = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        model = [[self alloc] init];
    });
    return model;
}

- (NSArray *)models
{
    return @[
             @{ @"MNGQ2CH/A": @{ @"name": @"iPhone 7 32GB 黑色", @"capacity": @"32GB" } },
             @{ @"MNGR2CH/A": @{ @"name": @"iPhone 7 32GB 银色", @"capacity": @"32GB" } },
             @{ @"MNGT2CH/A": @{ @"name": @"iPhone 7 32GB 金色", @"capacity": @"32GB" } },
             @{ @"MNGW2CH/A": @{ @"name": @"iPhone 7 32GB 玫瑰金色", @"capacity": @"32GB" } },
             @{ @"MNGX2CH/A": @{ @"name": @"iPhone 7 128GB 黑色", @"capacity": @"128GB" } },
             @{ @"MNGY2CH/A": @{ @"name": @"iPhone 7 128GB 银色", @"capacity": @"128GB" } },
             @{ @"MNH02CH/A": @{ @"name": @"iPhone 7 128GB 金色", @"capacity": @"128GB" } },
             @{ @"MNH12CH/A": @{ @"name": @"iPhone 7 128GB 玫瑰金色", @"capacity": @"128GB" } },
             @{ @"MNH22CH/A": @{ @"name": @"iPhone 7 128GB 亮黑色", @"capacity": @"128GB" } },
             @{ @"MNH32CH/A": @{ @"name": @"iPhone 7 256GB 黑色", @"capacity": @"256GB" } },
             @{ @"MNH42CH/A": @{ @"name": @"iPhone 7 256GB 银色", @"capacity": @"256GB" } },
             @{ @"MNH52CH/A": @{ @"name": @"iPhone 7 256GB 金色", @"capacity": @"256GB" } },
             @{ @"MNH62CH/A": @{ @"name": @"iPhone 7 256GB 玫瑰金色", @"capacity": @"256GB" } },
             @{ @"MNH72CH/A": @{ @"name": @"iPhone 7 256GB 亮黑色", @"capacity": @"256GB" } },
             @{ @"MNFP2CH/A": @{ @"name": @"iPhone 7 Plus 128GB 黑色", @"capacity": @"128GB" } },
             @{ @"MNFQ2CH/A": @{ @"name": @"iPhone 7 Plus 128GB 银色", @"capacity": @"128GB" } },
             @{ @"MNFR2CH/A": @{ @"name": @"iPhone 7 Plus 128GB 金色", @"capacity": @"128GB" } },
             @{ @"MNFT2CH/A": @{ @"name": @"iPhone 7 Plus 128GB 玫瑰金色", @"capacity": @"128GB" } },
             @{ @"MNFU2CH/A": @{ @"name": @"iPhone 7 Plus 128GB 亮黑色", @"capacity": @"128GB" } },
             @{ @"MNFV2CH/A": @{ @"name": @"iPhone 7 Plus 256GB 黑色", @"capacity": @"256GB" } },
             @{ @"MNFW2CH/A": @{ @"name": @"iPhone 7 Plus 256GB 银色", @"capacity": @"256GB" } },
             @{ @"MNFX2CH/A": @{ @"name": @"iPhone 7 Plus 256GB 金色", @"capacity": @"256GB" } },
             @{ @"MNFY2CH/A": @{ @"name": @"iPhone 7 Plus 256GB 玫瑰金色", @"capacity": @"256GB" } },
             @{ @"MNG02CH/A": @{ @"name": @"iPhone 7 Plus 256GB 亮黑色", @"capacity": @"256GB" } },
             @{ @"MNRJ2CH/A": @{ @"name": @"iPhone 7 Plus 32GB 黑色", @"capacity": @"32GB" } },
             @{ @"MNRK2CH/A": @{ @"name": @"iPhone 7 Plus 32GB 银色", @"capacity": @"32GB" } },
             @{ @"MNRL2CH/A": @{ @"name": @"iPhone 7 Plus 32GB 金色", @"capacity": @"32GB" } },
             @{ @"MNRM2CH/A": @{ @"name": @"iPhone 7 Plus 32GB 玫瑰金色", @"capacity": @"32GB" } }
             ];
}

+ (NSDictionary *)modelInfoFromModelString:(NSString *)modelString
{
    if ([modelString isEqualToString:@""] || !modelString) return nil;

    Model *model = [self sharedModel];
    
    for (NSDictionary *info in model.models) {
        if ([[modelString uppercaseString] isEqualToString:info.allKeys.firstObject]) {
            return info;
        }
    }
    
    return nil;
}

@end
