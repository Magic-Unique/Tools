//
//  MUPageChooser.h
//  segmentView
//
//  Created by Shuang on 15/11/24.
//  Copyright © 2015年 huaxu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MUPageChooser;

@protocol MUPageChooserDelegate <NSObject>

@optional

- (void)pageChooserDidChangeSelectedIndex:(MUPageChooser *)pageChooser;

@end


@interface MUPageChooser : UIView

@property (nonatomic, assign) id<MUPageChooserDelegate> delegate;

@property (nonatomic, strong, readonly) NSArray*titles;

/** 正常颜色(没有选中的按钮的颜色) */
@property (nonatomic, strong) UIColor *normalColor;

/** 高亮颜色(选中按钮的颜色, 底部横线的颜色) */
@property (nonatomic, strong) UIColor *highlightColor;

/** 按钮字体大小 */
@property (nonatomic, assign) CGFloat fontSize;

/** 底部横线的高度 */
@property (nonatomic, assign) CGFloat bottomLineHeight;

/** 当前选择索引 */
@property (nonatomic, assign) NSUInteger selectedIndex;

- (instancetype)initWithTitles:(NSArray*)titles andFontSize:(CGFloat)size;

- (void)setSelectedIndex:(NSUInteger)selectedIndex animated:(BOOL)animated;

@end
