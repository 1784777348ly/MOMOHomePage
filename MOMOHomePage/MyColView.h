//
//  MyColView.h
//  测试equal的原理
//
//  Created by liuyang on 2018/8/2.
//  Copyright © 2018年 hui10. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyColView : UICollectionView

@property(nonatomic)NSMutableArray *dataArr;

- (BOOL)alphaWithMin:(CGFloat)min max:(CGFloat)max  current:(CGFloat)cur;

- (BOOL)alphaUpWithMin:(CGFloat)min max:(CGFloat)max  current:(CGFloat)cur;

@end
