//
//  MUPath+NSFileManager.h
//  Tools
//
//  Created by 吴双 on 2017/8/8.
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

@property (nonatomic, strong, readonly) NSArray<MUPath *> *subpaths;

@property (nonatomic, strong) NSDictionary *attributes;

- (NSArray<MUPath *> *)subpathsWithPattern:(NSString *)pattern;

- (NSError *)createDirectoryWithCleanContents:(BOOL)contents;

- (NSError *)remove;

- (NSError *)removeSubpaths;

- (NSError *)copyTo:(MUPath *)destinationPath autoCover:(BOOL)autoCover;
- (NSError *)copyInTo:(MUPath *)distinationDirectoryPath autoCover:(BOOL)autoCover;

- (NSError *)moveTo:(MUPath *)destinationPath autoCover:(BOOL)autoCover;
- (NSError *)moveInTo:(MUPath *)distinationDirectoryPath autoCover:(BOOL)autoCover;

@end
