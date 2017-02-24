//
//  LBBCacheHelper.m
//  LiangBenBen
//
//  Created by xue on 2017/1/12.
//  Copyright © 2017年 liangxue. All rights reserved.
//

#import "LBBCacheHelper.h"

@implementation LBBCacheHelper

+ (NSString *)getAdvertiseImage{
    
   return  [[NSUserDefaults standardUserDefaults] objectForKey:@"adImageName"];
}

+ (void)setAdvertiseImage:(NSString *)imageName{
    [[NSUserDefaults standardUserDefaults] setObject:imageName forKey:@"adImageName"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
@end
