//
//  YNTabBarView.m
//  LYPlayCard
//
//  Created by liyangly on 2018/9/12.
//  Copyright © 2018年 makeupopular.com. All rights reserved.
//

#import "YNTabBarView.h"
// pod
#import "Masonry.h"

#ifndef SCREEN_WIDTH
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#endif

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

- (instancetype)initWithSelectList:(NSArray *)selectList
                      unSelectList:(NSArray *)unselectList {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        self.btnList = [NSMutableArray new];
        [self configSubViewsWithSelectList:selectList unSelectList:unselectList];
    }
    return self;
}

- (void)configSubViewsWithSelectList:(NSArray *)selectList
                        unSelectList:(NSArray *)unselectList {
    
    if (selectList.count > 0 && selectList.count == unselectList.count) {
        
        for (NSInteger i = 0; i < selectList.count; i++) {
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            UIImage *unSelectImg = [UIImage imageNamed:unselectList[i]];
            [btn setImage:unSelectImg forState:UIControlStateNormal];
            UIImage *selectImg = [UIImage imageNamed:selectList[i]];
            [btn setImage:selectImg forState:UIControlStateSelected];
            
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = i;
            
            if (i == 0) {
                btn.selected = YES;
            }
            
            CGFloat btnWidth = SCREEN_WIDTH/4;
            CGFloat offsetX = btnWidth * i;
            
            [self addSubview:btn];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.mas_equalTo(self);
                make.left.mas_equalTo(offsetX);
                make.width.mas_equalTo(btnWidth);
            }];
            
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
