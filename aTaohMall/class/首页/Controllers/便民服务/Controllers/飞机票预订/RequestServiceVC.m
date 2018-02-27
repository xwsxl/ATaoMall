//
//  RequestServiceVC.m
//  aTaohMall
//
//  Created by DingDing on 2017/8/28.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "RequestServiceVC.h"

@interface RequestServiceVC ()
{
    UIWebView *webView;
    NSString *URLStr;
    NSString *titleStr;
    
}
@end

@implementation RequestServiceVC

-(instancetype)initWithURLStr:(NSString *)Str
{
    if (self=[super init]) {
        URLStr =Str;
    }
    return self;
}
-(instancetype)initWithURLStr:(NSString *)Str withTitle:(NSString *)title
{
    if (self=[super init]) {
        URLStr =Str;
        titleStr=title;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNav];
    // Do any additional setup after loading the view.
    webView =[[UIWebView alloc]initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight, kScreen_Width, kScreen_Height-KSafeAreaTopNaviHeight)];
    if (!URLStr) {
        URLStr=@"";
    }

    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",@"http://192.168.1.26:8085/",URLStr]]]];
    [self.view addSubview:webView];
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
    if (titleStr) {
        label.text=titleStr;
    }else
    {
    
        label.text = @"特殊旅客购票须知";
    
    }
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
