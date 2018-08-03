//
//  NSProperty.h
//  RuntimeTest
//
//  Created by 吴双 on 15/11/5.
//  Copyright © 2015年 吴双. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Config.h"


@interface NSProperty : NSObject

@property (nonatomic, strong, readonly) NSString *key;

@property (nonatomic, assign, readonly) BOOL nonatomic;

@property (nonatomic, assign, readonly) BOOL atomic;

@property (nonatomic, assign, readonly) BOOL copy;

@property (nonatomic, assign, readonly) BOOL mrcRetain;

@property (nonatomic, assign, readonly) BOOL arcStrong;

@property (nonatomic, assign, readonly) BOOL weak;

@property (nonatomic, assign, readonly) BOOL readonly;

@property (nonatomic, strong, readonly) NSString *getter;

@property (nonatomic, strong, readonly) NSString *setter;

//value type
@property (nonatomic, assign, readonly) BOOL baseType;// Struct & BaseType

@property (nonatomic, assign, readonly) BOOL object;

@property (nonatomic, strong, readonly) NSString *valueType;

- (instancetype)initWithPropertyName:(const char *)name andPropertyAttributes:(const char *)attributes;
+ (instancetype)propertyWithPropertyName:(const char *)name andPropertyAttributes:(const char *)attributes;

@end
