//
//  UIImageView+CircleHeader.m
//  KuBer
//
//  Created by 吴双 on 16/3/9.
//  Copyright © 2016年 huaxu. All rights reserved.
//

#import "UIImageView+Circle.h"
#import <UIImageView+WebCache.h>
#import "MUCircleImageManager.h"

@implementation UIImageView (Circle)

- (void)setCircleImageWithURL:(NSURL *)URL {
	UIImage *circleImage = [MUCircleImageManager circleImageWithURL:URL];
	if (!circleImage) {
		[self sd_setImageWithURL:URL completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
			self.image = [MUCircleImageManager saveImage:image toCircleImageWithURL:imageURL];
		}];
	} else {
		self.image = circleImage;
	}
}

@end
