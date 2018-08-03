//
//  UIView+MUMaskView.m
//  RingTone
//
//  Created by TB-Mac-100 on 2016/11/30.
//  Copyright © 2016年 Mia Tse. All rights reserved.
//

#import "UIView+MUMaskView.h"
#import <objc/runtime.h>

#define MASKING_VIEW_PROPERTY_NAME @"mu_masking_view"

@implementation UIView (MUMaskView)

- (void)setMu_maskingView:(UIView * _Nullable)mu_maskingView {
	objc_setAssociatedObject(self, MASKING_VIEW_PROPERTY_NAME.UTF8String, mu_maskingView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)mu_maskingView {
	return objc_getAssociatedObject(self, MASKING_VIEW_PROPERTY_NAME.UTF8String);
}

- (void)mu_showMaskView:(UIView *)maskView {
	UIView *view = self.mu_maskingView;
	[view removeFromSuperview];
	self.mu_maskingView = maskView;
	maskView.frame = self.bounds;
	if ([self isKindOfClass:UIScrollView.class]) {
		UIScrollView *scrollView = (UIScrollView *)self;
		scrollView.scrollEnabled = maskView ? NO : YES;
	}
	[self addSubview:maskView];
	[self bringSubviewToFront:maskView];
}

- (void)mu_hideMaskingView {
	UIView *view = self.mu_maskingView;
	[view removeFromSuperview];
	self.mu_maskingView = nil;
	
	if ([self isKindOfClass:UIScrollView.class]) {
		UIScrollView *scrollView = (UIScrollView *)self;
		scrollView.scrollEnabled = YES;
	}
}

@end
