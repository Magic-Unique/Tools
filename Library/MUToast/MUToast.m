//
//  MUToast.m
//  ToastTest
//
//  Created by Magic_Unique on 15/11/6.
//  Copyright © 2015年 Magic_Unique. All rights reserved.
//

#import "MUToast.h"
#import "MUToastConstant.h"


@interface MUToast ()

{
    UILabel *_titleLabel;
}

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UIImageView *shadowView;

@property (nonatomic, assign) CGPoint bottomCenter;

@end

@implementation MUToast

#pragma mark - Quick Method

+ (void)showAutoHideToastText:(NSString *)text {
    [self showToastText:text duraion:3];
}

+ (void)showDurationToastText:(NSString *)text duraion:(NSTimeInterval)duration {
    [self showToastText:text duraion:duration];
}

+ (MUToast *)showHoldOnToastText:(NSString *)text {
    return [self showToastText:text duraion:0];
}

+ (MUToast *)showToastText:(NSString *)text duraion:(NSTimeInterval)duration {
    MUToast *toast = [self toastWithText:text];
    if (duration > 0) {
        [toast showForDuration:duration];
    } else {
        [toast show];
    }
    return toast;
}

+ (void)hideToast:(MUToast *)toast {
    [toast hidden];
}

#pragma mark - Initialize Method

- (instancetype)init {
    self = [super init];
    if (self) {
        self.alpha = 0;
		[self addSubview:self.shadowView];
    }
    return self;
}

- (instancetype)initWithStyle:(MUToastStyle)style {
    self = [self init];
    if (self) {
        switch (style) {
            case MUToastStyleBlack:
                TCornerRadius(3);
                TSetColor([UIColor colorWithWhite:0 alpha:0.9], WhiteColor);
                self.titleLabel.textColor = [UIColor whiteColor];
                break;
            case MUToastStyleWhite:
                TCornerRadius(3);
                TSetColor([UIColor colorWithWhite:1 alpha:0.9], BlackColor);
                break;
            case MUToastStyleBlurDark:
                TCornerRadius(3);
                TSetColor(ClearColor, WhiteColor);
                self.bgView = DarkBlurView;
                break;
            case MUToastStyleBlurLight:
                TCornerRadius(3);
                TSetColor(ClearColor, BlackColor);
                self.bgView = LightBlurView;
                break;
            case MUToastStyleShine:
                TSetColor(ClearColor, WhiteColor);
                self.bgView = [self shineImageView];
                break;
            default:
                break;
        }
    }
    return self;
}

- (instancetype)initWithText:(NSString *)text {
    self = [self initWithStyle:MUToastStyleBlurDark];
    if (self) {
        self.text = text;
    }
    return self;
}

+ (instancetype)toastWithText:(NSString *)text {
    return [[self alloc] initWithText:text];
}

- (instancetype)initWithText:(NSString *)text style:(MUToastStyle)style {
    self = [self initWithStyle:style];
    if (self) {
        self.text = text;
    }
    return self;
}

+ (instancetype)toastWithText:(NSString *)text style:(MUToastStyle)style {
    return [[self alloc] initWithText:text style:style];
}

#pragma mark - UIView

- (void)layoutSubviews {
    [super layoutSubviews];
	self.shadowView.frame = CGRectMake(-4, -4, self.frame.size.width + 8, self.frame.size.height + 8);
    self.titleLabel.center = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5);
    self.bgView.frame = self.bounds;
}

#pragma mark - Public Method

- (void)show {
    [self removeFromSuperview];
    [[UIApplication sharedApplication].windows.lastObject addSubview:self];
    self.center = BottomCenter;
    self.alpha = 0;
    [UIView animateWithDuration:AnimateDuration animations:^{
        self.bottomCenter = ToBackCenter;
        self.alpha = 1;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:AnimateToBack animations:^{
            self.bottomCenter = HighliCenter;
        }];
    }];
}

- (void)hidden {
    [UIView animateWithDuration:AnimateToBack animations:^{
        self.bottomCenter = ToBackCenter;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:AnimateDuration animations:^{
            self.bottomCenter = BottomCenter;
            self.alpha = 0;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }];
}

- (void)showForDuration:(NSTimeInterval)duration {
    [self show];
    [self performSelector:@selector(hidden) withObject:nil afterDelay:AnimateDuration + duration];
}

#pragma mark - Private Method

- (UIImageView *)shineImageView {
    UIImage *image = [UIImage imageNamed:MUToastSrcName(@"shine")];
    if (!image) {
        image = [UIImage imageNamed:MUToastFrameworkSrcName(@"shine")];
    }
    UIEdgeInsets edge = UIEdgeInsetsMake(image.size.height / 2 - 1, Margin_LR, image.size.height / 2 - 1, Margin_LR);
    UIImage *bgImage = [image resizableImageWithCapInsets:edge resizingMode:UIImageResizingModeStretch];
    return [[UIImageView alloc] initWithImage:bgImage];
}

- (void)setBottomCenter:(CGPoint)bottomCenter {
    bottomCenter.y -= self.frame.size.height * 0.5;
    self.center = bottomCenter;
}

#pragma mark - Property Setter

- (void)setText:(NSString *)text {
    self.titleLabel.text = text;
    CGRect stringBounds = [text boundingRectWithSize:MaxToastSize options:1 attributes:@{NSFontAttributeName:self.titleLabel.font} context:nil];
    self.titleLabel.frame = stringBounds;
    CGPoint center = self.center;
    CGRect frame = self.frame;
    frame.size.width = self.titleLabel.frame.size.width + 2 * Margin_LR;
    frame.size.height = self.titleLabel.frame.size.height + 2 * Margin_TB;
    self.frame = frame;
    self.center = center;
    [self setNeedsLayout];
}

- (void)setBgView:(UIView *)bgView {
    [_bgView removeFromSuperview];
    _bgView = bgView;
    [self insertSubview:_bgView atIndex:0];
}

- (void)setTitleLabel:(UILabel *)titleLabel {
    [_titleLabel removeFromSuperview];
    _titleLabel = titleLabel;
    [self addSubview:_titleLabel];
}

#pragma mark - Property Getter

- (NSString *)text {
    return self.titleLabel.text;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        self.titleLabel = [[UILabel alloc] init];
		_titleLabel.font = [UIFont systemFontOfSize:13];
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}

- (UIImageView *)shadowView {
	if (!_shadowView) {
		_shadowView = [UIImageView new];
//		_shadowView.hidden = YES;
		UIImage *image = [UIImage imageNamed:MUToastSrcName(@"shadow")];
		if (!image) {
			image = [UIImage imageNamed:MUToastFrameworkSrcName(@"shadow")];
		}
		NSLog(@"%@", NSStringFromCGSize(image.size));
		UIEdgeInsets edge = UIEdgeInsetsMake(6, 6, 6, 6);
		UIImage *bgImage = [image resizableImageWithCapInsets:edge resizingMode:UIImageResizingModeStretch];
		_shadowView.image = bgImage;
	}
	return _shadowView;
}

@end




