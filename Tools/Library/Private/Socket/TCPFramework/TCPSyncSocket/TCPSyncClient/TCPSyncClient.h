//
//  TCPSyncClient.h
//  Tools
//
//  Created by Magic_Unique on 15/9/16.
//  Copyright (c) 2015年 Unique. All rights reserved.
//

#import "NSSocket.h"

@interface TCPSyncClient : NSSocket


- (BOOL)connect:(int)timeout;
- (BOOL)connectToAddr:(NSString *)addr withPort:(NSUInteger)port andTimeout:(int)timeout;
- (BOOL)close;
- (BOOL)sendData:(NSData *)data;
- (BOOL)sendString:(NSString *)string;
- (NSData *)read:(int)expectLength;

+ (NSString *)errMsg:(int)errCode;

@end
