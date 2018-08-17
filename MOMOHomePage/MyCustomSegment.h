//
//  MyCustomSegment.h
//  测试equal的原理
//
//  Created by liuyang on 2018/8/2.
//  Copyright © 2018年 hui10. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MyCustomSegmentDelegate // 代理传值方法

- (void)sendValue:(NSInteger )index;

@end

@interface MyCustomSegment : UIView

@property(nonatomic, weak)id<MyCustomSegmentDelegate>delegate;

+(instancetype)customSegment:(CGRect)rect;

-(void)freshLittleFrame:(CGPoint)contentOffset;


@end
