//
//  NSObject+MUTask.h
//  Tools
//
//  Created by Magic_Unique on 16/8/17.
//  Copyright © 2016年 unique. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (MUTask)

- (void)addDeallocTask:(void(^)(id wself, NSString *key))task forKey:(NSString *)key;

- (void)removeDeallocTaskForKey:(NSString *)key;

- (void)clearAllDeallocTask;

@end
