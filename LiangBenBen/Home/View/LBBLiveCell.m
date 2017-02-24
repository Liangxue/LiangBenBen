//
//  LBBLiveCell.m
//  LiangBenBen
//
//  Created by xue on 2017/1/11.
//  Copyright © 2017年 liangxue. All rights reserved.
//

#import "LBBLiveCell.h"

@implementation LBBLiveCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 70)];
        
        [self.contentView addSubview:backView];
        
        self.headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 50, 50)];
        self.headImageView.layer.cornerRadius = 25;
        self.headImageView.layer.masksToBounds = YES;
        [backView addSubview:self.headImageView];
        
        self.nameLabel  = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.headImageView.frame)+10, 10, 100, 30)];
        self.nameLabel.textColor = [UIColor blackColor];
        self.nameLabel.font = [UIFont systemFontOfSize:14];
        [backView addSubview:self.nameLabel];
        
        
        self.locationLabel  = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.headImageView.frame)+10, CGRectGetMaxY(self.nameLabel.frame), 100, 30)];
        self.locationLabel.textColor = [UIColor blackColor];
        self.locationLabel.font = [UIFont systemFontOfSize:14];
        [backView addSubview:self.locationLabel];
        self.onLineLabel  = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-10-100, 10, 100, 30)];
        
        [backView addSubview:self.onLineLabel];

        self.otherLabel  = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-10-100, CGRectGetMaxY(self.onLineLabel.frame), 100, 30)];
        self.otherLabel.textColor = [UIColor blackColor];
        self.otherLabel.font = [UIFont systemFontOfSize:14];
        [backView addSubview:self.otherLabel];

        
        self.bigImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 70, SCREEN_WIDTH, SCREEN_WIDTH)];
        
        [self.contentView addSubview:self.bigImageView];
    }
    
    return self;
}

- (void)setLive:(LBBLive *)live{
    
    _live = live;
    
    if ([live.creator.nick isEqualToString:@"LiangBenBen"]) {
        
        self.headImageView.image = [UIImage  imageNamed:@"WechatIMG90.jpeg"];
        self.bigImageView.image = [UIImage  imageNamed:@"WechatIMG90.jpeg"];
        
    } else {

    [self.headImageView downloadImage:[NSString stringWithFormat:@"%@",live.creator.portrait] placeholder:@""];
    [self.bigImageView downloadImage:[NSString stringWithFormat:@"%@",live.creator.portrait] placeholder:@""];
    }
    self.nameLabel.text = live.creator.nick;
    
    self.locationLabel.text  = live.city;
    self.onLineLabel.text = [@(live.onlineUsers) stringValue];
        self.otherLabel.text = live.distance;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
