//
//  LBBTabBarViewController.m
//  LiangBenBen
//
//  Created by xue on 2017/1/6.
//  Copyright © 2017年 liangxue. All rights reserved.
//

#import "LBBTabBarViewController.h"
#import "LBBTabBar.h"
#import "LBBNavigationController.h"
#import "LBBLaunChViewController.h"
@interface LBBTabBarViewController ()<LBBTabBarDelegate>

@property (nonatomic,strong) LBBTabBar *lbbTabbar;

@end

@implementation LBBTabBarViewController

- (LBBTabBar *)lbbTabbar{
    
    if (!_lbbTabbar) {
        _lbbTabbar = [[LBBTabBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 49)];
        _lbbTabbar.delegate = self;
    }
    
    return _lbbTabbar;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //加载控制器
    [self configViewControllers];
    //加载tabbar
    
    [self.tabBar addSubview:self.lbbTabbar];
    
    [[UITabBar appearance] setShadowImage:[UIImage new]];
    [[UITabBar appearance] setBackgroundImage:[UIImage new]];
    
    // Do any additional setup after loading the view.
}

- (void)configViewControllers{
    
    NSMutableArray * viewControlNames = [NSMutableArray arrayWithArray:@[@"LBBHomeViewController",@"LBBMeViewController"]];

    
    for (NSUInteger i = 0; i < viewControlNames.count; i ++) {
        
        NSString * controllerName = viewControlNames[i];
        
        UIViewController * vc = [[NSClassFromString(controllerName) alloc] init];
        
        LBBNavigationController * nav = [[LBBNavigationController alloc] initWithRootViewController:vc];
        
        [viewControlNames replaceObjectAtIndex:i withObject:nav];
    }
    
    self.viewControllers = viewControlNames;

    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tabbar:(LBBTabBar *)tabbar clickButton:(LBBItemType)index{
    
    if (index != LBBItemTypeLaunch) {
        //当前tabbar的索引
        self.selectedIndex = index - LBBItemTypeLive;
        return;
    }
    
    LBBLaunchViewController *vc = [[LBBLaunchViewController alloc]init];
    
    
    [self presentViewController:vc animated:YES completion:nil];
    
    
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
