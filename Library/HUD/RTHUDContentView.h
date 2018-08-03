//
//  RTHUDContentView.h
//  RingTone
//
//  Created by TB-Mac-100 on 2016/12/13.
//  Copyright © 2016年 Mia Tse. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RTHUD;

@interface RTHUDContentView : UIView

@property (nonatomic, strong, readonly) RTHUD *hud;

- (instancetype)initWithSize:(CGSize)size;
- (instancetype)initWithWidth:(CGFloat)width height:(CGFloat)height;

@end
