//
//  mainViewController.m
//  bonjourDemo
//
//  Created by 赵一帆 on 16/4/6.
//  Copyright © 2016年 ZYF. All rights reserved.
//

#import "MainViewController.h"
#import "mainView.h"
#import "OldPhoneViewController.h"
#import "newPhoneViewController.h"
#import "BarButtonItem.h"
#import "DetailsPageView.h"
#import "FunctionViewController.h"
#import "AboutPageViewController.h"

@interface mainViewController ()<MainViewDelegate,BarButtonItemDelegate,DetailPageViewDelegate>
{
    mainView * main;
    DetailsPageView * detailView;
    NSString * detailName;
}
@end

static BOOL detailViewState = NO;

@implementation mainViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //    [self setNeedsStatusBarAppearanceUpdate];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    //    self.navigationController.navigationBarHidden = YES;
    [self setNeedsStatusBarAppearanceUpdate];
    self.navigationController.navigationBar.subviews.firstObject.alpha=0;
    self.title = @"手机克隆";
    // 设置导航默认标题的颜色及字体大小
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor],
                                                                    
                                                                    NSFontAttributeName : [UIFont boldSystemFontOfSize:15]};
    
    
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    self.navigationController.navigationBar.subviews.firstObject.alpha=1;
}
-(void)viewDidLoad
{
    [super viewDidLoad];
    [self prepareWork];
    

}

-(void)prepareWork
{
    BarButtonItem * rightButton = [[BarButtonItem alloc]init];
    rightButton = [rightButton initWithRightButtonImageName:@"menu_image"];
    rightButton.delegate = self;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    
    main = [mainView new];
    [self.view addSubview:main];
    [main mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.height.equalTo(self.view);
    }];
    main.delegate =self;
    
}
#pragma mark mainViewDelegate
-(void)clickOldPhone
{
    OldPhoneViewController * oldVC =[[OldPhoneViewController alloc] init];
    
    [self.navigationController pushViewController:oldVC animated:YES];
}
-(void)clickNewPhone
{
    newPhoneViewController * newVC =[[newPhoneViewController alloc] init];
    [self.navigationController pushViewController:newVC animated:YES];
}
-(void)installSoftwareForPhone{
    if (detailViewState&& [detailName isEqualToString:@"详情"]) {
        
        [detailView removeFromSuperview];
        detailViewState = NO;
        return;
    }
    detailView = [[DetailsPageView alloc]init];
    detailView.delegate = self;
    [self.view addSubview:detailView];
    [detailView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.top.bottom.equalTo(self.view);
        
    }];
    detailView.installTableView.hidden = NO;
    detailView.detailTabelView.hidden = YES;
 
}
#pragma mark BarButtonItemDelegate
-(void)rightBarButtonClick{

    if (!detailViewState) {
        
        detailView = [[DetailsPageView alloc]init];
         detailView.delegate = self;
        [self.view addSubview:detailView];
        [detailView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.right.top.bottom.equalTo(self.view);
            
        }];
        detailViewState = YES;
        detailName = @"详情";
    }else if([detailName isEqualToString:@"详情"]){
        
        [detailView removeFromSuperview];
        detailViewState = NO;
        
    }

}
#pragma mark DetailPageViewDelegate
-(void)didSelectRow:(NSInteger)tag{
    
    switch (tag) {
        case 0:
            detailView.installTableView.hidden = NO;
            detailView.detailTabelView.hidden = YES;
            detailName = @"邀请安装";
            break;
        case 1:{
            FunctionViewController * functionView = [[FunctionViewController alloc]init];
            [self.navigationController pushViewController:functionView animated:YES];
            [self removeDetailView];
        }
            break;
        case 2:{
            AboutPageViewController * aboutPageView = [[AboutPageViewController alloc]init];
            [self.navigationController pushViewController:aboutPageView animated:YES];
            [self removeDetailView];
        }

            break;
        case 3:
            
            break;
        case 999999:
            [self removeDetailView];
            break;
        default:
            break;
    }
    
}
//移除安装提示框
-(void)removeDetailView{

    [detailView removeFromSuperview];
    detailViewState = NO;
    detailName = @"详情";
    detailView.installTableView.hidden = YES;
    detailView.detailTabelView.hidden = NO;
    
}
//当只有是详情的时候点击屏幕才可以移除
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    if ([detailName isEqualToString:@"详情"]) {
        [detailView removeFromSuperview];
        detailViewState = NO;
    }
    
    
}
@end
