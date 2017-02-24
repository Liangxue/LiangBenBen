//
//  LBBLaunchViewController.m
//  LiangBenBen
//
//  Created by xue on 2017/1/6.
//  Copyright © 2017年 liangxue. All rights reserved.
//

#import "LBBLaunchViewController.h"
#import "LFLivePreview.h"
@interface LBBLaunchViewController ()
@property (weak, nonatomic) IBOutlet UIButton *address;

@end

@implementation LBBLaunchViewController
- (IBAction)closeLaunch:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)liveButtton:(UIButton *)sender {
    UIView * back = [[UIView alloc] initWithFrame:self.view.bounds];
    back.backgroundColor = [UIColor blackColor];
    [self.view addSubview:back];

    
    LFLivePreview *liveView = [[LFLivePreview alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:liveView];
    liveView.liveUrl = Live_LiangBenBen;
    [liveView startLive];
}

- (IBAction)address:(UIButton *)sender{
    
}


- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
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
