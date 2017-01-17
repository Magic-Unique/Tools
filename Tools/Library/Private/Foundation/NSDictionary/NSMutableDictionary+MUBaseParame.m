//
//  NSMutableDictionary+MUBaseParame.m
//  RingTone
//
//  Created by TB-Mac-100 on 2016/12/14.
//  Copyright © 2016年 Mia Tse. All rights reserved.
//

#import "NSMutableDictionary+MUBaseParame.h"
#import "UIDevice+MUExtension.h"

@implementation NSMutableDictionary (MUBaseParame)

+ (instancetype)baseParame {
	NSMutableDictionary *parame = [NSMutableDictionary dictionary];
#define set(key, value, default) parame[(key)] = (value) ? (value) : (default)
#define info(key) [NSBundle.mainBundle infoDictionary][key]
#define Device UIDevice.currentDevice
	set(@"isTest", @"true", @"");
	set(@"sku", info(@"CFBundleIdentifier"), @"");
	set(@"sv", info(@"CFBundleShortVersionString"), @"");
	set(@"devver", info(@"CFBundleVersion"), @"");
	set(@"source", @"1", @"");
	set(@"ib", @(Device.jailbreaked), @"false");
	set(@"lan", @"0", @"0");
	set(@"lanStr", Device.currentLanguage, @"");
	set(@"sn", @"", @"");
	set(@"idfv", Device.IDFV, @"");
	set(@"idfa", Device.IDFA, @"");
	set(@"time", @(NSDate.date.timeIntervalSince1970).stringValue, @"");
	set(@"p", Device.platform, @"");
	set(@"f", @"c", @"");
	set(@"mac", @"", @"");
	set(@"cpuid", Device.chipSerialNumber, @"");
	return parame;
}

@end
