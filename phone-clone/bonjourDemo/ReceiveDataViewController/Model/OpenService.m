//
//  openService.m
//  bonjourDemo
//
//  Created by wuqitao on 16/5/4.
//  Copyright © 2016年 ZYF. All rights reserved.
//

#import "OpenService.h"
#import "LoadingFrame.h"
#import "ContactModel.h"

static OpenService * _openService = nil;
@interface OpenService()<NSNetServiceDelegate,NSNetServiceBrowserDelegate,GCDAsyncSocketDelegate>
@property (nonatomic,strong) NSString * IP;
@property (nonatomic)NSNetService *localService ;
@property(nonatomic)GCDAsyncSocket * serverSocket;
@property(nonatomic)GCDAsyncSocket * clientSocket;
@property (nonatomic,strong)NSMutableData * mutableData;
@property (nonatomic,strong)NSData * endData;
@end

@implementation OpenService
//创建单例
+(OpenService*)defaultScoket{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _openService = [[OpenService alloc]init];
        _openService.mutableData = [NSMutableData data];
        _openService.endData = [CONTACT dataUsingEncoding:NSUTF8StringEncoding];
    });
    
    return _openService;
}
//退出页面是 停止服务
-(void)stop
{
    [self.localService stop];
    self.serverSocket = nil;
    self.localService.includesPeerToPeer =NO;
    self.localService =nil;
    
}
//开启服务
-(void)creatServer{
    NSLog(@"开启服务");
    self.IP = [ipTools getIPAddress:YES IPArray:NULL];
    if (!self.localService) {
        
        self.localService = [[NSNetService alloc] initWithDomain:KDomainString type:KBonjourType name:[UIDevice currentDevice].name ];
        
    }
    //一定要先开启，指定是否发布，解决，监听服务，在对蓝牙和WIFI可用，没有默认值。
    //此属性必须设置调用发布或publishwithoptions之前，resolvewithtimeout：`，或startmonitoring才能生效。
    self.localService.includesPeerToPeer =YES;
    
    self.localService .delegate=self;
    
    [self.localService publishWithOptions:NSNetServiceListenForConnections];
    
}
//发布成功的回调
-(void)netServiceDidPublish:(NSNetService *)sender
{
    NSLog(@"_____发布成功______");
    [self startListening];
}
//发布失败的回调
-(void)netService:(NSNetService *)sender didNotPublish:(NSDictionary<NSString *,NSNumber *> *)errorDict
{
    NSLog(@"————————发布失败——————————");
}

//开起监听
-(void)startListening
{
    //1.创建服务器socket
    if (!self.serverSocket) {
        NSLog(@"创建服务器socket");
        self.serverSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    }
    //2.开始监听（开放哪一个端口）
    NSError *error = nil;
    BOOL result = [self.serverSocket acceptOnPort:SOCKETPORT error:&error];
    if (result) {
        //开放成功
        NSLog(@"开放监听成功");
    }else{
        //开放失败
        NSLog(@"开放监听失败");
    }
}
//监听到客户端socket链接
//当客户端链接成功后，生成一个新的客户端socket
-(void)socket:(GCDAsyncSocket *)sock didAcceptNewSocket:(GCDAsyncSocket *)newSocket{
    
    //保存客户端socket
    self.clientSocket = newSocket;
    [self.clientSocket readDataWithTimeout:-1 tag:CONTACTDATA];
    NSLog(@"连接成功");
    if ([self.delegate respondsToSelector:@selector(clientName:)]) {
        [self.delegate clientName:1];
    }
    
    
}
//断开连接
-(void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err{
   
    if ([self.delegate respondsToSelector:@selector(clientName:)]) {
        [self.delegate clientName:0];
    }
    
}
//成功读取客户端发过来的消息--该方法是分段读取数据的、异步执行的读取数据，在数据读取结束时转到主线程
-(void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{
    
    __block ContactModel * contactModel = [ContactModel shareContactModel];

    __block LoadingFrame * loadFrame = [LoadingFrame single];
    
    [loadFrame dataReadSuccessfully];
    NSLog(@"读取");
    //每次接收的data都拼接到一起、内存不会复用，只会开辟一个新的内存来来存储数据
    [_openService.mutableData appendData:data];
    
    //持续接收服务端放回的数据
    [self.clientSocket readDataWithTimeout:-1 tag:CONTACTDATA];
    
    //没接收到一次数据 截取截取字符
    NSInteger  length = [_openService.mutableData length];
    NSData * endData;
    NSString * endString;
    if (length>[_openService.endData length]) {
        
        NSInteger  endLength = length-[_openService.endData length];
        endData = [_openService.mutableData subdataWithRange:NSMakeRange(endLength , [_openService.endData length])];
        endString = [[NSString alloc]initWithData:endData encoding:NSUTF8StringEncoding];
    }else{
        
        endString =@"";
    }
    //进行判断是否为结束符 如果是写入通讯录
    if ([endString isEqualToString:CONTACT]) {

        [loadFrame addFinish:@"数据读取完成"];
        [self.delegate startWrite];
        //去掉结束符
        NSInteger  contactDatalength = [_openService.mutableData length];
        NSData * contactData = [_openService.mutableData subdataWithRange:NSMakeRange(0 , contactDatalength-[_openService.endData length])];

        if (ISIOS9) {
            NSLog(@"iOS9");
            [contactModel addContactsToAddressBook:contactData];
            
        }else{
        
            [contactModel inputAdressBook:contactData];
        }
        //结束后清空数据
        _openService.mutableData = nil;
        _openService.mutableData = [NSMutableData data];
    }
}
@end
