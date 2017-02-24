//
//  LBBMeInfoView.m
//  LiangBenBen
//
//  Created by xue on 2017/1/13.
//  Copyright © 2017年 liangxue. All rights reserved.
//

#import "LBBMeInfoView.h"

@interface LBBMeInfoView ()

@end


@implementation LBBMeInfoView


+ (instancetype)loadInfoView{
    
    return [[[NSBundle mainBundle] loadNibNamed:@"LBBMeInfoView" owner:self options:nil] lastObject];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
