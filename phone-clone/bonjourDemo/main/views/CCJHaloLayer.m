//
//  CCJHaloLayer.m
//  bonjourDemo
//
//  Created by wuqitao on 16/4/14.
//  Copyright © 2016年 ZYF. All rights reserved.
//

#import "CCJHaloLayer.h"
@interface CCJHaloLayer()

@property (nonatomic,assign) CGColorRef borderColorref;

@end

@implementation CCJHaloLayer


-(instancetype)initWithColor:(CGColorRef)colorref{
    self = [super init];
    if (self) {
        self.contentsScale = [UIScreen mainScreen].scale;
        self.opacity = 0;
        _borderColorref = colorref;
        self.bigRadius = 150;
        self.animationDuration = 2.0;
        self.pulseInterval = 0;
    
        

        self.backgroundColor = [[UIColor clearColor] CGColor];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void) {
        
            [self setupAnimationGroup];
            
            if(self.pulseInterval != INFINITY) {
                
                dispatch_async(dispatch_get_main_queue(), ^(void) {
                
                    [self addAnimation:self.animationGroup forKey:nil];
                });
            }
        });
    }
        
    return self;
}


- (void)setBigRadius:(CGFloat)radius {
    
    _bigRadius = radius;

    CGPoint tempPos = self.position;
    CGFloat diameter = self.bigRadius * 2;
    self.bounds = CGRectMake(0, 0, diameter, diameter);
    self.borderWidth = 1;
    [self setBorderColor:_borderColorref];//边框颜色
    self.cornerRadius = self.bigRadius;
    self.position = tempPos;
    
   
}

- (void)setupAnimationGroup {
    
    CAMediaTimingFunction *defaultCurve = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    
    self.animationGroup = [CAAnimationGroup animation];
    self.animationGroup.duration = self.animationDuration + self.pulseInterval;
    self.animationGroup.repeatCount = INFINITY;
    self.animationGroup.removedOnCompletion = YES;
    self.animationGroup.timingFunction = defaultCurve;
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale.xy"];
    scaleAnimation.fromValue = @0.0;
    scaleAnimation.toValue = @1.0;
    scaleAnimation.duration = self.animationDuration;
    
    CAKeyframeAnimation *opacityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.duration = self.animationDuration;
    opacityAnimation.values = @[@0.8, @0.4, @0];
    opacityAnimation.keyTimes = @[@0, @0.5, @1];
    opacityAnimation.removedOnCompletion = NO;
    
    NSArray *animations = @[scaleAnimation, opacityAnimation];
    
    self.animationGroup.animations = animations;
}
@end
