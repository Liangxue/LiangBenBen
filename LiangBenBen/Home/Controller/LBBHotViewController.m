//
//  LBBHotViewController.m
//  LiangBenBen
//
//  Created by xue on 2017/1/6.
//  Copyright © 2017年 liangxue. All rights reserved.
//

#import "LBBHotViewController.h"
#import "LBBHomeHandler.h"
#import "LBBLiveCell.h"
#import "LBBPlayerViewController.h"
@interface LBBHotViewController ()
@property (nonatomic,strong) NSMutableArray *dataList;
@end

@implementation LBBHotViewController

- (NSMutableArray *)dataList{
    if (!_dataList) {
        _dataList = [NSMutableArray array];
    }
    
    return _dataList;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return SCREEN_WIDTH+70;

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LBBLiveCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LBBLiveCell"];
    cell.live = self.dataList[indexPath.row];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LBBPlayerViewController * player = [[LBBPlayerViewController alloc]init];
    player.live = self.dataList[indexPath.row];
    [self.navigationController pushViewController:player animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[LBBLiveCell class] forCellReuseIdentifier:@"LBBLiveCell"];
    [LBBHomeHandler executeGetHoteLiveTaskWithSuccess:^(id obj) {
        
        NSLog(@"%@",obj);
        
        [self.dataList addObjectsFromArray:obj];
        
        [self.tableView reloadData];
    } faile:^(id obj) {
        
        NSLog(@"error %@",obj);
        
    }];

    // Do any additional setup after loading the view from its nib.
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
