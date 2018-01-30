//
//  TrainKidTextViewController.m
//  aTaohMall
//
//  Created by JMSHT on 2017/7/17.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "TrainKidTextViewController.h"

@interface TrainKidTextViewController ()

@end

@implementation TrainKidTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initNav];
    
    [self initOtherView];
    
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
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(50, 25+KSafeTopHeight, [UIScreen mainScreen].bounds.size.width-100, 30)];
    
    label.text = @"儿童票购票说明";
    
    label.textColor = [UIColor blackColor];
    
    label.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:19];
    
    label.textAlignment = NSTextAlignmentCenter;
    
    [titleView addSubview:label];
    
}

-(void)initOtherView
{
    
   
    UILabel *NameLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 75+KSafeTopHeight, [UIScreen mainScreen].bounds.size.width-30, 12)];
    NameLabel.text = @"1.儿童不能单独乘坐火车，至少需要一名成人陪同。";
    NameLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    NameLabel.font  =[UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    NameLabel.numberOfLines = 0;
    [self.view addSubview:NameLabel];
    
    
    UILabel *NameLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(15, 100+KSafeTopHeight, [UIScreen mainScreen].bounds.size.width-30, 80)];
    NameLabel1.text = @"2.每名成年乘客可免费携1名身高1.2米以下儿童（无需购票）；超过1名时，其他儿童请购买儿童票。身高1.2米以下的免票儿童需和同行成人共用一个席位，若想要单独席位，须购买儿童票。";
    NameLabel1.numberOfLines = 0;
    NameLabel1.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    NameLabel1.font  =[UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    [self.view addSubview:NameLabel1];
    
    
    UILabel *NameLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(15, 180+KSafeTopHeight, [UIScreen mainScreen].bounds.size.width-30, 60)];
    NameLabel2.text = @"3.儿童身高为1.2～1.5米的，请购买儿童票（使用同行成人证件购买的儿童票，请提前用同行成人证件换取纸质车票后乘车）。";
    NameLabel2.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    NameLabel2.font  =[UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    NameLabel2.numberOfLines = 0;
    [self.view addSubview:NameLabel2];
    
    UILabel *NameLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(15, 240+KSafeTopHeight, [UIScreen mainScreen].bounds.size.width-30, 40)];
    NameLabel3.text = @"4.超过1.5米的，请购买成人票，若无有效证件请到车站窗口购票。";
    NameLabel3.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    NameLabel3.font  =[UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    NameLabel3.numberOfLines = 0;
    [self.view addSubview:NameLabel3];
    
    UILabel *NameLabel4 = [[UILabel alloc] initWithFrame:CGRectMake(15, 280+KSafeTopHeight, [UIScreen mainScreen].bounds.size.width-30, 50)];
    NameLabel4.text = @"备注：请根据儿童实际身高购票，本平台不承担因儿童身高与所购车票不符导致无法进站等责任。";
    NameLabel4.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    NameLabel4.font  =[UIFont fontWithName:@"PingFang-SC-Regular" size:12];
    NameLabel4.numberOfLines = 0;
    [self.view addSubview:NameLabel4];
    
    

}

-(void)QurtBtnClick
{
    [self.navigationController popViewControllerAnimated:NO];
    
}

@end
