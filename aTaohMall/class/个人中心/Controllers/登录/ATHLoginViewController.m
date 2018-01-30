//
//  ATHLoginViewController.m
//  aTaohMall
//
//  Created by JMSHT on 2016/10/18.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import "ATHLoginViewController.h"

#import "AuthcodeView.h"

#import "QueDingDingDanViewController.h"

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

#import "BackCartViewController.h"

#import "AFNetworking.h"

#import "ConverUtil.h"
#import "DESUtil.h"
#import "SecretCodeTool.h"

#import "PhoneAndFlowPayViewController.h"
#import "AirPlaneReserveGoBackViewController.h"
#import "AirPlaneReserveViewController.h"
#import "TrainYuDingViewController.h"
#import "PeccantViewController.h"
@interface ATHLoginViewController ()<UITextFieldDelegate,NameAndPassWordDelegate>
{
    
    UIView *view1;
    UIView *view2;
    UIView *YTTF;
    
    UIButton *YTLoginButton;
    UIButton *YTButton;
    UIButton *ZhuCeButton;
    UIButton *ForgetButton;
    
    
    UITextField *YTPassWordTF;
    UITextField *YTUserNameTF;
    UITextField *YTMessageTF;
    
    UIImageView *YTImageView;
    
    UIImageView *imgView1;
    UIImageView *imgView2;
    UIImageView *imgView3;
    
    
    //分割线
    UIImageView *imgView4;
    UIImageView *imgView5;
    UIImageView *imgView6;
    
    UIImageView *imgView7;
    UIImageView *imgView8;
    UIImageView *imgView9;
    
    int height;
    
    int a;
    
    NSMutableArray *_logArray;
    
    
    UIButton *backBtn;
    UIButton *registBtn;
    UIView *view;
    
    MBProgressHUD *myProgressHum;
    
    AFHTTPRequestOperationManager *manager;
    
    
    UIAlertController *alertCon;
    
    NSNull *null;
    
    int YTnumber;
    
    NSString *yt;
    
    NSInteger userName;
    NSInteger passWord;
    
    
    NSString *touxiang;
    
    NSString *yingCang;
}

@property (nonatomic, strong) AuthcodeView *authcodeView;

@end

@implementation ATHLoginViewController
/*******************************************************      控制器生命周期       ******************************************************/
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    height=168;
    a=0;
    YTnumber=0;
    yt=@"100";
    yingCang=@"500";
    [self setUI];
    NSLog(@"=====%@",self.choseView_gid);
    NSLog(@"=====%@",self.choseView_mid);
    NSLog(@"=====%@",self.choseView_NewGoods_Type);
    NSLog(@"=====%@",self.choseView_detailId);
    NSLog(@"=====%@",self.choseView_num);
    NSLog(@"=====%@",self.choseView_exchange);
    
}
- (void)viewWillDisappear:(BOOL)animated{
    
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    [manager.operationQueue cancelAllOperations];
    [YTUserNameTF resignFirstResponder];
    [YTPassWordTF resignFirstResponder];
    [YTMessageTF resignFirstResponder];


}
/*******************************************************      数据请求       ******************************************************/
//同店铺的不能购买 xiu bing fei lang miao xin quan miao peng ying liu xiang huo tai
-(void)getDatas1
{
    
    NSNull *null=[[NSNull alloc] init];
    
    manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@getConfirmOrderInfo_mob.shtml",URL_Str];
    
    NSLog(@"=====self.sigen====%@========",self.sigen);
    NSLog(@"=====self.mid====%@========",self.midddd);
    NSLog(@"=====self.gid====%@========",self.gid);
    NSLog(@"=====self.logo====%@========",self.logo);
    NSLog(@"=====self.storename====%@========",self.storename);
    
    NSDictionary *dic = @{@"sigen":self.sigen,@"mid":self.midddd,@"gid":self.gid,@"logo":@"",@"storename":self.storename};
    //logo可能为空报错
    
    [manager POST:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
        NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];
        
        
        if (codeKey && content) {
            NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
            
            //            NSLog(@"xmlStr==%@",xmlStr);
            
            NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];
            
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            NSLog(@"=======商品信息555555555555555555555555555%@",dic);
            //            view.hidden=YES;
            for (NSDictionary *dict1 in dic) {
                
                
                self.NotBuy=dict1[@"status"];
                
                self.NotBuyMessage=dict1[@"message"];
                
                
                NSString *YTType;
                NSString *YTStatus;
                
                for (NSDictionary *dict2 in dict1[@"list"]) {
                    
                    
                    YTType=dict2[@"good_type"];
                    
                    YTStatus=dict2[@"status"];
                    
                }
                
                if ([self.NotBuy isEqualToString:@"10001"]) {
                    
                    [JRToast showWithText:self.NotBuyMessage duration:3.0f];
                    
                    [self.navigationController popViewControllerAnimated:NO];
                    
                    
                }else if([self.NotBuy isEqualToString:@"10002"]){
                    
                    [JRToast showWithText:self.NotBuyMessage duration:3.0f];
                    
                    [self.navigationController popViewControllerAnimated:NO];
                    
                }else if([self.NotBuy isEqualToString:@"10000"]){
                    
                    if (([self.Goods_Type_Switch isEqualToString:@"1"] && [self.Good_status isEqualToString:@"0"]) || ([YTType isEqualToString:@"1"] && [YTStatus isEqualToString:@"0"])) {
                        
                        [JRToast showWithText:@"请等待，限购商品暂未开抢" duration:3.0f];
                        
                        [self.navigationController popViewControllerAnimated:NO];
                        
                        
                    }else if(([self.Goods_Type_Switch isEqualToString:@"1"] && [self.Good_status isEqualToString:@"7"]) || ([YTType isEqualToString:@"1"] && [YTStatus isEqualToString:@"7"])) {
                        
                        [JRToast showWithText:@"该商品已结束抢购！" duration:3.0f];
                        
                        [self.navigationController popViewControllerAnimated:NO];
                        
                        
                    }else if(([self.Goods_Type_Switch isEqualToString:@"1"] && [self.Good_status isEqualToString:@"6"]) || ([YTType isEqualToString:@"1"] && [YTStatus isEqualToString:@"6"])) {
                        
                        [JRToast showWithText:@"该商品已售完！" duration:3.0f];
                        
                        [self.navigationController popViewControllerAnimated:NO];
                        
                        
                    }else if(([self.Goods_Type_Switch isEqualToString:@"1"] && [self.Good_status isEqualToString:@"1"]) || ([YTType isEqualToString:@"1"] && [YTStatus isEqualToString:@"1"])) {
                        
                        [JRToast showWithText:@"该商品已下架！" duration:3.0f];
                        
                        [self.navigationController popViewControllerAnimated:NO];
                        
                        
                    }else if(([self.Goods_Type_Switch isEqualToString:@"1"] && [self.Good_status isEqualToString:@"5"]) || ([YTType isEqualToString:@"1"] && [YTStatus isEqualToString:@"5"])) {
                        
                        [JRToast showWithText:@"该商品已删除！" duration:3.0f];
                        
                        [self.navigationController popViewControllerAnimated:NO];
                        
                        
                    }else{
                        
                        if ([self.stock isEqualToString:@"0"]) {
                            
                            [JRToast showWithText:@"库存为0，无法购买" duration:3.0f];
                            
                            [self.navigationController popViewControllerAnimated:NO];
                            
                            
                        }else if([self.YTStatus isEqualToString:@"1"]){
                            
                            [JRToast showWithText:@"该商品已下架！" duration:3.0f];
                            
                            [self.navigationController popViewControllerAnimated:NO];
                            
                        }else{
                            
                            
                            QueDingDingDanViewController *vc=[[QueDingDingDanViewController alloc] init];
                            
                            //    NewAddAddressViewController *vc=[[NewAddAddressViewController alloc] init];
                            
                            NSLog(@"yyyyyyyyy==%@",self.yunfei);
                            
                            if ([self.BackBack isEqualToString:@"100"]) {
                                
                                vc.CutLogin = @"200";
                                
                            }else{
                                
                                vc.CutLogin = @"100";
                            }
                            
                            
                            vc.gid=self.gid;
                            
                            vc.sigen=self.sigen;
                            
                            vc.storename=self.storename;
                            
                            vc.logo=self.logo;
                            
                            vc.GoodsDetailType=self.SendWayType;
                            
                            vc.Goods_Type_Switch=self.Goods_Type_Switch;
                            
                            vc.SendWayType=self.SendWayType;
                            
                            vc.MoneyType=self.MoneyType;
                            
                            vc.midddd=self.midddd;
                            
                            vc.yunfei=self.yunfei;
                            
                            vc.exchange = self.exchange;
                            
                            vc.detailId = @"";
                            
                            [self.navigationController pushViewController:vc animated:NO];
                            self.navigationController.navigationBar.hidden=YES;
                            
                            
                        }
                    }
                }
            }
            
            NSLog(@"++++++self.NotBuy++++++%@",self.NotBuy);
            NSLog(@"++++++self.NotBuyMessage++++++%@",self.NotBuyMessage);
            //            [_tableView reloadData];
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //        [WKProgressHUD popMessage:@"网络请求失败，请检查您的网络设置" inView:self.view duration:1.5 animated:YES];
        
        //        [self NoWebSeveice];
        
        NSLog(@"%@",error);
    }];
}
/*******************************************************      初始化视图       ******************************************************/
-(void)setUI
{
    
    UIView *nav=[[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, KSafeAreaTopNaviHeight)];
    
    [self.view addSubview:nav];
    
    UIButton *back=[UIButton buttonWithType:UIButtonTypeCustom];
    back.frame=CGRectMake(10, 25+KSafeTopHeight, 30, 30);
    [back setBackgroundImage:[UIImage imageNamed:@"delete"] forState:0];
    
    [back addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [nav addSubview:back];
    
    UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(100, 25+KSafeTopHeight, [UIScreen mainScreen].bounds.size.width-200, 30)];
    label.text=@"登录";
    label.textAlignment=NSTextAlignmentCenter;
    label.font=[UIFont fontWithName:@"PingFangSC-Medium" size:20];
    [nav addSubview:label];
    
    view1=[[UIView alloc] initWithFrame:CGRectMake(15, 94+KSafeTopHeight, [UIScreen mainScreen].bounds.size.width-30, 44)];
    imgView7=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, view1.frame.size.width, 44)];
    imgView7.image=[UIImage imageNamed:@"边框"];
    [view1 addSubview:imgView7];
    
    imgView1=[[UIImageView alloc] initWithFrame:CGRectMake(20, 6, 33, 33)];
    imgView1.image=[UIImage imageNamed:@"用户名666"];
    [view1 addSubview:imgView1];
    
    imgView4=[[UIImageView alloc] initWithFrame:CGRectMake(73, 7, 1, 30)];
    imgView4.image=[UIImage imageNamed:@"分割线"];
    [view1 addSubview:imgView4];
    
    YTUserNameTF=[[UITextField alloc] initWithFrame:CGRectMake(94, 7, view1.frame.size.width-105, 30)];
    YTUserNameTF.placeholder=@"用户名";
    YTUserNameTF.font=[UIFont fontWithName:@"PingFangSC-Medium" size:14];
    YTUserNameTF.textAlignment=NSTextAlignmentLeft;
    YTUserNameTF.textColor=[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    YTUserNameTF.clearButtonMode=UITextFieldViewModeWhileEditing;
    YTUserNameTF.borderStyle=UITextBorderStyleNone;
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    
    
    if([userDefaultes stringForKey:@"myName"].length!=0){
        YTUserNameTF.text=[userDefaultes stringForKey:@"myName"];
    }else{
    }
    
    [YTUserNameTF addTarget:self action:@selector(YTUserNameTFDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    [view1 addSubview:YTUserNameTF];
    
    [self.view addSubview:view1];
    
    
    view2=[[UIView alloc] initWithFrame:CGRectMake(15, 168+KSafeTopHeight, [UIScreen mainScreen].bounds.size.width-30, 44)];
    imgView8=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, view2.frame.size.width, 44)];
    imgView8.image=[UIImage imageNamed:@"边框"];
    [view2 addSubview:imgView8];
    
    imgView2=[[UIImageView alloc] initWithFrame:CGRectMake(20, 6, 33, 33)];
    imgView2.image=[UIImage imageNamed:@"密码-(6)666"];
    [view2 addSubview:imgView2];
    
    imgView5=[[UIImageView alloc] initWithFrame:CGRectMake(73, 7, 1, 30)];
    imgView5.image=[UIImage imageNamed:@"分割线"];
    [view2 addSubview:imgView5];
    
    
    YTPassWordTF=[[UITextField alloc] initWithFrame:CGRectMake(94, 7, view2.frame.size.width-128, 30)];
    YTPassWordTF.placeholder=@"密码";
    YTPassWordTF.font=[UIFont fontWithName:@"PingFangSC-Medium" size:14];
    YTPassWordTF.textAlignment=NSTextAlignmentLeft;
    YTPassWordTF.textColor=[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    YTPassWordTF.clearButtonMode=UITextFieldViewModeWhileEditing;
    YTPassWordTF.borderStyle=UITextBorderStyleNone;
    
    YTPassWordTF.clearsOnBeginEditing=NO;
    
    YTPassWordTF.keyboardType=UIKeyboardTypeDefault;
    
    [YTPassWordTF addTarget:self action:@selector(YTPassWordTFDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    YTPassWordTF.secureTextEntry=YES;
    
    [view2 addSubview:YTPassWordTF];
    
    YTImageView=[[UIImageView alloc] initWithFrame:CGRectMake(view2.frame.size.width-38, 11, 22, 22)];
    YTImageView.image=[UIImage imageNamed:@"不可视"];
    [view2 addSubview:YTImageView];
    
    YTButton=[UIButton buttonWithType:UIButtonTypeCustom];
    YTButton.frame=CGRectMake(view2.frame.size.width-45, 0, 45, 44);
    [view2 addSubview:YTButton];
    
    
    [YTButton addTarget:self action:@selector(YTButtonBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:view2];
    
    YTTF=[[UIView alloc] initWithFrame:CGRectMake(15, height+KSafeTopHeight, [UIScreen mainScreen].bounds.size.width-30, 44)];
    imgView9=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, YTTF.frame.size.width, 44)];
    imgView9.image=[UIImage imageNamed:@"边框"];
    [YTTF addSubview:imgView9];
    
    imgView3=[[UIImageView alloc] initWithFrame:CGRectMake(20, 6, 33, 33)];
    imgView3.image=[UIImage imageNamed:@"验证码666"];
    [YTTF addSubview:imgView3];
    
    imgView6=[[UIImageView alloc] initWithFrame:CGRectMake(73, 7, 1, 30)];
    imgView6.image=[UIImage imageNamed:@"分割线"];
    [YTTF addSubview:imgView6];
    
    
    YTMessageTF=[[UITextField alloc] initWithFrame:CGRectMake(94, 7, YTTF.frame.size.width-200, 30)];
    YTMessageTF.placeholder=@"验证码";
    YTMessageTF.font=[UIFont fontWithName:@"PingFangSC-Medium" size:14];
    YTMessageTF.textAlignment=NSTextAlignmentLeft;
    YTMessageTF.textColor=[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    YTMessageTF.clearButtonMode=UITextFieldViewModeWhileEditing;
    YTMessageTF.borderStyle=UITextBorderStyleNone;
    [YTTF addSubview:YTMessageTF];
    
    [self.view addSubview:YTTF];
    
    
    YTTF.hidden=YES;
    
    
    YTLoginButton.enabled=NO;
    
    
    YTLoginButton=[UIButton buttonWithType:UIButtonTypeCustom];
    YTLoginButton.frame=CGRectMake(15, YTTF.frame.origin.y+YTTF.frame.size.height+50+KSafeTopHeight, [UIScreen mainScreen].bounds.size.width-30, 44);
    [YTLoginButton setBackgroundImage:[UIImage imageNamed:@"为选中按钮"] forState:0];
    
    [YTLoginButton setTitle:@"登录" forState:0];
    
    [YTLoginButton setTintColor:[UIColor whiteColor]];
    
    YTLoginButton.titleLabel.font=[UIFont fontWithName:@"PingFangSC-Medium" size:20];
    
    
    [self.view addSubview:YTLoginButton];
    
    
    ZhuCeButton=[UIButton buttonWithType:UIButtonTypeCustom];
    ZhuCeButton.frame=CGRectMake(20, YTLoginButton.frame.origin.y+YTLoginButton.frame.size.height+10+KSafeTopHeight, 104, 30);
    [ZhuCeButton setTitle:@"手机快速注册" forState:0];
    [ZhuCeButton setTitleColor:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0] forState:0];
    ZhuCeButton.titleLabel.font=[UIFont fontWithName:@"PingFangSC-Medium" size:15];
    ZhuCeButton.titleLabel.textAlignment=NSTextAlignmentLeft;
    
    [ZhuCeButton addTarget:self action:@selector(YTZhuCeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:ZhuCeButton];
    
    
    ForgetButton=[UIButton buttonWithType:UIButtonTypeCustom];
    ForgetButton.frame=CGRectMake([UIScreen mainScreen].bounds.size.width-100, YTLoginButton.frame.origin.y+YTLoginButton.frame.size.height+10+KSafeTopHeight, 93, 30);
    [ForgetButton setTitle:@"忘记密码？" forState:0];
    ForgetButton.titleLabel.textAlignment=NSTextAlignmentRight;
    
    [ForgetButton setTitleColor:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0] forState:0];
    ForgetButton.titleLabel.font=[UIFont fontWithName:@"PingFangSC-Medium" size:15];
    
    
    [ForgetButton addTarget:self action:@selector(YTForgetBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:ForgetButton];
    
    
    //设置代理
    YTUserNameTF.delegate=self;
    YTPassWordTF.delegate=self;
    
    self.again=@"1";
    
    
    null=[[NSNull alloc] init];
    
    null=[[NSNull alloc] init];
    
    
    
    
    if ([self.backString isEqualToString:@"100"]) {
        
        YTUserNameTF.text=self.userName;
        YTPassWordTF.text=self.userPassWord;
        
    }else{
        
        YTUserNameTF.text=[userDefaultes stringForKey:@"myName"];
        YTPassWordTF.text=nil;
    }
    //密码
    [ZZLimitInputManager limitInputView:YTUserNameTF maxLength:20];
    //用户名
    [ZZLimitInputManager limitInputView:YTPassWordTF maxLength:20];
    
    [ZZLimitInputManager limitInputView:YTMessageTF maxLength:4];
    
}

/*******************************************************      各种button执行方法、页面间的跳转       ******************************************************/

//第二步,实现回调函数
- (void)YTUserNameTFDidChange:(id) sender {
    UITextField *_field = (UITextField *)sender;
    
    userName=_field.text.length;
    passWord=YTPassWordTF.text.length;
    
    NSLog(@"====YTUserNameTF===%@,%d",[_field text],_field.text.length);
    
    if (/*YTPassWordTF.text.length>0*/passWord>0 && userName>=1) {
        
        YTLoginButton.enabled=YES;
        [YTLoginButton setBackgroundImage:[UIImage imageNamed:@"按钮"] forState:0];
        
        [YTLoginButton addTarget:self action:@selector(YTLoginBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
    }else{
        
        YTLoginButton.enabled=NO;
        [YTLoginButton setBackgroundImage:[UIImage imageNamed:@"为选中按钮"] forState:0];
        
    }
    
}

//第二步,实现回调函数
- (void)YTPassWordTFDidChange:(id) sender {
    UITextField *_field = (UITextField *)sender;
    
    passWord=_field.text.length;
    userName=YTUserNameTF.text.length;
    
    NSLog(@"==YTPassWordTF===%@,%d",[_field text],_field.text.length);
    
    
    if (/*YTUserNameTF.text.length>0*/userName>0 && passWord>=1) {
        
        YTLoginButton.enabled=YES;
        [YTLoginButton setBackgroundImage:[UIImage imageNamed:@"按钮"] forState:0];
        
        [YTLoginButton addTarget:self action:@selector(YTLoginBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
    }else{
        
        YTLoginButton.enabled=NO;
        [YTLoginButton setBackgroundImage:[UIImage imageNamed:@"为选中按钮"] forState:0];
    }
    
}
//左上角删除即返回
-(void)backBtnClick
{
    
    self.tabBarController.tabBar.userInteractionEnabled=YES;
    
    YTnumber=0;
    
    if ([self.HeindBack isEqualToString:@"100"]) {
        
        //创建通知，返回首页
        
        NSNotification *notionfication = [[NSNotification alloc] initWithName:@"LoginBackHome" object:nil userInfo:nil];
        
        [[NSNotificationCenter defaultCenter] postNotification:notionfication];
        
        
    }
    
    
    if ([self.CartBack isEqualToString:@"100"]) {
        
        self.tabBarController.selectedIndex=4;
        
    }
    
    //    self.navigationController.navigationBar.hidden=YES;
    //    self.tabBarController.tabBar.hidden=NO;
    //
    //    [self.navigationController popToRootViewControllerAnimated:YES];
    
    if ([self.backString isEqualToString:@"1"]){
        
        //恢复tabbar
        self.tabBarController.tabBar.hidden=YES;
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        
        
        
    }else if([self.backString isEqualToString:@"200"]){
        
        
        //恢复tabbar
        self.tabBarController.tabBar.hidden=YES;
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        
        
        
    }else if([self.backString isEqualToString:@"426"]){
        
        
        //恢复tabbar
        self.tabBarController.tabBar.hidden=YES;
        
        [self.navigationController popViewControllerAnimated:NO];
        
        
        
    }else if([self.backString isEqualToString:@"612"]){
        
        
        //恢复tabbar
        self.tabBarController.tabBar.hidden=YES;
        
        [self.navigationController popViewControllerAnimated:NO];
        
        
        
    }else if([self.backString isEqualToString:@"618"]){
        
        
        //恢复tabbar
        self.tabBarController.tabBar.hidden=YES;
        
        [self.navigationController popViewControllerAnimated:NO];
        
        
        
    }else if([self.backString isEqualToString:@"719"]){
        
        
        //恢复tabbar
        self.tabBarController.tabBar.hidden=YES;
        
        [self.navigationController popViewControllerAnimated:NO];
        
        
        
    }else if([self.backString isEqualToString:@"123"]){
        
        
        self.tabBarController.tabBar.hidden=YES;
        
        [self.navigationController popViewControllerAnimated:NO];
        
        
        
    }else if([self.backString isEqualToString:@"205"]){
        
        
        self.tabBarController.tabBar.hidden=YES;
        
        [self.navigationController popViewControllerAnimated:NO];
        
        
        
    }else if([self.backString isEqualToString:@"333"]){
        
        
        self.navigationController.navigationBar.hidden=YES;
        
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
        
        
        
        if (_delegate && [_delegate respondsToSelector:@selector(NoShowView)]) {
            
            [_delegate NoShowView];
            
        }
        
        
        self.tabBarController.tabBar.hidden=YES;
        
        [self.navigationController popViewControllerAnimated:YES];
        
        
        
    }else if([self.backString isEqualToString:@"400"]){
        
        
        self.tabBarController.tabBar.hidden=NO;
        
        [self.navigationController popViewControllerAnimated:YES];
        
        
        
    }else if([self.backString isEqualToString:@"520"]){
        
        self.tabBarController.tabBar.hidden=YES;
        
        [self.navigationController popViewControllerAnimated:YES];
        
        
    }else{
        
        if (_delegate && [_delegate respondsToSelector:@selector(NoShowView)]) {
            
            [_delegate NoShowView];
            
        }
        [self.navigationController popViewControllerAnimated:YES];
        //                            [self.navigationController pushViewController:home animated:YES];
        
        self.navigationController.navigationBar.hidden=YES;
        
        //恢复tabbar
        self.tabBarController.tabBar.hidden=NO;
    }
    
}
//登录
-(void)YTLoginBtnClick
{
    
    if (YTnumber>=3) {
        
        if ([yt isEqualToString:@"100"]) {
            
            YTLoginButton.hidden=YES;
            ZhuCeButton.hidden=YES;
            ForgetButton.hidden=YES;
            
            height=242;
            
            YTTF=[[UIView alloc] initWithFrame:CGRectMake(15, height, [UIScreen mainScreen].bounds.size.width-30, 44)];
            imgView9=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, YTTF.frame.size.width, 44)];
            imgView9.image=[UIImage imageNamed:@"边框"];
            [YTTF addSubview:imgView9];
            
            imgView3=[[UIImageView alloc] initWithFrame:CGRectMake(20, 6, 33, 33)];
            imgView3.image=[UIImage imageNamed:@"验证码666"];
            [YTTF addSubview:imgView3];
            
            imgView6=[[UIImageView alloc] initWithFrame:CGRectMake(73, 7, 1, 30)];
            imgView6.image=[UIImage imageNamed:@"分割线"];
            [YTTF addSubview:imgView6];
            
            
            YTMessageTF=[[UITextField alloc] initWithFrame:CGRectMake(94, 7, YTTF.frame.size.width-200, 30)];
            
            
            YTMessageTF.placeholder=@"验证码";
            YTMessageTF.font=[UIFont fontWithName:@"PingFangSC-Medium" size:17];
            YTMessageTF.textAlignment=NSTextAlignmentLeft;
            YTMessageTF.textColor=[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
            YTMessageTF.clearButtonMode=UITextFieldViewModeWhileEditing;
            YTMessageTF.borderStyle=UITextBorderStyleNone;
            [YTTF addSubview:YTMessageTF];
            
            
            
            //显示验证码界面
            self.authcodeView = [[AuthcodeView alloc] initWithFrame:CGRectMake(YTTF.frame.size.width-100, 7, 70, 30)];
            
            
            [YTTF addSubview:self.authcodeView];
            
            
            UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
            
            
            button.frame=CGRectMake(YTTF.frame.size.width-100, 7, 70, 30);
            
            [YTTF addSubview:button];
            
            [button addTarget:self action:@selector(YanBtnClick) forControlEvents:UIControlEventTouchUpInside];
            
            NSLog(@"======%@==",self.authcodeView.authcodeString);
            
            
            [self.view addSubview:YTTF];
            
            
            
            
            YTLoginButton=[UIButton buttonWithType:UIButtonTypeCustom];
            YTLoginButton.frame=CGRectMake(15, YTTF.frame.origin.y+YTTF.frame.size.height+50, [UIScreen mainScreen].bounds.size.width-30, 44);
            [YTLoginButton setBackgroundImage:[UIImage imageNamed:@"按钮"] forState:0];
            
            [YTLoginButton setTitle:@"登录" forState:0];
            
            [YTLoginButton setTintColor:[UIColor whiteColor]];
            
            YTLoginButton.titleLabel.font=[UIFont fontWithName:@"PingFangSC-Medium" size:20];
            
            
            [YTLoginButton addTarget:self action:@selector(YTLoginBtnClick) forControlEvents:UIControlEventTouchUpInside];
            
            [self.view addSubview:YTLoginButton];
            
            
            ZhuCeButton=[UIButton buttonWithType:UIButtonTypeCustom];
            ZhuCeButton.frame=CGRectMake(30, YTLoginButton.frame.origin.y+YTLoginButton.frame.size.height+10, 104, 30);
            [ZhuCeButton setTitle:@"手机快速注册" forState:0];
            [ZhuCeButton setTitleColor:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0] forState:0];
            ZhuCeButton.titleLabel.font=[UIFont fontWithName:@"PingFangSC-Medium" size:15];
            
            
            [ZhuCeButton addTarget:self action:@selector(YTZhuCeBtnClick) forControlEvents:UIControlEventTouchUpInside];
            
            [self.view addSubview:ZhuCeButton];
            
            
            ForgetButton=[UIButton buttonWithType:UIButtonTypeCustom];
            ForgetButton.frame=CGRectMake([UIScreen mainScreen].bounds.size.width-130, YTLoginButton.frame.origin.y+YTLoginButton.frame.size.height+10, 93, 30);
            [ForgetButton setTitle:@"忘记密码？" forState:0];
            [ForgetButton setTitleColor:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0] forState:0];
            ForgetButton.titleLabel.font=[UIFont fontWithName:@"PingFangSC-Medium" size:15];
            
            
            [ForgetButton addTarget:self action:@selector(YTForgetBtnClick) forControlEvents:UIControlEventTouchUpInside];
            
            [self.view addSubview:ForgetButton];
        }
        
        [self YanZhen];
        yt=@"200";
        
    }else{
       // [self YanZhen];
        //登录
        [self NewLogin];
    }
}
-(void)YanZhen
{
    
    if (YTUserNameTF.text.length == 0) {
        
        alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"用户名或密码不正确" preferredStyle:UIAlertControllerStyleAlert];
        [alertCon addAction: [UIAlertAction actionWithTitle: @"确认" style: UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
            [YTUserNameTF becomeFirstResponder];
            
        }]];
        [self presentViewController: alertCon animated: YES completion: nil];
        
        
        
    }else{
        
        if (YTUserNameTF.text.length < 4) {
            
            //用户名长度小于4
            alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"用户名或密码不正确" preferredStyle:UIAlertControllerStyleAlert];

            [alertCon addAction: [UIAlertAction actionWithTitle: @"确认" style: UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
                [YTUserNameTF becomeFirstResponder];
                
            }]];
            [self presentViewController: alertCon animated: YES completion: nil];
            
            
        }else{
            
            //用户名是否为字母加数字
            NSString *CM_NUM = @"^[A-Za-z0-9]+$";
            
            NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
            
            BOOL isMatch1 = [pred1 evaluateWithObject:YTUserNameTF.text];
            
            if (!isMatch1) {
                
                alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"用户名或密码不正确" preferredStyle:UIAlertControllerStyleAlert];
                [alertCon addAction: [UIAlertAction actionWithTitle: @"确认" style: UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    
                    [YTUserNameTF becomeFirstResponder];
                    
                }]];
                [self presentViewController: alertCon animated: YES completion: nil];
                
            }else{
                
                if (YTPassWordTF.text.length == 0) {
                    
                    alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"用户名或密码不正确" preferredStyle:UIAlertControllerStyleAlert];
                    [alertCon addAction: [UIAlertAction actionWithTitle: @"确认" style: UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                        
                        [YTPassWordTF becomeFirstResponder];
                        
                    }]];
                    [self presentViewController: alertCon animated: YES completion: nil];
                }else{
                    
                    if (YTPassWordTF.text.length < 6){
                        
                        alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"用户名或密码不正确" preferredStyle:UIAlertControllerStyleAlert];
                        [alertCon addAction: [UIAlertAction actionWithTitle: @"确认" style: UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                            
                            [YTPassWordTF becomeFirstResponder];
                            
                        }]];
                        [self presentViewController: alertCon animated: YES completion: nil];
                        
                        
                    }else{
                        
                        if([YTPassWordTF.text rangeOfString:@" "].location != NSNotFound){
                            
                            alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"用户名或密码不正确" preferredStyle:UIAlertControllerStyleAlert];
                            [alertCon addAction: [UIAlertAction actionWithTitle: @"确认" style: UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                                
                                [YTPassWordTF becomeFirstResponder];
                                
                            }]];
                            [self presentViewController: alertCon animated: YES completion: nil];
                            
                        }else{
                            if (YTMessageTF.text.length==0) {
                                
                                if ([yingCang isEqualToString:@"500"]) {
                                    
                                    yingCang=@"600";
                                    
                                }else{
                                    
                                    alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"验证码有误，请重新输入" preferredStyle:UIAlertControllerStyleAlert];
                                    [alertCon addAction: [UIAlertAction actionWithTitle: @"确认" style: UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                                        
                                        [YTMessageTF becomeFirstResponder];
                                        
                                    }]];
                                    [self presentViewController: alertCon animated: YES completion: nil];
                                }
                                
                                
                            }else{
                                
                                
                                NSString *astring01 = YTMessageTF.text;
                                NSString *astring02 = self.authcodeView.authcodeString;
                                
                                BOOL result = [astring01 compare:astring02
                                                         options:NSCaseInsensitiveSearch | NSNumericSearch] == NSOrderedSame;
                                NSLog(@"result:%d",result);
                                
                                if (!result) {
                                    
                                    alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"验证码有误，请重新输入" preferredStyle:UIAlertControllerStyleAlert];
                                    [alertCon addAction: [UIAlertAction actionWithTitle: @"确认" style: UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                                        
                                        [YTMessageTF becomeFirstResponder];
                                        
                                    }]];
                                    [self presentViewController: alertCon animated: YES completion: nil];
                                }else{
                                    
                                    //登录
                                    [self NewLogin];
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

-(void)NewLogin
{
    myProgressHum = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [myProgressHum hide:YES afterDelay:30.0];
    
    manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 30.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    NSDictionary *dic = @{@"phone":YTUserNameTF.text,@"password":YTPassWordTF.text};
    
    NSString *url = [NSString stringWithFormat:@"%@login_mob.shtml",URL_Str];
    
    [manager POST:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
        NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];
        
        if (codeKey && content) {
            NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
            
            
            
            NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];
            
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            
            
            
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
                    
                    
                    if ([dic1[@"portrait"] isEqual:null] || [dic1[@"portrait"] isEqualToString:@""]) {
                        
                        //缓存头像
                        
                        touxiang=@"头像";
                        
                    }else{
                        
                        //缓存头像
                        touxiang=dic1[@"portrait"];
                    }
                    
                    
                    
                    //实现反向传值
                    if (_delegate && [_delegate respondsToSelector:@selector(setSigenWithString:andStatusWithString:andIntegralWithString:andPhoneWithString:andHeaderImageWithString:andUserId: andUserName:)]) {
                        [_delegate setSigenWithString:dic1[@"sigen"] andStatusWithString:dic1[@"status"] andIntegralWithString:dic1[@"integral"] andPhoneWithString:dic1[@"phone"] andHeaderImageWithString:touxiang andUserId:dic1[@"userid"] andUserName:YTUserNameTF.text];
                    }
                    
                    
                    if (_delegate && [_delegate respondsToSelector:@selector(shuxingYT)]) {
                        
                        [_delegate shuxingYT];
                        
                    }
                    
                    
                    //缓存用户名
                    [UserMessageManager UserName:YTUserNameTF.text];
                    
                    [UserMessageManager UserNewName:YTUserNameTF.text];
                    
                    //缓存用户密码
                    [UserMessageManager UserPassWord:YTPassWordTF.text];
                    
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
                    
                    [KNotificationCenter postNotificationName:JMSHTLoginSuccessNoti object:nil];
                    NSString *userId=dic1[@"userid"];
                    
                    NSDictionary *dict10 =@{@"userid": userId};
                    
                    
                    //创建通知
                    NSNotification *notification =[NSNotification notificationWithName:@"yangtao" object:nil userInfo:dict10];
                    //通过通知中心发送通知
                    [[NSNotificationCenter defaultCenter] postNotification:notification];
                    
                }
                
                
                
                
                //通知购物车，加载数据
                
                //                NSNotification *TongZhiCartLoginSuccess = [[NSNotification alloc] initWithName:@"TongZhiCartLoginSuccess" object:nil userInfo:nil];
                //
                //                [[NSNotificationCenter defaultCenter] postNotification:TongZhiCartLoginSuccess];
                
                //缓存登录次数
                [UserMessageManager UserTime:self.again];
                
                if ([dic1[@"status"] isEqualToString:@"10000"]) {
                    
                    
                    [JRToast showWithText:@"登录成功" duration:1.0f];
                    
                    //通知购物车显示件数
                    NSNotification *changeCartNumber = [[NSNotification alloc] initWithName:@"LoginSuccessShowCartNumber" object:nil userInfo:nil];
                    
                    [[NSNotificationCenter defaultCenter] postNotification:changeCartNumber];
                    
                    
                    //缓存登录状态
                    [UserMessageManager LoginStatus:@"YES"];
                    
                    
                    //设置通知让其他界面接收数据
                    
                    //通知
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"postNumber" object:dic1[@"sigen"]];
                    
                    
                    self.sigen = dic1[@"sigen"];
                    
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
                        
                        
                        
                    }else if([self.backString isEqualToString:@"123"]){
                        
                        
                        if (_delegate && [_delegate respondsToSelector:@selector(LoginToBackCrat:)]) {
                            
                            [_delegate LoginToBackCrat:dic1[@"sigen"]];
                            
                        }
                        
                        BackCartViewController *vc = [[BackCartViewController alloc] init];
                        
                        vc.sigen=dic1[@"sigen"];
                        
                        vc.BackString = @"200";
                        
                        vc.jindu =self.jindu;
                        vc.weidu = self.weidu;
                        vc.MapStartAddress = self.MapStartAddress;
                        
                        //                        vc.delegate=self;
                        
                        self.navigationController.navigationBar.hidden=YES;
                        
                        [self.navigationController pushViewController:vc animated:NO];
                        
                        
                        
                        //                        [self.navigationController popViewControllerAnimated:YES];
                        
                        
                    }else if([self.backString isEqualToString:@"100"]){
                        
                        //恢复tabbar
                        self.tabBarController.tabBar.hidden=NO;
                        
                        PersonaViewController *vc=[[PersonaViewController alloc] init];
                        
                        self.navigationController.navigationBar.hidden=YES;
                        
                        [self.navigationController pushViewController:vc animated:NO];
                        
                        
                        
                    }else if([self.backString isEqualToString:@"426"]){
                        
                        
                        
                        NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:dic1[@"sigen"],@"textOne",dic1[@"status"],@"textThree",dic1[@"integral"],@"textFour",dic1[@"phone"],@"textFive",touxiang,@"textSix",dic1[@"userid"],@"textSeven",YTUserNameTF.text,@"textEight", nil];
                        
                        //创建通知
                        NSNotification *notification =[NSNotification notificationWithName:@"BMNotification" object:nil userInfo:dict];
                        //通过通知中心发送通知
                        [[NSNotificationCenter defaultCenter] postNotification:notification];
                        
                        
                        [self submitMoneyPay];
                        
                        
                    }else if([self.backString isEqualToString:@"612"]){
                        
                        AirPlaneReserveViewController *vc = [[AirPlaneReserveViewController alloc] init];
                        vc.Text = self.Text;
                        
                        
                        vc.time = self.time;
                        vc.flightNo = self.flightNo;
                        vc.GoBackString = self.GoBackString;
                        vc.CarrinerName = self.CarrinerName;
                        vc.Air_OffTime = self.Air_OffTime;
                        vc.ArriveTime = self.ArriveTime;
                        vc.Air_RunTime = self.Air_RunTime;
                        vc.Air_StartT = self.Air_StartT;
                        vc.Air_EndT = self.Air_EndT;
                        vc.Air_Meat = self.Air_Meat;
                        vc.Air_PlaneType = self.Air_PlaneType;
                        vc.Air_PlaneModel = self.Air_PlaneModel;
                        vc.Air_StartPortName = self.Air_StartPortName;
                        vc.Air_EndPortName = self.Air_EndPortName;
                        vc.DateWeek = self.DateWeek;
                        vc.TypeString = self.TypeString;
                        vc.OilString = self.OilString;
                        vc.Money = [NSString stringWithFormat:@"%d",[self.RanYou intValue] + [self.Price intValue]];
                        vc.RanYou = [NSString stringWithFormat:@"%d",[self.RanYou intValue]];
                        vc.Price = self.Price;
                        vc.TicketString = self.TicketString;
                        vc.ManOrKidString = self.ManOrKidString;
                        vc.Air_ByPass=self.Air_ByPass;
                        //支付参数
                        vc.Pay_shipping_space = self.Pay_shipping_space;
                        vc.Pay_is_tehui = self.Pay_is_tehui;
                        vc.Pay_is_spe = self.Pay_is_spe;
                        vc.Pay_price = self.Pay_price;
                        vc.Pay_cabin = self.Pay_cabin;
                        vc.Pay_bookpara = self.Pay_bookpara;
                        vc.Pay_run_time = self.Pay_run_time;
                        vc.Pay_start_time = self.Pay_start_time;
                        vc.Pay_arrive_time = self.Pay_arrive_time;
                        vc.Pay_start_airport = self.Pay_start_airport;
                        vc.Pay_start_terminal = self.Pay_start_terminal;
                        vc.Pay_arrive_airport = self.Pay_arrive_airport;
                        vc.Pay_arrive_terminal = self.Pay_arrive_terminal;
                        vc.Pay_airport_flight = self.Pay_airport_flight;
                        vc.Pay_airport_name = self.Pay_airport_name;
                        vc.Pay_airport_code = self.Pay_airport_code;
                        vc.Pay_is_quick_meal = self.Pay_is_quick_meal;
                        vc.Pay_plane_type = self.Pay_plane_type;
                        vc.Pay_airrax = self.Pay_airrax;
                        vc.Pay_fuel_oil = self.Pay_fuel_oil;
                        vc.refund_instructions = self.refund_instructions;
                        
                        vc.LoginBack = @"888";
                        
                        if (_delegate && [_delegate respondsToSelector:@selector(LoginToBackCrat:)]) {
                            
                            [_delegate LoginToBackCrat:dic1[@"sigen"]];
                            
                        }
                        
                        [self.navigationController pushViewController:vc animated:NO];
                        self.navigationController.navigationBar.hidden=YES;
                        
                        
                    }else if([self.backString isEqualToString:@"618"]){
                        
                        AirPlaneReserveGoBackViewController *vc = [[AirPlaneReserveGoBackViewController alloc] init];
                        vc.Text = self.Text;
                        
                        
                        vc.time = self.time;
                        vc.flightNo = self.flightNo;
                        vc.GoBackString = self.GoBackString;
                        vc.CarrinerName = self.CarrinerName;
                        vc.Air_OffTime = self.Air_OffTime;
                        vc.ArriveTime = self.ArriveTime;
                        vc.Air_RunTime = self.Air_RunTime;
                        vc.Air_StartT = self.Air_StartT;
                        vc.Air_EndT = self.Air_EndT;
                        vc.Air_Meat = self.Air_Meat;
                        vc.Air_PlaneType = self.Air_PlaneType;
                        vc.Air_PlaneModel = self.Air_PlaneModel;
                        vc.Air_StartPortName = self.Air_StartPortName;
                        vc.Air_EndPortName = self.Air_EndPortName;
                        vc.DateWeek = self.DateWeek;
                        vc.TypeString = self.TypeString;
                        vc.OilString = self.OilString;
                        vc.Money = [NSString stringWithFormat:@"%d",[self.RanYou intValue] + [self.Price intValue]];
                        vc.RanYou = [NSString stringWithFormat:@"%d",[self.RanYou intValue]];
                        vc.Price = self.Price;
                        vc.TicketString = self.TicketString;
                        vc.ManOrKidString = self.ManOrKidString;
                        vc.Air_ByPass=self.Air_ByPass;
                        //支付参数
                        vc.Pay_shipping_space = self.Pay_shipping_space;
                        vc.Pay_is_tehui = self.Pay_is_tehui;
                        vc.Pay_is_spe = self.Pay_is_spe;
                        vc.Pay_price = self.Pay_price;
                        vc.Pay_cabin = self.Pay_cabin;
                        vc.Pay_bookpara = self.Pay_bookpara;
                        vc.Pay_run_time = self.Pay_run_time;
                        vc.Pay_start_time = self.Pay_start_time;
                        vc.Pay_arrive_time = self.Pay_arrive_time;
                        vc.Pay_start_airport = self.Pay_start_airport;
                        vc.Pay_start_terminal = self.Pay_start_terminal;
                        vc.Pay_arrive_airport = self.Pay_arrive_airport;
                        vc.Pay_arrive_terminal = self.Pay_arrive_terminal;
                        vc.Pay_airport_flight = self.Pay_airport_flight;
                        vc.Pay_airport_name = self.Pay_airport_name;
                        vc.Pay_airport_code = self.Pay_airport_code;
                        vc.Pay_is_quick_meal = self.Pay_is_quick_meal;
                        vc.Pay_plane_type = self.Pay_plane_type;
                        vc.Pay_airrax = self.Pay_airrax;
                        vc.Pay_fuel_oil = self.Pay_fuel_oil;
                        vc.refund_instructions = self.refund_instructions;
                        
                        vc.LoginBack = @"888";
                        
                        
                        if (_delegate && [_delegate respondsToSelector:@selector(LoginToBackCrat:)]) {
                            
                            [_delegate LoginToBackCrat:dic1[@"sigen"]];
                            
                        }
                        
                        
                        [self.navigationController pushViewController:vc animated:NO];
                        self.navigationController.navigationBar.hidden=YES;
                        
                        
                    }else if([self.backString isEqualToString:@"719"]){
                        
                        TrainYuDingViewController *vc = [[TrainYuDingViewController alloc] init];
                        
                        vc.phone = [NSString stringWithFormat:@"%@",dic1[@"phone"]];
                        vc.StartCity = self.Train_StartCity;
                        vc.StartTime = self.Train_StartTime;
                        vc.ArriveCity = self.Train_ArriveCity;
                        vc.ArriveTime = self.Train_ArriveTime;
                        vc.CheCi = self.Train_CheCi;
                        vc.RunTime = self.Train_RunTime;
                        vc.from_station = self.Train_from_station;
                        vc.to_station = self.Train_to_station;
                        vc.DateString = self.Train_DateString;
                        vc.Name = self.Train_Name;
                        vc.Price = self.Train_Price;
                        vc.TicketCount = self.Train_TicketCount;
                        vc.PriceArray = self.Train_PriceArray;
                        vc.TypeString = self.Train_TypeString;
                        vc.zwcode = self.Train_zwcode;
                        vc.run_time = self.Train_run_time;
                        vc.che_type = self.Train_che_type;
                        vc.train_date = self.Train_train_date;
                        vc.is_accept_standing = self.Train_is_accept_standing;
                        vc.LoginBack = @"888";
                        
                        if (_delegate && [_delegate respondsToSelector:@selector(LoginToBackCrat:)]) {
                            
                            [_delegate LoginToBackCrat:dic1[@"sigen"]];
                            
                        }
                        
                        [self.navigationController pushViewController:vc animated:NO];
                        self.navigationController.navigationBar.hidden=YES;
                        
                        
                    }else if([self.backString isEqualToString:@"1234"])
                    {
                        PeccantViewController *vc=[[PeccantViewController alloc]init];
                        
                        [self.navigationController pushViewController:vc animated:NO];
                        
                        self.tabBarController.tabBar.hidden=YES;
                    }
                    else if([self.backString isEqualToString:@"520"]){
                        
                        
                        if (_delegate && [_delegate respondsToSelector:@selector(GoodsDetailReloadData:)]) {
                            
                            [_delegate GoodsDetailReloadData:dic1[@"sigen"]];
                            
                        }
                        self.navigationController.navigationBar.hidden=YES;
                        
                        [self.navigationController popViewControllerAnimated:YES];
                        
                        
                    }else if([self.backString isEqualToString:@"205"]){
                        
                        
                        if (_delegate && [_delegate respondsToSelector:@selector(LoginToTuWen:ID:)]) {
                            
                            [_delegate LoginToTuWen:dic1[@"sigen"] ID:self.gid];
                            
                        }
                        self.navigationController.navigationBar.hidden=YES;
                        
                        [self.navigationController popViewControllerAnimated:YES];
                        
                        
                    }else if([self.backString isEqualToString:@"300"]){
                        
                        
                        //发送通知，属性框消失，加入购物车成功！
                        
                        NSLog(@"==2===%@",self.choseView_gid);
                        NSLog(@"==2===%@",self.choseView_mid);
                        NSLog(@"==2===%@",self.choseView_NewGoods_Type);
                        NSLog(@"==2===%@",self.choseView_detailId);
                        NSLog(@"==2===%@",self.choseView_num);
                        NSLog(@"==2===%@",self.choseView_exchange);
                        
                        
                        if ([self.OOOOOOOOO isEqualToString:@"111"]) {
                            
                            
                            //添加 字典，将label的值通过key值设置传递
                            NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:dic1[@"sigen"],@"textOne",self.choseView_gid,@"textTwo",self.choseView_mid,@"textThree",self.choseView_num,@"textFour",self.choseView_NewGoods_Type,@"textFive",self.choseView_exchange,@"textSix",self.choseView_detailId,@"textSeven",self.choseView_NewGoods_Type,@"textEight", nil];
                            
                            
                            NSNotification *notification = [[NSNotification alloc] initWithName:@"AttribiteAddCart" object:nil userInfo:dict];
                            
                            //通过通知中心发送通知
                            [[NSNotificationCenter defaultCenter] postNotification:notification];
                            
                            [self.navigationController popViewControllerAnimated:NO];
                            
                        }else if ([self.OOOOOOOOO isEqualToString:@"222"]){
                            
                            
                            //立即购买跳确认订单
                            NSDictionary *dict1 =[[NSDictionary alloc] initWithObjectsAndKeys:dic1[@"sigen"],@"textOne",self.gid,@"textTwo",self.storename,@"textThree",self.logo,@"textFour",self.GoodsDetailType,@"textFive",self.Goods_Type_Switch,@"textSix",self.SendWayType,@"textSeven",self.MoneyType,@"textEight",self.midddd,@"textNine",self.yunfei,@"textTen",self.attributenum,@"textTen1",self.exchange,@"textTen2",self.detailId,@"textTen3", nil];
                            
                            
                            NSNotification *notification1 = [[NSNotification alloc] initWithName:@"AttribiteAddCart1" object:nil userInfo:dict1];
                            
                            //通过通知中心发送通知
                            [[NSNotificationCenter defaultCenter] postNotification:notification1];
                            
                            [self.navigationController popViewControllerAnimated:NO];
                            
                            
                        }else if ([self.OOOOOOOOO isEqualToString:@"333"]){
                            
                            
                            NSLog(@"==立即购买跳确认订单==self.midddd===%@",self.midddd);
                            
                            //                            //立即购买跳确认订单
                            //                            NSDictionary *dict2 =[[NSDictionary alloc] initWithObjectsAndKeys:dic1[@"sigen"],@"textOne",self.gid,@"textTwo",self.storename,@"textThree",self.logo,@"textFour",self.GoodsDetailType,@"textFive",self.Goods_Type_Switch,@"textSix",self.SendWayType,@"textSeven",self.MoneyType,@"textEight",self.midddd,@"textNine",self.yunfei,@"textTen",self.attributenum,@"textTen1",self.exchange,@"textTen2",self.detailId,@"textTen3", nil];
                            //
                            //                            NSNotification *notification2 = [[NSNotification alloc] initWithName:@"NowBuyGoToDingDan" object:nil userInfo:dict2];
                            //
                            //                            //通过通知中心发送通知
                            //                            [[NSNotificationCenter defaultCenter] postNotification:notification2];
                            
                            //进行限购处理
                            [self getDatas1];
                            
                        }else{
                            
                            
                            [self.navigationController popViewControllerAnimated:NO];
                            
                        }
                        
                        
                        
                        //=========================================================
                        
                        //                        self.tabBarController.tabBar.hidden=YES;
                        //                        [self.navigationController popViewControllerAnimated:YES];
                        
                        //=========================================================
                        
                    }else if([self.backString isEqualToString:@"333"]){
                        
                        
                        
                        
                        self.tabBarController.tabBar.hidden=NO;
                        
                        self.navigationController.navigationBar.hidden=YES;
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
                    
                    alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"用户名或密码不正确" preferredStyle:UIAlertControllerStyleAlert];
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
        
        [JRToast showWithText:@"网络请求失败，请检查你的网络设置" duration:3.0f];
        
        NSLog(@"PostDepartment Error %@",error);
    }];
}
//密码可见与不可见
-(void)YTButtonBtnClick:(UIButton *)sender
{
    
    sender.selected=!sender.selected;
    
    //去掉蓝色背景
    sender.tintColor=[UIColor clearColor];
    
    if (sender.selected) {
        
        YTPassWordTF.secureTextEntry = YES;
        
        YTImageView.image=[UIImage imageNamed:@"不可视"];
        
    }else{
        
        YTPassWordTF.secureTextEntry = NO;
        YTImageView.image=[UIImage imageNamed:@"可视"];
    }
}

-(void)YanBtnClick
{
    [self.authcodeView getAuthcode];
    [self.authcodeView setNeedsDisplay];
    
    NSLog(@"=====%@=======",self.authcodeView.authcodeString);
}
-(void)YTZhuCeBtnClick
{
    YTRegirstViewController *vc=[[YTRegirstViewController alloc] init];
    
    //    vc.delegate=self;
    
    [self.navigationController pushViewController:vc animated:NO];
    
    self.navigationController.navigationBar.hidden=YES;
    
}

-(void)YTForgetBtnClick
{
    
    NewForgotPassWordViewController *vc=[[NewForgotPassWordViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:NO];
    
    self.navigationController.navigationBar.hidden=YES;
}
/*******************************************************      协议方法       ******************************************************/
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    
    [YTUserNameTF resignFirstResponder];
    [YTPassWordTF resignFirstResponder];
    [YTMessageTF resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    
    [theTextField resignFirstResponder];
    
    return YES;
}
/*******************************************************      代码提取(多是复用代码)       ******************************************************/

-(void)setUserName:(NSString *)name andPassWord:(NSString *)password
{
    YTUserNameTF.text=name;
    
    YTPassWordTF.text=password;
}

-(void)submitMoneyPay
{
    
   
    manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@submitMoneyPay_mob.shtml",URL_Str];
    //saveUserExchange_mob.shtml
    
//    NSLog(@"===self.sigen==%@",self.sigen);
//    NSLog(@"===self.BianMinType==%@",self.BianMinType);
//    NSLog(@"===self.BianMinPhone==%@",self.BianMinPhone);
//    NSLog(@"===self.BianMinPrice==%@",self.BianMinPrice);
//    NSLog(@"===self.Commitcardid==%@",self.Commitcardid);
//    NSLog(@"===self.Commitcardnum==%@",self.Commitcardnum);
//    NSLog(@"===self.BianMinFlow_size==%@",self.BianMinFlow_size);
//    NSLog(@"===self.BianMinFlow_id==%@",self.BianMinFlow_id);
//    NSLog(@"===self.Commitgame_userid==%@",self.Commitgame_userid);
//    NSLog(@"===self.Commitcardname==%@",self.Commitcardname);
//    NSLog(@"===self.Commitgame_area==%@",self.Commitgame_area);
//    NSLog(@"===self.Commitgame_srv==%@",self.Commitgame_srv);
//    NSLog(@"===self.Commitis_traffic_permit==%@",self.Commitis_traffic_permit);
//    NSLog(@"===self.Commitid==%@",self.Commitid);
    
    
    NSDictionary *dic = @{@"sigen":self.sigen,@"type":self.BianMinType,@"phone":self.BianMinPhone,@"price":self.BianMinPrice,@"flow_size":self.BianMinFlow_size,@"flow_id":self.BianMinFlow_id,@"clientId":@"3",@"id":self.Commitid?self.Commitid:@"",@"cardid":self.Commitcardid?self.Commitcardid:@"",@"cardnum":self.Commitcardnum?self.Commitcardnum:@"",@"game_userid":self.Commitgame_userid?self.Commitgame_userid:@"",@"cardname":self.Commitcardname?self.Commitcardname:@"",@"game_area":self.Commitgame_area?self.Commitgame_area:@"",@"game_srv":self.Commitgame_srv?self.Commitgame_srv:@"",@"is_traffic_permit":self.Commitis_traffic_permit?self.Commitis_traffic_permit:@""};
    NSLog(@"dic=%@",dic);
    
    [manager POST:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
        NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];
        
        
        if (codeKey && content) {
            NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
            
            //            NSLog(@"xmlStr%@",xmlStr);
            
            
            NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            NSLog(@"分类查看更多书局=%@",dic);
            
            
            if ([dic[@"status"] isEqualToString:@"10000"]) {
                
                
                PhoneAndFlowPayViewController *vc=[[PhoneAndFlowPayViewController alloc] init];
                
                vc.Sigen=self.sigen;
                vc.integral = [NSString stringWithFormat:@"%@",dic[@"integral"]];
                vc.orderno = [NSString stringWithFormat:@"%@",dic[@"orderno"]];
                vc.pay_integral = [NSString stringWithFormat:@"%@",dic[@"pay_integral"]];
                vc.pay_money = [NSString stringWithFormat:@"%@",dic[@"pay_money"]];
                vc.price = [NSString stringWithFormat:@"%@",dic[@"price"]];
                vc.type = [NSString stringWithFormat:@"%@",dic[@"type"]];
                vc.Phone = self.BianMinPhone;
                vc.sta = [NSString stringWithFormat:@"%@",dic[@"sta"]];
                vc.proportion = [NSString stringWithFormat:@"%@",dic[@"proportion"]];
                if ([self.TitleString isEqualToString:@"100"]) {
                    
                    vc.title = @"话费充值";
                    
                }else if([self.TitleString isEqualToString:@"300"]){
                    
                    vc.title = @"游戏点卡";
                    
                }else{
                    
                    vc.title = @"流量充值";
                }
                
                self.navigationController.navigationBar.hidden=YES;
                
                [self.navigationController pushViewController:vc animated:NO];
                
                
            }else{
                
                
                [JRToast showWithText:dic[@"message"] duration:1.0f];
                [self.navigationController popViewControllerAnimated:NO];
            }

        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        
        NSLog(@"%@",error);
    }];
    
}


@end
