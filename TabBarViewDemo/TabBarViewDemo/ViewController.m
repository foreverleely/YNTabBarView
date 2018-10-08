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

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSArray *selectList   = @[@"icon_tabbar_1",
                              @"icon_tabbar_2",
                              @"icon_tabbar_3",
                              @"icon_tabbar_4"];
    NSArray *unSelectList = @[@"icon_tabbar_1_1",
                              @"icon_tabbar_2_1",
                              @"icon_tabbar_3_1",
                              @"icon_tabbar_4_1"];
    YNTabBarView *tabbarView = [[YNTabBarView alloc] initWithSelectList:selectList unSelectList:unSelectList];
    tabbarView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:tabbarView];
    [tabbarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.height.mas_equalTo(64);
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
