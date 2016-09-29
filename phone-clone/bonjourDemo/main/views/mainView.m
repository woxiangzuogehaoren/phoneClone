//
//  mainView.m
//  bonjourDemo
//
//  Created by 赵一帆 on 16/4/6.
//  Copyright © 2016年 ZYF. All rights reserved.
//

#import "mainView.h"
#import "bonjourHeader.h"
@implementation mainView
{
    UIImageView * topImage;
    
    UIImageView * ihoneImage;
    
    UILabel * introduceLabel;
    
    UIView * bottomView;
    
    UIButton * oldPhoneBtn;
    
    UIButton * newPhoneBtn;
    
    UIButton * installBtn;
    
}


-(instancetype)init
{
    self =[super init];
    if (self) {
        [self initCustomView];
    }
    return self;
}
-(void)initCustomView
{
    topImage = ({
        UIImageView * imageView =[UIImageView new];
        imageView.image = [UIImage imageNamed:@"back_image"];
        imageView;

    });
    [self addSubview:topImage];
    
    ihoneImage = ({
    
        UIImageView * imageView =[UIImageView new];
        imageView.image = [UIImage imageNamed:@"banner"];
        imageView;
    
    });
    [topImage addSubview:ihoneImage];
    
    introduceLabel = ({
        UILabel * label = [[UILabel alloc]init];
        label.textAlignment = NSTextAlignmentCenter;
        label.numberOfLines =0;
        label.text = @"将旧手机上的联系人、照片、视频等重要信息数据转移到新手机";
        label.textColor = [UIColor ivoryColor];
        label.font = [UIFont systemFontOfSize:10];
        label;
    });
    [topImage addSubview:introduceLabel];
    
    
    bottomView =({
        UIView * view  = [UIView new];
        view.backgroundColor =[UIColor whiteColor];
        view;
    });
    [self addSubview:bottomView];
    
    oldPhoneBtn = ({
        UIButton *oldBtn =[UIButton new];
        oldBtn.backgroundColor =[UIColor whiteColor];
        oldBtn.layer.cornerRadius =50;
        [oldBtn setBackgroundImage:[UIImage imageNamed:@"circle_image_1"] forState:UIControlStateNormal];
        [oldBtn setTitle:@"旧手机" forState:UIControlStateNormal];
        [oldBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [oldBtn addTarget:self action:@selector(touchUp:) forControlEvents:UIControlEventTouchUpInside];
//        [oldBtn addTarget:self action:@selector(touchDown:) forControlEvents:UIControlEventTouchDown & UIControlEventTouchDragInside];
        oldBtn;
    });
    [bottomView addSubview:oldPhoneBtn];
    
    newPhoneBtn = ({
        UIButton *newBtn =[UIButton new];
        newBtn.backgroundColor =[UIColor whiteColor];
        newBtn.layer.cornerRadius =50;
        [newBtn setBackgroundImage:[UIImage imageNamed:@"circle_image_2"] forState:UIControlStateNormal];
//        newBtn.layer.borderWidth =1;
//        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
//        CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 65/255.0, 105/255.0, 225/255.0, 1 });
//        [newBtn.layer setBorderColor:colorref];//边框颜色
        [newBtn setTitle:@"新手机" forState:UIControlStateNormal];
        [newBtn setTitleColor:[UIColor colorWithRed:65/255.0 green:105/255.0 blue:225/255.0 alpha:1] forState:UIControlStateNormal];
        [newBtn addTarget:self action:@selector(clickNewPhone:) forControlEvents:UIControlEventTouchUpInside];
        
        newBtn;
    });
    [bottomView addSubview:newPhoneBtn];
    
    installBtn = ({
        UIButton * installButton = [[UIButton alloc]init];
        [installButton setTitle:@"对方没有安装手机克隆？点击这里安装" forState:UIControlStateNormal];
        [installButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        installButton.titleLabel.font = [UIFont systemFontOfSize:10];
        [installButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
        [installButton addTarget:self action:@selector(installSoftware) forControlEvents:UIControlEventTouchUpInside];
        installButton;
    });
    [bottomView addSubview:installBtn];
    UIImageView * qrCodeImageView = ({
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 2.5, 15, 15)];
        imageView.image = [UIImage imageNamed:@"Qrcode_image"];
        imageView;
    });
    [installBtn addSubview:qrCodeImageView];
    
    /*
     先添加视图在用约束
     */
    
    [topImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.equalTo(self).multipliedBy(0.6);
    }];

    [ihoneImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(topImage);
        make.height.equalTo(topImage).multipliedBy(0.55);
        make.bottom.equalTo(topImage.mas_bottom).offset(-70);
        make.centerX.equalTo(topImage);
    }];
    
    [introduceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(topImage);
        make.width.equalTo(self).multipliedBy(0.6);
        make.bottom.equalTo(topImage.mas_bottom).offset(-10);
        make.height.equalTo(@30);
    }];
    
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topImage.mas_bottom);
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.bottom.equalTo(self);
    }];

    
    
    /*
        两个button的间隔
     */
    int padding = SCREENWIDTH/8;
    
    
    [oldPhoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bottomView.mas_centerY).offset(-20);
        make.left.equalTo(bottomView.mas_left).offset(padding);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];


    [newPhoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bottomView.mas_right).offset(-padding);
        make.size.centerY.equalTo(oldPhoneBtn);
    }];

    [installBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(bottomView.mas_bottom).offset(-10);
        make.centerX.equalTo(bottomView);
        make.width.equalTo(self).multipliedBy(0.6);
        make.height.equalTo(@20);
    }];
}
-(void)touchUp:(UIButton*)sender
{
//    if (self.btnBlock)
//    {
//        self.btnBlock();
//        
//   }
//    sender.backgroundColor = [UIColor grayColor];
    if ([self.delegate respondsToSelector:@selector(clickOldPhone)])
    {
        [self.delegate clickOldPhone];
    }
}
//-(void)touchDown:(UIButton*)sender
//{
//    sender.backgroundColor =[UIColor  whiteSmoke];
//}
-(void)clickNewPhone:(UIButton*)sender
{
    if ([self.delegate respondsToSelector:@selector(clickNewPhone)]) {
        [self.delegate clickNewPhone];
    }
}

-(void)installSoftware{
    if ([self.delegate respondsToSelector:@selector(installSoftwareForPhone)]) {
        [self.delegate installSoftwareForPhone];
    }

    
}
@end
