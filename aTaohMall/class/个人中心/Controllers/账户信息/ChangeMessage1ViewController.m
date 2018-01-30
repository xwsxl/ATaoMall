//
//  ChangeMessage1ViewController.m
//  aTaohMall
//
//  Created by JMSHT on 16/6/3.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import "ChangeMessage1ViewController.h"

#import "AFNetworking.h"

#import "ConverUtil.h"
#import "DESUtil.h"
#import "SecretCodeTool.h"

#import "UserMessageManager.h"

#import "CountMessageViewController.h"//账户信息
#import "JRToast.h"

#import "WKProgressHUD.h"
@interface ChangeMessage1ViewController ()<UIAlertViewDelegate>
{
    
    NSString *_status;
    UIView *view;
    
}
@end

@implementation ChangeMessage1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    self.ChangeEmailTF.text=self.ChangeString;
    
}

//修改数据
-(void)updateDatas
{
    
    if (self.ChangeEmailTF.text.length>0) {
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        //读取数组NSArray类型的数据
        self.sigens=[userDefaultes stringForKey:@"sigen"];
        
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        NSString *url = [NSString stringWithFormat:@"%@updateAccountInfo_mob.shtml",URL_Str];
        
        NSDictionary *dic = @{@"sigen":self.sigens,@"email":self.ChangeEmailTF.text,@"type":@"4"};
        
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
                        
                        if (_delegate && [_delegate respondsToSelector:@selector(setEmailWithString:)]) {
                            [_delegate setEmailWithString:self.ChangeEmailTF.text];
                            
                        }
                        [self.navigationController popViewControllerAnimated:YES];
                    }else{
                        
                        [JRToast showWithText:@"邮箱修改失败!" duration:1.0f];
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
    
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    BOOL isMatch1 = [emailTest evaluateWithObject:self.ChangeEmailTF.text];
    
    if (isMatch1) {
        
        
        //修改数据
        [self updateDatas];
        
        if (self.ChangeEmailTF.text.length>0) {
            CountMessageViewController *vc=[[CountMessageViewController alloc] init];
            
            [vc.tableView reloadData];
            
            
            //        [self.navigationController pushViewController:VC animated:NO];
            //
            //        self.navigationController.navigationBar.hidden=YES;
        }
    }else{
        
        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"您输入的邮箱有误！" message:nil delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView show];
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
