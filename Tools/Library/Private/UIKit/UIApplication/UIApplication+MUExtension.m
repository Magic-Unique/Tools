//
//  UIApplication+MUExtension.m
//  RingTone
//
//  Created by TB-Mac-100 on 2016/12/19.
//  Copyright © 2016年 Mia Tse. All rights reserved.
//

#import "UIApplication+MUExtension.h"

@implementation UIApplication (MUExtension)

- (void)openAppStoreRateURLWithAppleID:(NSString *)AppleID {
	NSString *urlStr = [@"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=" stringByAppendingString:AppleID];
	[self openURL:[NSURL URLWithString:urlStr]];
}

@end
