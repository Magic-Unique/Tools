//
//  NSObject+Runtime.h
//  Tools
//
//  Created by 吴双 on 15/11/3.
//  Copyright © 2015年 Unique. All rights reserved.
//

#import <Foundation/Foundation.h>


@class NSProperty;

@interface NSObject (Runtime)

+ (void)exchangeInstanceImplementFromMethod:(SEL)fromMethod toMethod:(SEL)toMethod;

+ (void)exchangeClassImplementFromMethod:(SEL)fromMethod toMethod:(SEL)toMethod;

+ (NSArray *)propertyList;

+ (NSArray *)IvarList;

+ (NSArray *)protocolList;

@end
