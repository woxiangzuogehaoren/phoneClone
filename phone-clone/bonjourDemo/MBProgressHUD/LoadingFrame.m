//
//  LoadingFrame.m
//  bonjourDemo
//
//  Created by wuqitao on 16/5/10.
//  Copyright © 2016年 ZYF. All rights reserved.
//

#import "LoadingFrame.h"

@implementation LoadingFrame
+(instancetype)single{
    
    static LoadingFrame * _loadingFrame = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _loadingFrame = [[LoadingFrame alloc]init];
        
    });
    
    return _loadingFrame;
}
-(MBProgressHUD*)displayPromptBox{
    
  return  [MBProgressHUD showMessage:@"正在加载数据中..."];
    
}
-(MBProgressHUD*)dataReadSuccessfully{
    
    // 移除HUD
    [MBProgressHUD hideHUD];
   return   [MBProgressHUD showMessage:@"正在读取..."];
}
-(void)addFinish:(NSString*)message{
    // 移除HUD
    [MBProgressHUD hideHUD];
    
    // 提醒有没有新版本
    [MBProgressHUD showSuccess:message];
    
}
-(UIView*)showMessage:(NSString*)message withDuration:(NSInteger)duration{
    
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    
    UIView * showView = ({
    
        UIView * view = [[UIView alloc]init];
        view.backgroundColor = [UIColor blackColor];
        view.frame = CGRectMake(1, 1, 1, 1);
        view.alpha = 1.0;
        view.layer.cornerRadius = 5.0f;
        view.layer.masksToBounds = YES;
        view;
    });
    [window addSubview:showView];
    
    UILabel * showLabel = [[UILabel alloc]init];
    showLabel.text = message;
    showLabel.textColor = [UIColor whiteColor];
    showLabel.textAlignment = NSTextAlignmentCenter;
    showLabel.backgroundColor = [UIColor clearColor];
    showLabel.font = [UIFont systemFontOfSize:15];
    NSDictionary * labelDic = [NSDictionary dictionaryWithObjectsAndKeys:showLabel.font,NSFontAttributeName,nil];
    CGSize labelSize = [message boundingRectWithSize:CGSizeMake(SCREENWIDTH, SCREENHEIGHT) options:NSStringDrawingUsesLineFragmentOrigin attributes:labelDic context:nil].size;
    showLabel.frame = CGRectMake(10, 5, labelSize.width, labelSize.height);


    [showView addSubview:showLabel];
    
    showView.frame = CGRectMake((SCREENWIDTH-labelSize.width-20)/2, SCREENHEIGHT/2, labelSize.width+20, labelSize.height+10);
    
    [UIView animateWithDuration:duration animations:^{
        showView.alpha = 0;
    }completion:^(BOOL finished) {
        [showView removeFromSuperview];
    }];
    
    return showView;
}
@end
