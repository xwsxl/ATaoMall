//
//  QueDingPayViewController.m
//  aTaohMall
//
//  Created by JMSHT on 16/5/16.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import "QueDingPayViewController.h"

#import "SelectPayCardViewController.h"//选择
#import "AddPayCardViewController.h"//添加

#import "AFNetworking.h"

//加密
#import "ConverUtil.h"
#import "DESUtil.h"
#import "SecretCodeTool.h"

#import "WKProgressHUD.h"

#import "MyRecordViewController.h"//支付记录

#import "PersonalShoppingDanDetailVC.h"
#import "PersonalAllDanVC.h"
#import "UserMessageManager.h"
@interface QueDingPayViewController ()<UIWebViewDelegate,UIAlertViewDelegate>
{
    UIWebView *_webView;
    UIAlertController *alertCon;
    UIView *view;
}

@end

@implementation QueDingPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor=[UIColor whiteColor];
    self.view.frame=[UIScreen mainScreen].bounds;
    self.returnurl = @"";
    self.creditBankJson = @"";
    self.orderName  = [NSString stringWithFormat: @"安淘惠"];
    self.orderDescription = [NSString stringWithFormat:@"支付"];
    
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-KSafeAreaTopNaviHeight)];
    [_webView setUserInteractionEnabled:YES];//是否支持交互
    _webView.delegate=self;
    [_webView setOpaque:NO];//opaque是不透明的意思
    [_webView setScalesPageToFit:YES];//自动缩放以适应屏幕
    [self.view addSubview:_webView];
    
    
    
    
    [self getDatas];
    
}


-(void)NoWebSeveice
{
    
    view=[[UIView alloc] initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    
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

-(void)getDatas
{
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数组NSArray类型的数据
    self.sigens=[userDefaultes stringForKey:@"sigen"];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@getReceiptAddress_mob.shtml",URL_Str];
    
    NSDictionary *dic = @{@"sigen":self.sigens};
    
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
            view.hidden=YES;
            NSLog(@"=====shouhuo==%@",dic);
            for (NSDictionary *dict1 in dic) {
                
                NSLog(@"=====dict1=ip]====%@===",dict1[@"ip"]);
                
                if ([dict1[@"status"] isEqualToString:@"10000"]) {
                    
                    NSString *ordername =  (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)self.orderName, nil, nil, kCFStringEncodingUTF8));
                    NSString *orderdes = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)self.orderDescription, nil, nil, kCFStringEncodingUTF8));
                    
                    //    NSString *strHttp = [NSString stringWithFormat:@"http://120.25.81.174:8093/qdb_pay.xhtml?appId=1006&clientId=04&pmoney=%@&out_trade_no=%@&ordername=%@&description=%@&returnurl=&notifyurl=%@&creditBankJson=&debitBankJson=%@", self.moneyCom, self.orderNo, ordername,orderdes,self.path, self.debitBankJson];
                    //    NSString *strHttp1 = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)strHttp, nil, nil, kCFStringEncodingUTF8));
                    //    strHttp = [strHttp stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                    
                    
                    //线上支付http://mb.dl.anzimall.com
                    //线下支付http://120.25.81.174:8093
                    
                    NSLog(@"====>>>>self.moneyCom>>>>>%@",self.moneyCom);
                    NSLog(@"====>>>>ip>>>>>%@",dict1[@"ip"]);
                    NSLog(@"====>>>>self.orderNo>>>>>%@",self.orderNo);
                    NSLog(@"====>>>>ordername>>>>>%@",ordername);
                    NSLog(@"====>>>>orderdes>>>>>%@",orderdes);
                    NSLog(@"====>>>>sself.path>>>>>%@",self.path);
                    NSLog(@"====>>>>self.debitBankJson>>>>>%@",self.debitBankJson);
                    NSLog(@"====>>>>successurl>>>>>%@",self.successurl);
                    
//            NSString *strHttp = [NSString stringWithFormat:@"http://athmall.com/pay/aliWapPay.shtml?"];
                    
//                    NSString *strHttp = [NSString stringWithFormat:@"http://120.25.81.174:8093/qdb_pay.xhtml"];
                    
                NSString *strHttp = [NSString stringWithFormat:@"http://120.25.81.174:8089/pay/aliWapPay.shtml"];
                    
                    NSURL *url = [NSURL URLWithString:strHttp];
 //                   NSString *postData = [NSString stringWithFormat:@"appId=1006&clientId=04&pmoney=%@&ip=%@&out_trade_no=%@&ordername=%@&description=%@&returnurl=&notifyurl=%@&creditBankJson=&debitBankJson=%@", self.moneyCom, dict1[@"ip"] , self.orderNo, ordername,orderdes,self.path, self.debitBankJson];
                    
                    NSString *postData = [NSString stringWithFormat:@"appId=1006&clientId=10003&pay_money=%@&ip=%@&pay_order=%@&ordername=%@&describe=%@&returnurl=%@&creditBankJson=&debitBankJson=%@&successurl=%@", self.moneyCom, dict1[@"ip"] , self.orderNo, ordername,orderdes,self.path, self.debitBankJson,self.successurl];
                    
                    
                    NSLog(@"=======%@",self.orderNo);
                    NSLog(@"=======%@",self.path);
                    NSLog(@"========%@",self.successurl);
                    
                    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
                    [request setHTTPMethod:@"POST"];
                    [request setHTTPBody:[postData dataUsingEncoding:NSUTF8StringEncoding]];
                    
                    
                    // NSURL *url = [NSURL URLWithString:[strHttp stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                    [_webView loadRequest:request];
                    
//                    
//                    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
//                    
//                    button.frame=CGRectMake(0, 618, [UIScreen mainScreen].bounds.size.width, 49);
//                    
//                    [button setTitle:@"返回上一级" forState:0];
//                    
//                    [button addTarget:self action:@selector(FanHUiBtmClick) forControlEvents:UIControlEventTouchUpInside];
//                    
//                    [self.view addSubview:button];
                    
                }else{
                    
                    alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:dict1[@"message"] preferredStyle:UIAlertControllerStyleAlert];
                    [alertCon addAction: [UIAlertAction actionWithTitle: @"确认" style: UIAlertActionStyleCancel handler:nil]];
                    [self presentViewController: alertCon animated: YES completion: nil];
                }
            }
            
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
//        [WKProgressHUD popMessage:@"网络请求失败，请检查您的网络设置" inView:self.view duration:1.5 animated:YES];
        
        [self NoWebSeveice];
        
        NSLog(@"%@",error);
    }];
}

-(void)loadData
{
    WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
    
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        [hud dismiss:YES];
    });
    
    [self getDatas];
}

-(void)FanHUiBtmClick
{
    [_webView goBack];
}
//返回
- (IBAction)backBtnClick:(UIButton *)sender {
    

    [UserMessageManager removeUserWord];
    
    
    //创建通知
    NSNotification *notification =[NSNotification notificationWithName:@"tongzhi" object:nil userInfo:nil];
    //通过通知中心发送通知
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    
    [self YTgetData];
    
    
//    [self.navigationController popViewControllerAnimated:YES];
    
//
}


-(void)YTgetData
{
    
    NSLog(@"========%@==",self.orderNo);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@getAliPayRecordByPayOrder.shtml",URL_Str];
    
    NSDictionary *dic = @{@"pay_order":self.orderNo};
    
    [manager POST:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
        NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];
        
        
        
        
        if (codeKey && content) {
            
            
            NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
            
            NSLog(@"===xmlStr%@",xmlStr);
            
            
            NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];
            
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            view.hidden=YES;
            NSLog(@"===TTTTTYYY==shouhuo==%@",dic);
            
                
                if ([dic[@"status"] isEqualToString:@"10000"]) {
                    
                    PersonalAllDanVC *vc=[[PersonalAllDanVC alloc] init];
                    [vc selectedDingDanType:@"0" AndIndexType:2];

                    PersonalShoppingDanDetailVC *vc2=[[PersonalShoppingDanDetailVC alloc] init];
                    XLDingDanModel *model=[[XLDingDanModel alloc] init];
                    model.order_batchid=self.orderNo;
                    vc2.delegate=vc;
                    vc2.myDingDanModel=model;
                    self.navigationController.viewControllers=@[self.navigationController.viewControllers.firstObject,vc,vc2];
                    [self.navigationController pushViewController:vc2 animated:NO];
                    self.navigationController.navigationBar.hidden=YES;
                    self.tabBarController.tabBar.hidden=YES;
                    
                    
                }else {
                    
                    [self.navigationController popViewControllerAnimated:YES];
                }
        
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //        [WKProgressHUD popMessage:@"网络请求失败，请检查您的网络设置" inView:self.view duration:1.5 animated:YES];
        
        [self NoWebSeveice];
        
        NSLog(@"%@",error);
    }];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
//    if (buttonIndex==0) {
//        
//        [self.navigationController popToViewController:self.navigationController.viewControllers[1] animated:YES];
//    }
}


//查看记录

- (IBAction)LookRecordBtnClick:(UIButton *)sender {
    
    
    NSLog(@"===支付记录==%@",self.sigens);
    
    
    MyRecordViewController *myVC=[[MyRecordViewController alloc] init];
    
    myVC.sigens1=self.sigens;
    
    
    //    BillPayViewController *billVC=[[BillPayViewController alloc] init];
    [self.navigationController pushViewController:myVC animated:YES];
    
}

@end
