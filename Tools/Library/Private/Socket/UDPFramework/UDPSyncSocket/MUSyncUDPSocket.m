//
//  MUSyncUDPSocket.m
//  Socket
//
//  Created by 吴双 on 16/4/12.
//  Copyright © 2016年 unique. All rights reserved.
//

#import "MUSyncUDPSocket.h"
#import "NSError+Socket.h"
#import "yudpsocket.h"

@implementation MUSyncUDPSocket

- (NSError *)listenWithAddress:(NSString *)address port:(NSUInteger)port {
	NSError *error = nil;
	if (_socketFd == 0) {
		const char *addr = address.UTF8String;
		int fd = yudpsocket_server(addr, (int)port);
		if (fd > 0) {
			_listeningAddress = address;
			_listeningPort = port;
			_socketFd = fd;
		} else {
			error = [NSError mus_errorWithCode:MUSocketErrorCodeListenFailed
										reason:MUSocketListenFailedCannotBeginListeningReason];
		}
	} else {
		error = [NSError mus_errorWithCode:MUSocketErrorCodeListenFailed
									reason:MUSocketListenFailedListeningHasBeganReason];
	}
	return error;
}

- (NSError *)close {NSError *error = nil;
	if (_socketFd > 0) {
		yudpsocket_close((int)_socketFd);
		_listeningAddress = nil;
		_listeningPort = 0;
		_socketFd = 0;
	} else {
		error = [NSError mus_errorWithCode:MUSocketErrorCodeCloseFailed reason:MUSocketCloseFailedServiceIsnotExistReason];
	}
	return error;
}

- (NSError *)sendString:(NSString *)string toAddress:(NSString *)address port:(NSUInteger)port {
	const char *bytes = string.UTF8String;
	NSData *data = [NSData dataWithBytes:bytes length:string.length];
	return [self sendData:data toAddress:address port:port];
}

- (NSError *)sendData:(NSData *)data toAddress:(NSString *)address port:(NSUInteger)port {
	char *bytes = malloc(data.length);
	[data getBytes:bytes length:data.length];
	NSError *error = [self sendBytes:bytes forLength:data.length toAddress:address port:port];
	free(bytes);
	return error;
}

- (NSError *)sendBytes:(const char *)bytes forLength:(NSUInteger)length toAddress:(NSString *)address port:(NSUInteger)port {
	NSError *error = nil;
	if (bytes && address && port > 0 && length < 127) {
		
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
				if (sendSize <= 0) {
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
	return error;
	
}

- (NSData *)readFromSocket:(NSString *__autoreleasing *)socket {
	*socket = nil;
	char *buff			= malloc(127);
	char *remoteIPBuff	= malloc(16);
	memset(buff, 0, 127);
	memset(remoteIPBuff, 0, 16);
	
	int remotePort		= 0;
	int readLength		= 0;
	
	NSData *receiveData		= nil;
	
	int selfSocketFD = (int)self.socketFd;
	remotePort = 0;
	readLength = yudpsocket_recive(selfSocketFD, buff, 127, remoteIPBuff, &remotePort);
	if (readLength <= 0) { } else {
		receiveData = [NSData dataWithBytes:buff length:127];
		*socket = [NSString stringWithFormat:@"%s:%d", remoteIPBuff, remotePort];
	}
	free(buff);
	free(remoteIPBuff);
	return receiveData;
}

@end
