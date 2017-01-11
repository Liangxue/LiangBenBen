//
//  LBBHomeHandler.m
//  LiangBenBen
//
//  Created by xue on 2017/1/11.
//  Copyright © 2017年 liangxue. All rights reserved.
//

#import "LBBHomeHandler.h"
#import "HttpTool.h"
#import "LBBLive.h"

@implementation LBBHomeHandler

+ (void)executeGetHoteLiveTaskWithSuccess:(SuccessBlock)success faile:(FailedBlock)faile{
    
    [HttpTool postWithPath:API_LiveGetTop params:@{} success:^(id json) {
        
        if ([json[@"dm_error"] boolValue]) {
            faile(json);
        }else{
            //数据解析
            
          NSArray *lives = [LBBLive mj_objectArrayWithKeyValuesArray:json[@"lives"]];
            success(lives);
        }
        
    } failure:^(NSError *error) {
       
        faile(error);
    }];
}

@end
