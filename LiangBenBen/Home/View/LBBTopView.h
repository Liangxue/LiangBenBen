//
//  LBBTopView.h
//  LiangBenBen
//
//  Created by xue on 2017/1/9.
//  Copyright © 2017年 liangxue. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^HomeTopViewBlock)(NSUInteger tag);

@interface LBBTopView : UIView




- (instancetype)initWithFrame:(CGRect)frame titleNames:(NSArray *)titiles;


@property (nonatomic,copy)HomeTopViewBlock block;


- (void)scrolling:(NSUInteger)idx;


@end
