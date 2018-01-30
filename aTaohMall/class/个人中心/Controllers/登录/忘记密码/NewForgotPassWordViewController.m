//
//  NewForgotPassWordViewController.m
//  aTaohMall
//
//  Created by JMSHT on 16/5/14.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import "NewForgotPassWordViewController.h"

#import "AgainPassWordViewController.h"//重设密码
#import "ZZLimitInputManager.h"

#import "WKProgressHUD.h"
@interface NewForgotPassWordViewController ()<UITextFieldDelegate>
{
    NSMutableArray *_forgotArray;
    NSString *strCode;
    UIButton *backBtn;
    NSTimer *timer;
    int i;
    UIButton *buttonCover;  //验证码倒计时
    
    UIAlertController *alertCon;
    
    MBProgressHUD *myProgressHum;
    
    UIView *view;
   // BOOL YanZhen;
}
@property (nonatomic,assign)BOOL YanZhen;

@end

@implementation NewForgotPassWordViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    i=299;
    
    self.PhoneNumberTF.keyboardType = UIKeyboardTypeNumberPad;
    self.YanZhenTF.keyboardType = UIKeyboardTypeNumberPad;
    self.PhoneNumberTF.delegate = self;
    self.YanZhenTF.delegate = self;

    [self.UserNameTextField addTarget:self action:@selector(textFiledDidChangedText:) forControlEvents:UIControlEventEditingChanged];
    [self.PhoneNumberTF addTarget:self action:@selector(textFiledDidChangedText:) forControlEvents:UIControlEventEditingChanged];
    [self.YanZhenTF addTarget:self action:@selector(textFiledDidChangedText:) forControlEvents:UIControlEventEditingChanged];
    [self.sureBut.layer setCornerRadius:5];
    self.sureBut.enabled=NO;
    self.sureBut.backgroundColor=RGB(255, 156, 159);
    self.clearBut.hidden=YES;

    self.YanZhenButton.enabled=NO;

    [self.YanZhenButton setBackgroundColor:RGB(225, 225, 225)];

    _forgotArray = [NSMutableArray array];
    
    //获取用户名
    [ZZLimitInputManager limitInputView:self.UserNameTextField maxLength:16];

    //获取手机号
    [ZZLimitInputManager limitInputView:self.PhoneNumberTF maxLength:11];

    //短信验证码
    [ZZLimitInputManager limitInputView:self.YanZhenTF maxLength:6];
}

-(void)textFiledDidChangedText:(UITextField *)TF
{
    if (TF==self.PhoneNumberTF) {
        if (TF.text.length>0) {
            self.clearBut.hidden=NO;
        }else
        {
            self.clearBut.hidden=YES;
        }
    }

    if (self.PhoneNumberTF.text.length>0&&self.UserNameTextField.text.length>0) {

        self.YanZhenButton.enabled=YES;
        self.YanZhenButton.backgroundColor=RGB(243, 73, 73);
        if (_YanZhenTF.text.length>0&&_YanZhen) {
            self.sureBut.enabled=YES;
            self.sureBut.backgroundColor=RGB(243, 73, 73);
        }else {
            self.sureBut.enabled=NO;
            self.sureBut.backgroundColor=RGB(255, 156, 159);
        }
    }else
    {
        self.YanZhenButton.enabled=NO;
        self.YanZhenButton.backgroundColor=RGB(225, 225, 225);
    }

}

-(void)setYanZhen:(BOOL)YanZhen
{
    _YanZhen=YanZhen;
    if (YanZhen&&self.PhoneNumberTF.text.length>0&&self.UserNameTextField.text.length>0&&self.YanZhenTF.text.length>0) {
        self.sureBut.enabled=YES;
        self.sureBut.backgroundColor=RGB(243, 73, 73);
    }else
    {
        self.YanZhenButton.enabled=NO;
        self.YanZhenButton.backgroundColor=RGB(225, 225, 225);
    }
}
//获取验证码
- (IBAction)getNumberBtnClick:(UIButton *)sender {
    
    
    if (self.PhoneNumberTF.text.length == 0) {
        [TrainToast showWithText:@"用户名或手机号码不匹配，请重新输入" duration:2.0];
    }else{
        
        if (self.PhoneNumberTF.text.length < 11) {
            [TrainToast showWithText:@"用户名或手机号码不匹配，请重新输入" duration:2.0];

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
            BOOL isMatch1 = [pred1 evaluateWithObject:self.PhoneNumberTF.text];
            NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
            BOOL isMatch2 = [pred2 evaluateWithObject:self.PhoneNumberTF.text];
            NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
            
            BOOL isMatch3 = [pred3 evaluateWithObject:self.PhoneNumberTF.text];
            
            if (!(isMatch1 || isMatch2 || isMatch3)) {
                [TrainToast showWithText:@"用户名或手机号码不匹配，请重新输入" duration:2.0];
            }else{
                //获取验证码
                [self getDatas];
            }
        }
    }
    

}


-(void)getDatas
{
    
    myProgressHum = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [myProgressHum hide:YES afterDelay:30.0];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //        NSString *urlStr = TestHttp;
    
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 30.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    
    NSLog(@"===self.PhoneNumberTF.text===%@",self.PhoneNumberTF.text);
    NSLog(@"===self.UserNameTextField.text===%@",self.UserNameTextField.text);
    
    NSDictionary *dic = @{@"phone":self.PhoneNumberTF.text,@"username":self.UserNameTextField.text};
    
    NSString *url = [NSString stringWithFormat:@"%@getVerificationCode_mob.shtml",URL_Str];
 //   self.YanZhen=NO;
    [manager POST:url parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
        NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];
        
        
        
        
        if (codeKey && content) {
            NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
            
            //NSLog(@"xmlStr==%@",xmlStr);
            
            
            NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];
            
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            
           // view.hidden=YES;

            NSLog(@"%@",dic);
            
            for (NSDictionary *dic1 in dic) {
                
                
                MallModel *model = [[MallModel alloc] init];
                model.id_ = dic1[@"userid"];
                model.sigen_ = dic1[@"sigen"];
                model.code_=dic1[@"code"];

                [_forgotArray addObject:model];
             [TrainToast showWithText:dic1[@"message"]  duration:2.0];
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                if ([dic1[@"status"] isEqualToString:@"10000"]) {

                    view.hidden=YES;
                    buttonCover = [UIButton buttonWithType:UIButtonTypeCustom];
                    buttonCover.frame = self.YanZhenButton.frame;
                    buttonCover.backgroundColor = [UIColor colorWithRed:225/255.0 green:225/255.0 blue:225/255.0 alpha:1];
                    [buttonCover setTitle:@"重新获取300(s)" forState:UIControlStateNormal];
                    buttonCover.titleLabel.font = [UIFont systemFontOfSize:12.0];
                    [self.view addSubview:buttonCover];

                    i = 300;

                    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(strTimer:) userInfo:nil repeats:YES];
                    strCode=model.code_;
                    self.YanZhen=YES;
                }
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [TrainToast showWithText:@"系统繁忙，请稍后再试" duration:2.0];
        NSLog(@"PostDepartment Error %@",error);
    }];

}


//确定
- (IBAction)OkBtnClick:(UIButton *)sender {


    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];

    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //        NSString *urlStr = TestHttp;

    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 30.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];

    NSLog(@"===self.PhoneNumberTF.text===%@",self.PhoneNumberTF.text);
    NSLog(@"===self.UserNameTextField.text===%@",self.UserNameTextField.text);

    MallModel *model=_forgotArray.lastObject;

    NSDictionary *dic = @{@"sigen":model.sigen_?model.sigen_:@"",@"code":self.YanZhenTF.text,@"username":self.UserNameTextField.text,@"phone":self.PhoneNumberTF.text};
//    String username = request.getParameter("username");
//    //手机号
//    String phone = request.getParameter("phone");
//    String code = request.getParameter("code");
    NSString *url = [NSString stringWithFormat:@"%@validationCodeIsEffective_mob.shtml",URL_Str];
    WKProgressHUD *hud=[WKProgressHUD showInView:self.view withText:@"" animated:YES];
    [manager POST:url parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {



    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
        NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];

        if (codeKey && content) {
            NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];

            //NSLog(@"xmlStr==%@",xmlStr);


            NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];


            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];

            view.hidden=YES;

            NSLog(@"%@",dic);

            if ([dic[@"status"] isEqualToString:@"10000"]) {
                AgainPassWordViewController *agVC=[[AgainPassWordViewController alloc] init];
                MallModel *model=_forgotArray.lastObject;
                agVC.sigens = model.sigen_;

                agVC.userName=self.UserNameTextField.text;

                [self.navigationController pushViewController:agVC animated:YES];

            }else
            {

                [TrainToast showWithText:dic[@"message"] duration:2.0];

            }


        }
        [hud dismiss:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
[hud dismiss:YES];
         [TrainToast showWithText:@"系统繁忙，请稍后再试" duration:2.0];

    }];
    


}

//返回
- (IBAction)backBtnClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)strTimer:(NSTimer *)time{
    
    
    [buttonCover setTitle:[NSString stringWithFormat:@"重新获取%d(s)",i] forState:UIControlStateNormal];
    
    i --;
    
    if (i == 0) {
        [timer invalidate];
        timer = nil;
        [self.YanZhenButton setTitle:@"重新获取" forState:UIControlStateNormal];
        [buttonCover removeFromSuperview];
        
    }
    
    
}

- (void)viewDidAppear:(BOOL)animated{
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    
    [self.PhoneNumberTF resignFirstResponder];
    [self.YanZhenTF resignFirstResponder];
    [self.UserNameTextField resignFirstResponder];
    
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
