//
//  LBBTabBar.m
//  LiangBenBen
//
//  Created by xue on 2017/1/6.
//  Copyright © 2017年 liangxue. All rights reserved.
//

#import "LBBTabBar.h"
@interface LBBTabBar(){
    
}

@property (nonatomic,strong)UIImageView *tabbarView;

@property (nonatomic,strong) NSArray *itemDataList;

@property (nonatomic,strong) UIButton *lastItem;

@property (nonatomic,strong) UIButton *cameraButton;

@end
@implementation LBBTabBar

- (UIButton *)cameraButton{
    
    if (!_cameraButton) {
        
        _cameraButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
        [_cameraButton setImage:[UIImage imageNamed:@"tab_launch"] forState:UIControlStateNormal];
        [_cameraButton addTarget:self action:@selector(clickItem:) forControlEvents:UIControlEventTouchUpInside];
        [_cameraButton sizeToFit];
        _cameraButton.tag = LBBItemTypeLaunch;
    }
    
    return _cameraButton;
}

- (NSArray *)itemDataList{
    if (!_itemDataList) {
        _itemDataList = @[@"tab_live",@"tab_me"];
    }
    
    return _itemDataList;
}

- (UIImageView *)tabbarView{
    
    if (!_tabbarView) {
        
        _tabbarView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"global_tab_bg"]];
    }
    
    return _tabbarView;
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        //加载背景
        [self addSubview:self.tabbarView];
        
        //加载item
        for (NSInteger i = 0; i < self.itemDataList.count; i++) {
            
            UIButton *item = [UIButton buttonWithType:UIButtonTypeCustom];
            [item setImage:[UIImage imageNamed:self.itemDataList[i]] forState:UIControlStateNormal];
            
            [item setImage:[UIImage imageNamed:[self.itemDataList[i] stringByAppendingString:@"_p"]] forState:UIControlStateSelected];
            item.adjustsImageWhenHighlighted = NO;
            [item addTarget:self action:@selector(clickItem:) forControlEvents:UIControlEventTouchUpInside];
            item.tag = LBBItemTypeLive + i;
            [self addSubview:item];
            
            if (i == 0) {
                
                item.selected = YES;
                
                self.lastItem = item;
            }
        }
        
        [self addSubview:self.cameraButton];
    }
    
    return self;
    
}


- (void)clickItem:(UIButton *)button{
    
    if ([self.delegate respondsToSelector:@selector(tabbar:clickButton:)]) {
        
        [self.delegate tabbar:self clickButton:button.tag];
    }
    
    if (self.block) {
        self.block(self,button.tag);
    }
    
    self.lastItem.selected = NO;
    button.selected = YES;
    self.lastItem = button;
    
    
    if (button.tag == LBBItemTypeLaunch) {
        
        return;
    }
    //按钮动画
    
    [UIView animateWithDuration:0.2 animations:^{
       
        button.transform = CGAffineTransformMakeScale(1.2, 1.2);
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.2 animations:^{
            button.transform = CGAffineTransformIdentity;
        }];
    }];
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    self.tabbarView.frame = self.bounds;
    
    CGFloat width  = self.bounds.size.width/self.itemDataList.count;
    
    
    for (NSInteger i = 0; i < [self subviews].count; i++) {
        
        UIView *btn = [self subviews][i];
        
        if ([btn isKindOfClass:[UIButton class]]) {
            
            btn.frame = CGRectMake((btn.tag - LBBItemTypeLive)*width, 0, width, self.frame.size.height);
        }
    }
    [self.cameraButton sizeToFit];
    
    self.cameraButton.center = CGPointMake(self.center.x, self.bounds.size.height-50);
}
@end
