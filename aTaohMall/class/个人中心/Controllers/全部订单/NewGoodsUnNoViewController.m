//
//  NewGoodsUnNoViewController.m
//  aTaohMall
//
//  Created by JMSHT on 2017/4/21.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "NewGoodsUnNoViewController.h"

@interface NewGoodsUnNoViewController ()

@end

@implementation NewGoodsUnNoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor =[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, KSafeAreaTopNaviHeight)];
    
    titleView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:titleView];
    
    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight-1, [UIScreen mainScreen].bounds.size.width, 1)];
    
    line.image = [UIImage imageNamed:@"分割线-拷贝"];
    
    [self.view addSubview:line];
    
    
    //返回按钮
    
    UIButton *Qurt = [UIButton buttonWithType:UIButtonTypeCustom];
    
    Qurt.frame = CGRectMake(10, 25+KSafeTopHeight, 30, 30);
    
    [Qurt setBackgroundImage:[UIImage imageNamed:@"iconfont-fanhui2yt"] forState:0];
    
    
    [Qurt addTarget:self action:@selector(QurtBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [titleView addSubview:Qurt];
    
    //创建搜索
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 25+KSafeTopHeight, [UIScreen mainScreen].bounds.size.width-200, 30)];
    
    label.text = @"商品过期不存在";
    
    label.textColor = [UIColor blackColor];
    
    label.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:19];
    
    label.textAlignment = NSTextAlignmentCenter;
    
    [titleView addSubview:label];
    
    UIImageView *bgImage=[[UIImageView alloc] initWithFrame:CGRectMake((self.view.frame.size.width-120)/2, 100, 120, 120)];
    
    bgImage.image=[UIImage imageNamed:@"商品过期"];
    
    
    [self.view addSubview:bgImage];
    
    
    UILabel *bgLabel=[[UILabel alloc] initWithFrame:CGRectMake(20, 240+KSafeTopHeight, self.view.frame.size.width-40, 23)];
    
    bgLabel.text=@"商品过期不存在";
    
    bgLabel.textAlignment=NSTextAlignmentCenter;
    
    bgLabel.textColor=[UIColor colorWithRed:170/255.0 green:170/255.0 blue:170/255.0 alpha:1.0];
    
    bgLabel.font=[UIFont systemFontOfSize:19];
    
    [self.view addSubview:bgLabel];
    
    
}

-(void)QurtBtnClick
{
    
    [self.navigationController popViewControllerAnimated:NO];
    
}

@end
