//
//  MUAsyncTCPClient.h
//  Socket
//
//  Created by 吴双 on 16/4/13.
//  Copyright © 2016年 unique. All rights reserved.
//

#import "MUSocketConst.h"

@class MUAsyncTCPClient;

@protocol MUAsyncTCPClientDelegate <NSObject>

@optional
- (void)TCPClient:(MUAsyncTCPClient *)TCPClient didReceiveData:(NSData *)data;
- (void)TCPClientDidBrokenByRemote:(MUAsyncTCPClient *)TCPClient;

@end









@interface MUAsyncTCPClient : NSObject

@property (nonatomic, weak, readonly) id <MUAsyncTCPClientDelegate> delegate;
@property (nonatomic, strong, readonly) dispatch_queue_t delegateQueue;

@property (nonatomic, readonly, copy) NSString *remoteAddress;
@property (nonatomic, readonly, assign) NSUInteger remotePort;
@property (nonatomic, readonly, assign) NSUInteger socketFd;

@property (nonatomic, assign) NSUInteger dataBuffLength;

- (instancetype)initWithDelegate:(id<MUAsyncTCPClientDelegate>)delegate;
- (instancetype)initWithDelegate:(id<MUAsyncTCPClientDelegate>)delegate
				   delegateQueue:(dispatch_queue_t)delegateQueue;

- (void)connectToAddress:(NSString *)address
					port:(NSUInteger)port
				 timeout:(NSUInteger)timeout
			   completed:(OperaCompletedBlock)completed;
- (void)closeWithCompleted:(OperaCompletedBlock)completed;

- (void)sendData:(NSData *)data completed:(OperaCompletedBlock)completed;
- (void)sendString:(NSString *)string completed:(OperaCompletedBlock)completed;
- (void)sendBytes:(const char *)bytes
		forLength:(NSUInteger)length
		completed:(OperaCompletedBlock)completed;

@end
