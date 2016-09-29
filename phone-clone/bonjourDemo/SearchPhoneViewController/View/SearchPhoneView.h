//
//  SeaerchPhoneView.h
//  bonjourDemo
//
//  Created by wuqitao on 16/4/14.
//  Copyright © 2016年 ZYF. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SearchPhoneViewDelegate <NSObject>

-(void)connectPhone;
-(void)installSoftwareForPhone;
@end

@interface SearchPhoneView : UIView

@property(nonatomic,weak)id delegate;
@property(nonatomic,strong) UIView * searchView;
@property(nonatomic,strong) UIButton * oldPhoneButton;
@property(nonatomic,strong) UILabel * choiceLabel;
@property(nonatomic,strong) UIView * toSearchView;
@property(nonatomic,strong) UILabel * searchPhoneLabel;
@property (nonatomic)NSNetService *service ;
//显示搜索到的手机
-(void)showAndHideTheSearchToThePhone:(NSString*)displayState;
//设置服务
-(void)settingServer:(NSNetService *)servers;
@end
