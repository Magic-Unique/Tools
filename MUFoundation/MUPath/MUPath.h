//
//  MUPath.h
//  WeChat
//
//  Created by Magic-Unique on 2017/8/7.
//
//

#import <Foundation/Foundation.h>

@interface MUPath : NSObject

@property (nonatomic, strong, readonly) NSString *string;
@property (nonatomic, strong, readonly) NSURL *fileURL;

@property (nonatomic, strong, readonly) MUPath *superpath;

@property (nonatomic, strong, readonly) NSString *pathExtension;
@property (nonatomic, strong, readonly) NSArray<NSString *> *pathComponents;
@property (nonatomic, strong, readonly) NSString *lastPathComponent;

- (instancetype)init;
+ (instancetype)path;

- (instancetype)initWithString:(NSString *)string;
+ (instancetype)pathWithString:(NSString *)string;

- (instancetype)initWithComponents:(NSArray<NSString *> *)components;
+ (instancetype)pathWithComponents:(NSArray<NSString *> *)components;

- (instancetype)subpathWithComponent:(NSString *)component;

@end
