//
//  MUBottomPopView.m
//  Tools
//
//  Created by Magic_Unique on 15/11/15.
//  Copyright © 2015年 Unique. All rights reserved.
//

#import "MUBottomPopView.h"

#define margin 5

#define animated_duration_normal 0.2
#define animated_duration_back 0.05
#define animated_duration_rebound 0.5

#define height_rebound 30

#define button_title_ok     @"确定"
#define button_title_cancel @"取消"

typedef void(^AnimatedCompleted)(BOOL finished);

@interface MUBottomPopView ()
{
    __weak UIView *_panelView;
    __weak UILabel *_titleLabel;
    __weak UIButton *_OKButton;
    __weak UIButton *_cancelButton;
}

@property (nonatomic, copy) BottomPopViewResultBlock resultBlock;

@property (nonatomic, assign) MUBottomPopViewAnimatedOption showAnimatedOption;

@property (nonatomic, assign) MUBottomPopViewAnimatedOption hideAnimatedOption;

@property (nonatomic, assign) MUBottomPopViewHideReason hideReason;

@property (nonatomic, assign, readonly) CGRect frameForShowPanel;

@property (nonatomic, assign, readonly) CGRect frameForHidePanel;

@property (nonatomic, assign, readonly) CGRect frameForHighPanel;

@property (nonatomic, assign, readonly) CGSize sizeForPanel;

@property (nonatomic, assign, readonly) CGFloat heightForToolBar;

@property (nonatomic, strong, readonly) UIWindow *topWindow;

@property (nonatomic, assign, readonly) CGRect boundsOfScreen;

@property (nonatomic, copy, readonly) AnimatedCompleted showCompleted;

@property (nonatomic, copy, readonly) AnimatedCompleted hideCompleted;

@end

@implementation MUBottomPopView

#pragma mark - view

- (instancetype)initWithDelegate:(id<MUBottomPopDelegate>)delegate {
    self = [super init];
    if (self) {
        self.delegate = delegate;
    }
    return self;
}

- (instancetype)initWithResultBlock:(BottomPopViewResultBlock)block {
    self = [super init];
    if (self) {
        self.resultBlock = block;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat heightForToolBar = self.heightForToolBar;
    
    CGRect frame;
    
//    frame = CGRectZero;
//    frame.size = self.sizeForPanel;
//    frame.origin.x = 0;
//    frame.origin.y = self.bounds.size.height - frame.size.height;
//    self.pannelView.frame = frame;
    
    frame = self.OKButton.frame;
    frame.origin.x = self.pannelView.bounds.size.width - margin - frame.size.width;
    frame.origin.y = 0;
    frame.size.height = heightForToolBar;
    self.OKButton.frame = frame;
    
    frame = self.cancelButton.frame;
    frame.origin.x = margin;
    frame.origin.y = 0;
    frame.size.height = heightForToolBar;
    self.cancelButton.frame = frame;
    
    frame = self.titleLabel.frame;
    CGFloat widthForButton = MAX(self.OKButton.frame.size.width, self.cancelButton.frame.size.width);
    frame.size.width = (self.pannelView.bounds.size.width * 0.5 - 2 * margin - widthForButton) * 2;
    frame.origin.y = 0;
    frame.size.height = heightForToolBar;
    frame.origin.x = CGRectGetMaxX(self.cancelButton.frame) + margin;
    self.titleLabel.frame = frame;
    CGPoint center = self.titleLabel.center;
    center.x = self.pannelView.bounds.size.width / 2;
    self.titleLabel.center = center;
    
    frame = self.contentView.frame;
    frame.origin.x = (self.pannelView.bounds.size.width - frame.size.width) * 0.5;
    frame.origin.y = heightForToolBar;
    self.contentView.frame = frame;
    center = self.contentView.center;
    center.x = self.pannelView.bounds.size.width / 2;
    self.contentView.center = center;
    [self.contentView setNeedsLayout];
}

- (void)setContentView:(UIView *)contentView {
    [_contentView removeFromSuperview];
    _contentView = contentView;
    [self.pannelView addSubview:_contentView];
    [self setNeedsLayout];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [super touchesEnded:touches withEvent:event];
	if (!CGRectContainsPoint(self.pannelView.frame, [touches.anyObject locationInView:self])) {
		_hideReason = MUBottomPopViewHideReasonClickShadow;
		[self hideWithAnimatedOption:self.showAnimatedOption];
	}
}

- (void)dealloc {
    
}

#pragma mark - public method

- (void)showWithAnimatedOption:(MUBottomPopViewAnimatedOption)option {
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    
    _showAnimatedOption = option;
    
    if ([self.delegate respondsToSelector:@selector(bottomPopView:willShowForAnimatedOption:)]) {
        [self.delegate bottomPopView:self willShowForAnimatedOption:self.showAnimatedOption];
    }
    
    self.frame = self.boundsOfScreen;
    [self.topWindow addSubview:self];
    
    switch (option) {
        case MUBottomPopViewAnimatedOptionAlpha: {
            self.alpha = 0;
            self.pannelView.frame = self.frameForShowPanel;
            [UIView animateWithDuration:animated_duration_normal animations:^{
                self.alpha = 1;
            } completion:self.showCompleted];
            break;
        }
        case MUBottomPopViewAnimatedOptionPop: {
            self.alpha = 0;
            self.pannelView.frame = self.frameForHidePanel;
            [UIView animateWithDuration:animated_duration_normal delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
                self.alpha = 1;
                self.pannelView.frame = self.frameForShowPanel;
            } completion:self.showCompleted];
            break;
        }
        case MUBottomPopViewAnimatedOptionRebound:{
            self.alpha = 0;
            self.pannelView.frame = self.frameForHidePanel;
			/*
			[UIView animateWithDuration:animated_duration_rebound delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
				self.alpha = 1;
				self.pannelView.frame = self.frameForShowPanel;
			} completion:self.showCompleted];
			 */
            [UIView animateWithDuration:animated_duration_normal delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
                self.alpha = 1;
                self.pannelView.frame = self.frameForHighPanel;
            } completion:^(BOOL finished) {
                if (finished) {
                    [UIView animateWithDuration:animated_duration_back delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
                        self.pannelView.frame = self.frameForShowPanel;
                    } completion:self.showCompleted];
                }
            }];
            break;
        }
        case MUBottomPopViewAnimatedOptionNone: {
            self.alpha = 1;
            self.pannelView.frame = self.frameForShowPanel;
            break;
        }
        default: {
            self.alpha = 1;
            self.pannelView.frame = self.frameForShowPanel;
            break;
        }
    }
}

- (void)hideWithAnimatedOption:(MUBottomPopViewAnimatedOption)option {
    _hideAnimatedOption = option;
    
    if ([self.delegate respondsToSelector:@selector(bottomPopView:willHideForAnimatedOption:andHideReason:)]) {
        [self.delegate bottomPopView:self willHideForAnimatedOption:option andHideReason:self.hideReason];
    }
    
    switch (option) {
        case MUBottomPopViewAnimatedOptionAlpha: {
            [UIView animateWithDuration:animated_duration_normal animations:^{
                self.alpha = 0;
            } completion:self.hideCompleted];
            break;
        }
        case MUBottomPopViewAnimatedOptionPop: {
            [UIView animateWithDuration:animated_duration_normal delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
                self.alpha = 0;
                self.pannelView.frame = self.frameForHidePanel;
            } completion:self.hideCompleted];
            break;
        }
        case MUBottomPopViewAnimatedOptionRebound:{
            [UIView animateWithDuration:animated_duration_back delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
                self.pannelView.frame = self.frameForHighPanel;
            } completion:^(BOOL finished) {
                if (finished) {
                    [UIView animateWithDuration:animated_duration_normal delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
                        self.alpha = 0;
                        self.pannelView.frame = self.frameForHidePanel;
                    } completion:self.hideCompleted];
                }
            }];
            break;
        }
        case MUBottomPopViewAnimatedOptionNone: {
            self.hideCompleted(YES);
            break;
        }
        default:
            self.hideCompleted(YES);
            break;
    }
}

+ (void)showWithAnimatedOption:(MUBottomPopViewAnimatedOption)option certainBlock:(BottomPopViewResultBlock)certain {
    MUBottomPopView *view = [[self alloc] initWithResultBlock:certain];
    [view showWithAnimatedOption:option];
}

#pragma mark - selector

- (void)cancelButtonClick:(UIButton *)cancelButton {
    self.hideReason = MUBottomPopViewHideReasonClickCancel;
    [self hideWithAnimatedOption:self.showAnimatedOption];
}

- (void)OKButtonClick:(UIButton *)OKButton {
    self.hideReason = MUBottomPopViewHideReasonClickOK;
    [self hideWithAnimatedOption:self.showAnimatedOption];
}

#pragma mark - title

- (void)setTitle:(NSString *)title {
    self.titleLabel.text = title;
    [self setNeedsLayout];
}

- (NSString *)title {
    return self.titleLabel.text;
}

#pragma mark - property getter

- (UIView *)pannelView {
    if (!_panelView) {
        UIView *panelView = [UIView new];
        panelView.backgroundColor = [UIColor whiteColor];
        [self addSubview:panelView];
        _panelView = panelView;
    }
    return _panelView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.font = self.OKButton.titleLabel.font;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = [UIColor darkGrayColor];
        [self.pannelView addSubview:titleLabel];
        _titleLabel = titleLabel;
    }
    return _titleLabel;
}

- (UIButton *)OKButton {
    if (!_OKButton) {
        UIButton *OKButton = [UIButton new];
        [OKButton addTarget:self action:@selector(OKButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [OKButton setTitle:button_title_ok forState:UIControlStateNormal];
        [OKButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self.pannelView addSubview:OKButton];
        _OKButton = OKButton;
    }
    return _OKButton;
}

- (UIButton *)cancelButton {
    if (!_cancelButton) {
        UIButton *cancelButton = [UIButton new];
        [cancelButton addTarget:self action:@selector(cancelButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [cancelButton setTitle:button_title_cancel forState:UIControlStateNormal];
        [cancelButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self.pannelView addSubview:cancelButton];
        _cancelButton = cancelButton;
    }
    return _cancelButton;
}

- (CGRect)boundsOfScreen  {
    return [UIScreen mainScreen].bounds;
}

- (UIWindow *)topWindow {
    return [UIApplication sharedApplication].windows.lastObject;
}

#pragma mark - core graphics struct getter

- (CGRect)frameForShowPanel {
    CGRect frame = CGRectZero;
    frame.size = self.sizeForPanel;
    frame.origin.x = 0;
    frame.origin.y = self.boundsOfScreen.size.height - frame.size.height;
    return frame;
}

- (CGRect)frameForHidePanel {
    CGRect frame = CGRectZero;
    frame.size = self.sizeForPanel;
    frame.origin.x = 0;
    frame.origin.y = self.boundsOfScreen.size.height;
    return frame;
}

- (CGRect)frameForHighPanel {
    CGRect frame = CGRectZero;
    frame.size = self.sizeForPanel;
    frame.size.height +=  height_rebound;
    frame.origin.x = 0;
    frame.origin.y = self.boundsOfScreen.size.height - frame.size.height;
    return frame;
}

- (CGSize)sizeForPanel {
    CGSize size = CGSizeZero;
    size.width = self.bounds.size.width;
    size.height = self.contentView.frame.size.height + self.heightForToolBar;
    return size;
}

- (CGFloat)heightForToolBar {
    [self.OKButton sizeToFit];
    [self.cancelButton sizeToFit];
    [self.titleLabel sizeToFit];
    
    CGFloat heightForButton = MAX(self.OKButton.frame.size.height, self.cancelButton.frame.size.height);
    return MAX(heightForButton, self.titleLabel.frame.size.height) + 2 * margin;
}

#pragma mark - animated completed block

- (AnimatedCompleted)showCompleted {
    return ^(BOOL finish) {
        if ([self.delegate respondsToSelector:@selector(bottomPopView:didShowForAnimatedOption:)]) {
            [self.delegate bottomPopView:self didShowForAnimatedOption:self.showAnimatedOption];
        }
    };
}

- (AnimatedCompleted)hideCompleted {
    return ^(BOOL finish) {
        if ([self.delegate respondsToSelector:@selector(bottomPopView:didHideForAnimatedOption:andHideReason:)]) {
            [self.delegate bottomPopView:self didHideForAnimatedOption:self.hideAnimatedOption andHideReason:self.hideReason];
        }
        if (self.resultBlock) {
            self.resultBlock(self.hideReason == MUBottomPopViewHideReasonClickOK);
        }
        [self removeFromSuperview];
    };
}

@end
