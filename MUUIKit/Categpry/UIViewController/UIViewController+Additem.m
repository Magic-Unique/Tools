//
//  UIViewController+Additem.m
//  快帮KuBer
//
//  Created by imac on 15/10/19.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "UIViewController+Additem.h"
@implementation UIViewController (Additem)

-(void)addLeftBarItems:(NSString *)text image:(NSString *)imageName target:(id)target action:(SEL)action
{
    UIButton *btn=[UIButton new];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    btn.frame=CGRectMake(0, 0, 30,30);
    if (text) {
        [btn setTitle:text forState:UIControlStateNormal];
    }
    if (imageName) {
        [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }
    UIBarButtonItem *leftBarButtonItem =  [[UIBarButtonItem alloc]initWithCustomView:btn];
    UIBarButtonItem *itemSpace0=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    itemSpace0.width=-10;
    self.navigationItem.leftBarButtonItems=@[itemSpace0,leftBarButtonItem];
    
}


-(void)addRightBarItems:(NSString *)text image:(NSString *)imageName target:(id)target action:(SEL)action
{
    UIButton *btn=[UIButton new];
    btn.frame=CGRectMake(0, 0, 30,30);
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    if (text) {
        [btn setTitle:text forState:UIControlStateNormal];
    }
    if (imageName) {
        [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }
    
    UIBarButtonItem *rightBarButtonItem =  [[UIBarButtonItem alloc]initWithCustomView:btn];
     UIBarButtonItem *itemSpace1=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
     itemSpace1.width=-9.5;
     self.navigationItem.rightBarButtonItems=@[itemSpace1,rightBarButtonItem];

}

@end
