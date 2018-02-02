//
//  YTNextViewController.m
//  aTaohMall
//
//  Created by JMSHT on 2016/10/8.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import "YTNextViewController.h"

#import "NewLoginViewController.h"

#import "XieYiViewController.h"
#import "ZZLimitInputManager.h"
#import "AFNetworking.h"

//加密
#import "ConverUtil.h"
#import "DESUtil.h"
#import "SecretCodeTool.h"

#import "MallModel.h"

#import "JRToast.h"

#import "UserMessageManager.h"

#import "WKProgressHUD.h"

#import "NewHomeViewController.h"//首页

#import "ClassifyViewController.h"//分类

#import "MerchantViewController.h"//商户

#import "CartViewController.h"

#import "PersonaViewController.h"
@interface YTNextViewController ()<UIAlertViewDelegate,UITextViewDelegate,UIGestureRecognizerDelegate>
{
    
    UIAlertController *alertCon;
    
    NSMutableArray *_registerArray;
    NSString *strCode;
    
    UIButton *backBtn;
    UIView *view;
    MBProgressHUD *myProgressHum; //进度条
    
    NSTimer *timer;   //验证码时间
    
    
    NSTimer *timer1;   //验证码时间
    int i;
    int YT;
    
    UIButton *buttonCover;
    
    BOOL isAgree;
    BOOL isCorrect;
    
    UITextField *tempTextField;//全局UITextfiled指针
}
@property (assign, nonatomic) BOOL isSelect;

@end

@implementation YTNextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    YT=10;
    
    [ZZLimitInputManager limitInputView:self.YTUserNameTF maxLength:11];
    
    [ZZLimitInputManager limitInputView:self.YTUserMessageTF maxLength:6];
    
//    [self protocolIsSelect:self.isSelect];
    
    [self.MessageButton setTitle:@"获取验证码" forState:0];
    
    self.YTTextView.hidden=YES;
    
    NSString *string = @"注册即表示您同意《积分商城客户协议书》";
    
    NSString *stringForColor = @"《积分商城客户协议书》";
    // 创建对象.
    NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:string];
    //
    NSRange range = [string rangeOfString:stringForColor];
    
    [mAttStri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0] range:range];
    
    _XieYiLabel.attributedText=mAttStri;
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(GoToXieYi:)];
    tap.delegate=self;
    tap.numberOfTapsRequired=1;
    
    _XieYiLabel.userInteractionEnabled=YES;
    
    [_XieYiLabel addGestureRecognizer:tap];
    
}


-(void)GoToXieYi:(UITapGestureRecognizer *)Gr
{
    
    NSLog(@"=========");
    
    XieYiViewController *vc=[[XieYiViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:NO];
    
    self.navigationController.navigationBar.hidden=YES;
    
    
}
//返回
- (IBAction)backBtnClick:(UIButton *)sender {
    
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"完成手机验证即可完成注册，确定离开吗" message:nil delegate:self cancelButtonTitle:@"继续注册" otherButtonTitles:@"返回", nil];
    
    [alert show];
    
};



-(void)NoWebSeveice
{
    
    view=[[UIView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    
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


//获取验证码
- (IBAction)getMessageBtnCLick:(UIButton *)sender {
    
    if (self.YTUserNameTF.text.length == 0) {
        
//        alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入正确的手机号码" preferredStyle:UIAlertControllerStyleAlert];
//        [alertCon addAction: [UIAlertAction actionWithTitle: @"确认" style: UIAlertActionStyleCancel handler:nil]];
//        [self presentViewController: alertCon animated: YES completion: nil];
        
        [JRToast showWithText:@"请输入正确的手机号码" duration:3.0f];
        
    }else{
        if (self.YTUserNameTF.text.length < 11 ) {
            
//            alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入正确的手机号码" preferredStyle:UIAlertControllerStyleAlert];
//            [alertCon addAction: [UIAlertAction actionWithTitle: @"确认" style: UIAlertActionStyleCancel handler:nil]];
//            [self presentViewController: alertCon animated: YES completion: nil];
            
            [JRToast showWithText:@"请输入正确的手机号码" duration:3.0f];
            
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
            BOOL isMatch1 = [pred1 evaluateWithObject:self.YTUserNameTF.text];
            NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
            BOOL isMatch2 = [pred2 evaluateWithObject:self.YTUserNameTF.text];
            NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
            
            BOOL isMatch3 = [pred3 evaluateWithObject:self.YTUserNameTF.text];
            
            if (!(isMatch1 || isMatch2 || isMatch3)) {
                
//                alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入正确的手机号码" preferredStyle:UIAlertControllerStyleAlert];
//                [alertCon addAction: [UIAlertAction actionWithTitle: @"确认" style: UIAlertActionStyleCancel handler:nil]];
//                [self presentViewController: alertCon animated: YES completion: nil];
                
                [JRToast showWithText:@"请输入正确的手机号码" duration:3.0f];
                
            }else{
                
                AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
                
                manager.responseSerializer = [AFHTTPResponseSerializer serializer];
                
                
                NSDictionary *dic = @{@"phone":self.YTUserNameTF.text};
                
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
                                
                                buttonCover.frame = self.MessageButton.frame;
                                buttonCover.backgroundColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153/255.0 alpha:1];
                                [buttonCover setTitle:@"60秒重新获取" forState:UIControlStateNormal];
                                buttonCover.titleLabel.font = [UIFont systemFontOfSize:12.0];
                                [self.YTView addSubview:buttonCover];
                                
                                i = 59;
                                YT=299;
                                
                                strCode = model.code_;
                                
                                
                                timer1 = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(strTimer1:) userInfo:nil repeats:YES];
                                
                                timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(strTimer:) userInfo:nil repeats:YES];
                                
                                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                                
                            }else {
                                
//                                alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:dic1[@"message"] preferredStyle:UIAlertControllerStyleAlert];
//                                [alertCon addAction: [UIAlertAction actionWithTitle: @"确认" style: UIAlertActionStyleCancel handler:nil]];
//                                [self presentViewController: alertCon animated: YES completion: nil];
                                
                                [JRToast showWithText:dic1[@"message"] duration:3.0f];
                                
                                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                                
                            }
                            
                        }
                        
                    }
                    
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    
//                    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
//                    
//                    alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"服务器连接失败! 请检查网络链接或联系客服" preferredStyle:UIAlertControllerStyleAlert];
//                    [alertCon addAction: [UIAlertAction actionWithTitle: @"确认" style: UIAlertActionStyleCancel handler:nil]];
//                    [self presentViewController: alertCon animated: YES completion: nil];
                    [self NoWebSeveice];
                    NSLog(@"PostDepartment Error %@",error);
                }];
            }
        }
    }
}

-(void)loadData
{
    
    WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
    
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        [hud dismiss:YES];
    });
    
//    [self NoWebSeveice];
    [self checkBtnClick];
}

//注册
- (IBAction)ZhuCeBtnClick:(UIButton *)sender {
    
    if (self.YTUserNameTF.text.length == 0) {
        
//        alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入正确的手机号码" preferredStyle:UIAlertControllerStyleAlert];
//        [alertCon addAction: [UIAlertAction actionWithTitle: @"确认" style: UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//            
            [self.YTUserNameTF becomeFirstResponder];
//            
//        }]];
//        [self presentViewController: alertCon animated: YES completion: nil];
        [JRToast showWithText:@"请输入正确的手机号码" duration:3.0f];
        
    }else{
        if (self.YTUserNameTF.text.length < 11 ) {
            
//            alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入正确的手机号码" preferredStyle:UIAlertControllerStyleAlert];
//            [alertCon addAction: [UIAlertAction actionWithTitle: @"确认" style: UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//                
                [self.YTUserNameTF becomeFirstResponder];
//                
//            }]];
//            [self presentViewController: alertCon animated: YES completion: nil];
            
            [JRToast showWithText:@"请输入正确的手机号码" duration:3.0f];
            
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
            BOOL isMatch1 = [pred1 evaluateWithObject:self.YTUserNameTF.text];
            NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
            BOOL isMatch2 = [pred2 evaluateWithObject:self.YTUserNameTF.text];
            NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
            
            BOOL isMatch3 = [pred3 evaluateWithObject:self.YTUserNameTF.text];
            
            if (!(isMatch1 || isMatch2 || isMatch3)) {
                
//                alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入正确的手机号码" preferredStyle:UIAlertControllerStyleAlert];
//                [alertCon addAction: [UIAlertAction actionWithTitle: @"确认" style: UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//                    
                    [self.YTUserNameTF becomeFirstResponder];
//                    
//                }]];
//                [self presentViewController: alertCon animated: YES completion: nil];
                
                 [JRToast showWithText:@"请输入正确的手机号码" duration:3.0f];
                
                
            }else{
                
                
                if (self.YTUserMessageTF.text.length==0) {
                    
//                    alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"验证码输入错误" preferredStyle:UIAlertControllerStyleAlert];
//                    [alertCon addAction: [UIAlertAction actionWithTitle: @"确认" style: UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//                        
                        [self.YTUserMessageTF becomeFirstResponder];
//                        
//                    }]];
//                    [self presentViewController: alertCon animated: YES completion: nil];
                    
                     [JRToast showWithText:@"验证码输入错误" duration:3.0f];
                    
                }else{
                    
                    if (![self.YTUserMessageTF.text isEqualToString:self.code]) {
                        
//                        alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"验证码输入错误" preferredStyle:UIAlertControllerStyleAlert];
//                        [alertCon addAction: [UIAlertAction actionWithTitle: @"确认" style: UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//                            
                            [self.YTUserMessageTF becomeFirstResponder];
//                            
//                        }]];
//                        [self presentViewController: alertCon animated: YES completion: nil];
                        
                         [JRToast showWithText:@"验证码输入错误" duration:3.0f];
                        
                    }else{
                        
                        
                        NSLog(@"====+=%d",YT);
                        if (YT==0) {
                            
//                            alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"验证码失效" preferredStyle:UIAlertControllerStyleAlert];
//                            [alertCon addAction: [UIAlertAction actionWithTitle: @"确认" style: UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//                                
                                [self.YTUserMessageTF becomeFirstResponder];
//                                
//                            }]];
//                            [self presentViewController: alertCon animated: YES completion: nil];
                            
                            [JRToast showWithText:@"验证码失效" duration:3.0f];
                            
                            
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


- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange {
    
    
    if ([[URL scheme] isEqualToString:@"zhifubao"]) {
        
        //4008-119-7898
            NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",@"4008-119-789"];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"sms://4008-119-7898"]];
        
        
                 return NO;
             }
    return YES;
}

- (void)strTimer:(NSTimer *)time{
    
    [buttonCover setTitle:[NSString stringWithFormat:@"%d秒重新获取",i] forState:UIControlStateNormal];
    
    i --;
    
//    YT--;
    
    if (i == 0) {
        [timer invalidate];
        timer = nil;
        
        
        [buttonCover removeFromSuperview];
        
        [self.MessageButton setTitle:@"重新获取验证码" forState:0];
        self.MessageButton.titleLabel.font=[UIFont systemFontOfSize:15];
        [self.MessageButton setTitleColor:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0] forState:0];
        
        
    }
    
    
}

- (void)strTimer1:(NSTimer *)time{
    
    
    YT--;
    
    if (YT == 0) {
        [timer1 invalidate];
        timer1 = nil;
        
        
    }
    
    
}

- (void)viewDidAppear:(BOOL)animated{
    [timer invalidate];
    timer = nil;
    
    [buttonCover removeFromSuperview];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    
    [self.YTUserMessageTF resignFirstResponder];

    [self.YTUserNameTF resignFirstResponder];

    
    
}


- (void)checkBtnClick{
    
    
    NSNull *null=[[NSNull alloc] init];
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //    NSString *urlStr = URL_Str;
    
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 30.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    
//    NSString *strUser = self.userNameTF.text;
//    NSString *strPassword = self.againUserPassWordTF.text;


    NSString *strMYID = [NSString stringWithFormat:@"%@",[[UIDevice currentDevice] identifierForVendor].UUIDString];
    
    NSDictionary *dic = @{@"username":self.userName,@"password":self.userPassWord,@"imei":strMYID,@"phone":self.self.YTUserNameTF.text,@"uid":self.uid,@"mid":self.mid};
    
    NSString *url = [NSString stringWithFormat:@"%@registered_mob.shtml",URL_Str];
    YLog(@"%@",dic);
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
                        [_delegate setUserName:self.userName andPassWord:self.userPassWord];
                    }
                    
                    //缓存用户名
                    [UserMessageManager UserName:self.userName];
                    
                    [UserMessageManager UserNewName:self.userName];
                    
                    //缓存用户密码
                    [UserMessageManager UserPassWord:self.userPassWord];
                    
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
                    [UserMessageManager UserId:dic1[@"uid"]];
                    
                    //缓存登录状态
                    [UserMessageManager LoginStatus:@"YES"];
                    
                    

                    [KNotificationCenter postNotificationName:JMSHTLoginSuccessNoti object:nil];
                    
                    //注册成功，通知购物车界面清空数据
                    NSNotification *ZhuCeSuccessCartReloadData = [NSNotification notificationWithName:@"ZhuCeSuccessCartReloadData" object:nil];
                    
                    [[NSNotificationCenter defaultCenter] postNotification:ZhuCeSuccessCartReloadData];
                    
                    
                    self.tabBarController.tabBar.hidden=NO;
                    
                    NSArray *vcArray = self.navigationController.viewControllers;
                    
                    NSLog(@"==注册成功=vcArray==%@",vcArray);
                    
                    for(UIViewController *vc in vcArray)
                    {
                        if ([vc isKindOfClass:[NewHomeViewController class]]){
                            
                            
                            self.navigationController.navigationBar.hidden=YES;
                            self.tabBarController.tabBar.hidden=NO;
                            
                            [self.navigationController popToViewController:vc animated:NO];
                            
                        }else if([vc isKindOfClass:[ClassifyViewController class]]){
                            
                            self.navigationController.navigationBar.hidden=YES;
                            self.tabBarController.tabBar.hidden=NO;
                            
                            [self.navigationController popToViewController:vc animated:NO];
                            
                        }else if([vc isKindOfClass:[MerchantViewController class]]){
                            
                            self.navigationController.navigationBar.hidden=YES;
                            self.tabBarController.tabBar.hidden=NO;
                            
                            [self.navigationController popToViewController:vc animated:NO];
                            
                        }else if([vc isKindOfClass:[CartViewController class]]){
                            
                            self.tabBarController.selectedIndex=4;
                            
                        }else if([vc isKindOfClass:[PersonaViewController class]]){
                            
                            self.navigationController.navigationBar.hidden=YES;
                            self.tabBarController.tabBar.hidden=NO;
                            
                            [self.navigationController popToViewController:vc animated:NO];
                        }

                        
                    }
                    
                    
                    
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
        

        
        [self NoWebSeveice];
    }];
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex==1) {
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}
@end
