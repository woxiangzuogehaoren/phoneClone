//
//  SendDataView.m
//  bonjourDemo
//
//  Created by wuqitao on 16/4/15.
//  Copyright © 2016年 ZYF. All rights reserved.
//

#import "SendDataView.h"
#import "bonjourHeader.h"
@implementation SendDataView

-(instancetype)init{
    
    if (self = [super init]) {
        [self initCustomView];
    }
    
    return self;
}
-(void)initCustomView{
    
    float buttonSize = (SCREENWIDTH-100)/3;
    //照片按钮
    self.pictureNumberLabel = [[UILabel alloc]init];
    self.pictureButton = [self setAllButtonTag:2 withBackgroundImageName:@"bt_date_normal"
                             withImageViewName:@"ic_date_picture" withNumberLabel:self.pictureNumberLabel];
    self.pictureButton.layer.cornerRadius = buttonSize/2;
    [self addSubview:self.pictureButton];
    [self.pictureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(buttonSize, buttonSize));
    }];
    
    UIImageView * imageViewVideo = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"rightImage"]];
    [self.pictureButton addSubview:imageViewVideo];
    [imageViewVideo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.pictureButton);
        make.right.equalTo(self.pictureButton).offset(-5);
        make.size.mas_equalTo(CGSizeMake(10, 10));
    }];
    
     //联系人按钮
    self.contactNumberLabel = [[UILabel alloc]init];
    self.contactNumberLabel.text = @"0";
    self.contactsButton = [self setAllButtonTag:1 withBackgroundImageName:@"bt_date_normal"
                              withImageViewName:@"ic_date_contact" withNumberLabel:self.contactNumberLabel];
    self.contactsButton.layer.cornerRadius = buttonSize/2;
    [self addSubview:self.contactsButton];
    [self.contactsButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self.pictureButton.mas_left).offset(-20);
        make.size.mas_equalTo(CGSizeMake(buttonSize, buttonSize));
    }];
    
    //视频按钮
    self.videoNumberLabel = [[UILabel alloc]init];
    self.videoNumberLabel.text = @"0";
    self.videoButton = [self setAllButtonTag:3 withBackgroundImageName:@"bt_date_normal"
                           withImageViewName:@"ic_date_video" withNumberLabel:self.videoNumberLabel];
    
    self.videoButton.layer.cornerRadius = buttonSize/2;
    [self addSubview:self.videoButton];
    [self.videoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.pictureButton.mas_right).offset(20);
        make.size.mas_equalTo(CGSizeMake(buttonSize, buttonSize));
    }];
    
    
    //发送按钮
    self.sendButton = [self setAllButtonTag:4 withBackgroundImageName:@"bt_blue"
                          withImageViewName:@"" withNumberLabel:nil];
    [self.sendButton setTitle:@"发送" forState:UIControlStateNormal];
    self.sendButton.titleLabel.font = [UIFont systemFontOfSize:10];
    [self addSubview:self.sendButton];
    [self.sendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self).offset(-20);
        make.width.equalTo(self).multipliedBy(0.6);
        make.height.equalTo(@40);
    }];
    
    //全选按钮
    self.selectButton = [self setAllButtonTag:5 withBackgroundImageName:@"feiquanxuan"
                            withImageViewName:@"" withNumberLabel:nil];
    [self addSubview:self.selectButton];
    [self.selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.sendButton.mas_right).offset(10);
        make.bottom.equalTo(self).offset(-35);
        make.size.mas_equalTo(CGSizeMake(25, 25));
    }];
    
    UILabel * selectLabel = ({
        UILabel * label = [[UILabel alloc]init];
        label.textAlignment = NSTextAlignmentLeft;
        label.text = @"全选";
        label.font = [UIFont systemFontOfSize:10];
        label;
    });
    [self addSubview:selectLabel];
    [selectLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.sendButton.mas_right).offset(12);
        make.bottom.equalTo(self).offset(-20);
        make.size.mas_equalTo(CGSizeMake(30, 15));
    }];
    
    self.transmitDataInfoLabel = ({
        UILabel * label = [[UILabel alloc]init];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:12];
        label.hidden = YES;
        label;
    });
    [self addSubview:self.transmitDataInfoLabel];
    [self.transmitDataInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self.sendButton.mas_top).offset(-20);
        make.width.equalTo(self);
        make.height.equalTo(@15);
    }];
}
-(UIButton*)setAllButtonTag:(NSInteger)tag withBackgroundImageName:(NSString*)imageName withImageViewName:(NSString*)imageViewName withNumberLabel:(UILabel*)numberLabel{
    
    UIButton * button = ({
        UIButton * button = [[UIButton alloc]init];
        button.tag = tag;
        [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonTriggerMethod:) forControlEvents:UIControlEventTouchUpInside];
        button;
    
    });
    if (tag<4) {
        UIImageView * imageView = ({
            UIImageView * imageView = [[UIImageView alloc]init];
            imageView.image = [UIImage imageNamed:imageViewName];
            imageView;
        });
        [button addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(button);
            make.size.mas_equalTo(CGSizeMake(30, 30));
        }];
        
        numberLabel.textColor = [UIColor colorWithRed:65/255 green:105.0/255 blue:225.0/255 alpha:1];
        numberLabel.textAlignment = NSTextAlignmentCenter;
        numberLabel.font = [UIFont systemFontOfSize:10];
        [button addSubview:numberLabel];
        [numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(button);
            make.top.equalTo(imageView.mas_bottom).offset(5);
            make.size.mas_equalTo(CGSizeMake(30, 10));
        }];
    }
    
    return button;
    
}

//更改发送按钮状态
-(void)changeTheStatusOfTheSendButton{
    
    
    
}
//更改数据信息
-(void)labelTextColorDataSize:(NSString*)dataSize withTransmissionTime:(NSString*)time{
    
    NSString * labelText = [NSString stringWithFormat:@"共选择了%@数据，预计用时%@",dataSize,time];
    NSUInteger dataLenth = dataSize.length;
    NSUInteger timeLenth = time.length;
    //一个label显示不同颜色
    NSMutableAttributedString * attributedText = [[NSMutableAttributedString alloc]initWithString:labelText];
    [attributedText addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, 4)];
    [attributedText addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(4, dataLenth)];
    [attributedText addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(4+dataLenth, 7)];
    [attributedText addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(11+dataLenth, timeLenth)];
    self.transmitDataInfoLabel.hidden = NO;
    self.transmitDataInfoLabel.attributedText = attributedText;
}
//显示联系人数量
-(void)displayContactNumber:(NSInteger)personCount{
    if (personCount) {
        
        self.contactNumberLabel.text = [NSString stringWithFormat:@"%ld",(long)personCount];
        
    }else{
        
        self.contactNumberLabel.text = @"0";
        [self.contactsButton setBackgroundColor:[UIColor grayColor]];
        self.contactsButton.enabled = NO;
    }
    
}
//显示照片数量
-(void)displayPhotoNumber:(NSInteger)count{
    
    if (count) {
        
        self.pictureNumberLabel.text = [NSString stringWithFormat:@"%ld",(long)count];
        
    }else{
        
        self.pictureNumberLabel.text = @"0";
        [self.pictureButton setBackgroundColor:[UIColor grayColor]];
        self.pictureButton.enabled = NO;
    }
    
}
//显示视频数量
-(void)displayVideoNumber:(NSInteger)count{
    
    if (count) {
        
        self.videoNumberLabel.text = [NSString stringWithFormat:@"%ld",(long)count];
        
    }else{
        
         self.videoNumberLabel.text = @"0";
        [self.videoButton setBackgroundColor:[UIColor grayColor]];
        self.videoButton.enabled = NO;
    }
    
}
-(void)buttonTriggerMethod:(UIButton*)sender{
    
    if ([self.delegate respondsToSelector:@selector(selectButtonTag:)]) {
        
        [self.delegate selectButtonTag:sender.tag];
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
