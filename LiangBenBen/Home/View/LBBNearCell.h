//
//  LBBNearCell.h
//  LiangBenBen
//
//  Created by xue on 2017/1/12.
//  Copyright © 2017年 liangxue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LBBLive.h"
@interface LBBNearCell : UICollectionViewCell
@property (strong, nonatomic)  UIImageView *headImage;
@property (strong, nonatomic)  UILabel *nameLabel;

@property (nonatomic,strong) LBBLive *live;
@end
