//
//  MUBottomPopView.h
//  CityPicker
//
//  Created by Magic_Unique on 15/11/15.
//  Copyright © 2015年 Unique. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MUBottomPopView;


typedef void(^BottomPopViewResultBlock)(BOOL ok);


typedef NS_ENUM(NSUInteger, MUBottomPopViewAnimatedOption) {
    MUBottomPopViewAnimatedOptionNone,
    MUBottomPopViewAnimatedOptionAlpha,
    MUBottomPopViewAnimatedOptionPop,
    MUBottomPopViewAnimatedOptionRebound,
};



typedef NS_ENUM(NSUInteger, MUBottomPopViewHideReason) {
    MUBottomPopViewHideReasonClickOK,
    MUBottomPopViewHideReasonClickCancel,
    MUBottomPopViewHideReasonClickShadow,
};



@protocol MUBottomPopDelegate <NSObject>

@optional

- (void)bottomPopView:(MUBottomPopView *)bottomPopView willShowForAnimatedOption:(MUBottomPopViewAnimatedOption)animatedOption;

- (void)bottomPopView:(MUBottomPopView *)bottomPopView didShowForAnimatedOption:(MUBottomPopViewAnimatedOption)animatedOption;

- (void)bottomPopView:(MUBottomPopView *)bottomPopView willHideForAnimatedOption:(MUBottomPopViewAnimatedOption)animatedOption andHideReason:(MUBottomPopViewHideReason)hideReason;

- (void)bottomPopView:(MUBottomPopView *)bottomPopView didHideForAnimatedOption:(MUBottomPopViewAnimatedOption)animatedOption andHideReason:(MUBottomPopViewHideReason)hideReason;

@end






@interface MUBottomPopView : UIView

@property (nonatomic, assign) id<MUBottomPopDelegate> delegate;

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, weak, readonly) UIView *pannelView;

@property (nonatomic, weak, readonly) UIButton *cancelButton;

@property (nonatomic, weak, readonly) UIButton *OKButton;

@property (nonatomic, weak, readonly) UILabel *titleLabel;

@property (nonatomic, copy) NSString *title;


- (instancetype)initWithDelegate:(id<MUBottomPopDelegate>)delegate;

- (instancetype)initWithResultBlock:(BottomPopViewResultBlock)block;

- (void)showWithAnimatedOption:(MUBottomPopViewAnimatedOption)option;

- (void)hideWithAnimatedOption:(MUBottomPopViewAnimatedOption)option;

+ (void)showWithAnimatedOption:(MUBottomPopViewAnimatedOption)option certainBlock:(BottomPopViewResultBlock)certain;

@end






