//
//  MUPageChooser.m
//  segmentView
//
//  Created by Shuang on 15/11/24.
//  Copyright © 2015年 huaxu. All rights reserved.
//

#import "MUPageChooser.h"
#import "UIKit+Extension.h"

@interface MUPageChooser ()
{
    NSArray<NSString *> *_titles;
    NSUInteger _selectedIndex;
    CGFloat _bottomLineHeight;
    CGFloat _fontSize;
}
@property (nonatomic, strong) UIView *bottomLine;

@property (nonatomic, strong) NSMutableArray<UIButton *> *buttons;

@end

@implementation MUPageChooser

- (instancetype)initWithTitles:(NSArray<NSString *> *)titles andFontSize:(CGFloat)size {
    self = [super init];
    if (self) {
        _titles = titles;
        _fontSize = size;
        [self addSubview:self.bottomLine];
        for (NSString *str in titles) {
            UIButton *button = [self createButtonWithTitle:str];
            [self.buttons addObject:button];
        }
        self.buttons.firstObject.selected = YES;
    }
    return self;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat itemWidth = self.bounds.size.width / self.titles.count;
    
    self.bottomLine.width = itemWidth;
    self.bottomLine.height = self.bottomLineHeight;
    self.bottomLine.toSuperViewBottom = 0;
    self.bottomLine.minX = self.selectedIndex * itemWidth;
    
    for (int i = 0; i < self.buttons.count; i++) {
        UIButton *button = self.buttons[i];
        button.width = itemWidth;
        button.height = self.bounds.size.height - self.bottomLineHeight;
        button.minY = 0;
        button.minX = itemWidth * i;
    }
}

- (void)setHighlightColor:(UIColor *)highlightColor {
	_highlightColor = highlightColor;
    self.bottomLine.backgroundColor = highlightColor;
    for (UIButton *button in self.buttons) {
        button.titleColorForSelectedNormal = highlightColor;
        button.titleColorForSelectedHighlighted = highlightColor;
    }
}

#pragma mark - public method

#pragma mark - private method

- (CGRect)frameForBottomLine:(NSUInteger)selectedIndex {
    CGRect frame = CGRectZero;
    frame.size.width = self.bounds.size.width / self.titles.count;
    frame.size.height = self.bottomLineHeight;
    frame.origin.y = self.bounds.size.height - frame.size.height;
    frame.origin.x = selectedIndex * frame.size.width;
    return frame;
}

#pragma mark - selector

- (void)itemClick:(UIButton *)button {
    NSUInteger selectedIndex = [self.buttons indexOfObject:button];
    [self setSelectedIndex:selectedIndex animated:YES];
}

#pragma mark - property setter

- (void)setBottomLineHeight:(CGFloat)bottomLineHeight {
    _bottomLineHeight = bottomLineHeight;
    self.bottomLine.height = bottomLineHeight;
    [self setNeedsLayout];
}

- (void)setNormalColor:(UIColor *)normalColor {
    _normalColor = normalColor;
    for (UIButton *button in self.buttons) {
        button.titleColorForDeselectNormal = normalColor;
    }
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex {
    [self setSelectedIndex:selectedIndex animated:NO];
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex animated:(BOOL)animated {
    if (_selectedIndex == selectedIndex) {
        return;
    }
    _selectedIndex = selectedIndex;
    for (UIButton *button in self.buttons) {
        button.selected = NO;
    }
    self.buttons[selectedIndex].selected = YES;
    if (animated) {
        [UIView animateWithDuration:0.3 animations:^{
            self.bottomLine.frame = [self frameForBottomLine:selectedIndex];
        }];
    } else {
        self.bottomLine.frame = [self frameForBottomLine:selectedIndex];
    }
    if ([self.delegate respondsToSelector:@selector(pageChooserDidChangeSelectedIndex:)]) {
        [self.delegate pageChooserDidChangeSelectedIndex:self];
    }
}

- (void)setFontSize:(CGFloat)fontSize {
    _fontSize = fontSize;
    for (UIButton *button in self.buttons) {
        button.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    }
}

#pragma mark - property getter

- (NSMutableArray<UIButton *> *)buttons {
    if (!_buttons) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}

- (UIView *)bottomLine {
    if (!_bottomLine) {
        _bottomLine = [UIView new];
        _bottomLine.backgroundColor = self.tintColor;
    }
    return _bottomLine;
}

- (CGFloat)bottomLineHeight {
    if (!_bottomLineHeight) {
        _bottomLineHeight = 2;
    }
    return _bottomLineHeight;
}

- (UIButton *)createButtonWithTitle:(NSString *)title {
    UIButton *button = [UIButton new];
    [button addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
    button.titleForDeselectNormal = title;
    button.titleColorForDeselectNormal = self.normalColor;
    button.titleColorForSelectedNormal = self.tintColor;
    button.titleColorForSelectedHighlighted = self.tintColor;
    button.titleLabel.font = [UIFont systemFontOfSize:self.fontSize];
    [self addSubview:button];
    return button;
}

- (CGFloat)fontSize {
    if (_fontSize == 0) {
        _fontSize = 15;
    }
    return _fontSize;
}

@end
