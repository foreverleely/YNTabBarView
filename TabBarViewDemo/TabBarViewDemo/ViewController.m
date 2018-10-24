//
//  ViewController.m
//  TabBarViewDemo
//
//  Created by liyangly on 2018/9/25.
//  Copyright © 2018年 liyang. All rights reserved.
//

#import "ViewController.h"
#import "YNTabBarView.h"
// pod
#import "Masonry.h"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)

#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define TARGETED_DEVICE_IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

#define TARGETED_DEVICE_IS_IPHONE_X (TARGETED_DEVICE_IS_IPHONE && (SCREEN_HEIGHT == 812 || SCREEN_HEIGHT == 896))

#define DeviceTabbarHeight    (TARGETED_DEVICE_IS_IPHONE_X ? 83 : 49)

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSArray *titleList = @[@"tab0",
                           @"tab1",
                           @"tab2",
                           @"tab3"];
    NSArray *selectList   = @[@"icon_tabbar_1",
                              @"icon_tabbar_2",
                              @"icon_tabbar_3",
                              @"icon_tabbar_4"];
    CGFloat viewWidth = 300.f;
    CGFloat btnWidth = viewWidth/selectList.count;
//    YNTabBarView *tabbarView = [[YNTabBarView alloc] initWithSelectList:selectList unSelectList:unSelectList andBtnWidth:btnWidth];
    YNTabBarView *tabbarView = [[YNTabBarView alloc] initWithTitles:titleList
                                                             Images:selectList
                                                        SelectColor:[UIColor yellowColor]
                                                      UnSelectColor:[UIColor lightGrayColor]
                                                          titleFont:[UIFont systemFontOfSize:6]
                                                        AndBtnWidth:btnWidth];
//    tabbarView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:tabbarView];
    [tabbarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.bottom.mas_equalTo(self.view);
        make.width.mas_equalTo(viewWidth);
        make.height.mas_equalTo(DeviceTabbarHeight);
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
