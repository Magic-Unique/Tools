//
//  MUAsyncUDPSocket.h
//  Socket
//
//  Created by 吴双 on 16/4/10.
//  Copyright © 2016年 unique. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MUSocketConst.h"

@class MUAsyncUDPSocket;

@protocol MUAsyncUDPSocketDelegate <NSObject>

@optional

/**
 *  Call after UDPSocket reveived bytes in delegateQueue.
 *
 *  @param UDPsocket MUAsyncUDPSocket
 *  @param data      NSData
 *  @param socket    NSString like "address:port"
 */
- (void)UDPSocket:(MUAsyncUDPSocket *)UDPsocket didReceivedData:(NSData *)data fromSocket:(NSString *)socket;

@end



@interface MUAsyncUDPSocket : NSObject

#pragma mark - Delegate
@property (nonatomic, weak, readonly) id<MUAsyncUDPSocketDelegate> delegate;
@property (nonatomic, strong, readonly) dispatch_queue_t delegateQueue;

#pragma mark - Socket
@property (nonatomic, copy, readonly) NSString *listeningAddress;
@property (nonatomic, assign, readonly) NSUInteger listeningPort;
@property (nonatomic, assign, readonly) NSUInteger socketFd;

@property (nonatomic, assign) NSUInteger dataBuffLength;

#pragma mark - Init
- (instancetype)initWithDelegate:(id<MUAsyncUDPSocketDelegate>)delegate;
- (instancetype)initWithDelegate:(id<MUAsyncUDPSocketDelegate>)delegate
				   delegateQueue:(dispatch_queue_t)delegateQueue;

#pragma mark - Enable
- (void)listenWithAddress:(NSString *)address
					 port:(NSUInteger)port
				completed:(OperaCompletedBlock)completed;
- (void)closeWithCompleted:(OperaCompletedBlock)completed;

#pragma mark - Send
- (void)sendData:(NSData *)data
	   toAddress:(NSString *)address
			port:(NSUInteger)port
	   completed:(OperaCompletedBlock)completed;
- (void)sendString:(NSString *)string
		 toAddress:(NSString *)address
			  port:(NSUInteger)port
		 completed:(OperaCompletedBlock)completed;
- (void)sendBytes:(const char *)bytes
		forLength:(NSUInteger)length
		toAddress:(NSString *)address
			 port:(NSUInteger)port
		completed:(OperaCompletedBlock)completed;

@end
