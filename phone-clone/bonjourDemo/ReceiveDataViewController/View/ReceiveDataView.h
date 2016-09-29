//
//  ReceiveDataView.h
//  bonjourDemo
//
//  Created by wuqitao on 16/4/15.
//  Copyright © 2016年 ZYF. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ReceiveDataViewDelegate <NSObject>
-(void)installSoftwareForPhone;

@end
@interface ReceiveDataView : UIView

    
@property(nonatomic,strong)    UIProgressView * progressView;
@property(nonatomic,strong)    UILabel * progressLabelNumber;
@property(nonatomic,strong)    UILabel * progressLabelName;

@property(nonatomic,strong)UIButton * owmPhoneButton;
@property(nonatomic,strong)UILabel * connectPhoneLabel;

@property(nonatomic,weak)id<ReceiveDataViewDelegate>delegate;
//已连接的手机名
-(void)oldPhoneName:(NSString*)name;

//显示进度条
-(void)displayProgressBar;
//更改进度条进度
-(void)changeProgressBarNumber:(NSInteger)num withTotal:(NSInteger)total;
//写入完成，隐藏进度条
-(void)hideProgressBar;

@end
