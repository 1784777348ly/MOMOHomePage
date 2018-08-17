//
//  MyTableView.m
//  测试equal的原理
//
//  Created by liuyang on 2018/8/2.
//  Copyright © 2018年 hui10. All rights reserved.
//

#import "MyTableView.h"
#import "MyTableViewCell.h"

@interface MyTableView ()<UITableViewDelegate,UITableViewDataSource>

@end

static  NSString *ID = @"MyTableViewCell";

@implementation MyTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self == [super initWithFrame:frame style:style]) {
        
        self.delegate = self;
        self.dataSource = self;
        self.tableFooterView = [UIView new];
        if (@available(iOS 11.0, *)) {
            self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        [self registerNib:[UINib nibWithNibName:@"MyTableViewCell" bundle:nil]  forCellReuseIdentifier:ID];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}










@end
