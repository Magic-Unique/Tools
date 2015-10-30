//
//  NSString+Extension.h
//  Tools
//
//  Created by Magic_Unique on 15/8/22.
//  Copyright (c) 2015年 Unique. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (GBK)

/**
 *  从GBK编码转换成UTF-8编码的NSString
 *
 *  @param obj data encoded with GBK
 *
 *  @return string encoded with UTF-8
 */

- (instancetype)initWithGBKString:(const char *)nullTerminatedCString;
- (instancetype)initWithGBKData:(NSData *)data;

+ (instancetype)stringWithGBKString:(const char *)nullTerminatedCString;
+ (instancetype)stringWithGBKData:(NSData *)data;

@end



@interface NSString (Data)

@property (nonatomic, copy, readonly) NSString *md5;

@end