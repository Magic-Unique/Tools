//
//  NSObject+Association.h
//  Tools
//
//  Created by 吴双 on 16/8/28.
//  Copyright © 2016年 Unique. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, NSAssociation) {
	NSAssociationBaseValue,
	NSAssociationAssign,
	NSAssociationWeak,
	NSAssociationRetain,
	NSAssociationStrong,
	NSAssociationCopy,
};


@interface NSObject (Association)

- (void)setAssociationObject:(id)object
					  forKey:(NSString *)key
				 association:(NSAssociation)association
					isAtomic:(BOOL)isAtomic;
- (id)associationObjectForKey:(NSString *)key;


- (void)setInteger:(NSInteger)integer forKey:(NSString *)key;
- (NSInteger)integerForKey:(NSString *)key;


- (void)setUnsignedInteger:(NSUInteger)unsignedInteger
					forKey:(NSString *)key;
- (NSUInteger)unsignedIntegerForKey:(NSString *)key;


- (void)setDouble:(double)doubleValue forKey:(NSString *)key;
- (double)doubleForKey:(NSString *)key;


- (void)setBool:(BOOL)boolValue forKey:(NSString *)key;
- (BOOL)boolForKey:(NSString *)key;


- (void)setSize:(CGSize)size forKey:(NSString *)key;
- (CGSize)sizeForKey:(NSString *)key;


- (void)setPoint:(CGPoint)point forKey:(NSString *)key;
- (CGPoint)pointForKey:(NSString *)key;

- (void)setRect:(CGRect)rect forKey:(NSString *)key;
- (CGRect)rectForKey:(NSString *)key;

@end
