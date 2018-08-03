//
//  UIDevice+MUExtension.m
//  RingTone
//
//  Created by TB-Mac-100 on 2016/12/14.
//  Copyright © 2016年 Mia Tse. All rights reserved.
//

#import "UIDevice+MUExtension.h"

#include <sys/sysctl.h>
#import <AdSupport/AdSupport.h>
#import <dlfcn.h>

@implementation UIDevice (MUExtension)

- (NSString *)platform {
	size_t size;
	sysctlbyname("hw.machine", NULL, &size, NULL, 0);
	char *machine = (char *)malloc(size);
	sysctlbyname("hw.machine", machine, &size, NULL, 0);
	NSString *platform = [NSString stringWithCString:machine encoding: NSUTF8StringEncoding];
	free(machine);
	machine = NULL;
	if (!platform) {
		return @"";
	}
	return platform;
}

- (NSString *)IDFA {
	return ASIdentifierManager.sharedManager.advertisingIdentifier.UUIDString;
}

- (NSString *)IDFV {
	return self.identifierForVendor.UUIDString;
}

- (NSString *)currentLanguage {
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	NSArray *languages = [defaults objectForKey:@"AppleLanguages"];
	NSString *currentLanguage = [languages objectAtIndex:0];
	return currentLanguage;
}

- (BOOL)jailbreaked {
	return [[NSFileManager defaultManager] fileExistsAtPath:@"/private/var/lib/apt/"] && [[NSFileManager defaultManager] fileExistsAtPath:@"/Applications/Cydia.app"];
}

- (NSString *)chipSerialNumber {
	return nil;
}

@end
