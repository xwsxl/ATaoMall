//
//  TrainTuiKuanViewController.m
//  aTaohMall
//
//  Created by JMSHT on 2017/5/16.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "TrainTuiKuanViewController.h"

@interface TrainTuiKuanViewController ()
{
    
    UIScrollView *_titleScroll;
}
@end

@implementation TrainTuiKuanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.frame=[UIScreen mainScreen].bounds;
    
    [self initNav];
    
    _titleScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-KSafeAreaTopNaviHeight)];
    
    _titleScroll.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height+100);
    //Button的高
    
    _titleScroll.showsVerticalScrollIndicator = NO;
    
    [self.view addSubview:_titleScroll];
    
    
    
    
    
    UILabel *NumberLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, [UIScreen mainScreen].bounds.size.width-30, 20)];
    NumberLabel1.text = @"退票须知";
    NumberLabel1.numberOfLines = 0;
    NumberLabel1.textAlignment = NSTextAlignmentCenter;
    NumberLabel1.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    NumberLabel1.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    [_titleScroll addSubview:NumberLabel1];
    
    
    UILabel *NumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 40, [UIScreen mainScreen].bounds.size.width-30, 400)];
    NumberLabel.text = @"退票时间：\n\n在线退票时间：06：00-22：55（其他时间须去火车窗口办理）。\n\n发车前35分钟且未取票可在“”全部订单“”页面中申请退款。\n退票手续费：\n开车前15天（不含）以上退票的，不收取退票费；\n开车时间前48小时以上的按票价5%；24小时以上、不足48小时的按票价10%计；\n不足24小时的按票价20%计。\n开车前48小时～15天期间内，改签或变更到站至距开车15天以上的其他列车，又在距开车15天前退票的，仍核收5%的退票费。\n上述计算的尾数以5角为单位，尾数小于2.5角的舍去、2.5角以上且小于7.5角的计为5角、7.5角以上的进为1元。\n退票费最低按2元计收。\n改签或变更到站后的车票乘车日期在春运期间的，退票时一律按开车时间前不足24小时标准核收退票费。\n网上退票，退款将在1-7个工作日退回原支付渠道；\n车站窗口退票将在1-15个工作日退回原支付渠道。";
    NumberLabel.numberOfLines = 0;
    NumberLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    NumberLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
    
    
    NSString *stringForColor = @"退票时间：";
    NSString *stringForColor1 = @"退票手续费：";

    // 创建对象.
    NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:NumberLabel.text];
    //
    NSRange range = [NumberLabel.text rangeOfString:stringForColor];
    NSRange range1 = [NumberLabel.text rangeOfString:stringForColor1];
    
    [mAttStri addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:14] range:range];
    [mAttStri addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:14] range:range1];
    
    
    NumberLabel.attributedText=mAttStri;
    
    [_titleScroll addSubview:NumberLabel];
    
    
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
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 25+KSafeTopHeight, [UIScreen mainScreen].bounds.size.width-200, 30)];
    
    label.text = @"退票须知";
    
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
