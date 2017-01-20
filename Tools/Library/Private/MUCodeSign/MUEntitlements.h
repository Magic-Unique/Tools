//
//  MUEntitlements.h
//  RingTone
//
//  Created by Shuang Wu on 2017/1/19.
//  Copyright © 2017年 Mia Tse. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MUEntitlements : NSObject

@property (nonatomic, copy) NSString *ApplicationIdentifier;

/** Enable for APNs */
@property (nonatomic, copy) NSString *APsEnvironment;

/** Enable in Production */
@property (nonatomic, assign) BOOL BetaReportsActive;

@property (nonatomic, copy) NSString *AppleDeveloperTeamIdentifier;

@property (nonatomic, assign) BOOL GetTaskAllow;

@property (nonatomic, copy) NSArray<NSString *> *KeychainAccessGroups;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
+ (instancetype)entitlementsWithDictionary:(NSDictionary *)dictionary;

@end
