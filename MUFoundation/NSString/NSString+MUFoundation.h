//
//  NSString+MUFoundation.h
//  MUFoundation
//
//  Created by 吴双 on 2023/8/20.
//

#import <Foundation/Foundation.h>

typedef NSString *MULine;
typedef NSArray<MULine> *MULines;


@interface NSString (MUFoundation)

@property (readonly) MULines mu_lines;

@property (readonly) NSRange mu_fullRange;

@property (readonly) NSString *mu_trimmedString;

@property (readonly) NSString *(^mu_removeIfHasPrefix)(NSString *prefix);
@property (readonly) NSString *(^mu_removeIfHasSuffix)(NSString *suffix);

@end





@interface NSMutableString (MUFoundation)

- (void)mu_trim;

- (void)mu_replace:(NSString *)string by:(NSString *)dist;

@end
