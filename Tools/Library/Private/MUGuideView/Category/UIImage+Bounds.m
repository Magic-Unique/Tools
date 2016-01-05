//
//  UIImage+Bounds.m
//  MUGuideView
//
//  Created by 吴双 on 16/1/5.
//  Copyright © 2016年 unique. All rights reserved.
//

#import "UIImage+Bounds.h"

@implementation UIImage (Bounds)

- (instancetype)imageWithBounds:(CGRect)bounds {
	bounds.origin.x *= self.scale;
	bounds.origin.y *= self.scale;
	bounds.size.width *= self.scale;
	bounds.size.height *= self.scale;
	CGImageRef imageRef = CGImageCreateWithImageInRect([self CGImage], bounds);
	UIImage *thumbScale = [UIImage imageWithCGImage:imageRef];
	CGImageRelease(imageRef);
	return thumbScale;
}

@end
