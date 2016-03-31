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
#import "MUBottomPopGroupPickerView.h"
#import "MUBottomPopNumberPickerView.h"
#import "MUBottomPopPickerView.h"

#import "UINavigationBar+Extension.h"

#import "MUToast.h"

#import "UIImage+Extension.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UISlider *r;
@property (weak, nonatomic) IBOutlet UISlider *g;
@property (weak, nonatomic) IBOutlet UISlider *b;
@property (weak, nonatomic) IBOutlet UISlider *a;
@property (weak, nonatomic) IBOutlet UISwitch *s;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    self.title = @"title";
    
    self.navigationController.navigationBar.alphaBackgroundColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.5];
	
	self.imageView.image = [UIImage imageWithImage:[UIImage imageNamed:@"header.jpg"] mask:[UIImage imageNamed:@"iconfont-wechat1193418easyiconnet-2"] option:UIImageMaskOptionFillWithScale];
	NSData *png = UIImagePNGRepresentation(self.imageView.image);
	[png writeToFile:@"/Users/Unique/Desktop/image.png" atomically:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
//	MUToast *toast = [MUToast toastWithText:@"123" style:MUToastStyleWhite];
//	[toast show];
//	[MUToast showDurationToastText:@"123" duraion:3];
	
//	[MUBottomPopNumberPickerView showWithMaxValues:@[@(255), @(255), @(255), @(255)] selectedIndex:@[@(192), @(168), @(1), @(101)] animatedOption:MUBottomPopViewAnimatedOptionRebound certainBlock:^(BOOL ok, NSArray<NSNumber *> *maxValues, NSArray<NSNumber *> *selectedIndexes) {
//		
//	}];
}
- (IBAction)valueChange:(UISlider *)sender {
//    [self.navigationController.navigationBar setAlphaBackgroundColor:[UIColor colorWithRed:1 green:0 blue:0 alpha:sender.value]];
}
- (IBAction)clickButton:(UIButton *)sender {
    
    [self.navigationController.navigationBar setAlphaBackgroundColor:[UIColor colorWithRed:self.r.value green:self.g.value blue:self.b.value alpha:self.a.value] animated:YES];
    
}
- (IBAction)rc:(id)sender {
    if (self.s.on) {
        [self.navigationController.navigationBar setAlphaBackgroundColor:[UIColor colorWithRed:self.r.value green:self.g.value blue:self.b.value alpha:self.a.value] animated:NO];
    }
    
}
- (IBAction)gc:(id)sender {
    if (self.s.on) {
        [self.navigationController.navigationBar setAlphaBackgroundColor:[UIColor colorWithRed:self.r.value green:self.g.value blue:self.b.value alpha:self.a.value] animated:NO];
    }
}
- (IBAction)bc:(id)sender {
    if (self.s.on) {
        [self.navigationController.navigationBar setAlphaBackgroundColor:[UIColor colorWithRed:self.r.value green:self.g.value blue:self.b.value alpha:self.a.value] animated:NO];
    }
}
- (IBAction)ac:(id)sender {
    if (self.s.on) {
        [self.navigationController.navigationBar setAlphaBackgroundColor:[UIColor colorWithRed:self.r.value green:self.g.value blue:self.b.value alpha:self.a.value] animated:NO];
    }
}

@end
