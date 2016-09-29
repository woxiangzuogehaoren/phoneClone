//
//  LoadingFrame.h
//  bonjourDemo
//
//  Created by wuqitao on 16/5/10.
//  Copyright © 2016年 ZYF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MBProgressHUD+NJ.h"
@interface LoadingFrame : NSObject
+(instancetype)single;
-(MBProgressHUD*)displayPromptBox;
-(MBProgressHUD*)dataReadSuccessfully;
-(void)addFinish:(NSString*)message;
-(UIView*)showMessage:(NSString*)message withDuration:(NSInteger)duration;
@end
