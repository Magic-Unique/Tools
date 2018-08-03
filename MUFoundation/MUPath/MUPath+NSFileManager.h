//
//  MUPath+NSFileManager.h
//  Tools
//
//  Created by Magic-Unique on 2017/8/8.
//  Copyright © 2017年 Unique. All rights reserved.
//

#import "MUPath.h"

typedef NS_ENUM(NSUInteger, MUPathType) {
	MUPathTypeNone,
	MUPathTypeFile,
	MUPathTypeDirectory,
};

@interface MUPath (NSFileManager)

@property (nonatomic, assign, readonly) MUPathType type;

@property (nonatomic, assign, readonly, getter=isExist) BOOL exist;

@property (nonatomic, assign, readonly, getter=isDirectory) BOOL directory;

@property (nonatomic, assign, readonly, getter=isFile) BOOL file;

@property (nonatomic, assign, readonly, getter=isReadable) BOOL readable;

@property (nonatomic, assign, readonly, getter=isWritable) BOOL writable;

@property (nonatomic, assign, readonly, getter=isExecutable) BOOL executable;

@property (nonatomic, assign, readonly, getter=isDeletable) BOOL deletable;

@property (nonatomic, strong, readonly) NSArray<MUPath *> *contents;
@property (nonatomic, strong, readonly) NSArray<MUPath *> *files;
@property (nonatomic, strong, readonly) NSArray<MUPath *> *directories;

@property (nonatomic, strong) NSDictionary *attributes;

- (NSUInteger)enumerateContentsUsingBlock:(void (^)(MUPath *content, BOOL *stop))block;
- (NSArray<MUPath *> *)contentsWithFilter:(BOOL (^)(MUPath *content))filter;
- (NSArray<MUPath *> *)contentsWithPattern:(NSString *)pattern;

- (NSError *)createDirectoryWithCleanContents:(BOOL)contents;

- (NSError *)remove;
- (NSError *)clean;

- (NSError *)copyTo:(MUPath *)destinationPath autoCover:(BOOL)autoCover;
- (NSError *)copyInto:(MUPath *)distinationDirectoryPath autoCover:(BOOL)autoCover;
- (NSError *)copyContentsInto:(MUPath *)distinationDirectoryPath autoCover:(BOOL)autoCover;

- (NSError *)moveTo:(MUPath *)destinationPath autoCover:(BOOL)autoCover;
- (NSError *)moveInto:(MUPath *)distinationDirectoryPath autoCover:(BOOL)autoCover;
- (NSError *)moveContentsInto:(MUPath *)distinationDirectoryPath autoCover:(BOOL)autoCover;

@end
