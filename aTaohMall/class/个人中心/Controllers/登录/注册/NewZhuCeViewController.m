//
//  NewZhuCeViewController.m
//  aTaohMall
//
//  Created by JMSHT on 16/5/14.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import "NewZhuCeViewController.h"
#import "NewLoginViewController.h"
#import "AFNetworking.h"

#import "XieYiViewController.h"

#import "ZZLimitInputManager.h"

#import "JRToast.h"
@interface NewZhuCeViewController ()<UITextFieldDelegate>
{
    UIAlertController *alertCon;
    NSMutableArray *_registerArray;
    NSString *strCode;
    
    UIButton *backBtn;
    
    MBProgressHUD *myProgressHum; //进度条
    
    NSTimer *timer;   //验证码时间
    int i;
    UIButton *buttonCover;
    
    BOOL isAgree;
    BOOL isCorrect;
    UIView *view;
    UITextField *tempTextField;//全局UITextfiled指针
}
@end

@implementation NewZhuCeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    isAgree = YES;
    
    isCorrect = YES;
    
    _registerArray = [NSMutableArray array];
    
    i = 59;
    
    
//    self.SureButton.enabled=NO;
    
    
    self.agreeString=@"1";
    
    self.userMessageTF.tag=100;
    
    self.userTGTF.tag=200;
    self.userTGTF.delegate = self;
    self.userMessageTF.delegate = self;
    
    //输入用户名长度
    [ZZLimitInputManager limitInputView:self.userNameTF maxLength:16];
    
    //设置密码长度
    [ZZLimitInputManager limitInputView:self.userPassWordTF maxLength:16];
    
    //重新输入密码
    [ZZLimitInputManager limitInputView:self.againUserPassWordTF maxLength:16];
    
    //手机号
    [ZZLimitInputManager limitInputView:self.userPhoneTF maxLength:11];
    
    //短信验证码
    [ZZLimitInputManager limitInputView:self.userMessageTF maxLength:6];
    
  //  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:andOtherTextField:) name:UIKeyboardWillShowNotification object:nil];
    //监听键盘的掉下
   // [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
}
//返回
- (IBAction)backBtnClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
//获取验证码
- (IBAction)getMessageBtnClick:(UIButton *)sender {
    
    if (self.userPhoneTF.text.length == 0) {
        
        alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入电话号码" preferredStyle:UIAlertControllerStyleAlert];
        [alertCon addAction: [UIAlertAction actionWithTitle: @"确认" style: UIAlertActionStyleCancel handler:nil]];
        [self presentViewController: alertCon animated: YES completion: nil];
        
    }else{
        if (self.userPhoneTF.text.length < 11 ) {
            
            alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"电话号码不得少于11个字符" preferredStyle:UIAlertControllerStyleAlert];
            [alertCon addAction: [UIAlertAction actionWithTitle: @"确认" style: UIAlertActionStyleCancel handler:nil]];
            [self presentViewController: alertCon animated: YES completion: nil];
            
        }else{
            
            /**
             * 移动号段正则表达式
             */
            NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
            /**
             * 联通号段正则表达式
             */
            NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
            /**
             * 电信号段正则表达式
             */
            NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
            NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
            BOOL isMatch1 = [pred1 evaluateWithObject:self.userPhoneTF.text];
            NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
            BOOL isMatch2 = [pred2 evaluateWithObject:self.userPhoneTF.text];
            NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
            
            BOOL isMatch3 = [pred3 evaluateWithObject:self.userPhoneTF.text];
            
            if (!(isMatch1 || isMatch2 || isMatch3)) {
                
                alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入正确的手机号" preferredStyle:UIAlertControllerStyleAlert];
                [alertCon addAction: [UIAlertAction actionWithTitle: @"确认" style: UIAlertActionStyleCancel handler:nil]];
                    [self presentViewController: alertCon animated: YES completion: nil];
            }
            
            
            
            
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            
            
            NSDictionary *dic = @{@"phone":self.userPhoneTF.text};
            
            NSString *url = [NSString stringWithFormat:@"%@getCode_mob.shtml",URL_Str];
            
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
                    
                    
                    NSLog(@"=====获取验证码==%@",dic);
                    
                    view.hidden=YES;
                    for (NSDictionary *dic1 in dic) {
                        
                        self.code=dic1[@"code"];
                        
                        if ([dic1[@"status"] isEqualToString:@"10000"]){
                            
                            MallModel *model = [[MallModel alloc] init];
                            model.id_ = dic1[@"userid"];
                            model.code_ = dic1[@"code"];
                            
                            buttonCover = [UIButton buttonWithType:UIButtonTypeCustom];
                            
                            buttonCover.frame = self.GetMessage.frame;
                            buttonCover.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:202.0/255.0 blue:0/255.0 alpha:1];
                            [buttonCover setTitle:@"300秒重新获取" forState:UIControlStateNormal];
                            buttonCover.titleLabel.font = [UIFont systemFontOfSize:12.0];
                            [self.view addSubview:buttonCover];
                            
                            i = 299;
                            strCode = model.code_;
                            
                            
                            
                            
                            timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(strTimer:) userInfo:nil repeats:YES];
                            
                            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                            
                        }else {
                            
                            alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:dic1[@"message"] preferredStyle:UIAlertControllerStyleAlert];
                            [alertCon addAction: [UIAlertAction actionWithTitle: @"确认" style: UIAlertActionStyleCancel handler:nil]];
                            [self presentViewController: alertCon animated: YES completion: nil];
                            
                            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                            
                        }
                        
                    }
                    
                }
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                
                alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"服务器连接失败! 请检查网络链接或联系客服" preferredStyle:UIAlertControllerStyleAlert];
                [alertCon addAction: [UIAlertAction actionWithTitle: @"确认" style: UIAlertActionStyleCancel handler:nil]];
                [self presentViewController: alertCon animated: YES completion: nil];
                
                NSLog(@"PostDepartment Error %@",error);
            }];
        }
    }
}
//阅读并同意
- (IBAction)agreeBtnClick:(UIButton *)sender {
    
    sender.selected=!sender.selected;
    
    //去掉蓝色背景
    sender.tintColor=[UIColor clearColor];
    
    if (sender.selected) {
               self.agreeImageView.image=[UIImage imageNamed:@"外圈@2x"];
//        self.SureButton.enabled=NO;
        
        self.agreeString=@"0";
    }else{
        
         self.agreeImageView.image=[UIImage imageNamed:@"圈"];
//        self.SureButton.enabled=YES;
        self.agreeString=@"1";
        

    }
    
}
//协议
- (IBAction)ptrocelBtnClick:(UIButton *)sender {
    
    XieYiViewController *vc=[[XieYiViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:NO];
    
    self.navigationController.navigationBar.hidden=YES;
    
}
//确定
- (IBAction)OkBtnClick:(UIButton *)sender {
    
    
    if (self.userNameTF.text.length == 0) {
        //输入用户名
        alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入用户名" preferredStyle:UIAlertControllerStyleAlert];
        [alertCon addAction: [UIAlertAction actionWithTitle: @"确认" style: UIAlertActionStyleCancel handler:nil]];
        [self presentViewController: alertCon animated: YES completion: nil];
        
    }else{
        
        if (self.userNameTF.text.length < 4) {
            
            //用户名长度小于4
            alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入4位以上用户名" preferredStyle:UIAlertControllerStyleAlert];
            [alertCon addAction: [UIAlertAction actionWithTitle: @"确认" style: UIAlertActionStyleCancel handler:nil]];
            [self presentViewController: alertCon animated: YES completion: nil];
            
        }else{
            //用户名是否为字母加数字
            NSString *CM_NUM = @"^[A-Za-z0-9_-]+$";
            
            NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
            
            BOOL isMatch1 = [pred1 evaluateWithObject:self.userNameTF.text];
            
            if (!isMatch1) {
                
                alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"用户名只能是字母或数字" preferredStyle:UIAlertControllerStyleAlert];
                [alertCon addAction: [UIAlertAction actionWithTitle: @"确认" style: UIAlertActionStyleCancel handler:nil]];
                [self presentViewController: alertCon animated: YES completion: nil];
                
            }else{
                //用户密码
                if (self.userPassWordTF.text.length == 0) {
                    
                    alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入密码" preferredStyle:UIAlertControllerStyleAlert];
                    [alertCon addAction: [UIAlertAction actionWithTitle: @"确认" style: UIAlertActionStyleCancel handler:nil]];
                    [self presentViewController: alertCon animated: YES completion: nil];
                    
                }else{
                    
                    if (self.userPassWordTF.text.length < 6){
                        
                        alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"密码长度密码长度需6~18" preferredStyle:UIAlertControllerStyleAlert];
                        [alertCon addAction: [UIAlertAction actionWithTitle: @"确认" style: UIAlertActionStyleCancel handler:nil]];
                        [self presentViewController: alertCon animated: YES completion: nil];
                        
                        
                        
                    }else{
                       
                        if([self.userPassWordTF.text rangeOfString:@" "].location != NSNotFound){
                            
                            alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"密码不能包含空格" preferredStyle:UIAlertControllerStyleAlert];
                            [alertCon addAction: [UIAlertAction actionWithTitle: @"确认" style: UIAlertActionStyleCancel handler:nil]];
                            [self presentViewController: alertCon animated: YES completion: nil];
                            
                        }else{
                            
                            //再次输密码
                            
                            if(self.againUserPassWordTF.text.length == 0){
                                
                                alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"请再次输入密码" preferredStyle:UIAlertControllerStyleAlert];
                                [alertCon addAction: [UIAlertAction actionWithTitle: @"确认" style: UIAlertActionStyleCancel handler:nil]];
                                [self presentViewController: alertCon animated: YES completion: nil];
                                
                            }else{
                                
                                if(self.againUserPassWordTF.text.length < 6 ){
                                    
                                    alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"密码长度不得少于6个字符" preferredStyle:UIAlertControllerStyleAlert];
                                    [alertCon addAction: [UIAlertAction actionWithTitle: @"确认" style: UIAlertActionStyleCancel handler:nil]];
                                    [self presentViewController: alertCon animated: YES completion: nil];
                                    
                                }else{
                                    
                                    if([self.againUserPassWordTF.text rangeOfString:@" "].location != NSNotFound){
                                        
                                        alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"再次输入密码不能包含空格" preferredStyle:UIAlertControllerStyleAlert];
                                        [alertCon addAction: [UIAlertAction actionWithTitle: @"确认" style: UIAlertActionStyleCancel handler:nil]];
                                        [self presentViewController: alertCon animated: YES completion: nil];
                                        
                                    }else{
                                        
                                        //判断两次密码是否相同
                                        
                                        if (![self.userPassWordTF.text isEqualToString:self.againUserPassWordTF.text]){
                                            
                                            alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"两次输入密码不一致" preferredStyle:UIAlertControllerStyleAlert];
                                            [alertCon addAction: [UIAlertAction actionWithTitle: @"确认" style: UIAlertActionStyleCancel handler:nil]];
                                            [self presentViewController: alertCon animated: YES completion: nil];
                                            
                                        }else{
                                            
                                            if (self.userPhoneTF.text.length==0) {
                                                
                                                alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入您的手机号" preferredStyle:UIAlertControllerStyleAlert];
                                                [alertCon addAction: [UIAlertAction actionWithTitle: @"确认" style: UIAlertActionStyleCancel handler:nil]];
                                                [self presentViewController: alertCon animated: YES completion: nil];
                                                
                                            }else{
                                                
                                                /**
                                                 * 移动号段正则表达式
                                                 */
                                                NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
                                                /**
                                                 * 联通号段正则表达式
                                                 */
                                                NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
                                                /**
                                                 * 电信号段正则表达式
                                                 */
                                                NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
                                                NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
                                                BOOL isMatch1 = [pred1 evaluateWithObject:self.userPhoneTF.text];
                                                NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
                                                BOOL isMatch2 = [pred2 evaluateWithObject:self.userPhoneTF.text];
                                                NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
                                                
                                                BOOL isMatch3 = [pred3 evaluateWithObject:self.userPhoneTF.text];
                                                
                                                if (!(isMatch1 || isMatch2 || isMatch3)) {
                                                    
                                                    alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入正确的手机号" preferredStyle:UIAlertControllerStyleAlert];
                                                    [alertCon addAction: [UIAlertAction actionWithTitle: @"确认" style: UIAlertActionStyleCancel handler:nil]];
                                                    [self presentViewController: alertCon animated: YES completion: nil];
                                                    
                                                }else{
                                                    
                                                    if(self.userMessageTF.text.length == 0){
                                                        
                                                        alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入验证码" preferredStyle:UIAlertControllerStyleAlert];
                                                        [alertCon addAction: [UIAlertAction actionWithTitle: @"确认" style: UIAlertActionStyleCancel handler:nil]];
                                                        [self presentViewController: alertCon animated: YES completion: nil];
                                                        
                                                    }else{
                                                        
                                                        if (self.userMessageTF.text.length <= 5) {
                                                            
                                                            alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"验证码必须为6位" preferredStyle:UIAlertControllerStyleAlert];
                                                            [alertCon addAction: [UIAlertAction actionWithTitle: @"确认" style: UIAlertActionStyleCancel handler:nil]];
                                                            [self presentViewController: alertCon animated: YES completion: nil];
                                                        }else{
                                                            
                                                            NSLog(@"==self.code=%@",self.code);
                                                            NSLog(@"==self.userMessageTF.text=%@",self.userMessageTF.text);
                                                            
                                                            if (![self.userMessageTF.text isEqualToString:self.code]) {
                                                                
                                                                alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"您输入的验证码错误" preferredStyle:UIAlertControllerStyleAlert];
                                                                [alertCon addAction: [UIAlertAction actionWithTitle: @"确认" style: UIAlertActionStyleCancel handler:nil]];
                                                                [self presentViewController: alertCon animated: YES completion: nil];
                                                            }else{
                                                                
                                                                if ([self.agreeString isEqualToString:@"0"]) {
                                                                    
                                                                    alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"请点击已阅读并同意" preferredStyle:UIAlertControllerStyleAlert];
                                                                    [alertCon addAction: [UIAlertAction actionWithTitle: @"确认" style: UIAlertActionStyleCancel handler:nil]];
                                                                    [self presentViewController: alertCon animated: YES completion: nil];
                                                                }else{
                                                                    
                                                                    //调用接口
                                                                    [self checkBtnClick];
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    
    
    
//    if (self.userNameTF.text.length == 0) {
//        alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入用户名" preferredStyle:UIAlertControllerStyleAlert];
//        [alertCon addAction: [UIAlertAction actionWithTitle: @"确认" style: UIAlertActionStyleCancel handler:nil]];
//        [self presentViewController: alertCon animated: YES completion: nil];
//        
//        
//        NSString *CM_NUM = @"^[A-Za-z0-9]+$";
//        
//        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
//        
//        BOOL isMatch1 = [pred1 evaluateWithObject:self.userNameTF.text];
//        
//        if (self.userNameTF.text.length < 4) {
//            
//            alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入4位以上用户名" preferredStyle:UIAlertControllerStyleAlert];
//            [alertCon addAction: [UIAlertAction actionWithTitle: @"确认" style: UIAlertActionStyleCancel handler:nil]];
//            [self presentViewController: alertCon animated: YES completion: nil];
//            
//            
//            if (isMatch1) {
//                
//                alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"用户名只能是字母或数字" preferredStyle:UIAlertControllerStyleAlert];
//                [alertCon addAction: [UIAlertAction actionWithTitle: @"确认" style: UIAlertActionStyleCancel handler:nil]];
//                [self presentViewController: alertCon animated: YES completion: nil];
//            }
//        }
//        
//        
//        
//        
//    }else if(self.userMessageTF.text.length == 0){
//        
//        alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入验证码" preferredStyle:UIAlertControllerStyleAlert];
//        [alertCon addAction: [UIAlertAction actionWithTitle: @"确认" style: UIAlertActionStyleCancel handler:nil]];
//        [self presentViewController: alertCon animated: YES completion: nil];
//        
//    }
//    else if (self.userPassWordTF.text.length == 0) {
//        alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入密码" preferredStyle:UIAlertControllerStyleAlert];
//        [alertCon addAction: [UIAlertAction actionWithTitle: @"确认" style: UIAlertActionStyleCancel handler:nil]];
//        [self presentViewController: alertCon animated: YES completion: nil];
//        
//    }else if(self.againUserPassWordTF.text.length == 0){
//        
//        alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"请再次输入密码" preferredStyle:UIAlertControllerStyleAlert];
//        [alertCon addAction: [UIAlertAction actionWithTitle: @"确认" style: UIAlertActionStyleCancel handler:nil]];
//        [self presentViewController: alertCon animated: YES completion: nil];
//        
//    }
//    else{
//        
//        if (![self.userMessageTF.text isEqualToString:strCode]) {
//            
//            alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"验证码输入不正确" preferredStyle:UIAlertControllerStyleAlert];
//            [alertCon addAction: [UIAlertAction actionWithTitle: @"确认" style: UIAlertActionStyleCancel handler:nil]];
//            [self presentViewController: alertCon animated: YES completion: nil];
//            
//            
//            
//        }else if([self.userPassWordTF.text rangeOfString:@" "].location != NSNotFound){
//            
//            alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"密码不能包含空格" preferredStyle:UIAlertControllerStyleAlert];
//            [alertCon addAction: [UIAlertAction actionWithTitle: @"确认" style: UIAlertActionStyleCancel handler:nil]];
//            [self presentViewController: alertCon animated: YES completion: nil];
//            
//        }
//        else if(self.againUserPassWordTF.text.length < 6 ){
//            alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"密码长度不得少于6个字符" preferredStyle:UIAlertControllerStyleAlert];
//            [alertCon addAction: [UIAlertAction actionWithTitle: @"确认" style: UIAlertActionStyleCancel handler:nil]];
//            [self presentViewController: alertCon animated: YES completion: nil];
//            
//            
//        }else if([self.againUserPassWordTF.text rangeOfString:@" "].location != NSNotFound){
//            
//            alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"密码不能包含空格" preferredStyle:UIAlertControllerStyleAlert];
//            [alertCon addAction: [UIAlertAction actionWithTitle: @"确认" style: UIAlertActionStyleCancel handler:nil]];
//            [self presentViewController: alertCon animated: YES completion: nil];
//            
//            
//            
//        }else if (self.userPassWordTF.text.length < 6){
//            
//            alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"密码长度密码长度需6~16" preferredStyle:UIAlertControllerStyleAlert];
//            [alertCon addAction: [UIAlertAction actionWithTitle: @"确认" style: UIAlertActionStyleCancel handler:nil]];
//            [self presentViewController: alertCon animated: YES completion: nil];
//            
//            
//            
//        }else if (![self.userPassWordTF.text isEqualToString:self.againUserPassWordTF.text]){
//            
//            alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"两次输入密码不一致" preferredStyle:UIAlertControllerStyleAlert];
//            [alertCon addAction: [UIAlertAction actionWithTitle: @"确认" style: UIAlertActionStyleCancel handler:nil]];
//            [self presentViewController: alertCon animated: YES completion: nil];
//            
//        }else if (isAgree != YES){
//            
//            alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"请同意用户协议" preferredStyle:UIAlertControllerStyleAlert];
//            [alertCon addAction: [UIAlertAction actionWithTitle: @"确认" style: UIAlertActionStyleCancel handler:nil]];
//            [self presentViewController: alertCon animated: YES completion: nil];
//            
//        }
//        else{
//            [self checkBtnClick];
//        }
//        
//    }

}

#pragma mark - UITextFieldDelegate

//-(void)textFieldDidBeginEditing:(UITextField *)textField
//{
//    UITextField *YanZhenTF=(UITextField *)[self.view viewWithTag:100];
//    UITextField *TuiGuangTF=(UITextField *)[self.view viewWithTag:200];
//    if (YanZhenTF == textField) {
//        NSLog(@"=%@",YanZhenTF);
//    }else if (TuiGuangTF == textField){
//        NSLog(@"=%@",TuiGuangTF);
//    }
////    tempTextField=textField;
//}
//
//
//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
//    
//    if (textField == self.userNameTF) {
//        
//        if (range.location + range.length >= textField.text.length) {
//            return NO;
//        }
//        
//        NSUInteger length = textField.text.length + string.length - range.length;
//        return length <= 16;
//        
//    }else if (textField == self.userPassWordTF) {
//        
//        if (range.location + range.length >= textField.text.length) {
//            return NO;
//        }
//        
//        NSUInteger length = textField.text.length + string.length - range.length;
//        return length <= 16;
//        
//    }else if (textField == self.againUserPassWordTF) {
//        
//        if (range.location + range.length >= textField.text.length) {
//            return NO;
//        }
//        
//        NSUInteger length = textField.text.length + string.length - range.length;
//        return length <= 16;
//        
//    }else if (textField == self.userPhoneTF) {
//        
//        if (range.location + range.length >= textField.text.length) {
//            return NO;
//        }
//        
//        NSUInteger length = textField.text.length + string.length - range.length;
//        return length <= 11;
//    
//    }else{
//        
//       return YES;
//    }
//    
//}
//
//- (void)textFieldDidChange:(UITextField *)textField
//{
//    if (textField == self.userPassWordTF)
//    {
//        if (textField.text.length > 16) {
//            
//            textField.text = [textField.text substringToIndex:16];
//        }
//    }
//    
//}


- (void)strTimer:(NSTimer *)time{
    
    [buttonCover setTitle:[NSString stringWithFormat:@"%d秒重新获取",i] forState:UIControlStateNormal];
    
    i --;
    
    if (i == 0) {
        [timer invalidate];
        timer = nil;
        
        [buttonCover removeFromSuperview];
        
    }
    
    
}


- (void)viewDidAppear:(BOOL)animated{
    [timer invalidate];
    timer = nil;
    
    [buttonCover removeFromSuperview];
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

- (void)checkBtnClick{
    
    
    myProgressHum = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [myProgressHum hide:YES afterDelay:30.0];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    NSString *urlStr = URL_Str;
    
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 30.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    
    NSString *strUser = self.userNameTF.text;
    NSString *strPassword = self.againUserPassWordTF.text;
    
    NSString *strMYID = [NSString stringWithFormat:@"%@",MYID];
    
    NSDictionary *dic = @{@"username":strUser,@"password":strPassword,@"imei":strMYID,@"tg_sigen":self.userTGTF.text,@"phone":self.userPhoneTF.text};
    
    NSString *url = [NSString stringWithFormat:@"%@registered_mob.shtml",URL_Str];
    [manager POST:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
        NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];
        
        
        
        if (codeKey && content) {
            NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
            
            
            
            NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            NSLog(@"=====注册===%@",dic);
            
            view.hidden=YES;
            for (NSDictionary *dic1 in dic) {
                
                MallModel *model = [[MallModel alloc] init];
                model.id_ = dic1[@"userid"];
                model.sigen_ = dic1[@"sigen"];
                
                
                NSString *message=dic1[@"message"];
                
                [_registerArray addObject:model];
                
                if ([dic1[@"status"] isEqualToString:@"10000"]) {
                    
                    [JRToast showWithText:@"注册成功!" duration:0.5f];
                    
                    //实现反向传值
                    if (_delegate && [_delegate respondsToSelector:@selector(setUserName:andPassWord:)]) {
                        [_delegate setUserName:self.userNameTF.text andPassWord:self.userPassWordTF.text];
                    }
                    
                    [self.navigationController popViewControllerAnimated:YES];
//                    NewLoginViewController *loginVC=[[NewLoginViewController alloc] init];
//                    
//                    
//                    loginVC.backString=@"1";
//                    
//                    [self.navigationController pushViewController:loginVC animated:YES];
                    
                    
                }else if ([dic1[@"status"] isEqualToString:@"10001"]){
                    alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
                    [alertCon addAction: [UIAlertAction actionWithTitle: @"确认" style: UIAlertActionStyleCancel handler:nil]];
                    [self presentViewController: alertCon animated: YES completion: nil];
                    
                    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                    
                    
                }else if ([dic1[@"status"] isEqualToString:@"10002"]){
                    
                    alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
                    [alertCon addAction: [UIAlertAction actionWithTitle: @"确认" style: UIAlertActionStyleCancel handler:nil]];
                    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                    [self presentViewController: alertCon animated: YES completion: nil];
                    
                    
                    
                }else if ([dic1[@"status"] isEqualToString:@"10003"]){
                    
                    alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
                    [alertCon addAction: [UIAlertAction actionWithTitle: @"确认" style: UIAlertActionStyleCancel handler:nil]];
                    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                    [self presentViewController: alertCon animated: YES completion: nil];
                    
                    
                }
                else if ([dic1[@"status"] isEqualToString:@"10005"]){
                    
                    alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
                    [alertCon addAction: [UIAlertAction actionWithTitle: @"确认" style: UIAlertActionStyleCancel handler:nil]];
                    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                    [self presentViewController: alertCon animated: YES completion: nil];
                    
                    
                }else {
                    
                    alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
                    [alertCon addAction: [UIAlertAction actionWithTitle: @"确认" style: UIAlertActionStyleCancel handler:nil]];
                    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                    [self presentViewController: alertCon animated: YES completion: nil];
                    
                }
                
            }
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"PostDepartment Error %@",error);
        
//        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
//        alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"服务器连接失败! 请检查网络链接或联系客服" preferredStyle:UIAlertControllerStyleAlert];
//        [alertCon addAction: [UIAlertAction actionWithTitle: @"确认" style: UIAlertActionStyleCancel handler:nil]];
//        [self presentViewController: alertCon animated: YES completion: nil];
        
        [self NoWebSeveice];
        
    }];
    
}

-(void)loadData{
    
//    [self getDatas];
    
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    
    [self.userNameTF resignFirstResponder];
    [self.userPassWordTF resignFirstResponder];
    [self.againUserPassWordTF resignFirstResponder];
    [self.userMessageTF resignFirstResponder];
    [self.userTGTF resignFirstResponder];
    [self.userPhoneTF resignFirstResponder];
    
    
}


//NSNotification:  消息的类
/*
 name, object, userInfo
 */
- (void)keyboardWillShow:(NSNotification *)notification andTextField:(UITextField *)textField
{
        NSLog(@"---%@", notification);
    
        //获得键盘的高度
        CGRect rect =  [notification.userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
        
        //CGRectValue, 将字符串---> 结构体
        //将结构体转换为字符串
        //NSStringFromCGRect(<#CGRect rect#>)
        
        CGFloat height = rect.size.height;
        
        //将self.view 的y坐标-height
        CGRect frame = self.view.frame;
        if (frame.origin.y == 0) {
            frame.origin.y = frame.origin.y - height;
            self.view.frame = frame;
        }
    
}

//当键盘掉下的时候， 会调用这个方法
- (void)keyboardWiilHide:(NSNotification *)notification andTextField:(UITextField *)textField
{
    
    CGRect rect = [notification.userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    
    CGFloat height = rect.size.height;
    
    CGRect frame = self.view.frame;
    
    if (frame.origin.y < 0) {
        frame.origin.y = frame.origin.y + height;
        self.view.frame = frame;
    }
    
}


//- (BOOL)textFieldShouldReturn:(UITextField *)textField {
//    
//    [textField resignFirstResponder];
//    return YES;
//    
//}

//键盘显示事件
- (void) keyboardWillShow:(NSNotification *)notification andOtherTextField:(UITextField *)textField{
//    NSLog(@"kkkkkk%@",TextFi",eld.text);
    
//    NSLog(@"=======&&&&7==%ld",textField.tag);
    
    
    NSLog(@"kkkkkk==%@",notification.userInfo );
    
    //获取键盘高度，在不同设备上，以及中英文下是不同的
    CGFloat kbHeight = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    
    //计算出键盘顶端到inputTextView panel底端的距离(加上自定义的缓冲距离INTERVAL_KEYBOARD)
    CGFloat offset = (self.view.frame.origin.y+self.view.frame.size.height) - (self.view.frame.size.height - kbHeight);
    
    // 取得键盘的动画时间，这样可以在视图上移的时候更连贯
    double duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    

        if(offset > 0) {
        [UIView animateWithDuration:duration animations:^{
            self.view.frame = CGRectMake(0.0f, -64, self.view.frame.size.width, self.view.frame.size.height);
        }];
    }


    
    }

///键盘消失事件
- (void) keyboardWillHide:(NSNotification *)notify {
    // 键盘动画时间
    double duration = [[notify.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    //视图下沉恢复原状
    [UIView animateWithDuration:duration animations:^{
        self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    }];
    
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}


-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
   NSLog(@"++++++%ld",textField.tag);
//    if (textField.tag==200) {
    
        
//    }else{
//        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
//        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
//    
//    }
    
    
}
//-(void)textFieldDidEndEditing:(UITextField *)textField{
// if (textField.tag!=200) {
//     [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
//     [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
//    }
//    
//    
//    
//}
@end
