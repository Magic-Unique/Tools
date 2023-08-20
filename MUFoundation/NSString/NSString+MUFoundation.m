//
//  NSString+MUFoundation.m
//  MUFoundation
//
//  Created by 吴双 on 2023/8/20.
//

#import "NSString+MUFoundation.h"

@implementation NSString (MUFoundation)

- (MULines)mu_lines {
    return [self componentsSeparatedByString:@"\n"];
}

- (NSRange)mu_fullRange {
    return NSMakeRange(0, self.length);
}

- (NSString *)mu_trimmedString {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *(^)(NSString *))mu_removeIfHasPrefix {
    return ^NSString *(NSString *prefix) {
        return [self mu_removeIfHasPrefix:prefix];
    };
}

- (NSString *(^)(NSString *))mu_removeIfHasSuffix {
    return ^NSString *(NSString *suffix) {
        return [self mu_removeIfHasSuffix:suffix];
    };
}

- (NSString *)mu_removePrefix:(NSString *)prefix otherwise:(NSString *)defaultValue {
    if ([self hasPrefix:prefix]) {
        return [self substringFromIndex:prefix.length];
    }
    return defaultValue;
}

- (NSString *)mu_removeIfHasPrefix:(NSString *)prefix {
    return [self mu_removePrefix:prefix otherwise:self];
}

- (NSString *)mu_removeSuffix:(NSString *)suffix otherwise:(NSString *)defaultValue {
    if ([self hasSuffix:suffix]) {
        return [self substringToIndex:self.length - suffix.length];
    }
    return defaultValue;
}

- (NSString *)mu_removeIfHasSuffix:(NSString *)suffix {
    return [self mu_removeSuffix:suffix otherwise:self];
}

@end

@implementation NSMutableString (MUFoundation)

- (void)mu_trim {
    NSString *target = [self mu_trimmedString];
    [self replaceCharactersInRange:self.mu_fullRange withString:target];
}

- (void)mu_replace:(NSString *)string by:(NSString *)dist {
    NSString *target = [self stringByReplacingOccurrencesOfString:string withString:dist];
    [self replaceCharactersInRange:self.mu_fullRange withString:target];
}

@end
