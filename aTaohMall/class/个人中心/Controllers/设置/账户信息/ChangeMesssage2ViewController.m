//
//  ChangeMesssage2ViewController.m
//  aTaohMall
//
//  Created by JMSHT on 16/6/3.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import "ChangeMesssage2ViewController.h"


#import "AFNetworking.h"

#import "ConverUtil.h"
#import "DESUtil.h"
#import "SecretCodeTool.h"

#import "UserMessageManager.h"

#import "CountMessageViewController.h"//账户信息
#import "JRToast.h"

#import "WKProgressHUD.h"
@interface ChangeMesssage2ViewController ()<UIAlertViewDelegate>
{
    
    UIView *view;
    
}
@end

@implementation ChangeMesssage2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.ChangePhoneTF.text=self.ChangeString;
}

//修改数据
-(void)updateDatas
{
    if (self.ChangePhoneTF.text.length>0) {
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        //读取数组NSArray类型的数据
        self.sigens=[userDefaultes stringForKey:@"sigen"];
        
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        NSString *url = [NSString stringWithFormat:@"%@updateAccountInfo_mob.shtml",URL_Str];
        
        NSDictionary *dic = @{@"sigen":self.sigens,@"phone":self.ChangePhoneTF.text,@"type":@"6"};
        
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
                
                NSLog(@"%@",dic);
                
                view.hidden=YES;
                
                for (NSDictionary *dict in dic) {
                    
                    if ([dict[@"status"] isEqualToString:@"10000"]) {
                        
                        //推荐奖励刷新数据
                        if (_delegate && [_delegate respondsToSelector:@selector(setDataReload)]) {
                            [_delegate setDataReload];
                        }
                        
                        
                        if (_delegate && [_delegate respondsToSelector:@selector(setPhoneWithString:)]) {
                            [_delegate setPhoneWithString:self.ChangePhoneTF.text];
                        }
                        
                        self.navigationController.navigationBar.hidden=YES;
                        self.tabBarController.tabBar.hidden=YES;
                        
                        [self.navigationController popViewControllerAnimated:YES];
                        
                    }else{
                        
                        [JRToast showWithText:@"电话修改失败!" duration:1.0f];
                    }
                }

                
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@",error);
            [self NoWebSeveice];
            
            
        }];
    }else{
        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"您输入的信息为空!" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alertView.delegate=self;
        [alertView show];
    }
    
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

-(void)loadData
{
    WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
    
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        [hud dismiss:YES];
    });
    
    [self updateDatas];
    
}
//保存
- (IBAction)saveBtnClick:(UIButton *)sender {
    
    
    if (self.ChangePhoneTF.text.length<11) {
        
        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"手机号长度只能是11位" message:nil delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        
        [alertView show];
        
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
        BOOL isMatch1 = [pred1 evaluateWithObject:self.ChangePhoneTF.text];
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:self.ChangePhoneTF.text];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        
        BOOL isMatch3 = [pred3 evaluateWithObject:self.ChangePhoneTF.text];
        
        if (isMatch1 || isMatch2 || isMatch3) {
            //            return nil;
            
            
            
                
                //修改数据
                [self updateDatas];
//            }
            
            if (self.ChangePhoneTF.text.length>0) {
                CountMessageViewController *vc=[[CountMessageViewController alloc] init];
                [vc.tableView reloadData];
                
            }
            
            
        }else{
            
            UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"请输入正确的手机号码" message:nil delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alertView show];
            
        }
    }
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
//返回
- (IBAction)backBtnClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
@end
