//
//  MUFirstTime.m
//  MUFirstTime
//
//  Created by 吴双 on 16/1/5.
//  Copyright © 2016年 unique. All rights reserved.
//

#import "MUFirstTime.h"

#define MUUserDefaults	[NSUserDefaults standardUserDefaults]
#define MUKeyPrefix		@"com.unique.firsttime."
#define MUBundleVersion	@"CFBundleShortVersionString"

@implementation MUFirstTime

+ (BOOL)isFirstTimeForIdentifier:(NSString *)identifier {
	return [self isFirstTimeForIdentifier:identifier withAutoRecord:YES];
}

+ (BOOL)isFirstTimeForIdentifier:(NSString *)identifier withAutoRecord:(BOOL)autoRecord {
	NSString *key = [self keyForIdentifier:identifier];
	float bundleShortVersion = [self bundleShortVersion];
	float userDefaultVersion = [self userDefaultsShortVersionForKey:key];
	if (bundleShortVersion > userDefaultVersion) {
		if (autoRecord) {
			[self writeUserDefaultsShortVersion:bundleShortVersion forKey:key];
		}
		return YES;
	}
	return NO;
}

+ (void)clearFirstTimeRecordForIdentifier:(NSString *)identifier {
	NSString *key = [self keyForIdentifier:identifier];
	[MUUserDefaults removeObjectForKey:key];
	[MUUserDefaults synchronize];
}

+ (NSString *)currentVersion {
	return [NSBundle.mainBundle objectForInfoDictionaryKey:MUBundleVersion];
}

#pragma mark - Private Method

+ (NSString *)keyForIdentifier:(NSString *)identifier {
	return [MUKeyPrefix stringByAppendingString:identifier];
}

+ (float)bundleShortVersion {
	NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
	NSString *currentVersionString = infoDictionary[MUBundleVersion];
	return [currentVersionString floatValue];
}

+ (float)userDefaultsShortVersionForKey:(NSString *)key {
	return [MUUserDefaults floatForKey:key];
}

+ (void)writeUserDefaultsShortVersion:(float)shortVersion forKey:(NSString *)key {
	[MUUserDefaults setFloat:shortVersion forKey:key];
	[MUUserDefaults synchronize];
}

@end
