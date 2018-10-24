//
//  YNTabBarView.m
//  LYPlayCard
//
//  Created by liyangly on 2018/9/12.
//  Copyright © 2018年 makeupopular.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
@interface UIImage (YNColor)

+ (UIImage *)yn_imageNamed:(NSString *)name withTintColor:(UIColor *)color;

@end

@implementation UIImage (YNColor)

+ (UIImage *)yn_imageNamed:(NSString *)name withTintColor:(UIColor *)color {
    
    UIImage *img = [[UIImage imageNamed:name] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIGraphicsBeginImageContextWithOptions(img.size, NO, img.scale);
    [color set];
    [img drawInRect:CGRectMake(0, 0, img.size.width, img.size.height)];
    img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

@end

#import "YNTabBarView.h"
// pod
#import "Masonry.h"


#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)

#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define TARGETED_DEVICE_IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

#define TARGETED_DEVICE_IS_IPHONE_X (TARGETED_DEVICE_IS_IPHONE && (SCREEN_HEIGHT == 812 || SCREEN_HEIGHT == 896))

#define DeviceTabbarHeight    (TARGETED_DEVICE_IS_IPHONE_X ? 83 : 49)

@interface YNTabBarView()

@property (nonatomic, strong) NSMutableArray *btnList;

@end

@implementation YNTabBarView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithImages:(NSArray *)images
                   SelectColor:(UIColor *)selectColor
                 UnSelectColor:(UIColor *)unSelectColor
                   AndBtnWidth:(CGFloat)btnWidth {
    return [self initWithTitles:nil Images:images SelectColor:selectColor UnSelectColor:unSelectColor AndBtnWidth:btnWidth];
}

- (instancetype)initWithTitles:(nullable NSArray *)titles
                        Images:(NSArray *)images
                   SelectColor:(UIColor *)selectColor
                 UnSelectColor:(UIColor *)unSelectColor
                   AndBtnWidth:(CGFloat)btnWidth {
    return [self initWithTitles:titles Images:images SelectColor:selectColor UnSelectColor:unSelectColor titleFont:nil AndBtnWidth:btnWidth];
}

- (instancetype)initWithTitles:(nullable NSArray *)titles
                        Images:(NSArray *)images
                   SelectColor:(UIColor *)selectColor
                 UnSelectColor:(UIColor *)unSelectColor
                     titleFont:(nullable UIFont *)titlefont
                   AndBtnWidth:(CGFloat)btnWidth {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        self.btnList = [NSMutableArray new];
        [self configSubViewsWithTitles:titles Images:images SelectColor:selectColor UnSelectColor:unSelectColor titleFont:titlefont AndBtnWidth:btnWidth];
    }
    return self;
}

- (void)configSubViewsWithTitles:(nullable NSArray *)titles
                          Images:(NSArray *)images
                     SelectColor:(UIColor *)selectColor
                   UnSelectColor:(UIColor *)unSelectColor
                       titleFont:(nullable UIFont *)titlefont
                     AndBtnWidth:(CGFloat)btnWidth {
    
    if (images && images.count > 0) {
        
        BOOL isTitleExist = titles && titles.count == images.count;
        
        for (NSInteger i = 0; i < images.count; i++) {
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [self addSubview:btn];
            btn.frame = CGRectMake(btnWidth * i, 0, btnWidth, DeviceTabbarHeight);
            
            [btn setImage:[UIImage yn_imageNamed:images[i] withTintColor:selectColor] forState:UIControlStateSelected];
            [btn setImage:[UIImage yn_imageNamed:images[i] withTintColor:unSelectColor] forState:UIControlStateNormal];
            
            btn.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
            btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            
            CGFloat imgWidth = btn.imageView.frame.size.width;
            CGFloat imgHeight = btn.imageView.frame.size.height;
            
            if (isTitleExist) {
                [btn setTitle:titles[i] forState:UIControlStateNormal];
                [btn setTitleColor:selectColor forState:UIControlStateSelected];
                [btn setTitleColor:unSelectColor forState:UIControlStateNormal];
                btn.titleLabel.font = [UIFont fontWithName:@"Nunito-SemiBold" size:10];
                
                if (titlefont) {
                    btn.titleLabel.font = titlefont;
                }
                
                [btn.titleLabel sizeToFit];
                CGFloat labelWidth = btn.titleLabel.frame.size.width;
                //                CGFloat labelHeight = btn.titleLabel.frame.size.height;
                
                CGFloat ltop = DeviceTabbarHeight/2 - 10;
                CGFloat lleft = (btnWidth - labelWidth)/2 - imgWidth;
                
                btn.titleEdgeInsets = UIEdgeInsetsMake(ltop, lleft, -ltop, -lleft);
            }
            
            CGFloat itop = (DeviceTabbarHeight - imgHeight)/2;
            if (isTitleExist) {
                itop = DeviceTabbarHeight/2 - imgHeight - 10;
            }
            CGFloat ileft = (btnWidth - imgWidth)/2;
            
            btn.imageEdgeInsets = UIEdgeInsetsMake(itop, ileft, -itop, -ileft);
            
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = i;
            
            if (i == 0) {
                btn.selected = YES;
            }
            
            [self.btnList addObject:btn];
        }
    }
    
}

- (void)btnClick:(UIButton *)sender {
    
    for (UIButton *btn in self.btnList) {
        if (btn.tag == sender.tag) {
            btn.selected = YES;
        } else {
            btn.selected = NO;
        }
    }
    
    if (self.selectItem) {
        self.selectIndex = sender.tag;
        self.selectItem(sender.tag);
    }
}

#pragma mark - Setters
- (void)setSelectIndex:(NSInteger)selectIndex {
    _selectIndex = selectIndex;
    
    for (UIButton *btn in self.btnList) {
        if (btn.tag == selectIndex) {
            btn.selected = YES;
        } else {
            btn.selected = NO;
        }
    }
}

- (void)setImageGap:(CGFloat)imageGap {
    _imageGap = imageGap;
    
    for (UIButton *btn in self.btnList) {
        btn.imageEdgeInsets = UIEdgeInsetsMake(imageGap, 0, imageGap, 0);
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
