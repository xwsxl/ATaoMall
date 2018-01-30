//
//  SettingPassWordViewController.m
//  aTaohMall
//
//  Created by JMSHT on 16/5/18.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import "SettingPassWordViewController.h"

#import "PassWordSettingViewController.h"

#import "NewLoginViewController.h"
#import "PersonaViewController.h"

#import "UserMessageManager.h"

#import "SearchManager.h"

#import "MerchantManager.h"

#import "CountMessageViewController.h"

@interface SettingPassWordViewController ()<UIActionSheetDelegate>
{
    UIAlertController *alertCon;
}
@end

@implementation SettingPassWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
}

//修改密码
- (IBAction)ChangePassWord:(UIButton *)sender {
    PassWordSettingViewController *vc=[[PassWordSettingViewController alloc] init];
    [self.navigationController pushViewController:vc animated:NO];
    self.navigationController.navigationBar.hidden=YES;
}
//退出
- (IBAction)QuitBtnClick:(UIButton *)sender {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"确认要退出登录吗？" message:nil preferredStyle:0];
    
    UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"确认" style:(UIAlertActionStyleDestructive) handler:^(UIAlertAction *action) {
        
        
        

        //发送通知购物，不显示件数
        
        NSNotification *notification = [[NSNotification alloc] initWithName:@"QuitLoginCartShowNoNumber" object:nil userInfo:nil];
        
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        
        //发送通知，购物车刷新数据
        
        NSNotification *notification1 = [[NSNotification alloc] initWithName:@"QuitLoginCartReloadData" object:nil userInfo:nil];
        
        [[NSNotificationCenter defaultCenter] postNotification:notification1];
        
        //通知AppDelegate不显示购物车件数
        NSNotification *notification2 = [[NSNotification alloc] initWithName:@"AppDelegateShowNumber" object:nil userInfo:nil];
    
        [[NSNotificationCenter defaultCenter] postNotification:notification2];
        

        
        for (UIViewController *controller in self.navigationController.viewControllers) {
            
            if ([controller isKindOfClass:[PersonaViewController class]]) {
                
                if (_delegate && [_delegate respondsToSelector:@selector(outStatus)]) {
                    
                  //  [_delegate outStatus];
                }
                
                
                self.tabBarController.tabBar.hidden=NO;
                
                [self.navigationController popToViewController:controller animated:YES];
            }
        }
        
        
        
        [SearchManager removeAllArray];
        
        [MerchantManager removeAllArray];
        
        [UserMessageManager SaveShenJi:@"NO"];
        
        //清空缓存数据
        [UserMessageManager DeleteAppDelegateCartNumber];
        
        [kUserDefaults removeObjectForKey:@"sigen"];
        [KNotificationCenter postNotificationName:JMSHTLogOutSuccessNoti object:nil];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction *action)
                                   {
                                       //这里可以不写代码
                                   }];
    [self presentViewController:alertController animated:YES completion:nil];
    
    
    [alertController addAction:cancelAction];
    [alertController addAction:photoAction];
    
//    [self showActionSheet2];
}
//账户信息
- (IBAction)CheckPersonInfo:(UIButton *)sender {
    CountMessageViewController *VC=[[CountMessageViewController alloc]init];
    VC.delegate=self.navigationController.viewControllers.firstObject;
    [self.navigationController pushViewController:VC
                                         animated:NO];
    
    self.tabBarController.tabBar.hidden=YES;
    
    NSLog(@"hahahahaha");
}   

//性别
-(void)showActionSheet2
{
    UIActionSheet *sheet=[[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"确定要退出登录吗？", @"确认",nil];
    
    [sheet showInView:self.view];
}
#pragma mark - actionSheet代理
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
        NSLog(@"0");
        
        
        
    }else if (buttonIndex==1){
        NSLog(@"1");
        
    }
}
//更改颜色
- (void)willPresentActionSheet:(UIActionSheet *)actionSheet
{
    
}
//返回
- (IBAction)backBtnClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
    self.tabBarController.tabBar.hidden=NO;
}


@end
