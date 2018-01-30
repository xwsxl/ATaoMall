//
//  TrainRetuenSuccessViewController.m
//  aTaohMall
//
//  Created by JMSHT on 2017/5/16.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "TrainRetuenSuccessViewController.h"

#import <UIImage+GIF.h>
#import <ImageIO/ImageIO.h>

#import "YLGIFImage.h"
#import "YLImageView.h"

#import "PersonalBMDetailVC.h"

@interface TrainRetuenSuccessViewController ()
{
    
    NSTimer *timer;   //验证码时间
    
    
    NSTimer *timer1;   //验证码时间
    int i;
    int YT;
    UILabel *label3;
}
@end

@implementation TrainRetuenSuccessViewController

//- (void)viewDidAppear:(BOOL)animated{
//    [timer invalidate];
//    timer = nil;
//    
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initNav];
    
    
//    YLImageView* imageView = [[YLImageView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-128)/2, 65+60, 128, 128)];
//    [self.view addSubview:imageView];
//    imageView.image = [YLGIFImage imageNamed:@"123.gif"];
    
    CGRect frame = CGRectMake(0, 65+60, 128, 128);
    
    frame.size = [UIImage imageNamed:@"123(1).gif"].size;
    // 读取gif图片数据
    NSData *gif = [NSData dataWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"123(1)" ofType:@"gif"]];
    // view生成
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-frame.size.width)/2, 100, frame.size.width, frame.size.height)];
    
    webView.backgroundColor = [UIColor orangeColor];
    webView.userInteractionEnabled = NO;//用户不可交互
    [webView loadData:gif MIMEType:@"image/gif" textEncodingName:nil baseURL:nil];
    [self.view addSubview:webView];
    
    
    
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(30, 260, [UIScreen mainScreen].bounds.size.width-60, 20)];
    label1.text = @"退款将在1-7个工作日退回原支付渠道";
    label1.numberOfLines=1;
    label1.textAlignment = NSTextAlignmentCenter;
    label1.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    label1.font  =[UIFont fontWithName:@"PingFang-SC-Regular" size:15];
    [self.view addSubview:label1];
    
//    UILabel *AllIntger = [[UILabel alloc] initWithFrame:CGRectMake(30, 185+128, [UIScreen mainScreen].bounds.size.width-60, 20)];
//    AllIntger.text = @"详细退款进度可进入支付宝查看";
//    AllIntger.numberOfLines=1;
//    AllIntger.textAlignment = NSTextAlignmentCenter;
//    AllIntger.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
//    AllIntger.font  =[UIFont fontWithName:@"PingFang-SC-Regular" size:14];
//    [self.view addSubview:AllIntger];
    
    label3 = [[UILabel alloc] initWithFrame:CGRectMake(60, 320, [UIScreen mainScreen].bounds.size.width-120, 14)];
    label3.text = @"3S";
    label3.numberOfLines=1;
    label3.textAlignment = NSTextAlignmentCenter;
    label3.textColor = [UIColor colorWithRed:73/255.0 green:141/255.0 blue:243/255.0 alpha:1.0];
    label3.font  =[UIFont fontWithName:@"PingFang-SC-Medium" size:18];
    [self.view addSubview:label3];
    
    i = 2;
    
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(strTimer:) userInfo:nil repeats:YES];
    
//    UIButton *Pay = [UIButton buttonWithType:UIButtonTypeCustom];
//    Pay.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width-100)/2, 185+128+50+24, 100, 15);
//    [Pay setTitle:@"进入支付宝" forState:0];
//    [Pay setTitleColor:[UIColor colorWithRed:73/255.0 green:141/255.0 blue:243/255.0 alpha:1.0] forState:0];
//    [Pay addTarget:self action:@selector(PayBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:Pay];
    
    
    
}


- (void)strTimer:(NSTimer *)time{
    
    label3.text =[NSString stringWithFormat:@"%dS",i];
    
    NSLog(@"===%@",[NSString stringWithFormat:@"%dS",i]);
    
    i --;
    
    //    YT--;
    
    if (i == -1) {
        [timer invalidate];
        timer = nil;
        
        if ([self.Train isEqualToString:@"100"]) {
            
            
            PersonalBMDetailVC *vc = [[PersonalBMDetailVC alloc] initWithOrderBatchid:self.orderno AndOrderType:@"5"];
            NSNotification *noti=[[NSNotification alloc] initWithName:JMSHTBMLISTReloadData object:nil userInfo:@{@"status":@"3"}];
            [[NSNotificationCenter defaultCenter] postNotification:noti];

            self.navigationController.viewControllers=@[self.navigationController.viewControllers.firstObject,self.navigationController.viewControllers[1],vc];

        }else{

            PersonalBMDetailVC *vc = [[PersonalBMDetailVC alloc] initWithOrderBatchid:self.orderno AndOrderType:@"4"];

            NSNotification *noti=[[NSNotification alloc] initWithName:JMSHTBMLISTReloadData object:nil userInfo:@{@"status":@"3"}];
            [[NSNotificationCenter defaultCenter] postNotification:noti];
           // [self.navigationController pushViewController:vc animated:NO];
            self.navigationController.viewControllers=@[self.navigationController.viewControllers.firstObject,self.navigationController.viewControllers[1],vc];

        }

        
    }
    
    
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
    
    label.text = @"退款中";
    
    label.textColor = [UIColor blackColor];
    
    label.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:19];
    
    label.textAlignment = NSTextAlignmentCenter;
    
    [titleView addSubview:label];
    
}

-(void)PayBtnClick
{
    
    
}
-(void)QurtBtnClick
{
    [self.navigationController popViewControllerAnimated:NO];
    
}


-(NSString *)Train
{
    if (!_Train) {
        _Train=@"";
    }
    return _Train;
}

@end
