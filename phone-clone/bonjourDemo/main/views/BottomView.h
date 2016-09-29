//
//  BottomView.h
//  bonjourDemo
//
//  Created by wuqitao on 16/4/19.
//  Copyright © 2016年 ZYF. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol BottomViewDelegate <NSObject>

-(void)selctButton:(NSInteger)tag;

@end
@interface BottomView : UIView

@property(nonatomic,weak)id<BottomViewDelegate>delegate;
//修改选择按钮的背景图片
-(void)modifySelectButtonBackGroundImage:(NSString*)imageName;
//修改确认按钮的背景图片
-(void)modifyConfirmButtonBackGroundImage:(NSString *)imageName;
@end
