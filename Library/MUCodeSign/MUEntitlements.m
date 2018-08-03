//
//  MUEntitlements.m
//  RingTone
//
//  Created by Shuang Wu on 2017/1/19.
//  Copyright © 2017年 Mia Tse. All rights reserved.
//

#import "MUEntitlements.h"

@implementation MUEntitlements

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
	self = [super init];
	if (self) {
		_ApplicationIdentifier = dictionary[@"application-identifier"];
		_APsEnvironment = dictionary[@"aps-environment"];
		_BetaReportsActive = [dictionary[@"beta-reports-active"] boolValue];
		_AppleDeveloperTeamIdentifier = dictionary[@"com.apple.developer.team-identifier"];
		_GetTaskAllow = [dictionary[@"get-task-allow"] boolValue];
		_KeychainAccessGroups = dictionary[@"keychain-access-groups"];
	}
	return self;
}

+ (instancetype)entitlementsWithDictionary:(NSDictionary *)dictionary {
	return [[self alloc] initWithDictionary:dictionary];
}

@end
