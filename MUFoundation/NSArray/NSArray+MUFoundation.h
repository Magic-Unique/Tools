//
//  NSArray+MUFoundation.h
//  MUFoundation
//
//  Created by 吴双 on 2023/8/20.
//

#import <Foundation/Foundation.h>

@interface NSArray<ObjectType> (MUFoundation)


@property (readonly, nonnull) NSArray<id> * _Nonnull(^mu_map)(id _Nonnull (^_Nonnull block)(id _Nonnull obj));
- (instancetype _Nonnull)mu_arrayByMap:(id _Nonnull(^_Nonnull)(ObjectType _Nonnull obj))mapBlock;

@property (readonly, nonnull) NSArray<id> * _Nonnull(^mu_flatMap)(NSArray<id> * _Nonnull(^_Nonnull block)(id _Nonnull obj));
- (instancetype _Nonnull)mu_arrayByFlatMap:(NSArray * _Nonnull(^_Nonnull)(ObjectType _Nonnull obj))mapBlock;

@property (readonly, nonnull) NSArray<id> * _Nonnull(^mu_compactMap)(id _Nullable (^_Nonnull block)(id _Nonnull obj));
- (instancetype _Nonnull)mu_arrayByCompactMap:(id _Nullable(^_Nonnull)(ObjectType _Nonnull obj))mapBlock;

- (NSArray<ObjectType> * _Nonnull)mu_arrayInPrefix:(NSUInteger)n;
- (NSArray<ObjectType> * _Nonnull)mu_arrayInSuffix:(NSUInteger)n;

@property (readonly, nonnull) NSArray<ObjectType> * _Nonnull(^mu_filter)(BOOL (^_Nonnull filter)(id _Nonnull obj));
- (NSArray<ObjectType> * _Nonnull)mu_arrayByFilter:(BOOL (^_Nonnull)(ObjectType _Nonnull object))filter;

- (ObjectType _Nullable)mu_firstObjectByFilter:(BOOL (^_Nonnull)(ObjectType _Nonnull object))filter;

@property (readonly, nonnull) id _Nullable (^mu_reduct)(id _Nullable (^_Nonnull)(id _Nullable, ObjectType _Nonnull));
- (id _Nullable)mu_reduct:(id _Nullable (^_Nonnull)(id _Nullable, ObjectType _Nonnull))block;

@end



@interface NSMutableArray<ObjectType> (MUFoundation)

@property (readonly, nullable) ObjectType mu_dropFirst;
- (NSArray<ObjectType> * _Nonnull)mu_dropFirst:(NSUInteger)n;

@property (readonly, nullable) ObjectType mu_dropLast;
- (NSArray<ObjectType> * _Nonnull)mu_dropLast:(NSUInteger)n;

@property (readonly, nonnull) NSMutableArray<ObjectType> * _Nonnull(^mu_filt)(BOOL (^_Nonnull filter)(id _Nonnull obj));
- (void)mu_filt:(BOOL (^_Nonnull)(ObjectType _Nonnull object))filter;

@end


