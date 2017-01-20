//
//  MUMobileProvision.h
//  RingTone
//
//  Created by Shuang Wu on 2017/1/19.
//  Copyright © 2017年 Mia Tse. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MUEntitlements.h"

@interface MUMobileProvision : NSObject

@property (nonatomic, copy) NSString *AppIDName;

@property (nonatomic, copy) NSArray<NSString *> *ApplicationIdentifierPrefix;

@property (nonatomic, copy) NSString *CreationDate;

@property (nonatomic, copy) NSArray<NSData *> *DeveloperCertificates;

@property (nonatomic, copy) MUEntitlements *Entitlements;

@property (nonatomic, copy) NSString *ExpirationDate;

@property (nonatomic, copy) NSString *Name;

@property (nonatomic, copy) NSArray<NSString *> *Platform;

/** Enable in Development */
@property (nonatomic, copy) NSArray<NSString *> *ProvisionedDevices;

@property (nonatomic, copy) NSArray<NSString *> *TeamIdentifier;

@property (nonatomic, copy) NSString *TeamName;

@property (nonatomic, assign) NSUInteger TimeToLive;

@property (nonatomic, copy) NSString *UUID;

@property (nonatomic, assign) NSUInteger Version;

+ (instancetype)localMobileProvision;

+ (instancetype)mobileProvisionWithContentsOfFile:(NSString *)file;

@end
