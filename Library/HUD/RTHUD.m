//
//  RTHUD.m
//  RingTone
//
//  Created by TB-Mac-100 on 2016/12/13.
//  Copyright © 2016年 Mia Tse. All rights reserved.
//

#import "RTHUD.h"

#define WINDOW UIApplication.sharedApplication.delegate.window

@interface RTHUD ()

@property (nonatomic, assign, readonly) CGSize contentSize;

@end

@implementation RTHUD

+ (instancetype)showContentView:(RTHUDContentView *)contentView {
	return [self showContentView:contentView onHideForTouchEdge:nil];
}

+ (instancetype)showContentView:(RTHUDContentView *)contentView onHideForTouchEdge:(OnHideForTouchEdge)onHide {
	return [[[RTHUD alloc] initWithContentView:contentView] show:YES onHideForTouchEdge:onHide];
}

+ (instancetype)showContentView:(RTHUDContentView *)contentView contentSize:(CGSize)contentSize onHideForTouchEdge:(OnHideForTouchEdge)onHide {
	return [[[RTHUD alloc] initWithContentView:contentView contentSize:contentSize] show:YES onHideForTouchEdge:onHide];
}

- (instancetype)initWithContentView:(RTHUDContentView *)contentView {
	self = [self initWithContentView:contentView contentSize:contentView.frame.size];
	if (self) {
		
	}
	return self;
}

- (instancetype)initWithContentView:(RTHUDContentView *)contentView contentSize:(CGSize)contentSize {
	self = [super initWithFrame:UIScreen.mainScreen.bounds];
	if (self) {
		self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
		
		_contentView = contentView;
		_contentSize = contentSize;
		_hideWhenTouchEdge = YES;
		[self addSubview:contentView];
	}
	return self;
}

- (void)layoutSubviews {
	[super layoutSubviews];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
	if (self.hideWhenTouchEdge) {
		CGPoint location = [touches.anyObject locationInView:self];
		if (!CGRectContainsPoint(self.contentView.frame, location)) {
			!_onHide?:_onHide(self);
			[self hide:YES];
		}
	}
}

- (instancetype)show:(BOOL)animated {
	return [self show:animated onHideForTouchEdge:nil];
}

- (instancetype)show:(BOOL)animated onHideForTouchEdge:(OnHideForTouchEdge)onHide {
	_onHide = [onHide copy];
	
	[WINDOW addSubview:self];
	
	CGSize boundsSize = self.bounds.size;
	CGSize stopSize = self.contentSize;
	CGRect frame = CGRectZero;
	frame.origin.x = (boundsSize.width - stopSize.width) / 2;
	frame.origin.y = (boundsSize.height - stopSize.height) / 2;
	frame.size = stopSize;
	self.contentView.frame = frame;
	
	CGAffineTransform startTransform = CGAffineTransformMakeScale(0.5, 0.5);
	CGAffineTransform stopTransform = CGAffineTransformIdentity;
	
	self.contentView.transform = startTransform;
	self.contentView.alpha = 0;
	self.alpha = 0;
	
	if (animated) {
		[UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseIn|UIViewAnimationOptionLayoutSubviews animations:^{
			self.contentView.transform = stopTransform;
			self.contentView.alpha = 1;
			self.alpha = 1;
		} completion:^(BOOL finished) {
		}];
	} else {
		self.contentView.transform = stopTransform;
		self.contentView.alpha = 1;
	}
	return self;
}

- (instancetype)hide:(BOOL)animated {
	
	CGAffineTransform startTransform = CGAffineTransformMakeScale(0.75, 0.75);
    
	if (animated) {
		[UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveLinear|UIViewAnimationOptionLayoutSubviews animations:^{
			self.contentView.transform = startTransform;
			self.contentView.alpha = 0;
			self.alpha = 0;
		} completion:^(BOOL finished) {
			if (finished) {
				[self removeFromSuperview];
			}
		}];
	} else {
		[self removeFromSuperview];
	}
	return self;
}

@end
