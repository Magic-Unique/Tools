//
//  MUAsyncTCPServer.h
//  Socket
//
//  Created by 吴双 on 16/4/13.
//  Copyright © 2016年 unique. All rights reserved.
//

#import "MUAsyncTCPClient.h"


@class MUAsyncTCPClient;
@class MUAsyncTCPServer;

@protocol MUAsyncTCPServerDelegate <NSObject>

@optional

- (void)TCPServer:(MUAsyncTCPServer *)TCPServer didReceiveData:(NSData *)data fromClient:(MUAsyncTCPClient *)client;
- (void)TCPServer:(MUAsyncTCPServer *)TCPServer didAcceptedClient:(MUAsyncTCPClient *)client;
- (void)TCPServer:(MUAsyncTCPServer *)TCPServer didBrokenByClient:(MUAsyncTCPClient *)client;

@end




@interface MUAsyncTCPServer : NSObject

@property (nonatomic, weak, readonly) id <MUAsyncTCPServerDelegate> delegate;
@property (nonatomic, strong, readonly) dispatch_queue_t delegateQueue;

@property (nonatomic, strong, readonly) NSArray *clients;

@property (nonatomic, copy, readonly) NSString *listeningAddress;
@property (nonatomic, assign, readonly) NSUInteger listeningPort;
@property (nonatomic, assign, readonly) NSUInteger socketFd;

@property (nonatomic, assign) NSUInteger dataBuffLength;

- (instancetype)initWithDelegate:(id<MUAsyncTCPServerDelegate>)delegate;
- (instancetype)initWithDelegate:(id<MUAsyncTCPServerDelegate>)delegate
				   delegateQueue:(dispatch_queue_t)delegateQueue;

- (void)listenWithAddress:(NSString *)address
					 port:(NSUInteger)port
				completed:(OperaCompletedBlock)completed;
- (void)closeWithCompleted:(OperaCompletedBlock)completed;


- (void)breakClient:(MUAsyncTCPClient *)client
		  completed:(OperaCompletedBlock)completed;


- (void)sendString:(NSString *)string
		  toClient:(MUAsyncTCPClient *)client
		 completed:(OperaCompletedBlock)completed;
- (void)sendData:(NSData *)data
		toClient:(MUAsyncTCPClient *)client
	   completed:(OperaCompletedBlock)completed;
- (void)sendBytes:(const char *)bytes
		forLength:(NSUInteger)length
		 toClient:(MUAsyncTCPClient *)client
		completed:(OperaCompletedBlock)completed;

@end
