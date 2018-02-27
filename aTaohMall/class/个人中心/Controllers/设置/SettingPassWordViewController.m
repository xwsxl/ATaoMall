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

#import "YTAddressManngerViewController.h"

#import "XLPersonalAboutUsVC.h"

#import "XLPersonalHopeHandVC.h"

#import "XLPersonalAccountSuggestVC.h"

#import "XLPersonalSatiCell.h"
@interface SettingPassWordViewController ()<UIActionSheetDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UIAlertController *alertCon;
    UITableView *_tableView;
    NSArray *dataArr;
    NSArray *dataArr2;
    NSArray *dataArr3;
    
}
@end

@implementation SettingPassWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    dataArr=@[@"账户信息",@"收货地址",@"修改密码"];
    dataArr2=@[@"关于我们",@"联系客服",@"反馈",@"帮助"];
    dataArr3=@[@"清除缓存"];
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight, kScreen_Width, kScreenHeight-KSafeAreaTopNaviHeight-KSafeAreaBottomHeight-49) style:UITableViewStyleGrouped];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.bounces=NO;
    _tableView.estimatedRowHeight=44;
    _tableView.estimatedSectionHeaderHeight=10;
    _tableView.estimatedSectionFooterHeight=0;
    _tableView.showsVerticalScrollIndicator=NO;
    [_tableView registerNib:[UINib nibWithNibName:@"XLPersonalSatiCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_tableView];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 3;
    }else if (section==1)
    {
        return 4;
    }else
    {
    return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XLPersonalSatiCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.detailLab.text=@"";
    switch (indexPath.section) {
        case 0:
            cell.nameLab.text=dataArr[indexPath.row];
            break;
        case 1:
            cell.nameLab.text=dataArr2[indexPath.row];
            if (indexPath.row==1) {
                cell.detailLab.text=@"400-811-9789转2";
            }
            break;
        case 2:
            cell.nameLab.text=dataArr3[indexPath.row];
            break;
        default:
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            if (indexPath.row==0) {
//账户信息
                [self CheckPersonInfo:nil];
            }else if (indexPath.row==1)
            {
//收货地址
                YTAddressManngerViewController *vc =[[YTAddressManngerViewController alloc] init];

                [self.navigationController pushViewController:vc animated:NO];
                self.navigationController.navigationBar.hidden=YES;
            }else
            {
//修改密码
                [self ChangePassWord:nil];
            }
            break;
        case 1:
            if(indexPath.row==0)
            {
                XLPersonalAboutUsVC *vc=[[XLPersonalAboutUsVC alloc] init];
                [self.navigationController pushViewController:vc animated:NO];
                self.navigationController.navigationBar.hidden=YES;
            }else if(indexPath.row==1)
            {
                 [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:4008119789"]];
            }else if(indexPath.row==2)
            {
                XLPersonalAccountSuggestVC *VC=[[XLPersonalAccountSuggestVC alloc] init];
                [self.navigationController pushViewController:VC animated:NO];
              //  [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:4008119789"]];
            }else
            {
                XLPersonalHopeHandVC *VC=[[XLPersonalHopeHandVC alloc] init];
                [self.navigationController pushViewController:VC animated:YES];
            }

            break;
        case 2:
            [self clearCache];
            break;

        default:
            break;
    }


}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[UIView alloc]init];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [[UIView alloc]init];
}

//
-(void)clearCache
{
    [UIAlertTools showAlertWithTitle:nil message:@"确定要清除所有缓存？清除后再次加载部分功能可能需要耗费一定时间。" cancelTitle:@"取消" titleArray:@[] viewController:self confirm:^(NSInteger buttonTag) {
        if (buttonTag==0) {
            WKProgressHUD *hud=[WKProgressHUD showInView:self.view withText:@"" animated:YES];


                //清除cookies

                NSHTTPCookie *cookie;

                NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];

                for (cookie in [storage cookies]){

                    [storage deleteCookie:cookie];

                }

                //清除UIWebView的缓存

                [[NSURLCache sharedURLCache] removeAllCachedResponses];

                NSURLCache * cache = [NSURLCache sharedURLCache];

                [cache removeAllCachedResponses];

                [cache setDiskCapacity:0];

                [cache setMemoryCapacity:0];



            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
                    [hud dismiss:YES];
                }];
            });
        }
    }];
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
