//
//  UIViewController+Additem.h
//  快帮KuBer
//
//  Created by imac on 15/10/19.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Additem)
-(void)addLeftBarItems:(NSString *)text image:(NSString *)name target:(id)target action:(SEL)action;


-(void)addRightBarItems:(NSString *)text image:(NSString *)name target:(id)target action:(SEL)action;
@end
