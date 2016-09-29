//
//  OldPhoneViewController.m
//  bonjourDemo
//
//  Created by 赵一帆 on 16/4/6.
//  Copyright © 2016年 ZYF. All rights reserved.
//

#import "OldPhoneViewController.h"
#import "SearchPhoneViewController.h"
#import "oldPhoneView.h"
#import "BarButtonItem.h"

@interface OldPhoneViewController ()<OldPhoneViewDelegate,BarButtonItemDelegate>
@property(nonatomic ,strong)oldPhoneView * oPhoneView;

@end

@implementation OldPhoneViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    self.navigationController.navigationBar.subviews.firstObject.alpha=1;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
    self.title = @"连接新手机热点";
    self.view.backgroundColor =[UIColor whiteColor];
    // 设置导航默认标题的颜色及字体大小
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor blackColor],
                                                                    
                                                                    NSFontAttributeName : [UIFont boldSystemFontOfSize:15]};
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self prepare];

}
-(void)prepare
{
    
    BarButtonItem * leftButton = [[BarButtonItem alloc]init];
    leftButton = [leftButton initWithLeftButtonImageName:@"arrow_left"];
    leftButton.delegate = self;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    
    self.oPhoneView =[[oldPhoneView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, self.view.height-64)];
    self.oPhoneView.delegate = self;
    [self.view addSubview:self.oPhoneView];

    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)searchForMobilePhones{
    SearchPhoneViewController * searchPhoneViewController = [[SearchPhoneViewController alloc]init];
    
    [self.navigationController pushViewController:searchPhoneViewController animated:YES];
    NSLog(@"搜索手机");
    
    
}
-(void)leftBarButtonClick{
    
    [self.navigationController popViewControllerAnimated:YES];

}
@end
