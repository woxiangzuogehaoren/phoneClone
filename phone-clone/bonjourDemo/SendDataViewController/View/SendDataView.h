//
//  SendDataView.h
//  bonjourDemo
//
//  Created by wuqitao on 16/4/15.
//  Copyright © 2016年 ZYF. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SendDataViewDelegate <NSObject>

-(void)selectButtonTag:(NSInteger)tag;


@end

@interface SendDataView : UIView
@property (nonatomic,weak)id<SendDataViewDelegate>delegate;

@property (nonatomic,strong) UIButton * contactsButton;
@property (nonatomic,strong) UIButton * pictureButton;
@property (nonatomic,strong) UIButton * videoButton;
@property (nonatomic,strong) UIButton * sendButton;
@property (nonatomic,strong) UIButton * selectButton;

@property (nonatomic,strong) UILabel * contactNumberLabel;
@property (nonatomic,strong) UILabel * pictureNumberLabel;
@property (nonatomic,strong) UILabel * videoNumberLabel;
@property (nonatomic,strong) UILabel * transmitDataInfoLabel;

//更改发送按钮状态
-(void)changeTheStatusOfTheSendButton;
//显示修改label
-(void)labelTextColorDataSize:(NSString*)dataSize withTransmissionTime:(NSString*)time;
//显示联系人数量
-(void)displayContactNumber:(NSInteger)personCount;
//显示照片数据
-(void)displayPhotoNumber:(NSInteger)count;
//显示视频数量
-(void)displayVideoNumber:(NSInteger)count;
@end
