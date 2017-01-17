//
//  RTStoreManager.m
//  RingTone
//
//  Created by TB-Mac-100 on 2016/12/12.
//  Copyright © 2016年 Mia Tse. All rights reserved.
//

#import "RTStoreManager.h"

#define Product_Identifier @"com.tse.ringtone.pro"	//	Product identifier in iTunes Connect
#define RTLocalText(a) nil

@interface RTStoreManager ()
{
	NSMutableArray *_productsRequestCompletions;
	NSArray *_products;
	SKProductsRequest *_productsRequest;
	StoreCompletion _storeCompletion;
	
	BOOL _restoredBuffer;
}

@end

@implementation RTStoreManager

+ (instancetype)sharedInstance {
	static RTStoreManager *_sharedInstance = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		_sharedInstance = [self new];
		for (SKPaymentTransaction *transaction in [SKPaymentQueue defaultQueue].transactions) {
			NSLog(@"Cancel transaction when init.");
			@try {
				[[SKPaymentQueue defaultQueue] finishTransaction:transaction];
			} @catch (NSException *exception) {
				NSLog(@"Catch exception: %@", exception);
			} @finally {
			}
		}
	});
	return _sharedInstance;
}

#pragma mark - Life cycle

- (instancetype)init {
	self = [super init];
	if (self) {
		_productsRequestCompletions = [NSMutableArray array];
		
		[[SKPaymentQueue defaultQueue] addTransactionObserver:self];
	}
	return self;
}

- (void)dealloc {
	[[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
}

#pragma mark - Store manager

- (BOOL)transactionEnable {
	return [SKPaymentQueue canMakePayments];
}

- (BOOL)restorePurchaseProducts:(StoreCompletion)completed {
	if (_storeCompletion) {
		return NO;
	}
	_storeCompletion = [completed copy];
	_restoredBuffer = NO;
	[[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
	return YES;
}

- (BOOL)purchaseProducts:(StoreCompletion)completed {
	if (_storeCompletion) {
		return NO;
	}
	StoreCompletion purchaseProductsCompletion = [completed copy];
	
	[self products:^(NSArray<SKProduct *> *products, RTStoreErrorCode error, NSString *description) {
		if (description) {
			//	Error in get products request
			!purchaseProductsCompletion?:purchaseProductsCompletion(error, description);
		} else {
			if (products.count == 0) {
				//	Error in get target product
				!purchaseProductsCompletion?:purchaseProductsCompletion(RTStoreErrorCodeCannotGetTargetProduct, RTLocalText(@"store.error.get_products"));
			} else {
				
				_storeCompletion = purchaseProductsCompletion;
				
				//	Fetch product
				SKProduct *product = products.firstObject;
				
				//	Begin purchase
				SKPayment *payment = [SKPayment paymentWithProduct:product];
				[[SKPaymentQueue defaultQueue] addPayment:payment];
				
			}
		}
	}];
	return YES;
}

- (void)products:(ProductsRequestCompletion)productsCompletion {
	if (_products) {
		!productsCompletion?:productsCompletion(_products, RTStoreErrorCodeSuccess, nil);
	} else {
		!productsCompletion?:[_productsRequestCompletions addObject:[productsCompletion copy]];
		
		if (!_productsRequest) {
			NSSet *productsSet = [NSSet setWithObjects:Product_Identifier, nil];
			_productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:productsSet];
			_productsRequest.delegate = self;
			[_productsRequest start];
		}
	}
}

- (void)request:(SKRequest *)request didCompletedWithError:(NSError *)error {
	_productsRequest = nil;
	RTStoreErrorCode resError = _products ? RTStoreErrorCodeSuccess : RTStoreErrorCodeCannotGetTargetProduct;
	for (ProductsRequestCompletion completion in _productsRequestCompletions) {
		completion(_products, resError, error.localizedDescription);
	}
	[_productsRequestCompletions removeAllObjects];
}

////沙盒测试环境验证
//#define SANDBOX @"https://sandbox.itunes.apple.com/verifyReceipt"
////正式环境验证
//#define AppStore @"https://buy.itunes.apple.com/verifyReceipt"
///**
// *  验证购买，避免越狱软件模拟苹果请求达到非法购买问题
// *
// */
//-(void)verifyPurchaseWithPaymentTransaction{
//	//从沙盒中获取交易凭证并且拼接成请求体数据
//	NSURL *receiptUrl=[[NSBundle mainBundle] appStoreReceiptURL];
//	NSData *receiptData=[NSData dataWithContentsOfURL:receiptUrl];
// 
//	NSString *receiptString=[receiptData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];//转化为base64字符串
// 
//	NSString *bodyString = [NSString stringWithFormat:@"{\"receipt-data\" : \"%@\"}", receiptString];//拼接请求数据
//	NSData *bodyData = [bodyString dataUsingEncoding:NSUTF8StringEncoding];
// 
// 
//	//创建请求到苹果官方进行购买验证
//	NSURL *url=[NSURL URLWithString:SANDBOX];
//	NSMutableURLRequest *requestM=[NSMutableURLRequest requestWithURL:url];
//	requestM.HTTPBody=bodyData;
//	requestM.HTTPMethod=@"POST";
//	//创建连接并发送同步请求
//	NSError *error=nil;
//	NSData *responseData=[NSURLConnection sendSynchronousRequest:requestM returningResponse:nil error:&error];
//	if (error) {
//		NSLog(@"验证购买过程中发生错误，错误信息：%@",error.localizedDescription);
//		return;
//	}
//	NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:nil];
//	NSLog(@"%@",dic);
//	if([dic[@"status"] intValue]==0){
//		NSLog(@"购买成功！");
//		NSDictionary *dicReceipt= dic[@"receipt"];
//		NSDictionary *dicInApp=[dicReceipt[@"in_app"] firstObject];
//		NSString *productIdentifier= dicInApp[@"product_id"];//读取产品标识
//		//如果是消耗品则记录购买数量，非消耗品则记录是否购买过
//		NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
//		if ([productIdentifier isEqualToString:@"123"]) {
//			int purchasedCount=[defaults integerForKey:productIdentifier];//已购买数量
//			[[NSUserDefaults standardUserDefaults] setInteger:(purchasedCount+1) forKey:productIdentifier];
//		}else{
//			[defaults setBool:YES forKey:productIdentifier];
//		}
//		//在此处对购买记录进行存储，可以存储到开发商的服务器端
//	}else{
//		NSLog(@"购买失败，未通过验证！");
//	}
//}

#pragma mark - Products request delegate

- (void)requestDidFinish:(SKRequest *)request {
	[self request:request didCompletedWithError:nil];
}

- (void)request:(SKRequest *)request didFailWithError:(NSError *)error {
	[self request:request didCompletedWithError:error];
}

- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response {
	_products = response.products;
}

#pragma mark - Payment transaction observer

- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray<SKPaymentTransaction *> *)transactions {
	for (SKPaymentTransaction *transaction in transactions) {
		switch (transaction.transactionState) {
			case SKPaymentTransactionStateFailed: {
				//	Failed
				if (transaction.error.code == 2) {
					!_storeCompletion?:_storeCompletion(RTStoreErrorCodeUserCanceled, RTLocalText(@"store.error.cancel_purchase"));
				} else {
					!_storeCompletion?:_storeCompletion(transaction.error.code, transaction.error.localizedDescription);
				}
				_storeCompletion = nil;
				[queue finishTransaction:transaction];
				break;
			}
			case SKPaymentTransactionStateDeferred:
				//	Waiting
				
				break;
			case SKPaymentTransactionStateRestored:
				//	Restored
				
				!_storeCompletion?:_storeCompletion(RTStoreErrorCodeSuccess, nil);
				_storeCompletion = nil;
				[queue finishTransaction:transaction];
				break;
			case SKPaymentTransactionStatePurchased: {
				//	Purchased
				
				!_storeCompletion?:_storeCompletion(RTStoreErrorCodeSuccess, nil);
				_storeCompletion = nil;
				[queue finishTransaction:transaction];
				break;
			}
			case SKPaymentTransactionStatePurchasing:
				//	Purchasing...
				
				break;
			default:
				break;
		}
	}
}

- (void)paymentQueue:(SKPaymentQueue *)queue restoreCompletedTransactionsFailedWithError:(NSError *)error {
	//	恢复失败，处理各种原因，但不包括“尚未购买”的原因
	switch (error.code) {
		case SKErrorPaymentCancelled:
			// user cancelled the request, etc.
			!_storeCompletion?:_storeCompletion(RTStoreErrorCodeUserCanceled, RTLocalText(@"store.error.cancel_restore"));
			break;
		case SKErrorUnknown:
		case SKErrorClientInvalid:
		case SKErrorPaymentInvalid:
		case SKErrorPaymentNotAllowed:
		case SKErrorStoreProductNotAvailable:
		case SKErrorCloudServicePermissionDenied:
		case SKErrorCloudServiceNetworkConnectionFailed:
			!_storeCompletion?:_storeCompletion(error.code, error.localizedDescription);
			break;
		default:
			break;
	}
	_storeCompletion = nil;
}

- (void)paymentQueueRestoreCompletedTransactionsFinished:(SKPaymentQueue *)queue {
	//	没有购买 直接点恢复   会调用这个方法
	
	//		这里无需判断是否恢复购买成功，因为购买成功后会回调 [-paymentQueue:updatedTransactions:] 并且执行 SKPaymentTransactionStateRestored 的 case
	//	执行后 _storeCompletion 自动清空，所以不用担心此处会二次执行 _storeCompletion
	!_storeCompletion?:_storeCompletion(RTStoreErrorCodeRestoreWithoutPurchase, RTLocalText(@"store.error.restore_without_purchase"));
	_storeCompletion = nil;
}

@end
