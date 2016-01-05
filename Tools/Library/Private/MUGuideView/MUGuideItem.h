//
//  MUGuideItem.h
//  MUGuideView
//
//  Created by 吴双 on 16/1/4.
//  Copyright © 2016年 unique. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, MUGuideArrowDirection) {
	MUGuideArrowDirectionNone,
	
	MUGuideArrowDirectionRightTop,
	MUGuideArrowDirectionBottomRight,
	MUGuideArrowDirectionLeftBottom,
	MUGuideArrowDirectionTopLeft,
	
	MUGuideArrowDirectionRightBottom,
	MUGuideArrowDirectionBottomLeft,
	MUGuideArrowDirectionLeftTop,
	MUGuideArrowDirectionTopRight,
};

@interface MUGuideItem : NSObject

@property (nonatomic, weak) UIView *targetView;
@property (nonatomic, assign) CGRect targetRect;
@property (nonatomic, assign) CGSize targetSize;
@property (nonatomic, assign) CGPoint targetCenter;

@property (nonatomic, assign) CGPoint arrowPoint;
@property (nonatomic, assign) MUGuideArrowDirection arrowDirection;

@property (nonatomic, assign) CGPoint contentPoint;
@property (nonatomic, strong) UIImage *contentImage;

@end
