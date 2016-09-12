//
//  Reservá.h
//  Reserva
//
//  Created by Yifei Zhou on 9/12/16.
//  Copyright © 2016 Aladdin Inc. All rights reserved.
//

#ifndef Reserva__h
#define Reserva__h

#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)

#define IS_NIL_OBJECT(OBJ) (!OBJ || [OBJ isKindOfClass:[NSNull class]])
#define IS_IPAD ([[[UIDevice currentDevice].model substringToIndex:4] isEqualToString:@"iPad"])

#endif /* Reserva__h */
