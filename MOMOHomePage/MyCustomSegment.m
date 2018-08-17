//
//  MyCustomSegment.m
//  测试equal的原理
//
//  Created by liuyang on 2018/8/2.
//  Copyright © 2018年 hui10. All rights reserved.
//

#import "MyCustomSegment.h"

#define SCREENW  [UIScreen mainScreen].bounds.size.width
#define SCREENH  [UIScreen mainScreen].bounds.size.height

@interface MyCustomSegment ()
{
    CGRect   _currentRect;
}

@property (retain, nonatomic) IBOutlet UIButton *recommand;
@property (retain, nonatomic) IBOutlet UIButton *miquan;
@property (retain, nonatomic) IBOutlet UIView *littleView;

@end

@implementation MyCustomSegment


+(instancetype)customSegment:(CGRect)rect
{
     MyCustomSegment *sview = [[[NSBundle mainBundle] loadNibNamed:@"MyCustomSegment" owner:self options:nil] lastObject];
     sview.frame = rect;
    return sview;
}


//-(instancetype)customSegmentd:(CGRect)rect
//{
//
//    return sview;
//}


- (IBAction)recommandClick:(UIButton *)sender {
    [self.delegate sendValue:0];
    
}


- (IBAction)quanClick:(UIButton *)sender {
    [self.delegate sendValue:1];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    if (_currentRect.origin.x >0) {
        self.littleView.frame = _currentRect;
    }
}


#pragma mark - 修改下面的小白线的位置

-(void)freshLittleFrame:(CGPoint)contentOffset
{
    CGFloat widths = CGRectGetMaxX(self.miquan.frame) - CGRectGetMinX(self.recommand.frame);
    CGRect rect = self.littleView.frame;
    rect.origin.x = self.recommand.frame.origin.x + contentOffset.x/(SCREENW*2)*widths;
    [self.littleView setFrame:rect];
     _currentRect = rect;
}




@end
