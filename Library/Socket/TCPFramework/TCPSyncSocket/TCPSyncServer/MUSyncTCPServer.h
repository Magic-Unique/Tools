//
//  MUSyncTCPServer.h
//  Socket
//
//  Created by 吴双 on 16/4/14.
//  Copyright © 2016年 unique. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MUSyncTCPClient.h"

@interface MUSyncTCPServer : NSObject

@property (nonatomic, copy, readonly) NSString *listeningAddress;
@property (nonatomic, assign, readonly) NSUInteger listeningPort;
@property (nonatomic, assign, readonly) NSUInteger socketFd;

@property (nonatomic, strong, readonly) NSArray *clients;

- (NSError *)listenWithAddress:(NSString *)address
						  port:(NSUInteger)port;
- (NSError *)close;

- (MUSyncTCPClient *)accept;

@end
