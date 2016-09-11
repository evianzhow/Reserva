//
//  Constants.h
//  Reservá
//
//  Created by Yifei Zhou on 9/9/16.
//  Copyright © 2016 Aladdin Inc. All rights reserved.
//

#ifndef Constants_h
#define Constants_h

#define API_STORES_URL @"https://reserve.cdn-apple.com/CN/zh_CN/reserve/iPhone/stores.json"
#define API_AVAILABILITY_URL @"https://reserve.cdn-apple.com/CN/zh_CN/reserve/iPhone/availability.json"
#define RESERVATION_URL_TEMPLATE @"https://reserve-cn.apple.com/CN/zh_CN/reserve/iPhone?partNumber=%@&channel=2&rv=&path=&sourceID=&iPP=false&appleCare=&iUID=&iuToken=&carrier=&store=%@"

#define TRAFFIC_RED_COLOR [UIColor colorWithRed:250/255.0f green:90/255.0f blue:98/255.0f alpha:1.0f]
#define TRAFFIC_YELLOW_COLOR [UIColor colorWithRed:251/255.0f green:189/255.0f blue:78/255.0f alpha:1.0f]
#define TRAFFIC_GREEN_COLOR [UIColor colorWithRed:61/255.0f green:200/255.0f blue:81/255.0f alpha:1.0f]

#define REFRESH_TIME_INTERVAL_STORED_KEY @"RefreshTimeInterval"

#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)

#endif /* Constants_h */
