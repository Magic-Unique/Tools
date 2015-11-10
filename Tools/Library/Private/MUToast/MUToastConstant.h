//
//  Constant.h
//  ToastTest
//
//  Created by Magic_Unique on 15/11/10.
//  Copyright © 2015年 Magic_Unique. All rights reserved.
//

#ifndef Constant_h
#define Constant_h

#define Margin_LR 20
#define Margin_TB 10

#define Screen          [UIScreen mainScreen]
#define ScreenSize      Screen.size
#define BottomCenter    CGPointMake(Screen.bounds.size.width * 0.5, Screen.bounds.size.height)
#define ToBackCenter    CGPointMake(Screen.bounds.size.width * 0.5, Screen.bounds.size.height * 0.83)
#define HighliCenter    CGPointMake(Screen.bounds.size.width * 0.5, Screen.bounds.size.height * 0.85)
#define MaxToastSize    CGSizeMake(Screen.bounds.size.width - 5 * Margin_LR, 999)

#define AnimateDuration 0.3
#define AnimateToBack   0.1

#define TCornerRadius(r) self.layer.cornerRadius = r; self.layer.masksToBounds = r;
#define TSetColor(b, t) self.titleLabel.textColor = t; self.backgroundColor = b;

#define BlackColor      [UIColor blackColor]
#define WhiteColor      [UIColor whiteColor]
#define ClearColor      [UIColor clearColor]

#define DarkBlurView    [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]]
#define LightBlurView   [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]]

#define MUToastSrcName(file) [@"Toast.bundle" stringByAppendingPathComponent:file]
#define MUToastFrameworkSrcName(file) [@"Frameworks/MUToast.framework/Toast.bundle" stringByAppendingPathComponent:file]

#endif /* Constant_h */
