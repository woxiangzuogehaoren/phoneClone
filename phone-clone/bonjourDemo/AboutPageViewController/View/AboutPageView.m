//
//  AboutPageView.m
//  bonjourDemo
//
//  Created by wuqitao on 16/4/21.
//  Copyright © 2016年 ZYF. All rights reserved.
//

#import "AboutPageView.h"

@implementation AboutPageView
-(instancetype)init{
    
    if (self=[super init]) {
        [self initCustomView];
    }
    
    return self;
}
-(void)initCustomView{
    
    self.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
    //logo
    UIImageView * logoImageView = ({
    
        UIImageView * imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"logo"]];
        imageView;
    });
    [self addSubview:logoImageView];
    [logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self).offset(-(SCREENWIDTH/5));
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
    //程序名
    UILabel * appNameLabel = ({
        UILabel * label = [[UILabel alloc]init];
        label.text = @"手机克隆";
        label.font = [UIFont boldSystemFontOfSize:15];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor blackColor];
        label;
    
    });
    [self addSubview:appNameLabel];
    [appNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(logoImageView.mas_bottom).offset(10);
        make.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(60, 20));
    }];
    //版本号
    UILabel * verNumLabel = ({
    
        UILabel * label = [[UILabel alloc]init];
        label.textColor = [UIColor grayColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:10];
        label.text = [NSString stringWithFormat:@"版本：%@", [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString*)kCFBundleVersionKey]];
        label;
    });
    [self addSubview:verNumLabel];
    [verNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(appNameLabel.mas_bottom).offset(5);
        make.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(50, 10));
        
    }];
    
    UIButton * privacyBtn = ({
    
        UIButton * button = [[UIButton alloc]init];
        [button setTitle:@"隐私政策" forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:12];
        [button setTitleColor:[UIColor colorWithRed:0.0 green:1.0 blue:1.0 alpha:1] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(privacy) forControlEvents:UIControlEventTouchUpInside];
        button;
    });
    [self addSubview:privacyBtn];
    [privacyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.equalTo(self);
        make.bottom.equalTo(self.mas_bottom).offset(-50);
        make.size.mas_equalTo(CGSizeMake(60, 10));
        
    }];
    UILabel * copyrightLabel = ({
    
        UILabel * label = [[UILabel alloc]init];
        label.text = @"版权所有";
        label.font = [UIFont systemFontOfSize:12];
        label;
    });
    [self addSubview:copyrightLabel];
    [copyrightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(privacyBtn.mas_bottom).offset(5);
        make.centerX.equalTo(self);
        make.width.equalTo(self).multipliedBy(0.9);
        make.height.equalTo(@12);
    }];
}
-(void)privacy{
    
    if ([self.deldgate respondsToSelector:@selector(privacyPolicy)]) {
        [self.deldgate privacyPolicy];
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
