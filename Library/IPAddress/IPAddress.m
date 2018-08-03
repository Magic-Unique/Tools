//
//  IPAddress.m
//  Tools
//
//  Created by Magic_Unique on 15/8/25.
//  Copyright (c) 2015年 Unique. All rights reserved.
//

#import "IPAddress.h"
#include <arpa/inet.h>
#include <net/if.h>
#include <ifaddrs.h>

/*
 struct ifaddrs {
 struct ifaddrs  *ifa_next;
 char		*ifa_name;
 unsigned int	 ifa_flags;
 struct sockaddr	*ifa_addr;
 struct sockaddr	*ifa_netmask;
 struct sockaddr	*ifa_dstaddr;
 void		*ifa_data;
 };
 */

@implementation IPAddress

+ (NSArray *)localIPAddress
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSString *localIP = nil;
    struct ifaddrs *addrs;
    if (getifaddrs(&addrs)==0) {
        const struct ifaddrs *cursor = addrs;
        while (cursor != NULL) {
            if (cursor->ifa_addr->sa_family == AF_INET && (cursor->ifa_flags & IFF_LOOPBACK) == 0)
            {
//                [self printfIfaddrs:cursor];
                //NSString *name = [NSString stringWithUTF8String:cursor->ifa_name];
                //if ([name isEqualToString:@"en0"]) // Wi-Fi adapter
                {
                    localIP = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)cursor->ifa_addr)->sin_addr)];
                    if (![array containsObject:localIP]) {
                        [array addObject:localIP];
                    }
                }
            }
            cursor = cursor->ifa_next;
        }
        freeifaddrs(addrs);
    }
    return [array copy];
}

+ (NSArray *)localWiFiIPAddress {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSString *localIP = nil;
    struct ifaddrs *addrs;
    if (getifaddrs(&addrs)==0) {
        const struct ifaddrs *cursor = addrs;
        while (cursor != NULL) {
            if (cursor->ifa_addr->sa_family == AF_INET && (cursor->ifa_flags & IFF_LOOPBACK) == 0)
            {
                //                [self printfIfaddrs:cursor];
                NSString *name = [NSString stringWithUTF8String:cursor->ifa_name];
                if ([name isEqualToString:@"en0"]) // Wi-Fi adapter
                {
                    localIP = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)cursor->ifa_addr)->sin_addr)];
                    if (![array containsObject:localIP]) {
                        [array addObject:localIP];
                    }
                }
            }
            cursor = cursor->ifa_next;
        }
        freeifaddrs(addrs);
    }
    return [array copy];
}

+ (NSArray *)localGPRSIPAddress {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSString *localIP = nil;
    struct ifaddrs *addrs;
    if (getifaddrs(&addrs)==0) {
        const struct ifaddrs *cursor = addrs;
        while (cursor != NULL) {
            if (cursor->ifa_addr->sa_family == AF_INET && (cursor->ifa_flags & IFF_LOOPBACK) == 0)
            {
                //                [self printfIfaddrs:cursor];
                NSString *name = [NSString stringWithUTF8String:cursor->ifa_name];
                if ([name isEqualToString:@"en1"]) // Wi-Fi adapter
                {
                    localIP = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)cursor->ifa_addr)->sin_addr)];
                    if (![array containsObject:localIP]) {
                        [array addObject:localIP];
                    }
                }
            }
            cursor = cursor->ifa_next;
        }
        freeifaddrs(addrs);
    }
    return [array copy];
}

+ (NSArray *)localWANIPAddress {
    NSArray *array = [self localIPAddress];
    NSMutableArray *res = [[NSMutableArray alloc] initWithCapacity:array.count];
    for (int i = 0; i < array.count; i++) {
        NSString *ip = array[i];
        if (![ip hasPrefix:@"192.168."]) {
            [res addObject:ip];
        }
    }
    return [res copy];
}

+ (NSArray *)localLANIPAddress {
    NSArray *array = [self localIPAddress];
    NSMutableArray *res = [[NSMutableArray alloc] initWithCapacity:array.count];
    for (int i = 0; i < array.count; i++) {
        NSString *ip = array[i];
        if ([ip hasPrefix:@"192.168."]) {
            [res addObject:ip];
        }
    }
    return [res copy];
}

+ (void)printfIfaddrs:(const struct ifaddrs *)cursor {
    NSLog(@"\nStruct ifaddrs : {\n\tifa_name : %s\n\tifa_flags : %d\n}\t", cursor->ifa_name, cursor->ifa_flags);
}

@end
