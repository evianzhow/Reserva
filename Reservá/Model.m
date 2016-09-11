//
//  Model.m
//  Reserva
//
//  Created by Yifei Zhou on 9/10/16.
//  Copyright © 2016 Aladdin Inc. All rights reserved.
//

#import "Model.h"
#import "Constants.h"

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
    id obj = [[NSUserDefaults standardUserDefaults] objectForKey:REGION_STORED_KEY];
    if ([obj isKindOfClass:[NSString class]] && [(NSString *)obj isEqualToString:@"HK"]) {
        return @[
                 @{ @"MN8G2ZP/A": @{
                            @"name": @"iPhone 7 32GB 黑色",
                            @"capacity": @"32GB",
                            @"colorSwatch": @"https://store.storeimages.cdn-apple.com/8748/as-images.apple.com/is/image/AppleInc/aos/published/images/i/ph/iphone7/black/iphone7-black-select-2016_SW_COLOR?wid=32&hei=32&fmt=jpeg&qlt=80&op_sharpen=0&resMode=bicub&op_usm=0.5,0.5,0,0&iccEmbed=0&layer=comp" }
                    },
                 @{ @"MN8H2ZP/A": @{
                            @"name": @"iPhone 7 32GB 銀色",
                            @"capacity": @"32GB",
                            @"colorSwatch": @"https://store.storeimages.cdn-apple.com/8748/as-images.apple.com/is/image/AppleInc/aos/published/images/i/ph/iphone7/silver/iphone7-silver-select-2016_SW_COLOR?wid=32&hei=32&fmt=jpeg&qlt=80&op_sharpen=0&resMode=bicub&op_usm=0.5,0.5,0,0&iccEmbed=0&layer=comp" }
                    },
                 @{ @"MN8J2ZP/A": @{
                            @"name": @"iPhone 7 32GB 金色",
                            @"capacity": @"32GB",
                            @"colorSwatch": @"https://store.storeimages.cdn-apple.com/8748/as-images.apple.com/is/image/AppleInc/aos/published/images/i/ph/iphone7/gold/iphone7-gold-select-2016_SW_COLOR?wid=32&hei=32&fmt=jpeg&qlt=80&op_sharpen=0&resMode=bicub&op_usm=0.5,0.5,0,0&iccEmbed=0&layer=comp" }
                    },
                 @{ @"MN8K2ZP/A": @{
                            @"name": @"iPhone 7 32GB 玫瑰金色",
                            @"capacity": @"32GB",
                            @"colorSwatch": @"https://store.storeimages.cdn-apple.com/8748/as-images.apple.com/is/image/AppleInc/aos/published/images/i/ph/iphone7/rosegold/iphone7-rosegold-select-2016_SW_COLOR?wid=32&hei=32&fmt=jpeg&qlt=80&op_sharpen=0&resMode=bicub&op_usm=0.5,0.5,0,0&iccEmbed=0&layer=comp" }
                    },
                 @{ @"MN8L2ZP/A": @{
                            @"name": @"iPhone 7 128GB 黑色",
                            @"capacity": @"128GB",
                            @"colorSwatch": @"https://store.storeimages.cdn-apple.com/8748/as-images.apple.com/is/image/AppleInc/aos/published/images/i/ph/iphone7/black/iphone7-black-select-2016_SW_COLOR?wid=32&hei=32&fmt=jpeg&qlt=80&op_sharpen=0&resMode=bicub&op_usm=0.5,0.5,0,0&iccEmbed=0&layer=comp" }
                    },
                 @{ @"MN8M2ZP/A": @{
                            @"name": @"iPhone 7 128GB 銀色",
                            @"capacity": @"128GB",
                            @"colorSwatch": @"https://store.storeimages.cdn-apple.com/8748/as-images.apple.com/is/image/AppleInc/aos/published/images/i/ph/iphone7/silver/iphone7-silver-select-2016_SW_COLOR?wid=32&hei=32&fmt=jpeg&qlt=80&op_sharpen=0&resMode=bicub&op_usm=0.5,0.5,0,0&iccEmbed=0&layer=comp" }
                    },
                 @{ @"MN8N2ZP/A": @{
                            @"name": @"iPhone 7 128GB 金色",
                            @"capacity": @"128GB",
                            @"colorSwatch": @"https://store.storeimages.cdn-apple.com/8748/as-images.apple.com/is/image/AppleInc/aos/published/images/i/ph/iphone7/gold/iphone7-gold-select-2016_SW_COLOR?wid=32&hei=32&fmt=jpeg&qlt=80&op_sharpen=0&resMode=bicub&op_usm=0.5,0.5,0,0&iccEmbed=0&layer=comp" }
                    },
                 @{ @"MN8P2ZP/A": @{
                            @"name": @"iPhone 7 128GB 玫瑰金色",
                            @"capacity": @"128GB",
                            @"colorSwatch": @"https://store.storeimages.cdn-apple.com/8748/as-images.apple.com/is/image/AppleInc/aos/published/images/i/ph/iphone7/rosegold/iphone7-rosegold-select-2016_SW_COLOR?wid=32&hei=32&fmt=jpeg&qlt=80&op_sharpen=0&resMode=bicub&op_usm=0.5,0.5,0,0&iccEmbed=0&layer=comp" }
                    },
                 @{ @"MN8Q2ZP/A": @{
                            @"name": @"iPhone 7 128GB 亮黑色",
                            @"capacity": @"128GB",
                            @"colorSwatch": @"https://store.storeimages.cdn-apple.com/8748/as-images.apple.com/is/image/AppleInc/aos/published/images/i/ph/iphone7/jetblack/iphone7-jetblack-select-2016_SW_COLOR?wid=32&hei=32&fmt=jpeg&qlt=80&op_sharpen=0&resMode=bicub&op_usm=0.5,0.5,0,0&iccEmbed=0&layer=comp" }
                    },
                 @{ @"MN8R2ZP/A": @{
                            @"name": @"iPhone 7 256GB 黑色",
                            @"capacity": @"256GB",
                            @"colorSwatch": @"https://store.storeimages.cdn-apple.com/8748/as-images.apple.com/is/image/AppleInc/aos/published/images/i/ph/iphone7/black/iphone7-black-select-2016_SW_COLOR?wid=32&hei=32&fmt=jpeg&qlt=80&op_sharpen=0&resMode=bicub&op_usm=0.5,0.5,0,0&iccEmbed=0&layer=comp" }
                    },
                 @{ @"MN8T2ZP/A": @{
                            @"name": @"iPhone 7 256GB 銀色",
                            @"capacity": @"256GB",
                            @"colorSwatch": @"https://store.storeimages.cdn-apple.com/8748/as-images.apple.com/is/image/AppleInc/aos/published/images/i/ph/iphone7/silver/iphone7-silver-select-2016_SW_COLOR?wid=32&hei=32&fmt=jpeg&qlt=80&op_sharpen=0&resMode=bicub&op_usm=0.5,0.5,0,0&iccEmbed=0&layer=comp" }
                    },
                 @{ @"MN8U2ZP/A": @{
                            @"name": @"iPhone 7 256GB 金色",
                            @"capacity": @"256GB",
                            @"colorSwatch": @"https://store.storeimages.cdn-apple.com/8748/as-images.apple.com/is/image/AppleInc/aos/published/images/i/ph/iphone7/gold/iphone7-gold-select-2016_SW_COLOR?wid=32&hei=32&fmt=jpeg&qlt=80&op_sharpen=0&resMode=bicub&op_usm=0.5,0.5,0,0&iccEmbed=0&layer=comp" }
                    },
                 @{ @"MN8V2ZP/A": @{
                            @"name": @"iPhone 7 256GB 玫瑰金色",
                            @"capacity": @"256GB",
                            @"colorSwatch": @"https://store.storeimages.cdn-apple.com/8748/as-images.apple.com/is/image/AppleInc/aos/published/images/i/ph/iphone7/rosegold/iphone7-rosegold-select-2016_SW_COLOR?wid=32&hei=32&fmt=jpeg&qlt=80&op_sharpen=0&resMode=bicub&op_usm=0.5,0.5,0,0&iccEmbed=0&layer=comp" }
                    },
                 @{ @"MN8W2ZP/A": @{
                            @"name": @"iPhone 7 256GB 亮黑色",
                            @"capacity": @"256GB",
                            @"colorSwatch": @"https://store.storeimages.cdn-apple.com/8748/as-images.apple.com/is/image/AppleInc/aos/published/images/i/ph/iphone7/jetblack/iphone7-jetblack-select-2016_SW_COLOR?wid=32&hei=32&fmt=jpeg&qlt=80&op_sharpen=0&resMode=bicub&op_usm=0.5,0.5,0,0&iccEmbed=0&layer=comp" }
                    },
                 @{ @"MN482ZP/A": @{
                            @"name": @"iPhone 7 Plus 128GB 黑色",
                            @"capacity": @"128GB",
                            @"colorSwatch": @"https://store.storeimages.cdn-apple.com/8748/as-images.apple.com/is/image/AppleInc/aos/published/images/i/ph/iphone7/plus/iphone7-plus-black-select-2016_SW_COLOR?wid=32&hei=32&fmt=jpeg&qlt=80&op_sharpen=0&resMode=bicub&op_usm=0.5,0.5,0,0&iccEmbed=0&layer=comp" }
                    },
                 @{ @"MN492ZP/A": @{
                            @"name": @"iPhone 7 Plus 128GB 銀色",
                            @"capacity": @"128GB",
                            @"colorSwatch": @"https://store.storeimages.cdn-apple.com/8748/as-images.apple.com/is/image/AppleInc/aos/published/images/i/ph/iphone7/plus/iphone7-plus-silver-select-2016_SW_COLOR?wid=32&hei=32&fmt=jpeg&qlt=80&op_sharpen=0&resMode=bicub&op_usm=0.5,0.5,0,0&iccEmbed=0&layer=comp" }
                    },
                 @{ @"MN4A2ZP/A": @{
                            @"name": @"iPhone 7 Plus 128GB 金色",
                            @"capacity": @"128GB",
                            @"colorSwatch": @"https://store.storeimages.cdn-apple.com/8748/as-images.apple.com/is/image/AppleInc/aos/published/images/i/ph/iphone7/plus/iphone7-plus-gold-select-2016_SW_COLOR?wid=32&hei=32&fmt=jpeg&qlt=80&op_sharpen=0&resMode=bicub&op_usm=0.5,0.5,0,0&iccEmbed=0&layer=comp" }
                    },
                 @{ @"MN4C2ZP/A": @{
                            @"name": @"iPhone 7 Plus 128GB 玫瑰金色",
                            @"capacity": @"128GB",
                            @"colorSwatch": @"https://store.storeimages.cdn-apple.com/8748/as-images.apple.com/is/image/AppleInc/aos/published/images/i/ph/iphone7/plus/iphone7-plus-rosegold-select-2016_SW_COLOR?wid=32&hei=32&fmt=jpeg&qlt=80&op_sharpen=0&resMode=bicub&op_usm=0.5,0.5,0,0&iccEmbed=0&layer=comp" }
                    },
                 @{ @"MN4D2ZP/A": @{
                            @"name": @"iPhone 7 Plus 128GB 亮黑色",
                            @"capacity": @"128GB",
                            @"colorSwatch": @"https://store.storeimages.cdn-apple.com/8748/as-images.apple.com/is/image/AppleInc/aos/published/images/i/ph/iphone7/plus/iphone7-plus-jetblack-select-2016_SW_COLOR?wid=32&hei=32&fmt=jpeg&qlt=80&op_sharpen=0&resMode=bicub&op_usm=0.5,0.5,0,0&iccEmbed=0&layer=comp" }
                    },
                 @{ @"MN4E2ZP/A": @{ 
                            @"name": @"iPhone 7 Plus 256GB 黑色",
                            @"capacity": @"256GB",
                            @"colorSwatch": @"https://store.storeimages.cdn-apple.com/8748/as-images.apple.com/is/image/AppleInc/aos/published/images/i/ph/iphone7/plus/iphone7-plus-black-select-2016_SW_COLOR?wid=32&hei=32&fmt=jpeg&qlt=80&op_sharpen=0&resMode=bicub&op_usm=0.5,0.5,0,0&iccEmbed=0&layer=comp" }
                    },
                 @{ @"MN4F2ZP/A": @{ 
                            @"name": @"iPhone 7 Plus 256GB 銀色",
                            @"capacity": @"256GB",
                            @"colorSwatch": @"https://store.storeimages.cdn-apple.com/8748/as-images.apple.com/is/image/AppleInc/aos/published/images/i/ph/iphone7/plus/iphone7-plus-silver-select-2016_SW_COLOR?wid=32&hei=32&fmt=jpeg&qlt=80&op_sharpen=0&resMode=bicub&op_usm=0.5,0.5,0,0&iccEmbed=0&layer=comp" }
                    },
                 @{ @"MN4J2ZP/A": @{ 
                            @"name": @"iPhone 7 Plus 256GB 金色",
                            @"capacity": @"256GB",
                            @"colorSwatch": @"https://store.storeimages.cdn-apple.com/8748/as-images.apple.com/is/image/AppleInc/aos/published/images/i/ph/iphone7/plus/iphone7-plus-gold-select-2016_SW_COLOR?wid=32&hei=32&fmt=jpeg&qlt=80&op_sharpen=0&resMode=bicub&op_usm=0.5,0.5,0,0&iccEmbed=0&layer=comp" }
                    },
                 @{ @"MN4K2ZP/A": @{ 
                            @"name": @"iPhone 7 Plus 256GB 玫瑰金色",
                            @"capacity": @"256GB",
                            @"colorSwatch": @"https://store.storeimages.cdn-apple.com/8748/as-images.apple.com/is/image/AppleInc/aos/published/images/i/ph/iphone7/plus/iphone7-plus-rosegold-select-2016_SW_COLOR?wid=32&hei=32&fmt=jpeg&qlt=80&op_sharpen=0&resMode=bicub&op_usm=0.5,0.5,0,0&iccEmbed=0&layer=comp" }
                    },
                 @{ @"MN4L2ZP/A": @{ 
                            @"name": @"iPhone 7 Plus 256GB 亮黑色",
                            @"capacity": @"256GB",
                            @"colorSwatch": @"https://store.storeimages.cdn-apple.com/8748/as-images.apple.com/is/image/AppleInc/aos/published/images/i/ph/iphone7/plus/iphone7-plus-jetblack-select-2016_SW_COLOR?wid=32&hei=32&fmt=jpeg&qlt=80&op_sharpen=0&resMode=bicub&op_usm=0.5,0.5,0,0&iccEmbed=0&layer=comp" }
                    },
                 @{ @"MNQH2ZP/A": @{ 
                            @"name": @"iPhone 7 Plus 32GB 黑色",
                            @"capacity": @"32GB",
                            @"colorSwatch": @"https://store.storeimages.cdn-apple.com/8748/as-images.apple.com/is/image/AppleInc/aos/published/images/i/ph/iphone7/plus/iphone7-plus-black-select-2016_SW_COLOR?wid=32&hei=32&fmt=jpeg&qlt=80&op_sharpen=0&resMode=bicub&op_usm=0.5,0.5,0,0&iccEmbed=0&layer=comp" }
                    },
                 @{ @"MNQJ2ZP/A": @{ 
                            @"name": @"iPhone 7 Plus 32GB 銀色",
                            @"capacity": @"32GB",
                            @"colorSwatch": @"https://store.storeimages.cdn-apple.com/8748/as-images.apple.com/is/image/AppleInc/aos/published/images/i/ph/iphone7/plus/iphone7-plus-silver-select-2016_SW_COLOR?wid=32&hei=32&fmt=jpeg&qlt=80&op_sharpen=0&resMode=bicub&op_usm=0.5,0.5,0,0&iccEmbed=0&layer=comp" }
                    },
                 @{ @"MNQK2ZP/A": @{ 
                            @"name": @"iPhone 7 Plus 32GB 金色",
                            @"capacity": @"32GB",
                            @"colorSwatch": @"https://store.storeimages.cdn-apple.com/8748/as-images.apple.com/is/image/AppleInc/aos/published/images/i/ph/iphone7/plus/iphone7-plus-gold-select-2016_SW_COLOR?wid=32&hei=32&fmt=jpeg&qlt=80&op_sharpen=0&resMode=bicub&op_usm=0.5,0.5,0,0&iccEmbed=0&layer=comp" }
                    },
                 @{ @"MNQL2ZP/A": @{ 
                            @"name": @"iPhone 7 Plus 32GB 玫瑰金色",
                            @"capacity": @"32GB",
                            @"colorSwatch": @"https://store.storeimages.cdn-apple.com/8748/as-images.apple.com/is/image/AppleInc/aos/published/images/i/ph/iphone7/plus/iphone7-plus-rosegold-select-2016_SW_COLOR?wid=32&hei=32&fmt=jpeg&qlt=80&op_sharpen=0&resMode=bicub&op_usm=0.5,0.5,0,0&iccEmbed=0&layer=comp" }
                    },

                 ];
    } else {
        return @[
                 @{ @"MNGQ2CH/A": @{
                            @"name": @"iPhone 7 32GB 黑色",
                            @"capacity": @"32GB",
                            @"colorSwatch": @"https://store.storeimages.cdn-apple.com/8748/as-images.apple.com/is/image/AppleInc/aos/published/images/i/ph/iphone7/black/iphone7-black-select-2016_SW_COLOR?wid=32&hei=32&fmt=jpeg&qlt=80&op_sharpen=0&resMode=bicub&op_usm=0.5,0.5,0,0&iccEmbed=0&layer=comp"
                            }
                    },
                 @{ @"MNGR2CH/A": @{
                            @"name": @"iPhone 7 32GB 银色",
                            @"capacity": @"32GB",
                            @"colorSwatch": @"https://store.storeimages.cdn-apple.com/8748/as-images.apple.com/is/image/AppleInc/aos/published/images/i/ph/iphone7/silver/iphone7-silver-select-2016_SW_COLOR?wid=32&hei=32&fmt=jpeg&qlt=80&op_sharpen=0&resMode=bicub&op_usm=0.5,0.5,0,0&iccEmbed=0&layer=comp"
                            }
                    },
                 @{ @"MNGT2CH/A": @{
                            @"name": @"iPhone 7 32GB 金色",
                            @"capacity": @"32GB",
                            @"colorSwatch": @"https://store.storeimages.cdn-apple.com/8748/as-images.apple.com/is/image/AppleInc/aos/published/images/i/ph/iphone7/gold/iphone7-gold-select-2016_SW_COLOR?wid=32&hei=32&fmt=jpeg&qlt=80&op_sharpen=0&resMode=bicub&op_usm=0.5,0.5,0,0&iccEmbed=0&layer=comp"
                            }
                    },
                 @{ @"MNGW2CH/A": @{
                            @"name": @"iPhone 7 32GB 玫瑰金色",
                            @"capacity": @"32GB",
                            @"colorSwatch": @"https://store.storeimages.cdn-apple.com/8748/as-images.apple.com/is/image/AppleInc/aos/published/images/i/ph/iphone7/rosegold/iphone7-rosegold-select-2016_SW_COLOR?wid=32&hei=32&fmt=jpeg&qlt=80&op_sharpen=0&resMode=bicub&op_usm=0.5,0.5,0,0&iccEmbed=0&layer=comp"
                            }
                    },
                 @{ @"MNGX2CH/A": @{
                            @"name": @"iPhone 7 128GB 黑色",
                            @"capacity": @"128GB",
                            @"colorSwatch": @"https://store.storeimages.cdn-apple.com/8748/as-images.apple.com/is/image/AppleInc/aos/published/images/i/ph/iphone7/black/iphone7-black-select-2016_SW_COLOR?wid=32&hei=32&fmt=jpeg&qlt=80&op_sharpen=0&resMode=bicub&op_usm=0.5,0.5,0,0&iccEmbed=0&layer=comp"
                            }
                    },
                 @{ @"MNGY2CH/A": @{
                            @"name": @"iPhone 7 128GB 银色",
                            @"capacity": @"128GB",
                            @"colorSwatch": @"https://store.storeimages.cdn-apple.com/8748/as-images.apple.com/is/image/AppleInc/aos/published/images/i/ph/iphone7/silver/iphone7-silver-select-2016_SW_COLOR?wid=32&hei=32&fmt=jpeg&qlt=80&op_sharpen=0&resMode=bicub&op_usm=0.5,0.5,0,0&iccEmbed=0&layer=comp"
                            }
                    },
                 @{ @"MNH02CH/A": @{
                            @"name": @"iPhone 7 128GB 金色",
                            @"capacity": @"128GB",
                            @"colorSwatch": @"https://store.storeimages.cdn-apple.com/8748/as-images.apple.com/is/image/AppleInc/aos/published/images/i/ph/iphone7/gold/iphone7-gold-select-2016_SW_COLOR?wid=32&hei=32&fmt=jpeg&qlt=80&op_sharpen=0&resMode=bicub&op_usm=0.5,0.5,0,0&iccEmbed=0&layer=comp"
                            }
                    },
                 @{ @"MNH12CH/A": @{
                            @"name": @"iPhone 7 128GB 玫瑰金色",
                            @"capacity": @"128GB",
                            @"colorSwatch": @"https://store.storeimages.cdn-apple.com/8748/as-images.apple.com/is/image/AppleInc/aos/published/images/i/ph/iphone7/rosegold/iphone7-rosegold-select-2016_SW_COLOR?wid=32&hei=32&fmt=jpeg&qlt=80&op_sharpen=0&resMode=bicub&op_usm=0.5,0.5,0,0&iccEmbed=0&layer=comp"
                            }
                    },
                 @{ @"MNH22CH/A": @{
                            @"name": @"iPhone 7 128GB 亮黑色",
                            @"capacity": @"128GB",
                            @"colorSwatch": @"https://store.storeimages.cdn-apple.com/8748/as-images.apple.com/is/image/AppleInc/aos/published/images/i/ph/iphone7/jetblack/iphone7-jetblack-select-2016_SW_COLOR?wid=32&hei=32&fmt=jpeg&qlt=80&op_sharpen=0&resMode=bicub&op_usm=0.5,0.5,0,0&iccEmbed=0&layer=comp"
                            }
                    },
                 @{ @"MNH32CH/A": @{
                            @"name": @"iPhone 7 256GB 黑色",
                            @"capacity": @"256GB",
                            @"colorSwatch": @"https://store.storeimages.cdn-apple.com/8748/as-images.apple.com/is/image/AppleInc/aos/published/images/i/ph/iphone7/black/iphone7-black-select-2016_SW_COLOR?wid=32&hei=32&fmt=jpeg&qlt=80&op_sharpen=0&resMode=bicub&op_usm=0.5,0.5,0,0&iccEmbed=0&layer=comp"
                            }
                    },
                 @{ @"MNH42CH/A": @{
                            @"name": @"iPhone 7 256GB 银色",
                            @"capacity": @"256GB",
                            @"colorSwatch": @"https://store.storeimages.cdn-apple.com/8748/as-images.apple.com/is/image/AppleInc/aos/published/images/i/ph/iphone7/silver/iphone7-silver-select-2016_SW_COLOR?wid=32&hei=32&fmt=jpeg&qlt=80&op_sharpen=0&resMode=bicub&op_usm=0.5,0.5,0,0&iccEmbed=0&layer=comp"
                            }
                    },
                 @{ @"MNH52CH/A": @{
                            @"name": @"iPhone 7 256GB 金色",
                            @"capacity": @"256GB",
                            @"colorSwatch": @"https://store.storeimages.cdn-apple.com/8748/as-images.apple.com/is/image/AppleInc/aos/published/images/i/ph/iphone7/gold/iphone7-gold-select-2016_SW_COLOR?wid=32&hei=32&fmt=jpeg&qlt=80&op_sharpen=0&resMode=bicub&op_usm=0.5,0.5,0,0&iccEmbed=0&layer=comp"
                            }
                    },
                 @{ @"MNH62CH/A": @{
                            @"name": @"iPhone 7 256GB 玫瑰金色",
                            @"capacity": @"256GB",
                            @"colorSwatch": @"https://store.storeimages.cdn-apple.com/8748/as-images.apple.com/is/image/AppleInc/aos/published/images/i/ph/iphone7/rosegold/iphone7-rosegold-select-2016_SW_COLOR?wid=32&hei=32&fmt=jpeg&qlt=80&op_sharpen=0&resMode=bicub&op_usm=0.5,0.5,0,0&iccEmbed=0&layer=comp"
                            }
                    },
                 @{ @"MNH72CH/A": @{
                            @"name": @"iPhone 7 256GB 亮黑色",
                            @"capacity": @"256GB",
                            @"colorSwatch": @"https://store.storeimages.cdn-apple.com/8748/as-images.apple.com/is/image/AppleInc/aos/published/images/i/ph/iphone7/jetblack/iphone7-jetblack-select-2016_SW_COLOR?wid=32&hei=32&fmt=jpeg&qlt=80&op_sharpen=0&resMode=bicub&op_usm=0.5,0.5,0,0&iccEmbed=0&layer=comp"
                            }
                    },
                 @{ @"MNFP2CH/A": @{
                            @"name": @"iPhone 7 Plus 128GB 黑色",
                            @"capacity": @"128GB",
                            @"colorSwatch": @"https://store.storeimages.cdn-apple.com/8748/as-images.apple.com/is/image/AppleInc/aos/published/images/i/ph/iphone7/plus/iphone7-plus-black-select-2016_SW_COLOR?wid=32&hei=32&fmt=jpeg&qlt=80&op_sharpen=0&resMode=bicub&op_usm=0.5,0.5,0,0&iccEmbed=0&layer=comp"
                            }
                    },
                 @{ @"MNFQ2CH/A": @{
                            @"name": @"iPhone 7 Plus 128GB 银色",
                            @"capacity": @"128GB",
                            @"colorSwatch": @"https://store.storeimages.cdn-apple.com/8748/as-images.apple.com/is/image/AppleInc/aos/published/images/i/ph/iphone7/plus/iphone7-plus-silver-select-2016_SW_COLOR?wid=32&hei=32&fmt=jpeg&qlt=80&op_sharpen=0&resMode=bicub&op_usm=0.5,0.5,0,0&iccEmbed=0&layer=comp"
                            }
                    },
                 @{ @"MNFR2CH/A": @{
                            @"name": @"iPhone 7 Plus 128GB 金色",
                            @"capacity": @"128GB",
                            @"colorSwatch": @"https://store.storeimages.cdn-apple.com/8748/as-images.apple.com/is/image/AppleInc/aos/published/images/i/ph/iphone7/plus/iphone7-plus-gold-select-2016_SW_COLOR?wid=32&hei=32&fmt=jpeg&qlt=80&op_sharpen=0&resMode=bicub&op_usm=0.5,0.5,0,0&iccEmbed=0&layer=comp"
                            }
                    },
                 @{ @"MNFT2CH/A": @{
                            @"name": @"iPhone 7 Plus 128GB 玫瑰金色",
                            @"capacity": @"128GB",
                            @"colorSwatch": @"https://store.storeimages.cdn-apple.com/8748/as-images.apple.com/is/image/AppleInc/aos/published/images/i/ph/iphone7/plus/iphone7-plus-rosegold-select-2016_SW_COLOR?wid=32&hei=32&fmt=jpeg&qlt=80&op_sharpen=0&resMode=bicub&op_usm=0.5,0.5,0,0&iccEmbed=0&layer=comp"
                            }
                    },
                 @{ @"MNFU2CH/A": @{
                            @"name": @"iPhone 7 Plus 128GB 亮黑色",
                            @"capacity": @"128GB",
                            @"colorSwatch": @"https://store.storeimages.cdn-apple.com/8748/as-images.apple.com/is/image/AppleInc/aos/published/images/i/ph/iphone7/plus/iphone7-plus-jetblack-select-2016_SW_COLOR?wid=32&hei=32&fmt=jpeg&qlt=80&op_sharpen=0&resMode=bicub&op_usm=0.5,0.5,0,0&iccEmbed=0&layer=comp"
                            }
                    },
                 @{ @"MNFV2CH/A": @{
                            @"name": @"iPhone 7 Plus 256GB 黑色",
                            @"capacity": @"256GB",
                            @"colorSwatch": @"https://store.storeimages.cdn-apple.com/8748/as-images.apple.com/is/image/AppleInc/aos/published/images/i/ph/iphone7/plus/iphone7-plus-black-select-2016_SW_COLOR?wid=32&hei=32&fmt=jpeg&qlt=80&op_sharpen=0&resMode=bicub&op_usm=0.5,0.5,0,0&iccEmbed=0&layer=comp"
                            }
                    },
                 @{ @"MNFW2CH/A": @{
                            @"name": @"iPhone 7 Plus 256GB 银色",
                            @"capacity": @"256GB",
                            @"colorSwatch": @"https://store.storeimages.cdn-apple.com/8748/as-images.apple.com/is/image/AppleInc/aos/published/images/i/ph/iphone7/plus/iphone7-plus-silver-select-2016_SW_COLOR?wid=32&hei=32&fmt=jpeg&qlt=80&op_sharpen=0&resMode=bicub&op_usm=0.5,0.5,0,0&iccEmbed=0&layer=comp"
                            }
                    },
                 @{ @"MNFX2CH/A": @{
                            @"name": @"iPhone 7 Plus 256GB 金色",
                            @"capacity": @"256GB",
                            @"colorSwatch": @"https://store.storeimages.cdn-apple.com/8748/as-images.apple.com/is/image/AppleInc/aos/published/images/i/ph/iphone7/plus/iphone7-plus-gold-select-2016_SW_COLOR?wid=32&hei=32&fmt=jpeg&qlt=80&op_sharpen=0&resMode=bicub&op_usm=0.5,0.5,0,0&iccEmbed=0&layer=comp"
                            }
                    },
                 @{ @"MNFY2CH/A": @{
                            @"name": @"iPhone 7 Plus 256GB 玫瑰金色",
                            @"capacity": @"256GB",
                            @"colorSwatch": @"https://store.storeimages.cdn-apple.com/8748/as-images.apple.com/is/image/AppleInc/aos/published/images/i/ph/iphone7/plus/iphone7-plus-rosegold-select-2016_SW_COLOR?wid=32&hei=32&fmt=jpeg&qlt=80&op_sharpen=0&resMode=bicub&op_usm=0.5,0.5,0,0&iccEmbed=0&layer=comp"
                            }
                    },
                 @{ @"MNG02CH/A": @{
                            @"name": @"iPhone 7 Plus 256GB 亮黑色",
                            @"capacity": @"256GB",
                            @"colorSwatch": @"https://store.storeimages.cdn-apple.com/8748/as-images.apple.com/is/image/AppleInc/aos/published/images/i/ph/iphone7/plus/iphone7-plus-jetblack-select-2016_SW_COLOR?wid=32&hei=32&fmt=jpeg&qlt=80&op_sharpen=0&resMode=bicub&op_usm=0.5,0.5,0,0&iccEmbed=0&layer=comp"
                            }
                    },
                 @{ @"MNRJ2CH/A": @{
                            @"name": @"iPhone 7 Plus 32GB 黑色",
                            @"capacity": @"32GB",
                            @"colorSwatch": @"https://store.storeimages.cdn-apple.com/8748/as-images.apple.com/is/image/AppleInc/aos/published/images/i/ph/iphone7/plus/iphone7-plus-black-select-2016_SW_COLOR?wid=32&hei=32&fmt=jpeg&qlt=80&op_sharpen=0&resMode=bicub&op_usm=0.5,0.5,0,0&iccEmbed=0&layer=comp"
                            }
                    },
                 @{ @"MNRK2CH/A": @{
                            @"name": @"iPhone 7 Plus 32GB 银色",
                            @"capacity": @"32GB",
                            @"colorSwatch": @"https://store.storeimages.cdn-apple.com/8748/as-images.apple.com/is/image/AppleInc/aos/published/images/i/ph/iphone7/plus/iphone7-plus-silver-select-2016_SW_COLOR?wid=32&hei=32&fmt=jpeg&qlt=80&op_sharpen=0&resMode=bicub&op_usm=0.5,0.5,0,0&iccEmbed=0&layer=comp"
                            }
                    },
                 @{ @"MNRL2CH/A": @{
                            @"name": @"iPhone 7 Plus 32GB 金色",
                            @"capacity": @"32GB",
                            @"colorSwatch": @"https://store.storeimages.cdn-apple.com/8748/as-images.apple.com/is/image/AppleInc/aos/published/images/i/ph/iphone7/plus/iphone7-plus-gold-select-2016_SW_COLOR?wid=32&hei=32&fmt=jpeg&qlt=80&op_sharpen=0&resMode=bicub&op_usm=0.5,0.5,0,0&iccEmbed=0&layer=comp"
                            }
                    },
                 @{ @"MNRM2CH/A": @{
                            @"name": @"iPhone 7 Plus 32GB 玫瑰金色",
                            @"capacity": @"32GB",
                            @"colorSwatch": @"https://store.storeimages.cdn-apple.com/8748/as-images.apple.com/is/image/AppleInc/aos/published/images/i/ph/iphone7/plus/iphone7-plus-rosegold-select-2016_SW_COLOR?wid=32&hei=32&fmt=jpeg&qlt=80&op_sharpen=0&resMode=bicub&op_usm=0.5,0.5,0,0&iccEmbed=0&layer=comp"
                            }
                    }
                 ];
    }
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
