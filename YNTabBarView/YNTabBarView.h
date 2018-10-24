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

@property (nonatomic, copy) void (^selectItem)(NSInteger index);

- (instancetype)initWithImages:(NSArray *)images
                   SelectColor:(UIColor *)selectColor
                 UnSelectColor:(UIColor *)unSelectColor
                   AndBtnWidth:(CGFloat)btnWidth;

- (instancetype)initWithTitles:(nullable NSArray *)titles
                        Images:(NSArray *)images
                   SelectColor:(UIColor *)selectColor
                 UnSelectColor:(UIColor *)unSelectColor
                   AndBtnWidth:(CGFloat)btnWidth;

- (instancetype)initWithTitles:(nullable NSArray *)titles
                        Images:(NSArray *)images
                   SelectColor:(UIColor *)selectColor
                 UnSelectColor:(UIColor *)unSelectColor
                     titleFont:(nullable UIFont *)titlefont
                   AndBtnWidth:(CGFloat)btnWidth;

@end
