//
//  myView.h
//  测试equal的原理
//
//  Created by liuyang on 2018/8/2.
//  Copyright © 2018年 hui10. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface myView : UIView

@property (nonatomic,assign) CGFloat currentRadius;
-(void)beginDrawRect;

-(void)freshIcon:(CGFloat)r;
@end
