//
//  SendDataViewController.h
//  bonjourDemo
//
//  Created by wuqitao on 16/4/15.
//  Copyright © 2016年 ZYF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SendDataViewController : UIViewController
@property (nonatomic,strong)NSString * ip;
//连接
@property (nonatomic,assign) NSInteger personCount;
@property(nonatomic)GCDAsyncSocket * socket;
@end
