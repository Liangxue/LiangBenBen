//
//  LBBLiveCell.h
//  LiangBenBen
//
//  Created by xue on 2017/1/11.
//  Copyright © 2017年 liangxue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LBBLive.h"
@interface LBBLiveCell : UITableViewCell

@property (nonatomic,strong) UIImageView *headImageView;
@property (nonatomic,strong) UILabel *nameLabel;

@property (nonatomic,strong) UILabel *locationLabel;

@property (nonatomic,strong) UILabel *onLineLabel;

@property (nonatomic,strong) UILabel *otherLabel;

@property (nonatomic,strong) UIImageView *bigImageView;

@property (nonatomic,strong) LBBLive *live;

@end
