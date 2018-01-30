//
//  PersonSettingInfoVC.m
//  aTaohMall
//
//  Created by Zhending Shi on 2017/9/18.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "PersonSettingInfoVC.h"

@interface PersonSettingInfoVC ()

@end

@implementation PersonSettingInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
}
//界面初始化
-(void)setUI
{
    [self initNavi];
    [self initMainView];
    
}
//初始化导航栏
-(void)initNavi
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
    
    //    [Qurt setBackgroundImage:[UIImage imageNamed:@"iconfont-fanhui2yt"] forState:0];
    
    [Qurt setImage:[UIImage imageNamed:@"iconfont-fanhui2yt"] forState:0];
    
    [Qurt addTarget:self action:@selector(QurtBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [titleView addSubview:Qurt];
    
    //创建搜索
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 25+KSafeTopHeight, [UIScreen mainScreen].bounds.size.width-200, 30)];
    
    label.text = @"设置";
    
    label.textColor = [UIColor blackColor];
    
    label.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:19];
    
    label.textAlignment = NSTextAlignmentCenter;
    
    [titleView addSubview:label];
    //设置不自动调整导航栏布局和左滑退出手势不可用
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    
}
//初始化主视图
-(void)initMainView
{
    self.view.backgroundColor=RGB(244, 244, 244);
    
    UIView *PersonInfoView=[[UIView alloc]initWithFrame:CGRectMake(0, 75, kScreen_Width, 60)];
    PersonInfoView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:PersonInfoView];
    
    
    
    
    
    
    
    
}

-(void)QurtBtnClick
{
    [self.navigationController popViewControllerAnimated:NO];
}

@end
