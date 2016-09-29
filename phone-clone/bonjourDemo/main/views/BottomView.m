//
//  BottomView.m
//  bonjourDemo
//
//  Created by wuqitao on 16/4/19.
//  Copyright © 2016年 ZYF. All rights reserved.
//

#import "BottomView.h"
#import "bonjourHeader.h"
@implementation BottomView
{
    UIButton * selectButton;
    UIButton * confirmButton;

}
-(instancetype)init{
    
    if (self = [super init]) {
        self.backgroundColor = [UIColor colorWithRed:248.0/255 green:246.0/255  blue:255.0/255  alpha:1];
        [self initCustomView];
    }
    
    return self;
}

-(void)initCustomView{
    
    float spacing = (SCREENWIDTH-50)/3;
    
    selectButton = ({
    
        UIButton * button = [[UIButton alloc]init];
        button.tag = 1;
        button.layer.cornerRadius = 15;
        [button setBackgroundImage:[UIImage imageNamed:@"feiquanxuan"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(selectBtn:) forControlEvents:UIControlEventTouchUpInside];
        button;
    });
    [self addSubview:selectButton];
    [selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(5);
        make.left.equalTo(self).offset(spacing);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    confirmButton = ({
        
        UIButton * button = [[UIButton alloc]init];
        button.tag = 2;
        button.layer.cornerRadius = 15;
        [button setBackgroundImage:[UIImage imageNamed:@"ic_success"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(selectBtn:) forControlEvents:UIControlEventTouchUpInside];
        button;
    });
    [self addSubview:confirmButton];
    [confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(5);
        make.right.equalTo(self).offset(-spacing);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    UILabel * selectLabel = ({
    
        UILabel * label = [[UILabel alloc]init];
        label.text = @"全选";
        label.font = [UIFont systemFontOfSize:10];
        label.textAlignment = NSTextAlignmentCenter;
        label;
    
    });
    [self addSubview:selectLabel];
    [selectLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(selectButton.mas_bottom).offset(5);
        make.left.equalTo(self).offset(spacing);
        make.size.mas_equalTo(CGSizeMake(30, 20));
    }];
    
    
    UILabel * confirmLabel = ({
        
        UILabel * label = [[UILabel alloc]init];
        label.text = @"确定";
        label.font = [UIFont systemFontOfSize:10];
        label.textAlignment = NSTextAlignmentCenter;
        label;
        
    });
    [self addSubview:confirmLabel];
    [confirmLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(confirmButton.mas_bottom).offset(5);
        make.right.equalTo(self).offset(-spacing);
        make.size.mas_equalTo(CGSizeMake(30, 20));
    }];
    
}
-(void)selectBtn:(UIButton*)sender{
    
    if ([self.delegate respondsToSelector:@selector(selctButton:)]) {
        [self.delegate selctButton:sender.tag];
    }
    
}
//修改选择按钮的背景图片
-(void)modifySelectButtonBackGroundImage:(NSString*)imageName{
    static BOOL buttonState = YES;
    if (buttonState) {
        [selectButton setBackgroundImage:[UIImage imageNamed:@"quanxuan"] forState:UIControlStateNormal];
        buttonState = NO;
    }else{
        [selectButton setBackgroundImage:[UIImage imageNamed:@"feiquanxuan"] forState:UIControlStateNormal];
        buttonState = YES;
    }
}
//修改确认按钮的背景图片
-(void)modifyConfirmButtonBackGroundImage:(NSString *)imageName{
    
    static BOOL buttonState = YES;
    if (buttonState) {
        [confirmButton setBackgroundImage:[UIImage imageNamed:@"ic_success_green"] forState:UIControlStateNormal];
        buttonState = NO;
    }else{
        [confirmButton setBackgroundImage:[UIImage imageNamed:@"ic_success"] forState:UIControlStateNormal];
        buttonState = YES;
    }
    
    
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
   
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, 2);  //线宽
    CGContextSetAllowsAntialiasing(context, true);
    CGContextSetRGBStrokeColor(context, 192.0 / 255.0, 192.0 / 255.0, 192.0 / 255.0, 1.0);  //线的颜色
    CGContextBeginPath(context);
    
    CGContextMoveToPoint(context, 0, 0);  //起点坐标
    CGContextAddLineToPoint(context, self.frame.size.width, 0);   //终点坐标
    
    CGContextStrokePath(context);
}


@end
