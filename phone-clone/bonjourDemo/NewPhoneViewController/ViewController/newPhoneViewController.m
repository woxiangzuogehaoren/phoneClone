//
//  newPhoneViewController.m
//  bonjourDemo
//
//  Created by 赵一帆 on 16/4/6.
//  Copyright © 2016年 ZYF. All rights reserved.
//

#import "newPhoneViewController.h"
#import "ReceiveDataViewController.h"
#import "newPhoneView.h"
#import "BarButtonItem.h"
@interface newPhoneViewController ()<BarButtonItemDelegate,NewPhoneViewDelegate>
@property (nonatomic ,strong) newPhoneView * nPhoneView;
@end

@implementation newPhoneViewController
-(void)viewWillAppear:(BOOL)animated{
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    self.navigationController.navigationBar.subviews.firstObject.alpha=1;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
    self.title = @"接收数据";
    self.view.backgroundColor =[UIColor whiteColor];
    // 设置导航默认标题的颜色及字体大小
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor blackColor],
                                                                    
                                                                    NSFontAttributeName : [UIFont boldSystemFontOfSize:15]};
    
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.\
    
    
    
    [self prepare];
    
}
-(void)prepare
{
    BarButtonItem * leftButton = [[BarButtonItem alloc]init];
    leftButton = [leftButton initWithLeftButtonImageName:@"arrow_left"];
    leftButton.delegate = self;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    
    self.nPhoneView =[[newPhoneView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, self.view.height-64)];
    [self.view addSubview: self.nPhoneView];
    self.nPhoneView.delegate = self;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark BarButtonItemDelegate
-(void)leftBarButtonClick{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
#pragma mark NewPhoneViewDelegate
-(void)oldMobilePhoneConnectionPage{
    
    ReceiveDataViewController * receDataView = [[ReceiveDataViewController alloc]init];
    [self.navigationController pushViewController:receDataView animated:YES];
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
