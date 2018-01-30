//
//  PersonAllScoreVC.m
//  aTaohMall
//
//  Created by Hawky on 2017/11/10.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "PersonAllScoreVC.h"
#import "PersonHealthyScoreVC.h"
#import "NewScoreViewController.h"


@interface PersonAllScoreVC ()<UIScrollViewDelegate>
@property (nonatomic,strong)UIImage *BackImage;
@property (nonatomic,strong)UIButton *NewScoreBut;
@property (nonatomic,strong)UIButton *HealthyBut;
@property (nonatomic,strong)NewScoreViewController *newScoreVC;
@property (nonatomic,strong)PersonHealthyScoreVC *HealthyScoreVC;
@property (nonatomic,strong)UIScrollView  *ContentView;
@end

@implementation PersonAllScoreVC

/*******************************************************      控制器生命周期       ******************************************************/
- (void)viewDidLoad {
    [super viewDidLoad];
    [self SetUI];

}

-(void)SetUI
{
    [self InitNavi];
    [self.view addSubview:self.ContentView];
    [self newScoreVC];
    [self HealthyScoreVC];
    self.ContentView.contentSize=CGSizeMake(kScreen_Width*2, kScreen_Height-KSafeAreaTopNaviHeight);
}
/*******************************************************      数据请求       ******************************************************/


/*******************************************************      初始化视图       ******************************************************/
-(void)InitNavi
{
    UIImageView *titleView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, KSafeAreaTopNaviHeight)];

    UIImage *img=[self.BackImage getSubImage:CGRectMake(0, 0, kScreen_Width, KSafeAreaTopNaviHeight)];
    [titleView setImage:img];
    titleView.userInteractionEnabled=YES;
    [self.view addSubview:titleView];

    //返回按钮

    UIButton *Qurt = [UIButton buttonWithType:UIButtonTypeCustom];

    Qurt.frame = CGRectMake(10, 25+KSafeTopHeight, 30, 30);

    //    [Qurt setBackgroundImage:[UIImage imageNamed:@"iconfont-fanhui2yt"] forState:0];

    [Qurt setImage:[UIImage imageNamed:@"iconfont-fanhui2"] forState:UIControlStateNormal];
  //  [Qurt setImage:[UIImage imageNamed:@"iconfont-fanhui2"] forState:UIControlStateSelected];
    [Qurt addTarget:self action:@selector(QurtBtnClick) forControlEvents:UIControlEventTouchUpInside];

    [titleView addSubview:Qurt];

    //创建搜索

    self.NewScoreBut=[UIButton buttonWithType:UIButtonTypeCustom];
    self.NewScoreBut.frame=CGRectMake((kScreen_Width-72*2-Width(20))/2.0, 32+KSafeTopHeight, 72, 18);
    self.NewScoreBut.titleLabel.font=KNSFONTM(18);
    [self.NewScoreBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.NewScoreBut setTitle:@"购物积分" forState:UIControlStateNormal];

    self.HealthyBut=[UIButton buttonWithType:UIButtonTypeCustom];
    self.HealthyBut.frame=CGRectMake(kScreen_Width/2.0+Width(12), 34+KSafeTopHeight, 64, 17);
    self.HealthyBut.titleLabel.font=KNSFONTM(16);
    [self.HealthyBut setTitle:@"健康积分" forState:UIControlStateNormal];
    [self.HealthyBut setTitleColor:RGBA(254, 254, 254, 0.5) forState:UIControlStateNormal];
    [self.HealthyBut addTarget:self action:@selector(selectorBMDan:) forControlEvents:UIControlEventTouchUpInside];

    [titleView addSubview:self.NewScoreBut];
    [titleView addSubview:self.HealthyBut];

    //设置不自动调整导航栏布局和左滑退出手势不可用
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}

/*******************************************************      各种button执行方法、页面间的跳转       ******************************************************/

-(void)QurtBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)selectorBMDan:(UIButton *)sender
{

    [UIView animateWithDuration:0.5 animations:^{
        self.NewScoreBut.titleLabel.font=KNSFONTM(16);
        self.NewScoreBut.frame=CGRectMake(kScreen_Width/2.0-63-Width(13), 34+KSafeTopHeight, 64, 17);
        [self.NewScoreBut setTitleColor:RGBA(244, 244, 244, 0.5) forState:UIControlStateNormal];

        self.HealthyBut.frame=CGRectMake(kScreen_Width/2.0+10, 32+KSafeTopHeight, 72, 18);
        self.HealthyBut.titleLabel.font=KNSFONTM(18);
        [self.HealthyBut setTitleColor:RGB(255, 255, 255) forState:UIControlStateNormal];

        self.ContentView.contentOffset=CGPointMake(kScreen_Width, 0);
    } completion:^(BOOL finished) {
        [self.NewScoreBut addTarget:self action:@selector(selectorShoppingDan:) forControlEvents:UIControlEventTouchUpInside];
        [self.HealthyBut removeTarget:self action:@selector(selectorBMDan:) forControlEvents:UIControlEventTouchUpInside];
    }];
}

-(void)selectorShoppingDan:(UIButton *)sender
{
    [UIView animateWithDuration:0.5 animations:^{

        self.NewScoreBut.frame=CGRectMake((kScreen_Width-72*2-Width(20))/2.0, 32+KSafeTopHeight, 72, 18);
        self.NewScoreBut.titleLabel.font=KNSFONTM(18);
        [self.NewScoreBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];


        self.HealthyBut.frame=CGRectMake(kScreen_Width/2.0+Width(12), 34+KSafeTopHeight, 64, 17);
        self.HealthyBut.titleLabel.font=KNSFONTM(16);
        [self.HealthyBut setTitleColor:RGBA(254, 254, 254, 0.5) forState:UIControlStateNormal];

        self.ContentView.contentOffset=CGPointMake(0, 0);
    } completion:^(BOOL finished) {
        [self.NewScoreBut removeTarget:self action:@selector(selectorShoppingDan:) forControlEvents:UIControlEventTouchUpInside];
        [self.HealthyBut addTarget:self action:@selector(selectorBMDan:) forControlEvents:UIControlEventTouchUpInside];
    }];

}


/*******************************************************      协议方法       ******************************************************/


/*******************************************************      代码提取(多是复用代码)       ******************************************************/

-(NewScoreViewController *)newScoreVC
{
    if (!_newScoreVC) {
        _newScoreVC=[[NewScoreViewController alloc] init];
        CGSize size = self.ContentView.bounds.size;
        _newScoreVC.view.frame=CGRectMake(0, 0, size.width, size.height);
        [self.ContentView addSubview:_newScoreVC.view];
        [self addChildViewController:_newScoreVC];
    }
    return _newScoreVC;
}

-(PersonHealthyScoreVC *)HealthyScoreVC
{
    if (!_HealthyScoreVC) {
        _HealthyScoreVC=[[PersonHealthyScoreVC alloc]init];
        CGSize size = self.ContentView.bounds.size;
        _HealthyScoreVC.view.frame=CGRectMake(size.width, 0, size.width, size.height);
        [self.ContentView addSubview:_HealthyScoreVC.view];
        [self addChildViewController:_HealthyScoreVC];
    }
    return _HealthyScoreVC;
}

-(UIScrollView *)ContentView
{
    if (!_ContentView) {
        _ContentView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight, kScreen_Width, kScreen_Height-KSafeAreaTopNaviHeight)];
        _ContentView.delegate=self;
        _ContentView.scrollEnabled=NO;
    }
    return _ContentView;

}
-(UIImage *)BackImage
{
    if (!_BackImage) {
        _BackImage=[UIImage imageWithImageView:CGRectMake(0, 0, kScreen_Width, KSafeAreaTopNaviHeight+Height(92)) StartColor:RGB(255, 52, 90) EndColor:RGB(255, 93, 94) startPoint:CGPointMake(0, 0) endPoint:CGPointMake(0, KSafeAreaTopNaviHeight+Height(92))];
    }
    return _BackImage;
}

@end
