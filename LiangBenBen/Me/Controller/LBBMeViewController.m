//
//  LBBMeViewController.m
//  LiangBenBen
//
//  Created by xue on 2017/1/13.
//  Copyright © 2017年 liangxue. All rights reserved.
//

#import "LBBMeViewController.h"
#import "LBBSetting.h"
#import "LBBMeInfoView.h"
@interface LBBMeViewController ()



@property (nonatomic,strong) LBBMeInfoView *infoView;

@property (nonatomic,strong) NSMutableArray *dataList;

@end

@implementation LBBMeViewController
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear: animated];
    
    self.navigationController.navigationBarHidden = NO;
}

- (LBBMeInfoView *)infoView{
    
    if (!_infoView) {
        _infoView = [LBBMeInfoView loadInfoView];
    }
    
    return _infoView;
}

- (void)search:(UIButton*)sender{
    
    NSLog(@"search");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = RGBCOLOR(234, 200, 100);
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.rowHeight = 60;
    self.tableView.sectionFooterHeight = 5;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 30, 0);

    
    
    [self loadData];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)loadData {
    
    LBBSetting *set1 = [[LBBSetting alloc]init];
    set1.title = @"映客贡献榜";
    set1.subtitle = @"";
    set1.vcName = @"";
    
    LBBSetting *set2 = [[LBBSetting alloc]init];
    set2.title = @"收益";
    set2.subtitle = @"0映票";
    set2.vcName = @"";

    LBBSetting *set3 = [[LBBSetting alloc]init];

    set3.title = @"账户";
    set3.subtitle = @"0钻石";
    set3.vcName = @"";
    LBBSetting *set4 = [[LBBSetting alloc]init];
    set4.title = @"等级";
    set4.subtitle = @"3级";
    set4.vcName = @"";

    LBBSetting *set5 = [[LBBSetting alloc]init];
    set5.title = @"实名认证";
    set5.subtitle = @"";
    set5.vcName = @"";

    
    LBBSetting *set6 = [[LBBSetting alloc]init];
    
    set6.title = @"设置";
    set6.subtitle = @"";
    set6.vcName = @"";
    NSArray * arr1 = @[set1,set2,set3];
    NSArray * arr2 = @[set4,set5];
    NSArray * arr3 = @[set6];
    
    self.dataList = [@[arr1,arr2,arr3] mutableCopy];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.dataList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSArray * arr = self.dataList[section];
    
    return arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    
    LBBSetting * set = self.dataList[indexPath.section][indexPath.row];
    
    cell.textLabel.text = set.title;
    cell.textLabel.textColor = [UIColor grayColor];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.detailTextLabel.text = set.subtitle;
    cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        return self.infoView;
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        return SCREEN_HEIGHT / 2;
    }
    
    return 0.1;
}

@end
