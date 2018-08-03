//
//  MUPath+Sandbox.m
//  WeChat
//
//  Created by 吴双 on 2017/8/8.
//
//

#import "MUPath+Sandbox.h"

@implementation MUPath (Sandbox)

+ (instancetype)homePath {
	return [self pathWithString:NSHomeDirectory()];
}

+ (instancetype)documentsPath {
	return [self pathWithString:NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject];
}

+ (instancetype)libraryPath	 {
	return [self pathWithString:NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).firstObject];
}

+ (instancetype)tempPath {
	return [self pathWithString:NSTemporaryDirectory()];
}

+ (instancetype)cachesPath {
	return [self pathWithString:NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject];
}

+ (instancetype)mainBundlePath {
	return [self pathWithString:NSBundle.mainBundle.bundlePath];
}

+ (instancetype)infoPlistPath {
	return [self pathWithString:[NSBundle.mainBundle.bundlePath stringByAppendingPathComponent:@"Info.plist"]];
}

@end
