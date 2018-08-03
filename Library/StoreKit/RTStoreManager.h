//
//  RTStoreManager.h
//  RingTone
//
//  Created by TB-Mac-100 on 2016/12/12.
//  Copyright © 2016年 Mia Tse. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>

#define SharedStoreManager [RTStoreManager sharedInstance]

typedef NS_ENUM(NSInteger, RTStoreErrorCode) {
	RTStoreErrorCodeSuccess						= -1,
	
	//	SKErrorCode
	
	RTStoreErrorCodeUnknown,
	RTStoreErrorCodeClientInvalid,
	RTStoreErrorCodeUserCanceled,
	RTStoreErrorCodePaymentInvalid,
	RTStoreErrorCodePaymentNotAllowed,
	RTStoreErrorCodeProductNotAvailable,
	RTStoreErrorCodeServicePermissionDenied,
	RTStoreErrorCodeCannotConnectService,
	
	//	RTStoreErrorCode
	
	RTStoreErrorCodeCannotGetProductsRequest,
	RTStoreErrorCodeCannotGetTargetProduct,
	RTStoreErrorCodeRestoreWithoutPurchase,
};

typedef void(^StoreCompletion)(RTStoreErrorCode errorCode, NSString *description);
typedef void(^ProductsRequestCompletion)(NSArray<SKProduct *> *products, RTStoreErrorCode error, NSString *description);



@interface RTStoreManager : NSObject <SKPaymentTransactionObserver, SKProductsRequestDelegate>

@property (nonatomic, assign, readonly) BOOL transactionEnable;

+ (instancetype)sharedInstance;

- (BOOL)restorePurchaseProducts:(StoreCompletion)completed;

- (BOOL)purchaseProducts:(StoreCompletion)completed;

- (void)products:(ProductsRequestCompletion)productsCompletion;

@end
