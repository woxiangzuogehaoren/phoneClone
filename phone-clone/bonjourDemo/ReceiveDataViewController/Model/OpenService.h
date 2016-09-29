//
//  openService.h
//  bonjourDemo
//
//  Created by wuqitao on 16/5/4.
//  Copyright © 2016年 ZYF. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol OpenServiceDelegate <NSObject>
@optional
-(void)receivedContactData:(NSData*)data;
-(void)receivedImageData:(NSData*)data;
-(void)receivedVideoData:(NSData*)data;


-(void)startWrite;
//-(void)beingWrittenNumber:(NSInteger)number withTotal:(NSInteger)total;
//-(void)completeWrite;

-(void)clientName:(NSInteger)tag;

@end

@interface OpenService : NSObject

@property (nonatomic,weak)id<OpenServiceDelegate>delegate;

//创建单例
+(OpenService*)defaultScoket;
//开启服务
-(void)creatServer;
//停止
-(void)stop;
@end
