//
//  MUVersion.h
//  DemoOC
//
//  Created by 吴双 on 2017/8/15.
//  Copyright © 2017年 unique. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MUVersion : NSObject

@property (nonatomic, strong, readonly) NSString *stringValue;

@property (nonatomic, assign, readonly) NSInteger mainVersion;
@property (nonatomic, assign, readonly) NSInteger childVersion;
@property (nonatomic, assign, readonly) NSInteger revisionVersion;
@property (nonatomic, assign, readonly) NSInteger builtVersion;

- (instancetype)initWithString:(NSString *)string;
+ (instancetype)versionWithString:(NSString *)string;

- (BOOL)isLargeThen:(MUVersion *)version;
- (BOOL)isLessThan:(MUVersion *)version;
- (BOOL)isEqualTo:(MUVersion *)version;

- (NSInteger)versionAtIndex:(NSUInteger)index;

- (NSString *)stringValueWithCount:(NSUInteger)count;

@end
