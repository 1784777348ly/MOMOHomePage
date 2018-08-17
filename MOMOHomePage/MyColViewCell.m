//
//  MyColViewCell.m
//  测试equal的原理
//
//  Created by liuyang on 2018/8/2.
//  Copyright © 2018年 hui10. All rights reserved.
//

#import "MyColViewCell.h"
#import "myView.h"
#import <Masonry/Masonry.h>


@interface MyColViewCell ()

@property(nonatomic, strong)UIImageView *imageView;

@property(nonatomic, strong)UILabel *botLabel;


@end

@implementation MyColViewCell


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        CGRect rect = self.bounds;
        self.contentView.clipsToBounds = YES;
        self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, rect.size.width, rect.size.width)];
        self.imageView.image = [UIImage imageNamed:@"120"];
        [self.contentView addSubview:_imageView];
        
        self.botLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, rect.size.width+10, rect.size.width, 12)];
        self.botLabel.text = @"";
        self.botLabel.font = [UIFont systemFontOfSize:12];
        self.botLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.botLabel];

    }
    return self;
    
}

-(void)makeMaswith:(UIView *)view1 andView:(UIView *)view2 andCommonView:(UIView *)view
{
    
//    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.right.top.mas_
//        
//    }];
//
//    [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
//
//    }];
//
}

-(void)freshTitle:(CGFloat)font
{
   
}

-(void)setDataDic:(NSDictionary *)dataDic
{
    _dataDic = [dataDic copy];
    
    self.imageView.image = [UIImage imageNamed:dataDic[@"icon"]];
    if ([dataDic[@"title"] description].length == 0) {
        self.botLabel.hidden = YES;
    }else{
        self.botLabel.hidden = NO;
        self.botLabel.text = dataDic[@"title"];
    }
}




-(void)freshImageFame:(CGFloat)x  titleframe:(CGFloat)f  cutx:(CGFloat)cut
{
    CGRect rect = self.frame;
    CGFloat  w = rect.size.width;
    rect.origin.x = cut-x;
    rect.origin.y = cut-x;
    rect.size.width = w-(cut-x)*2;
    rect.size.height = w-(cut-x)*2;
    self.imageView.frame = rect;
    
//    CGRect rectx = self.botLabel.frame;
//    rectx.size.height = 18+f;
//    self.botLabel.frame = rectx;
    
    
//    [self.botLabel setFont:[UIFont systemFontOfSize:15+f]];
}





@end
