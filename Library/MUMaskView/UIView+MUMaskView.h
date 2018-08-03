//
//  UIView+MUMaskView.h
//  RingTone
//
//  Created by TB-Mac-100 on 2016/11/30.
//  Copyright © 2016年 Mia Tse. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (MUMaskView)

@property (nonatomic, strong, readonly, nullable) UIView *mu_maskingView;

- (void)mu_showMaskView:(UIView * __nullable)maskView;

- (void)mu_hideMaskingView;

@end
