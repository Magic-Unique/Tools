//
//  MUSyncTCPClient.m
//  Socket
//
//  Created by 吴双 on 16/4/14.
//  Copyright © 2016年 unique. All rights reserved.
//

#import "MUSyncTCPClient.h"
#import "ytcpsocket.h"
#import "NSError+Socket.h"

@implementation MUSyncTCPClient

- (NSError *)connectToAddress:(NSString *)address port:(NSUInteger)port timeout:(NSUInteger)timeout {
	if (_socketFd > 0) {
		return [NSError mus_errorWithCode:MUSocketErrorCodeConnectFailed reason:MUSocketConnectFailedServiceHasBeganReason];
	}
	int rs = ytcpsocket_connect(address.UTF8String, (int)port, (int)timeout);
	if (rs > 0) {
		_remoteAddress = address;
		_remotePort = port;
		_socketFd = rs;
		return nil;
	} else {
		return [NSError mus_errorWithCode:MUSocketErrorCodeConnectFailed reason:MUSocketConnectFailedCannotBeginServiceReason];
	}
}

- (NSError *)close {
	int fd = (int)_socketFd;
	_remoteAddress = nil;
	_remotePort = 0;
	_socketFd = 0;
	if (fd > 0) {
		ytcpsocket_close(fd);
		return nil;
	}
	return [NSError mus_errorWithCode:MUSocketErrorCodeCloseFailed reason:MUSocketCloseFailedServiceIsnotExistReason];
}

- (NSError *)sendData:(NSData *)data {
	return [self sendBytes:data.bytes forLength:data.length];
}

- (NSError *)sendString:(NSString *)string {
	return [self sendBytes:string.UTF8String forLength:string.length];
}

- (NSData *)read:(NSUInteger)expectLength {
	NSData *data = nil;
	if (_socketFd) {
		int fd = (int)_socketFd;
		
		char *buff = malloc(expectLength);
		memset(buff, 0, expectLength);
		
		int readLen = ytcpsocket_pull(fd, buff, (int)expectLength);
		
		if (readLen > 0) {
			data = [NSData dataWithBytes:buff length:readLen];
		}
		
		free(buff);
	}
	return data;
}

- (NSError *)sendBytes:(const char *)bytes forLength:(NSUInteger)length {
	if (_socketFd > 0) {
		int fd = (int)_socketFd;

		int sendsize = ytcpsocket_send(fd, bytes, (int)length);
		
		if (sendsize == length) {
			return nil;
		} else {
			return [NSError mus_errorWithCode:MUSocketErrorCodeSendFailed reason:MUSocketSendFailedSendDataFailedReason];
		}
	} else {
		return [NSError mus_errorWithCode:MUSocketErrorCodeSendFailed reason:MUSocketSendFailedDisconnectReason];
	}
}

+ (instancetype)clientWithAddress:(NSString *)address port:(NSUInteger)port fd:(NSUInteger)fd {
	MUSyncTCPClient *client = [[self alloc] init];
	client->_remoteAddress = address;
	client->_remotePort = port;
	client->_socketFd = fd;
	return client;
}

@end
