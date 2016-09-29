//
//  AboutPageViewController.m
//  bonjourDemo
//
//  Created by wuqitao on 16/4/21.
//  Copyright © 2016年 ZYF. All rights reserved.
//

#import "AboutPageViewController.h"
#import "BarButtonItem.h"
#import "AboutPageView.h"
#import "PrivacyViewController.h"
@interface AboutPageViewController ()<BarButtonItemDelegate,AboutPageViewDelegate>

@end

@implementation AboutPageViewController
-(void)viewWillAppear:(BOOL)animated{
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    self.navigationController.navigationBar.subviews.firstObject.alpha=1;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
    self.title = @"功能介绍";
    self.view.backgroundColor =[UIColor whiteColor];
    // 设置导航默认标题的颜色及字体大小
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor blackColor],
                                                                    
                                                                    NSFontAttributeName : [UIFont boldSystemFontOfSize:15]};
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareWork];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)prepareWork{
    
    
    BarButtonItem * leftButton = [[BarButtonItem alloc]init];
    leftButton = [leftButton initWithLeftButtonImageName:@"arrow_left"];
    leftButton.delegate = self;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    
    AboutPageView * aboutPageView = [[AboutPageView alloc]init];
    aboutPageView.deldgate = self;
    [self.view addSubview:aboutPageView];
    [aboutPageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self.view);
    }];
    
}
-(void)privacyPolicy{
    
//    //push时的跳转动画；
//    CATransition *animation = [CATransition animation];
//    [animation setDuration:0.2];
//    //过渡类型；
//    [animation setType: kCATransitionReveal];
//    //这个是设置界面进入的方向；
//    [animation setSubtype: kCATransitionFromTop];
//    //界面进入的时间函数；
//    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
//    [self.navigationController.view.layer addAnimation:animation forKey:nil];
    PrivacyViewController * privacyView = [[PrivacyViewController alloc]init];
    
    [self.navigationController pushViewController:privacyView animated:YES];
    
}
-(void)leftBarButtonClick{
    
    [self.navigationController popViewControllerAnimated:YES];
    
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
