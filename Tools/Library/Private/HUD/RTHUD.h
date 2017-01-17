//
//  RTHUD.h
//  RingTone
//
//  Created by TB-Mac-100 on 2016/12/13.
//  Copyright © 2016年 Mia Tse. All rights reserved.
//

#import "RTHUDContentView.h"

@class RTHUD;

typedef void(^OnHideForTouchEdge)(RTHUD *hud);

@interface RTHUD : UIView

@property (nonatomic, strong, readonly) RTHUDContentView *contentView;

@property (nonatomic, copy, readonly) OnHideForTouchEdge onHide;

@property (nonatomic, assign) BOOL hideWhenTouchEdge;					//	default is YES

- (instancetype)initWithContentView:(RTHUDContentView *)contentView;
- (instancetype)initWithContentView:(RTHUDContentView *)contentView contentSize:(CGSize)contentSize;

- (instancetype)show:(BOOL)animated;
- (instancetype)show:(BOOL)animated onHideForTouchEdge:(OnHideForTouchEdge)onHide;
- (instancetype)hide:(BOOL)animated;

+ (instancetype)showContentView:(RTHUDContentView *)contentView;
+ (instancetype)showContentView:(RTHUDContentView *)contentView onHideForTouchEdge:(OnHideForTouchEdge)onHide;
+ (instancetype)showContentView:(RTHUDContentView *)contentView contentSize:(CGSize)contentSize onHideForTouchEdge:(OnHideForTouchEdge)onHide;

@end
