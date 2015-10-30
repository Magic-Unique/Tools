//
//  TCPSyncClient_Extension.h
//  ETCPSyncClient
//
//  Created by Magic_Unique on 15/8/21.
//  Copyright (c) 2015年 Unique. All rights reserved.
//

#import "TCPSyncClient.h"

@interface TCPSyncClient ()


// Create TCPSyncClient when someone connect this Server, and create with a fd. In the mean time, read thread will start.
+ (instancetype)clientByServerWithAddr:(NSString *)addr andPort:(int)port andFd:(int)fd;

@end
