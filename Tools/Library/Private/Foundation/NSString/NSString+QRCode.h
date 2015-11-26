//
//  NSString+QRCode.h
//  BathCard
//
//  Created by yingxin on 15/7/23.
//  Copyright (c) 2015年 沈阳卡盟浴卡通. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (QRCode)

- (UIImage *)imageForQRCode:(CGFloat)width;

@end
