//
//  MUBottomPopPickerView.h
//  Tools
//
//  Created by 吴双 on 15/12/1.
//  Copyright © 2015年 Unique. All rights reserved.
//

#import "MUBottomPopView.h"

typedef void(^BottomPopPickerViewResultBlock)(BOOL ok, NSArray<NSString *> *titles, NSUInteger selectedIndex);


@interface MUBottomPopPickerView : MUBottomPopView

@property (nonatomic, strong, readonly) UIPickerView *pickerView;

@property (nonatomic, assign) NSUInteger selectedIndex;

@property (nonatomic, strong) NSArray<NSString *> *titles;

- (instancetype)initWithResultBlock:(BottomPopPickerViewResultBlock)block;

- (void)setSelectedIndex:(NSUInteger)selectedIndex animated:(BOOL)animated;

+ (void)showWithTitles:(NSArray *)titles
         selectedIndex:(NSUInteger)selectedIndex
        animatedOption:(MUBottomPopViewAnimatedOption)option
          certainBlock:(BottomPopPickerViewResultBlock)certain;

@end
