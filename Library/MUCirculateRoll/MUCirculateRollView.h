//
//  MUCirculateRollView.h
//  
//
//  Created by Magic_Unqiue on 15/11/16.
//  Copyright © 2015年 Unique. All rights reserved.
//

#import <UIKit/UIKit.h>



typedef void(^ClickBehaver)(void);





@interface MUCirculateRollItemView : UIImageView

@property (nonatomic, copy) ClickBehaver behaver;

@end






@interface MUCirculateRollView : UIView

@property (nonatomic, strong, readonly) UIScrollView *scrollView;

@property (nonatomic, strong, readonly) UIPageControl *pageControl;

@property (nonatomic, strong, readonly) NSArray<MUCirculateRollItemView *> *itemViews;

@property (nonatomic, strong, readonly) NSTimer *circulateRollTimer;

@property (nonatomic, assign, readonly) BOOL circulateRolling;

- (instancetype)initWithItems:(NSArray*)items;

- (void)startCirculateRoll;

- (void)stopCirculateRoll;

@end
