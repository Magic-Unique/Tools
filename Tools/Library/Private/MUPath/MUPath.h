//
//  MUPath.h
//  WeChat
//
//  Created by 吴双 on 2017/8/7.
//
//

#import <Foundation/Foundation.h>

@interface MUPath : NSObject

@property (nonatomic, strong, readonly) NSString *absolutePath;

@property (nonatomic, weak, readonly) MUPath *superpath;

@property (nonatomic, strong, readonly) NSString *pathExtension;
@property (nonatomic, strong, readonly) NSArray<NSString *> *pathComponents;
@property (nonatomic, strong, readonly) NSString *lastPathComponent;

- (instancetype)initWithString:(NSString *)string;
+ (instancetype)pathWithString:(NSString *)string;

- (instancetype)initWithComponents:(NSArray<NSString *> *)components;
+ (instancetype)pathWithComponents:(NSArray<NSString *> *)components;

- (instancetype)subpathWithComponent:(NSString *)component;

@end
