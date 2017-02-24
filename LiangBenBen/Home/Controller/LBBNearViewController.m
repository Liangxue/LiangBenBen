//
//  LBBNearViewController.m
//  LiangBenBen
//
//  Created by xue on 2017/1/6.
//  Copyright © 2017年 liangxue. All rights reserved.
//

#import "LBBNearViewController.h"
#import "LBBHomeHandler.h"
#import "LBBNearCell.h"

#import "LBBPlayerViewController.h"
#define kItemSizeW 100
#define kMargin 5
@interface LBBNearViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>{
    UICollectionView *mainCollectionView;

}

@property(nonatomic,strong) NSArray *dataList;

@end

@implementation LBBNearViewController

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat outInset = SCREEN_WIDTH - 2 * kMargin;
    NSInteger count = outInset / kItemSizeW;
    NSInteger extraTotal = (NSInteger)(outInset - kMargin * (count - 1 ));
    
    CGFloat itemWH;
    
    if (extraTotal < count * kItemSizeW) {
        
        itemWH = extraTotal / count;
        
    } else {
        
        CGFloat extraWidth = extraTotal % kItemSizeW;
        itemWH = kItemSizeW + extraWidth / count;
    }
    
    return CGSizeMake(itemWH, itemWH + 35);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    //1.初始化layout
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //设置collectionView滚动方向
    //    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    //设置headerView的尺寸大小
//    layout.headerReferenceSize = CGSizeMake(self.view.frame.size.width, 100);
    //该方法也可以设置itemSize
//    layout.itemSize =CGSizeMake(110, 150);
    
    //2.初始化collectionView
    mainCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH - 20, SCREEN_HEIGHT) collectionViewLayout:layout];
    [self.view addSubview:mainCollectionView];
    mainCollectionView.backgroundColor = [UIColor clearColor];
    
    //3.注册collectionViewCell
    [mainCollectionView registerClass:[LBBNearCell class] forCellWithReuseIdentifier:@"cellId"];
    

    
    //4.设置代理
    mainCollectionView.delegate = self;
    mainCollectionView.dataSource = self;
    
    [LBBHomeHandler executeGetNearTaskWithSuccess:^(id obj) {
        
                self.dataList = obj;
        
        
            [mainCollectionView reloadData];

        
    } faile:^(id obj) {
                
}];
}


#pragma mark collectionView代理方法
//返回section个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    LBBNearCell *cell = (LBBNearCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    cell.live = self.dataList[indexPath.row];
    
    
    return cell;
}



////设置每个item的UIEdgeInsets
//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//    return UIEdgeInsetsMake(10, 10, 10, 10);
//}

//设置每个item水平间距
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
//{
//    return 10;
//}


//设置每个item垂直间距
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
//{
//    return 15;
//}



//点击item方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    LBBPlayerViewController *player = [[LBBPlayerViewController alloc]init];
    
    player.live = self.dataList[indexPath.row];
    player.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:player animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
