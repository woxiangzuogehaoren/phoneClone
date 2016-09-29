//
//  AboutPageView.h
//  bonjourDemo
//
//  Created by wuqitao on 16/4/21.
//  Copyright © 2016年 ZYF. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol AboutPageViewDelegate <NSObject>

-(void)privacyPolicy;

@end
@interface AboutPageView : UIView

@property(nonatomic,weak)id<AboutPageViewDelegate>deldgate;
@end
