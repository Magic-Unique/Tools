//
//  MUPath.m
//  WeChat
//
//  Created by 吴双 on 2017/8/7.
//
//

#import "MUPath.h"

@implementation MUPath

- (instancetype)initWithString:(NSString *)string {
	self = [super init];
	if (self) {
		NSMutableArray *componments = [string.pathComponents mutableCopy];
		NSString *firstObject = componments.firstObject;
		if ([firstObject isEqualToString:@"/"]) {
			[componments removeObjectAtIndex:0];
		}
		_pathComponents = [componments copy];
	}
	return self;
}

+ (instancetype)pathWithString:(NSString *)string {
	return [[self alloc] initWithString:string];
}

- (instancetype)initWithComponents:(NSArray<NSString *> *)components {
	self = [super init];
	if (self) {
		NSMutableArray *_components = [components mutableCopy];
		if ([_components.firstObject isEqualToString:@"/"]) {
			[_components removeObjectAtIndex:0];
		}
		_pathComponents = [_components copy];
	}
	return self;
}

+ (instancetype)pathWithComponents:(NSArray<NSString *> *)components {
	return [[self alloc] initWithComponents:components];
}

- (instancetype)subpathWithComponent:(NSString *)component {
	return [self.class pathWithComponents:[self.pathComponents arrayByAddingObject:component]];
}

- (MUPath *)superpath {
	if (self.pathComponents.count == 0) {
		return nil;
	} else {
		NSMutableArray *components = [self.pathComponents mutableCopy];
		[components removeLastObject];
		return [MUPath pathWithString:[components componentsJoinedByString:@"/"]];
	}
}

- (NSString *)string {
	NSString *string = [self.pathComponents componentsJoinedByString:@"/"];
	if ([string hasPrefix:@"/"]) {
		return string;
	} else {
		return [@"/" stringByAppendingString:string];
	}
}

- (NSString *)pathExtension {
	return self.pathComponents.lastObject.pathExtension;
}

- (NSString *)lastPathComponent {
	return self.pathComponents.lastObject;
}

@end
