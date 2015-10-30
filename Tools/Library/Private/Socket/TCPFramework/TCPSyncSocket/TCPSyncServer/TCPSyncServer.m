//
//  TCPSyncServer.m
//  Tools
//
//  Created by Magic_Unique on 15/9/16.
//  Copyright (c) 2015年 Unique. All rights reserved.
//

#import "TCPSyncServer.h"
#import "TCPSyncClient_Extension.h"
#import "ytcpsocket.h"

@implementation TCPSyncServer

- (BOOL)listen {
    if (self.fd > 0) {
        return NO;
    }
    int fd = ytcpsocket_listen([self.addr cStringUsingEncoding:NSUTF8StringEncoding], self.port);
    
    if (fd > 0) {
        self.fd = fd;
        return YES;
    } else {
        return NO;
    }
}

- (TCPSyncClient *)accept {
    if (self.fd > 0) {
        int serverFd = self.fd;
        char buff[16] = {0};//255.255.255.255
        int port = 0;
        int clientfd = ytcpsocket_accept(serverFd, buff, &port);
        if (clientfd < 0) {
            return nil;
        } else {
            NSString *addr = [NSString stringWithUTF8String:buff];
            TCPSyncClient *client = [TCPSyncClient clientByServerWithAddr:addr andPort:port andFd:clientfd];
            return client;
        }
    }
    return nil;
}

- (BOOL)close {
    int fd = self.fd;
    self.fd = 0;
    if (fd > 0) {
        ytcpsocket_close(fd);
        return YES;
    }
    return NO;
}



+ (NSString *)errMsg:(int)errCode {
    switch (errCode) {
        case -1:
            return @"listen fail";
        case -2:
            return @"socket not open";
        default:
            return @"Unknow error";
    }
}

#pragma mark - private method




@end
