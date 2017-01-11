//
//  LBBHomeHandler.h
//  LiangBenBen
//
//  Created by xue on 2017/1/11.
//  Copyright © 2017年 liangxue. All rights reserved.
//

#import "LBBBaseHandler.h"

@interface LBBHomeHandler : LBBBaseHandler

+ (void)executeGetHoteLiveTaskWithSuccess:(SuccessBlock)success faile:(FailedBlock)faile;

@end
