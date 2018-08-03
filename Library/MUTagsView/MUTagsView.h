//
//  MUTagsView.h
//  RingTone
//
//  Created by TB-Mac-100 on 2016/12/5.
//  Copyright © 2016年 Mia Tse. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MUTagsView;

@protocol MUTagsViewDataSource <NSObject>


/**
 Return the count of tags in tagsView

 @param tagsView MUTagsView

 @return NSUInteger
 */
- (NSUInteger)numberOfTagInTagsView:(MUTagsView *)tagsView;

/**
 Set the item view content and size of frame. tagsView will set the origin of frame to layout it automatic.

 @param tagsView MUTagsView
 @param index	 NSUInteger
 
 @return UIView
 */
- (UIView *)tagsView:(MUTagsView *)tagsView viewForTagIndex:(NSUInteger)index;

@end





@interface MUTagsView : UIScrollView

@property (nonatomic, weak) id<MUTagsViewDataSource> dataSource;

@property (nonatomic, assign) CGFloat horizontalMargin;
@property (nonatomic, assign) CGFloat verticalMargin;
@property (nonatomic, assign) UIEdgeInsets contentInsets;

@property (nonatomic, assign) NSUInteger numberOfTagsLine;

@property (nonatomic, assign, getter=isClickEnable) BOOL clickEnable;

- (void)reloadData;

@end
