//
//  MUPath+NSFileManager.m
//  Tools
//
//  Created by 吴双 on 2017/8/8.
//  Copyright © 2017年 Unique. All rights reserved.
//

#import "MUPath+NSFileManager.h"

#define FileManager [NSFileManager defaultManager]

@implementation MUPath (NSFileManager)

- (MUPathType)type {
	BOOL isDirectory = NO;
	if ([FileManager fileExistsAtPath:self.string isDirectory:&isDirectory]) {
		return isDirectory ? MUPathTypeDirectory : MUPathTypeFile;
	} else {
		return MUPathTypeNone;
	}
}

- (BOOL)isExist {
	return self.type != MUPathTypeNone;
}

- (BOOL)isDirectory {
	return self.type == MUPathTypeDirectory;
}

- (BOOL)isFile {
	return self.type == MUPathTypeFile;
}

- (BOOL)isReadable {
	return [FileManager isReadableFileAtPath:self.string];
}

- (BOOL)isWritable {
	return [FileManager isWritableFileAtPath:self.string];
}

- (BOOL)isExecutable {
	return [FileManager isExecutableFileAtPath:self.string];
}

- (BOOL)isDeletable {
	return [FileManager isDeletableFileAtPath:self.string];
}

- (NSArray<MUPath *> *)subpaths {
	if (self.isDirectory) {
		NSArray *subpathComponent = [FileManager contentsOfDirectoryAtPath:self.string error:nil];
		NSMutableArray<MUPath *> *subpaths = [NSMutableArray arrayWithCapacity:subpathComponent.count];
		for (NSString *subpath in subpathComponent) {
			[subpaths addObject:[self subpathWithComponent:subpath]];
		}
		return [subpaths copy];
	} else {
		return nil;
	}
}

- (NSArray<MUPath *> *)subpathsWithPattern:(NSString *)pattern {
	if (self.isDirectory) {
		NSArray *subpathComponent = [FileManager contentsOfDirectoryAtPath:self.string error:nil];
		NSMutableArray<MUPath *> *subpaths = [NSMutableArray arrayWithCapacity:subpathComponent.count];
		NSRegularExpression *regular = [NSRegularExpression regularExpressionWithPattern:pattern options:1 error:nil];
		if (regular) {
			for (NSString *subpath in subpathComponent) {
				if ([regular matchesInString:subpath options:1 range:NSMakeRange(0, subpath.length)].count) {
					[subpaths addObject:[self subpathWithComponent:subpath]];
				}
			}
			return [subpaths copy];
		}
	}
	return nil;
}

- (NSDictionary *)attributes {
	if (self.exist) {
		return [FileManager attributesOfItemAtPath:self.string error:nil];
	} else {
		return nil;
	}
}

- (void)setAttributes:(NSDictionary *)attributes {
	[FileManager setAttributes:attributes ofItemAtPath:self.string error:nil];
}

- (NSError *)createDirectoryWithCleanContents:(BOOL)cleanContents {
	NSError *error = nil;
	if (self.isExist) {
		if (self.isDirectory) {
			if (cleanContents) {
				error = [self removeSubpaths];
				if (error) {
					return error;
				}
			} else {
				return nil;
			}
		}
		error = [self remove];
		if (error) {
			return error;
		}
	}
	[FileManager createDirectoryAtPath:self.string withIntermediateDirectories:YES attributes:nil error:&error];
	return error;
}

- (NSError *)remove {
	NSError *error = nil;
	if (self.isExist) {
		[FileManager removeItemAtPath:self.string error:&error];
	}
	return error;
}

- (NSError *)removeSubpaths {
	__block NSError *error = nil;
	[self.subpaths enumerateObjectsUsingBlock:^(MUPath * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
		error = [obj remove];
		if (error) {
			*stop = YES;
		}
	}];
	return error;
}

- (NSError *)copyTo:(MUPath *)destinationPath autoCover:(BOOL)autoCover {
	NSError *error = nil;
	if (destinationPath.isExist) {
		if (autoCover) {
			error = [destinationPath remove];
			if (error) {
				return error;
			}
		}
	}
	[FileManager copyItemAtPath:self.string toPath:destinationPath.string error:&error];
	return error;
}

- (NSError *)copyInTo:(MUPath *)distinationDirectoryPath autoCover:(BOOL)autoCover {
    return [self copyTo:[distinationDirectoryPath subpathWithComponent:self.lastPathComponent]
              autoCover:autoCover];
}

- (NSError *)moveTo:(MUPath *)destinationPath autoCover:(BOOL)autoCover {
	NSError *error = nil;
	if (destinationPath.isExist) {
		if (autoCover) {
			error = [destinationPath remove];
			if (error) {
				return error;
			}
		}
	}
	[FileManager moveItemAtPath:self.string toPath:destinationPath.string error:&error];
	return error;
}

- (NSError *)moveInTo:(MUPath *)distinationDirectoryPath autoCover:(BOOL)autoCover {
    return [self moveTo:[distinationDirectoryPath subpathWithComponent:self.lastPathComponent]
              autoCover:autoCover];
}

@end
