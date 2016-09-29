//
//  newPhoneView.m
//  bonjourDemo
//
//  Created by 赵一帆 on 16/4/10.
//  Copyright © 2016年 ZYF. All rights reserved.
//

#import "newPhoneView.h"
@interface newPhoneView()

@property (nonatomic ,strong)UILabel* localIPLabel;
@property (nonatomic,strong) UIButton * connectionBtn;
@property (nonatomic,strong) UILabel * phoneLabel;
@property (nonatomic,strong) UILabel * setStepLabel;
@end

static NSString * firstStep = @"启用个人热点：打开系统”设置“，点击“个人热点”，打开“个人热点”开关";
static NSString * secondStep = @"等待对方连接：本机停留在“个人热点”界面；在对方手机上打开“手机克隆”，点击“旧手机”并按提示连接此热点。";
static NSString * thirdStep = @"返回手机克隆：连接热点成功后，本机返回“手机克隆”，点击下一步。";
static NSString * setStep = @"无法点击“个人热点？”\n● 请确认已关闭“飞行模式”。\n● 请启用蜂窝数据移动：在本机的“设置”中，点击“蜂窝移动网络”，打开“蜂窝移动数据”开关（iOS7以下版本，还需打开“启动4G”或“启动3G”开关）。";

@implementation newPhoneView

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
    
    
    self.setStepLabel = ({
        UILabel * label = [[UILabel alloc]init];
        label.font = [UIFont systemFontOfSize:10];
        label.numberOfLines = 10;
        label;
    });
    [self addSubview:self.setStepLabel];
    
    CGFloat height = [self selfAdaption:setStep withLabel:self.setStepLabel];
    self.setStepLabel.frame = CGRectMake(50, 50, SCREENWIDTH-70, height);
    [self labelDisplayInformation:setStep];
    
    
    UIButton * nextStepBtn = ({
        UIButton * button = [[UIButton alloc]init];
        [button setTitle:@"下一步" forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"bt_blue"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(newNextStep) forControlEvents:UIControlEventTouchUpInside];
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
        label.numberOfLines = 10;
        label;
        
    });
    
    CGFloat labelHeight = [self selfAdaption:labelName withLabel:operationLabel];
    [self addSubview:operationLabel];
    operationLabel.frame = CGRectMake(50, 10+distanceTop, SCREENWIDTH-70, labelHeight);

};
//根据文本获取label的高度
-(CGFloat)selfAdaption:(NSString*)info withLabel:(UILabel*)label{
    
    label.text = info;
    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:label.font,NSFontAttributeName,nil];
    
    CGSize size =[info boundingRectWithSize:CGSizeMake(SCREENWIDTH-70, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:tdic context:nil].size;
    
    return size.height;
}
//label显示信息
-(void)labelDisplayInformation:(NSString*)labelText{
    
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc]initWithString:labelText];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(0, 11)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(12, labelText.length-12)];
    self.setStepLabel.attributedText = attributedString;
}
//button的点击事件 代理
-(void)newNextStep{
    
    if ([self.delegate respondsToSelector:@selector(oldMobilePhoneConnectionPage)]) {
        
        [self.delegate oldMobilePhoneConnectionPage];
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

}

@end
