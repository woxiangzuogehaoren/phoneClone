//
//  CloneSocket.m
//  bonjourDemo
//
//  Created by wuqitao on 16/5/3.
//  Copyright © 2016年 ZYF. All rights reserved.
//

#import "ConnectionService.h"
#import <sys/socket.h>
#import <netdb.h>
#import "bonjourHeader.h"
static ConnectionService * _connectionService = nil;

@interface ConnectionService()<GCDAsyncSocketDelegate,NSNetServiceDelegate,NSNetServiceBrowserDelegate>

@property (nonatomic)GCDAsyncSocket * clientSocket;
@property(nonatomic)GCDAsyncSocket * socket;
@property(nonatomic)NSNetServiceBrowser* browser;


@end

@implementation ConnectionService
//初始化单例
+(ConnectionService *)defaultScoket
{

    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _connectionService =[[ConnectionService alloc] init];
    });
    return _connectionService;
}
//开始搜索设备
-(void)startSearchingDevice{
    NSLog(@"开启搜索");
    if (!self.browser)
    {
        self.browser =[[NSNetServiceBrowser alloc] init];
    }
    self.browser.includesPeerToPeer =YES;
    self.browser.delegate=self;
    [self.browser searchForServicesOfType:KBonjourType inDomain:KBrowserDomainString];

    
}
//停止搜索设备
-(void)stopSearchingDevice{
    
    [self.browser stop];
    self .browser =nil;
}

#pragma mark NSNetServiceDelegate,NSNetServiceBrowserDelegate
//搜索
-(void)netServiceBrowser:(NSNetServiceBrowser *)browser didFindService:(NSNetService *)service moreComing:(BOOL)moreComing{

    if (!moreComing) {

        if ([self.delegate respondsToSelector:@selector(settingServers:)]) {

            [self.delegate settingServers:service];
        }
    }
}
-(void)netServiceBrowser:(NSNetServiceBrowser *)browser didRemoveService:(NSNetService *)service moreComing:(BOOL)moreComing
{

    if (!moreComing) {

        
    }
    
}

-(void)netServiceBrowser:(NSNetServiceBrowser *)browser didNotSearch:(NSDictionary<NSString *,NSNumber *> *)errorDict
{
    NSLog(@"no search ");
}
//获取ip地址
-(NSString*)nameWithSockaddr:(struct sockaddr*)sadr
{
    char host[1024];
    char serv[20];
    NSInteger ss =0;
    ss= getnameinfo(sadr,sizeof sadr,host,sizeof( host),serv,sizeof (serv),NI_NUMERICHOST | NI_NUMERICSERV);
    return [NSString stringWithUTF8String:host];
    
}

@end
