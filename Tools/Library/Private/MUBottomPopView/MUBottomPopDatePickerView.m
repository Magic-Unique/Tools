//
//  MUBottomPopDatePickerView.m
//  CityPicker
//
//  Created by 吴双 on 15/11/28.
//  Copyright © 2015年 Unique. All rights reserved.
//

#import "MUBottomPopDatePickerView.h"

@interface MUBottomPopDatePickerView ()
{
    UIDatePicker *_datePicker;
}
@end

@implementation MUBottomPopDatePickerView

- (instancetype)initWithDelegate:(id<MUBottomPopDelegate>)delegate {
    self = [super initWithDelegate:delegate];
    if (self) {
        self.contentView = self.datePicker;
    }
    return self;
}

- (instancetype)initWithResultBlock:(BottomPopDatePickerViewResultBlock)block {
    self = [super initWithResultBlock:^(BOOL ok) {
        if (block) {
            block(ok, self.datePicker.date);
        }
    }];
    if (self) {
        self.contentView = self.datePicker;
    }
    return self;
}

- (void)layoutSubviews {
    CGRect frame = self.contentView.frame;
    frame.size.width = [UIApplication sharedApplication].windows.lastObject.bounds.size.width;
    self.contentView.frame = frame;
    [super layoutSubviews];
}

#pragma mark - public method

+ (void)showWithAnimatedOption:(MUBottomPopViewAnimatedOption)option certainBlock:(BottomPopDatePickerViewResultBlock)certain {
    MUBottomPopDatePickerView *view = [[self alloc] initWithResultBlock:certain];
    [view showWithAnimatedOption:option];
}

#pragma mark - property getter

- (UIDatePicker *)datePicker {
    if (!_datePicker) {
        _datePicker = [UIDatePicker new];
        _datePicker.datePickerMode = UIDatePickerModeDate;
//        [_datePicker setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_Hans_CN"]];
    }
    return _datePicker;
}


@end
