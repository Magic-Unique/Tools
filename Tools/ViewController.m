//
//  ViewController.m
//  Tools
//
//  Created by Magic_Unique on 15/10/30.
//  Copyright © 2015年 Unique. All rights reserved.
//

#import "ViewController.h"

#import "MUBottomPopCityPickerView.h"
#import "MUBottomPopDatePickerView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    static NSDictionary *_cityInfo = nil;
    MUBottomPopCityPickerView *view = [[MUBottomPopCityPickerView alloc] initWithResultBlock:^(BOOL ok, NSDictionary *cityInfo) {
        NSLog(@"%@", cityInfo);
        _cityInfo = cityInfo;
    }];
    view.style = 3;
    view.cityInfo = _cityInfo;
    [view showWithAnimatedOption:MUBottomPopViewAnimatedOptionRebound];
//    [MUBottomPopDatePickerView showWithAnimatedOption:MUBottomPopViewAnimatedOptionRebound certainBlock:^(BOOL ok, NSDate *date) {
//        NSLog(@"%@", date);
//    }];
}

@end
