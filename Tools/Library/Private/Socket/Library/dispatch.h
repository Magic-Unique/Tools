//
//  dispatch.h
//  Socket
//
//  Created by 吴双 on 16/4/11.
//  Copyright © 2016年 unique. All rights reserved.
//

#ifndef dispatch_h
#define dispatch_h

#include <dispatch/dispatch.h>

dispatch_queue_t dispatch_queue_accept();
dispatch_queue_t dispatch_queue_read();
dispatch_queue_t dispatch_queue_opera();


void dispatch_async_opera(dispatch_block_t block);
void dispatch_async_read(dispatch_block_t block);
void dispatch_async_accept(dispatch_block_t block);

#endif /* dispatch_h */
