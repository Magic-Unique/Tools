//
//  MUGuideTargetView.m
//  MUGuideView
//
//  Created by 吴双 on 16/1/5.
//  Copyright © 2016年 unique. All rights reserved.
//

#import "MUGuideTargetView.h"
#import "UIView+Snapshot.h"
#import "UIImage+Bounds.h"
#import "MUGuideView.h"

@implementation MUGuideTargetView

- (instancetype)init {
	self = [super init];
	if (self) {
		self.layer.masksToBounds = YES;
		self.layer.cornerRadius = 15;
	}
	return self;
}

- (void)setFrame:(CGRect)frame {
	[super setFrame:frame];
	[self refreshImage];
}

- (void)refreshImage {
	if ([self.superview isKindOfClass:[MUGuideView class]]) {
		MUGuideView *guideView = (MUGuideView *)self.superview;
		UIImage *targetViewSnapshot = [guideView valueForKey:@"_targetViewSnapshot"];
		UIImage *targetImage = [targetViewSnapshot imageWithBounds:self.frame];
		self.image = targetImage;
	}
}

@end
