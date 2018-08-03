//
//  MUGuideView.h
//  MUGuideView
//
//  Created by 吴双 on 16/1/4.
//  Copyright © 2016年 unique. All rights reserved.
//

#import "MUGuideItem.h"

@interface MUGuideView : UIView

@property (nonatomic, strong, readonly) NSArray<MUGuideItem *> *items;

- (instancetype)initWithItems:(NSArray<MUGuideItem *> *)items;

- (void)showToView:(UIView *)view;

@end
