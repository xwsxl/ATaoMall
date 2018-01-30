//
//  NewSaoYiSaoViewController.m
//  aTaohMall
//
//  Created by JMSHT on 2017/4/10.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "NewSaoYiSaoViewController.h"

#import "QRCodeGenerator.h"
#import "NewHomeViewController.h"

#import "MyRecordViewController.h"

@interface NewSaoYiSaoViewController ()
{
    UIButton *backBtn;//返回键
    UILabel *payLable;
    UIButton *billBtn;
    
    UIButton *barCodeBtn;
    UIButton *QRCodeBtn;
    
    //倒计时
    int secondCountDown;
    NSTimer *countDownTimer;
    
    UIView *paySuccessView;
}
@end

@implementation NewSaoYiSaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.frame=[UIScreen mainScreen].bounds;
    
    [self initNav];
    
//    [self codeGenrate];
    
    self.tabBarController.tabBar.hidden=YES;
    
    
}


-(void)initNav
{
    
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:255/255.0 green:52/255.0 blue:90/255.0 alpha:1.0].CGColor];
    gradientLayer.locations = @[@0.0, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1.0);
    gradientLayer.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [self.view.layer addSublayer:gradientLayer];
    
    
    UIView *navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, KSafeAreaTopNaviHeight)];
    
    [self.view addSubview:navView];
    
    
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(100, 25+KSafeTopHeight, [UIScreen mainScreen].bounds.size.width-200, 30)];
    
    title.text = @"扫一扫支付";
    
    title.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:19];
    
    title.textAlignment = NSTextAlignmentCenter;
    
    title.textColor = [UIColor whiteColor];
    
    [navView addSubview:title];
    
    
    UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
    back.frame = CGRectMake(10, 25+KSafeTopHeight, 30, 30);
//    [back setBackgroundImage:[UIImage imageNamed:@"iconfont-fanhui2new"] forState:0];
    [back setImage:[UIImage imageNamed:@"iconfont-fanhui2new"] forState:0];
    
    [back addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:back];
    
    
    UIButton *record = [UIButton buttonWithType:UIButtonTypeCustom];
    record.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-100, 25+KSafeTopHeight, 100, 30);
    [record setTitle:@"支付记录" forState:0];
    [record setTitleColor:[UIColor whiteColor] forState:0];
    record.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15];
    [record addTarget:self action:@selector(RecordBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:record];
    
    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(27, 96+KSafeTopHeight, [UIScreen mainScreen].bounds.size.width-54, [UIScreen mainScreen].bounds.size.height-192-KSafeAreaBottomHeight)];
    line.image = [UIImage imageNamed:@"发光框"];
    
    [self.view addSubview:line];
    
    self.saosaoView = [[UIView alloc] initWithFrame:CGRectMake(30, 100+KSafeTopHeight, [UIScreen mainScreen].bounds.size.width-60, [UIScreen mainScreen].bounds.size.height-200-KSafeAreaBottomHeight)];
    
//    self.saosaoView.layer.shadowColor = [UIColor whiteColor].CGColor;//shadowColor阴影颜色
//    self.saosaoView.layer.shadowOffset = CGSizeMake(4,4);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
//    self.saosaoView.layer.shadowOpacity = 1.0;//阴影透明度，默认0
//    self.saosaoView.layer.shadowRadius = 4;//阴影半径，默认3
    
    
    self.saosaoView.backgroundColor = [UIColor whiteColor];
    
    self.saosaoView.layer.cornerRadius  = 2;
    self.saosaoView.layer.masksToBounds = YES;
    
    [self.view addSubview:self.saosaoView];
    
    
    
    
    
    self.barImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 100+KSafeTopHeight, [UIScreen mainScreen].bounds.size.width-60-20, 60)];
    
    self.QRImgView = [[UIImageView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-60-20-200)/2, 200, 200, 200)];
    
//    [self.saosaoView addSubview:self.barImgView];
    
    NSString *codeUserID = [NSString stringWithFormat:@"%@",self.userid];
    //计算支付码头两个数字
    NSUInteger countUserID = codeUserID.length;
    NSInteger headCode = 20 - countUserID;
    NSString *headCodelen = [NSString stringWithFormat:@"%ld",headCode];
    NSInteger countHeadCode = headCodelen.length;
    NSInteger secondCode = headCode - countHeadCode;
    
    NSString *halfCode = [NSString stringWithFormat:@"%ld%@",(long)secondCode,codeUserID];
    
    while(halfCode.length <20) {
        int radomDig = arc4random() % 10;
        halfCode = [NSString stringWithFormat:@"%@%d",halfCode,radomDig];
    }
    
    
//    NSLog(@"%@",halfCode);
//    
//    
//    self.TwoNumbrerLabel.text=halfCode;
    
    //一维码
    ZXMultiFormatWriter *writer = [ZXMultiFormatWriter writer];
    ZXBitMatrix *result = [writer encode:halfCode format:kBarcodeFormatCode128 width:100 height:50 error:nil];
    CGImageRef image = [[ZXImage imageWithMatrix:result] cgimage];
    UIImage *barCodeImg = [UIImage imageWithCGImage:image];
    self.barImgView.image = barCodeImg;
    
    
    //二维码
    UIImage *QRImage = [[UIImage alloc]init];
    QRImage = [QRCodeGenerator qrImageForString:halfCode imageSize:self.QRImgView.bounds.size.width];
    [self.QRImgView setImage:QRImage];
    
    
    [self.saosaoView addSubview:self.QRImgView];
    [self.saosaoView addSubview:self.barImgView];
    
    
    
    
}

-(void)backBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
    
    self.tabBarController.tabBar.hidden=NO;
}
-(void)RecordBtnClick
{
    MyRecordViewController *myVC=[[MyRecordViewController alloc] init];
    
    myVC.sigens1=self.sigen;
    
    [self.navigationController pushViewController:myVC animated:YES];
    
}
@end
