//
//  NSObject+Runtime.m
//  Tools
//
//  Created by 吴双 on 15/11/3.
//  Copyright © 2015年 Unique. All rights reserved.
//

#import "NSObject+Runtime.h"
#import "NSProperty.h"
#import <objc/runtime.h>

@implementation NSObject (Runtime)

+ (void)exchangeClassImplementFromMethod:(SEL)fromMethod toMethod:(SEL)toMethod {
	method_exchangeImplementations(class_getClassMethod(self, fromMethod), class_getClassMethod(self, toMethod));
}

+ (void)exchangeInstanceImplementFromMethod:(SEL)fromMethod toMethod:(SEL)toMethod {
	method_exchangeImplementations(class_getInstanceMethod(self, fromMethod), class_getInstanceMethod(self, toMethod));
}

+ (NSArray *)propertyList {
    NSMutableArray *propertyList = [NSMutableArray array];
    unsigned outCount;
    objc_property_t *properties = class_copyPropertyList(self, &outCount);
    for (int i = 0; i < outCount; i++) {
        const char *char_t = property_getAttributes(properties[i]);
        const char *char_n = property_getName(properties[i]);
        NSProperty *property = [NSProperty propertyWithPropertyName:char_n andPropertyAttributes:char_t];
        [propertyList addObject:property];
    }
    return [propertyList copy];
}

@end

