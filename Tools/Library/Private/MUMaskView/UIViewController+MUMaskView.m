//
//  UIViewController+MUMaskView.m
//  RingTone
//
//  Created by TB-Mac-100 on 2016/11/30.
//  Copyright © 2016年 Mia Tse. All rights reserved.
//

#import "UIViewController+MUMaskView.h"
#import "UIView+MUMaskView.h"

@implementation UIViewController (MUMaskView)

- (UIView *)mu_maskingView {
	return self.view.mu_maskingView;
}

- (void)mu_showMaskView:(UIView *)maskView {
	[self.view mu_showMaskView:maskView];
}

- (void)mu_hideMaskingView {
	[self.view mu_hideMaskingView];
}

@end
