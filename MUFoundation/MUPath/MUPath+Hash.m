//
//  MUPath+Hash.m
//  MUFoundation
//
//  Created by Magic-Unique on 2017/8/8.
//

#import "MUPath+Hash.h"
#import "MUPath+NSFileManager.h"
#import <CommonCrypto/CommonDigest.h>

@implementation MUPath (Hash)

- (NSString *)MD5 {
    if (self.isFile == NO) {
        return nil;
    }
    
    NSFileHandle *handle = [NSFileHandle fileHandleForReadingAtPath:self.string];
    if (handle == nil) {
        return nil;
    }
    
    CC_MD5_CTX md5;
    CC_MD5_Init(&md5);
    while(YES) {
        @autoreleasepool {
            NSData *fileData = [handle readDataOfLength:256];
            CC_MD5_Update(&md5, [fileData bytes], (CC_LONG)[fileData length]);
            if (fileData.length == 0)
                break;
        }
    }
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5_Final(digest, &md5);
    NSString *s = [NSString stringWithFormat: @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                   digest[0], digest[1],
                   digest[2], digest[3],
                   digest[4], digest[5],
                   digest[6], digest[7],
                   digest[8], digest[9],
                   digest[10], digest[11],
                   digest[12], digest[13],
                   digest[14], digest[15]];
    return s;
}

@end
