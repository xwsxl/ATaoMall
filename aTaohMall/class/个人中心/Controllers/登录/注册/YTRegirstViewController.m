//
//  YTRegirstViewController.m
//  aTaohMall
//
//  Created by JMSHT on 2016/10/8.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import "YTRegirstViewController.h"

#import "YTGoodsDetailViewController.h"
#import "NewLoginViewController.h"
#import "AFNetworking.h"

#import "XieYiViewController.h"

#import "ZZLimitInputManager.h"

#import "JRToast.h"

#import "YTNextViewController.h"

#import "WKProgressHUD.h"
@interface YTRegirstViewController ()<UIAlertViewDelegate,UITextFieldDelegate>
{
    UIAlertController *alertCon;
    NSMutableArray *_registerArray;
    NSString *strCode;
    
    UIButton *backBtn;
    
    MBProgressHUD *myProgressHum; //进度条
    UIView *view;
    NSTimer *timer;   //验证码时间
    int i;
    UIButton *buttonCover;
    
    BOOL isAgree;
    BOOL isCorrect;
    
    UITextField *tempTextField;//全局UITextfiled指针
}

@end

@implementation YTRegirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.YTUserPassWordTF addTarget:self action:@selector(XLtextfiledchangedValue:) forControlEvents:UIControlEventEditingChanged];
    //输入用户名长度
    [ZZLimitInputManager limitInputView:self.YTUserNameTF maxLength:20];
    
    //设置密码长度
    [ZZLimitInputManager limitInputView:self.YTUserPassWordTF maxLength:20];
    
    
}


-(void)XLtextfiledchangedValue:(UITextField *)TF
{
    if ([TF.text containsString:@" "]) {
        TF.text=[TF.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    }
}

//返回
- (IBAction)backBtnClick:(UIButton *)sender {
    
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"填完信息即可完成注册" message:nil delegate:self cancelButtonTitle:@"继续注册" otherButtonTitles:@"返回", nil];
    [alert show];
    
}

//切换密码
- (IBAction)YTBtnClick:(UIButton *)sender {
    
    sender.selected=!sender.selected;
    
    //去掉蓝色背景
    sender.tintColor=[UIColor clearColor];
    
    
    if (sender.selected) {
        
        self.YTUserPassWordTF.secureTextEntry = YES;
        
        self.YTImageView.image=[UIImage imageNamed:@"不可视"];
        
    }else{
        
        self.YTUserPassWordTF.secureTextEntry = NO;
        self.YTImageView.image=[UIImage imageNamed:@"可视"];
    }
    
    
}

//下一步
- (IBAction)NextBtnClick:(UIButton *)sender {
    
    
//    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",@"4008-119-7898"];
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];

    
    if (self.YTUserNameTF.text.length==0) {
        
        //输入用户名
        alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入用户名" preferredStyle:UIAlertControllerStyleAlert];
        [alertCon addAction: [UIAlertAction actionWithTitle: @"确认" style: UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
             [self.YTUserNameTF becomeFirstResponder];
            
        }]];
        
        [self presentViewController: alertCon animated: YES completion: nil];
        
    }else{
        
        if (self.YTUserPassWordTF.text.length==0) {
            
            alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"请设置密码" preferredStyle:UIAlertControllerStyleAlert];
            [alertCon addAction: [UIAlertAction actionWithTitle: @"确认" style: UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
                [self.YTUserPassWordTF becomeFirstResponder];
                
            }]];
            
            [self presentViewController: alertCon animated: YES completion: nil];
            
        }else{
            
            //用户名是否为字母加数字
            NSString *CM_NUM = @"^[A-Za-z0-9_-]+$";
            
            NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
            
            BOOL isMatch1 = [pred1 evaluateWithObject:self.YTUserNameTF.text];
            
            if (!isMatch1) {
                
                alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"用户名特殊字符仅支持'-'和'_'" preferredStyle:UIAlertControllerStyleAlert];
                [alertCon addAction: [UIAlertAction actionWithTitle: @"确认" style: UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    
                    [self.YTUserNameTF becomeFirstResponder];
                }]];
                
                [self presentViewController: alertCon animated: YES completion: nil];
                
            }else{
                
                if (self.YTUserNameTF.text.length < 4) {
                    
                    alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"用户名长度为4-20位字符" preferredStyle:UIAlertControllerStyleAlert];
                    [alertCon addAction: [UIAlertAction actionWithTitle: @"确认" style: UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                        
                        [self.YTUserNameTF becomeFirstResponder];
                        
                    }]];
                    
                    [self presentViewController: alertCon animated: YES completion: nil];
                    
                }else{
                    
                    if (self.YTUserPassWordTF.text.length < 6) {
                        
                        alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"密码长度为6-20位字符" preferredStyle:UIAlertControllerStyleAlert];
                        [alertCon addAction: [UIAlertAction actionWithTitle: @"确认" style: UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                            
                            [self.YTUserPassWordTF becomeFirstResponder];
                            
                        }]];
                        
                        [self presentViewController: alertCon animated: YES completion: nil];
                    }else{
                        
                        if ([self.YTUserPassWordTF.text rangeOfString:@" "].location != NSNotFound) {
                            
                            alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"密码不能包含空格" preferredStyle:UIAlertControllerStyleAlert];
                            [alertCon addAction: [UIAlertAction actionWithTitle: @"确认" style: UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                                
                                [self.YTUserPassWordTF becomeFirstResponder];
                                
                            }]];
                            [self presentViewController: alertCon animated: YES completion: nil];
                            
                            
                        }else{
                            
                            
                            //用户名是否为汉字
                            //NSString *CM_NUM211 = @"^[\u4e00-\u9fa5]{0,}$";
                            
                            
                            
                            NSString *CM_NUM211 = @"^.*[\u4e00-\u9fa5].*$";
                            
                            NSPredicate *pred211 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM211];
                            
                            BOOL isMatch211 = [pred211 evaluateWithObject:self.YTUserPassWordTF.text];
                            
                            if (isMatch211) {
                                
                                alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"密码不允许有汉字" preferredStyle:UIAlertControllerStyleAlert];
                                [alertCon addAction: [UIAlertAction actionWithTitle: @"确认" style: UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                                    
                                    [self.YTUserPassWordTF becomeFirstResponder];
                                    
                                }]];
                                
                                [self presentViewController: alertCon animated: YES completion: nil];
                                
                            }else{
                                
                                //用户名是否为字母加数字
                                NSString *CM_NUM10 = @"^(?![\\d]+$)(?![a-zA-Z]+$)(?![^\\da-zA-Z]+$).{6,20}$";
                                
                                NSPredicate *pred110 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM10];
                                
                                BOOL isMatch110 = [pred110 evaluateWithObject:self.YTUserPassWordTF.text];
                                
                                if (!isMatch110) {
                                    
                                    alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"密码至少由2种字符组合" preferredStyle:UIAlertControllerStyleAlert];
                                    [alertCon addAction: [UIAlertAction actionWithTitle: @"确认" style: UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                                        
                                        [self.YTUserPassWordTF becomeFirstResponder];
                                        
                                    }]];
                                    
                                    [self presentViewController: alertCon animated: YES completion: nil];
                                    
                                }else{
                                    
                                    if (self.YTUserMessageTF.text.length==0) {
                                        
                                        [self getDatas];
                                        
                                    }else{
                                        
                                        NSString *CM_NUMyt = @"^.*[\u4e00-\u9fa5].*$";
                                        
                                        NSPredicate *predyt = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUMyt];
                                        
                                        BOOL isMatchyt = [predyt evaluateWithObject:self.YTUserPassWordTF.text];
                                        
                                        if (isMatchyt) {
                                            
                                            alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"该邀请码无效" preferredStyle:UIAlertControllerStyleAlert];
                                            [alertCon addAction: [UIAlertAction actionWithTitle: @"确认" style: UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                                                
                                                [self.YTUserMessageTF becomeFirstResponder];
                                                
                                            }]];
                                            
                                            [self presentViewController: alertCon animated: YES completion: nil];
                                            
                                            
                                        }else{
                                            
                                            
                                            NSString *CM_NUMyt10 = @"^[A-Za-z0-9_-]+$";
                                            
                                            NSPredicate *predyt10 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUMyt10];
                                            
                                            BOOL isMatchyt10 = [predyt10 evaluateWithObject:self.YTUserPassWordTF.text];
                                            
                                            if (!isMatchyt10) {
                                                
                                                alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"该邀请码无效" preferredStyle:UIAlertControllerStyleAlert];
                                                [alertCon addAction: [UIAlertAction actionWithTitle: @"确认" style: UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                                                    
                                                    [self.YTUserMessageTF becomeFirstResponder];
                                                    
                                                }]];
                                                
                                                [self presentViewController: alertCon animated: YES completion: nil];
                                                
                                                
                                            }else{
                                                
                                                WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
                                                
                                                dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
                                                dispatch_after(time, dispatch_get_main_queue(), ^{
                                                    [hud dismiss:YES];
                                                });
                                                
                                                [self getDatas];
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
//    YTGoodsDetailViewController *vc=[[YTGoodsDetailViewController alloc] init];
//    
//    [self.navigationController pushViewController:VC animated:NO];
//    
//    self.navigationController.navigationBar.hidden=YES;
    
    
}


-(void)getDatas
{
    

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 30.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    
    NSDictionary *dic = @{@"username":self.YTUserNameTF.text,@"tg_sigen":self.YTUserMessageTF.text};
    
    
    NSString *url = [NSString stringWithFormat:@"%@checkUsernameAndSigen_mob.shtml",URL_Str];
    
    [manager POST:url parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
        NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];
        
        
        
        
        if (codeKey && content) {
            NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
            
            NSLog(@"xmlStr%@",xmlStr);
            view.hidden=YES;
            
            NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];
            
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            NSLog(@"====%@",dic);
            
            
            for (NSDictionary *dic1 in dic) {
                
                
                if ([dic1[@"status"] isEqualToString:@"10000"] && [dic1[@"sigen_status"] isEqualToString:@"10000"]) {
                    
                    NSLog(@"=====%@",dic1[@"uid"]);
                    
                    NSLog(@"=====%@",dic1[@"mid"]);
                    
                    YTNextViewController *vc = [[YTNextViewController alloc] init];
                    vc.uid=dic1[@"uid"];
                    vc.mid=dic1[@"mid"];
                    vc.userName=self.YTUserNameTF.text;
                    vc.userPassWord=self.YTUserPassWordTF.text;
                    
                    [self.navigationController pushViewController:vc animated:NO];
                    
                    self.navigationController.navigationBar.hidden=YES;
                    
            
                }else if([dic1[@"status"] isEqualToString:@"10001"]){
                    
                    alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:dic1[@"message"] preferredStyle:UIAlertControllerStyleAlert];
                    [alertCon addAction: [UIAlertAction actionWithTitle: @"直接登录" style: UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                        
                        [self.navigationController popViewControllerAnimated:YES];
                        
                    }]];
                    
                    [alertCon addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        
                        
                        
                        
                        [self.YTUserNameTF becomeFirstResponder];
                        
                    }]];
                    
                    [self presentViewController: alertCon animated: YES completion: nil];
                    
                }else if ([dic1[@"sigen_status"] isEqualToString:@"10001"]){
                    
                    alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:dic1[@"sigen_message"] preferredStyle:UIAlertControllerStyleAlert];
                    [alertCon addAction: [UIAlertAction actionWithTitle: @"确认" style: UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                        
                        [self.YTUserMessageTF becomeFirstResponder];
                        
                    }]];
                    
                    [self presentViewController: alertCon animated: YES completion: nil];
                }else{
                    
                    alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:dic1[@"message"] preferredStyle:UIAlertControllerStyleAlert];
                    [alertCon addAction: [UIAlertAction actionWithTitle: @"确认" style: UIAlertActionStyleCancel handler:nil]];
                    [self presentViewController: alertCon animated: YES completion: nil];
                }
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
//        alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"服务器连接失败! 请检查网络链接或联系客服"preferredStyle:UIAlertControllerStyleAlert];
//        [alertCon addAction: [UIAlertAction actionWithTitle: @"确认" style: UIAlertActionStyleCancel handler:nil]];
//        [self presentViewController: alertCon animated: YES completion: nil];
//        
//        
//        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
//        [self NoWebSeveice];
        NSLog(@"PostDepartment Error %@",error);
    }];
}

-(void)loadData{
    
    WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
    
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        [hud dismiss:YES];
    });
    
//    [self NoWebSeveice];
    [self getDatas];
}
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

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex==1) {
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    
    [self.YTUserNameTF resignFirstResponder];
    [self.YTUserPassWordTF resignFirstResponder];
    [self.YTUserMessageTF resignFirstResponder];
}
@end
