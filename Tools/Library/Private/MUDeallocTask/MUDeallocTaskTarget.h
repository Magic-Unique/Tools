//
//  MUDeallocTaskTarget.h
//  Tools
//
//  Created by Magic_Unique on 16/8/17.
//  Copyright © 2016年 unique. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MUDeallocTaskTarget : NSObject

- (instancetype)initWithHostObject:(id)hostObject;
+ (instancetype)taskWithHostObject:(id)hostObject;

- (void)addDeallocTask:(void(^)(id obj, NSString *key))task forKey:(NSString *)key;

- (void)removeDeallocTaskForKey:(NSString *)key;

- (void)clearAllDeallocTask;

@end
