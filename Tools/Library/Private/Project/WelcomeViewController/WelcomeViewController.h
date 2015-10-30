//
//  WelcomeViewController.h
//  Tools
//
//  Created by Magic_Unique on 15/9/12.
//  Copyright (c) 2015年 Unique. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WelcomeViewController : UIViewController

@property (nonatomic, strong) UIViewController *target;

/**
 *  通过本类的canBeShow方法来决定返回的控制器对象. 如果canBeShow返回真, 返回一个欢迎界面控制器, 其target等于参数的target; 反之, 直接返回参数的target.
 *
 *  @param target 欢迎控制器结束后的目标控制器
 *
 *  @return 返回一个应该被显示的控制器
 */
+ (UIViewController *)viewControllerWithTargetViewController:(UIViewController *)target;

/**
 *  通过内部代码逻辑来决定本次运行是否需要显示欢迎界面, 从而决定 "viewControllerWithTargetViewController:" 的返回值
 *
 *  @return 欢迎界面是否应该显示
 */
+ (BOOL)canBeShow;

@end
