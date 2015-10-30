//
//  UDPSyncSocket.h
//  test
//
//  Created by Magic_Unique on 15/9/16.
//  Copyright (c) 2015年 Unique. All rights reserved.
//

#import "NSSocket.h"

@interface UDPSyncSocket : NSSocket

- (BOOL)listen;
- (BOOL)close;

- (BOOL)sendData:(NSData *)data toAddr:(NSString *)addr withPort:(int)port;
- (BOOL)sendString:(NSString *)string toAddr:(NSString *)addr withPort:(int)port;

- (NSData *)readFromSocket:(UDPSyncSocket **)socket;

//+ (NSString *)errMsg:(int)errCode;

@end
