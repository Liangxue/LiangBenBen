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
#import "LBBLocationManager.h"
#import "LBBAddModel.h"
@implementation LBBHomeHandler


//获取热门信息

+ (void)executeGetHoteLiveTaskWithSuccess:(SuccessBlock)success faile:(FailedBlock)faile{
    
    [HttpTool getWithPath:API_LiveGetTop params:@{} success:^(id json) {
        
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


//获取附近直播

+ (void)executeGetNearTaskWithSuccess:(SuccessBlock)success faile:(FailedBlock)faile{
    
    LBBLocationManager *manager = [LBBLocationManager sharedManager];
    
    NSDictionary *params =
//  @{@"uid":@"85149891",@"latitude":@"40.090562",@"longitude":@"116.413353"};

  @{@"uid":@"85149891",@"latitude":manager.lat,@"longitude":manager.lon};
    [HttpTool getWithPath:API_NearLocation params:params success:^(id json) {
//        success(json);

        NSInteger error = [json[@"dm_error"] integerValue];
        
        if (!error) {
            
            NSArray * lives = [LBBLive mj_objectArrayWithKeyValuesArray:json[@"lives"]];
            
            success(lives);
            
        } else {
            
            faile(json);
            
        }
    } failure:^(NSError *error) {
        
        faile(error);
    }];
}

+ (void)executeGetAddTaskWithSuccess:(SuccessBlock)success faile:(FailedBlock)faile{
    
    [HttpTool getWithPath:API_Advertise params:nil success:^(id json) {
        
        NSInteger error = [json[@"dm_error"] integerValue];
        
        if (!error) {

        LBBAddModel * addModel = [LBBAddModel mj_objectWithKeyValues:json[@"resources"][0]];
        
            success(addModel);
        }

    } failure:^(NSError *error) {
        
        faile(error);
    }];
}


@end
