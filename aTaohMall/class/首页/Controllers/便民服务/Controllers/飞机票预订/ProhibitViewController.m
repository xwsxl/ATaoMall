//
//  ProhibitViewController.m
//  aTaohMall
//
//  Created by JMSHT on 2017/6/6.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "ProhibitViewController.h"

#import "UIView+Frame.h"
@interface ProhibitViewController ()<UIScrollViewDelegate>
{
    
    UIScrollView *_scrollView;
    UIImageView *ImgView;
    
}
@end

@implementation ProhibitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.frame=[UIScreen mainScreen].bounds;
    
    [self initNav];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-KSafeAreaTopNaviHeight)];
    _scrollView.delegate = self;
    _scrollView.minimumZoomScale = 1;
    _scrollView.maximumZoomScale = 2;
    _scrollView.bounces = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    
    [self.view addSubview:_scrollView];
    
    ImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-65)];
    ImgView.image = [UIImage imageNamed:@"关于禁止携带危险品乘机的通知"];
    
    [_scrollView addSubview:ImgView];
    
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    tap.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:tap];
    
}

static CGFloat scale = 1.5;
static bool isBig = NO;
static CGPoint imagePoint;
static CGSize size;
- (void)tap:(UITapGestureRecognizer *)tap{
    
    imagePoint = [tap locationInView:ImgView];
    
    if(isBig == NO)
    {
        if(CGRectContainsPoint(ImgView.bounds, imagePoint)){
            size = ImgView.size;
            // 向上、向左偏移的距离
            CGFloat top,left;
            top = imagePoint.y * (scale - 1);
            left = imagePoint.x * (scale - 1);
            [UIView animateWithDuration:0.5 animations:^{
                ImgView.frame = CGRectMake(-left, -top,size.width * scale , size.height * scale);
            }];
            _scrollView.contentSize = CGSizeMake(size.width * scale , size.height * scale);
            _scrollView.contentInset = UIEdgeInsetsMake(top, left, -top, -left);
            isBig = YES;
        }
        
    }else{
        
        [UIView animateWithDuration:.5f animations:^{
            _scrollView.contentOffset = CGPointMake(0, 0);
            ImgView.frame = CGRectMake(0, 0, size.width, size.height);
        }];
        _scrollView.contentInset = UIEdgeInsetsMake(0,0,0,0);
        _scrollView.contentSize = size;
        
        isBig = NO;
    }
    
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return ImgView;
}

//创建导航栏
-(void)initNav
{
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, KSafeAreaTopNaviHeight)];
    
    titleView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:titleView];
    
    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight-1, [UIScreen mainScreen].bounds.size.width, 1)];
    
    line.image = [UIImage imageNamed:@"分割线-拷贝"];
    
    [self.view addSubview:line];
    
    
    //返回按钮
    
    UIButton *Qurt = [UIButton buttonWithType:UIButtonTypeCustom];
    
    Qurt.frame = CGRectMake(10, 25+KSafeTopHeight, 30, 30);
    
    [Qurt setImage:[UIImage imageNamed:@"iconfont-fanhui2yt"] forState:0];
    
    
    [Qurt addTarget:self action:@selector(QurtBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [titleView addSubview:Qurt];
    
    //创建搜索
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(40, 25+KSafeTopHeight, [UIScreen mainScreen].bounds.size.width-80, 30)];
    
    label.text = @"关于禁止携带危险品乘机的通知";
    
    label.textColor = [UIColor blackColor];
    
    label.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:19];
    
    label.textAlignment = NSTextAlignmentCenter;
    
    [titleView addSubview:label];
    
}
-(void)QurtBtnClick
{
    [self.navigationController popViewControllerAnimated:NO];
    
}

@end
