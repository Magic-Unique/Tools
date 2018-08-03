//
//  MUVersion.m
//  DemoOC
//
//  Created by 冷秋 on 2017/8/15.
//  Copyright © 2017年 unique. All rights reserved.
//

#import "MUVersion.h"

@interface MUVersion ()

@property (nonatomic, strong, readonly) NSArray<NSString *> *components;

@end

@implementation MUVersion

- (instancetype)initWithString:(NSString *)string {
	self = [super init];
	if (self) {
		_components = [string componentsSeparatedByString:@"."];
	}
	return self;
}

+ (instancetype)versionWithString:(NSString *)string {
	return [[self alloc] initWithString:string];
}

- (BOOL)isLargeThen:(MUVersion *)version {
	if (![version isKindOfClass:[MUVersion class]]) {
		return NO;
	}
	NSComparisonResult result = [self compare:version];
	return result == NSOrderedDescending;
}

- (BOOL)isLessThan:(MUVersion *)version {
	if (![version isKindOfClass:[MUVersion class]]) {
		return NO;
	}
	NSComparisonResult result = [self compare:version];
	return result == NSOrderedAscending;
}

- (BOOL)isEqualTo:(MUVersion *)version {
	if (![version isKindOfClass:[MUVersion class]]) {
		return NO;
	}
	NSComparisonResult result = [self compare:version];
	return result == NSOrderedSame;
}

- (NSComparisonResult)compare:(MUVersion *)version {
	if (![version isKindOfClass:[MUVersion class]]) {
		return NSOrderedSame;
	}
	NSUInteger count = self.components.count;
	count = MAX(count, version.components.count);
	
	NSArray<NSString *> *selfComponents = [self componentsWithCount:count];
	NSArray<NSString *> *targComponents = [version componentsWithCount:count];
	
	for (int i = 0; i < count; i++) {
		NSInteger selfVersion = selfComponents[i].integerValue;
		NSInteger targVersion = targComponents[i].integerValue;
		if (selfVersion > targVersion) {
			return NSOrderedDescending;
		} else if (selfVersion < targVersion) {
			return NSOrderedAscending;
		} else {
			continue;
		}
	}
	
	return NSOrderedSame;
}

- (NSArray<NSString *> *)componentsWithCount:(NSUInteger)count {
	NSMutableArray *array = [self.components mutableCopy];
	if (array.count < count) {
		while (array.count < count) {
			[array addObject:@"0"];
		}
	} else if (array.count > count) {
		while (array.count > count) {
			[array removeLastObject];
		}
	}
	return [array copy];
}

- (NSInteger)versionAtIndex:(NSUInteger)index {
	if (index >= self.components.count) {
		return 0;
	} else {
		return self.components[index].integerValue;
	}
}

- (NSString *)stringValueWithCount:(NSUInteger)count {
	NSArray *components = [self componentsWithCount:count];
	return [components componentsJoinedByString:@"."];
}

- (NSInteger)mainVersion {
	return [self versionAtIndex:0];
}

- (NSInteger)childVersion {
	return [self versionAtIndex:1];
}

- (NSInteger)revisionVersion {
	return [self versionAtIndex:2];
}

- (NSInteger)builtVersion {
	return [self versionAtIndex:3];
}

@end
