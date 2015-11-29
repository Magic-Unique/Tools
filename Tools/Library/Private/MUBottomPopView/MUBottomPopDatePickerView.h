//
//  MUBottomPopDatePickerView.h
//  CityPicker
//
//  Created by 吴双 on 15/11/28.
//  Copyright © 2015年 Unique. All rights reserved.
//

#import "MUBottomPopView.h"


typedef void(^BottomPopDatePickerViewResultBlock)(BOOL ok, NSDate *date);





@interface MUBottomPopDatePickerView : MUBottomPopView

@property (nonatomic, strong, readonly) UIDatePicker *datePicker;

- (instancetype)initWithResultBlock:(BottomPopDatePickerViewResultBlock)block;

+ (void)showWithAnimatedOption:(MUBottomPopViewAnimatedOption)option certainBlock:(BottomPopDatePickerViewResultBlock)certain;

@end
