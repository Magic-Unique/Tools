//
//  MUCirculateRollView.m
//
//
//  Created by Magic_Unqiue on 15/11/16.
//  Copyright © 2015年 Unique. All rights reserved.
//

#import "MUCirculateRollView.h"

@interface MUCirculateRollView () <UIScrollViewDelegate>
{
    UIPageControl *_pageControl;
    UIScrollView *_scrollView;
    BOOL _scrollClock;
}

@end

@implementation MUCirculateRollView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self addSubview:self.scrollView];
        [self addSubview:self.pageControl];
    }
    return self;
}

- (instancetype)initWithItems:(NSArray<MUCirculateRollItemView *> *)items {
    self = [self init];
    if (self) {
        self.itemViews = items;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat width = self.scrollView.bounds.size.width * self.itemViews.count;
    if (width == 0) {// If items.cout == 0, set countentSize.width = self.width
        width = self.bounds.size.width;
    }
    self.scrollView.contentSize = CGSizeMake(width, self.scrollView.bounds.size.height);
    self.pageControl.numberOfPages = self.itemViews.count;
    
    self.scrollView.frame = self.bounds;
    
    for (int i = 0; i < self.itemViews.count; i++) {
        MUCirculateRollItemView *item = self.itemViews[i];
        CGRect frame = self.scrollView.bounds;
        frame.origin.x = i * frame.size.width;
        item.frame = frame;
    }
    
    CGRect pageFrame = self.pageControl.frame;
    pageFrame.size.width = self.bounds.size.width;
    pageFrame.size.height = 10;
    pageFrame.origin.x = 0;
    pageFrame.origin.y = self.bounds.size.height - pageFrame.size.height * 2;
    self.pageControl.frame = pageFrame;
}

#pragma mark - public method

- (void)startCirculateRoll {
    if (_circulateRollTimer) {
        return;
    }
    _circulateRollTimer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(scroll) userInfo:nil repeats:YES];
}

- (void)stopCirculateRoll {
    [_circulateRollTimer invalidate];
    _circulateRollTimer = nil;
}

#pragma mark - private method

- (void)refreshUserInterface {
    [self setNeedsLayout];
}

- (void)scrollToIndex:(NSUInteger)index {
    if (index >= self.itemViews.count) {
        return;
    }
    [self.scrollView setContentOffset:CGPointMake(index * self.scrollView.bounds.size.width, 0) animated:YES];
}

#pragma mark - selector

- (void)scroll {
    NSUInteger index = (NSUInteger)(self.scrollView.contentOffset.x / self.scrollView.bounds.size.width);
    if (index >= self.itemViews.count - 1) {
        index = 0;
    } else {
        index ++;
    }
    [self scrollToIndex:index];
}


#pragma mark - scroll view delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSUInteger index =  (NSUInteger)(self.scrollView.contentOffset.x / self.scrollView.bounds.size.width + 0.5);
    if (!_scrollClock) {
        self.pageControl.currentPage = index;
    }
    
}

#pragma mark - property setter

- (void)setItemViews:(NSArray *)itemViews {
    for (MUCirculateRollItemView *item in _itemViews) {
        [item removeFromSuperview];
    }
    _itemViews = itemViews;
    for (MUCirculateRollItemView *item in _itemViews) {
        [self.scrollView addSubview:item];
    }
    [self refreshUserInterface];
}

#pragma mark - property getter

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [UIPageControl new];
    }
    return _pageControl;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [UIScrollView new];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
    }
    return _scrollView;
}

@end


@implementation MUCirculateRollItemView

@end
