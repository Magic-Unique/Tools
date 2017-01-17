//
//  MUKeychain.h
//  RingTone
//
//  Created by TB-Mac-100 on 2016/12/13.
//  Copyright © 2016年 Mia Tse. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MUKeychain : NSObject

+ (void)setKeychainValue:(id)value forKey:(NSString *)key;

+ (id)keychainValueForKey:(NSString *)key;

+ (void)removeKeychainValueForKey:(NSString *)key;

@end
