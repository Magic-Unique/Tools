//
//  TCPAsyncClient_Extension.h
//  ETCPAsyncClient
//
//  Created by Magic_Unique on 15/8/21.
//  Copyright (c) 2015年 Unique. All rights reserved.
//

#import "TCPAsyncClient.h"

@interface TCPAsyncClient ()


// Create TCPAsyncClient when someone connect this Server, and create with a fd. In the mean time, read thread will start.
+ (instancetype)clientByServerWithAddr:(NSString *)addr andPort:(int)port andFd:(int)fd;

@end
