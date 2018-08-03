//
//  MUGuideView.m
//  MUGuideView
//
//  Created by 吴双 on 16/1/4.
//  Copyright © 2016年 unique. All rights reserved.
//

#import "MUGuideView.h"
#import "UIView+Snapshot.h"
#import "MUGuideArrowView.h"
#import "MUGuideTargetView.h"
#import "MUGuideContentView.h"

@interface MUGuideView ()
{
	UIImage *_targetViewSnapshot;
}

@property (nonatomic, strong) MUGuideTargetView *targetRectContentImageView;

@property (nonatomic, strong) MUGuideArrowView *arrowImageView;

@property (nonatomic, strong) MUGuideContentView *contentView;

@property (nonatomic, assign) NSInteger currentIndex;

@property (nonatomic, weak, readonly) MUGuideItem *currentItem;

@end

@implementation MUGuideView

- (instancetype)init {
	self = [self initWithFrame:[UIScreen mainScreen].bounds];
	if (self) {
	}
	return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		self.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.667];
		[self addSubview:self.targetRectContentImageView];
		[self addSubview:self.arrowImageView];
		[self addSubview:self.contentView];
	}
	return self;
}

- (instancetype)initWithItems:(NSArray<MUGuideItem *> *)items {
	self = [self init];
	if (self) {
		_items = items;
	}
	return self;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
	[super touchesEnded:touches withEvent:event];
	self.currentIndex ++;
}

- (void)dealloc {
	NSLog(@"%s", __FUNCTION__);
}

#pragma mark - 公开方法

- (void)showToView:(UIView *)view {
	if (self.items.count) {
		_targetViewSnapshot = view.snapshot;
		self.frame = view.bounds;
		[view addSubview:self];
		self.currentIndex = 0;
	}
}

#pragma mark - 私有方法

- (NSInteger)currentIndex {
	if ([self.items containsObject:self.currentItem]) {
		return [self.items indexOfObject:self.currentItem];
	} else {
		return -1;
	}
}

- (void)setCurrentIndex:(NSInteger)currentIndex {
	if (currentIndex >= 0 && currentIndex < self.items.count) {
		[self setContentItem:self.items[currentIndex]];
	} else {
		[self removeFromSuperview];
	}
}

- (void)setContentItem:(MUGuideItem *)item {
	_currentItem = item;
	[self setViewHidden:!item];
	if (item) {
		self.targetRectContentImageView.frame = item.targetRect;
		[self.arrowImageView setImageDirection:item.arrowDirection arrowPoint:item.arrowPoint];
		self.contentView.image = item.contentImage;
		[self.contentView sizeToFit];
		self.contentView.center = item.contentPoint;
	}
}

- (void)setViewHidden:(BOOL)hidden {
	self.targetRectContentImageView.hidden = hidden;
	self.contentView.hidden = hidden;
	self.arrowImageView.hidden = hidden;
}

#pragma mark - 懒加载

- (MUGuideTargetView *)targetRectContentImageView {
	if (!_targetRectContentImageView) {
		_targetRectContentImageView = [MUGuideTargetView new];
	}
	return _targetRectContentImageView;
}

- (MUGuideArrowView *)arrowImageView {
	if (!_arrowImageView) {
		_arrowImageView = [MUGuideArrowView new];
	}
	return _arrowImageView;
}

- (MUGuideContentView *)contentView {
	if (!_contentView) {
		_contentView = [MUGuideContentView new];
	}
	return _contentView;
}

@end
