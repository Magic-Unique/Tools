//
//  MUPath+Path.m
//  Tools
//
//  Created by Magic-Unique on 2017/8/8.
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

- (BOOL)isMatching:(NSString *)pattern {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    return [predicate evaluateWithObject:self.lastPathComponent];
}

@end
