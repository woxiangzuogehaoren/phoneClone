//
//  ReceiveDataViewController.m
//  bonjourDemo
//
//  Created by wuqitao on 16/4/15.
//  Copyright © 2016年 ZYF. All rights reserved.
//

#import "ReceiveDataViewController.h"
#import "ReceiveDataView.h"
#import "BarButtonItem.h"
#import "CCJHaloLayer.h"
#import "DetailsPageView.h"
#import "bonjourHeader.h"
#import "OpenService.h"
#import "ContactModel.h"
//#import <ContactsUI/ContactsUI.h>
#import <Contacts/Contacts.h>

@interface ReceiveDataViewController ()<ReceiveDataViewDelegate,BarButtonItemDelegate,DetailPageViewDelegate,OpenServiceDelegate,ContatctModelDelegate>


@property (nonatomic,strong) CCJHaloLayer    * halo;
//计时器
@property (nonatomic,strong) CADisplayLink *disPlayLink;

@property (nonatomic,strong) ReceiveDataView * receiveDataView;

@property (nonatomic,strong) DetailsPageView * detailPageView;

@property (nonatomic,strong) OpenService * openService;
@property (nonatomic,strong) ContactModel * contactModel;

@property (nonatomic)NSNetService *service ;
@end

@implementation ReceiveDataViewController
-(void)viewWillAppear:(BOOL)animated{
    
    self.view.backgroundColor = [UIColor whiteColor];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    //    self.navigationController.navigationBarHidden = YES;
    [self setNeedsStatusBarAppearanceUpdate];
    self.navigationController.navigationBar.subviews.firstObject.alpha=0;
    self.title = @"接收数据";
    // 设置导航默认标题的颜色及字体大小
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor],
                                                                    
                                                                    NSFontAttributeName : [UIFont boldSystemFontOfSize:15]};
    
}
-(void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:animated];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareWork];
    self.openService = [OpenService defaultScoket];
    self.openService.delegate = self;
    [self.openService creatServer];
    
    self.contactModel = [ContactModel shareContactModel];
    self.contactModel.delegate = self;
    
    //加载定时器
    _disPlayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(delayAnimation)];
    _disPlayLink.frameInterval = 40;//40帧刷新一次
    [_disPlayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];

    
//    [self performSelector:@selector(display) withObject:self.halo afterDelay:3.0];

}
-(void)prepareWork{
    
    BarButtonItem * leftButton = [[BarButtonItem alloc]init];
    leftButton = [leftButton initWithLeftButtonImageName:@"ic_back"];
    leftButton.delegate = self;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    
    self.receiveDataView = [[ReceiveDataView alloc]init];
    [self.view addSubview:self.receiveDataView];
    [self.receiveDataView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];
    self.receiveDataView.delegate = self;

}

#pragma mark OpenServiceDelegate
-(void)receivedContactData:(NSData *)data{
    
    if (ISIOS9) {
        NSLog(@"iOS9");
        
//       [self.contactModel addContactsToAddressBook:data];
//        if (array.count) {NSArray * array =
//            CNContactViewController * con = [CNContactViewController viewControllerForContact:[array firstObject]];
//            [self.navigationController pushViewController:con animated:YES];
//        }
        
    }else{
        
        [self.contactModel inputAdressBook:data];
    }
    
}

-(void)startWrite{
    
    [self.receiveDataView displayProgressBar];
    
}
-(void)beingWrittenNumber:(NSInteger)number withTotal:(NSInteger)total{

    [self.receiveDataView changeProgressBarNumber:number withTotal:total];

}
-(void)completeWrite{
    
    [self.receiveDataView hideProgressBar];
    
}

-(void)clientName:(NSInteger)tag{
    switch (tag) {
        case 0:
//             [self.navigationController popToRootViewControllerAnimated:YES];
             [self.openService stop];
             [self.receiveDataView oldPhoneName:@""];
            break;
        case 1:
            [self performSelector:@selector(displayOldPhoneName) withObject:nil afterDelay:3.0];
            break;
        default:
            break;
    }
   
}
-(void)displayOldPhoneName{
    
     [self.receiveDataView oldPhoneName:@"旧手机"];
    
}
#pragma mark ReceiveDataViewDelegate
-(void)installSoftwareForPhone{
    self.detailPageView = [[DetailsPageView alloc]init];
    self.detailPageView.delegate = self;
    [self.view addSubview:self.detailPageView];
    [self.detailPageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.top.bottom.equalTo(self.view);
        
    }];
    self.detailPageView.installTableView.hidden = NO;
    self.detailPageView.detailTabelView.hidden = YES;

}
#pragma mark DetailPageViewDelegate
-(void)didSelectRow:(NSInteger)tag{
    
    switch (tag) {
        case 999999:
            [self.detailPageView removeFromSuperview];
            self.detailPageView.installTableView.hidden = YES;
            self.detailPageView.detailTabelView.hidden = NO;
            break;
            
        default:
            break;
    }
    
    
}
#pragma mark BarButtonItemDelegate
-(void)leftBarButtonClick{
    
    [self.openService stop];
    [self.receiveDataView oldPhoneName:@""];
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}
#pragma mark 搜索动画
- (void)delayAnimation
{
    [self startAnimation];
    [self performSelector:@selector(removeAnimatingTimer) withObject:nil afterDelay:0.8];
}
//开始动画
-(void)startAnimation{
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
  
    
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 225/255.0, 225/255.0, 225/255.0, 1 });
   
    
    
    self.halo = [[CCJHaloLayer alloc]initWithColor:colorref];
    self.halo.position = self.receiveDataView.owmPhoneButton.center;
    [self.receiveDataView.layer insertSublayer:self.halo below:self.receiveDataView.owmPhoneButton.layer];
    [self performSelector:@selector(removeLayer:) withObject:self.halo afterDelay:2.0];
    CGColorRelease(colorref);
    CGColorSpaceRelease(colorSpace);
}
//从视图中移除
- (void)removeLayer:(CALayer *)layer{
    [layer removeFromSuperlayer];
}

-(void)removeAnimatingTimer{
    
    [self.view.layer removeAllAnimations];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
