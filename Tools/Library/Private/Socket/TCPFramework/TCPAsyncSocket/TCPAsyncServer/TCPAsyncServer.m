//
//  TCPAsyncServer.m
//  TCP
//
//  Created by Magic_Unique on 15/8/20.
//  Copyright (c) 2015年 Unique. All rights reserved.
//

#import "TCPAsyncServer.h"
#import "ytcpsocket.h"
#import "TCPAsyncClient_Extension.h"

@interface TCPAsyncServer () <TCPAsyncClientDelegate>

@property (nonatomic, strong) NSThread *acceptThread;
@property (nonatomic, strong) NSMutableArray *clientArray;

@end

@implementation TCPAsyncServer

- (NSMutableArray *)clientArray
{
    if (!_clientArray) {
        _clientArray = [[NSMutableArray alloc] init];
    }
    return _clientArray;
}

- (BOOL)listen {
    if (self.fd > 0) {
        return NO;
    }
    int fd = ytcpsocket_listen([self.addr cStringUsingEncoding:NSUTF8StringEncoding], self.port);
    
    if (fd > 0) {
        self.fd = fd;
        [self startAccept];
        return YES;
    } else {
        return NO;
    }
}

- (TCPAsyncClient *)accept {
    if (self.fd > 0) {
        int serverFd = self.fd;
        char buff[16] = {0};//255.255.255.255
        int port = 0;
        int clientfd = ytcpsocket_accept(serverFd, buff, &port);
        if (clientfd < 0) {
            return nil;
        } else {
            NSString *addr = [NSString stringWithUTF8String:buff];
            TCPAsyncClient *client = [TCPAsyncClient clientByServerWithAddr:addr andPort:port andFd:clientfd];
            client.delegate = self;
            if ([self.delegate respondsToSelector:@selector(server:didReceiveClient:)]) {
                __weak TCPAsyncServer *selfServer = self;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [selfServer.delegate server:selfServer didReceiveClient:client];
                });
            }
            return client;
        }
    }
    return nil;
}

- (BOOL)close {
    int fd = self.fd;
    self.acceptThread = nil;
    self.fd = 0;
    if (fd > 0) {
        ytcpsocket_close(fd);
        return YES;
    }
    return NO;
}

- (int)sendData:(NSData *)data toClient:(TCPAsyncClient *)client {
    int count = 0;
    for (int i = 0; i < self.clientArray.count; i++) {
        TCPAsyncClient *temp = self.clientArray[i];
        if (client) {
            if ([client isEqual:temp]) {
                if ([temp sendData:data] == 0) {
                    count++;
                }
            }
        } else {
            if ([temp sendData:data] == 0) {
                count++;
            }
        }
    }
    return count;
}

- (int)sendString:(NSString *)string toClient:(TCPAsyncClient *)client {
    int count = 0;
    for (int i = 0; i < self.clientArray.count; i++) {
        TCPAsyncClient *temp = self.clientArray[i];
        NSLog(@"%@", temp);
        if (client) {
            if ([client isEqual:temp]) {
                if ([temp sendString:string] == 0) {
                    count++;
                }
            }
        } else {
            if ([temp sendString:string] == 0) {
                count++;
            }
        }
    }
    return count;
}

- (BOOL)breakClient:(TCPAsyncClient *)client {
    for (int i = 0; i < self.clientArray.count; i++) {
        TCPAsyncClient *temp = self.clientArray[i];
        if ([client isEqual:temp]) {
            [temp close];
            [self.clientArray removeObjectAtIndex:i];
            return YES;
        }
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

- (void)startAccept {
    if (!self.acceptThread) {
        self.acceptThread = [[NSThread alloc] initWithTarget:self selector:@selector(acceptThreadMethod) object:nil];
        [self.acceptThread start];
    }
}

- (void)acceptThreadMethod {
    while (self.fd > 0) {
        TCPAsyncClient *client = [self accept];
        if (!client) {
            break;
        }
        [self.clientArray addObject:client];
    }
    [self close];
}

#pragma mark - TCPAsyncClientDelegate

- (void)client:(TCPAsyncClient *)client didReceiveData:(NSData *)data {
    if ([self.delegate respondsToSelector:@selector(server:didReceiveData:fromClient:)]) {
        __weak TCPAsyncServer *selfServer = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            [selfServer.delegate server:selfServer didReceiveData:data fromClient:client];
        });
        
    }
}

- (void)clientDidBrokeByServer:(TCPAsyncClient *)client {
    if ([self.delegate respondsToSelector:@selector(server:didBrokeByClient:)]) {
        __weak TCPAsyncServer *selfServer = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            [selfServer.delegate server:selfServer didBrokeByClient:client];
            [selfServer.clientArray removeObject:client];
        });
        
    }
}

@end
