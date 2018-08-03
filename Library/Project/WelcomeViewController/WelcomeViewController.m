//
//  WelcomeViewController.m
//  Tools
//
//  Created by Magic_Unique on 15/9/12.
//  Copyright (c) 2015年 Unique. All rights reserved.
//

#import "WelcomeViewController.h"

#define IMAGE_COUNT 4
#define IMAGE_FORMAT @"new_feature_%01lu"

@interface WelcomeViewController ()



@end

@implementation WelcomeViewController

#pragma mark - must be override method

/**
 *  通过本方法创建欢迎界面的最后一个ImageView, 需要自行创建结束Button和绑定TouchUpInside事件
 *
 *  @return 最后一个ImageView
 */
- (UIImageView *)lastImageView {
    UIImageView *lastImageView = [self imageViewWithIndex:IMAGE_COUNT - 1];
    lastImageView.userInteractionEnabled = YES;
    // diy last image view
    /*
    UIButton *btn =[[UIButton alloc] init];
    [btn setTitle:@"开启" forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(presentTargetViewController) forControlEvents:UIControlEventTouchUpInside];
    CGRect frame = btn.frame;
    frame.size = btn.currentBackgroundImage.size;
    btn.frame = frame;
    btn.center = CGPointMake(lastImageView.frame.size.width * 0.5, lastImageView.frame.size.height * 0.5);
    
    [lastImageView addSubview:btn];
    */
    // end
    return lastImageView;
}

/**
 *  本方法决定工厂方法的返回值, 可通过UserDefault的读写来决定本方法的返回值. 返回真, 则工厂方法返回本类的对象, 其target等于工厂方法的参数target; 返回假, 工厂方法直接返回参数target
 *
 *  @return 欢迎界面是否应该被显示
 */
+ (BOOL)canBeShow {
	NSString *keyForLastVersion = @"com.unique.lastversoin";
	NSString *lastVersionString = [[NSUserDefaults standardUserDefaults] objectForKey:keyForLastVersion];
	NSString *currentVersionString = [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"];
	if (lastVersionString.floatValue < currentVersionString.floatValue) {
		[[NSUserDefaults standardUserDefaults] setObject:currentVersionString forKey:keyForLastVersion];
		return YES;
	} else {
		return NO;
	}
}

/**
 *  LastImageView中的结束按钮绑定的selector
 */
- (void)presentTargetViewController {
    if (self.target) {
        self.view.window.rootViewController = self.target;
    }
}



#pragma mark - do not change code

- (void)viewDidLoad
{
    [self.view addSubview:[self scrollView]];
}

+ (UIViewController *)viewControllerWithTargetViewController:(UIViewController *)target {
    if (![WelcomeViewController canBeShow]) {
        return target;
    } else {
        WelcomeViewController *wvc = [[WelcomeViewController alloc] init];
        wvc.target = target;
        return wvc;
    }
}

#pragma mark - sub view factory method

- (UIScrollView *)scrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.bounces = NO;
    scrollView.pagingEnabled = YES;
    scrollView.frame = self.view.bounds;
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * IMAGE_COUNT, 0);
    
    for (int i = 0; i < IMAGE_COUNT - 1; i++) {
        UIImageView *imageView = [self imageViewWithIndex:i];
        [scrollView addSubview:imageView];
    }
    UIImageView *lastImageView = [self lastImageView];
    [scrollView addSubview:lastImageView];
    return scrollView;
}

- (UIImageView *)imageViewWithIndex:(NSUInteger)index
{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[self imageWithIndex:index]];
    CGRect frame = imageView.frame;
    frame.size = self.view.frame.size;
    frame.origin.x = index * self.view.frame.size.width;
    imageView.frame = frame;
    return imageView;
}

- (UIImage *)imageWithIndex:(NSUInteger)index
{
    NSString *imageName = [NSString stringWithFormat:IMAGE_FORMAT, index];
    return [UIImage imageNamed:imageName];
}



@end
