//
//  MUPath+NSFileManager.m
//  Tools
//
//  Created by Magic-Unique on 2017/8/8.
//  Copyright © 2017年 Unique. All rights reserved.
//

#import "MUPath+NSFileManager.h"
#import "MUPath+Path.h"

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

- (NSUInteger)enumerateContentsUsingBlock:(void (^)(MUPath *content, BOOL *stop))block {
    NSArray *components = nil;
    if (self.isDirectory) {
        components = [FileManager contentsOfDirectoryAtPath:self.string error:nil];
        if (block) {
            BOOL stop = NO;
            for (NSString *item in components) {
                MUPath *path = [self subpathWithComponent:item];
                block(path, &stop);
                if (stop) {
                    break;
                }
            }
        }
    }
    return components.count;
}

- (NSArray<MUPath *> *)contentsWithFilter:(BOOL (^)(MUPath *content))filter {
    NSMutableArray *contents = nil;
    if (self.isDirectory) {
        contents = [NSMutableArray array];
        [self enumerateContentsUsingBlock:^(MUPath *content, BOOL *stop) {
            if (filter == nil || filter(content)) {
                [contents addObject:content];
            }
        }];
    }
    return [contents copy];
}

- (NSArray<MUPath *> *)contents {
    return [self contentsWithFilter:nil];
}

- (NSArray<MUPath *> *)files {
    return [self contentsWithFilter:^BOOL(MUPath *content) {
        return content.isFile;
    }];
}

- (NSArray<MUPath *> *)directories {
    return [self contentsWithFilter:^BOOL(MUPath *content) {
        return content.isDirectory;
    }];
}

- (NSArray<MUPath *> *)contentsWithPattern:(NSString *)pattern {
    return [self contentsWithFilter:^BOOL(MUPath *content) {
        return [content isMatching:pattern];
    }];
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
				error = [self clean];
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

- (NSError *)clean {
	__block NSError *error = nil;
    [self enumerateContentsUsingBlock:^(MUPath *content, BOOL *stop) {
        error = [content remove];
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

- (NSError *)copyInto:(MUPath *)distinationDirectoryPath autoCover:(BOOL)autoCover {
    return [self copyTo:[distinationDirectoryPath subpathWithComponent:self.lastPathComponent]
              autoCover:autoCover];
}

- (NSError *)copyContentsInto:(MUPath *)distinationDirectoryPath autoCover:(BOOL)autoCover {
    __block NSError *error = nil;
    if (self.isDirectory == NO) {
        return error;
    }
    [self enumerateContentsUsingBlock:^(MUPath *content, BOOL *stop) {
        error = [content copyInto:distinationDirectoryPath autoCover:autoCover];
        *stop = error ? YES : NO;
    }];
    return error;
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

- (NSError *)moveInto:(MUPath *)distinationDirectoryPath autoCover:(BOOL)autoCover {
    return [self moveTo:[distinationDirectoryPath subpathWithComponent:self.lastPathComponent]
              autoCover:autoCover];
}

- (NSError *)moveContentsInto:(MUPath *)distinationDirectoryPath autoCover:(BOOL)autoCover {
    __block NSError *error = nil;
    if (self.isDirectory == NO) {
        return error;
    }
    [self enumerateContentsUsingBlock:^(MUPath *content, BOOL *stop) {
        error = [content moveInto:distinationDirectoryPath autoCover:autoCover];
        *stop = error ? YES : NO;
    }];
    return error;
}

@end
