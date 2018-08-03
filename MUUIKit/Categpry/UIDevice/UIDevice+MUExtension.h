//
//  UIDevice+MUExtension.h
//  RingTone
//
//  Created by TB-Mac-100 on 2016/12/14.
//  Copyright © 2016年 Mia Tse. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (MUExtension)

@property (nonatomic, strong, readonly) NSString *platform;

@property (nonatomic, strong, readonly) NSString *IDFA;

@property (nonatomic, strong, readonly) NSString *IDFV;

@property (nonatomic, strong, readonly) NSString *currentLanguage;

@property (nonatomic, strong, readonly) NSString *chipSerialNumber;

@property (nonatomic, assign, readonly) BOOL jailbreaked;

@end
