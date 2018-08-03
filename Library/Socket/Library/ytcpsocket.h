//
//  ytcpsocket.h
//  TCP
//
//  Created by Magic_Unique on 15/8/20.
//  Copyright (c) 2015年 Unique. All rights reserved.
//

#ifndef TCP_ytcpsocket_h
#define TCP_ytcpsocket_h


void ytcpsocket_set_block(int socket,int on);
int ytcpsocket_connect(const char *host,int port,int timeout);
int ytcpsocket_close(int socketfd);
int ytcpsocket_pull(int socketfd,char *data,int len);
int ytcpsocket_send(int socketfd,const char *data,int len);
int ytcpsocket_listen(const char *addr,int port);
int ytcpsocket_accept(int onsocketfd,char *remoteip,int* remoteport);

#endif
