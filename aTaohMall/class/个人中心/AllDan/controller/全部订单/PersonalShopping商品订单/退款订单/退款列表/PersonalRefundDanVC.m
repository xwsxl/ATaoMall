//
//  PersonalRefundDanVC.m
//  aTaohMall
//
//  Created by Hawky on 2017/11/23.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "PersonalRefundDanVC.h"
#import "PersonalShoppingRefundListVC.h"
#import "PersonalBMDanVC.h"

@interface PersonalRefundDanVC ()<UIScrollViewDelegate>
@property (nonatomic,strong)UIButton *ShoppingDanBut;
@property (nonatomic,strong)UIButton *BMDanBut;
@property (nonatomic,strong)PersonalShoppingRefundListVC *ShoppingRefundDanVC;
@property (nonatomic,strong)PersonalBMDanVC *BMDanVC;
@property (nonatomic,strong)UIScrollView  *ContentView;
@end

@implementation PersonalRefundDanVC
/*******************************************************      控制器生命周期       ******************************************************/
- (void)viewDidLoad {
    [super viewDidLoad];
    [self SetUI];

}
-(void)selectedIndexType:(NSInteger )index
{

}

-(void)SetUI
{
    [self InitNavi];
    [self.view addSubview:self.ContentView];
    [self ShoppingRefundDanVC];
    [self BMDanVC];
    [self.BMDanVC selectedIndexType:0];
    self.ContentView.contentSize=CGSizeMake(kScreen_Width*2, kScreen_Height-65);
}
/*******************************************************      数据请求       ******************************************************/


/*******************************************************      初始化视图       ******************************************************/
-(void)InitNavi
{

    UIImageView *titleView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, KSafeAreaTopNaviHeight)];

    [titleView setImage:[UIImage imageWithImageView:titleView.bounds StartColor:RGB(255, 52, 90) EndColor:RGB(255, 93, 94) startPoint:CGPointMake(0, 0) endPoint:CGPointMake(0, KSafeAreaTopNaviHeight)]];
    titleView.userInteractionEnabled=YES;
    [self.view addSubview:titleView];

    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight, [UIScreen mainScreen].bounds.size.width, 1)];

    line.image = [UIImage imageNamed:@"分割线-拷贝"];

    [self.view addSubview:line];

    //返回按钮

    UIButton *Qurt = [UIButton buttonWithType:UIButtonTypeCustom];

    Qurt.frame = CGRectMake(10, 25+KSafeTopHeight, 30, 30);

    //    [Qurt setBackgroundImage:[UIImage imageNamed:@"iconfont-fanhui2yt"] forState:0];

    [Qurt setImage:[UIImage imageNamed:@"iconfont-fanhui2"] forState:UIControlStateNormal];
    [Qurt addTarget:self action:@selector(QurtBtnClick) forControlEvents:UIControlEventTouchUpInside];

    [titleView addSubview:Qurt];

    //创建搜索

    self.ShoppingDanBut=[UIButton buttonWithType:UIButtonTypeCustom];
    self.ShoppingDanBut.frame=CGRectMake((kScreen_Width-72*2-Width(20))/2.0, 32+KSafeTopHeight, 72, 18);
    self.ShoppingDanBut.titleLabel.font=KNSFONTM(18);
    [self.ShoppingDanBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.ShoppingDanBut setTitle:@"商品订单" forState:UIControlStateNormal];

    self.BMDanBut=[UIButton buttonWithType:UIButtonTypeCustom];
    self.BMDanBut.frame=CGRectMake(kScreen_Width/2.0+Width(12), 34+KSafeTopHeight, 64, 17);
    self.BMDanBut.titleLabel.font=KNSFONTM(16);
    [self.BMDanBut setTitle:@"便民订单" forState:UIControlStateNormal];
    [self.BMDanBut setTitleColor:RGBA(254, 254, 254, 0.5) forState:UIControlStateNormal];
    [self.BMDanBut addTarget:self action:@selector(selectorBMDan:) forControlEvents:UIControlEventTouchUpInside];

    [titleView addSubview:self.ShoppingDanBut];
    [titleView addSubview:self.BMDanBut];

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
        self.ShoppingDanBut.titleLabel.font=KNSFONTM(16);
        self.ShoppingDanBut.frame=CGRectMake(kScreen_Width/2.0-63-Width(13), 34+KSafeTopHeight, 64, 17);
        [self.ShoppingDanBut setTitleColor:RGBA(244, 244, 244, 0.5) forState:UIControlStateNormal];

        self.BMDanBut.frame=CGRectMake(kScreen_Width/2.0+10, 32+KSafeTopHeight, 72, 18);
        self.BMDanBut.titleLabel.font=KNSFONTM(18);
        [self.BMDanBut setTitleColor:RGB(255, 255, 255) forState:UIControlStateNormal];

        self.ContentView.contentOffset=CGPointMake(kScreen_Width, 0);
    } completion:^(BOOL finished) {
        [self.ShoppingDanBut addTarget:self action:@selector(selectorShoppingDan:) forControlEvents:UIControlEventTouchUpInside];
        [self.BMDanBut removeTarget:self action:@selector(selectorBMDan:) forControlEvents:UIControlEventTouchUpInside];
    }];
}

-(void)selectorShoppingDan:(UIButton *)sender
{
    [UIView animateWithDuration:0.5 animations:^{

        self.ShoppingDanBut.frame=CGRectMake((kScreen_Width-72*2-Width(20))/2.0, 32+KSafeTopHeight, 72, 18);
        self.ShoppingDanBut.titleLabel.font=KNSFONTM(18);
        [self.ShoppingDanBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];


        self.BMDanBut.frame=CGRectMake(kScreen_Width/2.0+Width(12), 34+KSafeTopHeight, 64, 17);
        self.BMDanBut.titleLabel.font=KNSFONTM(16);
        [self.BMDanBut setTitleColor:RGBA(254, 254, 254, 0.5) forState:UIControlStateNormal];

        self.ContentView.contentOffset=CGPointMake(0, 0);
    } completion:^(BOOL finished) {
        [self.ShoppingDanBut removeTarget:self action:@selector(selectorShoppingDan:) forControlEvents:UIControlEventTouchUpInside];
        [self.BMDanBut addTarget:self action:@selector(selectorBMDan:) forControlEvents:UIControlEventTouchUpInside];
    }];

}


/*******************************************************      协议方法       ******************************************************/


/*******************************************************      代码提取(多是复用代码)       ******************************************************/

-(PersonalShoppingRefundListVC *)ShoppingRefundDanVC
{
    if (!_ShoppingRefundDanVC) {
        _ShoppingRefundDanVC=[[PersonalShoppingRefundListVC alloc] init];
        CGSize size = self.ContentView.bounds.size;
        _ShoppingRefundDanVC.view.frame=CGRectMake(0, 0, size.width, size.height);
        [self.ContentView addSubview:_ShoppingRefundDanVC.view];
        [self addChildViewController:_ShoppingRefundDanVC];
    }
    return _ShoppingRefundDanVC;
}

-(PersonalBMDanVC *)BMDanVC
{
    if (!_BMDanVC) {
        _BMDanVC=[[PersonalBMDanVC alloc]init];
        CGSize size = self.ContentView.bounds.size;
        _BMDanVC.view.frame=CGRectMake(size.width, 0, size.width, size.height);
        [self.ContentView addSubview:_BMDanVC.view];
        [self addChildViewController:_BMDanVC];
    }
    return _BMDanVC;
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


@end
