//
//  MUCircleImageManager.h
//  KuBer
//
//  Created by 吴双 on 16/2/29.
//  Copyright © 2016年 huaxu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MUCircleImageManager : NSObject

+ (UIImage *)circleImageWithURL:(NSURL *)URL;

+ (UIImage *)saveImage:(UIImage *)image toCircleImageWithURL:(NSURL *)URL;

+ (void)clearROM;
+ (void)clearRAM;

@end
