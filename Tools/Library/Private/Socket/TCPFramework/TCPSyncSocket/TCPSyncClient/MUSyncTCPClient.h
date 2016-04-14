//
//  MUSyncTCPClient.h
//  Socket
//
//  Created by 吴双 on 16/4/14.
//  Copyright © 2016年 unique. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MUSyncTCPClient : NSObject

@property (nonatomic, copy, readonly) NSString *remoteAddress;
@property (nonatomic, assign, readonly) NSUInteger remotePort;
@property (nonatomic, assign, readonly) NSUInteger socketFd;

- (NSError *)connectToAddress:(NSString *)address
						 port:(NSUInteger)port
					  timeout:(NSUInteger)timeout;
- (NSError *)close;

- (NSError *)sendData:(NSData *)data;
- (NSError *)sendString:(NSString *)string;
- (NSError *)sendBytes:(const char *)bytes forLength:(NSUInteger)length;

- (NSData *)read:(NSUInteger)expectLength;

@end
