//
//  NSSocket.m
//  TCP
//
//  Created by Magic_Unique on 15/8/20.
//  Copyright (c) 2015年 Unique. All rights reserved.
//

#import "NSSocket.h"
#import "IPAddress.h"

static int MAX_DATA_LENGTH = 1024*512;

@implementation NSSocket

#pragma mark - global setting

+ (void)setMaxLengthOfData:(int)length {
    MAX_DATA_LENGTH = length;
}

+ (int)maxLengthOfData {
    return MAX_DATA_LENGTH;
}

+ (NSString *)stringWithUTF8Data:(NSData *)data {
    char *str = malloc([self maxLengthOfData]);
    memset(str, 0, [self maxLengthOfData]);
    [data getBytes:str length:[self maxLengthOfData]];
    NSString *nsStr = [NSString stringWithUTF8String:str];
    free(str);
    return nsStr;
}

+ (NSString *)stringWithGBKData:(NSData *)data {
    char *str = malloc([self maxLengthOfData]);
    memset(str, 0, [self maxLengthOfData]);
    [data getBytes:str length:[self maxLengthOfData]];
    unsigned long encode = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSString *nsStr = [[NSString alloc] initWithData:data encoding:encode];
    free(str);
    return nsStr;
}

#pragma mark - object method

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.addr = nil;
        self.port = 0;
        self.fd = 0;
    }
    return self;
}

- (instancetype)initWithAddr:(NSString *)addr andPort:(NSUInteger)port {
    self = [super init];
    if (self) {
        self.addr = addr;
        self.port = (int)port;
        self.fd = 0;
    }
    return self;
}

- (instancetype)initWithLocalPort:(NSUInteger)port {
    self = [super init];
    if (self) {
        self.addr = @"127.0.0.1";
        self.port = (int)port;
        self.fd = 0;
    }
    return self;
}

- (instancetype)initWithLanPort:(NSUInteger)port {
    self = [super init];
    if (self) {
        NSString *addr = [IPAddress localLANIPAddress].lastObject;
        if (addr) {
            self.addr = addr;
        } else {
            self.addr = @"127.0.0.1";
        }
        self.port = (int)port;
        self.fd = 0;
    }
    return self;
}


+ (instancetype)socketWithAddr:(NSString *)addr andPort:(NSUInteger)port {
    return [[self alloc] initWithAddr:addr andPort:port];
}

+ (instancetype)socketWithLocalPort:(NSUInteger)port {
    return [[self alloc] initWithLocalPort:port];
}

+ (instancetype)socketWithLanPort:(NSUInteger)port {
    return [[self alloc] initWithLanPort:port];
}

#pragma mark - private method


#pragma mark - override super method

- (NSString *)description {
    return [NSString stringWithFormat:@"\n%@ <%p> : {\n\tAddr\t: %@\n\tPort\t: %d\n\tEnable\t: %@\n}",
                                self.class, self, self.addr, self.port, self.fd>0 ? @"YES" : @"NO"];
}

- (BOOL)isEqual:(NSSocket *)socket {
    if ([socket isKindOfClass:[NSSocket class]]) {
        if ([self.addr isEqualToString:[socket addr]]) {
            if (self.port == socket.port) {
                return YES;
            }
        }
    }
    return NO;
}

@end
