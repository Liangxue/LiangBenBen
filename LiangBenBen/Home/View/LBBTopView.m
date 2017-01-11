//
//  LBBTopView.m
//  LiangBenBen
//
//  Created by xue on 2017/1/9.
//  Copyright © 2017年 liangxue. All rights reserved.
//

#import "LBBTopView.h"

@interface LBBTopView()

@property (nonatomic,strong) UIView *lineView;

@property (nonatomic,strong) NSMutableArray *buttons;

@end

@implementation LBBTopView

- (NSMutableArray *)buttons{
    if (!_buttons) {
        
        _buttons = [NSMutableArray array];
    }
    
    return _buttons;
}

- (instancetype)initWithFrame:(CGRect)frame titleNames:(NSArray *)titiles{
    
    self = [super initWithFrame:frame];
    if (self) {
       
        CGFloat btnW = self.frame.size.width/titiles.count;
        
        CGFloat btnH = self.frame.size.height;
        
        for (NSInteger i = 0; i < titiles.count; i++) {
            
            UIButton *titlesBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [titlesBtn setTitle:titiles[i] forState:UIControlStateNormal];
            
            [titlesBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            titlesBtn.frame = CGRectMake(i * btnW, 0, btnW, btnH);
            
            [titlesBtn addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
            titlesBtn.tag = i ;
            [self.buttons addObject:titlesBtn];
            [self addSubview:titlesBtn];
            
            if (i == 1) {
                
                CGFloat h = 2.0;
                CGFloat y = 40;
                
                [titlesBtn.titleLabel sizeToFit];
                
                self.lineView = [[UIView alloc]init];
                
                self.lineView.frame = CGRectMake(i*btnW, y, titlesBtn.frame.size.width, h);
                
//                self.lineView.center = titlesBtn.center;
                
                self.lineView.backgroundColor = [UIColor whiteColor];
                
                [self addSubview:self.lineView];
            }
            
        }
    }
    
    return self;
}

//home滚动时调用
- (void)scrolling:(NSUInteger)idx{
    
    UIButton *sender = self.buttons[idx];
    
    [UIView animateWithDuration:0.5 animations:^{
        
        CGFloat h = 2.0;
        CGFloat y = 40;
        CGFloat w = sender.frame.size.width;
        
        self.lineView.frame = CGRectMake(sender.center.x-w/2, y, w, h);
    }];
}
//点击事件
- (void)titleClick:(UIButton *)sender{
    
    
    self.block(sender.tag);
    
    [UIView animateWithDuration:0.5 animations:^{
       
        CGFloat h = 2.0;
        CGFloat y = 40;
        CGFloat w = sender.frame.size.width;
        
        self.lineView.frame = CGRectMake(sender.center.x-w/2, y, w, h);
    }];
}
@end
