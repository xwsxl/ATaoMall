//
//  TrainPriceDetailViewController.m
//  aTaohMall
//
//  Created by JMSHT on 2017/7/18.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "TrainPriceDetailViewController.h"

@interface TrainPriceDetailViewController ()

@end

@implementation TrainPriceDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1.0];
    
    
    [self initNav];
    
    [self initView];
    
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
    
    label.text = @"价格明细";
    
    label.textColor = [UIColor blackColor];
    
    label.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:19];
    
    label.textAlignment = NSTextAlignmentCenter;
    
    [titleView addSubview:label];
    
}

-(void)initView{
    
    UILabel *TopLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 70+KSafeTopHeight, [UIScreen mainScreen].bounds.size.width-30, 12)];
    TopLabel.text = @"*最终退还金额以铁路部门实际退还为准。";
    TopLabel.numberOfLines=1;
    TopLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    TopLabel.font  =[UIFont fontWithName:@"PingFang-SC-Regular" size:12];
    [self.view addSubview:TopLabel];
    
    NSString *stringForColor = @"*";
    
    // 创建对象.
    NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:TopLabel.text];
    //
    NSRange range = [TopLabel.text rangeOfString:stringForColor];
    
    [mAttStri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0] range:range];
    TopLabel.attributedText=mAttStri;
    
    UIView *MoneyView = [[UIView alloc] initWithFrame:CGRectMake(0, 87+KSafeTopHeight, [UIScreen mainScreen].bounds.size.width, 50)];
    MoneyView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:MoneyView];
    
    UILabel *IdLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, (50-14)/2, 100, 14)];
    IdLabel.text = @"支付价";
    IdLabel.numberOfLines=1;
    IdLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    IdLabel.font  =[UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    [MoneyView addSubview:IdLabel];
    
    UILabel *Price = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-220, (50-14)/2, 200, 14)];
    Price.text = self.Price;
    Price.numberOfLines=1;
    Price.textAlignment = NSTextAlignmentRight;
    Price.textColor = [UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
    Price.font  =[UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    [MoneyView addSubview:Price];
    
    UIImageView *line1 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 49, [UIScreen mainScreen].bounds.size.width-15, 1)];
    line1.image = [UIImage imageNamed:@"分割线-拷贝"];
    [MoneyView addSubview:line1];
    
    NSString *stringForColor1 = @"￥";
    
    // 创建对象.
    NSMutableAttributedString *mAttStri1 = [[NSMutableAttributedString alloc] initWithString:Price.text];
    //
    NSRange range1 = [Price.text rangeOfString:stringForColor1];
    
    [mAttStri1 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:15] range:range1];
    Price.attributedText=mAttStri1;
    
    
    UIView *IntgerView = [[UIView alloc] initWithFrame:CGRectMake(0, 87+50+KSafeTopHeight, [UIScreen mainScreen].bounds.size.width, 50)];
    IntgerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:IntgerView];
    
    UILabel *IntgerLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, (50-14)/2, 100, 14)];
    IntgerLabel.text = @"实际票价";
    IntgerLabel.numberOfLines=1;
    IntgerLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    IntgerLabel.font  =[UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    [IntgerView addSubview:IntgerLabel];
    
    UILabel *Intger = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-220, (50-14)/2, 200, 14)];
    Intger.text = [NSString stringWithFormat:@"￥%@",self.order_cash];
    Intger.numberOfLines=1;
    Intger.textAlignment = NSTextAlignmentRight;
    Intger.textColor = [UIColor colorWithRed:255/255.0 green:92/255.0 blue:94/255.0 alpha:1.0];
    Intger.font  =[UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    [IntgerView addSubview:Intger];
    
    
    UIImageView *line2 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 49, [UIScreen mainScreen].bounds.size.width-15, 1)];
    line2.image = [UIImage imageNamed:@"分割线-拷贝"];
    [IntgerView addSubview:line2];
    
    
    UIView *OtherView = [[UIView alloc] initWithFrame:CGRectMake(0, 87+100+KSafeTopHeight, [UIScreen mainScreen].bounds.size.width, 50)];
    OtherView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:OtherView];
    
    
    UILabel *Label1 = [[UILabel alloc] initWithFrame:CGRectMake(15, 19, 100, 14)];
    Label1.text = @"差额退款";
    Label1.numberOfLines=1;
    Label1.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    Label1.font  =[UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    [OtherView addSubview:Label1];
    
    UILabel *AllPrice = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-225, 19, 210, 14)];
    
    if ([self.bsr_type isEqualToString:@"0"]) {
        
        AllPrice.text = [NSString stringWithFormat:@"￥%@+%@积分",self.refund_amount,self.integral_amount];
    }else{
        
        AllPrice.text = [NSString stringWithFormat:@"￥0.00+0.00积分"];
    }
    
    AllPrice.numberOfLines=1;
    AllPrice.textAlignment = NSTextAlignmentRight;
    AllPrice.textColor = [UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
    AllPrice.font  =[UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    [OtherView addSubview:AllPrice];
    
    NSString *stringForColor2 = @"￥";
    
    // 创建对象.
    NSMutableAttributedString *mAttStri2 = [[NSMutableAttributedString alloc] initWithString:AllPrice.text];
    //
    NSRange range2 = [AllPrice.text rangeOfString:stringForColor2];
    
    [mAttStri2 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:15] range:range2];
    AllPrice.attributedText=mAttStri2;
    
    UIImageView *line3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 49, [UIScreen mainScreen].bounds.size.width, 1)];
    line3.image = [UIImage imageNamed:@"分割线-拷贝"];
    [OtherView addSubview:line3];
    
}

-(void)QurtBtnClick
{
    [self.navigationController popViewControllerAnimated:NO];
    
}

@end
