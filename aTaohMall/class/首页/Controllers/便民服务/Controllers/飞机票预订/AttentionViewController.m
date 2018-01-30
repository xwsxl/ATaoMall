//
//  AttentionViewController.m
//  aTaohMall
//
//  Created by JMSHT on 2017/5/31.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "AttentionViewController.h"

@interface AttentionViewController ()
{
    
    UIScrollView *_titleScroll;
    UIWebView *webView;
    
}
@end

@implementation AttentionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initNav];
    webView =[[UIWebView alloc]initWithFrame:CGRectMake(0, 65, kScreen_Width, kScreen_Height-65)];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",URL_Str,@"getplanespecialpg_wap.shtml?app"]]]];
    [self.view addSubview:webView];
//    self.view.frame=[UIScreen mainScreen].bounds;
//    
//    [self initNav];
//    
//    _titleScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 65, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-65)];
//    
//    _titleScroll.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
//    //Button的高
//    
//    _titleScroll.showsVerticalScrollIndicator = NO;
//    
//    [self.view addSubview:_titleScroll];
    
    
    
    
    
//    UILabel *NumberLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, [UIScreen mainScreen].bounds.size.width-30, 20)];
//    NumberLabel1.text = @"特殊旅客购票须知";
//    NumberLabel1.numberOfLines = 0;
//    NumberLabel1.textAlignment = NSTextAlignmentCenter;
//    NumberLabel1.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
//    NumberLabel1.font = [UIFont fontWithName:@"PingFang-SC-Light" size:14];
//    [_titleScroll addSubview:NumberLabel1];
//    
//    
//    UILabel *NumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 40, [UIScreen mainScreen].bounds.size.width-30, 300)];
//    NumberLabel.text = @"   *婴儿票（14天-2岁），暂不提供婴儿票购买服务，请直接前往机场柜台购买。但每个航班可守婴儿票数量有限，如有需请及时联系航空公司购买。 \n   *儿童乘机需由18岁以上成人携带，1名成人最多可携带2名儿童，单独购买儿童票请到航空公司柜台购买。 每个航班儿童票数量有限，请您及时办理。\n  *儿童(2岁-12岁，按乘机当天的实际年龄计算)2岁(含)-12岁(不含)请购买儿童票，票价为全价票的50%，不收取机场建设费，燃油收取成人票价的50%，购买时需要同时购买成人票，一个成人最 多携带两名儿童。 \n   *2岁(含)-16岁(不含)儿童无身份证、证件类型可选择户口本，证件号码栏请填写儿童在户口本上的身份证件号码。 12（含）-18岁（不含）购票价格已成人票一致。 \n   *重要旅客(VIP)、婴儿、无成人陪伴儿童、孕妇、病残旅客、革命伤残军人和因公致残人民警察等待殊旅客购票，请提前向航空公司申 请并妥善安排行程。";
//    NumberLabel.numberOfLines = 0;
//    NumberLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
//    NumberLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
//    
//    
//    NSString *stringForColor = @"关于民航旅客携带“充电宝”乘机规定的公告";
//    NSString *stringForColor1 = @"退票手续费：";
//    
//    // 创建对象.
//    NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:NumberLabel.text];
//    //
//    NSRange range = [NumberLabel.text rangeOfString:stringForColor];
//    NSRange range1 = [NumberLabel.text rangeOfString:stringForColor1];
//    
//    [mAttStri addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:14] range:range];
//    [mAttStri addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:14] range:range1];
//    
//    
//    NumberLabel.attributedText=mAttStri;
//    
//    [_titleScroll addSubview:NumberLabel];
    
    
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
    
    label.text = @"特殊旅客购票须知";
    
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
