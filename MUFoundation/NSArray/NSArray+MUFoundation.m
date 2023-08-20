//
//  NSArray+MUFoundation.m
//  MUFoundation
//
//  Created by 吴双 on 2023/8/20.
//

#import "NSArray+MUFoundation.h"

@implementation NSArray (MUFoundation)

- (NSArray<id> * _Nonnull (^)(id  _Nonnull (^ _Nonnull)(id _Nonnull)))mu_map {
    return ^NSArray *(id (^block)(id)) {
        return [self mu_arrayByMap:block];
    };
}

- (NSArray<id> * _Nonnull (^)(NSArray<id> * _Nonnull (^ _Nonnull)(id _Nonnull)))mu_flatMap {
    return ^NSArray *(id (^block)(id)) {
        return [self mu_arrayByFlatMap:block];
    };
}
- (NSArray<id> * _Nonnull (^)(id  _Nullable (^ _Nonnull)(id _Nonnull)))mu_compactMap {
    return ^NSArray *(id (^block)(id)) {
        return [self mu_arrayByCompactMap:block];
    };
    
}

- (instancetype)mu_arrayByMap:(id (^)(id obj))mapBlock {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:self.count];
    for (id obj in self) {
        id map = mapBlock(obj);
        [array addObject:map];
    }
    return array;
}

- (instancetype)mu_arrayByFlatMap:(NSArray * _Nonnull (^)(id _Nonnull))mapBlock {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:self.count];
    for (id obj in self) {
        id map = mapBlock(obj);
        [array addObjectsFromArray:map];
    }
    return array;
}

- (instancetype)mu_arrayByCompactMap:(id (^)(id obj))mapBlock {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:self.count];
    for (id obj in self) {
        id map = mapBlock(obj);
        if (map) {
            [array addObject:map];
        }
    }
    return array;
}

- (NSArray<id> *)mu_arrayInPrefix:(NSUInteger)n {
    if (self.count >= n) {
        NSRange range = NSMakeRange(0, n);
        NSArray *first = [self subarrayWithRange:range];
        return first;
    } else {
        return self;
    }
}

- (NSArray<id> *)mu_arrayInSuffix:(NSUInteger)n {
    if (self.count >= n) {
        NSRange range = NSMakeRange(self.count - n, n);
        NSArray *last = [self subarrayWithRange:range];
        return last;
    } else {
        return self;
    }
}

- (NSArray<id> * _Nonnull (^)(BOOL (^ _Nonnull)(id _Nonnull)))mu_filter {
    return ^NSArray *(BOOL (^filter)(id)) {
        return [self mu_arrayByFilter:filter];
    };
}

- (NSArray<id> *)mu_arrayByFilter:(BOOL (^)(id))filter {
    NSMutableArray *array = [NSMutableArray array];
    for (id obj in self) {
        if (filter(obj)) {
            [array addObject:obj];
        }
    }
    return array;
}

- (id)mu_firstObjectByFilter:(BOOL (^)(id))filter {
    for (id obj in self) {
        if (filter(obj)) {
            return obj;
        }
    }
    return nil;
}

- (id (^)(id (^)(id, id)))mu_reduct {
    return ^id(id (^block)(id, id)) {
        return [self mu_reduct:block];
    };
}

- (id)mu_reduct:(id (^)(id, id))block {
    id result = nil;
    for (id obj in self) {
        result = block(result, obj);
    }
    return result;
}

@end



@implementation NSMutableArray (MUFoundation)

- (instancetype)mu_arrayByMap:(id  _Nonnull (^)(id _Nonnull))mapBlock {
    return [[super mu_arrayByMap:mapBlock] mutableCopy];
}

- (instancetype)mu_arrayByFlatMap:(NSArray * _Nonnull (^)(id _Nonnull))mapBlock {
    return [[super mu_arrayByFlatMap:mapBlock] mutableCopy];
}

- (instancetype)mu_arrayByCompactMap:(id (^)(id obj))mapBlock {
    return [[super mu_arrayByCompactMap:mapBlock] mutableCopy];
}

- (id)mu_dropFirst {
    id first = self.firstObject;
    if (first) {
        [self removeObjectAtIndex:0];
    }
    return first;
}

- (NSArray<id> *)mu_dropFirst:(NSUInteger)n {
    if (self.count >= n) {
        NSRange range = NSMakeRange(0, n);
        NSArray *first = [self subarrayWithRange:range];
        [self removeObjectsInRange:range];
        return first;
    } else {
        NSArray *list = [self copy];
        [self removeAllObjects];
        return list;
    }
}

- (id)mu_dropLast {
    id last = self.lastObject;
    if (last) {
        [self removeLastObject];
    }
    return last;
}

- (NSArray<id> *)mu_dropLast:(NSUInteger)n {
    if (self.count >= n) {
        NSRange range = NSMakeRange(self.count - n, n);
        NSArray *last = [self subarrayWithRange:range];
        [self removeObjectsInRange:range];
        return last;
    } else {
        NSArray *list = [self copy];
        [self removeAllObjects];
        return list;
    }
}

- (NSMutableArray<id> * _Nonnull (^)(BOOL (^ _Nonnull)(id _Nonnull)))mu_filt {
    return ^NSMutableArray *(BOOL (^block)(id)) {
        [self mu_filt:block];
        return self;
    };
}

- (void)mu_filt:(BOOL (^)(id))filter {
    for (NSUInteger i = 0; i < self.count; i++) {
        if (!filter(self[i])) {
            [self removeObjectAtIndex:i--];
        }
    }
}

@end


