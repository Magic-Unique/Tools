//
//  MUGuideArrowView.h
//  MUGuideView
//
//  Created by 吴双 on 16/1/4.
//  Copyright © 2016年 unique. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MUGuideItem.h"

typedef NS_ENUM(NSUInteger, MUGuideArrowImage) {
	MUGuideArrowImageNone,
	MUGuideArrowImageTurnLeft,
	MUGuideArrowImageTurnRight,
};


@interface MUGuideArrowView : UIImageView

@property (nonatomic, assign, readonly) MUGuideArrowImage arrowImage;

@property (nonatomic, assign, readonly) CGPoint arrowPoint;

- (void)setImageDirection:(MUGuideArrowDirection)imageDirection arrowPoint:(CGPoint)arrowPoint;

@end
