//
//  MUDeallocTaskTarget.m
//  Tools
//
//  Created by Magic_Unique on 16/8/17.
//  Copyright © 2016年 unique. All rights reserved.
//

#import "MUDeallocTaskTarget.h"

@interface MUDeallocTaskTarget ()
{
    __unsafe_unretained id _hostObject;
}

@property (nonatomic, strong) NSMutableDictionary<NSString *, void (^)(id obj, NSString *key)> *taskBuffer;

@end




@implementation MUDeallocTaskTarget

- (instancetype)initWithHostObject:(id)hostObject {
    self = [super init];
    if (self) {
        _hostObject = hostObject;
    }
    return self;
}

+ (instancetype)taskWithHostObject:(id)hostObject {
    return [self.alloc initWithHostObject:hostObject];
}

- (void)addDeallocTask:(void (^)(id obj, NSString *key))task forKey:(NSString *)key {
    self.taskBuffer[[key copy]] = [task copy];
}

- (void)removeDeallocTaskForKey:(NSString *)key {
    [_taskBuffer removeObjectForKey:key];
    if (_taskBuffer.count == 0) {
        _taskBuffer = nil;
    }
}

- (NSArray<NSString *> *)allDeallocTaskKeys {
	return self.taskBuffer.allKeys;
}

- (void)clearAllDeallocTask {
    _taskBuffer = nil;
}

- (NSMutableDictionary *)taskBuffer {
    if (!_taskBuffer) {
        _taskBuffer = [NSMutableDictionary dictionary];
    }
    return _taskBuffer;
}

- (void)dealloc {
    id hostObj = _hostObject;
    for (NSString *key in _taskBuffer.allKeys) {
        void(^task)(id obj, NSString *) = _taskBuffer[key];
        !task?:task(hostObj, key);
    }
}

@end
