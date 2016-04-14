//
//  MUAsyncTCPServer.m
//  Socket
//
//  Created by 吴双 on 16/4/13.
//  Copyright © 2016年 unique. All rights reserved.
//

#import "MUAsyncTCPServer.h"
#import "NSError+Socket.h"
#import "dispatch.h"
#import "ytcpsocket.h"


@interface MUAsyncTCPClient ()
- (NSError *)close;
+ (instancetype)clientWithAddress:(NSString *)address
							 port:(NSUInteger)port
						 socketFd:(NSUInteger)socketFd
				   dataBuffLength:(NSUInteger)dataBuffLength
						 delegate:(id<MUAsyncTCPClientDelegate>)delegate;
@end




@interface MUAsyncTCPServer () <MUAsyncTCPClientDelegate>

@property (nonatomic, strong) NSMutableArray<MUAsyncTCPClient *> *linkedClients;

@end

@implementation MUAsyncTCPServer

#pragma mark - Init

- (instancetype)init {
	self = [self initWithDelegate:nil];
	return self;
}

- (instancetype)initWithDelegate:(id<MUAsyncTCPServerDelegate>)delegate {
	self = [self initWithDelegate:delegate delegateQueue:dispatch_get_main_queue()];
	return self;
}

- (instancetype)initWithDelegate:(id<MUAsyncTCPServerDelegate>)delegate delegateQueue:(dispatch_queue_t)delegateQueue {
	self = [super init];
	if (self) {
		_delegate = delegate;
		_delegateQueue = delegateQueue;
	}
	return self;
}

#pragma mark - Property getter

- (NSArray *)clients {
	return [self.linkedClients copy];
}

#pragma mark - Property setter

- (void)setDataBuffLength:(NSUInteger)dataBuffLength {
	_dataBuffLength = dataBuffLength;
	for (MUAsyncTCPClient *item in self.linkedClients) {
		item.dataBuffLength = dataBuffLength;
	}
}

#pragma mark - Service

- (void)listenWithAddress:(NSString *)address
					 port:(NSUInteger)port
				completed:(OperaCompletedBlock)completed {
	dispatch_async_opera(^{
		NSError *error = nil;
		if (self.socketFd > 0) {
			error = [NSError mus_errorWithCode:MUSocketErrorCodeListenFailed
										reason:MUSocketListenFailedListeningHasBeganReason];
		}
		int fd = ytcpsocket_listen(address.UTF8String, (int)port);
		
		if (fd > 0) {
			_listeningAddress = address;
			_listeningPort = port;
			_socketFd = fd;
			[self dispatchAsyncAccept];
		} else {
			error = [NSError mus_errorWithCode:MUSocketErrorCodeListenFailed
										reason:MUSocketListenFailedCannotBeginListeningReason];
		}
		MUSocketRunBlockInDelegateQueueWithOneParame(completed, error);
	});
}

- (void)closeWithCompleted:(OperaCompletedBlock)completed {
	dispatch_async_opera(^{
		NSError *error = nil;
		int fd = (int)_socketFd;
		_listeningAddress = nil;
		_listeningPort = 0;
		_socketFd = 0;
		if (fd > 0) {
			ytcpsocket_close(fd);
		} else {
			error = [NSError mus_errorWithCode:MUSocketErrorCodeCloseFailed
										reason:MUSocketCloseFailedServiceIsnotExistReason];
		}
		MUSocketRunBlockInDelegateQueueWithOneParame(completed, error);
	});
}

#pragma mark - Linking manage

- (void)breakClient:(MUAsyncTCPClient *)client completed:(OperaCompletedBlock)completed {
	dispatch_async_opera(^{
		NSError *error = [NSError mus_errorWithCode:MUSocketErrorCodeBreakFailed
											 reason:MUSocketBreakFailedClientIsNotExistReason];
		for (int i = 0; i < self.linkedClients.count; i++) {
			MUAsyncTCPClient *temp = self.linkedClients[i];
			if ([client isEqual:temp]) {
				if (temp.socketFd > 0) {
					error = [temp close];
				}
				[self.linkedClients removeObject:temp];
				break;
			}
		}
		MUSocketRunBlockInDelegateQueueWithOneParame(completed, error);
	});
}

#pragma mark - Send data

- (void)sendString:(NSString *)string
		  toClient:(MUAsyncTCPClient *)client
		 completed:(OperaCompletedBlock)completed {
	dispatch_async_opera(^{
		NSError *error = [NSError mus_errorWithCode:MUSocketErrorCodeSendFailed reason:MUSocketSendFailedDisconnectReason];
		for (MUAsyncTCPClient *item in self.linkedClients) {
			if ([item isEqual:client]) {
				[item sendString:string completed:completed];
				return ;
			}
		}
		MUSocketRunBlockInDelegateQueueWithOneParame(completed, error);
	});
}

- (void)sendData:(NSData *)data
		toClient:(MUAsyncTCPClient *)client
	   completed:(OperaCompletedBlock)completed {
	dispatch_async_opera(^{
		NSError *error = [NSError mus_errorWithCode:MUSocketErrorCodeSendFailed reason:MUSocketSendFailedDisconnectReason];
		for (MUAsyncTCPClient *item in self.linkedClients) {
			if ([item isEqual:client]) {
				[item sendData:data completed:completed];
				return ;
			}
		}
		MUSocketRunBlockInDelegateQueueWithOneParame(completed, error);
	});
}

- (void)sendBytes:(const char *)bytes forLength:(NSUInteger)length toClient:(MUAsyncTCPClient *)client completed:(OperaCompletedBlock)completed {
	dispatch_async_opera(^{
		NSError *error = [NSError mus_errorWithCode:MUSocketErrorCodeSendFailed reason:MUSocketSendFailedDisconnectReason];
		for (MUAsyncTCPClient *item in self.linkedClients) {
			if ([item isEqual:client]) {
				[item sendBytes:bytes forLength:length completed:completed];
				return ;
			}
		}
		MUSocketRunBlockInDelegateQueueWithOneParame(completed, error);
	});
}

#pragma mark - Accept

- (void)dispatchAsyncAccept {
	dispatch_async_accept(^{
		while (self.socketFd > 0) {
			MUAsyncTCPClient *client = [self accept];
			if (client) {
				if ([self.delegate respondsToSelector:@selector(TCPServer:didAcceptedClient:)]) {
					dispatch_async(self.delegateQueue, ^{
						[self.delegate TCPServer:self didAcceptedClient:client];
					});
				}
				[self.linkedClients addObject:client];
			} else {
				break;
			}
		}
		[self closeWithCompleted:nil];
	});
}

- (MUAsyncTCPClient *)accept {
	if (self.socketFd > 0) {
		int serverFd = (int)self.socketFd;
		char buff[16] = {0};//255.255.255.255
		int port = 0;
		int clientfd = ytcpsocket_accept(serverFd, buff, &port);
		if (clientfd < 0) {
			return nil;
		} else {
			NSString *address = [NSString stringWithUTF8String:buff];
			return [MUAsyncTCPClient clientWithAddress:address
												  port:port
											  socketFd:clientfd
										dataBuffLength:self.dataBuffLength
											  delegate:self];
		}
	}
	return nil;
}

#pragma mark - Async TCP client delegate

- (void)TCPClient:(MUAsyncTCPClient *)TCPClient didReceiveData:(NSData *)data {
	if ([self.delegate respondsToSelector:@selector(TCPServer:didReceiveData:fromClient:)]) {
		dispatch_async(self.delegateQueue, ^{
			[self.delegate TCPServer:self didReceiveData:data fromClient:TCPClient];
		});
	}
}

- (void)TCPClientDidBrokenByRemote:(MUAsyncTCPClient *)TCPClient {
	if ([self.delegate respondsToSelector:@selector(TCPServer:didBrokenByClient:)]) {
		dispatch_async(self.delegateQueue, ^{
			[self.delegate TCPServer:self didBrokenByClient:TCPClient];
		});
	}
}

- (NSMutableArray<MUAsyncTCPClient *> *)linkedClients {
	if (!_linkedClients) {
		_linkedClients = [NSMutableArray array];
	}
	return _linkedClients;
}

@end
