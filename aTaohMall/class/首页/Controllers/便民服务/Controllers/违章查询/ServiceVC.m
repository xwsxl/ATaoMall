//
//  ServiceVC.m
//  aTaohMall
//
//  Created by Zhending Shi on 2017/8/4.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "ServiceVC.h"

@interface ServiceVC ()
{
    UIWebView *webView;
    UILabel *Titlelabel;
}

@end

@implementation ServiceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNav];
    webView=[[UIWebView alloc]initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight, kScreen_Width, kScreen_Height-KSafeAreaTopNaviHeight)];
    NSString *urlString=[NSString stringWithFormat:@"%@illegalServiceDocJSP_mob.shtml",URL_Str];
    [webView loadRequest:[NSURLRequest requestWithURL:KNSURL(urlString)]];
    
    [self.view addSubview:webView];
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
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
    
    //    [Qurt setBackgroundImage:[UIImage imageNamed:@"iconfont-fanhui2yt"] forState:0];
    
    [Qurt setImage:[UIImage imageNamed:@"iconfont-fanhui2yt"] forState:0];
    
    [Qurt addTarget:self action:@selector(QurtBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [titleView addSubview:Qurt];
    
    //创建搜索
    
    Titlelabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 25+KSafeTopHeight, [UIScreen mainScreen].bounds.size.width-200, 30)];
    
    Titlelabel.text = @"服务说明";
    
    Titlelabel.textColor = [UIColor blackColor];
    
    Titlelabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:19];
    
    Titlelabel.textAlignment = NSTextAlignmentCenter;
    
    [titleView addSubview:Titlelabel];
    
}
-(void)QurtBtnClick{
    
    [self.navigationController popViewControllerAnimated:YES];
    // self.tabBarController.tabBar.hidden=YES;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
