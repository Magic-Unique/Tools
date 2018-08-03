//
//  NSError+Socket.h
//  Socket
//
//  Created by 吴双 on 16/4/11.
//  Copyright © 2016年 unique. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const MUSocketDomain;

extern NSString *const MUSocketListenFailedDescription;
extern NSString *const MUSocketListenFailedListeningHasBeganReason;
extern NSString *const MUSocketListenFailedCannotBeginListeningReason;

extern NSString *const MUSocketCloseFailedDescription;
extern NSString *const MUSocketCloseFailedServiceIsnotExistReason;

extern NSString *const MUSocketSendFailedDescription;
extern NSString *const MUSocketSendFailedParameterErrorReason;
extern NSString *const MUSocketSendFailedCannotGetRemoteServerReason;
extern NSString *const MUSocketSendFailedCannotCreateLocalServerReason;
extern NSString *const MUSocketSendFailedSendDataFailedReason;
extern NSString *const MUSocketSendFailedDisconnectReason;

extern NSString *const MUSocketConnectFailedDescription;
extern NSString *const MUSocketConnectFailedServiceHasBeganReason;
extern NSString *const MUSocketConnectFailedCannotBeginServiceReason;

extern NSString *const MUSocketBreakFailedDescription;
extern NSString *const MUSocketBreakFailedClientIsNotExistReason;

typedef NS_ENUM(NSInteger, MUSocketErrorCode) {
	MUSocketErrorCodeListenFailed = 1001,
	MUSocketErrorCodeCloseFailed = 1002,
	MUSocketErrorCodeSendFailed = 1003,
	MUSocketErrorCodeConnectFailed = 1004,
	MUSocketErrorCodeBreakFailed = 1005,
};







@interface NSError (Socket)

+ (instancetype)mus_errorWithCode:(MUSocketErrorCode)code
				  description:(NSString *)description
					   reason:(NSString *)reason;

+ (instancetype)mus_errorWithCode:(MUSocketErrorCode)code
						   reason:(NSString *)reason;

@end
