//
//  UIView+GuideView.h
//  MUGuideView
//
//  Created by 吴双 on 16/1/4.
//  Copyright © 2016年 unique. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (GuideView)

@property (nonatomic, assign) CGPoint anchorPoint;

- (void)setAnchorPointInSuperView:(CGPoint)point;

@end
