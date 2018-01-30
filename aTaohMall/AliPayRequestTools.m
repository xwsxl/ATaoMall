//
//  AliPayRequestTools.m
//  aTaohMall
//
//  Created by DingDing on 2017/8/22.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "AliPayRequestTools.h"
#import "Order.h"
#import "APAuthV2Info.h"
#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>
#import "WKProgressHUD.h"
#import "SVProgressHUD.h"
#import "PersonalAllDanVC.h"
static AliPayRequestTools *aliPayTool=nil;

@interface AliPayRequestTools()
{
    WKProgressHUD *hud;
}

@end
@implementation AliPayRequestTools

-(void)ContinuePayWithOrderNum:(NSString *)orderNum OnViewController:(UIViewController *)VC AndResponseSuccess:(Success)success failed:(Failure)failed
{
    // self.orderno=orderNum;
    self.order_batchid=orderNum;
    [self goPayWithResponseSuccess:^(NSDictionary *responseObj) {
        success(responseObj);
    } OnViewController:VC failed:^(NSError *error) {
        failed(error);
    }];
}

-(void)BMContinuePayWithOrderNum:(NSString *)orderNum OnViewController:(UIViewController *)VC AndResponseSuccess:(Success)success failed:(Failure)failed
{
    // self.orderno=orderNum;
    self.order_batchid=orderNum;
    [self goBMPayWithResponseSuccess:^(NSDictionary *responseObj) {
        success(responseObj);
    } OnViewController:VC failed:^(NSError *error) {
       // YLog(@"%@",error.localizedDescription);
        failed(error);
    }];
}

-(void)goBMPayWithResponseSuccess:(Success)success OnViewController:(UIViewController *)VC failed:(Failure)failed
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    hud=[WKProgressHUD showInView:VC.view animated:YES];

    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *url = [NSString stringWithFormat:@"%@orderPaymentBy_BM_mob.shtml",URL_Str];
    NSDictionary *dic = @{@"sigen":[kUserDefaults objectForKey:@"sigen"],@"orderno":self.order_batchid,@"clientId":@"04"};
    [manager POST:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
        NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];

        if (codeKey && content) {
            NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];

            //NSLog(@"xmlStr%@",xmlStr);


            NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];


            NSDictionary *dict1 = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];

            NSLog(@"付款dic=%@",dict1);

            [SVProgressHUD dismiss];


            self.status=dict1[@"status"];
            self.message=dict1[@"message"];
            self.debitBankJson=dict1[@"debitBankJson"];
            self.description1=dict1[@"description"];
            self.notifyurl=dict1[@"notifyurl"];
            self.ordername=dict1[@"ordername"];
            self.out_trade_no=dict1[@"out_trade_no"];
            self.pmoney=dict1[@"pmoney"];

            self.successurl=dict1[@"successurl"];


            self.APP_ID = dict1[@"APP_ID"];

            self.SELLER = dict1[@"SELLER"];

            self.RSA_PRIVAT = dict1[@"RSA_PRIVAT"];

            self.Pay_orderno = dict1[@"out_trade_no"];

            self.Notify_url = dict1[@"notify_url"];

            self.Pay_money = dict1[@"pay_money"];

            self.Money_url = dict1[@"pmoney"];

            self.Return_url = dict1[@"returnurl"];



            if ([self.status isEqualToString:@"10000"]) {

                [self saveAlipayRecordWithResponseSuccess:^(NSDictionary *responseObj) {
                    success(responseObj);
                } OnViewController:VC failed:^(NSError *error) {
                    failed(error);

                }];

            }else if ([self.status isEqualToString:@"10006"]){

                [hud dismiss:YES];
                NSError *error=[[NSError alloc] init];
                failed(error);
                [UIAlertTools showAlertWithTitle:@"" message:self.message cancelTitle:@"知道了" titleArray:nil viewController:VC confirm:^(NSInteger buttonTag) {

                }];

            }

            else{
                [hud dismiss:YES];

                NSError *error=[[NSError alloc] init];
                failed(error);
                [TrainToast showWithText:self.message duration:2.0];

            }
        }
        else
        {
            [hud dismiss:YES];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failed(error);
        [hud dismiss:YES];
    }];

}




-(void)goPayWithResponseSuccess:(Success)success OnViewController:(UIViewController *)VC failed:(Failure)failed
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    hud=[WKProgressHUD showInView:VC.view animated:YES];

    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *url = [NSString stringWithFormat:@"%@orderPayment_mob.shtml",URL_Str];
    NSDictionary *dic = @{@"sigen":[kUserDefaults objectForKey:@"sigen"],@"order_batchid":self.order_batchid,@"clientId":@"04"};
    [manager POST:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
        NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];

        if (codeKey && content) {
            NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];

            //NSLog(@"xmlStr%@",xmlStr);


            NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];


            NSDictionary *dict1 = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];

            NSLog(@"付款dic=%@",dict1);
            [SVProgressHUD dismiss];


            self.status=dict1[@"status"];
            self.message=dict1[@"message"];
            self.debitBankJson=dict1[@"debitBankJson"];
            self.description1=dict1[@"description"];
            self.notifyurl=dict1[@"notifyurl"];
            self.ordername=dict1[@"ordername"];
            self.out_trade_no=dict1[@"out_trade_no"];
            self.pmoney=dict1[@"pmoney"];

            self.successurl=dict1[@"successurl"];


            self.APP_ID = dict1[@"APP_ID"];

            self.SELLER = dict1[@"SELLER"];

            self.RSA_PRIVAT = dict1[@"RSA_PRIVAT"];

            self.Pay_orderno = dict1[@"out_trade_no"];

            self.Notify_url = dict1[@"notify_url"];

            self.Pay_money = dict1[@"pay_money"];

            self.Money_url = dict1[@"pmoney"];

            self.Return_url = dict1[@"returnurl"];



            if ([self.status isEqualToString:@"10000"]) {

                [self saveAlipayRecordWithResponseSuccess:^(NSDictionary *responseObj) {
                    success(responseObj);
                } OnViewController:VC failed:^(NSError *error) {
                    failed(error);

                }];

            }else if ([self.status isEqualToString:@"10006"]){

                [hud dismiss:YES];
                NSError *error=[[NSError alloc] init];
                failed(error);
                [UIAlertTools showAlertWithTitle:@"" message:self.message cancelTitle:@"知道了" titleArray:nil viewController:VC confirm:^(NSInteger buttonTag) {

                }];

            }

            else{
                [hud dismiss:YES];
                NSError *error=[[NSError alloc] init];
                failed(error);
                [TrainToast showWithText:self.message duration:2.0];

            }
        }
        else
        {
            [hud dismiss:YES];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failed(error);
        [hud dismiss:YES];
    }];

}

-(void)saveAlipayRecordWithResponseSuccess:(Success)success OnViewController:(UIViewController *)VC failed:(Failure)failed
{

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];

    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    NSString *url = [NSString stringWithFormat:@"%@saveAlipayRecord.shtml",URL_Str1];
    //saveUserExchange_mob.shtml

    NSDictionary *dic = @{@"pay_order":self.Pay_orderno,@"pay_money":self.Money_url,@"clientId":@"10003",@"describe":@"IOS",@"returnurl":self.Return_url};

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

            [hud dismiss:YES];
            for (NSDictionary *dict1 in dic) {

                self.Alipay_Goods_name =dict1[@"goods_name"];

                if ([dict1[@"status"] isEqualToString:@"10000"]) {

                    [self GoALiPayWithResponseSuccess:^(NSDictionary *responseObj) {
                        success(responseObj);
                    } OnViewController:VC failed:^(NSError *error) {
                        failed(error);
                    } ];

                }else{
                }
            }
        }
        [hud dismiss:YES];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [hud dismiss:YES];
        failed(error);
    }];


}

-(void)GoALiPayWithResponseSuccess:(Success)success OnViewController:(UIViewController *)VC  failed:(Failure)failed
{


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

        [UIAlertTools showAlertWithTitle:@"提示" message:@"缺少appId或者私钥。" cancelTitle:@"确定" titleArray:nil viewController:VC confirm:^(NSInteger buttonTag) {

        }];
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

    order.biz_content.timeout_express = @"30m"; //超时时间设置

    order.biz_content.total_amount = [NSString stringWithFormat:@"%.02f", [self.Pay_money floatValue]]; //商品价格

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

            NSLog(@"reslut ==继续支付== %@",resultDic);

            if ([resultDic[@"resultStatus"] isEqualToString:@"9000"]) {
                success(resultDic);

            }else{

                NSLog(@"支付失败，请返回重新支付");
            }
          //  [self YTgetDataWithViewController:VC];
        }];

        [[AlipaySDK defaultService] processAuth_V2Result:[NSURL URLWithString:self.successurl] standbyCallback:^(NSDictionary *resultDic) {

            NSLog(@"((())))))");
        }];


    }


}
/*
-(void)YTgetDataWithViewController:(UIViewController *)VC
{

    NSLog(@"========%@==",self.ordername);

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];

    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    NSString *url = [NSString stringWithFormat:@"%@getAliPayRecordByPayOrder.shtml",URL_Str];

    NSDictionary *dic = @{@"pay_order":self.out_trade_no};

    [manager POST:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
        NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];
        if (codeKey && content) {

            NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];

            NSLog(@"===xmlStr===继续付款返回跳转===%@",xmlStr);

            NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];

            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];

            NSLog(@"===TTTTTYYY==shouhuo==%@",dic);

            if ([dic[@"status"] isEqualToString:@"10000"]) {

                if ([dic[@"order_type"] isEqualToString:@"8"] || [dic[@"order_type"] isEqualToString:@"10"]) {

                    PersonalAllDanVC *vc=[[PersonalAllDanVC alloc] init];
                    vc.tag2 = 100;
                    vc.sigen=[kUserDefaults objectForKey:@"sigen"];
                    vc.back=@"500";
                    vc.Change = @"";

                    [VC.navigationController pushViewController:vc animated:NO];
                    VC.navigationController.navigationBar.hidden=YES;
                    VC.tabBarController.tabBar.hidden=YES;

                }else if ([dic[@"order_type"] isEqualToString:@"11"])
                {
                    ATHBreakRulesOrderDetailViewController *vc = [[ATHBreakRulesOrderDetailViewController alloc] init];
                    vc.orderNo=self.orderno;
                    PersonalAllDanVC *vc2=[[PersonalAllDanVC alloc]init];
                    vc2.sigen=[kUserDefaults objectForKey:@"sigen"];
                    vc2.Change=@"";
                    NSArray *arr=@[VC.navigationController.viewControllers.firstObject,vc2,vc];

                    VC.navigationController.viewControllers=arr;
                    [VC.navigationController pushViewController:vc animated:NO];
                    VC.navigationController.navigationBar.hidden = YES;



                }
                else{

                    PersonalAllDanVC *vc=[[PersonalAllDanVC alloc] init];
                    vc.tag2 = 102;
                    vc.sigen=[kUserDefaults objectForKey:@"sigen"];
                    vc.back=@"500";
                    vc.Change = @"0";

                    [VC.navigationController pushViewController:vc animated:NO];
                    VC.navigationController.navigationBar.hidden=YES;
                    VC.tabBarController.tabBar.hidden=YES;

                }

            }else {


                //      [VC.navigationController popViewControllerAnimated:YES];


            }

        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

        [TrainToast showWithText:error.localizedDescription duration:2.0];
    }];
}
*/
+(instancetype)shareAlipayTool
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        aliPayTool=[[self alloc]init];
    });
    return aliPayTool;
}


@end

