//
//  MBProgressHUD+MJ.m
//
//  Created by mj on 13-4-18.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "MBProgressHUD+MJ.h"

@implementation MBProgressHUD (MJ)
#pragma mark 显示信息
+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view
{
	UIView *_view = view;
	if (_view == nil) _view = [[UIApplication sharedApplication] delegate].window;
	// 快速显示一个提示信息
	MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:_view animated:YES];
	hud.label.text = text;
	hud.contentColor = [UIColor whiteColor];
	// 设置图片
	hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", icon]]];
	// 再设置模式
	hud.mode = MBProgressHUDModeCustomView;
	
	// 隐藏时候从父控件中移除
	hud.removeFromSuperViewOnHide = YES;
	
	// 1秒之后再消失
	[hud hideAnimated:YES afterDelay:1.5];
}

#pragma mark 显示错误信息
+ (void)showError:(NSString *)error toView:(UIView *)view{
    [self show:error icon:@"error.png" view:view];
}

+ (void)showSuccess:(NSString *)success toView:(UIView *)view
{
    [self show:success icon:@"success.png" view:view];
}

#pragma mark 显示一些信息
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view {
	UIView *_view = view;
	if (_view == nil) _view = [[UIApplication sharedApplication].windows lastObject];
	_view = [UIApplication sharedApplication].delegate.window;
	// 快速显示一个提示信息
	MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:_view animated:YES];
	hud.label.text = message;
	hud.contentColor = [UIColor whiteColor];
	// 隐藏时候从父控件中移除
	hud.removeFromSuperViewOnHide = YES;
	// YES代表需要蒙版效果
	hud.backgroundView.style = MBProgressHUDBackgroundStyleBlur;
	
	return hud;
}

+ (void)showSuccess:(NSString *)success
{
    [self showSuccess:success toView:nil];
}

+ (void)showError:(NSString *)error
{
    [self showError:error toView:nil];
}

+ (void)showSuccess:(NSString *)success delay:(NSTimeInterval)delay {
	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
		[self showSuccess:success];
	});
}
+ (void)showError:(NSString *)error delay:(NSTimeInterval)delay {
	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
		[self showError:error];
	});
}

+ (MBProgressHUD *)showMessage:(NSString *)message
{
    return [self showMessage:message toView:nil];
}

+ (void)hideHUDForView:(UIView *)view
{
    [self hideHUDForView:view animated:YES];
}

+ (void)hideHUD
{
    [self hideHUDForView:nil];
}
@end
