//
//  MUSocketConst.h
//  Socket
//
//  Created by 吴双 on 16/4/12.
//  Copyright © 2016年 unique. All rights reserved.
//

#ifndef MUSocketConst_h
#define MUSocketConst_h

#import <Foundation/Foundation.h>

typedef void(^OperaCompletedBlock)(NSError *error);

#define MUSocketRunBlockInDelegateQueueWithOneParame(b, p) \
if(b) {\
	dispatch_async(self.delegateQueue, ^{\
		b(p);\
	});\
}

#endif /* MUSocketConst_h */
