//
//  NSProperty.m
//  RuntimeTest
//
//  Created by 吴双 on 15/11/5.
//  Copyright © 2015年 吴双. All rights reserved.
//

#import "NSProperty.h"

@interface NSProperty ()

@property (nonatomic, copy) NSString *attributes;

@end

@implementation NSProperty

- (instancetype)initWithPropertyName:(const char *)name andPropertyAttributes:(const char *)attributes {
    self = [super init];
    if (self) {
        _key = [NSString stringWithUTF8String:name];
        _attributes = [NSString stringWithUTF8String:attributes];
        NSLog(@"%s", attributes);
    }
    return self;
}

+ (instancetype)propertyWithPropertyName:(const char *)name andPropertyAttributes:(const char *)attributes {
    return [[self alloc] initWithPropertyName:name andPropertyAttributes:attributes];
}

- (BOOL)nonatomic {
    return [self hasChar:@"N"];
}

- (BOOL)atomic {
    return !self.nonatomic;
}

- (BOOL)copy {
    return [self hasChar:@"C"];
}

- (BOOL)mrcRetain {
    return [self hasChar:@"&"];
}

- (BOOL)arcStrong {
    return self.mrcRetain;
}

- (BOOL)weak {
    return [self hasChar:@"W"];
}

- (BOOL)readonly {
    return [self hasChar:@"R"];
}

- (NSString *)getter {
    NSRange range = [self.attributes rangeOfString:@",G"];
    if (range.length == 0) {
        return self.key;
    } else {
        NSArray *array = [self.attributes componentsSeparatedByString:@","];
        for (NSString *str in array) {
            if ([str hasPrefix:@"G"]) {
                return [str substringFromIndex:1];
            }
        }
        return self.key;
    }
}

- (NSString *)setter {
    NSRange range = [self.attributes rangeOfString:@",S"];
    if (range.length == 0) {
        return [self defaultSetter];
    } else {
        NSArray *array = [self.attributes componentsSeparatedByString:@","];
        for (NSString *str in array) {
            if ([str hasPrefix:@"S"]) {
                return [str substringFromIndex:1];
            }
        }
        return [self defaultSetter];
    }
}

- (BOOL)baseType {
    return !self.object;
}

- (BOOL)object {
    return [self.attributes rangeOfString:@"@"].length > 0;
}

- (NSString *)valueType {
    NSString *attributeType = [self.attributes componentsSeparatedByString:@","].firstObject;
    
    if (self.baseType) {
        NSDictionary *dict = @{
            @"B":@"BOOL",
            @"i":@"int",    @"I":@"unsigned int",
            @"q":@"long",   @"Q":@"unsigned long",
            @"f":@"float",
            @"d":@"double",
        };
        NSString *key = [self.attributes substringWithRange:NSMakeRange(1, attributeType.length - 1)];
        if ([key rangeOfString:@"{"].length == 0) {
            return dict[key];
        } else {
            NSRange rangeOfD = [key rangeOfString:@"="];
            return [key substringWithRange:NSMakeRange(1, rangeOfD.location-1)];
        }
    } else {
        NSString *type = [attributeType componentsSeparatedByString:@"@"].lastObject;
        if ([type isEqualToString:@""]) {
            return @"id";
        } else {
            return [type substringWithRange:NSMakeRange(1, type.length - 2)];
        }
    }
}

- (NSString *)defaultSetter {
    NSString *firstChar = [self.key substringToIndex:1];
    NSString *followString = [self.key substringFromIndex:1];
    char c = firstChar.UTF8String[0];
    if (c >= 'a' && c <= 'z') {
        c += 'A' - 'a';
    }
    return [NSString stringWithFormat:@"set%c%@:", c, followString];
}

- (BOOL)hasChar:(NSString *)c {
    NSString *str = [NSString stringWithFormat:@",%@,", c];
    return [self.attributes rangeOfString:str].length > 0;
}

@end
