//
//  IPAddress.h
//  Tools
//
//  Created by Magic_Unique on 15/8/25.
//  Copyright (c) 2015年 Unique. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IPAddress : NSObject

+ (NSArray *)localIPAddress;

+ (NSArray *)localWiFiIPAddress;
+ (NSArray *)localGPRSIPAddress;

+ (NSArray *)localLANIPAddress;
+ (NSArray *)localWANIPAddress;

@end
