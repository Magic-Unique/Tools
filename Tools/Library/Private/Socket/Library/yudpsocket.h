//
//  yudpsocket.h
//  UDPFactory
//
//  Created by Magic_Unique on 15/8/21.
//  Copyright (c) 2015年 Unique. All rights reserved.
//

#ifndef UDPFactory_yudpsocket_h
#define UDPFactory_yudpsocket_h

int yudpsocket_server(const char *addr,int port);
int yudpsocket_recive(int socket_fd,char *outdata,int expted_len,char *remoteip,int* remoteport);
int yudpsocket_close(int socket_fd);
//return socket fd
int yudpsocket_client();
int yudpsocket_get_server_ip(const char *host,char *ip);
//send message to addr and port
int yudpsocket_sentto(int socket_fd,const char *msg,int len, const char *toaddr, int topotr);


#endif
