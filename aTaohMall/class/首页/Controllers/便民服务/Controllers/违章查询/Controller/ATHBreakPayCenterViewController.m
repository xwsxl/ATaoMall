//
//  ATHBreakPayCenterViewController.m
//  违章查询
//
//  Created by JMSHT on 2017/7/27.
//  Copyright © 2017年 yt. All rights reserved.
//

#import "ATHBreakPayCenterViewController.h"
#import "ATHBreakRulesUpImgViewController.h"
#import "Order.h"
#import "APAuthV2Info.h"
#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>
#import "JRToast.h"
#import "PersonalAllDanVC.h"

#import "PersonalBMDetailVC.h"
@interface ATHBreakPayCenterViewController ()
{
    UILabel *PayLabel;
    UISwitch *Switch;
    UIWebView *webView;
    UIView *loadView;
}

@end

@implementation ATHBreakPayCenterViewController
/*******************************************************      控制器生命周期       ******************************************************/
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];
    
    //创建导航栏
    [self initNav];
    
    [self initManView];
    
    //支付界面
    [self initPayView];
    
}
/*******************************************************      初始化视图       ******************************************************/
//创建导航栏
-(void)initNav
{
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, KSafeAreaTopNaviHeight)];
    
    titleView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:titleView];
    
    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight-1, [UIScreen mainScreen].bounds.size.width, 1)];
    
    line.image = [UIImage imageNamed:@"分割线-拷贝"];
    
    [self.view addSubview:line];
    
    //返回按钮
    
    UIButton *Qurt = [UIButton buttonWithType:UIButtonTypeCustom];
    
    Qurt.frame = CGRectMake(10, 25+KSafeTopHeight, 30, 30);

    //    [Qurt setBackgroundImage:[UIImage imageNamed:@"iconfont-fanhui2yt"] forState:0];
    
    [Qurt setImage:[UIImage imageNamed:@"iconfont-fanhui2yt"] forState:0];
    
    [Qurt addTarget:self action:@selector(QurtBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [titleView addSubview:Qurt];
    
    //创建搜索
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 25+KSafeTopHeight, [UIScreen mainScreen].bounds.size.width-200, 30)];
    
    label.text = @"支付中心";
    
    label.textColor = [UIColor blackColor];
    
    label.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:19];
    
    label.textAlignment = NSTextAlignmentCenter;
    
    [titleView addSubview:label];
    
}
/*****
 *
 *  Description 付费详细
 *
 ******/
-(void)initManView
{
    
    NSArray *array = @[@"罚金",@"滞纳金",@"服务费"];
    NSArray *array1 = @[self.orderModel.fineMoney,_orderModel.lateMoney,_orderModel.serviceFee];
    
    for (int i = 0; i < array.count; i++) {
        
        UIView *ManView = [[UIView alloc] initWithFrame:CGRectMake(0, 70+KSafeTopHeight + 50*i, [UIScreen mainScreen].bounds.size.width, 50)];
        ManView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:ManView];
        
        UILabel *NameLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 18, ([UIScreen mainScreen].bounds.size.width-30)/2, 14)];
        NameLabel.text = array[i];
        NameLabel.numberOfLines=1;
        NameLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        NameLabel.font  =[UIFont fontWithName:@"PingFang-SC-Regular" size:14];
        [ManView addSubview:NameLabel];
        
        UILabel *NumberLabel = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-215, 18, 200, 14)];
        NumberLabel.text = [NSString stringWithFormat:@"￥%@",array1[i]];
        NumberLabel.numberOfLines=1;
        NumberLabel.textAlignment = NSTextAlignmentRight;
        NumberLabel.textColor = [UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
        NumberLabel.font  =[UIFont fontWithName:@"PingFang-SC-Regular" size:15];
        [ManView addSubview:NumberLabel];
        
        UIImageView *line = [[UIImageView alloc] init];
        
        if (i==array.count-1) {
            
           line.frame = CGRectMake(0, 49, [UIScreen mainScreen].bounds.size.width, 1);
            
        }else{
            
           line.frame = CGRectMake(15, 49, [UIScreen mainScreen].bounds.size.width-15, 1);
            
        }
        
        line.image = [UIImage imageNamed:@"分割线-拷贝"];
        [ManView addSubview:line];
    }
    
    UIView *ZhiFuBao = [[UIView alloc] initWithFrame:CGRectMake(0, 70 + 50*array.count+9+KSafeTopHeight, [UIScreen mainScreen].bounds.size.width, 71)];
    ZhiFuBao.backgroundColor=[UIColor whiteColor];
    
    [self.view addSubview:ZhiFuBao];
    
    UIImageView *line3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 1)];
    
    line3.image = [UIImage imageNamed:@"分割线-拷贝"];
    
    [ZhiFuBao addSubview:line3];
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(15, (71-18)/2, 70, 18)];
    imgView.image = [UIImage imageNamed:@"支付宝"];
    [ZhiFuBao addSubview:imgView];
    
    UIImageView *imgView1 = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-30, (71-12)/2, 12, 12)];
    imgView1.image = [UIImage imageNamed:@"选中425"];
    [ZhiFuBao addSubview:imgView1];
    
    UIImageView *line4 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 70, [UIScreen mainScreen].bounds.size.width, 1)];
    
    line4.image = [UIImage imageNamed:@"分割线-拷贝"];
    
    [ZhiFuBao addSubview:line4];
    
    UIView *IntegerView = [[UIView alloc] initWithFrame:CGRectMake(0, 70+50*array.count+9+71+10+KSafeTopHeight, [UIScreen mainScreen].bounds.size.width, 70)];
    IntegerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:IntegerView];
    
    UIImageView *line5 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 1)];
    
    line5.image = [UIImage imageNamed:@"分割线-拷贝"];
    
    [IntegerView addSubview:line5];
    
    UILabel *IntegerLabel = [[UILabel alloc] initWithFrame:CGRectMake(17, 19, 200, 12)];
    ;
    IntegerLabel.text = [NSString stringWithFormat:@"使用 %@ 积分兑现￥%@",_orderModel.deductionIntegral,_orderModel.deductionIntegral];
    IntegerLabel.numberOfLines=1;
    IntegerLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    IntegerLabel.font  =[UIFont fontWithName:@"PingFang-SC-Regular" size:12];
    [IntegerView addSubview:IntegerLabel];
    
    NSString *stringForColor1 = @"200";
    
    // 创建对象.
    NSMutableAttributedString *mAttStri1 = [[NSMutableAttributedString alloc] initWithString:IntegerLabel.text];
    //
    NSRange range1 = [IntegerLabel.text rangeOfString:stringForColor1];
    
    [mAttStri1 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:10] range:range1];
    IntegerLabel.attributedText=mAttStri1;
    
    UILabel *Integer = [[UILabel alloc] initWithFrame:CGRectMake(17, 45, 300, 14)];
    
    Integer.text = [NSString stringWithFormat:@"(你有%@积分，最多可使用%@积分)",_orderModel.userIntegral,_orderModel.deductionIntegral];
    Integer.numberOfLines=1;
    Integer.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
    Integer.font  =[UIFont fontWithName:@"PingFang-SC-Regular" size:12];
    [IntegerView addSubview:Integer];
    
    Switch =[[UISwitch alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-60, (70-30)/2, 50, 30)];
    Switch.on = YES;
    [Switch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];   // 开关事件切换通知
    
    [IntegerView addSubview:Switch];
    
    UIImageView *line6 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 69, [UIScreen mainScreen].bounds.size.width, 1)];
    
    line6.image = [UIImage imageNamed:@"分割线-拷贝"];
    
    [IntegerView addSubview:line6];
}
/*****
 *
 *  Description 缴费按钮
 *
 ******/
-(void)initPayView
{
    UIImageView *line2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-51-KSafeAreaBottomHeight, [UIScreen mainScreen].bounds.size.width, 1)];
    line2.image = [UIImage imageNamed:@"分割线-拷贝"];
    [self.view addSubview:line2];
    
    UIView *PayView = [[UIView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-50-KSafeAreaBottomHeight, [UIScreen mainScreen].bounds.size.width, 50)];
    PayView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:PayView];
    
    
    UIButton *PayButton = [UIButton buttonWithType:UIButtonTypeCustom];
    PayButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-101, 0, 101, 50);
    [PayButton setTitle:@"支付" forState:0];
    [PayButton setTitleColor:[UIColor whiteColor] forState:0];
    PayButton.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15];
    PayButton.backgroundColor = [UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
    [PayButton addTarget:self action:@selector(payBtnCLick) forControlEvents:UIControlEventTouchUpInside];
    [PayView addSubview:PayButton];
    
    PayLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, (50-20)/2, [UIScreen mainScreen].bounds.size.width-15-101-20, 20)];
    float money=[_orderModel.fineMoney floatValue]+[_orderModel.lateMoney floatValue]+[_orderModel.serviceFee floatValue]-[_orderModel.deductionIntegral floatValue];
    NSString *stringForColor1 =[NSString stringWithFormat:@"%.2f",money];
    PayLabel.text = [NSString stringWithFormat: @"已选%@条,总计%@元",_count,stringForColor1];
    PayLabel.numberOfLines=1;
    PayLabel.textAlignment = NSTextAlignmentRight;
    PayLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    PayLabel.font  =[UIFont fontWithName:@"PingFang-SC-Regular" size:15];
    [PayView addSubview:PayLabel];
    
    NSString *stringForColor = _count;
    
    // 创建对象.
    NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:PayLabel.text];
    //
    NSRange range = [PayLabel.text rangeOfString:stringForColor];
    NSRange range1 = [PayLabel.text rangeOfString:stringForColor1];
    
    [mAttStri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0] range:range];
    [mAttStri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0] range:range1];
    
    PayLabel.attributedText=mAttStri;
    
    
}


/*******************************************************      数据请求       ******************************************************/
//支付
-(void)payBtnCLick
{
    
    CGRect frame = CGRectMake(0, 65+60, 80, 80);
    frame.size = [UIImage imageNamed:@"ring-alt(1).gif"].size;
    // 读取gif图片数据
    NSData *gif = [NSData dataWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"ring-alt(1)" ofType:@"gif"]];
    // view生成
    webView = [[UIWebView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-frame.size.width)/2, ([UIScreen mainScreen].bounds.size.height-frame.size.height)/2, frame.size.width, frame.size.height)];
    
    webView.backgroundColor = [UIColor clearColor];
    [webView setOpaque:NO];
    webView.userInteractionEnabled = NO;//用户不可交互
    [webView loadData:gif MIMEType:@"image/gif" textEncodingName:nil baseURL:nil];
    [self.view addSubview:webView];
    
    loadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    loadView.backgroundColor = [UIColor blackColor];
    
    loadView.alpha = 0.2;
    
    [self.view addSubview:loadView];
    

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@illegalPay_mob.shtml",URL_Str];
    
    NSDictionary *params=@{@"sigen":[[NSUserDefaults standardUserDefaults] objectForKey:@"sigen"],@"orderno":_orderModel.orderNo,@"payintegral":Switch.on==YES?_orderModel.deductionIntegral:@"0"};
    
    [manager POST:url parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
        
        NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];
        
        if (codeKey && content) {
            
            NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
            
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
            
            NSLog(@"xmlStr==%@",xmlStr);
            
            NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
           
            NSLog(@"dic=%@",dic);
            NSNull *null = [[NSNull alloc] init];
            
            if ([dic[@"status"] isEqualToString:@"10000"])
           
            {
              
                
                self.PayType =[NSString stringWithFormat:@"%@", dic[@"type"]];
                
                self.Status=[NSString stringWithFormat:@"%@",dic[@"status"]];
                
                self.successurl=[NSString stringWithFormat:@"%@",dic[@"successurl"]];
                
                self.APP_ID =[NSString stringWithFormat:@"%@", dic[@"APP_ID"]];
                
                self.SELLER = [NSString stringWithFormat:@"%@",dic[@"SELLER"]];
                
                self.RSA_PRIVAT = [NSString stringWithFormat:@"%@",dic[@"RSA_PRIVAT"]];
                
                self.Pay_orderno = [NSString stringWithFormat:@"%@",dic[@"orderno"]];
                
                self.Notify_url = [NSString stringWithFormat:@"%@",dic[@"notify_url"]];
                
                self.ALiPay_money = [NSString stringWithFormat:@"%@",dic[@"pay_money"]];
                
                self.Money_url = [NSString stringWithFormat:@"%@",dic[@"money"]];
                
                self.Return_url = [NSString stringWithFormat:@"%@",dic[@"returnurl"]];
                
                if ([[NSString stringWithFormat:@"%@",dic[@"type"]] isEqualToString:@"2"] && ![[NSString stringWithFormat:@"%@",dic[@"money"]] isEqualToString:@""] && ![[NSString stringWithFormat:@"%@",dic[@"money"]] isEqual:null]){//组合支付
                    
                    //调用支付宝支付
                    
                    [self saveAlipayRecord];
                    
                    
                }
                
//                ATHBreakRulesOrderDetailViewController *vc = [[ATHBreakRulesOrderDetailViewController alloc] init];
//                vc.sta= @"2";//交易成功
//                vc.orderNo=[NSString stringWithFormat:@"%@",dic[@"orderno"]];
//                [self.navigationController pushViewController:vc animated:NO];
//                self.navigationController.navigationBar.hidden = YES;
          
            }
            
            else{
                [TrainToast showWithText:[NSString stringWithFormat:@"%@",dic[@"message"]] duration:2.0];
            }
            
        }
        if (webView.superview!=nil) {
            [webView removeFromSuperview];
        }
        if (loadView.superview!=nil) {
            [loadView removeFromSuperview];
        }

    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        if (webView.superview!=nil) {
            [webView removeFromSuperview];
        }
        if (loadView.superview!=nil) {
            [loadView removeFromSuperview];
        }

    }];
    
}
-(void)saveAlipayRecord
{
    
//    WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
    
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        
    });
    
    NSLog(@"====self.Pay_orderno=====%@",self.Pay_orderno);
    NSLog(@"====self.Money_url=====%@",self.Money_url);
    NSLog(@"====self.Return_url=====%@",self.Return_url);
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@saveAlipayRecord.shtml",URL_Str1];
    //saveUserExchange_mob.shtml
    
    
    NSDictionary *dic = @{@"pay_order":self.Pay_orderno,@"pay_money":self.Money_url,@"clientId":@"10003",@"describe":@"IOS",@"returnurl":self.Return_url};
    
    //        NSDictionary *dic=nil;
    //        NSDictionary *dic = @{@"classId":@"129"};
    [manager POST:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
        NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];
        
        if (codeKey && content) {
            NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
            
            
            
            NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];
            
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            NSLog(@"========保存支付宝信息==%@",dic);
            
            for (NSDictionary *dict1 in dic) {
                
                self.Alipay_Goods_name =[NSString stringWithFormat:@"%@",dict1[@"goods_name"]];
                
                if ([dict1[@"status"] isEqualToString:@"10000"]) {
                    
//                    //创建通知，区分是分机票，还是其他，是飞机票，跳团部订单
//                    NSNotification *notification1 = [[NSNotification alloc] initWithName:@"FJPNSNotification" object:nil userInfo:nil];
//                    
//                    //通过通知中心发送通知
//                    [[NSNotificationCenter defaultCenter] postNotification:notification1];
//                    
//                    [hud dismiss:YES];
                    
                    [self GoALiPay];
                    
                    
                }else{
                    
//                    [hud dismiss:YES];
//                    
//                    [JRToast showWithText:dict1[@"message"] duration:2.0f];
                }
            }
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //        [WKProgressHUD popMessage:@"网络请求失败，请检查您的网络设置" inView:self.view duration:1.5 animated:YES];
        //        [self NoWebSeveice];
        
//        [hud dismiss:YES];
        
        NSLog(@"%@",error);
    }];
    
    
    
}
-(void)GoALiPay
{
    
    
    //    [UserMessageManager removeUserWord];
    
    NSLog(@"===self.APP_ID===%@===self.SELLER=%@===self.RSA_PRIVAT=%@==self.Pay_money===%@==self.Pay_orderno===%@==self.Notify_url==%@",self.APP_ID,self.SELLER,self.RSA_PRIVAT,self.Pay_money,self.Pay_orderno,self.Notify_url);
    //重要说明
    //这里只是为了方便直接向商户展示支付宝的整个支付流程；所以Demo中加签过程直接放在客户端完成；
    //真实App里，privateKey等数据严禁放在客户端，加签过程务必要放在服务端完成；
    //防止商户私密数据泄露，造成不必要的资金损失，及面临各种安全风险；
    /*============================================================================*/
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
    //    NSString *appID = @"2016102002254231";
    
    NSString *appID = self.APP_ID;
    
    //    NSString *privateKey = @"MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBAMTmGiHlcAdESK9KcP7vmvSS8uO75JBW+O5ruS1SD+iuWRfFiBplBkZJ57a/LFRwZDvaC/7klSXTRhn4KbHuVfIGXc3j6F1BpWkh7Cks8FOGb86o5wHbbsLWC6JmMAhTIypcIuREKWQ5a9219GTzG/PhBeNdg+EklvlFyr3rCBlRAgMBAAECgYEAsWNoma8eDb3sCdh0EomFPeCB6L/nPE7Ot+XfD8CFyqgAZhU0+CqZy4tbsV1sL6qN8woPkpUW9dvwpQbZcY76Z5uQ29w6NyXn20rqlcw2qNUPCgxagHAKVohQSFpMl3hj2L2Nw1q3KapwVkZ918r5ksLUBrlb3cCBo9WdxtyAGB0CQQDpgsz4TPAXA4jFfAD3FMxoom3Xdy+AJC43sGflUTyureqL0g/xHTB4CQW9n2ygGn9qk+Now08tV0J6RRrJ7zNjAkEA19yhy90/NwdHBpOK/6dGzweSud+hZx7UYNy4JhC9pppVP5ECNnJC7rnN3BIMuIKSkr8DwKi6HSn5Bgo7uRkwuwJAT9kEUdutNZFl0XHHurWH+Deiq8z7lyvICg7uWAHhaDHcRBd+kApVKpabOe4r7MtiyoTrfEVc67os5zZ+JJMA1QJAM83PRo2iTiKA+SMPiKssYyL+I313zrenYFeYGgqKeSEwtECot0hUp9YPgXETfHRZmL4euG3FvJoGGVz7WECjYQJBAL8W1pQpZcUgLppoSwgsjitLv1Xe0GNWJm0vql7zCLsAMF7+w1fY3LHuJP/RfHDX5aswfSa/s7Ox6iV5MSlgGnk=";
    
    NSString *privateKey = self.RSA_PRIVAT;
    
    /*============================================================================*/
    /*============================================================================*/
    /*============================================================================*/
    
    //partner和seller获取失败,提示
    if ([appID length] == 0 ||
        [privateKey length] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"缺少appId或者私钥。"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    Order* order = [Order new];
    
    // NOTE: app_id设置
    order.app_id = appID;
    
    // NOTE: 支付接口名称
    order.method = @"alipay.trade.app.pay";
    
    // NOTE: 参数编码格式
    order.charset = @"utf-8";
    
    
    //回调
    order.notify_url=self.Notify_url;
    
    // NOTE: 当前时间点
    NSDateFormatter* formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    order.timestamp = [formatter stringFromDate:[NSDate date]];
    
    // NOTE: 支付版本
    order.version = @"2.0";
    
    // NOTE: sign_type设置
    order.sign_type = @"RSA";
    
    order.return_url = self.successurl;
    
    // NOTE: 商品数据
    order.biz_content = [BizContent new];
    order.biz_content.body = @"安淘惠";
    order.biz_content.subject = self.Alipay_Goods_name;
    
    //    order.biz_content.out_trade_no = [self generateTradeNO]; //订单ID（由商家自行制定）
    order.biz_content.out_trade_no = self.Pay_orderno; //订单ID（由商家自行制定）
    
    //order.biz_content.timeout_express = @"30m"; //超时时间设置
    order.biz_content.total_amount = [NSString stringWithFormat:@"%.02f", [self.ALiPay_money floatValue]]; //商品价格
    if (ISTEXTPRICE) {
        order.biz_content.total_amount = [NSString stringWithFormat:@"%.02f", 0.01]; //商品价格
    }
    //将商品信息拼接成字符串
    NSString *orderInfo = [order orderInfoEncoded:NO];
    NSString *orderInfoEncoded = [order orderInfoEncoded:YES];
    NSLog(@"orderSpec = %@",orderInfo);
    
    // NOTE: 获取私钥并将商户信息签名，外部商户的加签过程请务必放在服务端，防止公私钥数据泄露；
    //       需要遵循RSA签名规范，并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    NSString *signedString = [signer signString:orderInfo];
    
    // NOTE: 如果加签成功，则继续执行支付
    if (signedString != nil) {
        //应用注册scheme,在AliSDKDemo-Info.plist定义URL types
        NSString *appScheme = @"aTaohPay";
        
        // NOTE: 将签名成功字符串格式化为订单字符串,请严格按照该格式
        NSString *orderString = [NSString stringWithFormat:@"%@&sign=%@",
                                 orderInfoEncoded, signedString];
        
        // NOTE: 调用支付结果开始支付
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            
            
            
            NSLog(@"reslut =飞机票单程付款==%@",resultDic);
            
            if ([resultDic[@"resultStatus"] isEqualToString:@"9000"]) {
                
                NSString *codeKey = [SecretCodeTool getDesCodeKey:_orderModel.orderNo];
                NSString *content = [SecretCodeTool getReallyDesCodeString:_orderModel.orderNo];
                
                PersonalBMDetailVC *vc = [[PersonalBMDetailVC alloc] initWithOrderBatchid:[DesUtil decryptUseDES:content key:codeKey] AndOrderType:@"6"];
                PersonalAllDanVC *vc2=[[PersonalAllDanVC alloc]init];
                [vc2 selectedDingDanType:@"1" AndIndexType:2];
                vc.delegate=vc2;

                NSArray *arr=@[self.navigationController.viewControllers.firstObject,vc2,vc];
                
                self.navigationController.viewControllers=arr;
                [self.navigationController pushViewController:vc animated:NO];
                self.navigationController.navigationBar.hidden = YES;
            
            }else if ([resultDic[@"resultStatus"] isEqualToString:@"8000"]){
                
                [JRToast showWithText:@"正在处理中" duration:2.0f];
                
            }else if ([resultDic[@"resultStatus"] isEqualToString:@"4000"]){
                
                
                [JRToast showWithText:@"订单支付失败" duration:2.0f];
                
            }else if ([resultDic[@"resultStatus"] isEqualToString:@"6001"]){
                
                [JRToast showWithText:@"用户中途取消" duration:2.0f];
                NSString *codeKey = [SecretCodeTool getDesCodeKey:_orderModel.orderNo];
                NSString *content = [SecretCodeTool getReallyDesCodeString:_orderModel.orderNo];
                PersonalBMDetailVC *vc = [[PersonalBMDetailVC alloc] initWithOrderBatchid:[DesUtil decryptUseDES:content key:codeKey] AndOrderType:@"6"];
                PersonalAllDanVC *vc2=[[PersonalAllDanVC alloc]init];
                [vc2 selectedDingDanType:@"1" AndIndexType:1];
                vc.delegate=vc2;
                NSArray *arr=@[self.navigationController.viewControllers.firstObject,vc2,vc];

                self.navigationController.viewControllers=arr;
                [self.navigationController pushViewController:vc animated:NO];
                self.navigationController.navigationBar.hidden = YES;
                
        
            }else if ([resultDic[@"resultStatus"] isEqualToString:@"6002"]){
                
                [JRToast showWithText:@"网络连接出错" duration:2.0f];
                
              
            }
            
            return;
        }];
        //
        
//        NSString *codeKey = [SecretCodeTool getDesCodeKey:_orderModel.orderNo];
//        NSString *content = [SecretCodeTool getReallyDesCodeString:_orderModel.orderNo];
//        
//        ATHBreakRulesOrderDetailViewController *vc = [[ATHBreakRulesOrderDetailViewController alloc] init];
//        //  vc.sta= @"2";//交易成功
//        vc.orderNo=[DesUtil decryptUseDES:content key:codeKey];
//        [self.navigationController pushViewController:vc animated:NO];
//        self.navigationController.navigationBar.hidden = YES;
        
    }
    
    
}
/*******************************************************      各种Button执行方法、页面跳转     ******************************************************/
/*****
 *
 *  Description 是否使用积分
 *
 ******/
-(void)switchAction:(id)sender
{
    
    UISwitch *switchButton = (UISwitch*)sender;
    BOOL isButtonOn = [switchButton isOn];
    if (isButtonOn) {
        NSLog(@"开");
        float money=[_orderModel.fineMoney floatValue]+[_orderModel.lateMoney floatValue]+[_orderModel.serviceFee floatValue]-[_orderModel.deductionIntegral floatValue];
        NSString *stringForColor1 =[NSString stringWithFormat:@"%.2f",money];
        PayLabel.text = [NSString stringWithFormat: @"已选%@条,总计%@元",_count,stringForColor1];
        
        NSString *stringForColor = _count;
        
        // 创建对象.
        NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:PayLabel.text];
        //
        NSRange range = [PayLabel.text rangeOfString:stringForColor];
        NSRange range1 = [PayLabel.text rangeOfString:stringForColor1];
        
        [mAttStri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0] range:range];
        [mAttStri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0] range:range1];
        
        PayLabel.attributedText=mAttStri;
        
    }else {
        NSLog(@"关");
        float money=[_orderModel.fineMoney floatValue]+[_orderModel.lateMoney floatValue]+[_orderModel.serviceFee floatValue];
        NSString *stringForColor1 =[NSString stringWithFormat:@"%.2f",money];
        PayLabel.text = [NSString stringWithFormat: @"已选%@条,总计%@元",_count,stringForColor1];
        NSString *stringForColor = _count;
        
        // 创建对象.
        NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:PayLabel.text];
        //
        NSRange range = [PayLabel.text rangeOfString:stringForColor];
        NSRange range1 = [PayLabel.text rangeOfString:stringForColor1];
        
        [mAttStri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0] range:range];
        [mAttStri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0] range:range1];
        
        PayLabel.attributedText=mAttStri;
    }
    
}
//返回
-(void)QurtBtnClick
{
    
    [self.navigationController popViewControllerAnimated:NO];
    
}



@end
