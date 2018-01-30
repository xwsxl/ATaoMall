//
//  PassWordSettingViewController.m
//  aTaohMall
//
//  Created by JMSHT on 16/5/18.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import "PassWordSettingViewController.h"


#import "NewLoginViewController.h"

#import "UserMessageManager.h"//缓存数据

#import "ChangeSuccessViewController.h"//修改成功
#import "ChangeFailureViewController.h"//修改失败

#import "ZZLimitInputManager.h"

#import "WKProgressHUD.h"

#import "WKProgressHUD.h"

#import "ATHLoginViewController.h"

@interface PassWordSettingViewController ()<UITextFieldDelegate,LoginMessageDelegate>
{
    UIAlertController *alertCon;
    
    UIView *view;
    MBProgressHUD *myProgressHum;
}
@end

@implementation PassWordSettingViewController
- (IBAction)OldPasswordButClick:(id)sender {
    self.oldPasswordBut.selected=!_oldPasswordBut.selected;
    if (_oldPasswordBut.selected) {
        [_oldPasswordBut setBackgroundImage:KImage(@"睁眼") forState:UIControlStateNormal];
        self.OldPassWordTF.secureTextEntry=NO;
    }else
    {
        [_oldPasswordBut setBackgroundImage:KImage(@"闭眼") forState:UIControlStateNormal];
        self.OldPassWordTF.secureTextEntry=YES;

    }
}
- (IBAction)NewPasswordButClick:(id)sender {
    self.NewPasswordBut.selected=!_NewPasswordBut.selected;
    if (_NewPasswordBut.selected) {
        [_NewPasswordBut setBackgroundImage:KImage(@"睁眼") forState:UIControlStateNormal];
        self.NewPassWordTF.secureTextEntry=NO;
    }else
    {
        [_NewPasswordBut setBackgroundImage:KImage(@"闭眼") forState:UIControlStateNormal];
        self.NewPassWordTF.secureTextEntry=YES;

    }
}
- (IBAction)SurePasswordButClick:(id)sender {
    self.SurePassWordBut.selected=!_SurePassWordBut.selected;
    if (_SurePassWordBut.selected) {
        [_SurePassWordBut setBackgroundImage:KImage(@"睁眼") forState:UIControlStateNormal];
        self.AgainPassWordTF.secureTextEntry=NO;
    }else
    {
        [_SurePassWordBut setBackgroundImage:KImage(@"闭眼") forState:UIControlStateNormal];
        self.AgainPassWordTF.secureTextEntry=YES;

    }
}

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
    
    //取出缓存数据
    [self readNSUserDefaults];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidTimeout:) name:kApplicationDidTimeoutNotification object:nil];
    
    [self.AgainPassWordTF addTarget:self action:@selector(textFiledDidChangedText:) forControlEvents:UIControlEventEditingChanged];
    [self.OldPassWordTF addTarget:self action:@selector(textFiledDidChangedText:) forControlEvents:UIControlEventEditingChanged];
    [self.NewPassWordTF addTarget:self action:@selector(textFiledDidChangedText:) forControlEvents:UIControlEventEditingChanged];
    self.view.frame=[UIScreen mainScreen].bounds;
    
    self.OldPassWordTF.delegate = self;
    self.NewPassWordTF.delegate = self;
    self.AgainPassWordTF.delegate = self;
    self.sureBut.enabled=NO;
    self.sureBut.backgroundColor=RGB(255, 156, 159);
    self.sureBut.layer.cornerRadius=5;
    
    //设置旧密码长度
    [ZZLimitInputManager limitInputView:self.OldPassWordTF maxLength:16];
    
    //设置新密码长度
    [ZZLimitInputManager limitInputView:self.NewPassWordTF maxLength:16];
    
    //设置新密码长度
    [ZZLimitInputManager limitInputView:self.AgainPassWordTF maxLength:16];



}

-(void)textFiledDidChangedText:(UITextField *)TF
{
    YLog(@"%@",TF.text);
    if ([TF.text containsString:@" "]) {
       TF.text=[TF.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    }
    if (self.OldPassWordTF.text.length>0&&self.AgainPassWordTF.text.length>0&&self.NewPassWordTF.text.length>0) {
        self.sureBut.enabled=YES;
        self.sureBut.backgroundColor=RGB(255, 73, 73);
    }else
    {
        self.sureBut.enabled=NO;
        self.sureBut.backgroundColor=RGB(255, 156, 159);
    }

}

-(void)loadData{
    
    [self getDatas];
    
}

//反向传值，实现代理方法
-(void)setSigenWithString:(NSString *)string1 andStatusWithString:(NSString *)string2 andIntegralWithString:(NSString *)string3 andPhoneWithString:(NSString *)string4 andHeaderImageWithString:(NSString *)string5
{
    self.sigens=string1;
    self.phoneNumbers=string4;

    
    NSLog(@"sigen==%@",string1);
    
    NSLog(@"phone==%@",string4);

    //刷新数据

}

//自动退出
- (void)applicationDidTimeout:(NSNotification *)notif{
    
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    app.mySigen = nil;
    app.myIntegral = nil;
    app.myPhone = nil;
    app.myKey = nil;
    app.myPassword = nil;
    app.myPhoto = nil;
    app.myUserid = nil;
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

//返回
- (IBAction)backBtnClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

//提交
- (IBAction)commitBtnClick:(UIButton *)sender {


    WKProgressHUD *hud=[WKProgressHUD showInView:self.view withText:nil animated:YES];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 30.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    NSDictionary *dic = @{@"sigen":self.sigens,@"old_password":self.OldPassWordTF.text};

    NSString *url = [NSString stringWithFormat:@"%@verificationPassword_mob.shtml",URL_Str];
    [manager POST:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
          [hud dismiss:YES];
        NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
        NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];
        if (codeKey && content) {
            NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];

            //NSLog(@"xmlStr%@",xmlStr);


            NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];


            NSDictionary *dic1 = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];


                       NSLog(@"=======%@",dic1);
          //  view.hidden=YES;


                if ([dic1[@"status"] isEqualToString:@"10000"]) {
//*************旧密码正确
                    if ([self.NewPassWordTF.text isEqualToString:self.OldPassWordTF.text]||[self.AgainPassWordTF.text isEqualToString:self.OldPassWordTF.text])
                    {
                        [TrainToast showWithText:@"新旧密码不能一致" duration:2.0];

                    }else if (![self.NewPassWordTF.text isEqualToString:self.AgainPassWordTF.text])
                    {
                        [TrainToast showWithText:@"两次输入的密码不一致，请重新输入" duration:2.0];

                    }else
                    {

                        if ([self secretIsIncrectWithString:self.NewPassWordTF.text]) {

                            [self getDatas];

                        }else
                        {
                            [TrainToast showWithText:@"6-16个字符，由字母、数字和符号的两种以上组合" duration:2.0];
                        }
                    }
//****************
                }else{

                    [TrainToast showWithText:dic1[@"message"] duration:2.0];
                }
            }




    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [hud dismiss:YES];
        [TrainToast showWithText:@"登录密码修改失败，请重新修改" duration:2.0];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.OldPassWordTF.text=@"";
            self.NewPassWordTF.text=@"";
            self.AgainPassWordTF.text=@"";
        });
    }];








}

-(BOOL)secretIsIncrectWithString:(NSString *)str
{
    BOOL result = false;

    // 判断长度大于6位后再接着判断是否同时包含数字和字符
     NSString * regex= @"^(?=.*[a-zA-Z0-9].*)(?=.*[a-zA-Z\\W].*)(?=.*[0-9\\W].*).{6,20}$";
  //  NSString * regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,16}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    result = [pred evaluateWithObject:str];
    return result;
}

-(void)getDatas
{
    
    myProgressHum = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [myProgressHum hide:YES afterDelay:30.0];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //            NSString *urlStr = TestHttp;
    
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 30.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    //            AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSLog(@"==self.phoneNumbers====%@",self.phoneNumbers);
    NSLog(@"==self.sigens====%@",self.sigens);
    NSLog(@"==self.NewPassWordTF.text====%@",self.NewPassWordTF.text);
    
    if (self.phoneNumbers.length==0) {
        
        self.phoneNumbers=@"";
        
    }
    NSDictionary *dic = @{@"sigen":self.sigens,@"phone":self.phoneNumbers,@"password":self.NewPassWordTF.text,@"old_password":self.OldPassWordTF.text};
    
    
    NSString *url = [NSString stringWithFormat:@"%@userResetPassword_mob.shtml",URL_Str];
    [manager POST:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
        NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];
        
        
        
        
        if (codeKey && content) {
            NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
            
            //NSLog(@"xmlStr%@",xmlStr);
            
            
            NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];
            
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            
//            NSLog(@"=======%@",dic);
            view.hidden=YES;
            for (NSDictionary *dic1 in dic) {
                
                
                if ([dic1[@"status"] isEqualToString:@"10000"]) {
                    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                    [TrainToast showWithText:dic1[@"message"] duration:3.0];
                    [KNotificationCenter postNotificationName:JMSHTLogOutSuccessNoti object:nil];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        ATHLoginViewController *login=[[ATHLoginViewController alloc] init];

                        self.navigationController.viewControllers=@[self.navigationController.viewControllers.firstObject,login];

                        self.navigationController.navigationBar.hidden=YES;
                        self.tabBarController.tabBar.hidden=YES;

                    });

                }else{

                    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                    [TrainToast showWithText:dic1[@"message"] duration:2.0];
                }
            }
            
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

        [TrainToast showWithText:@"登录密码修改失败，请重新修改" duration:2.0];
        self.OldPassWordTF.text=@"";
        self.NewPassWordTF.text=@"";
        self.AgainPassWordTF.text=@"";
        NSLog(@"PostDepartment Error %@",error);
    }];
    
    
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    
    [self.OldPassWordTF resignFirstResponder];
    [self.NewPassWordTF resignFirstResponder];
    [self.AgainPassWordTF resignFirstResponder];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    
    [theTextField resignFirstResponder];
    
    return YES;
}

-(void)readNSUserDefaults{//取出缓存的数据
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数组NSArray类型的数据

    self.sigens=[userDefaultes stringForKey:@"sigen"];
    
    self.passwords=[userDefaultes stringForKey:@"password"];
    
    self.phoneNumbers=[userDefaultes stringForKey:@"phone"];

        NSLog(@"UserName======%@",self.phoneNumbers);
}

@end
