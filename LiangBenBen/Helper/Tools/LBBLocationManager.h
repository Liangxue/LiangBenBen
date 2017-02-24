//
//  LBBLocationManager.h
//  LiangBenBen
//
//  Created by xue on 2017/1/11.
//  Copyright © 2017年 liangxue. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^LocationBlock)(NSString *lat, NSString *lon);


@interface LBBLocationManager : NSObject

+ (instancetype) sharedManager;

- (void)getGps:(LocationBlock)block;

@property (nonatomic,copy) NSString *lat;
@property (nonatomic,copy) NSString *lon;

@end
