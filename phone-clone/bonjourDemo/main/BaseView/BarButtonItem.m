//
//  LeftBarButtonItem.m
//  bonjourDemo
//
//  Created by wuqitao on 16/4/15.
//  Copyright © 2016年 ZYF. All rights reserved.
//

#import "BarButtonItem.h"

@implementation BarButtonItem
-(BarButtonItem *) initWithLeftButtonImageName:(NSString *)imageName{
    
    BarButtonItem * button = [[BarButtonItem alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    [button  setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(toPlayLeft) forControlEvents:UIControlEventTouchUpInside];

    
    return button;
}
-(BarButtonItem*)initWithRightButtonImageName:(NSString*)imageName{
    
    BarButtonItem * button = [[BarButtonItem alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    [button  setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(toPlayRight) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

-(void)toPlayLeft {

    if ([self.delegate respondsToSelector:@selector(leftBarButtonClick)]) {
        [self.delegate leftBarButtonClick];
    }
}
-(void)toPlayRight{
    if ([self.delegate respondsToSelector:@selector(rightBarButtonClick)]) {
        [self.delegate rightBarButtonClick];
    }
    
}

@end
