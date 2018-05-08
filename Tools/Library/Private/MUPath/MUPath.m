//
//  MUPath.m
//  WeChat
//
//  Created by 吴双 on 2017/8/7.
//
//

#import "MUPath.h"

static NSString *MUCurrentWorkDirectoryPath() {
    return [NSString stringWithUTF8String:getcwd(NULL, 0)];
}

static NSString *MUGetFullPathString(NSString *path) {
    if ([path hasPrefix:@"~"]) {
        path = [path stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:NSHomeDirectory()];
    }
    
    else if (![path hasPrefix:@"/"]) {
        path = [MUCurrentWorkDirectoryPath() stringByAppendingPathComponent:path];
    }
    
    NSMutableArray *folders = [NSMutableArray arrayWithArray:[path componentsSeparatedByString:@"/"]];
    
    NSMutableArray *formatFolders = [NSMutableArray array];
    for (NSString *folder in folders) {
        if (folder.length == 0) {
            continue;
        }
        
        if ([folder isEqualToString:@"."]) {
            continue;
        } else if ([folder isEqualToString:@".."]) {
            [formatFolders removeLastObject];
        } else {
            [formatFolders addObject:folder];
        }
    }
    
    NSString *fullPath = [formatFolders componentsJoinedByString:@"/"];
    return [@"/" stringByAppendingString:fullPath];
}

@implementation MUPath

- (instancetype)init {
    return self = [self initWithString:MUCurrentWorkDirectoryPath()];
}

+ (instancetype)path {
    return [[self alloc] init];
}

- (instancetype)initWithString:(NSString *)string {
	self = [super init];
	if (self) {
		NSMutableArray *componments = [string.pathComponents mutableCopy];
		NSString *firstObject = componments.firstObject;
		if ([firstObject isEqualToString:@"/"]) {
			[componments removeObjectAtIndex:0];
		}
		_pathComponents = [componments copy];
	}
	return self;
}

+ (instancetype)pathWithString:(NSString *)string {
    return [[self alloc] initWithString:MUGetFullPathString(string)];
}

- (instancetype)initWithComponents:(NSArray<NSString *> *)components {
	self = [super init];
	if (self) {
		NSMutableArray *_components = [components mutableCopy];
		if ([_components.firstObject isEqualToString:@"/"]) {
			[_components removeObjectAtIndex:0];
		}
		_pathComponents = [_components copy];
	}
	return self;
}

+ (instancetype)pathWithComponents:(NSArray<NSString *> *)components {
	return [[self alloc] initWithComponents:components];
}

- (instancetype)subpathWithComponent:(NSString *)component {
	return [self.class pathWithComponents:[self.pathComponents arrayByAddingObject:component]];
}

- (MUPath *)superpath {
	if (self.pathComponents.count == 0) {
		return nil;
	} else {
		NSMutableArray *components = [self.pathComponents mutableCopy];
		[components removeLastObject];
        return [MUPath pathWithComponents:components];
	}
}

- (NSString *)string {
	NSString *string = [self.pathComponents componentsJoinedByString:@"/"];
	if ([string hasPrefix:@"/"]) {
		return string;
	} else {
		return [@"/" stringByAppendingString:string];
	}
}

- (NSURL *)fileURL {
    return [NSURL fileURLWithPath:self.string];
}

- (NSString *)pathExtension {
	return self.lastPathComponent.pathExtension;
}

- (NSString *)lastPathComponent {
	return self.pathComponents.lastObject;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@ path=\"%@\">", self.class, self.string];
}

@end
