//
//  MUPath+Path.h
//  Tools
//
//  Created by Magic-Unique on 2017/8/8.
//  Copyright © 2017年 Unique. All rights reserved.
//

#import "MUPath.h"

@interface MUPath (Path)

- (BOOL)is:(NSString *)name;

- (BOOL)isA:(NSString *)pathExtension;

- (BOOL)isMatching:(NSString *)pattern;

@end
