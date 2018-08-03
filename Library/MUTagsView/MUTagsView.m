//
//  MUTagsView.m
//  RingTone
//
//  Created by TB-Mac-100 on 2016/12/5.
//  Copyright © 2016年 Mia Tse. All rights reserved.
//

#import "MUTagsView.h"

@interface MUTagsView ()
{
    BOOL _needsReload;
}
@end

@implementation MUTagsView

- (void)setDataSource:(id<MUTagsViewDataSource>)dataSource {
    if (_dataSource != dataSource) {
        _dataSource = dataSource;
        [self setNeedsReload];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (_needsReload) {
        _needsReload = NO;
        [self _reloadDataFramDataSource];
    }
}

- (void)reloadData {
    [self setNeedsReload];
}

- (void)setNeedsReload {
    _needsReload = YES;
    [self setNeedsLayout];
}

- (void)_reloadDataFramDataSource {
    //  Clean old items
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    NSUInteger numberOfTags = [self.dataSource numberOfTagInTagsView:self];
    NSUInteger currentLine = 1;
    CGRect lastFrame = CGRectMake(self.contentInsets.left - self.horizontalMargin, self.contentInsets.top, 0, 0);
    CGFloat maxX = self.bounds.size.width - self.contentInsets.right;
	CGSize contentSize = CGSizeZero;
    
    for (int i = 0; i < numberOfTags; i++) {
        UIView *view = [self.dataSource tagsView:self viewForTagIndex:i];
        CGRect frame = view.frame;
        frame.origin.x = CGRectGetMaxX(lastFrame) + self.horizontalMargin;
        frame.origin.y = lastFrame.origin.y;
        if (CGRectGetMaxX(frame) > maxX) {
            //  needs break line
            if (self.numberOfTagsLine > 0 && self.numberOfTagsLine < currentLine + 1) {
                //  out of line count
                break;
            } else {
                //  break line
                frame.origin = CGPointMake(self.contentInsets.left, CGRectGetMaxY(lastFrame) + self.verticalMargin);
                currentLine ++;
            }
        }
        view.frame = frame;
		lastFrame = frame;
		contentSize.width = CGRectGetMaxX(frame) > contentSize.width ? CGRectGetMaxX(frame) : contentSize.width;
		contentSize.height = CGRectGetMaxY(frame) > contentSize.height ? CGRectGetMaxY(frame) : contentSize.height;
        [self addSubview:view];
    }
	contentSize.width += self.contentInsets.right;
	contentSize.height += self.contentInsets.bottom;
	self.contentSize = contentSize;
}

@end
