//
//  MyViewController.m
//  测试equal的原理
//
//  Created by liuyang on 2018/8/2.
//  Copyright © 2018年 hui10. All rights reserved.
//

#import "MyViewController.h"
#import "MyColView.h"
#import "MyCustomSegment.h"
#import "MyTableView.h"
#import <Masonry/Masonry.h>



#define SCREENW  [UIScreen mainScreen].bounds.size.width
#define SCREENH  [UIScreen mainScreen].bounds.size.height

//一些常量
#define NaviH     64
#define segBar    40
#define colH      230
#define ScroH     SCREENH - NaviH - colH

#define level1      64
#define level2      140
#define level3      294
#define level4      187



@interface MyViewController ()<UIGestureRecognizerDelegate,MyCustomSegmentDelegate,UIScrollViewDelegate>
{
    CGFloat  _lasty;
    BOOL     _changeFrame;
}

@property (nonatomic, strong) MyColView *myView;
@property (nonatomic, strong) MyCustomSegment *segmentBar;
@property (nonatomic, strong) UIButton *btn;
@property (nonatomic, strong) MyTableView *lTableView;
@property (nonatomic, strong) MyTableView *rTableView;
@property (nonatomic, strong) UIScrollView *myScroller;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, strong) UIPanGestureRecognizer *down;
@property (nonatomic, strong) NSMutableArray<UITableView *> *tableViewArr;
@property (nonatomic, strong) UIView *containView;
@property (nonatomic, strong) UIView *scrContainView;
@property (nonatomic, strong) MyColView *coverView;

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.myView];

    self.btn = [[UIButton alloc] initWithFrame:CGRectMake(310, NaviH, 65, 65)];
    self.btn.backgroundColor = [UIColor blueColor];
    [self.btn setTitle:@"DOWN" forState:UIControlStateNormal];
    self.btn.hidden = YES;
    [self.btn addTarget:self action:@selector(expandClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btn];
    [self.view addSubview:self.coverView];
    [self.view addSubview:self.containView];
    [self makeConstraints];

    if (@available(iOS 11.0, *)) {
        self.myScroller.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        self.lTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        self.rTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    self.down = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePan:)];
    _down.delegate = self;
    [self.view addGestureRecognizer:_down];
    [_down addObserver:self forKeyPath:@"state" options:NSKeyValueObservingOptionNew context:nil];
    self.currentIndex = 0;
    
    [self.lTableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    [self.rTableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    _changeFrame = YES;
    _lasty = level3;
    
}

-(void)makeConstraints
{

    [self.segmentBar mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.left.top.right.mas_equalTo(_containView);
        make.height.mas_equalTo(segBar);
        
    }];
    [self.myScroller mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.left.bottom.right.mas_equalTo(_containView);
        make.top.mas_equalTo(_segmentBar.mas_bottom);
        
    }];
    
    [self.scrContainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(self.myScroller);
        make.centerY.mas_equalTo(self.myScroller.mas_centerY);
        make.width.mas_equalTo(SCREENW*2);
    }];
    
    [_lTableView mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.left.bottom.top.mas_equalTo(self.scrContainView);
        make.right.mas_equalTo(_rTableView.mas_left);
    }];
    [_rTableView mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.right.bottom.top.mas_equalTo(self.scrContainView);
        make.width.mas_equalTo(_lTableView.mas_width);
        
    }];
    
    
}



#pragma mark - 代理方法


-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    
    if ([keyPath isEqualToString:@"state"]) {
        
        UIPanGestureRecognizer *pan = (UIPanGestureRecognizer *)object;
        
        CGRect frame = [self obtainRect:self.containView];
        
        if (pan.state == UIGestureRecognizerStateBegan) {
            _lasty = frame.origin.y;
        }
        
        
        if ((pan.state == UIGestureRecognizerStateEnded) && (frame.origin.y == level2)) {
            pan.enabled = NO;
            self.tableViewArr[self.currentIndex].scrollEnabled = YES;
            [self ruleScrFrame:level2 withAnimate:NO andfinish:nil];
            _lasty = frame.origin.y;
            
            if ([self.myView alphaWithMin:level2 max:level3 current:frame.origin.y]) {
                self.coverView.hidden = NO;
                self.btn.hidden = NO;
                [self.coverView alphaUpWithMin:level2 max:level4 current:frame.origin.y];
            }else{
                self.coverView.hidden = YES;
                self.btn.hidden = YES;
            }
            
            
        }else if ((pan.state == UIGestureRecognizerStateEnded) && (frame.origin.y < level3-42)){
            self.tableViewArr[self.currentIndex].scrollEnabled = YES;
            pan.enabled = NO;
            [self ruleScrFrame:level2 withAnimate:NO andfinish:nil];
            _lasty = frame.origin.y;
            
            if ([self.myView alphaWithMin:level2 max:level3 current:level2]) {
                self.coverView.hidden = NO;
                self.btn.hidden = NO;
                [self.coverView alphaUpWithMin:level2 max:level4 current:level2];
            }else{
                self.coverView.hidden = YES;
                self.btn.hidden = YES;
            }
        }else if ((pan.state == UIGestureRecognizerStateEnded) && (frame.origin.y <= level3)){
            self.tableViewArr[self.currentIndex].scrollEnabled = YES;
            [self ruleScrFrame:level3 withAnimate:NO andfinish:nil];
            [self.myView alphaWithMin:level2 max:level3 current:level3];
            _lasty = frame.origin.y;
        }
    }else{
        
        if (self.tableViewArr[self.currentIndex].contentOffset.y > 0 && [self obtainy:_containView] <= level2 && [self obtainy:_containView] >= level1) {
            
            if (_changeFrame) {
                _changeFrame = NO;
                [self ruleScrFrame:level1 withAnimate:YES andfinish:^(BOOL finished) {
                    _changeFrame = YES;;
                }];
            }
        
        }else if(self.tableViewArr[self.currentIndex].contentOffset.y < 0 && [self obtainy:_containView] <= level2 && [self obtainy:_containView] >= level1){
            if (_changeFrame) {
                _changeFrame = NO;
                [self ruleScrFrame:level2 withAnimate:YES andfinish:^(BOOL finished) {
                _changeFrame = YES;;
            }];
            }
        }
        
        
    }
    
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([scrollView isEqual:self.myScroller]) {
      [self.segmentBar freshLittleFrame:scrollView.contentOffset];
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if ([scrollView isEqual:self.myScroller]) {
        self.currentIndex = scrollView.contentOffset.x/SCREENW;
    }
}




-(void)sendValue:(NSInteger)index
{
    //获得左右滑动
    self.currentIndex = index;
    [self.myScroller setContentOffset:CGPointMake(SCREENW*index, 0) animated:YES];
    [self.segmentBar freshLittleFrame:CGPointMake(SCREENW*index, 0)];
}


-(void)expandClick:(UIButton *)btnn
{
    self.coverView.hidden = YES;
    self.btn.hidden = YES;
    [self.coverView alphaUpWithMin:level2 max:level4 current:level4];
    self.coverView.alpha = 0.4;
    self.myView.alpha = 1;
    [self.myView alphaWithMin:level2 max:level3 current:level3];
    self.myView.hidden = NO;
    [self ruleScrFrame:level3 withAnimate:YES andfinish:nil];
    _down.enabled = YES;
}



#pragma mark - 手势处理
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if ([otherGestureRecognizer.view isKindOfClass:[MyTableView class]] || [otherGestureRecognizer.view isKindOfClass:[UIScrollView class]]) {
        return NO;
    }
    return YES;
}


// 给加的手势设置代理, 并实现此协议方法
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        UIPanGestureRecognizer *pan = (UIPanGestureRecognizer *)gestureRecognizer;
        CGPoint pos = [pan velocityInView:pan.view];
        //判断三种情况 在  level2～level3之间
        CGFloat y = [self obtainy:self.containView];
        if ((pos.y != 0 && y > level2) || (pos.y != 0 && y < level3) ) {
            self.tableViewArr[self.currentIndex].scrollEnabled = NO;
            return YES;
        }else{
            return NO;
        }
    }
    return NO;
}


-(void)handlePan:(UIPanGestureRecognizer *)pan
{
    
    CGPoint pos = [pan translationInView:pan.view];
    CGFloat y = pos.y+_lasty;
    if (y <=level2 && self.tableViewArr[self.currentIndex].scrollEnabled == NO) {
        [self ruleScrFrame:level2 withAnimate:NO andfinish:nil];
    }else if (y >= level3 && self.tableViewArr[self.currentIndex].scrollEnabled == NO){
        [self ruleScrFrame:level3 withAnimate:NO andfinish:nil];
    }else if(y < level3 && y > level2 && self.tableViewArr[self.currentIndex].scrollEnabled == NO){
        CGRect rect = self.containView.frame;
        rect.origin.y = y;
        rect.size.height = SCREENH - y;
        self.containView.frame = rect;
        if ([self.myView alphaWithMin:level2 max:level3 current:rect.origin.y]) {
            self.coverView.hidden = NO;
            self.btn.hidden = NO;
            if ([self.coverView alphaUpWithMin:level2 max:level4 current:rect.origin.y]) {
                self.btn.hidden = YES;
            }else{
                self.btn.hidden = NO;
            }
        }else{
            self.coverView.hidden = YES;
            self.btn.hidden = YES;
        }
    }
}



- (MyCustomSegment *)segmentBar
{
    if (!_segmentBar) {
        _segmentBar = [MyCustomSegment customSegment:CGRectMake(0, 0, SCREENW, segBar)];
        _segmentBar.delegate = self;
        _segmentBar.backgroundColor = [UIColor clearColor];
    }
    return _segmentBar;
}

- (UIScrollView *)myScroller{
    
    if (!_myScroller) {
        _myScroller = [[UIScrollView alloc] initWithFrame:CGRectZero];
        _myScroller.backgroundColor = [UIColor whiteColor];
        
        self.scrContainView = [[UIView alloc] init];
        [_myScroller addSubview:self.scrContainView];
        [self.scrContainView addSubview:self.lTableView];
        [self.scrContainView addSubview:self.rTableView];
        _myScroller.pagingEnabled = YES;
        _myScroller.delegate = self;
    }
    
    return  _myScroller;
}

- (UIView *)containView
{
    if(!_containView){
        _containView = [[UIView alloc] initWithFrame:CGRectMake(0, level3, SCREENW, 373)];
        [_containView addSubview:self.segmentBar];
        [_containView addSubview:self.myScroller];
        _containView.backgroundColor = [UIColor clearColor];
       
    }
    return _containView;
}



- (MyColView *)myView
{
    if (!_myView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize = CGSizeMake(65, 87);
        layout.minimumInteritemSpacing = 20;
        layout.minimumLineSpacing = 50;
        layout.sectionInset = UIEdgeInsetsMake(16, 40, 20, 40);
        _myView = [[MyColView alloc] initWithFrame:CGRectMake(0, NaviH,SCREENW, colH) collectionViewLayout:layout];
        _myView.dataArr = [@[@{@"icon":@"120",@"title":@"新人榜"},@{@"icon":@"120",@"title":@"新人榜"},
                            @{@"icon":@"120",@"title":@"新人榜"},@{@"icon":@"120",@"title":@"新人榜"},
                            @{@"icon":@"120",@"title":@"新人榜"},@{@"icon":@"120",@"title":@"新人榜"}
                           ] mutableCopy];
        
        _myView.alwaysBounceHorizontal = YES;
        _myView.backgroundColor = [UIColor clearColor];
    }
    return _myView;
}

- (MyColView *)coverView
{
    if (!_coverView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize = CGSizeMake(50, 50);
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 20;
        layout.sectionInset = UIEdgeInsetsMake(16, 0, 10, 20);
        _coverView = [[MyColView alloc] initWithFrame:CGRectMake(30, NaviH,SCREENW-85-30, 80) collectionViewLayout:layout];
        _coverView.dataArr = [@[@{@"icon":@"120",@"title":@""},@{@"icon":@"120",@"title":@""},
                             @{@"icon":@"120",@"title":@""},@{@"icon":@"120",@"title":@""},
                             @{@"icon":@"120",@"title":@""},@{@"icon":@"120",@"title":@""}
                             ] mutableCopy];
        _coverView.alwaysBounceHorizontal = YES;
        _coverView.hidden = YES;
        _coverView.backgroundColor = [UIColor clearColor];
        _coverView.alpha = 0.4;
    }
    
    return _coverView;
}



-(MyTableView *)lTableView
{
    if (!_lTableView) {
        _lTableView = [[MyTableView alloc] initWithFrame:CGRectMake(0, 0, SCREENW, SCREENH-NaviH-colH) style:UITableViewStylePlain];
       
    }
    return _lTableView;
}

-(MyTableView *)rTableView
{
    if (!_rTableView) {
        _rTableView = [[MyTableView alloc] initWithFrame:CGRectMake(SCREENW, 0, SCREENW, SCREENH-NaviH-colH) style:UITableViewStylePlain];
        
    }
    return _rTableView;
}

-(CGRect)obtainRect:(UIView *)view
{
    return view.frame;
}

-(CGFloat)obtainy:(UIView *)view
{
    return view.frame.origin.y;
}

-(NSMutableArray *)tableViewArr
{
    if (!_tableViewArr) {
        _tableViewArr = [[NSMutableArray alloc] initWithObjects:self.lTableView,self.rTableView, nil];
    }
    return _tableViewArr;
}



-(void)ruleScrFrame:(CGFloat)top withAnimate:(BOOL)animate andfinish:(void(^)(BOOL finished))finish
{
     CGFloat duration = animate?0.5:0;
    [UIView animateWithDuration:duration animations:^{
        CGFloat y = top;
        CGRect rect = [self obtainRect:self.containView];
        rect.origin.y = y;
        rect.size.height = SCREENH - top;
        self.containView.frame = rect;
    } completion:^(BOOL finished) {
        
        if (finish) {
           finish(finished);
        }
        
    }];
    
   
}











@end
