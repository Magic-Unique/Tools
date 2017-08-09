//
//  MUPath+Path.h
//  Tools
//
//  Created by 吴双 on 2017/8/8.
//  Copyright © 2017年 Unique. All rights reserved.
//

#import "MUPath.h"

@interface MUPath (Path)

- (BOOL)is:(NSString *)name;

- (BOOL)isA:(NSString *)pathExtension;

- (BOOL)isLike:(NSString *)pattern;

@end
