//
//  MUCircleImageManager.m
//  KuBer
//
//  Created by 吴双 on 16/2/29.
//  Copyright © 2016年 huaxu. All rights reserved.
//

#import "MUCircleImageManager.h"
#import "NSString+Extension.h"

#define MUSharedCircleImageManager	[self sharedCircleImageManager]
#define MUSharedCircleImageBuffer	MUSharedCircleImageManager.imageBuffer

@interface MUCircleImageManager ()

@property (nonatomic, strong) NSMutableDictionary<NSString *, UIImage *> *imageBuffer;

@end

@implementation MUCircleImageManager

+ (MUCircleImageManager *)sharedCircleImageManager {
	static MUCircleImageManager *_sharedCircleImageManager = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		_sharedCircleImageManager = [self new];
	});
	return _sharedCircleImageManager;
}

#pragma mark - Public method

+ (UIImage *)circleImageWithURL:(NSURL *)URL {
	return MUSharedCircleImageBuffer[URL.absoluteString.MD5];
}

+ (UIImage *)saveImage:(UIImage *)image toCircleImageWithURL:(NSURL *)URL {
	UIImage *circleImage = [self createCircleImageWithImage:image];
	MUSharedCircleImageBuffer[URL.absoluteString.MD5] = circleImage;
	return circleImage;
}

+ (void)clearRAM {
	[MUSharedCircleImageBuffer removeAllObjects];
}

+ (void)clearROM {
	
}

#pragma mark - Private method

+ (UIImage *)createCircleImageWithImage:(UIImage *)image {
	CGSize CGImageSize = CGSizeMake(image.size.width * image.scale, image.size.height * image.scale);
	UIGraphicsBeginImageContext(CGImageSize);
	CGRect ovalRect = CGRectZero;
	ovalRect.size = CGImageSize;
	UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:ovalRect];
	[path addClip];
	[image drawInRect:ovalRect];
	UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	newImage = [UIImage imageWithCGImage:newImage.CGImage scale:image.scale orientation:UIImageOrientationUp];
	return newImage;
}

- (NSMutableDictionary<NSString *,UIImage *> *)imageBuffer {
	if (!_imageBuffer) {
		_imageBuffer = [NSMutableDictionary dictionary];
	}
	return _imageBuffer;
}

@end
