//
//  NSString+Extension.m
//  Tools
//
//  Created by Magic_Unique on 15/8/22.
//  Copyright (c) 2015年 Unique. All rights reserved.
//

#import "NSString+Extension.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (GBK)

- (instancetype)initWithGBKString:(const char *)nullTerminatedCString {
    unsigned long encode = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    self = [self initWithCString:nullTerminatedCString encoding:encode];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithGBKData:(NSData *)data {
    unsigned long encode = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    self = [self initWithData:data encoding:encode];
    if (self) {
        
    }
    return self;
}

+ (instancetype)stringWithGBKString:(const char *)nullTerminatedCString {
    return [[self alloc] initWithGBKString:nullTerminatedCString];
}

+ (instancetype)stringWithGBKData:(NSData *)data {
    return [[self alloc] initWithGBKData:data];
}

@end

@implementation NSString (Data)

- (NSString *)md5
{
    const char *cStr =[self UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (unsigned int)strlen(cStr), result);
    return [NSString stringWithFormat:
           @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
           result[0], result[1], result[2], result[3],
           result[4], result[5], result[6], result[7],
           result[8], result[9], result[10], result[11],
           result[12], result[13], result[14], result[15]
           ];
}

@end
