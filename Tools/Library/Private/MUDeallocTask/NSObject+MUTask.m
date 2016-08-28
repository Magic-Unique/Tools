//
//  NSObject+MUTask.m
//  Tools
//
//  Created by Magic_Unique on 16/8/17.
//  Copyright © 2016年 unique. All rights reserved.
//

#import "NSObject+MUTask.h"
#import "MUDeallocTaskTarget.h"
#import <objc/runtime.h>

@implementation NSObject (MUTask)

- (MUDeallocTaskTarget *)deallocTaskTarget {
    MUDeallocTaskTarget *target = objc_getAssociatedObject(self, "deallocTaskTarget");
    if (!target) {
        target = [MUDeallocTaskTarget taskWithHostObject:self];
        objc_setAssociatedObject(self, "deallocTaskTarget", target, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return target;
}

- (void)addDeallocTask:(void (^)(id, NSString *))task forKey:(NSString *)key {
    [self.deallocTaskTarget addDeallocTask:task forKey:key];
}

- (void)removeDeallocTaskForKey:(NSString *)key {
    MUDeallocTaskTarget *deallocTaskTarget = objc_getAssociatedObject(self, "deallocTaskTarget");
    [deallocTaskTarget removeDeallocTaskForKey:key];
}

- (void)clearAllDeallocTask {
    [self.deallocTaskTarget clearAllDeallocTask];
}

@end
