//
//  NSDate+Extension.m
//  KuBer
//
//  Created by 吴双 on 15/12/4.
//  Copyright © 2015年 huaxu. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)

- (NSUInteger)year {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy";
    formatter.timeZone = [NSTimeZone localTimeZone];
    return [[formatter stringFromDate:self] intValue];
}

- (NSUInteger)month {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"MM";
    formatter.timeZone = [NSTimeZone localTimeZone];
    return [[formatter stringFromDate:self] intValue];
}

- (NSUInteger)day {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"dd";
    formatter.timeZone = [NSTimeZone localTimeZone];
    return [[formatter stringFromDate:self] intValue];
}

- (NSUInteger)hour {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"HH";
    formatter.timeZone = [NSTimeZone localTimeZone];
    return [[formatter stringFromDate:self] intValue];
}

- (NSUInteger)min {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"mm";
    formatter.timeZone = [NSTimeZone localTimeZone];
    return [[formatter stringFromDate:self] intValue];
}

- (NSUInteger)second {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"ss";
    formatter.timeZone = [NSTimeZone localTimeZone];
    return [[formatter stringFromDate:self] intValue];
}

@end
