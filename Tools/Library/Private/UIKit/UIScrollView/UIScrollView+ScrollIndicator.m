//
//  UIScrollView+ScrollIndicator.m
//  Tools
//
//  Created by 吴双 on 2018/7/24.
//  Copyright © 2018年 Unique. All rights reserved.
//

#import "UIScrollView+ScrollIndicator.h"
#import <objc/runtime.h>

@interface UIScrollView ()
- (void)_quicklyHideScrollIndicator:(UIImageView *)indicator animated:(BOOL)arg2;
- (void)_hideScrollIndicators;
@end

@implementation UIScrollView (ScrollIndicator)

+ (void)si_initialize {
    Method ori_quick = class_getInstanceMethod(self, @selector(_quicklyHideScrollIndicator:animated:));
    Method new_quick = class_getInstanceMethod(self, @selector(si_quicklyHideScrollIndicator:animated:));
    method_exchangeImplementations(ori_quick, new_quick);
    
    Method ori_hide = class_getInstanceMethod(self, @selector(_hideScrollIndicators));
    Method new_hide = class_getInstanceMethod(self, @selector(si_hideScrollIndicators));
    method_exchangeImplementations(ori_hide, new_hide);
}

- (void)si_quicklyHideScrollIndicator:(UIImageView *)indicator animated:(BOOL)arg2 {
    if (self.si_alwaysShowsScrollIndicator) {
        
    } else {
        [self si_quicklyHideScrollIndicator:indicator animated:arg2];
    }
}

- (void)si_hideScrollIndicators {
    if (self.si_alwaysShowsScrollIndicator) {
        
    } else {
        [self si_hideScrollIndicators];
    }
}

- (BOOL)si_alwaysShowsScrollIndicator {
    NSNumber *value = objc_getAssociatedObject(self, "_alwaysShowsScrollIndicator");
    return value.boolValue;
}

- (void)setSi_alwaysShowsScrollIndicator:(BOOL)si_alwaysShowsScrollIndicator {
    if (si_alwaysShowsScrollIndicator) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            [[self class] si_initialize];
        });
        objc_setAssociatedObject(self, "_alwaysShowsScrollIndicator", @YES, OBJC_ASSOCIATION_COPY_NONATOMIC);
        [self flashScrollIndicators];
    } else {
        objc_setAssociatedObject(self, "_alwaysShowsScrollIndicator", nil, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
}

@end
