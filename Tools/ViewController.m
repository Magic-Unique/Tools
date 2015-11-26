//
//  ViewController.m
//  Tools
//
//  Created by Magic_Unique on 15/10/30.
//  Copyright © 2015年 Unique. All rights reserved.
//

#import "ViewController.h"
#import "NSString+Extension.h"

#import "MUToast.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    
    MUToast *toast = [MUToast toastWithText:@"这是一条消息" style:MUToastStyleBlurDark];
    [toast showForDuration:2];
}

@end
