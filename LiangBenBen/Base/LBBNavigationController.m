//
//  LBBNavigationController.m
//  LiangBenBen
//
//  Created by xue on 2017/1/6.
//  Copyright © 2017年 liangxue. All rights reserved.
//

#import "LBBNavigationController.h"

@interface LBBNavigationController ()

@end

@implementation LBBNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navigationBar.barTintColor = RGBCOLOR(0, 261, 201);
    
    self.navigationBar.tintColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    [super pushViewController:viewController animated:animated];
    if (self.viewControllers.count) {
        self.hidesBottomBarWhenPushed = YES;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
