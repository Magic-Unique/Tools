//
//  MUBottomPopNumberPickerView.m
//  Tools
//
//  Created by 吴双 on 16/1/31.
//  Copyright © 2016年 Unique. All rights reserved.
//

#import "MUBottomPopNumberPickerView.h"

@interface MUBottomPopNumberPickerView () <UIPickerViewDataSource, UIPickerViewDelegate>
{
	UIPickerView *_pickerView;
}

@end

@implementation MUBottomPopNumberPickerView

- (instancetype)initWithDelegate:(id<MUBottomPopDelegate>)delegate {
	self = [super initWithDelegate:delegate];
	if (self) {
		self.contentView = self.pickerView;
	}
	return self;
}

- (instancetype)initWithResultBlock:(BottomPopNumberPickerViewResultBlock)block {
	self = [super initWithResultBlock:^(BOOL ok) {
		if (block) {
			block(ok, self.maxValues, self.selectedIndexes);
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

+ (void)showWithMaxValues:(NSArray<NSNumber *> *)maxValues
			selectedIndex:(NSArray<NSNumber *> *)selectedIndexes
		   animatedOption:(MUBottomPopViewAnimatedOption)option
			 certainBlock:(BottomPopNumberPickerViewResultBlock)certain {
	MUBottomPopNumberPickerView *view = [[self alloc] initWithResultBlock:certain];
	view.maxValues = maxValues;
	view.selectedIndexes = selectedIndexes;
	[view showWithAnimatedOption:option];
}

- (void)setMaxValues:(NSArray<NSNumber *> *)maxValues {
	_maxValues = maxValues;
	[self.pickerView reloadAllComponents];
}

- (void)setSelectedIndexes:(NSArray<NSNumber *> *)selectedIndexes {
	[self setSelectedIndexes:selectedIndexes animated:NO];
}

- (void)setSelectedIndexes:(NSArray<NSNumber *> *)selectedIndexes animated:(BOOL)animated {
	for (int i = 0; i < MIN(selectedIndexes.count, self.pickerView.numberOfComponents); i++) {
		[self.pickerView selectRow:selectedIndexes[i].intValue inComponent:i animated:animated];
	}
}

- (NSArray<NSNumber *> *)selectedIndexes {
	NSMutableArray *array = [NSMutableArray array];
	for (int i = 0; i < self.pickerView.numberOfComponents; i++) {
		[array addObject:@([self.pickerView selectedRowInComponent:i])];
	}
	return [array copy];
}

#pragma mark - picker view data source

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
	return self.maxValues.count;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
	return self.maxValues[component].intValue + 1;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	return [NSString stringWithFormat:@"%ld", (unsigned long)row];
}

- (UIPickerView *)pickerView {
	if (!_pickerView) {
		_pickerView = [UIPickerView new];
		_pickerView.dataSource = self;
		_pickerView.delegate = self;
	}
	return _pickerView;
}

@end
