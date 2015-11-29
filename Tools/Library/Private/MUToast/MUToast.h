//
//  MUToast.h
//  ToastTest
//
//  Created by Magic_Unique on 15/11/6.
//  Copyright © 2015年 Magic_Unique. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger, MUToastStyle) {
    MUToastStyleBlurDark,   //default
    MUToastStyleBlurLight,
    MUToastStyleBlack,
    MUToastStyleWhite,
    MUToastStyleShine,
};

@interface MUToast : UIView

/**
 *  Show a toast message and auto hide after 3 s.
 *
 *  @param text message
 */
+ (void)showAutoHideToastText:(NSString *)text;

/**
 *  Show a toast message and auto hide after duration time.
 *
 *  @param text     message
 *  @param duration duration time
 */
+ (void)showDurationToastText:(NSString *)text duraion:(NSTimeInterval)duration;

/**
 *  Show a toast message without hidden.
 *
 *  @param text message
 *
 *  @return MUToast
 */
+ (MUToast *)showHoldOnToastText:(NSString *)text;

/**
 *  Hide a toast
 *
 *  @param toast toast
 */
+ (void)hideToast:(MUToast *)toast;

@property (nonatomic, strong, readonly) NSString *text;

/**
 *  Init and use default style
 *
 *  @param text message
 *
 *  @return MUToast
 */
- (instancetype)initWithText:(NSString *)text;
+ (instancetype)toastWithText:(NSString *)text;

/**
 *  Init
 *
 *  @param text  message
 *  @param style MUToastStyle
 *
 *  @return MUToast
 */
- (instancetype)initWithText:(NSString *)text style:(MUToastStyle)style;
+ (instancetype)toastWithText:(NSString *)text style:(MUToastStyle)style;

/**
 *  Show in window
 */
- (void)show;

/**
 *  Hide from window
 */
- (void)hidden;

/**
 *  show in window and hide after duration time
 *
 *  @param duration duration time
 */
- (void)showForDuration:(NSTimeInterval)duration;


@end
