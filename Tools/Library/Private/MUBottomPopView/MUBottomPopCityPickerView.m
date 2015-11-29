//
//  MUBottomPopCityPickerView.m
//  CityPicker
//
//  Created by 吴双 on 15/11/28.
//  Copyright © 2015年 Unique. All rights reserved.
//

#import "MUBottomPopCityPickerView.h"

#define source_path [[NSBundle mainBundle] pathForResource:@"pcr" ofType:@"plist"]

#define municipality_suffix @"市"
#define provinces_three_char @[@"黑龙江省", @"内蒙古自治区"]

NSString *const MUCityInfoProvinceKey = @"province";
NSString *const MUCityInfoCityKey = @"city";
NSString *const MUCityInfoRegionKey = @"region";


#pragma mark - model

@interface MUChinaCity : NSObject

@property (nonatomic, strong) NSString *city;

@property (nonatomic, strong) NSArray<NSString *> *regions;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
+ (instancetype)cityWithDictionary:(NSDictionary *)dictionary;

@end

@interface MUChinaProvince : NSObject

@property (nonatomic, strong) NSString *province;

@property (nonatomic, strong) NSArray<MUChinaCity *> *cities;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
+ (instancetype)provinceWithDictionary:(NSDictionary *)dictionary;

+ (NSArray<MUChinaProvince *> *)allProvince;

@end





















#pragma mark - view

@interface MUBottomPopCityPickerView () <UIPickerViewDataSource, UIPickerViewDelegate>
{
    UIPickerView *_cityPicker;
    NSArray<MUChinaProvince *> *_data;
    MUBottomPopCityPickerStyle _style;
}

@property (nonatomic, strong) NSArray<MUChinaProvince *> *data;

@property (nonatomic, strong) MUChinaProvince *selectedProvince;

@property (nonatomic, strong) MUChinaCity *selectedCity;

@property (nonatomic, strong) NSString *selectedRegion;

@end

@implementation MUBottomPopCityPickerView

- (instancetype)initWithDelegate:(id<MUBottomPopDelegate>)delegate {
    self = [super initWithDelegate:delegate];
    if (self) {
        self.selectedProvince = self.data.firstObject;
        self.contentView = self.cityPicker;
    }
    return self;
}

- (instancetype)initWithResultBlock:(BottomPopCityPickerViewResultBlock)block {
    self = [super initWithResultBlock:^(BOOL ok) {
        if (block) {
            block(ok, self.cityInfo);
        }
    }];
    if (self) {
        self.selectedProvince = self.data.firstObject;
        self.contentView = self.cityPicker;
    }
    return self;
}

- (void)layoutSubviews {
    CGRect frame = self.contentView.frame;
    frame.size.width = [UIApplication sharedApplication].windows.lastObject.bounds.size.width;
    self.contentView.frame = frame;
    [self.contentView setNeedsLayout];
    [super layoutSubviews];
}

#pragma mark - public method

+ (void)showWithAnimatedOption:(MUBottomPopViewAnimatedOption)option certainBlock:(BottomPopCityPickerViewResultBlock)certain {
    MUBottomPopCityPickerView *view = [[MUBottomPopCityPickerView alloc] initWithResultBlock:certain];
    [view showWithAnimatedOption:option];
}

#pragma mark - private method

- (void)reloadComponent:(NSUInteger)component {
    /*
     value: 0   1   2   3
     style:     p   c   r
     compo: p   c   r
     */
    if (self.style > component) {
        [self.cityPicker reloadComponent:component];
        [self.cityPicker selectRow:0 inComponent:component animated:YES];
        if (component < 2) {
            [self reloadComponent:component+1];
        }
    }
}

#pragma mark - picker view data source

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return self.style > 3 ? 3 : self.style;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSUInteger row = 0;
    switch (component) {
        case 0: {
            row = self.data.count;
            break;
        }
        case 1: {
            // use regions replace city, if hide regions and province is municipality.
            if (self.style == 2 && [self.selectedProvince.province hasSuffix:municipality_suffix]) {
                row = self.selectedCity.regions.count;
            } else {
                row = self.selectedProvince.cities.count;
            }
            
            break;
        }
        case 2: {
            row = self.selectedCity.regions.count;
            break;
        }
        default:
            break;
    }
    return row;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *title = @"";
    
    switch (component) {
        case 0: {
            title = self.data[row].province;
            // hide some char when number of component is 3
            if (self.style == 3) {
                if ([provinces_three_char containsObject:title]) {
                    title = [title substringToIndex:3];
                } else {
                    title = [title substringToIndex:2];
                }
            }
            break;
        }
        case 1: {
            // use regions replace city, if hide regions and province is municipality.
            if (self.style == 2 && [self.selectedProvince.province hasSuffix:municipality_suffix]) {
                title = self.selectedCity.regions[row];
            } else {
                title = self.selectedProvince.cities[row].city;
            }
            break;
        }
        case 2: {
            title = self.selectedCity.regions[row];
            break;
        }
        default:
            break;
    }
    return title;
}

#pragma mark - picker view delegate

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    switch (component) {
        case 0:
            self.selectedProvince = self.data[row];
            break;
        case 1:
            // use regions replace city, if hide regions and province is municipality.
            if (self.style == 2 && [self.selectedProvince.province hasSuffix:municipality_suffix]) {
                self.selectedRegion = self.selectedCity.regions[row];
            } else {
                self.selectedCity = self.selectedProvince.cities[row];
            }
            
            break;
        case 2:
            self.selectedRegion = self.selectedCity.regions[row];
            break;
        default:
            break;
    }
    [self reloadComponent:component+1];
}

#pragma mark - city infomation

- (NSDictionary *)cityInfo {
    
    NSMutableDictionary *cityInfo = [NSMutableDictionary dictionary];
    
    if (self.style >= 1) {
        cityInfo[MUCityInfoProvinceKey] = self.selectedProvince.province;
    }
    if (self.style >= 2) {
        // use regions replace city, if hide regions and province is municipality.
        if ([self.selectedProvince.province hasSuffix:municipality_suffix]) {
            cityInfo[MUCityInfoRegionKey] = self.selectedRegion;
        } else {
            cityInfo[MUCityInfoCityKey] = self.selectedCity.city;
        }
    }
    if (self.style >= 3) {
        cityInfo[MUCityInfoRegionKey] = self.selectedRegion;
    }
    
    
    
    return [NSDictionary dictionaryWithDictionary:cityInfo];
}

- (void)setCityInfo:(NSDictionary *)cityInfo {
    [self setCityInfo:cityInfo animated:NO];
}

- (void)setCityInfo:(NSDictionary *)cityInfo animated:(BOOL)animated {
    NSString *nameProvince = cityInfo[MUCityInfoProvinceKey];
    NSString *nameCity = cityInfo[MUCityInfoCityKey];
    NSString *nameRegion = cityInfo[MUCityInfoRegionKey];
    if ([self setSelectedProvinceWithName:nameProvince animated:animated]) {
        if ([self setSelectedCityWithName:nameCity animated:animated]) {
            [self selSelectedRegionWithName:nameRegion animated:animated];
        }
    }
}

- (BOOL)setSelectedProvinceWithName:(NSString *)name animated:(BOOL)animated {
    NSUInteger row = -1;
    if (name) {
        for (MUChinaProvince *province in self.data) {
            row++;
            if ([province.province hasPrefix:name]) {
                self.selectedProvince = province;
                [self.cityPicker selectRow:row inComponent:0 animated:animated];
                return YES;
            }
        }
    }
    return NO;
}

- (BOOL)setSelectedCityWithName:(NSString *)name animated:(BOOL)animated {
    NSUInteger row = -1;
    if (name) {
        for (MUChinaCity *city in self.selectedProvince.cities) {
            row++;
            if ([city.city hasPrefix:name]) {
                self.selectedCity = city;
                [self.cityPicker selectRow:row inComponent:1 animated:animated];
                return YES;
            }
        }
    }
    return NO;
}

- (BOOL)selSelectedRegionWithName:(NSString *)name animated:(BOOL)animated {
    NSUInteger row = -1;
    if (name) {
        for (NSString *region in self.selectedCity.regions) {
            row ++;
            if ([region hasPrefix:name]) {
                self.selectedRegion = region;
                [self.cityPicker selectRow:row inComponent:2 animated:animated];
                return YES;
            }
        }
    }
    return NO;
}

#pragma mark - selected data

- (void)setSelectedProvince:(MUChinaProvince *)selectedProvince {
    _selectedProvince = selectedProvince;
    self.selectedCity = selectedProvince.cities.firstObject;
}

- (void)setSelectedCity:(MUChinaCity *)selectedCity {
    _selectedCity = selectedCity;
    self.selectedRegion = selectedCity.regions.firstObject;
}

#pragma mark - style

- (void)setStyle:(MUBottomPopCityPickerStyle)style {
    if (style > 3) {
        style = 3;
    }
    _style = style;
    [self.cityPicker reloadAllComponents];
}

- (MUBottomPopCityPickerStyle)style {
    if (!_style) {
        _style = MUBottomPopCityPickerStyleProvinceCityRegion;
    }
    return _style;
}

#pragma mark - property getter

- (UIPickerView *)cityPicker {
    if (!_cityPicker) {
        _cityPicker = [UIPickerView new];
        _cityPicker.dataSource = self;
        _cityPicker.delegate = self;
    }
    return _cityPicker;
}

- (NSArray *)data {
    if (!_data) {
        _data = [MUChinaProvince allProvince];
    }
    return _data;
}


@end




















#pragma mark - model

@implementation MUChinaProvince

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.province = dictionary[@"province"];
        NSMutableArray *cities = [NSMutableArray array];
        for (NSDictionary *item in dictionary[@"cities"]) {
            [cities addObject:[MUChinaCity cityWithDictionary:item]];
        }
        self.cities = [cities copy];
    }
    return self;
}

+ (instancetype)provinceWithDictionary:(NSDictionary *)dictionary {
    return [[self alloc] initWithDictionary:dictionary];
}

+ (NSArray<MUChinaProvince *> *)allProvince {
    NSArray *array = [NSArray arrayWithContentsOfFile:source_path];
    NSMutableArray *provinces = [NSMutableArray array];
    for (NSDictionary *item in array) {
        [provinces addObject:[MUChinaProvince provinceWithDictionary:item]];
    }
    return [provinces copy];
}

@end



@implementation MUChinaCity

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dictionary];
    }
    return self;
}

+ (instancetype)cityWithDictionary:(NSDictionary *)dictionary {
    return [[self alloc] initWithDictionary:dictionary];
}

@end
