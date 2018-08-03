//
//  MUPath+Sandbox.h
//  WeChat
//
//  Created by Magic-Unique on 2017/8/8.
//
//

#import "MUPath.h"

@interface MUPath (Sandbox)

+ (instancetype)homePath;

+ (instancetype)documentsPath;

+ (instancetype)cachesPath;

+ (instancetype)libraryPath;

+ (instancetype)tempPath;

+ (instancetype)mainBundlePath;

+ (instancetype)infoPlistPath;

@end
