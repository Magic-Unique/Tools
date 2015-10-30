//
//  NSSocket.h
//
//
//  Created by Magic_Unique on 15/8/20.
//  Copyright (c) 2015年 Unique. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSSocket : NSObject


@property (nonatomic, strong) NSString *addr;

@property (nonatomic, assign) int port;

@property (nonatomic, assign) int fd;


/**
 *  设置本地缓冲区的最大长度
 *
 *  @param length 最大长度
 */
+ (void)setMaxLengthOfData:(int)length;

/**
 *  获取本地缓冲区的最大长度
 *
 *  @return 最大长度
 */
+ (int)maxLengthOfData;

/**
 *  创建一个绑定地址和端口的Socket
 *
 *  @param addr 地址
 *  @param port 端口
 *
 *  @return Socket
 */
- (instancetype)initWithAddr:(NSString *)addr andPort:(NSUInteger)port;

/**
 *  创建一个地址为127.0.0.1的Socket
 *
 *  @param port 端口
 *
 *  @return Socket
 */
- (instancetype)initWithLocalPort:(NSUInteger)port;

/**
 *  创建一个地址开头为192.168.***.***的Socket, Lan地址不存在, 则地址为127.0.0.1
 *
 *  @param port 端口
 *
 *  @return Socket
 */
- (instancetype)initWithLanPort:(NSUInteger)port;

+ (instancetype)socketWithAddr:(NSString *)addr andPort:(NSUInteger)port;
+ (instancetype)socketWithLocalPort:(NSUInteger)port;
+ (instancetype)socketWithLanPort:(NSUInteger)port;

+ (NSString *)stringWithUTF8Data:(NSData *)data;
+ (NSString *)stringWithGBKData:(NSData *)data;


@end
