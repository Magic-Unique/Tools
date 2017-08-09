//
//  MUPath+Path.m
//  Tools
//
//  Created by 吴双 on 2017/8/8.
//  Copyright © 2017年 Unique. All rights reserved.
//

#import "MUPath+Path.h"

@implementation MUPath (Path)

- (BOOL)is:(NSString *)name {
	return [self.lastPathComponent.lowercaseString isEqualToString:name.lowercaseString];
}

- (BOOL)isA:(NSString *)pathExtension {
	return [self.pathExtension.lowercaseString isEqualToString:pathExtension.lowercaseString];
}

- (BOOL)isLike:(NSString *)pattern {
	NSRegularExpression *regular = [NSRegularExpression regularExpressionWithPattern:pattern options:1 error:nil];
	NSString *lastPathComponent= self.lastPathComponent;
	if ([regular matchesInString:lastPathComponent options:1 range:NSMakeRange(0, lastPathComponent.length)].count > 0) {
		return YES;
	} else {
		return NO;
	}
}

@end
