//
//  LBBTabBar.h
//  LiangBenBen
//
//  Created by xue on 2017/1/6.
//  Copyright © 2017年 liangxue. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,LBBItemType) {
    
    LBBItemTypeLaunch = 10,
    
    LBBItemTypeLive = 100,//展示直播
    LBBItemTypeMe,
};

@class LBBTabBar;

//

typedef void(^TabBarBlock)(LBBTabBar *tabbar,LBBItemType index);

//

@protocol LBBTabBarDelegate <NSObject>

- (void)tabbar:(LBBTabBar *)tabbar clickButton:(LBBItemType) index;


@end


@interface LBBTabBar : UIView


@property (nonatomic,weak) id <LBBTabBarDelegate> delegate;

//
@property (nonatomic,copy) TabBarBlock block;
//
@end
