//
//  FunctionViewController.m
//  bonjourDemo
//
//  Created by wuqitao on 16/4/21.
//  Copyright © 2016年 ZYF. All rights reserved.
//

#import "FunctionViewController.h"
#import "BarButtonItem.h"
#import "FunctionView.h"
@interface FunctionViewController ()<BarButtonItemDelegate>

@end

@implementation FunctionViewController
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
-(void)prepareWork{
    
    BarButtonItem * leftButton = [[BarButtonItem alloc]init];
    leftButton = [leftButton initWithLeftButtonImageName:@"arrow_left"];
    leftButton.delegate = self;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    
    FunctionView * functionView = [[FunctionView alloc]init];
    [functionView setNeedsDisplay];
    [self.view addSubview:functionView];
    [functionView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.view).offset(5);
        make.top.equalTo(self.view).offset(69);
        make.right.equalTo(self.view).offset(-5);
        make.height.mas_equalTo((SCREENHEIGHT-64)/2);
        
    }];
    
}
-(void)leftBarButtonClick{
    
    [self.navigationController popViewControllerAnimated:YES];
    
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
