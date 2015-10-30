//
//  UDPAsyncSocket.m
//  
//
//  Created by Magic_Unique on 15/8/21.
//  Copyright (c) 2015年 Unique. All rights reserved.
//

#import "UDPAsyncSocket.h"
#import "yudpsocket.h"
#import "IPAddress.h"

@interface UDPAsyncSocket ()

@property (nonatomic, strong) NSThread *readThread;

@end

@implementation UDPAsyncSocket

#pragma mark - object method

- (BOOL)listen {
    if (self.fd > 0) {
        return NO;
    }
    if (!self.readThread) {
        const char *addr = [self.addr cStringUsingEncoding:NSUTF8StringEncoding];
        int fd = yudpsocket_server(addr, self.port);
        if (fd > 0) {
            self.fd = fd;
            NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(readThreadMethod) object:nil];
            self.readThread = thread;
            [thread start];
            return YES;
        }
        return NO;
    }
    return NO;
}

- (BOOL)close {
    self.readThread = nil;
    if (self.fd > 0) {
        yudpsocket_close(self.fd);
        self.fd = 0;
        return YES;
    } else {
        return NO;
    }
}

- (BOOL)sendData:(NSData *)data toAddr:(NSString *)addr withPort:(int)port {
    if (data && addr && port > 0) {
        char *bytes = malloc([NSSocket maxLengthOfData]);
        [data getBytes:bytes length:data.length];
        [self sendBytes:bytes withLength:data.length toAddr:addr withPort:port];
        free(bytes);
        return YES;
    }
    return NO;
}

- (BOOL)sendString:(NSString *)string toAddr:(NSString *)addr withPort:(int)port {
    if (string && addr && port > 0) {
        const char *bytes = [string cStringUsingEncoding:NSUTF8StringEncoding];
        [self sendBytes:bytes withLength:[NSSocket maxLengthOfData] toAddr:addr withPort:port];
        return YES;
    }
    return NO;
}

#pragma mark - class method


+ (NSString *)errMsg:(int)errCode {
    switch (errCode) {
        case -1:
            return @"LISTEN:Listen faild";
        case -2:
            return @"CLOSE:Socket not open";
        default:
            return @"Unknow error";
    }
}

#pragma mark - private method

- (BOOL)sendBytes:(const char *)bytes withLength:(NSUInteger)length toAddr:(NSString *)addr withPort:(int)port {
    
    //新建一个ip的buff
    char *remoteIPBuff = malloc(16);
    memset(remoteIPBuff, 0, 16);
    
    //转换目标ip
    const char *conAddr = [addr cStringUsingEncoding:NSUTF8StringEncoding];
    
    //检测目标ip
    int ret = yudpsocket_get_server_ip(conAddr, remoteIPBuff);
    if (ret == 0) {
        int fd = yudpsocket_client();
        if (self.fd > 0) {
            int sendSize = yudpsocket_sentto(fd, bytes, (int)length, remoteIPBuff, port);
            if (sendSize > 0) {
                yudpsocket_close(fd);
                free(remoteIPBuff);
                return YES;
            }
        }
    }
    free(remoteIPBuff);
    return NO;
    
}


- (void)readThreadMethod {
    while (self.fd > 0) {
        char *buff = malloc([NSSocket maxLengthOfData]);
        memset(buff, 0, [NSSocket maxLengthOfData]);
        char *remoteIPBuff = malloc(16);
        memset(remoteIPBuff, 0, 16);
        int remotePort = 0;
        int readLength = yudpsocket_recive(self.fd, buff, [NSSocket maxLengthOfData], remoteIPBuff, &remotePort);
        int port = remotePort;
        NSString *addr = [NSString stringWithUTF8String:remoteIPBuff];
        if (readLength <= 0) {
            free(buff);
            free(remoteIPBuff);
            continue;
        }
        NSData *data = [NSData dataWithBytes:buff length:[NSSocket maxLengthOfData]];
        if ([self.delegate respondsToSelector:@selector(socket:didReceiveData:fromSocket:)]) {
            UDPAsyncSocket *source = [UDPAsyncSocket socketWithAddr:addr andPort:port];
            __weak UDPAsyncSocket *selfSocket = self;
            dispatch_async(dispatch_get_main_queue(), ^{
                [selfSocket.delegate socket:selfSocket didReceiveData:data fromSocket:source];
            });
        }
        free(buff);
        free(remoteIPBuff);
    }
    self.readThread = nil;
}

#pragma mark - super method




@end
