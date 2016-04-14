//
//  dispatch.c
//  Socket
//
//  Created by 吴双 on 16/4/11.
//  Copyright © 2016年 unique. All rights reserved.
//

#include "dispatch.h"

static dispatch_queue_t acceptQueue;
static dispatch_queue_t readQueue;
static dispatch_queue_t operaQueue;

dispatch_queue_t dispatch_queue_accept() {
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		acceptQueue = dispatch_queue_create("com.unique.socket.accept", DISPATCH_QUEUE_CONCURRENT);
	});
	return acceptQueue;
}

dispatch_queue_t dispatch_queue_read() {
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		readQueue = dispatch_queue_create("com.unique.socket.read", DISPATCH_QUEUE_CONCURRENT);
	});
	return readQueue;
}

dispatch_queue_t dispatch_queue_opera() {
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		operaQueue = dispatch_queue_create("com.unique.socket.opera", DISPATCH_QUEUE_SERIAL);
	});
	return operaQueue;
}




void dispatch_async_read(dispatch_block_t block) {
	dispatch_async(dispatch_queue_read(), block);
}

void dispatch_async_accept(dispatch_block_t block) {
	dispatch_async(dispatch_queue_accept(), block);
}

void dispatch_async_opera(dispatch_block_t block) {
	dispatch_async(dispatch_queue_opera(), block);
}