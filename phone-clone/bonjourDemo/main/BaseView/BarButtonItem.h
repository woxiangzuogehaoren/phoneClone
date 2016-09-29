//
//  LeftBarButtonItem.h
//  bonjourDemo
//
//  Created by wuqitao on 16/4/15.
//  Copyright © 2016年 ZYF. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BarButtonItemDelegate <NSObject>

@optional
-(void)leftBarButtonClick;
-(void)rightBarButtonClick;
@end

@interface BarButtonItem : UIButton
-(BarButtonItem *) initWithLeftButtonImageName:(NSString*)imageName;
-(BarButtonItem *) initWithRightButtonImageName:(NSString*)imageName;
@property (nonatomic,weak)id<BarButtonItemDelegate>delegate;
@end
