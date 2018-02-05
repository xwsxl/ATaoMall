//
//  JDSelectAnctionViewController.m
//  aTaohMall
//
//  Created by JMSHT on 2017/4/24.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "JDSelectAnctionViewController.h"

#import "JD_ScreeningViewController.h"
#define offset [UIScreen mainScreen].bounds.size.width-50

@interface JDSelectAnctionViewController ()<AF_ScreeningViewControllerDelegate>
{
    UIWindow *window;
    JD_ScreeningViewController * rvc;
}
@end

@implementation JDSelectAnctionViewController

-(void)dismissWindow{
    //设置视图偏移
    [UIView animateWithDuration:.3 animations:^{
        CGRect rect = window.frame;
        rect.origin.x += (offset);
        window.frame = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height);
    } completion:^(BOOL finished) {
        window.hidden = YES;
        window = nil;
        [self dismissViewControllerAnimated:NO completion:nil];
    }];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /** 点击视图关闭window */
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickWindow)];
    [self.view addGestureRecognizer:tap];
    
    /** 加载window */
    window = [[UIWindow alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width, 0, offset, [UIScreen mainScreen].bounds.size.height)];
    //window.windowLevel =  UIWindowLevelStatusBar + 1;//此设置遮蔽状态栏
    window.hidden = NO;
    rvc = [[JD_ScreeningViewController alloc] init];
    rvc.width = offset;
    rvc.delegate = self;
    window.rootViewController = rvc;
    
    //设置视图偏移
    [UIView animateWithDuration:.3 animations:^{
        CGRect rect = window.frame;
        rect.origin.x -= (offset);
        window.frame = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height);
    }];
    
    
}

-(void)clickWindow
{
    [rvc SureBtnClick];
}

#pragma mark - AF_ScreeningViewController 代理

- (void)determineButtonTouchEvent
{
    [self dismissWindow];
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
