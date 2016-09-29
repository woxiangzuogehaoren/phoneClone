//
//  newPhoneView.h
//  bonjourDemo
//
//  Created by 赵一帆 on 16/4/10.
//  Copyright © 2016年 ZYF. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NewPhoneViewDelegate <NSObject>

-(void)oldMobilePhoneConnectionPage;

@end

@interface newPhoneView : UIView

@property(nonatomic,weak)id<NewPhoneViewDelegate>delegate;
@end
