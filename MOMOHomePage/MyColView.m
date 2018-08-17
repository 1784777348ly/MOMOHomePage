
//
//  MyColView.m
//  测试equal的原理
//
//  Created by liuyang on 2018/8/2.
//  Copyright © 2018年 hui10. All rights reserved.
//

#import "MyColView.h"
#import "MyColViewCell.h"
#import "myView.h"

#define minalpha 0.4



static NSString *cell = @"MyColViewCell";

@interface MyColView ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

@end

@implementation MyColView

-(instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    if (self == [super initWithFrame:frame collectionViewLayout:layout]) {
        
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[MyColViewCell class] forCellWithReuseIdentifier:cell];
        if (@available(iOS 11.0, *)) {
            self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
                
    }
    
    return self;
}

#pragma mark - 代理方法

//返回指定区(section)包含的数据源条目数(number of items)，该方法必须实现：
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return  self.dataArr.count;
}

//返回某个indexPath对应的cell，该方法必须实现：

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    MyColViewCell *cells =  [collectionView dequeueReusableCellWithReuseIdentifier:cell forIndexPath:indexPath];
    cells.dataDic = self.dataArr[indexPath.row];
    return cells;
    
}


//点击每个item实现的方法：

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (BOOL)alphaWithMin:(CGFloat)min max:(CGFloat)max  current:(CGFloat)cur
{

    CGFloat cut = 5;
    
    CGFloat pera = (1-minalpha)/(max-min);
    
    CGFloat perr = cut/(max-min);
    
    CGFloat perl = 2/(max-min);
    
    CGFloat current = cur - min;
    
    self.alpha = minalpha+current*pera;
    
    for (int i=0; i<6; i++) {
        NSIndexPath *path = [NSIndexPath indexPathForRow:i inSection:0];
        MyColViewCell *cell = (MyColViewCell *)[self cellForItemAtIndexPath:path];
        [cell freshImageFame:current*perr titleframe:current*perl cutx:cut];
    }
    
    if (self.alpha <= minalpha+0.01) {
        self.hidden = YES;
    }else{
        self.hidden = NO;
    }
    
    if (cur <= 187) {
        return YES;
    }else{
        return NO;
    }
}

- (BOOL)alphaUpWithMin:(CGFloat)min max:(CGFloat)max  current:(CGFloat)cur
{
    
    CGFloat cut = 20;
    
    CGFloat pera = (1-minalpha)/(max-min);
    
    CGFloat perr = cut/(max-min);
    
    CGFloat current = (cur - max)*-1;
    
    self.alpha = minalpha+current*pera;
    
    for (int i=0; i<6; i++) {
        NSIndexPath *path = [NSIndexPath indexPathForRow:i inSection:0];
        MyColViewCell *cell = (MyColViewCell *)[self cellForItemAtIndexPath:path];
        [cell freshImageFame:current*perr titleframe:0 cutx:cut];
    }
    
    if (self.alpha <= minalpha+0.01) {
        self.hidden = YES;
        return YES;
    }else{
        self.hidden = NO;
        return NO;
    }
    
}









@end
