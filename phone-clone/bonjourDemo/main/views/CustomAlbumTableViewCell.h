//
//  CustomAlbumTableViewCell.h
//  bonjourDemo
//
//  Created by wuqitao on 16/4/19.
//  Copyright © 2016年 ZYF. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CustomAlbumTableViewCellDelegate <NSObject>

-(void)selectButtonImage:(UIButton*)sender;


@end
@interface CustomAlbumTableViewCell : UITableViewCell
-(void)setSelectButtonBackgroundImage:(NSString*)imageName;
//相册缩略图
-(void)modifyPosterImage:(UIImage*)imageName;
//相册名称
-(void)modifyAlbumName:(NSString*)albumName;
//相册数量
-(void)modifyDetailTextLabel:(NSString*)detailText;


@property(nonatomic,weak)id<CustomAlbumTableViewCellDelegate>delegate;

@property (nonatomic,strong) UIButton * selectButton;

@end
