//
//  MUSyncTCPServer.m
//  Socket
//
//  Created by 吴双 on 16/4/14.
//  Copyright © 2016年 unique. All rights reserved.
//

#import "MUSyncTCPServer.h"
#import "NSError+Socket.h"
#import "ytcpsocket.h"


@interface MUSyncTCPClient ()

+ (instancetype)clientWithAddress:(NSString *)address port:(NSUInteger)port fd:(NSUInteger)fd;

@end



@implementation MUSyncTCPServer

- (NSError *)listenWithAddress:(NSString *)address port:(NSUInteger)port {
	if (_socketFd > 0) {
		return [NSError mus_errorWithCode:MUSocketErrorCodeListenFailed reason:MUSocketListenFailedListeningHasBeganReason];
	}
	int fd = ytcpsocket_listen(address.UTF8String, (int)port);
	
	if (fd > 0) {
		_listeningAddress = address;
		_listeningPort = port;
		_socketFd = fd;
		return nil;
	} else {
		return [NSError mus_errorWithCode:MUSocketErrorCodeListenFailed reason:MUSocketListenFailedCannotBeginListeningReason];
	}
}

- (NSError *)close {
	int fd = (int)_socketFd;
	_listeningAddress = nil;
	_listeningPort = 0;
	_socketFd = 0;
	
	if (fd > 0) {
		ytcpsocket_close(fd);
		return nil;
	}
	return [NSError mus_errorWithCode:MUSocketErrorCodeCloseFailed reason:MUSocketCloseFailedServiceIsnotExistReason];
}

- (MUSyncTCPClient *)accept {
	if (_socketFd > 0) {
		int serverFd = (int)_socketFd;
		char buff[16] = {0};//255.255.255.255
		int port = 0;
		int clientfd = ytcpsocket_accept(serverFd, buff, &port);
		if (clientfd < 0) {
			return nil;
		} else {
			NSString *addr = [NSString stringWithUTF8String:buff];
			MUSyncTCPClient *client = [MUSyncTCPClient clientWithAddress:addr port:port fd:clientfd];
			return client;
		}
	}
	return nil;
}

@end
