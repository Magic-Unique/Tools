//
//  IPAddress.h
//  Tools
//
//  Created by Magic_Unique on 15/8/25.
//  Copyright (c) 2015年 Unique. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IPAddress : NSObject

/**
 *  获取所有IP地址
 *
 *  @return NSArray<NSString *>
 */
+ (NSArray<NSString *> *)localIPAddress;

/**
 *  获取WiFi地址
 *
 *  @return NSArray<NSString *>
 */
+ (NSArray<NSString *> *)localWiFiIPAddress;

/**
 *  获取移动数据地址
 *
 *  @return NSArray<NSString *>
 */
+ (NSArray<NSString *> *)localGPRSIPAddress;

/**
 *  获取广域网地址
 *
 *  @return NSArray<NSString *>
 */
+ (NSArray<NSString *> *)localLANIPAddress;

/**
 *  获取局域网地址
 *
 *  @return NSArray<NSString *>
 */
+ (NSArray<NSString *> *)localWANIPAddress;

@end
