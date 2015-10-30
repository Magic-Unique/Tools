//
//  TCPSyncServer.h
//  Tools
//
//  Created by Magic_Unique on 15/9/16.
//  Copyright (c) 2015年 Unique. All rights reserved.
//

#import "NSSocket.h"

@class TCPSyncClient;

@interface TCPSyncServer : NSSocket

- (BOOL)listen;
- (BOOL)close;
- (TCPSyncClient *)accept;


//- (BOOL)breakClient:(TCPSyncClient *)client;
//
//- (int)sendData:(NSData *)data toClient:(TCPSyncClient *)client;
//- (int)sendString:(NSString *)string toClient:(TCPSyncClient *)client;


+ (NSString *)errMsg:(int)errCode;

@end
