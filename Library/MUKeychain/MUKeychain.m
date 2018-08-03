//
//  MUKeychain.m
//  RingTone
//
//  Created by TB-Mac-100 on 2016/12/13.
//  Copyright © 2016年 Mia Tse. All rights reserved.
//

#import "MUKeychain.h"
#import <Security/Security.h>

@implementation MUKeychain

+ (NSMutableDictionary *)getKeychainQuery:(NSString *)service {
	return [NSMutableDictionary dictionaryWithObjectsAndKeys:
			(id)kSecClassGenericPassword,(id)kSecClass,
			service, (id)kSecAttrService,
			service, (id)kSecAttrAccount,
			(id)kSecAttrAccessibleAfterFirstUnlock,(id)kSecAttrAccessible,
			nil];
}

+ (void)setKeychainValue:(id)value forKey:(NSString *)key {
	//Get search dictionary
	NSMutableDictionary *keychainQuery = [self getKeychainQuery:key];
	//Delete old item before add new item
	SecItemDelete((CFDictionaryRef)keychainQuery);
	//Add new object to search dictionary(Attention:the data format)
	[keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:value] forKey:(id)kSecValueData];
	//Add item to keychain with the search dictionary
	SecItemAdd((CFDictionaryRef)keychainQuery, NULL);
}

+ (id)keychainValueForKey:(NSString *)key {
	id ret = nil;
	NSMutableDictionary *keychainQuery = [self getKeychainQuery:key];
	//Configure the search setting
	//Since in our simple case we are expecting only a single attribute to be returned (the password) we can set the attribute kSecReturnData to kCFBooleanTrue
	[keychainQuery setObject:(id)kCFBooleanTrue forKey:(id)kSecReturnData];
	[keychainQuery setObject:(id)kSecMatchLimitOne forKey:(id)kSecMatchLimit];
	CFDataRef keyData = NULL;
	if (SecItemCopyMatching((CFDictionaryRef)keychainQuery, (CFTypeRef *)&keyData) == noErr) {
		@try {
			ret = [NSKeyedUnarchiver unarchiveObjectWithData:(NSData *)CFBridgingRelease(keyData)];
		} @catch (NSException *e) {
			NSLog(@"Unarchive of %@ failed: %@", key, e);
		} @finally {
		}
	}
	if (keyData)
//		CFRelease(keyData);
	return ret;
}

+ (void)removeKeychainValueForKey:(NSString *)key {
	NSMutableDictionary *keychainQuery = [self getKeychainQuery:key];
	SecItemDelete((CFDictionaryRef)keychainQuery);
}

@end
