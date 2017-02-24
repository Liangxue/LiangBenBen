//
//  LBBLocationManager.m
//  LiangBenBen
//
//  Created by xue on 2017/1/11.
//  Copyright © 2017年 liangxue. All rights reserved.
//

#import "LBBLocationManager.h"
#import <CoreLocation/CoreLocation.h>

@interface LBBLocationManager()<CLLocationManagerDelegate>

@property (nonatomic,strong) CLLocationManager *locManager;

@property (nonatomic,strong) LocationBlock block;

@end

@implementation LBBLocationManager

+ (instancetype)sharedManager{
    
    static LBBLocationManager *_manager;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[LBBLocationManager  alloc]init];
    });
    
    return _manager;
}


- (instancetype)init{
    
    self = [super init];
    if (self) {
        _locManager = [[CLLocationManager alloc]init];
        
        _locManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locManager.distanceFilter = 100;
        _locManager.delegate = self;
        
        if (![CLLocationManager locationServicesEnabled]) {
            
            //开启定位服务
        }else{
            
            CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
            if (status == kCLAuthorizationStatusNotDetermined) {
                
                [_locManager requestWhenInUseAuthorization];
            }
        }
    }
    
    return self;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    
    CLLocation *currLocation = [locations lastObject];
    
    NSString *lat = [NSString stringWithFormat:@"%@",@(currLocation.coordinate.latitude)];
    NSString *lon = [NSString stringWithFormat:@"%@",@(currLocation.coordinate.longitude*-1)];

    NSLog(@"经度=%f 纬度=%f 高度=%f", currLocation.coordinate.latitude, currLocation.coordinate.longitude, currLocation.altitude);
    [LBBLocationManager sharedManager].lon = lon;
    [LBBLocationManager sharedManager].lat = lat;
    self.block(lat,lon);
    
    [self.locManager stopUpdatingLocation];
}

- (void)getGps:(LocationBlock)block{
    
    self.block = block;
    
    [self.locManager startUpdatingLocation];
}
@end
