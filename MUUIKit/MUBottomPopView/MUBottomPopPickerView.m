//
//  MUBottomPopPickerView.m
//  Tools
//
//  Created by 吴双 on 15/12/1.
//  Copyright © 2015年 Unique. All rights reserved.
//

#import "MUBottomPopPickerView.h"

@interface MUBottomPopPickerView () <UIPickerViewDataSource, UIPickerViewDelegate>
{
    UIPickerView *_pickerView;
}
@end

@implementation MUBottomPopPickerView

- (instancetype)initWithDelegate:(id<MUBottomPopDelegate>)delegate {
    self = [super initWithDelegate:delegate];
    if (self) {
        self.contentView = self.pickerView;
    }
    return self;
}

- (instancetype)initWithResultBlock:(BottomPopPickerViewResultBlock)block {
    self = [super initWithResultBlock:^(BOOL ok) {
        if (block) {
            block(ok, self.titles, self.selectedIndex);
        }
    }];
    if (self) {
        self.contentView = self.pickerView;
    }
    return self;
}

- (void)layoutSubviews {
    CGRect frame = self.contentView.frame;
    frame.size.width = [UIApplication sharedApplication].windows.lastObject.bounds.size.width;
    self.contentView.frame = frame;
    [super layoutSubviews];
}

#pragma mark - titles

- (void)setTitles:(NSArray<NSString *> *)titles {
    _titles = titles;
    [self.pickerView reloadAllComponents];
}

#pragma mark - selected index

- (void)setSelectedIndex:(NSUInteger)selectedIndex {
    [self setSelectedIndex:selectedIndex animated:NO];
}

- (NSUInteger)selectedIndex {
    return [self.pickerView selectedRowInComponent:0];
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex animated:(BOOL)animated {
    if (self.titles.count > selectedIndex) {
        [self.pickerView selectRow:selectedIndex inComponent:0 animated:animated];
    }
}

#pragma mark - picker view data source

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.titles.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.titles[row];
}

#pragma mark - public method

+ (void)showWithTitles:(NSArray *)titles selectedIndex:(NSUInteger)selectedIndex animatedOption:(MUBottomPopViewAnimatedOption)option certainBlock:(BottomPopPickerViewResultBlock)certain {
    
    MUBottomPopPickerView *view = [[self alloc] initWithResultBlock:certain];
    view.titles = titles;
    view.selectedIndex = selectedIndex;
    [view showWithAnimatedOption:option];
}

#pragma mark - property getter

- (UIPickerView *)pickerView {
    if (!_pickerView) {
        _pickerView = [UIPickerView new];
        _pickerView.dataSource = self;
        _pickerView.delegate = self;
    }
    return _pickerView;
}

@end
