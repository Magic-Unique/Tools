

// 1 判断字符串本身是否为合法的qq
// 2 判断字符串本身是否为合法的邮箱账号
// 3 判断字符串本身是否为合法的手机号
// 4 判断字符串本身是否为合法的ip地址
// 5 判断字符串本身是否为合法的URL
// 6 计算一个路径下得所有文件的大小

#import <Foundation/Foundation.h>

@interface NSString (HRLegal)

/** 判断字符串本身是否为合法的qq*/
-(BOOL)isQQ;

/** 判断字符串本身是否为合法的邮箱账号*/
-(BOOL)isEmail;

/** 判断字符串本身是否为合法的手机号*/
-(BOOL)isPhoneNumber;

/** 判断字符串本身是否为合法的ip地址*/
-(BOOL)isIPAddress;

/** 判断字符串本身是否为合法的URL*/
-(BOOL)isURL;

/** 路径下所有文件的大小*/
-(NSInteger)fileSize;

@end
