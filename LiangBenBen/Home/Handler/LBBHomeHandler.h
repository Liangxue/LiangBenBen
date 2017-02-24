//
//  LBBHomeHandler.h
//  LiangBenBen
//
//  Created by xue on 2017/1/11.
//  Copyright © 2017年 liangxue. All rights reserved.
//

#import "LBBBaseHandler.h"

@interface LBBHomeHandler : LBBBaseHandler

//热门
+ (void)executeGetHoteLiveTaskWithSuccess:(SuccessBlock)success faile:(FailedBlock)faile;

//附近
+ (void)executeGetNearTaskWithSuccess:(SuccessBlock)success faile:(FailedBlock)faile;
//广告
+ (void)executeGetAddTaskWithSuccess:(SuccessBlock)success faile:(FailedBlock)faile;
@end
