//
//  MUGuideItem.m
//  MUGuideView
//
//  Created by 吴双 on 16/1/4.
//  Copyright © 2016年 unique. All rights reserved.
//

#import "MUGuideItem.h"

@implementation MUGuideItem

- (void)setTargetSize:(CGSize)targetSize {
	CGRect rect = self.targetRect;
	rect.size = targetSize;
	self.targetRect = rect;
}

- (CGSize)targetSize {
	return self.targetRect.size;
}

- (void)setTargetCenter:(CGPoint)targetCenter {
	CGRect rect = self.targetRect;
	rect.origin.x = targetCenter.x - rect.size.width / 2;
	rect.origin.y = targetCenter.y - rect.size.height / 2;
	self.targetRect = rect;
}

- (CGPoint)targetCenter {
	return CGPointMake(CGRectGetMidX(self.targetRect), CGRectGetMidY(self.targetRect));
}

@end
