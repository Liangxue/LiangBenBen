//
//  LBBFocusViewController.m
//  LiangBenBen
//
//  Created by xue on 2017/1/6.
//  Copyright © 2017年 liangxue. All rights reserved.
//

#import "LBBFocusViewController.h"
#import "LBBPlayerViewController.h"
#import "LBBHomeHandler.h"
#import "LBBLiveCell.h"
@interface LBBFocusViewController ()

@property (nonatomic,strong) NSMutableArray *dataList;

@end

@implementation LBBFocusViewController




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
    LBBLiveCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LiveCell"];
    cell.live = self.dataList[indexPath.row];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LBBPlayerViewController * player = [[LBBPlayerViewController alloc]init];
    player.live = self.dataList[indexPath.row];
    player.hidesBottomBarWhenPushed =YES;

    [self.navigationController pushViewController:player animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[LBBLiveCell class] forCellReuseIdentifier:@"LiveCell"];
//    [LBBHomeHandler executeGetHoteLiveTaskWithSuccess:^(id obj) {
//        
//        NSLog(@"%@",obj);
//        
//        [self.dataList addObjectsFromArray:obj];
//        
//        [self.tableView reloadData];
//    } faile:^(id obj) {
//        
//        NSLog(@"error %@",obj);
//        
//    }];
    
    LBBLive *live = [[LBBLive alloc]init];
    
    LBBCreator *creator = [[LBBCreator alloc]init];
    
    live.creator = creator;
    
    live.streamAddr = Live_LiangBenBen;
    live.city = @"北京";
    live.onlineUsers = 100;
    live.creator.nick = @"LiangBenBen";
    [self.dataList addObject:live];

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
