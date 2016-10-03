//
//  SearchPhoneViewController.m
//  bonjourDemo
//
//  Created by wuqitao on 16/4/14.
//  Copyright © 2016年 ZYF. All rights reserved.
//

#import "SearchPhoneViewController.h"
#import "SearchPhoneView.h"
#import "CCJHaloLayer.h"
#import "BarButtonItem.h"
#import "bonjourHeader.h"
#import "SendDataViewController.h"
#import "DetailsPageView.h"
#import "WaitConnectView.h"
#import "ContactModel.h"
#import <sys/socket.h>
#import <netdb.h>
#import "ConnectionService.h"
#import "LoadingFrame.h"

@interface SearchPhoneViewController ()<SearchPhoneViewDelegate,BarButtonItemDelegate,DetailPageViewDelegate,GCDAsyncSocketDelegate,ConnectionServiceDelegate,NSNetServiceDelegate,NSNetServiceBrowserDelegate>

@property (nonatomic,strong) BarButtonItem * leftButton;

@property (nonatomic,strong) SearchPhoneView * searchPhoneView;
@property (nonatomic,strong) WaitConnectView * waitContectView;
@property (nonatomic,strong) CCJHaloLayer    * halo;
//计时器
@property (nonatomic,strong) CADisplayLink *disPlayLink;

@property (nonatomic,strong) DetailsPageView * detailPageView;

@property (nonatomic,strong) ConnectionService * connectionService;
@property(nonatomic,copy)NSString * parsingIP;
@property(nonatomic,assign)NSInteger port;

@property (nonatomic)GCDAsyncSocket * clientSocket;
@property(nonatomic)GCDAsyncSocket * socket;
@property(nonatomic)NSNetServiceBrowser* browser;
//连接

@property (nonatomic,assign) NSInteger personCount;
@property(nonatomic,strong) NSString * serviceName;
@end

@implementation SearchPhoneViewController
-(void)viewWillAppear:(BOOL)animated{
   
    self.title = @"发送数据";
    self.navigationController.navigationBar.subviews.firstObject.alpha=0;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor blackColor],
                                                                    
                                                                    NSFontAttributeName : [UIFont boldSystemFontOfSize:15]};
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.connectionService = [ConnectionService defaultScoket];
    self.connectionService.delegate = self;
    
}

-(void)viewDidDisappear:(BOOL)animated{
    
    [self.connectionService stopSearchingDevice];
    self.socket = nil;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self prepare];
    //加载定时器
    _disPlayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(delayAnimation)];
    _disPlayLink.frameInterval = 40;//40帧刷新一次
    [_disPlayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];

    
    [self performSelector:@selector(displayNewPhone) withObject:self.halo afterDelay:2.0];
    

}

-(void)prepare{
   
    
    self.leftButton = [[BarButtonItem alloc]init];
    self.leftButton = [self.leftButton initWithLeftButtonImageName:@"arrow_left"];
    self.leftButton.delegate = self;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.leftButton];
    
    self.searchPhoneView = [[SearchPhoneView alloc]init];
    self.searchPhoneView.delegate = self;
    [self.view addSubview:self.searchPhoneView];
    [self.searchPhoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(64);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(self.view.height-64);
    }];
    
    
}

//显示搜索到的手机
-(void)displayNewPhone{
    
    [self.connectionService startSearchingDevice];


}
#pragma mark BarButtonItemDelegate
-(void)leftBarButtonClick{
    [self.searchPhoneView showAndHideTheSearchToThePhone:@"隐藏"];
    [self.navigationController popToRootViewControllerAnimated:YES];
}
#pragma mark NSNetServiceDelegate
//解析服务
-(void)netServiceDidResolveAddress:(NSNetService *)sender{
    
    NSLog(@"解析服务");
    self.port =sender.port;
    NSArray * addressArray = sender .addresses;
    if (addressArray !=nil) {
    struct sockaddr * addr = (struct sockaddr*)[addressArray[0] bytes];

    self.parsingIP =  [self.connectionService nameWithSockaddr:addr];
        
        [self connectPhone];
    }
    else
    {
        NSLog(@"no address found!");
    }
    
}
-(void)netServiceDidStop:(NSNetService *)sender{
    
    NSLog(@"解析超时%ld",sender.port);
    
}
//解析服务失败，解析出错
- (void)netService:(NSNetService *)netService didNotResolve:(NSDictionary *)errorDict {
    
    NSLog(@"解析服务失败，解析出错: %@",errorDict);
    
}
#pragma mark CloneSocketDelegate
//获取搜索到的设备
-(void)settingServers:(NSNetService *)servers{
    NSLog(@"获取搜索到的设备");
    self.serviceName = servers.name;
    [self.searchPhoneView settingServer:servers];
    [self.searchPhoneView showAndHideTheSearchToThePhone:@"显示"];
    
    
}
#pragma mark--连接服务器
-(void)connectionServer
{
    if (!self.socket)
    {
        self.socket =[[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    }
    NSError *error =nil;
    BOOL result = [self .socket connectToHost:self.parsingIP onPort:SOCKETPORT error:&error];
    if (result) {
        NSLog(@"客户端连接服务器成功");
    }else
    {
        NSLog(@"客户端连接服务器失败%@",error);
    }
    
}
#pragma mark SearchPhoneDelegate 搜索
-(void)connectPhone{
    self.waitContectView = [[WaitConnectView alloc]init];
    [self.waitContectView waitContectViewState:self.serviceName];
    [self.view addSubview:self.waitContectView];
    [self.waitContectView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.top.bottom.equalTo(self.view);
        
    }];
    ContactModel * contactModel = [ContactModel shareContactModel];
    self.personCount = [contactModel getNumberOfContacts];
    [self connectionServer];
    [self performSelector:@selector(getIntoSendDataView) withObject:nil afterDelay:3.0];

}

#pragma mark GCDAsyncSocketDelegate
//-(void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port{
//
//    [self.socket readDataWithTimeout:-1 tag:0];
//
//}
#pragma mark--锁屏的时候调用
-(void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err{
    
//    [self.navigationController popToRootViewControllerAnimated:YES];

    LoadingFrame * message = [LoadingFrame single];
    
    [self.view addSubview:[message showMessage:@"退出连接" withDuration:3]];
}

#pragma mark--进入发送数据界面
-(void)getIntoSendDataView{
    
    [self.waitContectView removeFromSuperview];
    
    SendDataViewController * sendDataView = [[SendDataViewController alloc]init];
    sendDataView.socket = [[GCDAsyncSocket alloc]init];
    sendDataView.socket = self.socket;
    sendDataView.personCount = self.personCount;
    [self.navigationController pushViewController:sendDataView animated:YES];
    
    
}

#pragma mark--安装软件页面
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
#pragma mark--DetailPageViewDelegate 详情
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

#pragma mark--搜索动画
- (void)delayAnimation
{
    [self startAnimation];
    [self performSelector:@selector(removeAnimatingTimer) withObject:nil afterDelay:0.8];
}
//开始动画
-(void)startAnimation{
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 128/255.0, 138/255.0, 135/255.0, 1 });
   
    self.halo = [[CCJHaloLayer alloc]initWithColor:colorref];
    self.halo.position = self.searchPhoneView.oldPhoneButton.center;
    [self.searchPhoneView.searchView.layer insertSublayer:self.halo below:self.searchPhoneView.oldPhoneButton.layer];
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


@end
