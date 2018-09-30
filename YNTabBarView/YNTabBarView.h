//
//  YNTabBarView.h
//  LYPlayCard
//
//  Created by liyangly on 2018/9/12.
//  Copyright © 2018年 makeupopular.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YNTabBarView : UIView

@property (nonatomic, assign) NSInteger selectIndex;

// set button imageInsets
@property (nonatomic, assign) CGFloat imageGap;

@property (nonatomic, strong) NSArray *unSelectImgList;

@property (nonatomic, strong) NSArray *selectImgList;

@property (nonatomic, copy) void (^selectItem)(NSInteger index);


- (instancetype)initWithSelectList:(NSArray *)selectList
                      unSelectList:(NSArray *)unselectList;

@end
