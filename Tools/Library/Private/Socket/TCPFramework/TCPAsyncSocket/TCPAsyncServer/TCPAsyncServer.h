//
//  TCPAsyncServer.h
//  TCP
//
//  Created by Magic_Unique on 15/8/20.
//  Copyright (c) 2015年 Unique. All rights reserved.
//

#import "NSSocket.h"


@class TCPAsyncServer;
@class TCPAsyncClient;

@protocol TCPAsyncServerDelegate <NSObject>

@optional

- (void)server:(TCPAsyncServer *)server didReceiveData:(NSData *)data fromClient:(TCPAsyncClient *)client;
- (void)server:(TCPAsyncServer *)server didReceiveClient:(TCPAsyncClient *)client;
- (void)server:(TCPAsyncServer *)server didBrokeByClient:(TCPAsyncClient *)client;

@end


@interface TCPAsyncServer : NSSocket

@property (nonatomic, assign) id<TCPAsyncServerDelegate> delegate;

- (BOOL)listen;
- (BOOL)close;

- (BOOL)breakClient:(TCPAsyncClient *)client;

- (int)sendData:(NSData *)data toClient:(TCPAsyncClient *)client;
- (int)sendString:(NSString *)string toClient:(TCPAsyncClient *)client;


+ (NSString *)errMsg:(int)errCode;

@end
