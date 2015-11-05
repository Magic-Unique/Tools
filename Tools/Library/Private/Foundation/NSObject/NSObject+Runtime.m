//
//  NSObject+Runtime.m
//  Tools
//
//  Created by 吴双 on 15/11/3.
//  Copyright © 2015年 Unique. All rights reserved.
//

#import "NSObject+Runtime.h"
#import <objc/runtime.h>

@implementation NSObject (Runtime)

+ (void)swapInstanceSourceMethod:(SEL)sourceMethod withTargetMethod:(SEL)targetMethod {
    method_exchangeImplementations(class_getInstanceMethod(self, sourceMethod), class_getInstanceMethod(self, targetMethod));
}

+ (void)swapClassSourceMethod:(SEL)sourceMethod withTargetMethod:(SEL)targetMethod {
    method_exchangeImplementations(class_getClassMethod(self, sourceMethod), class_getClassMethod(self, targetMethod));
}

- (void)setAssociatedObject:(id)object forKey:(NSString *)key withAssociationMode:(NSObjectAssociationMode)mode {
    [self willChangeValueForKey:key];
    objc_setAssociatedObject(self, key.UTF8String, object, (objc_AssociationPolicy)mode);
    [self didChangeValueForKey:key];
}

- (id)associatedObjectForKey:(NSString *)key {
    return objc_getAssociatedObject(self, key.UTF8String);
}

+ (NSDictionary<NSString *, Class> *)propertyList {
    NSMutableDictionary<NSString *, Class> *list = [NSMutableDictionary new];
    unsigned outCount;
    objc_property_t *properties = class_copyPropertyList(self, &outCount);
    for (int i = 0; i < outCount; i++) {
        const char *char_t = property_getAttributes(properties[i]);
        NSLog(@"%s", char_t);
    }
    return list;
}

@end
