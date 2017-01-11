//
//  LBBBaseHandler.h
//  LiangBenBen
//
//  Created by xue on 2017/1/11.
//  Copyright © 2017年 liangxue. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^CompleteBlock)();


typedef void(^SuccessBlock)(id obj);

typedef void(^FailedBlock)(id obj);

@interface LBBBaseHandler : NSObject



@end
