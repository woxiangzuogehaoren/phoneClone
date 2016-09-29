//
//  SeaerchPhoneView.m
//  bonjourDemo
//
//  Created by wuqitao on 16/4/14.
//  Copyright © 2016年 ZYF. All rights reserved.
//

#import "SearchPhoneView.h"
#import "bonjourHeader.h"
@implementation SearchPhoneView

-(instancetype)init{
    
    self = [super init];
    if (self) {
        
        [self initCustomView];
    }
    
    return self;
}

-(void)initCustomView{
    //搜索手机页面
    self.searchView = ({
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT/2)];
        view.backgroundColor = [UIColor whiteColor];
        view;
        
    });
    [self addSubview:self.searchView];
    
    self.oldPhoneButton = ({
        UIButton * button = [[UIButton alloc]init];
//        button.center = self.searchView.center;
//        CGSize  size = CGSizeMake(60, 60);
//        button.size = size;
        [button setBackgroundImage:[UIImage imageNamed:@"ic_ios_oldphone"] forState:UIControlStateNormal];
        button;
    });
    [self.searchView addSubview:self.oldPhoneButton];
    [self.oldPhoneButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.searchView);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
    //本机
    UILabel * ownPhoneLabel = ({
        UILabel * label = [[UILabel alloc]init];
        label.text = [NSString stringWithFormat:@"本机：%@",[[UIDevice currentDevice] name]];
        label.textColor = [UIColor blackColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:10];
        label;
    });
    [self.searchView addSubview:ownPhoneLabel];
    [ownPhoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.searchView);
        make.top.equalTo(self.oldPhoneButton.mas_bottom).offset(10);
        make.width.equalTo(self).multipliedBy(0.8);
        make.height.equalTo(@10);
    }];
    //选择
    self.choiceLabel = ({
        UILabel * label = [[UILabel alloc]init];
        label.text = @"正在搜索新手机...";
        label.textColor = [UIColor colorWithRed:65/255 green:105.0/255 blue:225.0/255 alpha:1];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:12];
        label;
    });
    [self.searchView addSubview:self.choiceLabel];
    [self.choiceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.searchView);
        make.top.equalTo(ownPhoneLabel.mas_bottom).offset(15);
        make.width.equalTo(self);
        make.height.equalTo(@12);
    }];
    //搜到手机页面
    
    self.toSearchView = ({
        UIView * view = [[UIView alloc]init];
        view.backgroundColor = [UIColor whiteColor];
        view.hidden = YES;
        view;
    });
    [self addSubview:self.toSearchView];
    [self.toSearchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.left.right.equalTo(self);
        make.bottom.equalTo(self).offset(-50);
        make.height.equalTo(@110);
    }];
    
    
    UIButton * newPhoneButton = ({
        UIButton * button = [[UIButton alloc]init];
        [button setBackgroundImage:[UIImage imageNamed:@"ic_android_Black_1"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(connectButton) forControlEvents:UIControlEventTouchUpInside];
        button;
    });
    [self.toSearchView addSubview:newPhoneButton];
    [newPhoneButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.toSearchView);
        make.top.equalTo(self.toSearchView);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
    
    self.searchPhoneLabel = ({
        UILabel * label = [[UILabel alloc]init];
        label.text = [NSString stringWithFormat:@"%@",[[UIDevice currentDevice] name]];
        label.textColor = [UIColor blackColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:10];
        label;
    });
    [self.toSearchView addSubview:self.searchPhoneLabel];
    [self.searchPhoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.toSearchView);
        make.top.equalTo(newPhoneButton.mas_bottom).offset(10);
        make.width.equalTo(self);
        make.height.equalTo(@10);
    }];
    
    UIButton * connectBtn = ({
        UIButton * button = [[UIButton alloc]init];
        [button setTitle:@"连接" forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:10];
        [button setBackgroundImage:[UIImage imageNamed:@"bt_blue"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(connectButton) forControlEvents:UIControlEventTouchUpInside];
        button;
    });
    [self.toSearchView addSubview:connectBtn];
    [connectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.toSearchView);
        make.bottom.equalTo(self.toSearchView);
        make.size.mas_equalTo(CGSizeMake(50, 20));
    }];
    
    
    //点击安装软件
   UIButton * installBtn = ({
        UIButton * installButton = [[UIButton alloc]init];
        [installButton setTitle:@"对方没有安装手机克隆？点击这里安装" forState:UIControlStateNormal];
        [installButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        installButton.titleLabel.font = [UIFont systemFontOfSize:10];
        [installButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
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
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 2.5, 15, 15)];
        imageView.image = [UIImage imageNamed:@"Qrcode_image"];
        imageView;
    });
    [installBtn addSubview:qrCodeImageView];
    
}
//显示搜索到的手机
-(void)showAndHideTheSearchToThePhone:(NSString*)displayState{
    
    if ([displayState isEqualToString:@"显示"]) {
        self.toSearchView.hidden = NO;
        self.searchPhoneLabel.text = _service.name;
        self.searchView.frame = CGRectMake(0, -15, SCREENWIDTH, SCREENHEIGHT/2);
        self.choiceLabel.text = @"请选择接收方手机";
    }else{
        self.toSearchView.hidden = YES;
        self.searchPhoneLabel.text = @"";
        self.searchView.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT/2);
        self.choiceLabel.text = @"正在搜索新手机...";
    }
}
//连接手机
-(void)connectButton{
    
    if ([self.delegate respondsToSelector:@selector(connectPhone)]) {
//        [self.delegate connectPhone];
        _service.delegate = self.delegate;
        [_service resolveWithTimeout:1.0];
    }
    
    
}
//安装软件
-(void)installSoftware{
    
    if ([self.delegate respondsToSelector:@selector(installSoftwareForPhone)]) {
        [self.delegate installSoftwareForPhone];
    }
    
}
-(void)settingServer:(NSNetService *)servers{

    _service = servers;
    
}
@end
