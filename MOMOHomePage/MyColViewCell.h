//
//  MyColViewCell.h
//  测试equal的原理
//
//  Created by liuyang on 2018/8/2.
//  Copyright © 2018年 hui10. All rights reserved.
//

#import <UIKit/UIKit.h>

@class myView;

@interface MyColViewCell : UICollectionViewCell
@property(nonatomic, strong)myView  *viexw;

@property(nonatomic, copy)NSDictionary *dataDic;

-(void)freshTitle:(CGFloat)font;

-(void)freshImageFame:(CGFloat)x  titleframe:(CGFloat)f  cutx:(CGFloat)cut;



@end
