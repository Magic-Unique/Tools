//
//  MUSyncUDPSocket.h
//  Socket
//
//  Created by 吴双 on 16/4/12.
//  Copyright © 2016年 unique. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CFNetwork/CFSocketStream.h>

@interface MUSyncUDPSocket : NSObject

@property (nonatomic, copy, readonly) NSString *listeningAddress;
@property (nonatomic, assign, readonly) NSUInteger listeningPort;
@property (nonatomic, assign, readonly) NSUInteger socketFd;

#pragma mark - Enable
- (NSError *)listenWithAddress:(NSString *)address
						  port:(NSUInteger)port;
- (NSError *)close;

#pragma mark - Send
- (NSError *)sendData:(NSData *)data
			toAddress:(NSString *)address
				 port:(NSUInteger)port;
- (NSError *)sendString:(NSString *)string
			  toAddress:(NSString *)address
				   port:(NSUInteger)port;
- (NSError *)sendBytes:(const char *)bytes
			 forLength:(NSUInteger)length
			 toAddress:(NSString *)address
				  port:(NSUInteger)port;

#pragma mark - Read
- (NSData *)readFromSocket:(NSString **)socket;

@end
