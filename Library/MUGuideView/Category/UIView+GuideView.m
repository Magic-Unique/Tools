//
//  UIView+GuideView.m
//  MUGuideView
//
//  Created by 吴双 on 16/1/4.
//  Copyright © 2016年 unique. All rights reserved.
//

#import "UIView+GuideView.h"



@implementation UIView (GuideView)

- (void)setAnchorPoint:(CGPoint)anchorPoint {
	self.layer.anchorPoint = CGPointMake(anchorPoint.x / self.frame.size.width, anchorPoint.y / self.frame.size.height);
}

- (CGPoint)anchorPoint {
	return CGPointMake(self.layer.anchorPoint.x * self.frame.size.width, self.layer.anchorPoint.y * self.frame.size.height);
}

- (void)setAnchorPointInSuperView:(CGPoint)point {
	CGPoint anchorPoint = self.anchorPoint;
	CGPoint origin = CGPointZero;
	origin.x = point.x - anchorPoint.x;
	origin.y = point.y - anchorPoint.y;
	CGRect frame = self.frame;
	frame.origin = origin;
	self.frame = frame;
}


@end
