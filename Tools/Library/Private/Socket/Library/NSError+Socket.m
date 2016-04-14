//
//  NSError+Socket.m
//  Socket
//
//  Created by 吴双 on 16/4/11.
//  Copyright © 2016年 unique. All rights reserved.
//

#import "NSError+Socket.h"

NSString *const MUSocketDomain = @"com.unique.socket.error";

NSString *const MUSocketListenFailedDescription					= @"Socket listen failed.";
NSString *const MUSocketListenFailedListeningHasBeganReason		= @"Socket is listening.";
NSString *const MUSocketListenFailedCannotBeginListeningReason	= @"Socket can not begin listening.";

NSString *const MUSocketCloseFailedDescription					= @"Socket close failed.";
NSString *const MUSocketCloseFailedServiceIsnotExistReason		= @"Socket listening service is not exist.";

NSString *const MUSocketSendFailedDescription					= @"Socket send data failed.";
NSString *const MUSocketSendFailedParameterErrorReason			= @"The parameters for sending data are illegal.";
NSString *const MUSocketSendFailedCannotGetRemoteServerReason	= @"Socket can not get remote service.";
NSString *const MUSocketSendFailedCannotCreateLocalServerReason = @"Socket can not create a local service.";
NSString *const MUSocketSendFailedSendDataFailedReason			= @"Socket can not send data to remote service.";
NSString *const MUSocketSendFailedDisconnectReason				= @"Socket can not send anything without connection.";


NSString *const MUSocketConnectFailedDescription				= @"Socket can not connect remote service.";
NSString *const MUSocketConnectFailedServiceHasBeganReason		= @"Socket has connect a remote service.";
NSString *const MUSocketConnectFailedCannotBeginServiceReason	= @"Socket can not start service.";

NSString *const MUSocketBreakFailedDescription					= @"Socket can not break a linking.";
NSString *const MUSocketBreakFailedClientIsNotExistReason		= @"Socket can not break a client without linked.";






@implementation NSError (Socket)

+ (instancetype)mus_errorWithCode:(MUSocketErrorCode)code description:(NSString *)description reason:(NSString *)reason {
	return [NSError errorWithDomain:MUSocketDomain code:code userInfo:@{
			NSLocalizedDescriptionKey:description,
			NSLocalizedFailureReasonErrorKey:reason
			}];
}

+ (instancetype)mus_errorWithCode:(MUSocketErrorCode)code reason:(NSString *)reason {
	NSString *description = nil;
	switch (code) {
		case MUSocketErrorCodeListenFailed:
			description = MUSocketListenFailedDescription;
			break;
		case MUSocketErrorCodeCloseFailed:
			description = MUSocketCloseFailedDescription;
			break;
		case MUSocketErrorCodeSendFailed:
			description = MUSocketSendFailedDescription;
			break;
		case MUSocketErrorCodeConnectFailed:
			description = MUSocketConnectFailedDescription;
			break;
		case MUSocketErrorCodeBreakFailed:
			description = MUSocketBreakFailedDescription;
			break;
		default:
			description = @"No description";
			break;
	}
	return [self mus_errorWithCode:code description:description reason:reason];
}

@end
