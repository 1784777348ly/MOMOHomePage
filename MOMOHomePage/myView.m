//
//  myView.m
//  测试equal的原理
//
//  Created by liuyang on 2018/8/2.
//  Copyright © 2018年 hui10. All rights reserved.
//

#import "myView.h"

#define MaxRadius     30

@interface myView ()
{
    CGFloat _xy;
}




@end

@implementation myView

-(void)beginDrawRect
{
    _currentRadius = 30;
    _xy = 0;
    
    self.backgroundColor = [UIColor clearColor];
    [self setNeedsDisplay];
    
}

-(void)freshIcon:(CGFloat)r
{
    _currentRadius = 27 + r;
    _xy = sqrtf(3-r);
    [self setNeedsDisplay];
}



-(void)drawRect:(CGRect)rect
{
    UIColor *drawColor = [UIColor yellowColor];
    [drawColor setStroke];
    CGRect newFrame = CGRectMake(_xy, _xy, _currentRadius*2, _currentRadius*2);
    UIBezierPath *bPath = [UIBezierPath bezierPathWithRoundedRect:newFrame cornerRadius:_currentRadius];
    [drawColor setFill];
    [bPath closePath];
    [bPath stroke];
    [bPath fill];
}





@end
