//
//  ReceiveDataView.m
//  bonjourDemo
//
//  Created by wuqitao on 16/4/15.
//  Copyright © 2016年 ZYF. All rights reserved.
//

#import "ReceiveDataView.h"

@implementation ReceiveDataView

-(instancetype)init{
    
    if (self = [super init]) {
        [self initCustomView];
    }
    return self;
}

-(void)initCustomView{
    
    UIImageView * backgroundImageView = ({
        UIImageView * imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"back_image"]];
        imageView;
    });
    [self addSubview:backgroundImageView];
    [backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.height.equalTo(self);
    }];
    
    self.owmPhoneButton = ({
        UIButton * button = [[UIButton alloc]init];
        [button setBackgroundImage:[UIImage imageNamed:@"ic_iphone_White_1"] forState:UIControlStateNormal];
        button;
        
    });
    [self addSubview:self.owmPhoneButton];
    [self.owmPhoneButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self).offset(-50);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
    
    UILabel * ownPhoneLabel = ({
    
        UILabel * label = [[UILabel alloc]init];
        label.text = [NSString stringWithFormat:@"本机:%@",[[UIDevice currentDevice] name]];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:10];
        label;
    });
    [self addSubview:ownPhoneLabel];
    [ownPhoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.owmPhoneButton.mas_bottom).offset(10);
        make.left.right.equalTo(self);
        make.height.equalTo(@10);
    }];
    
    self.connectPhoneLabel = ({
    
        UILabel * label = [[UILabel alloc]init];
        label.textColor = [UIColor whiteColor];
        label.text = @"等待旧手机连接...";
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:15];
        label;
    });
    [self addSubview:self.connectPhoneLabel];
    [self.connectPhoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ownPhoneLabel.mas_bottom).offset(10);
        make.left.right.equalTo(self);
        make.height.equalTo(@20);
    }];
    
    self.progressView = ({
        
        UIProgressView * progress = [[UIProgressView alloc]init];
        progress.progressViewStyle= UIProgressViewStyleDefault;
        progress.progress = 0.0;
        progress.progressTintColor = [UIColor greenColor];
        progress.trackTintColor = [UIColor whiteColor];
        progress.hidden = YES;
        progress;
    });
    [self addSubview:self.progressView];
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self);
        make.centerY.equalTo(self).offset(100);
        make.width.equalTo(self).multipliedBy(0.6);
        make.height.equalTo(@5);
    }];
    
    self.progressLabelName = ({
        
        UILabel * label = [[UILabel alloc]init];
        label.text = @"写入进度";
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:10];
        label.hidden = YES;
        label;
    });
    [self addSubview:self.progressLabelName];
    [self.progressLabelName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.progressView.mas_left).offset(-5);
        make.centerY.equalTo(self).offset(100);
        make.size.mas_equalTo(CGSizeMake(40, 10));
    }];
    
    self.progressLabelNumber = ({
        
        UILabel * label = [[UILabel alloc]init];
//        label.text = @"1/2000";
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:10];
        label.hidden = YES;
        label;
    });
    [self addSubview:self.progressLabelNumber];
    [self.progressLabelNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self);
        make.left.equalTo(self.progressView.mas_right).offset(5);
        make.centerY.equalTo(self).offset(100);
        make.height.equalTo(@10);
    }];
    
    //点击安装软件
    UIButton * installBtn = ({
        UIButton * installButton = [[UIButton alloc]init];
        [installButton setTitle:@"对方没有安装手机克隆？点击这里安装" forState:UIControlStateNormal];
        [installButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        installButton.titleLabel.font = [UIFont systemFontOfSize:10];
        [installButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 15, 0, 0)];
        [installButton addTarget:self action:@selector(installSoftware) forControlEvents:UIControlEventTouchUpInside];
        installButton;
    });
    [self addSubview:installBtn];
    [installBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(-10);
        make.centerX.equalTo(self);
        make.width.equalTo(self).multipliedBy(0.6);
        make.height.equalTo(@20);
    }];
    
    UIImageView * qrCodeImageView = ({
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
        imageView.image = [UIImage imageNamed:@"ic_code_white"];
        imageView;
    });
    [installBtn addSubview:qrCodeImageView];
    
    
}
//显示进度条
-(void)displayProgressBar{

    self.progressView.hidden = NO;
    self.progressLabelNumber.hidden = NO;
    self.progressLabelName.hidden = NO;
}
//更改进度条进度
-(void)changeProgressBarNumber:(NSInteger)num withTotal:(NSInteger)total{

       
    self.progressLabelNumber.text = [NSString stringWithFormat:@"%ld/%ld",(long)num,(long)total];
    [self.progressView setProgress:(float)num/total animated:YES];


}
//写入完成，隐藏进度条
-(void)hideProgressBar{
    
    self.progressView.progress = 0.0;
    self.progressView.hidden = YES;
    self.progressLabelNumber.text = @"";
    self.progressLabelNumber.hidden = YES;
    self.progressLabelName.hidden = YES;
    
}
-(void)oldPhoneName:(NSString*)name{
    
    if (name.length>0) {
        self.connectPhoneLabel.text =[NSString stringWithFormat:@"%@已连接",name];
    }else{
        self.connectPhoneLabel.text = @"等待旧手机连接...";
    }
    
    
}
//安装软件
-(void)installSoftware{
    
    if ([self.delegate respondsToSelector:@selector(installSoftwareForPhone)]) {
        [self.delegate installSoftwareForPhone];
    }
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
