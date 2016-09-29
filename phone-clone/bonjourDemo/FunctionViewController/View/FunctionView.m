//
//  FunctionView.m
//  bonjourDemo
//
//  Created by wuqitao on 16/4/21.
//  Copyright © 2016年 ZYF. All rights reserved.
//

#import "FunctionView.h"

static NSString * akeySwitchString = @"无论是联系，还是图片，视频，均可以轻松从旧手机一键导入到新手机，换机方便。";
static NSString * simpleOperationString = @"不用连接电脑，摆脱数据线，无需注册。";
static NSString * ultrafastSpeedString = @"20米近场直连，传输速度远超蓝牙十倍。";

@implementation FunctionView

-(instancetype)init{
    
    if (self = [super init]) {
    
        [self initCustomView];
    }
    
    return self;
}
-(void)initCustomView{
    
    self.backgroundColor = [UIColor whiteColor];
    
    self.layer.borderWidth = 0.5;
    self.layer.cornerRadius = 5;

    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 192/255.0, 192/255.0, 192/255.0, 1 });
    [self.layer setBorderColor:colorref];//边框颜色
    //标题
    UILabel * titleLabel = ({
    
        UILabel * label = [[UILabel alloc]init];
        label.text = @"手机克隆是XX提供的手机一键搬家工具";
        label.font = [UIFont boldSystemFontOfSize:12];
        label;
    });
    [self addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
//        make.left.equalTo(self).offset(5);
        make.top.equalTo(self);
        make.centerX.equalTo(self);
        make.width.equalTo(self).multipliedBy(0.9);
        make.height.equalTo(@45);
    }];
    
    //一键换机label
    UILabel * aKeySwitchLabel = [self titleLabel:@"一键换机"];
    [self addSubview:aKeySwitchLabel];
    [aKeySwitchLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(titleLabel.mas_bottom).offset(10);
        make.centerX.equalTo(self);
        make.width.equalTo(self).multipliedBy(0.9);
        
    }];
    
    //一键换机详情label
    UILabel * aKeySwitchDetailLabel = [self explicateLabel:akeySwitchString];
    [self addSubview:aKeySwitchDetailLabel];
    [aKeySwitchDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(aKeySwitchLabel.mas_bottom).offset(5);
        make.centerX.equalTo(self);
        make.width.equalTo(self).multipliedBy(0.9);
    }];
    
    //操作简单label
    UILabel * simpleOperationLabel = [self titleLabel:@"操作简单"];
    [self addSubview:simpleOperationLabel];
    [simpleOperationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(aKeySwitchDetailLabel.mas_bottom).offset(10);
        make.centerX.equalTo(self);
        make.width.equalTo(self).multipliedBy(0.9);
    }];
    
    //操作简单详情label
    UILabel * simpleOperationDetailLabel = [self explicateLabel:simpleOperationString];
    [self addSubview:simpleOperationDetailLabel];
    [simpleOperationDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(simpleOperationLabel.mas_bottom).offset(5);
        make.centerX.equalTo(self);
        make.width.equalTo(self).multipliedBy(0.9);
    }];
    
    //速度超快label
    UILabel * ultrafastSpeedLabel = [self titleLabel:@"速度超快"];
    [self addSubview:ultrafastSpeedLabel];
    [ultrafastSpeedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(simpleOperationDetailLabel.mas_bottom).offset(10);
        make.centerX.equalTo(self);
        make.width.equalTo(self).multipliedBy(0.9);
        
    }];
    
    //速度超快详情
    UILabel * ultrafastSpeedDetailLabel = [self explicateLabel:ultrafastSpeedString];
    [self addSubview:ultrafastSpeedDetailLabel];
    [ultrafastSpeedDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(ultrafastSpeedLabel.mas_bottom).offset(5);
        make.centerX.equalTo(self);
        make.width.equalTo(self).multipliedBy(0.9);
    }];
    
}

-(UILabel*)titleLabel:(NSString*)labelText{
    
    UILabel * label = ({
        
        UILabel * label = [[UILabel alloc]init];
        label.textColor = [UIColor colorWithRed:135.0/255 green:206.0/255 blue:235.0/255 alpha:1];
        label.font = [UIFont systemFontOfSize:12];
        label.text = labelText;
        label;
    });
    return label;
}

-(UILabel*)explicateLabel:(NSString*)explicateString{
    
    UILabel * label = ({
        
        UILabel * label = [[UILabel alloc]init];
        label.textColor = [UIColor grayColor];
        label.font = [UIFont systemFontOfSize:10];
        label.numberOfLines = 10;
        label.text = explicateString;
        label;
    });
    CGFloat height = [self selfAdaption:explicateString withLabel:label];
    
    CGSize size = CGSizeMake(self.frame.size.width, height);
    
    [label sizeThatFits:size];
    
    return label;
    
}
//根据文本获取label的高度
-(CGFloat)selfAdaption:(NSString*)info withLabel:(UILabel*)label{
    
    label.text = info;
    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:label.font,NSFontAttributeName,nil];
    
    CGSize size =[info boundingRectWithSize:CGSizeMake(SCREENWIDTH-70, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:tdic context:nil].size;
    
    return size.height;
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, 0.5);  //线宽
    CGContextSetAllowsAntialiasing(context, true);
    CGContextSetRGBStrokeColor(context, 192.0 / 255.0, 192.0 / 255.0, 192.0 / 255.0, 1.0);  //线的颜色
    CGContextBeginPath(context);
    
    CGContextMoveToPoint(context, 0, 45);  //起点坐标
    CGContextAddLineToPoint(context, self.frame.size.width, 45);   //终点坐标
    
    CGContextStrokePath(context);
}


@end
