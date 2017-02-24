//
//  LBBNearCell.m
//  LiangBenBen
//
//  Created by xue on 2017/1/12.
//  Copyright © 2017年 liangxue. All rights reserved.
//

#import "LBBNearCell.h"

@implementation LBBNearCell


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.headImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
        
        [self.contentView addSubview:self.headImage];
        
        self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 100, 100, 30)];
        self.nameLabel.text = @"23232";
        [self.contentView addSubview:self.nameLabel];
    }
    return self;
}

- (void)setLive:(LBBLive *)live{
    _live = live;
    
    [self.headImage downloadImage:live.creator.portrait placeholder:nil];
    
    self.nameLabel.text = live.distance;
}

@end
