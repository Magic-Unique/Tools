//
//  MUMobileProvision.m
//  RingTone
//
//  Created by Shuang Wu on 2017/1/19.
//  Copyright © 2017年 Mia Tse. All rights reserved.
//

#import "MUMobileProvision.h"

static NSDictionary * mobileProvisionObjectWithContentsOfFile(NSString *file) {
	NSDictionary *dic = nil;
	
	NSString *embeddedPath = file;
	NSString *tempPath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"temp.plist"];
	
	if ([[NSFileManager defaultManager] fileExistsAtPath:embeddedPath]) {
		
		NSString *embeddedProvisioning = [NSString stringWithContentsOfFile:embeddedPath encoding:NSASCIIStringEncoding error:nil];
		
		NSRange headRange = [embeddedProvisioning rangeOfString:@"<plist"];
		NSRange footRange = [embeddedProvisioning rangeOfString:@"plist>"];
		NSRange enableRange = NSMakeRange(headRange.location, footRange.location + footRange.length - headRange.location);
		
		NSString *objStr = [embeddedProvisioning substringWithRange:enableRange];
		
		
		[objStr writeToFile:tempPath atomically:YES encoding:NSUTF8StringEncoding error:nil];
		dic = [NSDictionary dictionaryWithContentsOfFile:tempPath];
		[[NSFileManager defaultManager] removeItemAtPath:tempPath error:nil];
	}
	return dic;
}

@implementation MUMobileProvision

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
	self = [super init];
	if (self) {
#define SetVar(k) _##k = dictionary[@#k]
		SetVar(AppIDName);
		SetVar(ApplicationIdentifierPrefix);
		SetVar(CreationDate);
		SetVar(DeveloperCertificates);
		SetVar(ExpirationDate);
		SetVar(Name);
		SetVar(Platform);
		SetVar(ProvisionedDevices);
		SetVar(TeamIdentifier);
		SetVar(TeamName);
		SetVar(UUID);
#undef SetVar
		_Entitlements = [MUEntitlements entitlementsWithDictionary:dictionary[@"Entitlements"]];
		_TimeToLive = [dictionary[@"TimeToLive"] unsignedIntegerValue];
		_Version = [dictionary[@"Version"] unsignedIntegerValue];
	}
	return self;
}

+ (instancetype)localMobileProvision {
	return [self mobileProvisionWithContentsOfFile:[NSBundle.mainBundle pathForResource:@"embedded" ofType:@"mobileprovision"]];
}

+ (instancetype)mobileProvisionWithContentsOfFile:(NSString *)file {
	NSDictionary *obj = mobileProvisionObjectWithContentsOfFile(file);
	if (!obj) {
		return nil;
	}
	return [[self alloc] initWithDictionary:obj];
}

@end
