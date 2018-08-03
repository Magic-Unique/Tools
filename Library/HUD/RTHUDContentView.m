//
//  RTHUDContentView.m
//  RingTone
//
//  Created by TB-Mac-100 on 2016/12/13.
//  Copyright © 2016年 Mia Tse. All rights reserved.
//

#import "RTHUDContentView.h"
#import "RTHUD.h"

@implementation RTHUDContentView

- (instancetype)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		self.backgroundColor = [UIColor whiteColor];
		self.layer.cornerRadius = 8;
	}
	return self;
}

- (instancetype)init {
	self = [self initWithFrame:CGRectZero];
	return self;
}

- (instancetype)initWithSize:(CGSize)size {
	self = [self initWithFrame:CGRectMake(0, 0, size.width, size.height)];
	return self;
}

- (instancetype)initWithWidth:(CGFloat)width height:(CGFloat)height {
	self = [self initWithFrame:CGRectMake(0, 0, width, height)];
	return self;
}

- (RTHUD *)hud {
	if ([self.superview isKindOfClass:[RTHUD class]]) {
		return (RTHUD *)self.superview;
	} else {
		return nil;
	}
}

@end
