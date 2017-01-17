//
//  MUFirstTime.h
//  MUFirstTime
//
//  Created by 吴双 on 16/1/5.
//  Copyright © 2016年 unique. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MUFirstTime : NSObject

+ (BOOL)isFirstTimeForIdentifier:(NSString *)identifier;

+ (BOOL)isFirstTimeForIdentifier:(NSString *)identifier withAutoRecord:(BOOL)autoRecord;

+ (void)clearFirstTimeRecordForIdentifier:(NSString *)identifier;

+ (NSString *)currentVersion;

@end
