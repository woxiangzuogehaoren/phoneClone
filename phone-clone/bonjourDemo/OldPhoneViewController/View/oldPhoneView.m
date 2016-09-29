//
//  oldPhoneView.m
//  bonjourDemo
//
//  Created by 赵一帆 on 16/4/11.
//  Copyright © 2016年 ZYF. All rights reserved.
//

#import "oldPhoneView.h"
#import "bonjourHeader.h"

@implementation oldPhoneView

static NSString * firstStep = @"启用无线局域网：打开系统”设置“，点击“无线局域网”，打开“无线局域网”开...";
static NSString * secondStep = @"选取网络：按照对方手机“个人热点”界面提示的热点名称选取并连接网络。";
static NSString * thirdStep = @"返回手机克隆：连接热点成功后，本机返回“手机克隆”，点击下一步。";
//需要设置rect
-(instancetype)initWithFrame:(CGRect)frame
{
    self =[super initWithFrame:frame];
    if(self)
    {
        self.backgroundColor = [UIColor whiteColor];
        [self initCustomView];
           }
    return self;
}
-(void)initCustomView
{
    
    [self pageLayoutImageName:@"num_image1" withNumber:0 withLabelName:firstStep];
    [self pageLayoutImageName:@"num_image2" withNumber:1 withLabelName:secondStep];
    [self pageLayoutImageName:@"num_image3" withNumber:2 withLabelName:thirdStep];
   
    UIButton * nextStepBtn = ({
        UIButton * button = [[UIButton alloc]init];
        [button setTitle:@"下一步" forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"bt_blue"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(oldNextStep) forControlEvents:UIControlEventTouchUpInside];
        button;
    });
    [self addSubview:nextStepBtn];
    [nextStepBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(20);
        make.right.equalTo(self.mas_right).offset(-20);
        make.bottom.equalTo(self.mas_bottom).offset(-30);
        make.height.equalTo(@40);
    }];
    
    
    [self drawlineNumber:0];
    [self drawlineNumber:1];

}
//页面布局
-(void)pageLayoutImageName:(NSString*)imageName withNumber:(NSInteger)number withLabelName:(NSString*)labelName{
    
    NSInteger distanceTop =SCREENHEIGHT*0.25*number;
    
    UIImageView * numberImageView = ({
        UIImageView * imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imageName]];
        imageView;
    });
    [self addSubview:numberImageView];
    [numberImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self).offset(10+distanceTop);
        make.left.equalTo(self).offset(20);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    UILabel * operationLabel = ({
    
        UILabel * label = [[UILabel alloc]init];
        label.text = labelName;
        label.font = [UIFont systemFontOfSize:13];
        label.textColor = [UIColor blackColor];
        label.numberOfLines = 0;
        label;
    
    });
    [self addSubview:operationLabel];
    [operationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(numberImageView.mas_right).offset(10);
        make.right.equalTo(self.mas_right).offset(-20);
        make.top.equalTo(self).offset(5+distanceTop);
        make.height.equalTo(@40);
    }];
};
//button的点击事件 代理
-(void)oldNextStep{

    if ([self.delegate respondsToSelector:@selector(searchForMobilePhones)]) {
        [self.delegate searchForMobilePhones];
    }
    
}
//画线
-(void)drawlineNumber:(NSInteger)number{
    
    NSInteger distanceTop =SCREENHEIGHT*0.25*number;
    
    UIImageView *iView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 30+distanceTop, 20, SCREENHEIGHT*0.25-20)];
    [self addSubview:iView];
    
    UIGraphicsBeginImageContext(iView.frame.size); //参数size为新创建的位图上下文的大小
    [iView.image drawInRect:CGRectMake(0, 0, iView.frame.size.width, iView.frame.size.height)];
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapSquare); //设置线段收尾样式
    
    CGFloat length[] = {5,5}; // 线的宽度，间隔宽度
    CGContextRef line = UIGraphicsGetCurrentContext(); //设置上下文
    CGContextSetStrokeColorWithColor(line, [UIColor blackColor].CGColor);
    CGContextSetLineWidth(line, 0.1); //设置线粗细
    CGContextSetLineDash(line, 0, length, 2);//画虚线
    CGContextMoveToPoint(line, 10, 0); //开始画线
    CGContextAddLineToPoint(line, 10, SCREENHEIGHT*0.25-20);//画直线
    CGContextStrokePath(line); //指定矩形线
    iView.image = UIGraphicsGetImageFromCurrentImageContext();
    
    //    // 在line 中间的间隔里 再画一条不同颜色的间隔线
    //    CGContextRef line2 = UIGraphicsGetCurrentContext();
    //    CGContextSetStrokeColorWithColor(line2, [UIColor blackColor].CGColor);
    //    CGContextSetLineWidth(line2, 5);
    //    CGContextSetLineDash(line2, 0, length, 2);//画虚线
    //    CGContextMoveToPoint(line2, 30, 20.0); //开始画线line2 参数对象，X坐标，Y坐标
    //    CGContextAddLineToPoint(line2, self.frame.size.width, 20);
    //    CGContextStrokePath(line2);
}
@end
