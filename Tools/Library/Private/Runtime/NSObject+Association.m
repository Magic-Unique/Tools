//
//  NSObject+Association.m
//  Tools
//
//  Created by 吴双 on 16/8/28.
//  Copyright © 2016年 Unique. All rights reserved.
//

#import "NSObject+Association.h"
#import <objc/runtime.h>

typedef id(^PackageBlock)(void);

@implementation NSObject (Association)

#pragma mark - general

- (void)setAssociationObject:(id)object forKey:(NSString *)key association:(NSAssociation)association isAtomic:(BOOL)isAtomic {
	
	const void *cKey = (const void *)key.hash;
	
	objc_AssociationPolicy policy = isAtomic ? OBJC_ASSOCIATION_COPY_NONATOMIC : OBJC_ASSOCIATION_COPY;

	switch (association) {
		case NSAssociationAssign: {
			__unsafe_unretained id uuObj = object;
			objc_setAssociatedObject(self, cKey, ^{
				return uuObj;
			}, policy);
			break;
		}
		case NSAssociationWeak: {
			__weak id wObj = object;
			objc_setAssociatedObject(self, cKey, ^{
				return wObj;
			}, policy);
			break;
		}
		case NSAssociationCopy: {
			__strong id cObj = [object copy];
			objc_setAssociatedObject(self, cKey, ^{
				return cObj;
			}, policy);
			break;
		}
		case NSAssociationBaseValue:
		case NSAssociationRetain:
		case NSAssociationStrong: {
			__strong id sObj = object;
			objc_setAssociatedObject(self, cKey, ^{
				return sObj;
			}, policy);
			break;
		}
		default:
			break;
	}
}

- (id)associationObjectForKey:(NSString *)key {
	const void *cKey = (const void *)key.hash;
	PackageBlock block = objc_getAssociatedObject(self, cKey);
	return block?block():nil;
}

#pragma mark - Integer

- (void)setInteger:(NSInteger)integer forKey:(NSString *)key {
	NSNumber *number = [NSNumber numberWithInteger:integer];
	[self setAssociationObject:number forKey:key association:NSAssociationBaseValue isAtomic:YES];
}

- (NSInteger)integerForKey:(NSString *)key {
	NSNumber *number = [self associationObjectForKey:key];
	if ([number isKindOfClass:[NSNumber class]]) {
		return [number integerValue];
	} else {
		return 0;
	}
}

#pragma mark - Unsigned Integer

- (void)setUnsignedInteger:(NSUInteger)unsignedInteger forKey:(NSString *)key {
	NSNumber *number = [NSNumber numberWithUnsignedInteger:unsignedInteger];
	[self setAssociationObject:number forKey:key association:NSAssociationBaseValue isAtomic:YES];
}

- (NSUInteger)unsignedIntegerForKey:(NSString *)key {
	NSNumber *number = [self associationObjectForKey:key];
	if ([number isKindOfClass:[NSNumber class]]) {
		return [number unsignedIntegerValue];
	} else {
		return 0;
	}
}

#pragma mark - Double

- (void)setDouble:(double)doubleValue forKey:(NSString *)key {
	NSNumber *number = [NSNumber numberWithDouble:doubleValue];
	[self setAssociationObject:number forKey:key association:NSAssociationBaseValue isAtomic:YES];
}

- (double)doubleForKey:(NSString *)key {
	NSNumber *number = [self associationObjectForKey:key];
	if ([number isKindOfClass:[NSNumber class]]) {
		return [number doubleValue];
	} else {
		return 0;
	}
}

#pragma mark - BOOL

- (void)setBool:(BOOL)boolValue forKey:(NSString *)key {
	NSNumber *number = [NSNumber numberWithBool:boolValue];
	[self setAssociationObject:number forKey:key association:NSAssociationBaseValue isAtomic:YES];
}

- (BOOL)boolForKey:(NSString *)key {
	NSNumber *number = [self associationObjectForKey:key];
	if ([number isKindOfClass:[NSNumber class]]) {
		return [number boolValue];
	} else {
		return NO;
	}
}

#pragma mark - Size

- (void)setSize:(CGSize)size forKey:(NSString *)key {
	NSValue *value = [NSValue valueWithCGSize:size];
	[self setAssociationObject:value forKey:key association:NSAssociationBaseValue isAtomic:YES];
}

- (CGSize)sizeForKey:(NSString *)key {
	NSValue *value = [self associationObjectForKey:key];
	if ([value isKindOfClass:[NSValue class]]) {
		return [value CGSizeValue];
	} else {
		return CGSizeZero;
	}
}

#pragma mark - Point

- (void)setPoint:(CGPoint)point forKey:(NSString *)key {
	NSValue *value = [NSValue valueWithCGPoint:point];
	[self setAssociationObject:value forKey:key association:NSAssociationBaseValue isAtomic:YES];
}

- (CGPoint)pointForKey:(NSString *)key {
	NSValue *value = [self associationObjectForKey:key];
	if ([value isKindOfClass:[NSValue class]]) {
		return [value CGPointValue];
	} else {
		return CGPointZero;
	}
}

#pragma mark - Rect

- (void)setRect:(CGRect)rect forKey:(NSString *)key {
	NSValue *value = [NSValue valueWithCGRect:rect];
	[self setAssociationObject:value forKey:key association:NSAssociationBaseValue isAtomic:YES];
}

- (CGRect)rectForKey:(NSString *)key {
	NSValue *value = [self associationObjectForKey:key];
	if ([value isKindOfClass:[NSValue class]]) {
		return [value CGRectValue];
	} else {
		return CGRectZero;
	}
}

@end
