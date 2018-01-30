//
//  YTOtherLoginViewController.m
//  aTaohMall
//
//  Created by JMSHT on 2016/10/8.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import "YTOtherLoginViewController.h"
#import "NewZhuCeViewController.h"//新注册

#import "NewForgotPassWordViewController.h"//新忘记密码

#import "PersonaViewController.h"//个人中心

#import "UserMessageManager.h"//缓存用户名

#import "NewHomeViewController.h"

#import "NewZhuCeViewController.h"

#import "NewHomeViewController.h"

#import "NewGoodsDetailViewController.h"//商品详情

#import "ZZLimitInputManager.h"

#import "JRToast.h"

#import "YTRegirstViewController.h"

#import "YTLoginViewController.h"
@interface YTOtherLoginViewController ()<UITextFieldDelegate,NameAndPassWordDelegate>
{
    NSMutableArray *_logArray;
    
    
    UIButton *backBtn;
    UIButton *registBtn;
    
    UIView *view;
    MBProgressHUD *myProgressHum;
    
    AFHTTPRequestOperationManager *manager;
    
    
    UIAlertController *alertCon;
    
    NSNull *null;
    
    int YTnumber;
    
}

@end

@implementation YTOtherLoginViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //    self.tabBarController.tabBar.hidden = YES;
    
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    app.myIntegral = @"";
    app.myKey = @"";
    app.myPassword = @"";
    app.myPhone = @"";
    app.myPhoto = @"";
    app.mySigen = @"";
    app.myUserid = @"";
    
    app.myIntegral = nil;
    app.myKey = nil;
    app.myPassword = nil;
    app.myPhone = nil;
    app.myPhoto = nil;
    app.mySigen = nil;
    app.myUserid = nil;
    
    //    [super viewWillAppear:NO];
    //    [self readNSUserDefaults];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    YTnumber=0;
    
    self.LoginButton.enabled=NO;
    
    [self.LoginButton setBackgroundImage:[UIImage imageNamed:@"为选中按钮"] forState:0];
    
    self.view.frame=[UIScreen mainScreen].bounds;
    
    
    //设置代理
    self.UserNameTF.delegate=self;
    self.PassWordTF.delegate=self;
    
    self.again=@"1";
    
    
    null=[[NSNull alloc] init];
    
    if ([self.cancleString isEqualToString:@"1"]) {
        
        self.CancleButton.hidden=YES;
        
    }
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    
    
    
    
    if ([self.backString isEqualToString:@"100"]) {
        
        self.UserNameTF.text=self.userName;
        self.PassWordTF.text=self.userPassWord;
        
    }else{
        
        self.UserNameTF.text=[userDefaultes stringForKey:@"myName"];
        self.PassWordTF.text=nil;
    }
    //密码
    [ZZLimitInputManager limitInputView:self.PassWordTF maxLength:20];
    //用户名
    [ZZLimitInputManager limitInputView:self.UserNameTF maxLength:20];
    
    
}


-(void)setUserName:(NSString *)name andPassWord:(NSString *)password
{
    self.UserNameTF.text=name;
    
    self.PassWordTF.text=password;
}


- (IBAction)backBtnClick:(UIButton *)sender {
    
    YTnumber=0;
    
    if ([self.backString isEqualToString:@"1"]){
        
        //恢复tabbar
        self.tabBarController.tabBar.hidden=YES;
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        
        
        
    }else if([self.backString isEqualToString:@"200"]){
        
        
        //恢复tabbar
        self.tabBarController.tabBar.hidden=YES;
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        
        
        
    }else if([self.backString isEqualToString:@"100"]){
        
        
        //恢复tabbar
        self.tabBarController.tabBar.hidden=NO;
        
        PersonaViewController *vc=[[PersonaViewController alloc] init];
        
        self.navigationController.navigationBar.hidden=YES;
        [self.navigationController pushViewController:vc animated:NO];


    }else if([self.backString isEqualToString:@"300"]){
        
        
        
        
        
        
        self.tabBarController.tabBar.hidden=YES;
        
        [self.navigationController popViewControllerAnimated:YES];
        
        
        
    }else if([self.backString isEqualToString:@"400"]){
        
        
        self.tabBarController.tabBar.hidden=NO;
        
        [self.navigationController popViewControllerAnimated:YES];
        
        
        
    }else{
        [self.navigationController popViewControllerAnimated:YES];
        //                            [self.navigationController pushViewController:home animated:YES];
        
        self.navigationController.navigationBar.hidden=YES;
        
        //恢复tabbar
        self.tabBarController.tabBar.hidden=NO;
    }
}


- (IBAction)LoginBtnClick:(UIButton *)sender {
    
    if (self.UserNameTF.text.length == 0) {
        
        alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入用户名" preferredStyle:UIAlertControllerStyleAlert];
        [alertCon addAction: [UIAlertAction actionWithTitle: @"确认" style: UIAlertActionStyleCancel handler:nil]];
        [self presentViewController: alertCon animated: YES completion: nil];
        
        
        
    }else{
        
        if (self.UserNameTF.text.length < 4) {
            
            //用户名长度小于4
            alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入4位以上用户名" preferredStyle:UIAlertControllerStyleAlert];
            [alertCon addAction: [UIAlertAction actionWithTitle: @"确认" style: UIAlertActionStyleCancel handler:nil]];
            [self presentViewController: alertCon animated: YES completion: nil];
            
            
        }else{
            
            //用户名是否为字母加数字
            NSString *CM_NUM = @"^[A-Za-z0-9]+$";
            
            NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
            
            BOOL isMatch1 = [pred1 evaluateWithObject:self.UserNameTF.text];
            
            if (!isMatch1) {
                
                alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"用户名只能是字母或数字" preferredStyle:UIAlertControllerStyleAlert];
                [alertCon addAction: [UIAlertAction actionWithTitle: @"确认" style: UIAlertActionStyleCancel handler:nil]];
                [self presentViewController: alertCon animated: YES completion: nil];
                
            }else{
                
                if (self.PassWordTF.text.length == 0) {
                    
                    alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入密码" preferredStyle:UIAlertControllerStyleAlert];
                    [alertCon addAction: [UIAlertAction actionWithTitle: @"确认" style: UIAlertActionStyleCancel handler:nil]];
                    [self presentViewController: alertCon animated: YES completion: nil];
                }else{
                    
                    if (self.PassWordTF.text.length < 6){
                        
                        alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"密码长度密码长度需6~20" preferredStyle:UIAlertControllerStyleAlert];
                        [alertCon addAction: [UIAlertAction actionWithTitle: @"确认" style: UIAlertActionStyleCancel handler:nil]];
                        [self presentViewController: alertCon animated: YES completion: nil];
                        
                        
                    }else{
                        
                        if([self.PassWordTF.text rangeOfString:@" "].location != NSNotFound){
                            
                            alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"密码不能包含空格" preferredStyle:UIAlertControllerStyleAlert];
                            [alertCon addAction: [UIAlertAction actionWithTitle: @"确认" style: UIAlertActionStyleCancel handler:nil]];
                            [self presentViewController: alertCon animated: YES completion: nil];
                            
                        }else{
                            
                            
                            if (YTnumber>=3) {
                                
                                YTLoginViewController *vc=[[YTLoginViewController alloc] init];
                                
                                self.navigationController.navigationBar.hidden=YES;
                                
                                [self.navigationController pushViewController:vc animated:NO];
                                
                            }
                            
                            //登录
                            [self NewLogin];
                        }
                    }
                }
            }
        }
    }
}


- (IBAction)zhuceBtnClick:(UIButton *)sender {
    
    YTRegirstViewController *vc=[[YTRegirstViewController alloc] init];
    
//    vc.delegate=self;
    
    [self.navigationController pushViewController:vc animated:NO];
    
    self.navigationController.navigationBar.hidden=YES;
}


- (IBAction)forgetBtnClick:(UIButton *)sender {
    
    NewForgotPassWordViewController *vc=[[NewForgotPassWordViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:NO];
    
    self.navigationController.navigationBar.hidden=YES;
}


- (IBAction)ytKeShiBtnClick:(UIButton *)sender {
    
    sender.selected=!sender.selected;
    
    //去掉蓝色背景
    sender.tintColor=[UIColor clearColor];
    
    
    if (sender.selected) {
        
        self.PassWordTF.secureTextEntry = YES;
        
        self.YTImageView.image=[UIImage imageNamed:@"不可视"];
        
    }else{
        
        self.PassWordTF.secureTextEntry = NO;
        self.YTImageView.image=[UIImage imageNamed:@"可视"];
    }

}


-(void)NoWebSeveice
{
    
    view=[[UIView alloc] initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-200)];
    
    view.backgroundColor=[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];
    
    [self.view addSubview:view];
    
    
    UIImageView *image=[[UIImageView alloc] initWithFrame:CGRectMake((view.frame.size.width-82)/2, 100, 82, 68)];
    
    image.image=[UIImage imageNamed:@"网络连接失败"];
    
    [view addSubview:image];
    
    
    UILabel *label1=[[UILabel alloc] initWithFrame:CGRectMake(100, 180, view.frame.size.width-200, 20)];
    
    label1.text=@"网络连接失败";
    
    label1.textAlignment=NSTextAlignmentCenter;
    
    label1.font=[UIFont fontWithName:@"PingFangSC-Medium" size:15];
    
    label1.textColor=[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    
    [view addSubview:label1];
    
    
    UILabel *label2=[[UILabel alloc] initWithFrame:CGRectMake(100, 210, view.frame.size.width-200, 20)];
    
    label2.text=@"请检查你的网络";
    
    label2.textAlignment=NSTextAlignmentCenter;
    
    label2.font=[UIFont fontWithName:@"PingFangSC-Medium" size:12];
    
    label2.textColor=[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    
    [view addSubview:label2];
    
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    
    button.frame=CGRectMake(100, 250, view.frame.size.width-200, 50);
    
    [button setTitle:@"重新加载" forState:0];
    button.titleLabel.font=[UIFont fontWithName:@"PingFangSC-Medium" size:12];
    [button setTitleColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0] forState:0];
    
    [view addSubview:button];
    
    [button addTarget:self action:@selector(loadData) forControlEvents:UIControlEventTouchUpInside];
    
}
-(void)NewLogin
{
    myProgressHum = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [myProgressHum hide:YES afterDelay:30.0];
    
    manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //        NSString *urlStr = TestHttp;
    
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 30.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    NSDictionary *dic = @{@"phone":self.UserNameTF.text,@"password":self.PassWordTF.text};
    
    NSString *url = [NSString stringWithFormat:@"%@login_mob.shtml",URL_Str];
    
    [manager POST:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
        NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];
        //            NSLog(@"opration  !!!!%@",operation.responseString);
        
        
        
        if (codeKey && content) {
            NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
            
            //NSLog(@"xmlStr%@",xmlStr);
            
            
            NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];
            
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            
            view.hidden=YES;
            
            for (NSDictionary *dic1 in dic) {
                
                NSLog(@"状态码 == %@",dic1[@"status"]);
                
                NSLog(@"登录状态  ==%@",dic1[@"message"]);
                NSLog(@"%@",dic1);
                
                
                if ([dic1[@"status"] isEqualToString:@"10000"]) {
                    
                    MallModel *model = [[MallModel alloc] init];
                    model.id_ = dic1[@"userid"];
                    model.sigen_ = dic1[@"sigen"];
                    
                    //传值sigen给个人中心界面
                    PersonaViewController *vc=[[PersonaViewController alloc] init];
                    
                    NewHomeViewController *home=[[NewHomeViewController alloc] init];
                    
                    home.sigens=dic1[@"sigen"];
                    
                    vc.sigen=dic1[@"sigen"];
                    vc.status=dic1[@"status"];
                    
                    //                    NSLog(@"个人中心sigen==%@",vc.sigen);
                    //block实现传值
                    
                    
                    
                    
                    
                    
                    //实现反向传值
                    if (_delegate && [_delegate respondsToSelector:@selector(setSigenWithString:andStatusWithString:andIntegralWithString:andPhoneWithString:andHeaderImageWithString:andUserId: andUserName:)]) {
                        [_delegate setSigenWithString:dic1[@"sigen"] andStatusWithString:dic1[@"status"] andIntegralWithString:dic1[@"integral"] andPhoneWithString:dic1[@"phone"] andHeaderImageWithString:dic1[@"portrait"] andUserId:dic1[@"userid"] andUserName:self.UserNameTF.text];
                    }
                    
                    //缓存用户名
                    [UserMessageManager UserName:self.UserNameTF.text];
                    
                    [UserMessageManager UserNewName:self.UserNameTF.text];
                    
                    //缓存用户密码
                    [UserMessageManager UserPassWord:self.PassWordTF.text];
                    
                    //缓存用户sigen
                    [UserMessageManager UserSigen:dic1[@"sigen"]];
                    //缓存手机号
                    if (![dic1[@"phone"] isEqual:null]) {
                        
                        [UserMessageManager UserPhone:dic1[@"phone"]];
                    }
                    
                    
                    //缓存用户积分
                    [UserMessageManager UserInteger:dic1[@"integral"]];
                    
                    [UserMessageManager LoginNumber:dic1[@"status"]];
                    
                    if ([dic1[@"portrait"] isEqual:null] || [dic1[@"portrait"] isEqualToString:@""]) {
                        
                        //缓存头像
                        [UserMessageManager UserHeaderImage:@"头像"];
                    }else{
                        
                        //缓存头像
                        [UserMessageManager UserHeaderImage:dic1[@"portrait"]];
                    }
                    
                    
                    //缓存userid
                    [UserMessageManager UserId:dic1[@"userid"]];
                    
                    
                    NSString *userId=dic1[@"userid"];
                    
                    NSDictionary *dict10 =@{@"userid": userId};
                    
                    
                    //创建通知
                    NSNotification *notification =[NSNotification notificationWithName:@"yangtao" object:nil userInfo:dict10];
                    //通过通知中心发送通知
                    [[NSNotificationCenter defaultCenter] postNotification:notification];
                    
                }
                
                
                
                
                
                //缓存登录次数
                [UserMessageManager UserTime:self.again];
                
                if ([dic1[@"status"] isEqualToString:@"10000"]) {
                    /*
                     PersonalCenterViewController *personal = [self.storyboard instantiateViewControllerWithIdentifier:@"PersonalCenterViewController"];
                     [self.navigationController pushViewController:personal animated:YES];
                     
                     personal.phone_ = self.userPhone.text;
                     personal.pass_ = self.userPassword.text;
                     personal.sigen_ = dic1[@"sigen"];
                     personal.headPhoto_ = dic1[@"portrait"];
                     personal.integrass_ = dic1[@"integral"];
                     */
                    
                    [JRToast showWithText:@"登陆成功!" duration:1.0f];
                    
                    //缓存登录状态
                    [UserMessageManager LoginStatus:@"YES"];
                    
                    
                    //设置通知让其他界面接收数据
                    
                    //通知
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"postNumber" object:dic1[@"sigen"]];
                    
                    
                    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                    
                    
                    
                    //                        app.mySigen = dic1[@"sigen"];
                    
                    app.mySigen = @"===";
                    
                    //                        app.my = self.UserNameTF.text;
                    //                        app.myPassword = self.PassWordTF.text;
                    app.myPhoto = dic1[@"portrait"];
                    app.myIntegral = dic1[@"integral"];
                    app.myKey = dic1[@"key"];
                    app.myUserid = dic1[@"userid"];
                    
                    NSLog(@"----->%@",app.myUserid);
                    
                    //NSLog(@"%@",self.again);
                    
                    //[ddind1 stopAnimating];
                    
                    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                    
                    
                    if ([self.backString isEqualToString:@"1"]){
                        //恢复tabbar
                        self.tabBarController.tabBar.hidden=NO;
                        
                        [self.navigationController popToRootViewControllerAnimated:YES];
                        
                        
                        
                    }else if([self.backString isEqualToString:@"200"]){
                        
                        //恢复tabbar
                        self.tabBarController.tabBar.hidden=NO;
                        
                        [self.navigationController popToRootViewControllerAnimated:YES];
                        
                        
                        
                    }else if([self.backString isEqualToString:@"100"]){
                        
                        //恢复tabbar
                        self.tabBarController.tabBar.hidden=NO;
                        
                        PersonaViewController *vc=[[PersonaViewController alloc] init];
                        
                        self.navigationController.navigationBar.hidden=YES;
                        
                        [self.navigationController pushViewController:vc animated:NO];
                        
                        
                        
                    }else if([self.backString isEqualToString:@"300"]){
                        
                        self.tabBarController.tabBar.hidden=YES;
                        [self.navigationController popViewControllerAnimated:YES];
                        
                        
                        
                    }else{
                        [self.navigationController popViewControllerAnimated:YES];
                        //                            [self.navigationController pushViewController:home animated:YES];
                        
                        //恢复tabbar
                        self.tabBarController.tabBar.hidden=NO;
                        
                        self.navigationController.navigationBar.hidden=YES;
                        
                        
                    }
                    
                    
                    
                }else if([dic1[@"status"] isEqualToString:@"10001"]){
                    
                    alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"用户名或密码不正确" preferredStyle:UIAlertControllerStyleAlert];
                    [alertCon addAction: [UIAlertAction actionWithTitle: @"确认" style: UIAlertActionStyleCancel handler:nil]];
                    [self presentViewController: alertCon animated: YES completion: nil];
                    
                    
                    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                    
                    
                    YTnumber++;
                    
                }else{
                    
                    alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:dic1[@"message"] preferredStyle:UIAlertControllerStyleAlert];
                    [alertCon addAction: [UIAlertAction actionWithTitle: @"确认" style: UIAlertActionStyleCancel handler:nil]];
                    [self presentViewController: alertCon animated: YES completion: nil];
                    
                    
                    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                }
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
//        alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"服务器连接失败! 请检查网络链接或联系客服" preferredStyle:UIAlertControllerStyleAlert];
//        [alertCon addAction: [UIAlertAction actionWithTitle: @"确认" style: UIAlertActionStyleCancel handler:nil]];
//        [self presentViewController: alertCon animated: YES completion: nil];
        
        [self NoWebSeveice];
        NSLog(@"PostDepartment Error %@",error);
    }];
}

-(void)loadData{
    
    //    [self NoWebSeveice];
    [self NewLogin];
}
- (void)viewWillDisappear:(BOOL)animated{
    
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    [manager.operationQueue cancelAllOperations];
    
    [self.PassWordTF resignFirstResponder];
    [self.UserNameTF resignFirstResponder];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    
    [self.UserNameTF resignFirstResponder];
    [self.PassWordTF resignFirstResponder];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    
    [theTextField resignFirstResponder];
    
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    if (textField==self.UserNameTF) {
        
        NSLog(@"111");
        
        if (self.PassWordTF.text.length>0) {
            
            self.LoginButton.enabled=YES;
            [self.LoginButton setBackgroundImage:[UIImage imageNamed:@"按钮"] forState:0];
            
        }else{
            
            self.LoginButton.enabled=NO;
            [self.LoginButton setBackgroundImage:[UIImage imageNamed:@"为选中按钮"] forState:0];
        }
        
    }else if (textField==self.PassWordTF){
        NSLog(@"222");
        if (self.UserNameTF.text.length>0) {
            
            self.LoginButton.enabled=YES;
            [self.LoginButton setBackgroundImage:[UIImage imageNamed:@"按钮"] forState:0];
            
        }else{
            
            self.LoginButton.enabled=NO;
            [self.LoginButton setBackgroundImage:[UIImage imageNamed:@"为选中按钮"] forState:0];
        }
    }
}

//-(void)textFieldDidEndEditing:(UITextField *)textField
//{
//    
//    if (textField==self.UserNameTF) {
//        
//        NSLog(@"111");
//        
//        if (self.PassWordTF.text.length>0) {
//            
//            self.LoginButton.enabled=YES;
//            [self.LoginButton setBackgroundImage:[UIImage imageNamed:@"按钮"] forState:0];
//            
//        }else{
//            
//            self.LoginButton.enabled=NO;
//            [self.LoginButton setBackgroundImage:[UIImage imageNamed:@"为选中按钮"] forState:0];
//        }
//        
//    }else if (textField==self.PassWordTF){
//        NSLog(@"222");
//        if (textField.text.length>0) {
//            
//            self.LoginButton.enabled=YES;
//            [self.LoginButton setBackgroundImage:[UIImage imageNamed:@"按钮"] forState:0];
//            
//        }else{
//            
//            self.LoginButton.enabled=NO;
//            [self.LoginButton setBackgroundImage:[UIImage imageNamed:@"为选中按钮"] forState:0];
//        }
//    }
// 
//}

//-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
//{
//    
//    if (textField==self.UserNameTF && string) {
//        
//        NSLog(@"===1111===%@=string.length",self.PassWordTF.text);
//        
//        if (self.PassWordTF.text.length>0) {
//            
//            self.LoginButton.enabled=YES;
//            [self.LoginButton setBackgroundImage:[UIImage imageNamed:@"按钮"] forState:0];
//            
//        }else{
//            
//            self.LoginButton.enabled=NO;
//            [self.LoginButton setBackgroundImage:[UIImage imageNamed:@"为选中按钮"] forState:0];
//        }
//    }else if (textField==self.PassWordTF && string){
//        
//        NSLog(@"===2222===%@=string.length",self.PassWordTF.text);
//        
//        if (self.PassWordTF.text.length>0) {
//            
//            [self.LoginButton setBackgroundImage:[UIImage imageNamed:@"按钮"] forState:0];
//            self.LoginButton.enabled=YES;
//            
//            
//        }else{
//            
//            self.LoginButton.enabled=NO;
//            [self.LoginButton setBackgroundImage:[UIImage imageNamed:@"为选中按钮"] forState:0];
//        }
//    }
//    
//    return YES;
//}


@end
