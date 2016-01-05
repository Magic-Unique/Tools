//
//  MUGuideArrowView.m
//  MUGuideView
//
//  Created by 吴双 on 16/1/4.
//  Copyright © 2016年 unique. All rights reserved.
//

#define MUArrowImageNil			nil
#define MUArrowImageTurnLeft	[UIImage imageNamed:@"guide_arrow_left"]
#define MUArrowImageTurnRight	[UIImage imageNamed:@"guide_arrow_right"]

#define MUArrowSizeWidth		MUArrowImageTurnLeft.size.width
#define MUArrowSizeHeight		MUArrowImageTurnLeft.size.height
#define MUArrowAnchorPointX		0.0
#define MUArrowAnchorPointY		8.0
#define CGAnchorPointY(arrow)	MUArrowAnchorPointY/self.image.size.height
#define CGAnchorPointX(arrow)	(arrow == MUGuideArrowImageTurnLeft ? 0.0 : MUArrowSizeWidth)/MUArrowSizeWidth
#define CGAnchorPoint(arrow)	CGPointMake(CGAnchorPointX(arrowImage), CGAnchorPointY(arrowImage))
#define CGAnchorPointDefault	CGPointMake(0.5, 0.5)

#import "MUGuideArrowView.h"
#import "UIView+GuideView.h"

@implementation MUGuideArrowView

- (void)setArrowImage:(MUGuideArrowImage)arrowImage {
	switch (arrowImage) {
		case MUGuideArrowImageTurnLeft:
			_arrowImage = arrowImage;
			self.image = MUArrowImageTurnLeft;
			self.layer.anchorPoint = CGAnchorPoint(arrowImage);
			break;
		case MUGuideArrowImageTurnRight:
			_arrowImage = arrowImage;
			self.image = MUArrowImageTurnRight;
			self.layer.anchorPoint = CGAnchorPoint(arrowImage);
			break;
		default:
			_arrowImage = MUGuideArrowImageNone;
			self.image = MUArrowImageNil;
			self.layer.anchorPoint = CGAnchorPointDefault;
	}
	[self sizeToFit];
}

- (void)setArrowPoint:(CGPoint)arrowPoint {
	_arrowPoint = arrowPoint;
	[self setAnchorPointInSuperView:arrowPoint];
}

- (void)setImageDirection:(MUGuideArrowDirection)imageDirection arrowPoint:(CGPoint)arrowPoint {
	if (imageDirection == MUGuideArrowDirectionNone || imageDirection > 8) {
		self.arrowImage = MUGuideArrowImageNone;
		self.arrowPoint = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5);
	} else {
		if (imageDirection >= 1 && imageDirection <= 4) {
			self.arrowImage = MUGuideArrowImageTurnLeft;
		} else {
			self.arrowImage = MUGuideArrowImageTurnRight;
		}
		self.arrowPoint = arrowPoint;
		self.transform = CGAffineTransformMakeRotation(M_PI_2 * (imageDirection % 4));
	}
}

- (void)setImage:(MUGuideArrowImage)image arrowPoint:(CGPoint)arrowPoint rotation:(CGFloat)rotation {
	self.transform = CGAffineTransformIdentity;
	self.arrowImage = image;
	self.arrowPoint = arrowPoint;
	self.transform = CGAffineTransformMakeRotation(rotation);
}

@end
