//
//  MUAsyncUDPSocket.m
//  Socket
//
//  Created by 吴双 on 16/4/10.
//  Copyright © 2016年 unique. All rights reserved.
//

#import "MUAsyncUDPSocket.h"
#import "NSError+Socket.h"
#import "dispatch.h"
#import "yudpsocket.h"

@implementation MUAsyncUDPSocket

#pragma mark - Init

- (instancetype)init {
	self = [self initWithDelegate:nil];
	return self;
}

- (instancetype)initWithDelegate:(id<MUAsyncUDPSocketDelegate>)delegate {
	self = [self initWithDelegate:delegate delegateQueue:dispatch_get_main_queue()];
	return self;
}

- (instancetype)initWithDelegate:(id<MUAsyncUDPSocketDelegate>)delegate delegateQueue:(dispatch_queue_t)delegateQueue {
	self = [super init];
	if (self) {
		_delegate = delegate;
		_delegateQueue = delegateQueue;
	}
	return self;
}

- (void)listenWithAddress:(NSString *)address port:(NSUInteger)port completed:(OperaCompletedBlock)completed {
	dispatch_async_opera(^{
		NSError *error = nil;
		if (_socketFd == 0) {
			const char *addr = address.UTF8String;
			int fd = yudpsocket_server(addr, (int)port);
			if (fd > 0) {
				_listeningAddress = address;
				_listeningPort = port;
				_socketFd = fd;
				[self read];
			} else {
				error = [NSError mus_errorWithCode:MUSocketErrorCodeListenFailed
											reason:MUSocketListenFailedCannotBeginListeningReason];
			}
		} else {
			error = [NSError mus_errorWithCode:MUSocketErrorCodeListenFailed
										reason:MUSocketListenFailedListeningHasBeganReason];
		}
		MUSocketRunBlockInDelegateQueueWithOneParame(completed, error);
	});
	
}

- (void)closeWithCompleted:(OperaCompletedBlock)completed {
	dispatch_async_opera(^{
		NSError *error = nil;
		if (_socketFd > 0) {
			yudpsocket_close((int)_socketFd);
			_listeningAddress = nil;
			_listeningPort = 0;
			_socketFd = 0;
			
		} else {
			error = [NSError mus_errorWithCode:MUSocketErrorCodeCloseFailed reason:MUSocketCloseFailedServiceIsnotExistReason];
		}
		MUSocketRunBlockInDelegateQueueWithOneParame(completed, error);
	});
	
}

#pragma mark - Send

- (void)sendData:(NSData *)data
	   toAddress:(NSString *)address
			port:(NSUInteger)port
	   completed:(OperaCompletedBlock)completed {
	
	[self sendBytes:data.bytes forLength:data.length toAddress:address port:port completed:completed];
}

- (void)sendString:(NSString *)string
		 toAddress:(NSString *)address
			  port:(NSUInteger)port
		 completed:(OperaCompletedBlock)completed {
	[self sendBytes:string.UTF8String forLength:string.length toAddress:address port:port completed:completed];
}

- (void)sendBytes:(const char *)bytes
		forLength:(NSUInteger)length
		toAddress:(NSString *)address
			 port:(NSUInteger)port
		completed:(OperaCompletedBlock)completed {
	dispatch_async_opera(^{
		NSError *error = nil;
		if (bytes && address && port > 0 && length < self.dataBuffLength) {
			
			//新建一个ip的buff
			char *remoteIPBuff = malloc(16);
			memset(remoteIPBuff, 0, 16);
			
			//转换目标ip
			const char *constAddress = address.UTF8String;
			
			//检测目标ip
			int ret = yudpsocket_get_server_ip(constAddress, remoteIPBuff);
			if (ret == 0) {
				int fd = yudpsocket_client();
				if (fd > 0) {
					int sendSize = yudpsocket_sentto(fd, bytes, (int)length, remoteIPBuff, (int)port);
					if (sendSize != length) {
						error = [NSError mus_errorWithCode:MUSocketErrorCodeSendFailed reason:MUSocketSendFailedSendDataFailedReason];
					}
					yudpsocket_close(fd);
				} else {
					error = [NSError mus_errorWithCode:MUSocketErrorCodeSendFailed reason:MUSocketSendFailedCannotCreateLocalServerReason];
				}
			} else {
				error = [NSError mus_errorWithCode:MUSocketErrorCodeSendFailed reason:MUSocketSendFailedCannotGetRemoteServerReason];
			}
			free(remoteIPBuff);
		} else {
			error = [NSError mus_errorWithCode:MUSocketErrorCodeSendFailed reason:MUSocketSendFailedParameterErrorReason];
		}
		MUSocketRunBlockInDelegateQueueWithOneParame(completed, error);
	});
}

#pragma mark - Private method

- (void)read {
	dispatch_async_read(^{
		int selfSocketFD	= 0;
		char *remoteIPBuff	= malloc(16);
		char *buff			= NULL;
		int remotePort		= 0;
		int readLength		= 0;
		int dataBuffLength	= 0;
		
		NSString *socket	= nil;
		NSData *receiveData = nil;
		
		while (self.socketFd > 0) {
			selfSocketFD = (int)self.socketFd;
			dataBuffLength = (int)self.dataBuffLength;
			buff = malloc(dataBuffLength);
			memset(buff, 0, dataBuffLength);
			memset(remoteIPBuff, 0, 16);
			remotePort = 0;
			readLength = yudpsocket_recive(selfSocketFD, buff, dataBuffLength, remoteIPBuff, &remotePort);
			if (readLength > 0) {
				receiveData = [NSData dataWithBytes:buff length:dataBuffLength];
				socket = [NSString stringWithFormat:@"%s:%d", remoteIPBuff, remotePort];
				
				if ([self.delegate respondsToSelector:@selector(UDPSocket:didReceivedData:fromSocket:)]) {
					dispatch_async(self.delegateQueue, ^{
						[self.delegate UDPSocket:self didReceivedData:receiveData fromSocket:socket];
					});
				}
			}
			
			free(buff);
		}
		free(remoteIPBuff);
	});
	
}

- (NSUInteger)dataBuffLength {
	if (_dataBuffLength == 0) {
		_dataBuffLength = 1024;
	}
	return _dataBuffLength;
}

@end
