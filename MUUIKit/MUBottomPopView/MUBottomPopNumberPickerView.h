//
//  MUBottomPopNumberPickerView.h
//  Tools
//
//  Created by 吴双 on 16/1/31.
//  Copyright © 2016年 Unique. All rights reserved.
//

#import "MUBottomPopView.h"

typedef void(^BottomPopNumberPickerViewResultBlock)(BOOL ok,
												   NSArray<NSNumber *> *maxValues,
												   NSArray<NSNumber *> *selectedIndexes);

@interface MUBottomPopNumberPickerView : MUBottomPopView

@property (nonatomic, strong, readonly) UIPickerView *pickerView;

@property (nonatomic, strong) NSArray<NSNumber *> *maxValues;

@property (nonatomic, strong) NSArray<NSNumber *> *selectedIndexes;

- (instancetype)initWithResultBlock:(BottomPopNumberPickerViewResultBlock)block;

- (void)setSelectedIndexes:(NSArray<NSNumber *> *)selectedIndexes animated:(BOOL)animated;

+ (void)showWithMaxValues:(NSArray<NSNumber *> *)maxValues
			selectedIndex:(NSArray<NSNumber *> *)selectedIndexes
		   animatedOption:(MUBottomPopViewAnimatedOption)option
			 certainBlock:(BottomPopNumberPickerViewResultBlock)certain;

@end
