//
//  NSString+HRLegal.m
//  Email
//
//  Created by 张文军 on 15/8/19.
//  Copyright (c) 2015年 hare. All rights reserved.
//

#import "NSString+HRLegal.h"

@implementation NSString (HRLegal)

/** 判断字符串本身是否为合法的qq*/
-(BOOL)isQQ{
    // 第一个为1-9后面跟上4-10个数字
    NSString *pattern = @"^[1-9]\\d{4,10}$";
    return [self match:pattern];
}

/** 判断字符串本身是否为合法的邮箱账号*/
-(BOOL)isEmail{
    
    // 邮箱首位只能是数字或字母，后面跟数字或字母或下滑线,加@加邮箱后缀
    NSString *pattern = @"^[A-Z0-9a-z]{1}[A-Z0-9a-z_]@(qq.com|sohu.com||163.com||163.net||126.com||188.com||139.com||qq.vip.com||hotmail.com||gmail.com||TOM.com||foxmail.com||sina.com||yahoo.com||yahoo.cn||msn.cn||live.com)$";
    return [self match:pattern];
}

/** 判断字符串本身是否为合法的手机号*/
-(BOOL)isPhoneNumber{
    // 第一位是1，第二位是3578中得一位，后面跟9位的数字
    return [self match:@"^1[3578]{1}\\d{9}$"];
}

/** 判断字符串本身是否为合法的ip地址*/
-(BOOL)isIPAddress{
    // 192.168.0.1
    NSString *pattern = @"^\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}$";
    return [self match:pattern];
}

/** 判断字符串本身是否为合法的URL*/
-(BOOL)isURL{
    // 192.168.0.1
    NSString *urlPattern = @"(http|ftp|https):\\/\\/[\\w\\-_]+(\\.[\\w\\-_]+)+([\\w\\-\\.,@?^=%&amp;:/~\\+#]*[\\w\\-\\@?^=%&amp;/~\\+#])?";
    return [self match:urlPattern];
}

/** 传入一个规则，判断自己是否符合这个规则*/
-(BOOL)match:(NSString *)pattern{
    
    NSPredicate *prediate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
    
    return [prediate evaluateWithObject:self];
}

/** 路径下所有文件的大小*/
-(NSInteger)fileSize{
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    // 是否是文件夹
    BOOL isDirectory;
    
    // 路径是否存在
    BOOL isExist = [fileManager fileExistsAtPath:self isDirectory:&isDirectory];
    
    // 如果文件不存在，就返回0；
    if (isExist == NO) {
        return 0;
    }
    
    // 如果不是文件夹，就说明是一个文件
    if (isDirectory == NO) {
        NSDictionary *attributes = [fileManager attributesOfItemAtPath:self error:nil];
        return [attributes[NSFileSize] integerValue];
    }
    
    // 能进到这一步，说明是一个文件夹，就遍历该目录下得所有文件路径
    NSArray *subPaths = [fileManager subpathsAtPath:self];
    
    NSInteger totalByteSize = 0;
    
    for (NSString *subPath in subPaths) {
        // 拼接成全路径
        NSString *fullSubPath = [self stringByAppendingPathComponent:subPath];
        [fileManager fileExistsAtPath:fullSubPath isDirectory:&isDirectory];
        // 如果不是文件夹，就说明是文件
        if (isDirectory == NO) {
            
            NSInteger fileSeze = [[fileManager attributesOfItemAtPath:fullSubPath error:nil][NSFileSize] integerValue];
            
            totalByteSize += fileSeze;
        }
    }
    return totalByteSize;
}

@end
