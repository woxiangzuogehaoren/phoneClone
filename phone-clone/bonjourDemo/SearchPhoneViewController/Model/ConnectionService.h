//
//  CloneSocket.h
//  bonjourDemo
//
//  Created by wuqitao on 16/5/3.
//  Copyright © 2016年 ZYF. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ConnectionServiceDelegate <NSObject>

-(void)settingServers:(NSNetService*)servers;

@end

@interface ConnectionService : NSObject

@property (nonatomic,weak)id<ConnectionServiceDelegate>delegate;

//初始化单例
+(ConnectionService *)defaultScoket;
//开始搜索设备
-(void)startSearchingDevice;
//停止搜索设备
-(void)stopSearchingDevice;

//获取ip地址
-(NSString*)nameWithSockaddr:(struct sockaddr*)sadr;
@end
