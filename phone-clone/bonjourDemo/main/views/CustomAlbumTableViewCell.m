//
//  CustomAlbumTableViewCell.m
//  bonjourDemo
//
//  Created by wuqitao on 16/4/19.
//  Copyright © 2016年 ZYF. All rights reserved.
//

#import "CustomAlbumTableViewCell.h"
@interface CustomAlbumTableViewCell ()
@property(nonatomic,strong) UILabel * albumNameLabel;
@property(nonatomic,strong) UILabel * photoNumberLabel;
@property(nonatomic,strong) UIImageView * albumPosterImageView;

@end

@implementation CustomAlbumTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self prepare];
    }
    
    return self;
}
-(void)prepare{
    
    self.selectButton = ({
        UIButton * button = [[UIButton alloc]init];
        [button addTarget:self action:@selector(selectButtonAlbum:) forControlEvents:UIControlEventTouchUpInside];
        button;
    });
    [self addSubview:self.selectButton];
    [self.selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self).offset(-20);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    //相册缩略图
    self.albumPosterImageView = ({
        UIImageView * imageView = [[UIImageView alloc]init];
        imageView;
    });
    [self addSubview:self.albumPosterImageView];
    [self.albumPosterImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.mas_left).offset(10);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    //相册名称
    self.albumNameLabel = ({
        UILabel * label = [[UILabel alloc]init];
        label.font = [UIFont systemFontOfSize:18];
        label;
    });
    [self addSubview:self.albumNameLabel];
    [self.albumNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(5);
        make.left.equalTo(self.albumPosterImageView.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake(self.width*0.6, 30));
    }];
    //照片数量
    self.photoNumberLabel = ({
        UILabel * label = [[UILabel alloc]init];
        label.font = [UIFont systemFontOfSize:10];
        label;
    });
    [self addSubview:self.photoNumberLabel];
    [self.photoNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.albumNameLabel.mas_bottom).offset(5);
        make.left.equalTo(self.albumPosterImageView.mas_right).offset(12);
        make.size.mas_equalTo(CGSizeMake(self.width*0.6, 12));
    }];
    
}

//相册缩略图
-(void)modifyPosterImage:(UIImage*)image{
    
    
    self.albumPosterImageView.image = image;
    
}
//相册名称
-(void)modifyAlbumName:(NSString*)albumName{
    self.albumNameLabel.text = albumName;
}
//相册数量
-(void)modifyDetailTextLabel:(NSString*)detailText{
    
    self.photoNumberLabel.text = detailText;
}
//修改button
-(void)setSelectButtonBackgroundImage:(NSString*)imageName{
    
    [self.selectButton setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    
}
//button触发代理方法
-(void)selectButtonAlbum:(UIButton*)button{
    
    if ([self.delegate respondsToSelector:@selector(selectButtonImage:)]) {
        [self.delegate selectButtonImage:button];
    }
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
