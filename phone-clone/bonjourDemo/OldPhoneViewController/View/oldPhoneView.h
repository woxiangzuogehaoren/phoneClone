//
//  oldPhoneView.h
//  bonjourDemo
//
//  Created by 赵一帆 on 16/4/11.
//  Copyright © 2016年 ZYF. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OldPhoneViewDelegate <NSObject>

-(void)searchForMobilePhones;

@end

@interface oldPhoneView : UIView

@property(nonatomic,weak)id<OldPhoneViewDelegate>delegate;
@end
