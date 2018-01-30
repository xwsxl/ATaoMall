//
//  AgainPassWordViewController.m
//  aTaohMall
//
//  Created by JMSHT on 16/5/19.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import "AgainPassWordViewController.h"

#import "ChangeFailureViewController.h"//修改失败

#import "ChangeSuccessViewController.h"//修改成功

#import "ZZLimitInputManager.h"

#import "UserMessageManager.h"

#import "ATHLoginViewController.h"
@interface AgainPassWordViewController ()<UITextFieldDelegate>
{
    
    MBProgressHUD *myProgressHum;
    
    UIAlertController *alertCon;
    
    UIView *view;
    
}
@end

@implementation AgainPassWordViewController
- (IBAction)PassWordButClick:(id)sender {
    self.PassWordBut.selected=!_PassWordBut.selected;
    if (_PassWordBut.selected) {
        [_PassWordBut setBackgroundImage:KImage(@"睁眼") forState:UIControlStateNormal];
        self.PassWordTF.secureTextEntry=NO;
    }else
    {
        [_PassWordBut setBackgroundImage:KImage(@"闭眼") forState:UIControlStateNormal];
        self.PassWordTF.secureTextEntry=YES;

    }
}
- (IBAction)AgainPassWordButClick:(id)sender {
    self.AgainPassWordBut.selected=!_AgainPassWordBut.selected;
    if (_AgainPassWordBut.selected) {
        [_AgainPassWordBut setBackgroundImage:KImage(@"睁眼") forState:UIControlStateNormal];
        self.AgainPassWord.secureTextEntry=NO;
    }else
    {
        [_AgainPassWordBut setBackgroundImage:KImage(@"闭眼") forState:UIControlStateNormal];
        self.AgainPassWord.secureTextEntry=YES;

    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.


    self.sureBut.layer.cornerRadius=5;
    self.sureBut.enabled=NO;
    self.sureBut.backgroundColor=RGB(255, 156, 159);

    
    [self.PassWordTF addTarget:self action:@selector(textFiledDidChangedText:) forControlEvents:UIControlEventEditingChanged];
    [self.AgainPassWord addTarget:self action:@selector(textFiledDidChangedText:) forControlEvents:UIControlEventEditingChanged];


    //新密码
    [ZZLimitInputManager limitInputView:self.PassWordTF maxLength:16];
    
    //再次输入
    [ZZLimitInputManager limitInputView:self.AgainPassWord maxLength:16];
    
    NSLog(@"=======%@",self.userName);
    
}
-(void)textFiledDidChangedText:(UITextField *)TF
{
    if ([TF.text containsString:@" "]) {
       TF.text= [TF.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    }

    if (self.PassWordTF.text.length>0&&self.AgainPassWord.text.length>0) {
        self.sureBut.enabled=YES;
        self.sureBut.backgroundColor=RGB(255, 73, 73);
    }else
    {
        self.sureBut.enabled=NO;
        self.sureBut.backgroundColor=RGB(255, 156, 159);
    }

}

-(void)setPassword
{
    myProgressHum = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [myProgressHum hide:YES afterDelay:30.0];

        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];

        manager.responseSerializer = [AFHTTPResponseSerializer serializer];

        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = 30.f;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];

        NSString *strNewPassAgain = [NSString stringWithFormat:@"%@",self.AgainPassWord.text];
        NSDictionary *dic = @{@"sigen":self.sigens,@"password":strNewPassAgain};

        NSString *url = [NSString stringWithFormat:@"%@resetPassword_mob.shtml",URL_Str];

        [manager POST:url parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {

        } success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
            NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];

            if (codeKey && content) {
                NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
                xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
                xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];

                NSLog(@"xmlStr%@",xmlStr);

                NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];

                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                for (NSDictionary *dic1 in dic) {

                    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                    [TrainToast showWithText:dic1[@"message"] duration:3.0];
                    if ([dic1[@"status"] isEqualToString:@"10000"]) {
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            for (UIViewController *vc in self.navigationController.viewControllers) {
                                if ([vc isKindOfClass:[ATHLoginViewController class]]) {
                                    [self.navigationController popToViewController:vc animated:YES];
                                }
                            }
                        });

                    }
                }
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [TrainToast showWithText:@"您的账户密码设置失败，请重新设置" duration:2.0];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.PassWordTF setText:@""];
                [self.AgainPassWord setText:@""];
            });
            NSLog(@"PostDepartment Error %@",error);
        }];

}
//提交
- (IBAction)CommitBtnClick:(UIButton *)sender {

    if (![self.PassWordTF.text isEqualToString:self.AgainPassWord.text]) {
        [TrainToast showWithText:@"两次输入的密码不一致，请重新输入" duration:2.0];
    }else
    {
        BOOL result = false;

        // 判断长度大于8位后再接着判断是否同时包含数字和字符
        NSString * regex= @"^(?=.*[a-zA-Z0-9].*)(?=.*[a-zA-Z\\W].*)(?=.*[0-9\\W].*).{6,20}$";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        result = [pred evaluateWithObject:self.PassWordTF.text];

        if (result) {
            [self setPassword];
        }else
        {
            [TrainToast showWithText:@"6-16个字符，由字母、数字和符号的两种以上组合" duration:2.0];
        }
    }
}

//返回
- (IBAction)backBtnClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    
    [self.PassWordTF resignFirstResponder];
    [self.AgainPassWord resignFirstResponder];
    
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return YES;
    
}

@end
