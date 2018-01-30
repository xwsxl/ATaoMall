//
//  GoodsDetailViewController.m
//  aTaohMall
//
//  Created by JMSHT on 16/5/14.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import "GoodsDetailViewController.h"

#import "TuWenViewController.h"//图文详情

#import "GotoShopLookViewController.h"//进店看看

#import "MerchantDetailViewController.h"
@interface GoodsDetailViewController ()

@end

@implementation GoodsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.frame=[UIScreen mainScreen].bounds;
    
}

//图文详情
- (IBAction)TuWenBtnClick:(UIButton *)sender {
    
    TuWenViewController *tuVC=[[TuWenViewController alloc] init];
    
    [self.navigationController pushViewController:tuVC animated:YES];
}

//配送方式
- (IBAction)SendWayBtnClick:(UIButton *)sender {
    
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 280, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-280)];
    
//    [self.view addSubview:view];
    
    UILabel *titleLabel=[[UILabel alloc] init];
    titleLabel.frame=CGRectMake(20, 20, [UIScreen mainScreen].bounds.size.width-40, 20);
    titleLabel.text=@"配送方式";
    titleLabel.textAlignment=NSTextAlignmentCenter;
    [view addSubview:titleLabel];
    
    UILabel *label1=[[UILabel alloc] initWithFrame:CGRectMake(10, 50, 60, 20)];
    label1.text=@"快递邮寄";
    
    UIButton *button1=[UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame=CGRectMake([UIScreen mainScreen].bounds.size.width-40, 50, 30, 30);
    [button1 setBackgroundImage:[UIImage imageNamed:@"无勾选状态@2x"] forState:0];
    [button1 setBackgroundImage:[UIImage imageNamed:@"勾选状态@2x"] forState:1];
    
    UIImageView *imgView1=[[UIImageView alloc] initWithFrame:CGRectMake(10, 85, [UIScreen mainScreen].bounds.size.width-20, 1)];
    imgView1.image=[UIImage imageNamed:@"分割线配送方式@2x"];
    
    [view addSubview:label1];
    [view addSubview:button1];
    [view addSubview:imgView1];
    
    UILabel *label2=[[UILabel alloc] initWithFrame:CGRectMake(10, 126, 60, 20)];
    label2.text=@"包邮";
    
    UIButton *button2=[UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame=CGRectMake([UIScreen mainScreen].bounds.size.width-40, 126, 30, 30);
    [button2 setBackgroundImage:[UIImage imageNamed:@"无勾选状态@2x"] forState:0];
    [button2 setBackgroundImage:[UIImage imageNamed:@"勾选状态@2x"] forState:1];
    
    UIImageView *imgView2=[[UIImageView alloc] initWithFrame:CGRectMake(10, 131, [UIScreen mainScreen].bounds.size.width-20, 1)];
    imgView2.image=[UIImage imageNamed:@"分割线配送方式@2x"];
    
    [view addSubview:label2];
    [view addSubview:button2];
    [view addSubview:imgView2];
    
    
    UILabel *label3=[[UILabel alloc] initWithFrame:CGRectMake(10, 162, 60, 20)];
    label3.text=@"线下自取";
    
    UIButton *button3=[UIButton buttonWithType:UIButtonTypeCustom];
    button3.frame=CGRectMake([UIScreen mainScreen].bounds.size.width-40, 162, 30, 30);
    [button3 setBackgroundImage:[UIImage imageNamed:@"无勾选状态@2x"] forState:0];
    [button3 setBackgroundImage:[UIImage imageNamed:@"勾选状态@2x"] forState:1];
    
    UIImageView *imgView3=[[UIImageView alloc] initWithFrame:CGRectMake(10, 167, [UIScreen mainScreen].bounds.size.width-20, 1)];
    imgView3.image=[UIImage imageNamed:@"分割线配送方式@2x"];
    
    [view addSubview:label3];
    [view addSubview:button3];
    [view addSubview:imgView3];
    
    
    //关闭
    UIButton *closeButton=[UIButton buttonWithType:UIButtonTypeCustom];
    
    closeButton.frame=CGRectMake(0, view.bounds.size.height-50, view.bounds.size.width, 50);
    
    [closeButton setTitle:@"关闭" forState:0];
    closeButton.titleLabel.font=[UIFont systemFontOfSize:22];
    [closeButton setTitleColor:[UIColor whiteColor] forState:0];
    
    [view addSubview:closeButton];
}
//进店看看
- (IBAction)gotoShopLookBtnClick:(UIButton *)sender {
    
    GotoShopLookViewController *lookVC=[[GotoShopLookViewController alloc] init];
    
    [self.navigationController pushViewController:lookVC animated:YES];
    
    self.navigationController.navigationBar.hidden=YES;
}

//返回
- (IBAction)backBtnClick:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
//    self.navigationController.navigationBar.hidden=NO;
    
    self.tabBarController.tabBar.hidden=NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
