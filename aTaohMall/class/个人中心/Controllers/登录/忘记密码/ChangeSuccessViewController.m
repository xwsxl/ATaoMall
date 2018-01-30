//
//  ChangeSuccessViewController.m
//  aTaohMall
//
//  Created by JMSHT on 16/5/19.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import "ChangeSuccessViewController.h"

#import "NewLoginViewController.h"
#import "ATHLoginViewController.h"
@interface ChangeSuccessViewController ()
{
    
    NSTimer *timer;   //验证码时间
    
    int i;
}
@end

@implementation ChangeSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    i=2;
    
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(strTimer:) userInfo:nil repeats:YES];
    
    NSLog(@"===self.userName===%@",self.userName);
    NSLog(@"===self.userPassWord===%@",self.userPassWord);
}
//登录
//- (IBAction)loginBtnClick:(UIButton *)sender {
//    
//    NewLoginViewController *loginVC=[[NewLoginViewController alloc] init];
//    
//    loginVC.backString=@"100";
//    
//    [self.navigationController pushViewController:loginVC animated:YES];
//    
//}

- (void)strTimer:(NSTimer *)time{
    
    i --;
    
    if (i == 0) {
        [timer invalidate];
        timer = nil;
        
        
//        NewLoginViewController *loginVC=[[NewLoginViewController alloc] init];
        ATHLoginViewController *loginVC=[[ATHLoginViewController alloc] init];
        loginVC.backString=@"100";
        
        loginVC.userName=self.userName;
        loginVC.userPassWord=self.userPassWord;
        
        [self.navigationController pushViewController:loginVC animated:NO];
    }
    
    
}

@end
