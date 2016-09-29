//
//  PrivacyViewController.m
//  bonjourDemo
//
//  Created by wuqitao on 16/4/22.
//  Copyright © 2016年 ZYF. All rights reserved.
//

#import "PrivacyViewController.h"
#import "BarButtonItem.h"
@interface PrivacyViewController ()<BarButtonItemDelegate>

@end

@implementation PrivacyViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
   
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
     [self prepareWork];
    // Do any additional setup after loading the view.
}
-(void)prepareWork{
    
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.subviews.firstObject.alpha=1;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
    self.title = @"隐私政策";
    self.view.backgroundColor =[UIColor whiteColor];
    // 设置导航默认标题的颜色及字体大小
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor blackColor],
                                                                    
                                                                    NSFontAttributeName : [UIFont boldSystemFontOfSize:15]};
    BarButtonItem * leftButton = [[BarButtonItem alloc]init];
    leftButton = [leftButton initWithLeftButtonImageName:@"arrow_left"];
    leftButton.delegate = self;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    
    NSString * privacyPath = [[NSBundle mainBundle]pathForResource:@"Privacy" ofType:@"txt"];
    
    NSString * privacyStr= [[NSString alloc]initWithContentsOfFile:privacyPath encoding:NSUTF8StringEncoding error:nil];
    
    NSLog(@"%@",privacyStr);
    
    UITextView * privacyTextView = ({
    
        UITextView * textView = [[UITextView alloc]init];
        textView.editable = NO;
        textView.text = privacyStr;
        textView.textColor = [UIColor blackColor];
        textView.font = [UIFont systemFontOfSize:12];
        textView;
    });
    [self.view addSubview:privacyTextView];
    [privacyTextView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).offset(64);
        
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
