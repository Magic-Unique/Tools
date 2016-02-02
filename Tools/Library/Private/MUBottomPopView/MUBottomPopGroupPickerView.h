//
//  MUBottomPopGroupPickerView.h
//  Tools
//
//  Created by 吴双 on 16/1/31.
//  Copyright © 2016年 Unique. All rights reserved.
//

#import "MUBottomPopView.h"

typedef void(^BottomPopGroupPickerViewResultBlock)(BOOL ok,
												   NSArray<NSArray<NSString *> *> *titles,
												   NSArray<NSNumber *> *selectedIndexes);

@interface MUBottomPopGroupPickerView : MUBottomPopView

@property (nonatomic, strong, readonly) UIPickerView *pickerView;

@property (nonatomic, strong) NSArray<NSArray<NSString *> *> *titles;

@property (nonatomic, strong) NSArray<NSNumber *> *selectedIndexes;

- (instancetype)initWithResultBlock:(BottomPopGroupPickerViewResultBlock)block;

- (void)setSelectedIndexes:(NSArray<NSNumber *> *)selectedIndexes animated:(BOOL)animated;

+ (void)showWithTitles:(NSArray<NSArray<NSString *> *> *)titles
		 selectedIndex:(NSArray<NSNumber *> *)selectedIndexes
		animatedOption:(MUBottomPopViewAnimatedOption)option
		  certainBlock:(BottomPopGroupPickerViewResultBlock)certain;

@end
