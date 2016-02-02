//
//  MUBottomPopGroupPickerView.m
//  Tools
//
//  Created by 吴双 on 16/1/31.
//  Copyright © 2016年 Unique. All rights reserved.
//

#import "MUBottomPopGroupPickerView.h"

@interface MUBottomPopGroupPickerView () <UIPickerViewDataSource, UIPickerViewDelegate>
{
	UIPickerView *_pickerView;
}

@end

@implementation MUBottomPopGroupPickerView

- (instancetype)initWithDelegate:(id<MUBottomPopDelegate>)delegate {
	self = [super initWithDelegate:delegate];
	if (self) {
		self.contentView = self.pickerView;
	}
	return self;
}

- (instancetype)initWithResultBlock:(BottomPopGroupPickerViewResultBlock)block {
	self = [super initWithResultBlock:^(BOOL ok) {
		if (block) {
			block(ok, self.titles, self.selectedIndexes);
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

- (void)setTitles:(NSArray<NSArray<NSString *> *> *)titles {
	_titles = titles;
	[self.pickerView reloadAllComponents];
}

- (void)setSelectedIndexes:(NSArray<NSNumber *> *)selectedIndexes {
	[self setSelectedIndexes:selectedIndexes animated:NO];
}

- (void)setSelectedIndexes:(NSArray<NSNumber *> *)selectedIndexes animated:(BOOL)animated {
	for (int component = 0; component < selectedIndexes.count; component++) {
		NSUInteger row = selectedIndexes[component].intValue;
		[self.pickerView selectRow:row inComponent:component animated:animated];
	}
}

- (NSArray<NSNumber *> *)selectedIndexes {
	NSMutableArray *array = [NSMutableArray array];
	for (int i = 0; i < self.pickerView.numberOfComponents; i++) {
		NSUInteger row = [self.pickerView selectedRowInComponent:i];
		[array addObject:@(row)];
	}
	return [array copy];
}

+ (void)showWithTitles:(NSArray<NSArray<NSString *> *> *)titles
		 selectedIndex:(NSArray<NSNumber *> *)selectedIndexes
		animatedOption:(MUBottomPopViewAnimatedOption)option
		  certainBlock:(BottomPopGroupPickerViewResultBlock)certain {
	MUBottomPopGroupPickerView *view = [[self alloc] initWithResultBlock:certain];
	view.titles = titles;
	view.selectedIndexes = selectedIndexes;
	[view showWithAnimatedOption:option];
}

#pragma mark - picker view data source

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
	return self.titles.count;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
	return self.titles[component].count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	return self.titles[component][row];
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
