//
//  TCPSyncClient.m
//  Tools
//
//  Created by Magic_Unique on 15/9/16.
//  Copyright (c) 2015年 Unique. All rights reserved.
//

#import "TCPSyncClient.h"
#import "ytcpsocket.h"

@implementation TCPSyncClient

- (BOOL)connect:(int)timeout {
    if (self.fd > 0) {
        return NO;
    }
    int rs = ytcpsocket_connect([self.addr cStringUsingEncoding:NSUTF8StringEncoding], self.port, timeout);
    if (rs > 0) {
        self.fd = rs;
        return YES;
    } else {
        return NO;
    }
}

- (BOOL)connectToAddr:(NSString *)addr withPort:(NSUInteger)port andTimeout:(int)timeout {
    if (self.fd > 0) {
        return NO;
    }
    int rs = ytcpsocket_connect([addr cStringUsingEncoding:NSUTF8StringEncoding], (int)port, timeout);
    if (rs > 0) {
        self.addr = addr;
        self.port = (int)port;
        self.fd = rs;
        return YES;
    } else {
        return NO;
    }
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

- (BOOL)sendData:(NSData *)data {
    if (self.fd > 0) {
        int fd = self.fd;
        
        char *buff = malloc([NSSocket maxLengthOfData]);
        memset(buff, 0, [NSSocket maxLengthOfData]);
        
        int length = (int)data.length;
        [data getBytes:buff length:data.length];
        
        int sendsize = ytcpsocket_send(fd, buff, length);
        
        free(buff);
        
        if (sendsize == length) {
            return YES;
        } else {
            return NO;
        }
    } else {
        return NO;
    }
}

- (BOOL)sendString:(NSString *)string {
    if (self.fd > 0) {
        int fd = self.fd;
        const char *buff = [string cStringUsingEncoding:NSUTF8StringEncoding];
        int length = (int)strlen(buff);
        int sendsize = ytcpsocket_send(fd, buff, length);
        if (sendsize == length) {
            return YES;
        } else {
            return NO;
        }
    } else {
        return NO;
    }
}

- (NSData *)read:(int)expectLength {
    NSData *data = nil;
    if (self.fd) {
        int fd = self.fd;
        
        char *buff = malloc([NSSocket maxLengthOfData]);
        memset(buff, 0, [NSSocket maxLengthOfData]);
        
        int readLen = ytcpsocket_pull(fd, buff, expectLength);
        
        if (readLen > 0) {
            data = [NSData dataWithBytes:buff length:readLen];
        }
        
        free(buff);
    }
    return data;
}

+ (NSString *)errMsg:(int)errCode {
    switch (errCode) {
        case 0:
            return @"Succeed";
        case -1:
            return @"CONNECT:Qeury server fail";
        case -2:
            return @"CONNECT:Connection closed";
        case -3:
            return @"CONNECT:Connect timeout";
        case -4:
            return @"CLOSE:Socket not open";
        case -5:
            return @"SEND:Socket not open";
        case -6:
            return @"SEND:Send error";
        default:
            return @"Unknow error";
    }
}

#pragma mark - private method

// This method will be used by a TCPServer when someone connect it. And auto start read thread.
+ (instancetype)clientByServerWithAddr:(NSString *)addr andPort:(int)port andFd:(int)fd {
    TCPSyncClient *client = [[self alloc] initWithAddr:addr andPort:port];
    if (fd > 0) {
        client.fd = fd;
    }
    return client;
}

//- (void)startReadThread {
//    if (self.readThread) {
//        return;
//    } else if (self.fd > 0){
//        self.readThread = [[NSThread alloc] initWithTarget:self selector:@selector(readThreadMothod) object:nil];
//        [self.readThread start];
//    }
//}

//- (void)readThreadMothod {
//    while (self.fd > 0) {
//        
//        NSData *data = [self read:[NSSocket maxLengthOfData]];
//        if (!data) {
//            if ([self.delegate respondsToSelector:@selector(clientDidBrokeByServer:)] && self.fd > 0) {
//                __weak TCPAsyncClient *selfClient = self;
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    [selfClient.delegate clientDidBrokeByServer:selfClient];
//                });
//            }
//            break;
//        }
//        if ([self.delegate respondsToSelector:@selector(client:didReceiveData:)]) {
//            __weak TCPAsyncClient *selfClient = self;
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [selfClient.delegate client:selfClient didReceiveData:data];
//            });
//        }
//    }
//    [self close];
//}


@end
