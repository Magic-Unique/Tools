//
//  UITabBarItem+Extension.m
//  RingTone
//
//  Created by TB-Mac-100 on 2016/12/2.
//  Copyright © 2016年 Mia Tse. All rights reserved.
//

#import "UITabBarItem+Extension.h"

@implementation UITabBarItem (Extension)

- (void)setBadgeNumber:(NSInteger)badgeNumber {
	if (badgeNumber == 0) {
		self.badgeValue = nil;
	} else {
		self.badgeValue = @(badgeNumber).stringValue;
	}
}

- (NSInteger)badgeNumber {
	return self.badgeValue.integerValue;
}

@end
