//
//  MUBottomPopCityPickerView.h
//  CityPicker
//
//  Created by 吴双 on 15/11/28.
//  Copyright © 2015年 Unique. All rights reserved.
//

#import "MUBottomPopView.h"

extern NSString *const MUCityInfoProvinceKey;
extern NSString *const MUCityInfoCityKey;
extern NSString *const MUCityInfoRegionKey;

typedef void(^BottomPopCityPickerViewResultBlock)(BOOL ok, NSDictionary *cityInfo);

typedef NS_ENUM(NSUInteger, MUBottomPopCityPickerStyle) {
    MUBottomPopCityPickerStyleProvince = 1,
    MUBottomPopCityPickerStyleProvinceCity = 2,
    MUBottomPopCityPickerStyleProvinceCityRegion = 3,
};


@interface MUBottomPopCityPickerView : MUBottomPopView

@property (nonatomic, strong, readonly) UIPickerView *cityPicker;

@property (nonatomic, strong) NSDictionary *cityInfo;

@property (nonatomic, assign) MUBottomPopCityPickerStyle style;

- (instancetype)initWithResultBlock:(BottomPopCityPickerViewResultBlock)block;

- (void)setCityInfo:(NSDictionary *)cityInfo animated:(BOOL)animated;

+ (void)showWithAnimatedOption:(MUBottomPopViewAnimatedOption)option certainBlock:(BottomPopCityPickerViewResultBlock)certain;


@end
