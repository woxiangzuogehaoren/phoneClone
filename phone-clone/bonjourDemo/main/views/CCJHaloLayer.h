//
//  CCJHaloLayer.h
//  bonjourDemo
//
//  Created by wuqitao on 16/4/14.
//  Copyright © 2016年 ZYF. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
@interface CCJHaloLayer : CALayer
@property (nonatomic, assign) CGFloat bigRadius;
@property (nonatomic, assign) NSTimeInterval animationDuration;
@property (nonatomic, assign) NSTimeInterval pulseInterval;

@property (nonatomic, strong) CAAnimationGroup *animationGroup;

-(instancetype)initWithColor:(CGColorRef)colorref;

@end
