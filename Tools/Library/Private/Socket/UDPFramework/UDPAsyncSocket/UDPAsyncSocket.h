//
//  UDPAsyncSocket.h
//  UDPFactory
//
//  Created by Magic_Unique on 15/8/21.
//  Copyright (c) 2015年 Unique. All rights reserved.
//

#import "NSSocket.h"


@class UDPAsyncSocket;

@protocol UDPAsyncSocketDelegate <NSObject>

@optional
- (void)socket:(UDPAsyncSocket *)socket didReceiveData:(NSData *)data fromSocket:(UDPAsyncSocket *)source;

@end

@interface UDPAsyncSocket : NSSocket


@property (nonatomic, assign) id<UDPAsyncSocketDelegate> delegate;


- (BOOL)listen;
- (BOOL)close;

- (BOOL)sendData:(NSData *)data toAddr:(NSString *)addr withPort:(int)port;
- (BOOL)sendString:(NSString *)string toAddr:(NSString *)addr withPort:(int)port;

+ (NSString *)errMsg:(int)errCode;

@end
