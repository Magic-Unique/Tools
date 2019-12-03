//
//  MUPath+File.m
//  MUFoundation
//
//  Created by Magic-Unique on 2017/8/8.
//

#import "MUPath+File.h"
#import "MUPath+NSFileManager.h"

@implementation MUPath (File)

- (NSDictionary *)dictionary {
    if (self.isFile) {
        return [NSDictionary dictionaryWithContentsOfFile:self.string];
    }
    return nil;
}

- (NSArray *)array {
    if (self.isFile) {
        return [NSArray arrayWithContentsOfFile:self.string];
    }
    return nil;
}

@end
