//
//  TCPAsyncClient.h
//  TCP
//
//  Created by Magic_Unique on 15/8/20.
//  Copyright (c) 2015年 Unique. All rights reserved.
//

#import "NSSocket.h"

@class TCPAsyncClient;

@protocol TCPAsyncClientDelegate <NSObject>

@optional

- (void)client:(TCPAsyncClient *)client didReceiveData:(NSData *)data;
- (void)clientDidBrokeByServer:(TCPAsyncClient *)client;

@end

@interface TCPAsyncClient : NSSocket

@property (nonatomic, assign) id<TCPAsyncClientDelegate> delegate;

- (BOOL)connect:(int)timeout;
- (BOOL)connectToAddr:(NSString *)addr withPort:(NSUInteger)port andTimeout:(int)timeout;
- (BOOL)close;
- (BOOL)sendData:(NSData *)data;
- (BOOL)sendString:(NSString *)string;


+ (NSString *)errMsg:(int)errCode;

@end
