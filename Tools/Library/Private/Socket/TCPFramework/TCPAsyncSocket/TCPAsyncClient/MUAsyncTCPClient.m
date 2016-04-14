//
//  MUAsyncTCPClient.m
//  Socket
//
//  Created by 吴双 on 16/4/13.
//  Copyright © 2016年 unique. All rights reserved.
//

#import "MUAsyncTCPClient.h"
#import "dispatch.h"
#import "NSError+Socket.h"
#import "ytcpsocket.h"

@implementation MUAsyncTCPClient

#pragma mark - Init

- (instancetype)init {
	self = [self initWithDelegate:nil];
	return self;
}

- (instancetype)initWithDelegate:(id<MUAsyncTCPClientDelegate>)delegate {
	self = [self initWithDelegate:delegate delegateQueue:dispatch_get_main_queue()];
	return self;
}

- (instancetype)initWithDelegate:(id<MUAsyncTCPClientDelegate>)delegate
				   delegateQueue:(dispatch_queue_t)delegateQueue {
	self = [super init];
	if (self) {
		_delegate = delegate;
		_delegateQueue = delegateQueue;
	}
	return self;
}

#pragma mark - Service

- (void)connectToAddress:(NSString *)address
					port:(NSUInteger)port
				 timeout:(NSUInteger)timeout
			   completed:(OperaCompletedBlock)completed {
	dispatch_async_opera(^{
		NSError *error = nil;
		if (_socketFd == 0) {
			int rs = ytcpsocket_connect(address.UTF8String, (int)port, (int)timeout);
			if (rs > 0) {
				_remoteAddress = address;
				_remotePort = port;
				_socketFd = rs;
				[self dispatchAsyncRead];
			} else {
				error = [NSError mus_errorWithCode:MUSocketErrorCodeConnectFailed
											reason:MUSocketConnectFailedCannotBeginServiceReason];
			}
		} else {
			error = [NSError mus_errorWithCode:MUSocketErrorCodeConnectFailed
										reason:MUSocketConnectFailedServiceHasBeganReason];
		}
		MUSocketRunBlockInDelegateQueueWithOneParame(completed, error);
	});
}

- (void)closeWithCompleted:(OperaCompletedBlock)completed {
	dispatch_async_opera(^{
		NSError *error = [self close];
		MUSocketRunBlockInDelegateQueueWithOneParame(completed, error);
	});
}

- (NSError *)close {
	NSError *error = nil;
	int fd = (int)_socketFd;
	_remoteAddress = nil;
	_remotePort = 0;
	_socketFd = 0;
	if (fd > 0) {
		ytcpsocket_close(fd);
	} else {
		error = [NSError mus_errorWithCode:MUSocketErrorCodeCloseFailed reason:MUSocketCloseFailedServiceIsnotExistReason];
	}
	return error;
}

#pragma mark - Send

- (void)sendData:(NSData *)data completed:(OperaCompletedBlock)completed {
	[self sendBytes:data.bytes forLength:data.length completed:completed];
}

- (void)sendString:(NSString *)string completed:(OperaCompletedBlock)completed {
	[self sendBytes:string.UTF8String forLength:string.length completed:completed];
}

- (void)sendBytes:(const char *)bytes
		forLength:(NSUInteger)length
		completed:(OperaCompletedBlock)completed {
	dispatch_async_opera(^{
		NSError *error = nil;
		if (self.socketFd > 0) {
			int fd = (int)self.socketFd;
			int sendsize = ytcpsocket_send(fd, bytes, (int)length);
			if (sendsize != length) {
				error = [NSError mus_errorWithCode:MUSocketErrorCodeSendFailed reason:MUSocketSendFailedSendDataFailedReason];
			}
		} else {
			error = [NSError mus_errorWithCode:MUSocketErrorCodeSendFailed reason:MUSocketSendFailedDisconnectReason];
		}
		MUSocketRunBlockInDelegateQueueWithOneParame(completed, error);
	});
}

#pragma mark - Read

- (void)dispatchAsyncRead {
	dispatch_async_read(^{
		while (self.socketFd > 0) {
			NSData *data = [self readDataFromBuff];
			if (!data) {
				if ([self.delegate respondsToSelector:@selector(TCPClientDidBrokenByRemote:)] && self.socketFd > 0) {
					dispatch_async(self.delegateQueue, ^{
						[self.delegate TCPClientDidBrokenByRemote:self];
					});
				}
				break;
			}
			
			if ([self.delegate respondsToSelector:@selector(TCPClient:didReceiveData:)]) {
				dispatch_async(self.delegateQueue, ^{
					[self.delegate TCPClient:self didReceiveData:data];
				});
			}
		}
		[self closeWithCompleted:nil];
	});
}

- (NSData *)readDataFromBuff {
	NSData *data = nil;
	int socketFd = (int)_socketFd;
	NSUInteger dataBuffLength = self.dataBuffLength;
	if (socketFd > 0) {
		char *buff = malloc(dataBuffLength);
		memset(buff, 0, dataBuffLength);
		int readLen = ytcpsocket_pull(socketFd, buff, (int)dataBuffLength);
		if (readLen > 0) {
			data = [NSData dataWithBytes:buff length:readLen];
		}
		free(buff);
	}
	return data;
}

#pragma mark - Property getter

- (NSUInteger)dataBuffLength {
	if (_dataBuffLength == 0) {
		_dataBuffLength = 1024;
	}
	return _dataBuffLength;
}

#pragma mark - Object 

- (BOOL)isEqual:(id)object {
	if (object == self) {
		return YES;
	}
	if (![object isKindOfClass:[MUAsyncTCPClient class]]) {
		return NO;
	}
	MUAsyncTCPClient *client = object;
	if ([client.remoteAddress isEqualToString:self.remoteAddress] && client.remotePort == self.remotePort) {
		return YES;
	}
	return NO;
}

#pragma mark - Category for server

+ (instancetype)clientWithAddress:(NSString *)address
							 port:(NSUInteger)port
						 socketFd:(NSUInteger)socketFd
				   dataBuffLength:(NSUInteger)dataBuffLength
						 delegate:(id<MUAsyncTCPClientDelegate>)delegate {
	MUAsyncTCPClient *client = [[self alloc] initWithDelegate:delegate delegateQueue:dispatch_queue_read()];
	client->_remoteAddress = address;
	client->_remotePort = port;
	client->_socketFd = socketFd;
	client.dataBuffLength = dataBuffLength;
	[client dispatchAsyncRead];
	return client;
}

@end
