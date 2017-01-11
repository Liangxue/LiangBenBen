//
//  LBBHomeViewController.m
//  LiangBenBen
//
//  Created by xue on 2017/1/6.
//  Copyright © 2017年 liangxue. All rights reserved.
//

#import "LBBHomeViewController.h"
#import "LBBTopView.h"
@interface LBBHomeViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;

@property (nonatomic,strong) NSArray *dataList;


@property (nonatomic,strong) LBBTopView *topView;


@end



@implementation LBBHomeViewController


- (LBBTopView *)topView{
    
    if (!_topView) {
        
        _topView = [[LBBTopView alloc]initWithFrame:CGRectMake(0, 0, 200, 50) titleNames:self.dataList];
        
        __weak typeof(self) weakself = self;
        
        _topView.block = ^(NSUInteger tag){
            
            
            CGPoint point = CGPointMake(tag *SCREEN_WIDTH, weakself.contentScrollView.contentOffset.y);
            
            [weakself.contentScrollView setContentOffset:point animated:YES];
        };
    }
    
    return _topView;
}

- (NSArray *)dataList{
    if (!_dataList) {
        
        _dataList = @[@"关注",@"热门",@"附近"];
    }
    
    return _dataList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.contentScrollView.delegate = self;
    [self initUI];
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void)initUI{
    
    
    self.navigationItem.titleView = self.topView;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"global_search"] style:UIBarButtonItemStylePlain target:self action:@selector(leftAction:)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"title_button_more"] style:UIBarButtonItemStylePlain target:self action:@selector(rightAction:)];
    
    //添加子视图控制器
    
    [self setupChildViewControllers];
    
}

- (void)setupChildViewControllers{
    
    NSArray *vcNames = @[@"LBBFocusViewController",@"LBBHotViewController",@"LBBNearViewController"];
    
    for (NSInteger i = 0; i < vcNames.count; i ++) {
        UIViewController *vc = [[NSClassFromString(vcNames[i]) alloc]init];
        vc.title = self.dataList[i];
        
        [self addChildViewController:vc];
        
    }
    //添加view
    
    self.contentScrollView.contentSize = CGSizeMake(SCREEN_WIDTH*self.dataList.count, 0);
    self.contentScrollView.pagingEnabled = YES;
    
    //默认展示第二个页面
    
//    self.contentScrollView.contentOffset
    
    [self scrollViewDidEndScrollingAnimation:self.contentScrollView];
    
}
- (void)leftAction:(UIBarButtonItem*)item{
    
}

- (void)rightAction:(UIBarButtonItem*)item{
    
}

//动画结束
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
    
    //contentScrollView的width
    CGFloat width = SCREEN_WIDTH;//scrollView.frame.size.width;
    
    CGFloat height = SCREEN_HEIGHT;//scrollView.frame.size.height;
    
    CGFloat offsetX = scrollView.contentOffset.x;
    
    //获取索引
    NSInteger index = offsetX / width;
    
    //索引值联动topview
    [self.topView scrolling:index];
    
    UIViewController *vc = self.childViewControllers[index];
    
    if ([vc isViewLoaded]) return;
    
    vc.view.frame = CGRectMake(offsetX, 0, scrollView.frame.size.width, height);
    
    [scrollView addSubview:vc.view];

}
//scrollview delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView

{
    
    
    // called when scroll view grinds to a halt


    [self scrollViewDidEndScrollingAnimation:scrollView];
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
