//
//  MUCodeSignCheck.m
//  RingTone
//
//  Created by Shuang Wu on 2017/1/19.
//  Copyright © 2017年 Mia Tse. All rights reserved.
//

#import "MUCodeSignCheck.h"
#import "MUMobileProvision.h"

BOOL isSignWithTeamIdentifier(NSString *teamIdentifier) {
	MUMobileProvision *mobileProvision = [MUMobileProvision localMobileProvision];
	return [mobileProvision.ApplicationIdentifierPrefix containsObject:teamIdentifier];
}
