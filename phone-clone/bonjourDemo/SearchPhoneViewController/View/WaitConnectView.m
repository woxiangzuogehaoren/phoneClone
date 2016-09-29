//
//  WaitConnectView.m
//  bonjourDemo
//
//  Created by wuqitao on 16/5/10.
//  Copyright © 2016年 ZYF. All rights reserved.
//

#import "WaitConnectView.h"

@implementation WaitConnectView
{
    UILabel * waitLabel;
}
-(instancetype)init{
    
    if (self = [super init]) {
        
        [self initCustomView];
    }
    
    return self;
}
-(void)initCustomView{
    
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    
    UIView * waitView = ({
    
        UIView * view = [[UIView alloc]init];
        view;
    });
    [self addSubview:waitView];
    [waitView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.center.equalTo(self);
        make.width.equalTo(self).multipliedBy(0.9);
        make.height.equalTo(@60);
    }];
    UIImageView * backgroundView = ({

        UIImageView * imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"check_update_bg"]];
        imageView;
    });
    [waitView addSubview:backgroundView];
    [backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.top.bottom.equalTo(waitView);
        
    }];
    
    waitLabel = ({
    
        UILabel * label = [[UILabel alloc]init];
        label.textColor = [UIColor blackColor];
        label.font = [UIFont systemFontOfSize:15];
        label;
    
    });
    [waitView addSubview:waitLabel];
    [waitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.center.equalTo(waitView);
        make.width.equalTo(waitView).multipliedBy(0.8);
        make.height.equalTo(@40);
    }];
}
-(void)waitContectViewState:(NSString*)serviceName{
    
    waitLabel.text = [NSString stringWithFormat:@"正在连接%@...",serviceName];
}


@end
