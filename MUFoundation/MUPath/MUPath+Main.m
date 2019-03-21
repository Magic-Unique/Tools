//
//  MUPath.m
//  WeChat
//
//  Created by Magic-Unique on 2017/8/7.
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
    NSArray *components = [self.pathComponents arrayByAddingObjectsFromArray:[component componentsSeparatedByString:@"/"]];
	return [self.class pathWithComponents:components];
}

- (instancetype)pathByReplacingPathExtension:(NSString *)pathExtension {
    NSString *path = self.string;
    path = path.stringByDeletingPathExtension;
    path = [path stringByAppendingPathExtension:pathExtension];
    return [self.class pathWithString:path];
}

- (instancetype)pathByReplacingLastPathComponent:(NSString *)lastPathComponent {
    NSString *path = self.string;
    if ([path isEqualToString:@"/"]) {
        return nil;
    }
    path = path.stringByDeletingLastPathComponent;
    path = [path stringByAppendingPathComponent:lastPathComponent];
    return [self.class pathWithString:path];
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

- (NSString *)relativeStringToPath:(MUPath *)path {
    NSMutableArray *selfComponents = [self.pathComponents mutableCopy];
    NSMutableArray *pathComponents = [path.pathComponents mutableCopy];
    while (selfComponents.count && pathComponents.count) {
        NSString *selfComponent = selfComponents.firstObject;
        NSString *pathComponent = pathComponents.firstObject;
        if ([selfComponent isEqualToString:pathComponent]) {
            [selfComponents removeObjectAtIndex:0];
            [pathComponents removeObjectAtIndex:0];
            continue;
        } else {
            break;
        }
    }
    NSMutableArray *components = [NSMutableArray array];
    for (NSUInteger i = 0; i < pathComponents.count; i++) {
        [components addObject:@".."];
    }
    [components addObjectsFromArray:selfComponents];
    return [components componentsJoinedByString:@"/"];
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
