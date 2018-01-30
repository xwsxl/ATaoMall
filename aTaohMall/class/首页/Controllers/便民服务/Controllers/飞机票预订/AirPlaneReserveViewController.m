//
//  AirPlaneReserveViewController.m
//  aTaohMall
//
//  Created by JMSHT on 2017/5/22.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "AirPlaneReserveViewController.h"

#import "AirOneDetailView.h"
#import "TuiKuanShuoMingView.h"
#import "AirPlaneAddManView.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

#import <ContactsUI/ContactsUI.h>

#import "AirOrderRefundViewController.h"

#import "PublicAnnouncementViewController.h"
#import "AttentionViewController.h"
#import "ProhibitViewController.h"
#import "AFNetworking.h"

#import "ConverUtil.h"
#import "DESUtil.h"
#import "SecretCodeTool.h"
#import "AirSelectView.h"

#import "WKProgressHUD.h"

#import "BianMinModel.h"

#import "JRToast.h"
#import "AirBaoXianView.h"

#import "AirOneMingXiView.h"
#import "ZZLimitInputManager.h"
#import "TrainToast.h"

#import "AirPiaoHaoView.h"
#import "Order.h"
#import "APAuthV2Info.h"
#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>


#import "PersonalAllDanVC.h"
#import "AirPlaneDetailViewController.h"
#define kAlphaNum @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
#define  TopTipsHeight ([self.ManOrKidString isEqualToString:@"1"]?45:70)
@interface AirPlaneReserveViewController ()<UITextViewDelegate,CNContactPickerDelegate,AirPlaneAddManDelegate,UIAlertViewDelegate,AirOneMingXiDelegate,UITextFieldDelegate,UIScrollViewDelegate>
{
    UIScrollView *_scrollView;
    UITextView *_textView;
    
    AirOneDetailView *_oneView;
    TuiKuanShuoMingView *_customShareView;
    AirPlaneAddManView *_addView;
    AirPiaoHaoView *_piaoView;
    
    UITextField *PhoneLabel;
    
    NSMutableArray *_data;
    NSMutableArray *_GoArrM;
    NSMutableArray *_ManArrM;
    NSArray *SelectArrM;
    
    UILabel *InterLabel;
    UILabel *UseLabel;
    
    AirBaoXianView *_baoView;
    AirOneMingXiView *_mingxiView;
    
    NSArray *ManArray;
    NSArray *OldManArray;
    
    UIView *PhoneView;
    UIView *BaoXianView;
    UIView *InterView;
    UIView *XieYiView;
    UIView *nameView;
    
    UITextField *NameTF;
    
    int index;
    UIImageView *UpimgView;
    UIButton *UpButton;
    UILabel *PriceLabel;
    UIButton *InterTipsBut;
    
    UISwitch *BaoXianSwitch;
    UISwitch *InterSwitch;
    
    UIView *ManPaioHaoView;
    UILabel *ManPaioHaoLabel;
    UITextField *ManPaioHaoTF;
    
    int Height;
    
    UIWebView *webView;
    UIView *loadView;
    UIButton *tipsBut;
}

@property (assign, nonatomic) BOOL isSelect;
@property (nonatomic, strong) UISwipeGestureRecognizer *rightSwipeGestureRecognizer;
@end

@implementation AirPlaneReserveViewController


/*******************************************************      控制器生命周期       ******************************************************/
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _data = [NSMutableArray new];
    
    _GoArrM = [NSMutableArray new];
    
    _ManArrM = [NSMutableArray new];
    
    //    _SelectArrM = [NSMutableArray new];
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数组NSArray类型的数据
    self.sigen=[userDefaultes stringForKey:@"sigen"];
    
    if ([self.ManOrKidString isEqualToString:@"1"]) {
        
        Height = 0;
        
    }else if ([self.ManOrKidString isEqualToString:@"2"]){
        
        Height = 1;
        
    }
    [self initNav];

    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-KSafeAreaTopNaviHeight-49-KSafeAreaBottomHeight)];
    _scrollView.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1.0];
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.delegate=self;
    _scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height+100);
    [self.view addSubview:_scrollView];
    
    self.rightSwipeGestureRecognizer=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipes:)];
    
    [self.view addGestureRecognizer:self.rightSwipeGestureRecognizer];
    
    [self initTopTipsView];
    
    [self initTopView];
    
    [self initManView];
    
    [self initPhoneView];
    
    [self initBaoXianView];
    
    [self initInterView];
    
    [self initXieYiView];
    
    [self initBoomView];
    
    //    [self getDatas];
    
    [self getInterDatas];
    
    _oneView = [[AirOneDetailView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:_oneView];
    
    _customShareView = [[TuiKuanShuoMingView alloc]init];
    [self.view addSubview:_customShareView];
    
    _addView = [[AirPlaneAddManView alloc]init];
    [self.view addSubview:_addView];
    
    _baoView = [[AirBaoXianView alloc] init];
    [self.view addSubview:_baoView];
    
    _mingxiView = [[AirOneMingXiView alloc] init];
    [self.view addSubview:_mingxiView];
    
    _piaoView = [[AirPiaoHaoView alloc] init];
    [self.view addSubview:_piaoView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resultStatus:) name:@"resultStatus" object:nil];
    
}
/*******************************************************      数据请求       ******************************************************/
/*****
 *
 *  Description 获取积分数据
 *
 ******/
-(void)getInterDatas
{
    
    //    WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
    //
    //    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
    //    dispatch_after(time, dispatch_get_main_queue(), ^{
    //
    //    });
    
    CGRect frame = CGRectMake(0, 65+60, 80, 80);
    
    frame.size = [UIImage imageNamed:@"ring-alt(1).gif"].size;
    // 读取gif图片数据
    NSData *gif = [NSData dataWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"ring-alt(1)" ofType:@"gif"]];
    // view生成
    webView = [[UIWebView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-frame.size.width)/2, ([UIScreen mainScreen].bounds.size.height-frame.size.height)/2, frame.size.width, frame.size.height)];
    
    webView.backgroundColor = [UIColor clearColor];
    webView.userInteractionEnabled = NO;//用户不可交互
    [webView setOpaque:NO];
    [webView loadData:gif MIMEType:@"image/gif" textEncodingName:nil baseURL:nil];
    [self.view addSubview:webView];
    
    [self.view removeGestureRecognizer:self.rightSwipeGestureRecognizer];
    
    loadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    loadView.backgroundColor = [UIColor blackColor];
    
    loadView.alpha = 0.2;
    
    [self.view addSubview:loadView];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@getCasualtyAndIntegral_mob.shtml",URL_Str];
    //saveUserExchange_mob.shtml
    
    
    NSLog(@"===sigen===%@",self.sigen);
    NSLog(@"===ManOrKidString===%@",self.ManOrKidString);
    
    NSDictionary *dict = @{@"sigen":self.sigen,@"passenger_type":self.ManOrKidString,@"wf_type":@"1"};
    
    [manager POST:url parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
        NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];
        
        
        if (codeKey && content) {
            NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
            
            NSLog(@"xmlStr=价格=%@",xmlStr);
            
            
            NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            if ([dic[@"status"] isEqualToString:@"10000"]) {
                
                PhoneLabel.text = [NSString stringWithFormat:@"%@",dic[@"phone"]];
                InterLabel.text = [NSString stringWithFormat:@"(你有%@积分，最多可使用0.00积分)",dic[@"integral"]];
                
                self.proportion = [NSString stringWithFormat:@"%@",dic[@"proportion"]];
                self.integral = [NSString stringWithFormat:@"%@",dic[@"integral"]];
                self.sale = [NSString stringWithFormat:@"%@",dic[@"sale"]];
                self.Remark = [NSString stringWithFormat:@"%@",dic[@"remark"]];
                
                self.order_id = [NSString stringWithFormat:@"%@",dic[@"order_id0"]];
                
                ManPaioHaoTF.text = self.order_id;
                [self initPasserView];
            }else{
                
                [JRToast showWithText:dic[@"message"] duration:2.0f];
                
                
            }
            
            
            [webView removeFromSuperview];
            [loadView removeFromSuperview];
          
            [self.view addGestureRecognizer:self.rightSwipeGestureRecognizer];
            //            [hud dismiss:YES];
            
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        NSLog(@"%@",error);
        //        [hud dismiss:YES];
        
        [webView removeFromSuperview];
        [loadView removeFromSuperview];
        [self.view addGestureRecognizer:self.rightSwipeGestureRecognizer];
    }];
    
}
/*****
 *
 *  Description 获取数据
 *
 ******/
-(void)getDatas
{
    
    [_data removeAllObjects];
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@getAirPassenger_mob.shtml",URL_Str];
    //saveUserExchange_mob.shtml
    
    NSDictionary *dict = @{@"sigen":self.sigen};
    
    [manager POST:url parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
        NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];
        
        
        if (codeKey && content) {
            NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
            
            NSLog(@"xmlStr=查询乘车人=%@",xmlStr);
            
            
            NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            //            NSLog(@"分类查看更多书局=%@",dic);
            
            
            
            if ([dic[@"status"] isEqualToString:@"10000"]) {
                
                for (NSDictionary *dict in dic[@"list"]) {
                    
                    BianMinModel *model = [[BianMinModel alloc] init];
                    
                    model.ManId = [NSString stringWithFormat:@"%@",dict[@"id"]];
                    model.ManUid = [NSString stringWithFormat:@"%@",dict[@"uid"]];
                    model.username = [NSString stringWithFormat:@"%@",dict[@"username"]];
                    model.air_passenger = [NSString stringWithFormat:@"%@",dict[@"air_passenger"]];
                    model.passporttypeseid = [NSString stringWithFormat:@"%@",dict[@"passporttypeseid"]];
                    model.passportseno = [NSString stringWithFormat:@"%@",dict[@"passportseno"]];
                    model.phone = [NSString stringWithFormat:@"%@",dict[@"phone"]];
                    
                    [_data addObject:model];
                    
                }
                
                
            }else{
                
                
            }
            
            
            //            [hud dismiss:YES];
            
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        NSLog(@"%@",error);
        //        [hud dismiss:YES];
        
        
    }];
    
}
-(void)PayBtnCLick
{
    
    [_mingxiView  hideInView];
    
    if (ManArray.count == 0) {
        
        [TrainToast showWithText:@"最少添加一位乘机人" duration:2.0f];
        
    }else{
        
        if (NameTF.text.length == 0) {
            
            [TrainToast showWithText:@"请输入联系人姓名" duration:2.0f];
            
        }else{
            
            if (PhoneLabel.text.length == 0) {
                
                [TrainToast showWithText:@"请输入联系电话" duration:2.0f];
                
            }else{
                
                if ([self.ManOrKidString isEqualToString:@"2"]) {
                    
                    if (ManPaioHaoTF.text.length == 0) {
                        
                        [TrainToast showWithText:@"请输入成人票号" duration:2.0f];
                        
                    }else{
                        
                        if ([self.Pay_plane_type isEqualToString:@"小"]) {
                            
                            self.Pay_plane_type = @"0";
                            
                        }else if ([self.Pay_plane_type isEqualToString:@"中"]){
                            
                            self.Pay_plane_type = @"1";
                        }else if ([self.Pay_plane_type isEqualToString:@"大"]){
                            
                            self.Pay_plane_type = @"2";
                        }else{
                            
                            self.Pay_plane_type = @"";
                        }
                        
                        
                        self.Pay_integral = self.DiKouInter;
                        self.Pay_phone1 = PhoneLabel.text;
                        self.Pay_linkman_name = NameTF.text;
                        
                        if ([self.ManOrKidString isEqualToString:@"1"]) {
                            
                            self.Pay_adultTicketNo = @"";
                            
                        }else if ([self.ManOrKidString isEqualToString:@"2"]){
                            
                            self.Pay_adultTicketNo = ManPaioHaoTF.text;
                        }
                        
                        self.Pay_psgtype = self.ManOrKidString;
                        self.Pay_is_arrive_and_depart = @"0";
                        self.Pay_clientId = @"3";
                        
                        UISwitch *baoxian = (UISwitch *)[self.view viewWithTag:20000];
                        
                        BOOL ret1 = [baoxian isOn];
                        
                        if (ret1) {
                            
                            self.Pay_is_aviation_accident_insurance = @"1";
                            self.Pay_aviation_accident_insurance_price = [NSString stringWithFormat:@"%.02f",[self.sale floatValue]];
                            
                        }else{
                            
                            self.Pay_is_aviation_accident_insurance = @"0";
                            self.Pay_aviation_accident_insurance_price = @"0";
                        }
                        
                        
                        [self CommitData];
                        
                    }
                    
                }else{
                    
                    //                    BianMinModel *model = [[BianMinModel alloc] init];
                    //
                    //                    model.Pay_run_time = self.Pay_run_time;
                    //                    model.Pay_start_time = self.Pay_start_time;
                    //                    model.Pay_arrive_time = self.Pay_arrive_time;
                    //                    model.Pay_start_airport	= self.Pay_start_airport;
                    //                    model.Pay_start_terminal = self.Pay_start_terminal;
                    //                    model.Pay_arrive_airport = self.Pay_arrive_airport;
                    //                    model.Pay_arrive_terminal = self.Pay_arrive_terminal;
                    //                    model.Pay_airport_flight = self.Pay_airport_flight;
                    //                    model.Pay_airport_name = self.Pay_airport_name;
                    //                    model.Pay_airport_code = self.Pay_airport_code;
                    //                    model.Pay_is_quick_meal = self.Pay_is_quick_meal;
                    
                    if ([self.Pay_plane_type isEqualToString:@"小"]) {
                        
                        //                        model.Pay_plane_type = @"0";
                        self.Pay_plane_type = @"0";
                        
                    }else if ([self.Pay_plane_type isEqualToString:@"中"]){
                        
                        //                        model.Pay_plane_type = @"1";
                        self.Pay_plane_type = @"1";
                    }else if ([self.Pay_plane_type isEqualToString:@"大"]){
                        
                        //                        model.Pay_plane_type = @"2";
                        self.Pay_plane_type = @"2";
                    }else{
                        
                        //                        model.Pay_plane_type = @"";
                        self.Pay_plane_type = @"";
                    }
                    
                    //                    model.Pay_airrax = self.Pay_airrax;
                    //                    model.Pay_fuel_oil = self.Pay_fuel_oil;
                    //                    model.Pay_is_tehui = self.Pay_is_tehui;
                    //                    model.Pay_is_spe = self.Pay_is_spe;
                    //                    model.Pay_price = self.Pay_price;
                    //                    model.Pay_cabin = self.Pay_cabin;
                    //                    model.Pay_bookpara = self.Pay_bookpara;
                    //                    model.Pay_shipping_space = self.Pay_shipping_space;
                    //                    model.Pay_money = [NSString stringWithFormat:@"%@",self.Pay_money];
                    //                    model.Pay_integral = self.DiKouInter;
                    self.Pay_integral = self.DiKouInter;
                    self.Pay_phone1 = PhoneLabel.text;
                    self.Pay_linkman_name = NameTF.text;
                    
                    if ([self.ManOrKidString isEqualToString:@"1"]) {
                        
                        self.Pay_adultTicketNo = @"";
                        
                    }else if ([self.ManOrKidString isEqualToString:@"2"]){
                        
                        self.Pay_adultTicketNo = ManPaioHaoTF.text;
                    }
                    
                    self.Pay_psgtype = self.ManOrKidString;
                    self.Pay_is_arrive_and_depart = @"1";
                    self.Pay_clientId = @"3";
                    
                    UISwitch *baoxian = (UISwitch *)[self.view viewWithTag:20000];
                    
                    BOOL ret1 = [baoxian isOn];
                    
                    if (ret1) {
                        
                        self.Pay_is_aviation_accident_insurance = @"1";
                        self.Pay_aviation_accident_insurance_price = [NSString stringWithFormat:@"%.02f",[self.sale floatValue]];                    }else{
                        
                        self.Pay_is_aviation_accident_insurance = @"0";
                        self.Pay_aviation_accident_insurance_price = [NSString stringWithFormat:@"%@",self.sale];
                    }
                    
                    
                    [self CommitData];
                    
                }
                
            }
        }
    }
}

-(void)CommitData
{
    
    [_ManArrM removeAllObjects];
    [_GoArrM removeAllObjects];
    
    
   // WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
    WKProgressHUD *hud = [WKProgressHUD showInView:self.view animated:YES];
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        
    });
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@submitAirOrder_mob.shtml",URL_Str];
    //saveUserExchange_mob.shtml
    
    
    NSLog(@"==self.Pay_integral==%@",self.Pay_integral);
    
    NSDictionary *dict1 = @{@"money":self.Pay_money,@"integral":self.Pay_integral,@"run_time":self.Pay_run_time,@"start_time":self.Pay_start_time,@"arrive_time":self.Pay_arrive_time,@"start_airport":self.Pay_start_airport,@"start_terminal":self.Pay_start_terminal,@"arrive_airport":self.Pay_arrive_airport,@"arrive_terminal":self.Pay_arrive_terminal,@"airport_flight":self.Pay_airport_flight,@"airport_name":self.Pay_airport_name,@"airport_code":self.Pay_airport_code,@"is_quick_meal":self.Pay_is_quick_meal,@"plane_type":self.Pay_plane_type,@"airrax":self.Pay_airrax,@"fuel_oil":self.Pay_fuel_oil,@"is_tehui":self.Pay_is_tehui,@"is_spe":self.Pay_is_spe,@"price":self.Pay_price,@"cabin":self.Pay_cabin,@"bookpara":self.Pay_bookpara,@"phone1":self.Pay_phone1,@"linkman_name":self.Pay_linkman_name,@"is_aviation_accident_insurance":self.Pay_is_aviation_accident_insurance,@"adultTicketNo":self.Pay_adultTicketNo,@"aviation_accident_insurance_price":self.Pay_aviation_accident_insurance_price,@"psgtype":self.Pay_psgtype,@"shipping_space":self.Pay_shipping_space,@"is_arrive_and_depart":self.Pay_is_arrive_and_depart,@"clientId":self.Pay_clientId,@"refund_instructions":self.refund_instructions};
    
    [_GoArrM addObject:dict1];
    
    
    for (BianMinModel *model in ManArray) {
        
        NSDictionary *dict = @{@"username":model.username,@"passportseno":model.passportseno,@"phone2":model.phone};
        
        [_ManArrM addObject:dict];
        
    }
    
    NSDictionary *dict = @{@"go_plane_ticket":_GoArrM,@"return_plane_ticket":@"",@"plane_passenger_data":_ManArrM};
    
    NSString *str = [self dictionaryToJson:dict];
    
    //    NSLog(@"==提交数据==%@",str);
    
    NSDictionary *dict3 = @{@"sigen":self.sigen,@"all_data":str,@"city_name":self.GoBackString};
    
    [manager POST:url parameters:dict3 success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
        NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];
        
        
        if (codeKey && content) {
            NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
            
            NSLog(@"xmlStr=提交=%@",xmlStr);
            
            
            NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            NSNull *null = [[NSNull alloc] init];
            
            if ([dic[@"status"] isEqualToString:@"10000"]) {
                
                [hud dismiss:YES];
                
                self.PayType = dic[@"type"];
                
                self.Status=dic[@"status"];
                
                self.successurl=dic[@"successurl"];
                
                self.APP_ID = dic[@"APP_ID"];
                
                self.SELLER = dic[@"SELLER"];
                
                self.RSA_PRIVAT = dic[@"RSA_PRIVAT"];
                
                self.Pay_orderno = dic[@"orderno"];
                
                self.Notify_url = dic[@"notify_url"];
                
                self.ALiPay_money = dic[@"pay_money"];
                
                self.Money_url = [NSString stringWithFormat:@"%@",dic[@"money"]];
                
                self.Return_url = dic[@"returnurl"];
                
                if ([dic[@"type"] isEqualToString:@"2"] && ![dic[@"money"] isEqualToString:@""] && ![dic[@"money"] isEqual:null]){//组合支付
                    
                    
                    //调用支付宝支付
                    
                    [self saveAlipayRecord];
                    
                    
                    
                }
                
                
            }else if ([dic[@"status"] isEqualToString:@"10006"])
            {
                [UIAlertTools showAlertWithTitle:@"" message:dic[@"message"] cancelTitle:@"知道了" titleArray:nil viewController:self confirm:^(NSInteger buttonTag) {
                    
                }];
                
                
            }
            else{
                
                [JRToast showWithText:[NSString stringWithFormat:@"%@",dic[@"message"]] duration:2.0f];
                
                
            }
            
            
            [hud dismiss:YES];
            
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        NSLog(@"%@",error);
        [hud dismiss:YES];
        
        
    }];
    
}
-(void)HuoQuanXian
{
    
    //重要说明
    //这里只是为了方便直接向商户展示支付宝的整个支付流程；所以Demo中加签过程直接放在客户端完成；
    //真实App里，privateKey等数据严禁放在客户端，加签过程务必要放在服务端完成；
    //防止商户私密数据泄露，造成不必要的资金损失，及面临各种安全风险；
    /*============================================================================*/
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
    //    NSString *pid = @"2088712201847501";
    //    NSString *appID = @"2016102002254231";
    //    NSString *privateKey = @"MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBAMTmGiHlcAdESK9KcP7vmvSS8uO75JBW+O5ruS1SD+iuWRfFiBplBkZJ57a/LFRwZDvaC/7klSXTRhn4KbHuVfIGXc3j6F1BpWkh7Cks8FOGb86o5wHbbsLWC6JmMAhTIypcIuREKWQ5a9219GTzG/PhBeNdg+EklvlFyr3rCBlRAgMBAAECgYEAsWNoma8eDb3sCdh0EomFPeCB6L/nPE7Ot+XfD8CFyqgAZhU0+CqZy4tbsV1sL6qN8woPkpUW9dvwpQbZcY76Z5uQ29w6NyXn20rqlcw2qNUPCgxagHAKVohQSFpMl3hj2L2Nw1q3KapwVkZ918r5ksLUBrlb3cCBo9WdxtyAGB0CQQDpgsz4TPAXA4jFfAD3FMxoom3Xdy+AJC43sGflUTyureqL0g/xHTB4CQW9n2ygGn9qk+Now08tV0J6RRrJ7zNjAkEA19yhy90/NwdHBpOK/6dGzweSud+hZx7UYNy4JhC9pppVP5ECNnJC7rnN3BIMuIKSkr8DwKi6HSn5Bgo7uRkwuwJAT9kEUdutNZFl0XHHurWH+Deiq8z7lyvICg7uWAHhaDHcRBd+kApVKpabOe4r7MtiyoTrfEVc67os5zZ+JJMA1QJAM83PRo2iTiKA+SMPiKssYyL+I313zrenYFeYGgqKeSEwtECot0hUp9YPgXETfHRZmL4euG3FvJoGGVz7WECjYQJBAL8W1pQpZcUgLppoSwgsjitLv1Xe0GNWJm0vql7zCLsAMF7+w1fY3LHuJP/RfHDX5aswfSa/s7Ox6iV5MSlgGnk=";
    
    NSString *pid = self.SELLER;
    NSString *appID = self.APP_ID;
    NSString *privateKey = self.RSA_PRIVAT;
    
    /*============================================================================*/
    /*============================================================================*/
    /*============================================================================*/
    
    //pid和appID获取失败,提示
    if ([pid length] == 0 ||
        [appID length] == 0 ||
        [privateKey length] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"缺少pid或者appID或者私钥。"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    //生成 auth info 对象
    APAuthV2Info *authInfo = [APAuthV2Info new];
    authInfo.pid = pid;
    authInfo.appID = appID;
    
    //auth type
    NSString *authType = [[NSUserDefaults standardUserDefaults] objectForKey:@"authType"];
    if (authType) {
        authInfo.authType = authType;
    }
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = @"aTaohPay";
    
    // 将授权信息拼接成字符串
    NSString *authInfoStr = [authInfo description];
    NSLog(@"authInfoStr = %@",authInfoStr);
    
    // 获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    NSString *signedString = [signer signString:authInfoStr];
    
    // 将签名成功字符串格式化为订单字符串,请严格按照该格式
    if (signedString.length > 0) {
        authInfoStr = [NSString stringWithFormat:@"%@&sign=%@&sign_type=%@", authInfoStr, signedString, @"RSA"];
        [[AlipaySDK defaultService] auth_V2WithInfo:authInfoStr
                                         fromScheme:appScheme
                                           callback:^(NSDictionary *resultDic) {
                                               NSLog(@"result = %@",resultDic);
                                               // 解析 auth code
                                               NSString *result = resultDic[@"result"];
                                               NSString *authCode = nil;
                                               if (result.length>0) {
                                                   NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                                                   for (NSString *subResult in resultArr) {
                                                       if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                                                           authCode = [subResult substringFromIndex:10];
                                                           break;
                                                       }
                                                   }
                                               }
                                               
                                               
                                               NSLog(@"授权结果 authCode = %@", authCode?:@"");
                                           }];
    }
    
}
-(void)saveAlipayRecord
{
    
   // WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
   WKProgressHUD *hud = [WKProgressHUD showInView:self.view animated:YES];
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
                
                self.Alipay_Goods_name =dict1[@"goods_name"];
                
                if ([dict1[@"status"] isEqualToString:@"10000"]) {
                    
                    //创建通知，区分是分机票，还是其他，是飞机票，跳团部订单
                    NSNotification *notification1 = [[NSNotification alloc] initWithName:@"FJPNSNotification" object:nil userInfo:nil];
                    
                    //通过通知中心发送通知
                    [[NSNotificationCenter defaultCenter] postNotification:notification1];
                    
                    [hud dismiss:YES];
                    
                    [self GoALiPay];
                    
                    
                }else{
                    
                    [hud dismiss:YES];
                    
                    [JRToast showWithText:dict1[@"message"] duration:2.0f];
                }
            }
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //        [WKProgressHUD popMessage:@"网络请求失败，请检查您的网络设置" inView:self.view duration:1.5 animated:YES];
        //        [self NoWebSeveice];
        
        [hud dismiss:YES];
        
        NSLog(@"%@",error);
    }];
    
    
    
    //    [HTTPRequestManager POST:@"saveAlipayRecord.shtml" NSDictWithString:@{@"pay_order":self.Pay_orderno,@"pay_money":self.Money_url,@"clientId":@"10003",@"describe":@"IOS",@"returnurl":self.Return_url} parameters:nil result:^(id responseObj, NSError *error) {
    //
    //
    ////        NSLog(@"==========保存支付宝信息====%@===",responseObj);
    //
    //
    //        if (responseObj) {
    //
    //            for (NSDictionary *dict in responseObj) {
    //
    //
    //                if ([dict[@"status"] isEqualToString:@"10000"]) {
    //
    //
    //                    [self GoALiPay];
    //
    //                }else{
    //
    //
    //                    [JRToast showWithText:dict[@"message"] duration:3.0f];
    //
    //                }
    //
    //
    //            }
    //
    //
    //        }else{
    //
    //
    //            NSLog(@"error");
    //
    //        }
    //
    //
    //    }];
    
    
    
    
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
    
    order.biz_content.timeout_express = @"30m"; //超时时间设置
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
                
                NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
                //读取数组NSArray类型的数据
                
                
                PersonalAllDanVC *vc=[[PersonalAllDanVC alloc] init];
                [vc selectedDingDanType:@"1" AndIndexType:2];

                self.navigationController.viewControllers=@[self.navigationController.viewControllers.firstObject,vc];
                [self.navigationController pushViewController:vc animated:NO];
                
                
                
            }else if ([resultDic[@"resultStatus"] isEqualToString:@"8000"]){
                
                [JRToast showWithText:@"正在处理中" duration:2.0f];
                
                
            }else if ([resultDic[@"resultStatus"] isEqualToString:@"4000"]){
                
                
                [JRToast showWithText:@"订单支付失败" duration:2.0f];
                
            }else if ([resultDic[@"resultStatus"] isEqualToString:@"6001"]){
                
                [JRToast showWithText:@"用户中途取消" duration:2.0f];
                PersonalAllDanVC *vc=[[PersonalAllDanVC alloc] init];
                [vc selectedDingDanType:@"1" AndIndexType:1];

                self.navigationController.viewControllers=@[self.navigationController.viewControllers.firstObject,vc];
                [self.navigationController pushViewController:vc animated:NO];
                
            }else if ([resultDic[@"resultStatus"] isEqualToString:@"6002"]){
                
                [JRToast showWithText:@"网络连接出错" duration:2.0f];
            }
            
            
        }];
        //
        
        
        
    }
    
    
}
/*******************************************************      初始化视图       ******************************************************/
//创建导航栏
-(void)initNav
{
    //  self.navigationController.interactivePopGestureRecognizer.enabled=YES;
    
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
    
    label.text = @"机票预定";
    
    label.textColor = [UIColor blackColor];
    
    label.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:19];
    
    label.textAlignment = NSTextAlignmentCenter;
    
    [titleView addSubview:label];
    
    
}



-(void)initTopTipsView
{
    if ([self.ManOrKidString isEqualToString:@"1"]) {
    UIView *tipsView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 45)];
        tipsView.backgroundColor=RGB(63, 139, 253);
        UIImageView *IV=[[UIImageView alloc]initWithFrame:CGRectMake(15, 8, 13, 13)];
        IV.image=[UIImage imageNamed:@"icon_hint"];
        [tipsView addSubview:IV];
        UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMake(33, 6,kScreen_Width-48, 34)];
        lab.font=KNSFONT(12);
        lab.textColor=RGB(255, 255, 255);
        lab.numberOfLines=0;
        lab.text=@"所售机票暂时无法提供改签服务，若急需改签请致电联系相应航空公司。最终解释权归本公司所有。";
        [tipsView addSubview:lab];
        [_scrollView addSubview:tipsView];
        
    }else
    {
        
        UIView *tipsView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 70)];
        tipsView.backgroundColor=RGB(63, 139, 253);
        UIImageView *IV=[[UIImageView alloc]initWithFrame:CGRectMake(15, 8, 13, 13)];
        IV.image=[UIImage imageNamed:@"icon_hint"];
        [tipsView addSubview:IV];
        UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMake(33, 9,kScreen_Width-48, 12)];
        lab.font=KNSFONT(12);
        lab.textColor=RGB(255, 255, 255);
        lab.text=@"儿童乘机人若无有效身份证件建议携带上户口薄原件";
        [tipsView addSubview:lab];
        
        UIImageView *IV2=[[UIImageView alloc]initWithFrame:CGRectMake(15, 30, 13, 13)];
        IV2.image=[UIImage imageNamed:@"icon_hint"];
        [tipsView addSubview:IV2];
        UILabel * lab2 = [[UILabel alloc]initWithFrame:CGRectMake(33, 28,kScreen_Width-48, 34)];
        lab2.font=KNSFONT(12);
        lab2.textColor=RGB(255, 255, 255);
        lab2.numberOfLines=0;
        lab2.text=@"所售机票暂时无法提供改签服务，若急需改签请致电联系相应航空公司。最终解释权归本公司所有。";
        [tipsView addSubview:lab2];
        [_scrollView addSubview:tipsView];
        
    }
    
    
}


/*****
 *
 *  Description 顶部时间、城市、票价视图
 *
 ******/
-(void)initTopView
{
    
    UIView *TopView = [[UIView alloc] initWithFrame:CGRectMake(0, 0+TopTipsHeight, [UIScreen mainScreen].bounds.size.width, 71)];
    TopView.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:TopView];
    
    NSArray *string1 =[self.time componentsSeparatedByString:@"-"];
    
    
    NSArray *date = [self.Air_OffTime componentsSeparatedByString:@" "];
    NSArray *array = [date[1] componentsSeparatedByString:@":"];
    
    UILabel *Toplabel = [[UILabel alloc] initWithFrame:CGRectMake(15, (35-17)/2, 200, 17)];
    Toplabel.text = [NSString stringWithFormat:@"%@-%@ %@ %@",string1[1],string1[2],self.DateWeek,[NSString stringWithFormat:@"%@:%@",array[0],array[1]]];
    Toplabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    Toplabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:18];
    Toplabel.textAlignment = NSTextAlignmentLeft;
    [TopView addSubview:Toplabel];
    
    UILabel *Namelabel = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-50-200, (35-13)/2, 200, 13)];
    Namelabel.text = self.GoBackString;
    Namelabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    Namelabel.font = [UIFont fontWithName:@"PingFangSC-Light" size:14];
    Namelabel.textAlignment = NSTextAlignmentRight;
    [TopView addSubview:Namelabel];
    
    
    UIButton *GoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    GoButton.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 35);
    [GoButton addTarget:self action:@selector(GoBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [TopView addSubview:GoButton];
    
    
    UIImageView *online = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-30, (35-14)/2, 8, 14)];
    online.image = [UIImage imageNamed:@"icon_more"];
    [TopView addSubview:online];
    
    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(15, 35, [UIScreen mainScreen].bounds.size.width-30, 0.5)];
    line.image = [UIImage imageNamed:@"xuxian"];
    [TopView addSubview:line];
    
    NSString *string = [NSString stringWithFormat:@"票价:￥%.02f %@",[self.Price floatValue], self.OilString];
    
    CGRect tempRect = [string boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width,13) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Light" size:14]} context:nil];

    CGFloat width=tempRect.size.width;


    UILabel *PaioJialabel = [[UILabel alloc] initWithFrame:CGRectMake(15, (35-13)/2+36,kScreenWidth-15-100, 13)];
    PaioJialabel.text = string;
    PaioJialabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    PaioJialabel.font = [UIFont fontWithName:@"PingFangSC-Light" size:14];
    if (width>kScreenWidth-15-100) {
    PaioJialabel.font = [UIFont fontWithName:@"PingFangSC-Light" size:12];
    }
    PaioJialabel.textAlignment = NSTextAlignmentLeft;
    [TopView addSubview:PaioJialabel];
    
    NSString *stringForColor3 = [NSString stringWithFormat:@"￥%.02f",[self.Price floatValue]];
    // 创建对象.
    NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:PaioJialabel.text];
    //
    NSRange range3 = [PaioJialabel.text rangeOfString:stringForColor3];
    [mAttStri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0] range:range3];
    PaioJialabel.attributedText=mAttStri;
    
//    UILabel *JiJianlabel = [[UILabel alloc] initWithFrame:CGRectMake(15+tempRect.size.width+15, (35-13)/2+36, 200, 13)];
//    JiJianlabel.text = self.OilString;
//    JiJianlabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
//    JiJianlabel.font = [UIFont fontWithName:@"PingFangSC-Light" size:14];
//    [TopView addSubview:JiJianlabel];

    UILabel *Tuilabel = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-30-205, (35-13)/2+36, 200, 13)];
    Tuilabel.text = @"退票说明";
    Tuilabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    Tuilabel.font = [UIFont fontWithName:@"PingFangSC-Light" size:14];
    Tuilabel.textAlignment = NSTextAlignmentRight;
    [TopView addSubview:Tuilabel];
    
    UIButton *timeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    timeButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-30, (35-14)/2+36, 14, 14);
    [timeButton setImage:[UIImage imageNamed:@"icon_tip-red"] forState:0];
    [timeButton addTarget:self action:@selector(TimeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [TopView addSubview:timeButton];
    
    UIImageView *line1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 70, [UIScreen mainScreen].bounds.size.width, 1)];
    line1.image = [UIImage imageNamed:@"分割线-拷贝"];
    [TopView addSubview:line1];
}
/*****
 *
 *  Description 乘机人视图
 *
 ******/
-(void)initManView
{
    
    UIView *ManView = [[UIView alloc] initWithFrame:CGRectMake(0, 71+10+TopTipsHeight, [UIScreen mainScreen].bounds.size.width, 50)];
    ManView.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:ManView];
    
    
    UILabel *ManLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, (50-13)/2, 100, 13)];
    ManLabel.text = @"乘机人";
    ManLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    ManLabel.font = [UIFont fontWithName:@"PingFangSC-Light" size:14];
    [ManView addSubview:ManLabel];
    
    
    UIButton *ManButton = [UIButton buttonWithType:UIButtonTypeCustom];
    ManButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-91, (50-25)/2, 71, 25);
    [ManButton setTitle:@"选择乘机人" forState:0];
    ManButton.backgroundColor = [UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
    [ManButton setTitleColor:[UIColor whiteColor] forState:0];
    ManButton.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Light" size:12];
    ManButton.layer.cornerRadius = 3;
    ManButton.layer.masksToBounds = YES;
    [ManButton addTarget:self action:@selector(ManBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [ManView addSubview:ManButton];
    
    UIImageView *line1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 49, [UIScreen mainScreen].bounds.size.width, 1)];
    line1.image = [UIImage imageNamed:@"分割线-拷贝"];
    [ManView addSubview:line1];
    
    
}

//创建乘车人视图
-(void)initPasserView
{
    
    //移除就试图
    if (OldManArray.count > 0) {
        
        for (int i = 0; i < OldManArray.count; i++) {
            
            UIView *view = (UIView *)[self.view viewWithTag:1100+i];
            [view removeFromSuperview];
            
            UILabel *price = (UILabel *)[self.view viewWithTag:1200+i];
            [price removeFromSuperview];
            
            UILabel *Id = (UILabel *)[self.view viewWithTag:1300+i];
            [Id removeFromSuperview];
            
            UIImageView *RedImgView = (UIImageView *)[self.view viewWithTag:1400+i];
            [RedImgView removeFromSuperview];
            
            UIButton *line = (UIButton *)[self.view viewWithTag:1500+i];
            [line removeFromSuperview];
            
        }
    }
    
    
    for (int i=0; i<ManArray.count; i++) {
        
        BianMinModel *model = ManArray[i];
        
        UIView *NameView = [[UIView alloc] initWithFrame:CGRectMake(0,TopTipsHeight+ 71+10+50 +50*i, [UIScreen mainScreen].bounds.size.width, 50)];
        NameView.tag = 1100+i;
        NameView.backgroundColor = [UIColor whiteColor];
        [_scrollView addSubview:NameView];
        
        UILabel *NameLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 11, 200, 13)];
        NameLabel.text = model.username;
        NameLabel.tag = 1200+i;
        NameLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        NameLabel.font  =[UIFont fontWithName:@"PingFang-SC-Regular" size:14];
        [NameView addSubview:NameLabel];
        
        UILabel *idLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 30, 200, 13)];
        idLabel.text = model.passportseno;
        idLabel.tag = 1300+i;
        idLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        idLabel.font  =[UIFont fontWithName:@"PingFang-SC-Regular" size:12];
        [NameView addSubview:idLabel];
        
        UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 49, [UIScreen mainScreen].bounds.size.width, 1)];
        line.tag = 1400+i;
        line.image = [UIImage imageNamed:@"分割线-拷贝"];
        [NameView addSubview:line];
        
        UIButton *DeleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        DeleteButton.frame = CGRectMake(14, (50-16)/2, 16, 16);
        DeleteButton.tag = 1500+i;
        [DeleteButton setImage:[UIImage imageNamed:@"删除"] forState:0];
        [DeleteButton addTarget:self action:@selector(DeleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [NameView addSubview:DeleteButton];
        
    }
    
    nameView.frame = CGRectMake(0,TopTipsHeight+ 71+10+50+9+50*ManArray.count, [UIScreen mainScreen].bounds.size.width, 50);
    PhoneView.frame = CGRectMake(0, TopTipsHeight+ 71+10+50+9+50+50*ManArray.count, [UIScreen mainScreen].bounds.size.width, 50);
    BaoXianView.frame = CGRectMake(0, TopTipsHeight+ 71+10+50+9+59+50+50*ManArray.count+59*Height, [UIScreen mainScreen].bounds.size.width, 50);
    InterView.frame = CGRectMake(0, TopTipsHeight+ 71+10+50+9+59+60+50+50*ManArray.count+59*Height, [UIScreen mainScreen].bounds.size.width, 70);
    XieYiView.frame = CGRectMake(0,TopTipsHeight+  71+10+50+9+59+60+70+10+50+50*ManArray.count+59*Height, [UIScreen mainScreen].bounds.size.width, 40);
    _scrollView.contentSize=CGSizeMake(kScreen_Width,TopTipsHeight+ 101+10+50+9+59+60+70+10+50+50*ManArray.count+109*Height+80);
    
    ManPaioHaoView.frame = CGRectMake(0,TopTipsHeight+  71+10+50+9+50+59+50*ManArray.count, [UIScreen mainScreen].bounds.size.width, 50*Height);
    
    //    ManPaioHaoView.frame = CGRectMake(0, 71+69+50+59+50*ManArray.count, [UIScreen mainScreen].bounds.size.width, 50*Height);
    
    if (ManArray.count==0) {
        
        PriceLabel.text = @"￥---";
        UpButton.hidden=YES;
        UpimgView.hidden=YES;
        
        UseLabel.text = [NSString stringWithFormat:@"使用 0.00 积分兑现￥0.00"];
        
        NSString *stringForColor3 = @"0.00";
        // 创建对象.
        NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:UseLabel.text];
        //
        NSRange range3 = [UseLabel.text rangeOfString:stringForColor3];
        [mAttStri addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Regular" size:10] range:range3];
        UseLabel.attributedText=mAttStri;
        
        InterLabel.text = [NSString stringWithFormat:@"(你有%@积分，最多可使用0.00积分)",self.integral];
        
        self.CanUseInter = @"";
        
        
    }else{
        
        UpButton.hidden=NO;
        UpimgView.hidden=NO;
        
        //判断保险开关是否打开
        UISwitch *baoxian = (UISwitch *)[self.view viewWithTag:20000];
        
        BOOL ret1 = [baoxian isOn];
        //判断积分按钮是否打开
        UISwitch *jifen = (UISwitch *)[self.view viewWithTag:10000];
        
        BOOL ret2 = [jifen isOn];
        //判断积分抵扣多少
        
        if (ret1) {//保险开了
            
            if (ret2) {//积分开了，保险开了
                
                NSLog(@"积分开了，保险开了");
                
                //用户积分大于抵扣积分
                if ([self.integral floatValue] >= ([self.Money floatValue]*ManArray.count + [self.sale floatValue]*ManArray.count)*[self.proportion floatValue]) {
                    
                    PriceLabel.text = [NSString stringWithFormat:@"￥%.02f(共%d人)",[self.Money floatValue]*ManArray.count + [self.sale floatValue]*ManArray.count - ([self.Money floatValue]*ManArray.count + [self.sale floatValue]*ManArray.count)*[self.proportion floatValue],(int)ManArray.count];
                    
                    self.Pay_money = [NSString stringWithFormat:@"%.02f",[self.Money floatValue]*ManArray.count + [self.sale floatValue]*ManArray.count - ([self.Money floatValue]*ManArray.count + [self.sale floatValue]*ManArray.count)*[self.proportion floatValue]];
                    
                    InterLabel.text = [NSString stringWithFormat:@"(你有%@积分，最多可使用%.02f积分)",self.integral,([self.Money floatValue]*ManArray.count + [self.sale floatValue]*ManArray.count)*[self.proportion floatValue]];
                    
                    UseLabel.text = [NSString stringWithFormat:@"使用 %.02f 积分兑现￥%.02f",([self.Money floatValue]*ManArray.count + [self.sale floatValue]*ManArray.count)*[self.proportion floatValue],([self.Money floatValue]*ManArray.count + [self.sale floatValue]*ManArray.count)*[self.proportion floatValue]];
                    
                    self.CanUseInter = [NSString stringWithFormat:@"%.02f",([self.Money floatValue]*ManArray.count + [self.sale floatValue]*ManArray.count)*[self.proportion floatValue]];
                    
                    self.DiKouInter = [NSString stringWithFormat:@"%.02f",([self.Money floatValue]*ManArray.count + [self.sale floatValue]*ManArray.count)*[self.proportion floatValue]];
                    
                    NSString *stringForColor3 = [NSString stringWithFormat:@"%.02f",([self.Money floatValue]*ManArray.count + [self.sale floatValue]*ManArray.count)*[self.proportion floatValue]];
                    // 创建对象.
                    NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:UseLabel.text];
                    //
                    NSRange range3 = [UseLabel.text rangeOfString:stringForColor3];
                    [mAttStri addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Regular" size:10] range:range3];
                    UseLabel.attributedText=mAttStri;
                }else{
                    
                    PriceLabel.text = [NSString stringWithFormat:@"￥%.02f(共%d人)",[self.Money floatValue]*ManArray.count + [self.sale floatValue]*ManArray.count - [self.integral floatValue],(int)ManArray.count];
                    
                    self.Pay_money = [NSString stringWithFormat:@"%.02f",[self.Money floatValue]*ManArray.count + [self.sale floatValue]*ManArray.count - [self.integral floatValue]];
                    
                    InterLabel.text = [NSString stringWithFormat:@"(你有%@积分，最多可使用%.02f积分)",self.integral,[self.integral floatValue]];
                    
                    UseLabel.text = [NSString stringWithFormat:@"使用 %.02f 积分兑现￥%.02f",[self.integral floatValue],[self.integral floatValue]];
                    
                    self.CanUseInter = [NSString stringWithFormat:@"%.02f",[self.integral floatValue]];
                    
                    self.DiKouInter = [NSString stringWithFormat:@"%.02f",[self.integral floatValue]];
                    
                    NSString *stringForColor3 = [NSString stringWithFormat:@"%.02f",[self.integral floatValue]];
                    // 创建对象.
                    NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:UseLabel.text];
                    //
                    NSRange range3 = [UseLabel.text rangeOfString:stringForColor3];
                    [mAttStri addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Regular" size:10] range:range3];
                    UseLabel.attributedText=mAttStri;
                }
            }else{//保险开了，积分关了
                
                NSLog(@"保险开了，积分关了");
                
                PriceLabel.text = [NSString stringWithFormat:@"￥%.02f(共%d人)",[self.Money floatValue]*ManArray.count + [self.sale floatValue]*ManArray.count,(int)ManArray.count];
                
                self.Pay_money = [NSString stringWithFormat:@"%.02f",[self.Money floatValue]*ManArray.count + [self.sale floatValue]*ManArray.count];
                
                
                NSString *integralStr=@"";
              if([self.integral floatValue] >= ([self.Money floatValue]*ManArray.count + [self.sale floatValue]*ManArray.count)*[self.proportion floatValue])
              {
                  integralStr=[NSString stringWithFormat:@"%.02f",([self.Money floatValue]*ManArray.count + [self.sale floatValue]*ManArray.count)*[self.proportion floatValue]];;
                  
              }else
              {
                  integralStr=self.integral;
              }
                InterLabel.text = [NSString stringWithFormat:@"(你有%@积分，最多可使用%@积分)",self.integral,integralStr];
                
                UseLabel.text = [NSString stringWithFormat:@"使用 0.00 积分兑现￥0.00"];
                
                self.CanUseInter = @"0.00";
                
                self.DiKouInter = @"0.00";
                
                NSString *stringForColor3 = @"0.00";
                // 创建对象.
                NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:UseLabel.text];
                //
                NSRange range3 = [UseLabel.text rangeOfString:stringForColor3];
                [mAttStri addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Regular" size:10] range:range3];
                UseLabel.attributedText=mAttStri;
            }
            
        }else{
            
            if (ret2) {//保险关了，积分开了
                
                NSLog(@"保险关了，积分开了");
                if ([self.integral floatValue] >= ([self.Money floatValue]*ManArray.count)*[self.proportion floatValue]) {
                    
                    PriceLabel.text = [NSString stringWithFormat:@"￥%.02f(共%d人)",[self.Money floatValue]*ManArray.count - ([self.Money floatValue]*ManArray.count)*[self.proportion floatValue],(int)ManArray.count];
                    
                    self.Pay_money = [NSString stringWithFormat:@"%.02f",[self.Money floatValue]*ManArray.count - ([self.Money floatValue]*ManArray.count)*[self.proportion floatValue]];
                    
                    InterLabel.text = [NSString stringWithFormat:@"(你有%@积分，最多可使用%.02f积分)",self.integral,([self.Money floatValue]*ManArray.count)*[self.proportion floatValue]];
                    
                    UseLabel.text = [NSString stringWithFormat:@"使用 %.02f 积分兑现￥%.02f",([self.Money floatValue]*ManArray.count)*[self.proportion floatValue],([self.Money floatValue]*ManArray.count)*[self.proportion floatValue]];
                    
                    self.CanUseInter = [NSString stringWithFormat:@"%.02f",([self.Money floatValue]*ManArray.count)*[self.proportion floatValue]];
                    
                    self.DiKouInter = [NSString stringWithFormat:@"%.02f",([self.Money floatValue]*ManArray.count)*[self.proportion floatValue]];
                    
                    NSString *stringForColor3 = [NSString stringWithFormat:@"%.02f",([self.Money floatValue]*ManArray.count)*[self.proportion floatValue]];
                    // 创建对象.
                    NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:UseLabel.text];
                    //
                    NSRange range3 = [UseLabel.text rangeOfString:stringForColor3];
                    [mAttStri addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Regular" size:10] range:range3];
                    UseLabel.attributedText=mAttStri;
                    
                }else{
                    
                    PriceLabel.text = [NSString stringWithFormat:@"￥%.02f(共%d人)",[self.Money floatValue]*ManArray.count - [self.integral floatValue],(int)ManArray.count];
                    
                    self.Pay_money = [NSString stringWithFormat:@"%.02f",[self.Money floatValue]*ManArray.count - [self.integral floatValue]];
                    
                    InterLabel.text = [NSString stringWithFormat:@"(你有%@积分，最多可使用%.02f积分)",self.integral,[self.integral floatValue]];
                    
                    UseLabel.text = [NSString stringWithFormat:@"使用 %.02f 积分兑现￥%.02f",[self.integral floatValue],[self.integral floatValue]];
                    
                    self.CanUseInter = [NSString stringWithFormat:@"%.02f",[self.integral floatValue]];
                    
                    self.DiKouInter = [NSString stringWithFormat:@"%.02f",[self.integral floatValue]];
                    
                    NSString *stringForColor3 = [NSString stringWithFormat:@"%.02f",[self.integral floatValue]];
                    // 创建对象.
                    NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:UseLabel.text];
                    //
                    NSRange range3 = [UseLabel.text rangeOfString:stringForColor3];
                    [mAttStri addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Regular" size:10] range:range3];
                    UseLabel.attributedText=mAttStri;
                    
                }
                
            }else{//保险关了，积分关了
                
                NSLog(@"保险关了，积分关了");
                
                PriceLabel.text = [NSString stringWithFormat:@"￥%.02f(共%d人)",[self.Money floatValue]*ManArray.count,(int)ManArray.count];
                
                self.Pay_money = [NSString stringWithFormat:@"%.02f",[self.Money floatValue]*ManArray.count];
                
                NSString *integralStr=@"";
                if([self.integral floatValue] >= ([self.Money floatValue]*ManArray.count + [self.sale floatValue]*ManArray.count)*[self.proportion floatValue])
                {
                    integralStr=[NSString stringWithFormat:@"%.02f",([self.Money floatValue]*ManArray.count + [self.sale floatValue]*ManArray.count)*[self.proportion floatValue]];;
                    
                }else
                {
                    integralStr=self.integral;
                }
                InterLabel.text = [NSString stringWithFormat:@"(你有%@积分，最多可使用%@积分)",self.integral,integralStr];
                
                UseLabel.text = [NSString stringWithFormat:@"使用 0.00 积分兑现￥0.00"];
                
                self.CanUseInter = @"0.00";
                
                self.DiKouInter = @"0.00";
                
                NSString *stringForColor3 = @"0.00";
                // 创建对象.
                NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:UseLabel.text];
                //
                NSRange range3 = [UseLabel.text rangeOfString:stringForColor3];
                [mAttStri addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Regular" size:10] range:range3];
                UseLabel.attributedText=mAttStri;
                
            }
            
        }
        
        //        if ([self.integral floatValue] >= ([self.Money floatValue]*ManArray.count + [self.sale floatValue]*ManArray.count)*[self.proportion floatValue]) {
        //
        //
        //            PriceLabel.text = [NSString stringWithFormat:@"￥%.02f(共%d人)",[self.Money floatValue]*ManArray.count + [self.sale floatValue]*ManArray.count - ([self.Money floatValue]*ManArray.count + [self.sale floatValue]*ManArray.count)*[self.proportion floatValue],(int)ManArray.count];
        //
        //            self.Pay_money = [NSString stringWithFormat:@"%.02f",[self.Money floatValue]*ManArray.count + [self.sale floatValue]*ManArray.count - ([self.Money floatValue]*ManArray.count + [self.sale floatValue]*ManArray.count)*[self.proportion floatValue]];
        //
        //            InterLabel.text = [NSString stringWithFormat:@"(你有%@积分，最多可使用%.02f积分)",self.integral,([self.Money floatValue]*ManArray.count + [self.sale floatValue]*ManArray.count)*[self.proportion floatValue]];
        //
        //            UseLabel.text = [NSString stringWithFormat:@"使用 %.02f 积分兑现￥%.02f",([self.Money floatValue]*ManArray.count + [self.sale floatValue]*ManArray.count)*[self.proportion floatValue],([self.Money floatValue]*ManArray.count + [self.sale floatValue]*ManArray.count)*[self.proportion floatValue]];
        //
        //            self.CanUseInter = [NSString stringWithFormat:@"%.02f",([self.Money floatValue]*ManArray.count + [self.sale floatValue]*ManArray.count)*[self.proportion floatValue]];
        //
        //            self.DiKouInter = [NSString stringWithFormat:@"%.02f",([self.Money floatValue]*ManArray.count + [self.sale floatValue]*ManArray.count)*[self.proportion floatValue]];
        //
        //            NSString *stringForColor3 = [NSString stringWithFormat:@"%.02f",([self.Money floatValue]*ManArray.count + [self.sale floatValue]*ManArray.count)*[self.proportion floatValue]];
        //            // 创建对象.
        //            NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:UseLabel.text];
        //            //
        //            NSRange range3 = [UseLabel.text rangeOfString:stringForColor3];
        //            [mAttStri addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Regular" size:10] range:range3];
        //            UseLabel.attributedText=mAttStri;
        //
        //        }else{
        //
        //            PriceLabel.text = [NSString stringWithFormat:@"￥%.02f(共%d人)",[self.Money floatValue]*ManArray.count + [self.sale floatValue]*ManArray.count - [self.integral floatValue],(int)ManArray.count];
        //
        //            self.Pay_money = [NSString stringWithFormat:@"%.02f",[self.Money floatValue]*ManArray.count + [self.sale floatValue]*ManArray.count - [self.integral floatValue]];
        //
        //            InterLabel.text = [NSString stringWithFormat:@"(你有%@积分，最多可使用%.02f积分)",self.integral,[self.integral floatValue]];
        //
        //            UseLabel.text = [NSString stringWithFormat:@"使用 %.02f 积分兑现￥%.02f",[self.integral floatValue],[self.integral floatValue]];
        //
        //            self.CanUseInter = [NSString stringWithFormat:@"%.02f",[self.integral floatValue]];
        //
        //            self.DiKouInter = [NSString stringWithFormat:@"%.02f",[self.integral floatValue]];
        //
        //            NSString *stringForColor3 = [NSString stringWithFormat:@"%.02f",[self.integral floatValue]];
        //            // 创建对象.
        //            NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:UseLabel.text];
        //            //
        //            NSRange range3 = [UseLabel.text rangeOfString:stringForColor3];
        //            [mAttStri addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Regular" size:10] range:range3];
        //            UseLabel.attributedText=mAttStri;
        //
        //        }
        //
        //
        NSString *stringForColor = @"￥";
        NSString *stringForColor1 = [NSString stringWithFormat:@"(共%d人)",(int)ManArray.count];
        // 创建对象.
        NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:PriceLabel.text];
        //
        NSRange range = [PriceLabel.text rangeOfString:stringForColor];
        NSRange range1 = [PriceLabel.text rangeOfString:stringForColor1];
        
        [mAttStri addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Medium" size:12] range:range];
        [mAttStri addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:12] range:range1];
        [mAttStri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0] range:range1];
        
        PriceLabel.attributedText=mAttStri;
        
        
        
    }
    /*--------------Hawky-8-23----------------*/
//    UIButton *but=[self.view viewWithTag:1689];
//    CGSize size=[InterLabel.text sizeWithFont:KNSFONT(12) maxSize:CGSizeMake(kScreen_Width-30, 14)];
//    but.frame=CGRectMake(size.width+15+5, 47, 11, 11);
//
//    CGRect rect=InterView.frame;
//    InterTipsView.frame=CGRectMake(but.center.x-40,65+rect.origin.y+but.frame.origin.y+but.frame.size.height, 80, 40);
    
    CGSize size=[InterLabel.text sizeWithFont:KNSFONT(12) maxSize:CGSizeMake(kScreen_Width-30, 14)];
    tipsBut.frame=CGRectMake(size.width+15+5, 47, 11, 11);
    CGRect rect=InterView.frame;
    InterTipsBut.frame=CGRectMake(tipsBut.center.x-40,rect.origin.y+tipsBut.frame.origin.y+tipsBut.frame.size.height, 80, 40);
    /*---------------------------------------*/
    
    
}
/*****
 *
 *  Description 联系人视图
 *
 ******/
-(void)initPhoneView
{
    
    nameView = [[UIView alloc] initWithFrame:CGRectMake(0,TopTipsHeight+  71+10+50+9+50*ManArray.count, [UIScreen mainScreen].bounds.size.width, 50)];
    nameView.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:nameView];
    
    UIImageView *line2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 49, [UIScreen mainScreen].bounds.size.width, 1)];
    line2.image = [UIImage imageNamed:@"分割线-拷贝"];
    [nameView addSubview:line2];
    
    UILabel *ManLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(15, (50-13)/2, 60, 13)];
    ManLabel1.text = @"联系人";
    ManLabel1.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    ManLabel1.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    [nameView addSubview:ManLabel1];
    
    NameTF = [[UITextField alloc] initWithFrame:CGRectMake(80, (50-20)/2, 200, 20)];
    NameTF.placeholder = @"请输入联系人姓名";
    NameTF.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    NameTF.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    NameTF.delegate=self;
    [nameView addSubview:NameTF];
    
    UIToolbar *bar3 = [[UIToolbar alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH,44)];
    UIButton *button3 = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 60, 7,50, 30)];
    [button3 setTitle:@"确定"forState:UIControlStateNormal];
    [button3 setTitleColor:[UIColor redColor] forState:0];
    [button3 addTarget:self action:@selector(OKBtnclick) forControlEvents:UIControlEventTouchUpInside];
    [bar3 addSubview:button3];
    
    UIButton *button4 = [[UIButton alloc] initWithFrame:CGRectMake(10, 7,50, 30)];
    [button4 setTitle:@"取消"forState:UIControlStateNormal];
    [button4 setTitleColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0] forState:0];
    [bar3 addSubview:button4];
    [button4 addTarget:self action:@selector(CancleBtnclick) forControlEvents:UIControlEventTouchUpInside];
    NameTF.inputAccessoryView = bar3;
    
    PhoneView = [[UIView alloc] initWithFrame:CGRectMake(0,TopTipsHeight+  71+69+50+50*ManArray.count, [UIScreen mainScreen].bounds.size.width, 50)];
    PhoneView.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:PhoneView];
    
    UILabel *ManLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, (50-13)/2, 60, 13)];
    ManLabel.text = @"联系手机";
    ManLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    ManLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    [PhoneView addSubview:ManLabel];
    
    _scrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    
    
    PhoneLabel = [[UITextField alloc] initWithFrame:CGRectMake(80, (50-20)/2, 200, 20)];
    PhoneLabel.placeholder = @"请输入联系手机号";
    PhoneLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    PhoneLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    PhoneLabel.keyboardType = UIKeyboardTypeNumberPad;
    PhoneLabel.delegate=self;
    [ZZLimitInputManager limitInputView:PhoneLabel maxLength:11];
    [PhoneView addSubview:PhoneLabel];
    
    UIToolbar *bar1 = [[UIToolbar alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH,44)];
    UIButton *button1 = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 60, 7,50, 30)];
    [button1 setTitle:@"确定"forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor redColor] forState:0];
    [button1 addTarget:self action:@selector(OKBtnclick) forControlEvents:UIControlEventTouchUpInside];
    [bar1 addSubview:button1];
    
    UIButton *button2 = [[UIButton alloc] initWithFrame:CGRectMake(10, 7,50, 30)];
    [button2 setTitle:@"取消"forState:UIControlStateNormal];
    [button2 setTitleColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0] forState:0];
    [bar1 addSubview:button2];
    [button2 addTarget:self action:@selector(CancleBtnclick) forControlEvents:UIControlEventTouchUpInside];
    PhoneLabel.inputAccessoryView = bar1;
    
    
    UIButton *PhoneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    PhoneButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-42, (50-23)/2, 22, 23);
    [PhoneButton setImage:[UIImage imageNamed:@"icon-address-book"] forState:0];
    [PhoneButton addTarget:self action:@selector(PhoneBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [PhoneView addSubview:PhoneButton];
    
    UIImageView *line1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 49, [UIScreen mainScreen].bounds.size.width, 1)];
    line1.image = [UIImage imageNamed:@"分割线-拷贝"];
    [PhoneView addSubview:line1];
    
    
    NSLog(@"====self.ManOrKidString===%@===Height===%d",self.ManOrKidString,Height);
    
    if ([self.ManOrKidString isEqualToString:@"2"]){
        
        ManPaioHaoView = [[UIView alloc] init];
        
        ManPaioHaoView.frame = CGRectMake(0, TopTipsHeight+ 71+69+50+59+50*ManArray.count, [UIScreen mainScreen].bounds.size.width, 50*Height);
        
        ManPaioHaoView.backgroundColor = [UIColor whiteColor];
        [_scrollView addSubview:ManPaioHaoView];
        
        ManPaioHaoLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, (50-13)/2, 60, 13)];
        ManPaioHaoLabel.text = @"成人票号";
        ManPaioHaoLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        ManPaioHaoLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
        [ManPaioHaoView addSubview:ManPaioHaoLabel];
        
        UIButton *ManPiaoHaoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        ManPiaoHaoButton.frame = CGRectMake(75, (50-14)/2, 14, 14);
        [ManPiaoHaoButton setImage:[UIImage imageNamed:@"icon_tip-grey"] forState:0];
        [ManPiaoHaoButton addTarget:self action:@selector(ManPiaoHaoBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [ManPaioHaoView addSubview:ManPiaoHaoButton];
        
        ManPaioHaoTF = [[UITextField alloc] initWithFrame:CGRectMake(109, (50-20)/2, 200, 20)];
        ManPaioHaoTF.placeholder = @"请输入成人票号";
        //        ManPaioHaoTF.text = self.order_id;
        ManPaioHaoTF.returnKeyType=UIReturnKeyDone;
        ManPaioHaoTF.delegate=self;
        ManPaioHaoTF.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        ManPaioHaoTF.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
        ManPaioHaoTF.keyboardType = UIKeyboardTypeASCIICapable;
        [ManPaioHaoTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
       // [ZZLimitInputManager limitInputView:ManPaioHaoTF maxLength:11];
        [ManPaioHaoView addSubview:ManPaioHaoTF];
        
        UIToolbar *bar3 = [[UIToolbar alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH,44)];
        UIButton *button3 = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 60, 7,50, 30)];
        [button3 setTitle:@"确定"forState:UIControlStateNormal];
        [button3 setTitleColor:[UIColor redColor] forState:0];
        [button3 addTarget:self action:@selector(OKBtnclick) forControlEvents:UIControlEventTouchUpInside];
        [bar3 addSubview:button3];
        
        UIButton *button4 = [[UIButton alloc] initWithFrame:CGRectMake(10, 7,50, 30)];
        [button4 setTitle:@"取消"forState:UIControlStateNormal];
        [button4 setTitleColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0] forState:0];
        [bar3 addSubview:button4];
        [button4 addTarget:self action:@selector(CancleBtnclick) forControlEvents:UIControlEventTouchUpInside];
    //    ManPaioHaoTF.inputAccessoryView = bar3;
        
        UIImageView *line3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 50*Height-1, [UIScreen mainScreen].bounds.size.width, 1)];
        line3.image = [UIImage imageNamed:@"分割线-拷贝"];
        [ManPaioHaoView addSubview:line3];
        
    }
    
    
}
/*****
 *
 *  Description 保险视图
 *
 ******/
-(void)initBaoXianView
{
    BaoXianView = [[UIView alloc] initWithFrame:CGRectMake(0, TopTipsHeight+ 71+10+50+9+59+50+50*ManArray.count+59*Height, [UIScreen mainScreen].bounds.size.width, 50)];
    BaoXianView.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:BaoXianView];
    
    UIImageView *line2 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 11, 13, 14)];
    line2.image = [UIImage imageNamed:@"icon-insurance"];
    [BaoXianView addSubview:line2];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(32, 11, 100, 13)];
    label1.text = @"航空意外险";
    label1.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    label1.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    [BaoXianView addSubview:label1];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(15, 29, 150, 12)];
    label2.text = @"百万保额，飞行有保障";
    label2.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
    label2.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
    [BaoXianView addSubview:label2];
    
    BaoXianSwitch = [[UISwitch alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-60, 10, 50, 30)];
    BaoXianSwitch.tag = 20000;
    BaoXianSwitch.on = YES;//设置初始为ON的一边
    [BaoXianSwitch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];   // 开关事件切换通知
    [BaoXianView addSubview:BaoXianSwitch];
    
    UIImageView *line1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 49, [UIScreen mainScreen].bounds.size.width, 1)];
    line1.image = [UIImage imageNamed:@"分割线-拷贝"];
    [BaoXianView addSubview:line1];
    
    UIButton *baoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    baoButton.frame  =CGRectMake(0, 0, 150, 50);
    [baoButton addTarget:self action:@selector(BaoXianBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [BaoXianView addSubview:baoButton];
    
    
}
/*****
 *
 *  Description 积分
 *
 ******/
-(void)initInterView
{
    InterView = [[UIView alloc] initWithFrame:CGRectMake(0, TopTipsHeight+ 71+10+50+9+59+60+50+50*ManArray.count+59*Height, [UIScreen mainScreen].bounds.size.width, 70)];
    InterView.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:InterView];
    
    UseLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 19, 200, 12)];
    //    UseLabel.text = @"使用 200 积分兑现￥20.00";
    UseLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    UseLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
    [InterView addSubview:UseLabel];
    
    UseLabel.text = [NSString stringWithFormat:@"使用 0.00 积分兑现￥0.00"];
    
    NSString *stringForColor3 = @"0.00";
    // 创建对象.
    NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:UseLabel.text];
    //
    NSRange range3 = [UseLabel.text rangeOfString:stringForColor3];
    [mAttStri addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Regular" size:10] range:range3];
    UseLabel.attributedText=mAttStri;
   // NSString *str= @"(你有4482.12积分，最多可使用200积分)";
  //  CGSize size=[str sizeWithFont:KNSFONT(12) maxSize:CGSizeMake(kScreen_Width-60, 13)];
    InterLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 45, [UIScreen mainScreen].bounds.size.width-60, 13)];
    InterLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
    InterLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
    [InterView addSubview:InterLabel];
    
//   UIButton * But=[UIButton buttonWithType:UIButtonTypeCustom];
//    [But setImage:KImage(@"提示") forState:UIControlStateNormal];
//    [But addTarget:self action:@selector(interTips:) forControlEvents:UIControlEventTouchUpInside];
//    But.tag=1689;
//    [InterView addSubview:tipsBut];
    tipsBut=[UIButton buttonWithType:UIButtonTypeCustom];
    [tipsBut setImage:KImage(@"提示") forState:UIControlStateNormal];
    [tipsBut addTarget:self action:@selector(interTips:) forControlEvents:UIControlEventTouchUpInside];
    
    [InterView addSubview:tipsBut];


    
    
    InterSwitch = [[UISwitch alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-60, 20, 50, 30)];
    InterSwitch.tag = 10000;
    InterSwitch.on = YES;//设置初始为ON的一边
    [InterSwitch addTarget:self action:@selector(switchAction1:) forControlEvents:UIControlEventValueChanged];   // 开关事件切换通知
    [InterView addSubview:InterSwitch];
    
    UIImageView *line1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 69, [UIScreen mainScreen].bounds.size.width, 1)];
    line1.image = [UIImage imageNamed:@"分割线-拷贝"];
    [InterView addSubview:line1];
    
    
    
    
}
/*****
 *
 *  Description 协议
 *
 ******/
-(void)initXieYiView
{
    
    XieYiView = [[UIView alloc] initWithFrame:CGRectMake(0, TopTipsHeight+ 71+10+50+9+50+59+60+70+10+50*ManArray.count+59*Height, [UIScreen mainScreen].bounds.size.width, 40)];
    //    XieYiView.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:XieYiView];
    
    UIButton *XieYiButton = [UIButton buttonWithType:UIButtonTypeCustom];
    XieYiButton.frame = CGRectMake(14, 10, 16, 16);
    [XieYiButton setImage:[UIImage imageNamed:@"icon-selected-blue"] forState:0];
    [XieYiButton addTarget:self action:@selector(XieYiBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [XieYiView addSubview:XieYiButton];
    
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(35, 0, [UIScreen mainScreen].bounds.size.width-50, 80)];
    _textView.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
    _textView.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1.0];
    _textView.delegate = self;
    _textView.editable = NO;        //必须禁止输入，否则点击将弹出输入键盘
    _textView.scrollEnabled = NO;
    [XieYiView addSubview:_textView];
    
    //    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(35, 0, [UIScreen mainScreen].bounds.size.width-50, 40)];
    //    label2.numberOfLines=0;
    //    label2.text = @"我已阅读并同意 《关于民航旅客行李中携带锂电池规定的公告》《关于禁止携带危险品乘机的通知》《特殊旅客购票须知》。";
    //    label2.textColor = [UIColor colorWithRed:43/255.0 green:143/255.0 blue:255/255.0 alpha:1.0];
    //    label2.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
    //    [XieYiView addSubview:label2];
    ////
    //
    //    NSString *stringForColor3 = @"我已阅读并同意";
    //    // 创建对象.
    //    NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:label2.text];
    //    //
    //    NSRange range3 = [label2.text rangeOfString:stringForColor3];
    //    [mAttStri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0] range:range3];
    //    label2.attributedText=mAttStri;
    
    
    [self protocolIsSelect:self.isSelect];
    
}
/*****
 *
 *  Description 付款视图
 *
 ******/
-(void)initBoomView
{
    
    UIView *boomView = [[UIView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-49-KSafeAreaBottomHeight, [UIScreen mainScreen].bounds.size.width-144, 49)];
    boomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:boomView];
    
    
    PriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, [UIScreen mainScreen].bounds.size.width-144-30, 20)];
    PriceLabel.text = @"￥---";
    PriceLabel.textColor = [UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
    PriceLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:19];
    [boomView addSubview:PriceLabel];
    
    UpimgView = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-144-24, (49-8)/2, 14, 8)];
    UpimgView.image = [UIImage imageNamed:@"icon_more-up"];
    [boomView addSubview:UpimgView];
    
    
    UpButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UpButton.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width-144, 49);
    [UpButton addTarget:self action:@selector(UpBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    UpButton.selected = YES;
    UpButton.hidden=YES;
    UpimgView.hidden=YES;
    [boomView addSubview:UpButton];
    
    
    
    UIView *PayView = [[UIView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-144, [UIScreen mainScreen].bounds.size.height-49-KSafeAreaBottomHeight, 144, 49)];
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)[UIColor colorWithRed:255/255.0 green:52/255.0 blue:90/255.0 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0].CGColor];
    gradientLayer.locations = @[@0.0, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1.0);
    gradientLayer.frame = CGRectMake(0, 0, 144, 49);
    [PayView.layer addSublayer:gradientLayer];
    
    [self.view addSubview:PayView];
    
    UIButton *Pay = [UIButton buttonWithType:UIButtonTypeCustom];
    Pay.frame = CGRectMake(0, 0, 144, 49);
    Pay.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:16];
    [Pay addTarget:self action:@selector(PayBtnCLick) forControlEvents:UIControlEventTouchUpInside];
    [Pay setTitle:@"付款" forState:0];
    [Pay setTitleColor:[UIColor whiteColor] forState:0];
    [PayView addSubview:Pay];
    
}
/*******************************************************      各种button执行方法、页面间的跳转       ******************************************************/
/*****
 *
 *  Description 右滑返回上级页面
 *
 ******/
- (void)handleSwipes:(UISwipeGestureRecognizer *)sender
{
    if (sender.direction == UISwipeGestureRecognizerDirectionLeft) {
        
    }
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        
        NSLog(@"右滑");
        [self.navigationController popViewControllerAnimated:YES];
    }
}
-(void)DeleteBtnClick:(UIButton *)sender
{
    
    index = (int)sender.tag-1500;
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"确定要删除该乘机人？" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
    [alert show];
    
    
    
    
}
-(void)switchAction:(id)sender
{
    //保险
    UISwitch *switchButton = (UISwitch*)sender;
    UISwitch *inter = (UISwitch *)[self.view viewWithTag:10000];
    
    BOOL ret = [inter isOn];
    
    BOOL isButtonOn = [switchButton isOn];
    if (isButtonOn) {
        NSLog(@"开");
        
        if (ManArray.count==0) {
            
            PriceLabel.text = @"￥---";
            
        }else{
            
            if (ret) {
                
                //                NSLog(@"积分打开");
                
                //                PriceLabel.text = [NSString stringWithFormat:@"￥%.02f(共%d人)",[self.Money floatValue]*ManArray.count + [self.sale floatValue]*ManArray.count - [self.CanUseInter floatValue],(int)ManArray.count];
                
                if ([self.integral floatValue] >= ([self.Money floatValue]*ManArray.count + [self.sale floatValue]*ManArray.count)*[self.proportion floatValue]) {
                    
                    
                    PriceLabel.text = [NSString stringWithFormat:@"￥%.02f(共%d人)",[self.Money floatValue]*ManArray.count + [self.sale floatValue]*ManArray.count - ([self.Money floatValue]*ManArray.count + [self.sale floatValue]*ManArray.count)*[self.proportion floatValue],(int)ManArray.count];
                    
                    self.Pay_money = [NSString stringWithFormat:@"%.02f",[self.Money floatValue]*ManArray.count + [self.sale floatValue]*ManArray.count - ([self.Money floatValue]*ManArray.count + [self.sale floatValue]*ManArray.count)*[self.proportion floatValue]];
                    
                    InterLabel.text = [NSString stringWithFormat:@"(你有%@积分，最多可使用%.02f积分)",self.integral,([self.Money floatValue]*ManArray.count + [self.sale floatValue]*ManArray.count)*[self.proportion floatValue]];
                    
                    UseLabel.text = [NSString stringWithFormat:@"使用 %.02f 积分兑现￥%.02f",([self.Money floatValue]*ManArray.count + [self.sale floatValue]*ManArray.count)*[self.proportion floatValue],([self.Money floatValue]*ManArray.count + [self.sale floatValue]*ManArray.count)*[self.proportion floatValue]];
                    
                    self.CanUseInter = [NSString stringWithFormat:@"%.02f",([self.Money floatValue]*ManArray.count + [self.sale floatValue]*ManArray.count)*[self.proportion floatValue]];
                    
                    self.DiKouInter = [NSString stringWithFormat:@"%.02f",([self.Money floatValue]*ManArray.count + [self.sale floatValue]*ManArray.count)*[self.proportion floatValue]];
                    
                    NSString *stringForColor3 = [NSString stringWithFormat:@"%.02f",([self.Money floatValue]*ManArray.count + [self.sale floatValue]*ManArray.count)*[self.proportion floatValue]];
                    // 创建对象.
                    NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:UseLabel.text];
                    //
                    NSRange range3 = [UseLabel.text rangeOfString:stringForColor3];
                    [mAttStri addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Regular" size:10] range:range3];
                    UseLabel.attributedText=mAttStri;
                    
                }else{
                    
                    PriceLabel.text = [NSString stringWithFormat:@"￥%.02f(共%d人)",[self.Money floatValue]*ManArray.count + [self.sale floatValue]*ManArray.count - [self.integral floatValue],(int)ManArray.count];
                    
                    self.Pay_money = [NSString stringWithFormat:@"%.02f",[self.Money floatValue]*ManArray.count + [self.sale floatValue]*ManArray.count - [self.integral floatValue]];
                    
                    InterLabel.text = [NSString stringWithFormat:@"(你有%@积分，最多可使用%.02f积分)",self.integral,[self.integral floatValue]];
                    
                    UseLabel.text = [NSString stringWithFormat:@"使用 %.02f 积分兑现￥%.02f",[self.integral floatValue],[self.integral floatValue]];
                    
                    self.CanUseInter = [NSString stringWithFormat:@"%.02f",[self.integral floatValue]];
                    
                    self.DiKouInter = [NSString stringWithFormat:@"%.02f",[self.integral floatValue]];
                    
                    NSString *stringForColor3 = [NSString stringWithFormat:@"%.02f",[self.integral floatValue]];
                    // 创建对象.
                    NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:UseLabel.text];
                    //
                    NSRange range3 = [UseLabel.text rangeOfString:stringForColor3];
                    [mAttStri addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Regular" size:10] range:range3];
                    UseLabel.attributedText=mAttStri;
                    
                }
            }else{
                
                //                NSLog(@"积分关闭");
                
                PriceLabel.text = [NSString stringWithFormat:@"￥%.02f(共%d人)",[self.Money floatValue]*ManArray.count + [self.sale floatValue]*ManArray.count,(int)ManArray.count];
                
                self.Pay_money = [NSString stringWithFormat:@"%.02f",[self.Money floatValue]*ManArray.count + [self.sale floatValue]*ManArray.count];
                
                InterLabel.text = [NSString stringWithFormat:@"(你有%@积分，最多可使用0.00积分)",self.integral];
                
                UseLabel.text = [NSString stringWithFormat:@"使用 0.00 积分兑现￥0.00"];
                
                self.DiKouInter = @"0.00";
                
                NSString *stringForColor3 = @"0.00";
                // 创建对象.
                NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:UseLabel.text];
                //
                NSRange range3 = [UseLabel.text rangeOfString:stringForColor3];
                [mAttStri addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Regular" size:10] range:range3];
                UseLabel.attributedText=mAttStri;
                
            }
            
            
            NSString *stringForColor = @"￥";
            NSString *stringForColor1 = [NSString stringWithFormat:@"(共%d人)",(int)ManArray.count];
            // 创建对象.
            NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:PriceLabel.text];
            //
            NSRange range = [PriceLabel.text rangeOfString:stringForColor];
            NSRange range1 = [PriceLabel.text rangeOfString:stringForColor1];
            
            [mAttStri addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Medium" size:12] range:range];
            [mAttStri addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:12] range:range1];
            [mAttStri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0] range:range1];
            
            PriceLabel.attributedText=mAttStri;
        }
        
        
    }else {
        NSLog(@"关");
        
        
        if (ManArray.count==0) {
            
            PriceLabel.text = @"￥---";
        }else{
            
            
            if (ret) {
                
                //                NSLog(@"积分打开");
                
                //                PriceLabel.text = [NSString stringWithFormat:@"￥%.02f(共%d人)",[self.Money floatValue]*ManArray.count- [self.CanUseInter floatValue],(int)ManArray.count];
                
                if ([self.integral floatValue] >= ([self.Money floatValue]*ManArray.count)*[self.proportion floatValue]) {
                    
                    //890
                    PriceLabel.text = [NSString stringWithFormat:@"￥%.02f(共%d人)",[self.Money floatValue]*ManArray.count - ([self.Money floatValue]*ManArray.count)*[self.proportion floatValue],(int)ManArray.count];
                    
                    self.Pay_money = [NSString stringWithFormat:@"%.02f",[self.Money floatValue]*ManArray.count - ([self.Money floatValue]*ManArray.count)*[self.proportion floatValue]];
                    
                    InterLabel.text = [NSString stringWithFormat:@"(你有%@积分，最多可使用%.02f积分)",self.integral,([self.Money floatValue]*ManArray.count)*[self.proportion floatValue]];
                    
                    UseLabel.text = [NSString stringWithFormat:@"使用 %.02f 积分兑现￥%.02f",([self.Money floatValue]*ManArray.count )*[self.proportion floatValue],([self.Money floatValue]*ManArray.count)*[self.proportion floatValue]];
                    
                    self.DiKouInter = [NSString stringWithFormat:@"%.02f",([self.Money floatValue]*ManArray.count)*[self.proportion floatValue]];
                    
                    NSString *stringForColor3 = [NSString stringWithFormat:@"%.02f",([self.Money floatValue]*ManArray.count)*[self.proportion floatValue]];
                    // 创建对象.
                    NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:UseLabel.text];
                    //
                    NSRange range3 = [UseLabel.text rangeOfString:stringForColor3];
                    [mAttStri addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Regular" size:10] range:range3];
                    UseLabel.attributedText=mAttStri;
                    
                }else{
                    
                    PriceLabel.text = [NSString stringWithFormat:@"￥%.02f(共%d人)",[self.Money floatValue]*ManArray.count - [self.integral floatValue],(int)ManArray.count];
                    
                    self.Pay_money = [NSString stringWithFormat:@"%.02f",[self.Money floatValue]*ManArray.count - [self.integral floatValue]];
                    
                    InterLabel.text = [NSString stringWithFormat:@"(你有%@积分，最多可使用%.02f积分)",self.integral,[self.integral floatValue]];
                    
                    UseLabel.text = [NSString stringWithFormat:@"使用 %.02f 积分兑现￥%.02f",[self.integral floatValue],[self.integral floatValue]];
                    
                    self.DiKouInter = [NSString stringWithFormat:@"%.02f",[self.integral floatValue]];
                    
                    
                    NSString *stringForColor3 = [NSString stringWithFormat:@"%.02f",[self.integral floatValue]];
                    // 创建对象.
                    NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:UseLabel.text];
                    //
                    NSRange range3 = [UseLabel.text rangeOfString:stringForColor3];
                    [mAttStri addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Regular" size:10] range:range3];
                    UseLabel.attributedText=mAttStri;
                    
                }
                
            }else{
                
                //                NSLog(@"积分关闭");
                
                PriceLabel.text = [NSString stringWithFormat:@"￥%.02f(共%d人)",[self.Money floatValue]*ManArray.count,(int)ManArray.count];
                
                self.Pay_money = [NSString stringWithFormat:@"%.02f",[self.Money floatValue]*ManArray.count];
                
                InterLabel.text = [NSString stringWithFormat:@"(你有%@积分，最多可使用0.00积分)",self.integral];
                
                UseLabel.text = [NSString stringWithFormat:@"使用 0.00 积分兑现￥0.00"];
                self.DiKouInter = @"0.00";
                NSString *stringForColor3 = @"0.00";
                // 创建对象.
                NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:UseLabel.text];
                //
                NSRange range3 = [UseLabel.text rangeOfString:stringForColor3];
                [mAttStri addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Regular" size:10] range:range3];
                UseLabel.attributedText=mAttStri;
                
            }
            
            
            
            
            NSString *stringForColor = @"￥";
            NSString *stringForColor1 = [NSString stringWithFormat:@"(共%d人)",(int)ManArray.count];
            // 创建对象.
            NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:PriceLabel.text];
            //
            NSRange range = [PriceLabel.text rangeOfString:stringForColor];
            NSRange range1 = [PriceLabel.text rangeOfString:stringForColor1];
            
            [mAttStri addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Medium" size:12] range:range];
            [mAttStri addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:12] range:range1];
            [mAttStri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0] range:range1];
            
            PriceLabel.attributedText=mAttStri;
            
        }
        
    }
}

-(void)switchAction1:(id)sender
{
    
    UISwitch *switchButton = (UISwitch*)sender;
    
    UISwitch *inter = (UISwitch *)[self.view viewWithTag:20000];
    
    BOOL ret = [inter isOn];
    
    BOOL isButtonOn = [switchButton isOn];
    if (isButtonOn) {
        NSLog(@"开");
        
        if (ManArray.count==0) {
            
            PriceLabel.text = @"￥---";
        }else{
            
            if (ret) {
                
                //               NSLog(@"保险打开");
                
                //                PriceLabel.text = [NSString stringWithFormat:@"￥%.02f(共%d人)",[self.Money floatValue]*ManArray.count + [self.sale floatValue]*ManArray.count - [self.CanUseInter floatValue],(int)ManArray.count];
                
                if ([self.integral floatValue] >= ([self.Money floatValue]*ManArray.count + [self.sale floatValue]*ManArray.count)*[self.proportion floatValue]) {
                    
                    
                    PriceLabel.text = [NSString stringWithFormat:@"￥%.02f(共%d人)",[self.Money floatValue]*ManArray.count + [self.sale floatValue]*ManArray.count - ([self.Money floatValue]*ManArray.count + [self.sale floatValue]*ManArray.count)*[self.proportion floatValue],(int)ManArray.count];
                    
                    self.Pay_money = [NSString stringWithFormat:@"%.02f",[self.Money floatValue]*ManArray.count + [self.sale floatValue]*ManArray.count - ([self.Money floatValue]*ManArray.count + [self.sale floatValue]*ManArray.count)*[self.proportion floatValue]];
                    
                    InterLabel.text = [NSString stringWithFormat:@"(你有%@积分，最多可使用%.02f积分)",self.integral,([self.Money floatValue]*ManArray.count + [self.sale floatValue]*ManArray.count)*[self.proportion floatValue]];
                    
                    self.DiKouInter = [NSString stringWithFormat:@"%.02f",([self.Money floatValue]*ManArray.count + [self.sale floatValue]*ManArray.count)*[self.proportion floatValue]];
                    
                    UseLabel.text = [NSString stringWithFormat:@"使用 %.02f 积分兑现￥%.02f",([self.Money floatValue]*ManArray.count + [self.sale floatValue]*ManArray.count)*[self.proportion floatValue],([self.Money floatValue]*ManArray.count + [self.sale floatValue]*ManArray.count)*[self.proportion floatValue]];
                    
                    
                    NSString *stringForColor3 = [NSString stringWithFormat:@"%.02f",([self.Money floatValue]*ManArray.count + [self.sale floatValue]*ManArray.count)*[self.proportion floatValue]];
                    // 创建对象.
                    NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:UseLabel.text];
                    //
                    NSRange range3 = [UseLabel.text rangeOfString:stringForColor3];
                    [mAttStri addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Regular" size:10] range:range3];
                    UseLabel.attributedText=mAttStri;
                    
                }else{
                    
                    PriceLabel.text = [NSString stringWithFormat:@"￥%.02f(共%d人)",[self.Money floatValue]*ManArray.count + [self.sale floatValue]*ManArray.count - [self.integral floatValue],(int)ManArray.count];
                    
                    self.Pay_money = [NSString stringWithFormat:@"%.02f",[self.Money floatValue]*ManArray.count + [self.sale floatValue]*ManArray.count - [self.integral floatValue]];
                    
                    InterLabel.text = [NSString stringWithFormat:@"(你有%@积分，最多可使用%.02f积分)",self.integral,[self.integral floatValue]];
                    
                    UseLabel.text = [NSString stringWithFormat:@"使用 %.02f 积分兑现￥%.02f",[self.integral floatValue],[self.integral floatValue]];
                    
                    self.DiKouInter = [NSString stringWithFormat:@"%.02f",[self.integral floatValue]];
                    
                    NSString *stringForColor3 = [NSString stringWithFormat:@"%.02f",[self.integral floatValue]];
                    // 创建对象.
                    NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:UseLabel.text];
                    //
                    NSRange range3 = [UseLabel.text rangeOfString:stringForColor3];
                    [mAttStri addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Regular" size:10] range:range3];
                    UseLabel.attributedText=mAttStri;
                    
                }
                
            }else{
                
                //                NSLog(@"保险关闭");
                
                //                PriceLabel.text = [NSString stringWithFormat:@"￥%.02f(共%d人)",[self.Money floatValue]*ManArray.count -[self.CanUseInter floatValue],(int)ManArray.count];
                
                if ([self.integral floatValue] >= ([self.Money floatValue]*ManArray.count)*[self.proportion floatValue]) {
                    
                    
                    PriceLabel.text = [NSString stringWithFormat:@"￥%.02f(共%d人)",[self.Money floatValue]*ManArray.count - ([self.Money floatValue]*ManArray.count)*[self.proportion floatValue],(int)ManArray.count];
                    
                    self.Pay_money = [NSString stringWithFormat:@"%.02f",[self.Money floatValue]*ManArray.count - ([self.Money floatValue]*ManArray.count)*[self.proportion floatValue]];
                    
                    InterLabel.text = [NSString stringWithFormat:@"(你有%@积分，最多可使用%.02f积分)",self.integral,([self.Money floatValue]*ManArray.count)*[self.proportion floatValue]];
                    
                    self.DiKouInter = [NSString stringWithFormat:@"%.02f",([self.Money floatValue]*ManArray.count)*[self.proportion floatValue]];
                    
                    UseLabel.text = [NSString stringWithFormat:@"使用 %.02f 积分兑现￥%.02f",([self.Money floatValue]*ManArray.count + [self.sale floatValue]*ManArray.count)*[self.proportion floatValue],([self.Money floatValue]*ManArray.count + [self.sale floatValue]*ManArray.count)*[self.proportion floatValue]];
                    
                    
                    NSString *stringForColor3 = [NSString stringWithFormat:@"%.02f",([self.Money floatValue]*ManArray.count + [self.sale floatValue]*ManArray.count)*[self.proportion floatValue]];
                    // 创建对象.
                    NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:UseLabel.text];
                    //
                    NSRange range3 = [UseLabel.text rangeOfString:stringForColor3];
                    [mAttStri addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Regular" size:10] range:range3];
                    UseLabel.attributedText=mAttStri;
                    
                }else{
                    
                    PriceLabel.text = [NSString stringWithFormat:@"￥%.02f(共%d人)",[self.Money floatValue]*ManArray.count - [self.integral floatValue],(int)ManArray.count];
                    
                    self.Pay_money = [NSString stringWithFormat:@"%.02f",[self.Money floatValue]*ManArray.count - [self.integral floatValue]];
                    
                    InterLabel.text = [NSString stringWithFormat:@"(你有%@积分，最多可使用%.02f积分)",self.integral,[self.integral floatValue]];
                    
                    self.DiKouInter = [NSString stringWithFormat:@"%.02f",[self.integral floatValue]];
                    
                    UseLabel.text = [NSString stringWithFormat:@"使用 %.02f 积分兑现￥%.02f",[self.integral floatValue],[self.integral floatValue]];
                    
                    
                    NSString *stringForColor3 = [NSString stringWithFormat:@"%.02f",[self.integral floatValue]];
                    // 创建对象.
                    NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:UseLabel.text];
                    //
                    NSRange range3 = [UseLabel.text rangeOfString:stringForColor3];
                    [mAttStri addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Regular" size:10] range:range3];
                    UseLabel.attributedText=mAttStri;
                    
                }
                
                
            }
            
            
            NSString *stringForColor = @"￥";
            NSString *stringForColor1 = [NSString stringWithFormat:@"(共%d人)",(int)ManArray.count];
            // 创建对象.
            NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:PriceLabel.text];
            //
            NSRange range = [PriceLabel.text rangeOfString:stringForColor];
            NSRange range1 = [PriceLabel.text rangeOfString:stringForColor1];
            
            [mAttStri addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Medium" size:12] range:range];
            [mAttStri addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:12] range:range1];
            [mAttStri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0] range:range1];
            
            PriceLabel.attributedText=mAttStri;
        }
        
    }else {
        NSLog(@"关");
        
        if (ManArray.count==0) {
            
            PriceLabel.text = @"￥---";
        }else{
            
            
            if (ret) {
                
                //                NSLog(@"保险打开");
                
                PriceLabel.text = [NSString stringWithFormat:@"￥%.02f(共%d人)",[self.Money floatValue]*ManArray.count+[self.sale floatValue]*ManArray.count,(int)ManArray.count];
                
                self.Pay_money = [NSString stringWithFormat:@"%.02f",[self.Money floatValue]*ManArray.count+[self.sale floatValue]*ManArray.count];
                
                NSString *integralStr=@"";
                if([self.integral floatValue] >= ([self.Money floatValue]*ManArray.count + [self.sale floatValue]*ManArray.count)*[self.proportion floatValue])
                {
                    integralStr=[NSString stringWithFormat:@"%.02f",([self.Money floatValue]*ManArray.count + [self.sale floatValue]*ManArray.count)*[self.proportion floatValue]];;
                    
                }else
                {
                    integralStr=self.integral;
                }
                InterLabel.text = [NSString stringWithFormat:@"(你有%@积分，最多可使用%@积分)",self.integral,integralStr];
                
                self.DiKouInter = [NSString stringWithFormat:@"0.00"];
                
                UseLabel.text = [NSString stringWithFormat:@"使用 0.00 积分兑现￥0.00"];
                
                NSString *stringForColor3 = @"0.00";
                // 创建对象.
                NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:UseLabel.text];
                //
                NSRange range3 = [UseLabel.text rangeOfString:stringForColor3];
                [mAttStri addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Regular" size:10] range:range3];
                UseLabel.attributedText=mAttStri;
                
            }else{
                
                //                NSLog(@"保险关闭");
                
                PriceLabel.text = [NSString stringWithFormat:@"￥%.02f(共%d人)",[self.Money floatValue]*ManArray.count,(int)ManArray.count];
                self.Pay_money = [NSString stringWithFormat:@"%.02f",[self.Money floatValue]*ManArray.count];
                NSString *integralStr=@"";
                if([self.integral floatValue] >= ([self.Money floatValue]*ManArray.count + [self.sale floatValue]*ManArray.count)*[self.proportion floatValue])
                {
                    integralStr=[NSString stringWithFormat:@"%.02f",([self.Money floatValue]*ManArray.count + [self.sale floatValue]*ManArray.count)*[self.proportion floatValue]];;
                    
                }else
                {
                    integralStr=self.integral;
                }
                InterLabel.text = [NSString stringWithFormat:@"(你有%@积分，最多可使用%@积分)",self.integral,integralStr];
                self.DiKouInter = [NSString stringWithFormat:@"0.00"];
                UseLabel.text = [NSString stringWithFormat:@"使用 0.00 积分兑现￥0.00"];
                
                NSString *stringForColor3 = @"0.00";
                // 创建对象.
                NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:UseLabel.text];
                //
                NSRange range3 = [UseLabel.text rangeOfString:stringForColor3];
                [mAttStri addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Regular" size:10] range:range3];
                UseLabel.attributedText=mAttStri;
                
            }
            
            
            
            
            NSString *stringForColor = @"￥";
            NSString *stringForColor1 = [NSString stringWithFormat:@"(共%d人)",(int)ManArray.count];
            // 创建对象.
            NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:PriceLabel.text];
            //
            NSRange range = [PriceLabel.text rangeOfString:stringForColor];
            NSRange range1 = [PriceLabel.text rangeOfString:stringForColor1];
            
            [mAttStri addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Medium" size:12] range:range];
            [mAttStri addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:12] range:range1];
            [mAttStri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0] range:range1];
            
            PriceLabel.attributedText=mAttStri;
            
        }
        
    }
    
    CGSize size=[InterLabel.text sizeWithFont:KNSFONT(12) maxSize:CGSizeMake(kScreen_Width-30, 14)];
    tipsBut.frame=CGRectMake(size.width+15+5, 47, 11, 11);
    CGRect rect=InterView.frame;
    InterTipsBut.frame=CGRectMake(tipsBut.center.x-40,rect.origin.y+tipsBut.frame.origin.y+tipsBut.frame.size.height, 80, 40);
}
-(void)XieYiBtnClick
{
    
    
}
-(void)PhoneBtnClick
{
    CNContactPickerViewController * vc = [[CNContactPickerViewController alloc] init];
    vc.delegate = self;
    [self presentViewController:vc animated:YES completion:nil];
    
}

-(void)BaoXianBtnClick
{
    _baoView.Text = self.Remark;
    
    [_baoView showInView:self.view];
    
}

-(void)ManBtnClick
{
    //键盘掉下
    [NameTF resignFirstResponder];
    [PhoneLabel resignFirstResponder];
    [ManPaioHaoTF resignFirstResponder];
    
    NSMutableArray *arrM = [NSMutableArray new];
    
    if (ManArray.count > 0) {
        
        for (BianMinModel *model in ManArray) {
            
            [arrM addObject:model];
            
        }
        
        OldManArray = arrM;
    }
    
    _addView.TicketCount = self.TicketString;
    
    _addView.ManKidString = self.ManOrKidString;
    
    _addView.delegate=self;
    
    _addView.ManArray = SelectArrM;
    
    _addView.PageString = @"0";
    
    [_addView showInView:self.view];
}
-(void)TimeBtnClick
{
    _customShareView.Text = self.Text;
    
    [_customShareView showInView:self.view Text:self.Text];
    
}
-(void)QurtBtnClick
{
    if ([self.LoginBack isEqualToString:@"888"]) {
        
        [NameTF resignFirstResponder];
        [PhoneLabel resignFirstResponder];
        [ManPaioHaoTF resignFirstResponder];
        
        [self.view endEditing:YES];
        
        NSArray *vcArray = self.navigationController.viewControllers;
        
        NSLog(@"==viewControllers===%@",vcArray);
        
        for(UIViewController *vc in vcArray)
        {
            
            if ([vc isKindOfClass:[AirPlaneDetailViewController class]]){
                
                
                self.navigationController.navigationBar.hidden=YES;
                
                [self.navigationController popToViewController:vc animated:NO];
                
            }
            //            else{
            //
            //                self.navigationController.navigationBar.hidden=YES;
            //                self.tabBarController.tabBar.hidden=NO;
            //                [self.navigationController popToRootViewControllerAnimated:NO];
            //            }
            
        }
    }else{
        
        [NameTF resignFirstResponder];
        [PhoneLabel resignFirstResponder];
        [ManPaioHaoTF resignFirstResponder];
        
        [self.view endEditing:YES];
        
        [self.navigationController popViewControllerAnimated:NO];
    }
    
}
//明细
-(void)UpBtnClick:(UIButton *)sender
{
    
    UISwitch *baoxian = (UISwitch *)[self.view viewWithTag:20000];
    
    BOOL ret1 = [baoxian isOn];
    //判断积分按钮是否打开
    UISwitch *jifen = (UISwitch *)[self.view viewWithTag:10000];
    
    BOOL ret2 = [jifen isOn];
    
    if (sender.selected) {
        
        [_mingxiView Price:self.Price JiJian:self.RanYou BaoXian:self.sale DiKoi:self.DiKouInter Number:(int)ManArray.count kai1:ret1 kai2:ret2];
        
        [_mingxiView showInView:self.view];
        
        _mingxiView.delegate=self;
        
        UpimgView.image = [UIImage imageNamed:@"icon_more-down"];
        sender.selected = !sender.selected;
        
    }else{
        
        [_mingxiView hideInView];
        UpimgView.image = [UIImage imageNamed:@"icon_more-up"];
        sender.selected=YES;
        
        
    }
}


-(void)GoBtnClick
{
    _oneView.time = self.time;
    _oneView.flightNo = self.flightNo;
    _oneView.CarrinerName = self.CarrinerName;
    _oneView.Air_OffTime = self.Air_OffTime;
    _oneView.ArriveTime = self.ArriveTime;
    _oneView.Air_RunTime = self.Air_RunTime;
    _oneView.Air_StartT = self.Air_StartT;
    _oneView.Air_EndT = self.Air_EndT;
    _oneView.Air_Meat = self.Air_Meat;
    _oneView.Air_PlaneType = self.Air_PlaneType;
    _oneView.Air_PlaneModel = self.Air_PlaneModel;
    _oneView.Air_StartPortName = self.Air_StartPortName;
    _oneView.Air_EndPortName = self.Air_EndPortName;
    _oneView.DateWeek = self.DateWeek;
    _oneView.TypeString = self.TypeString;
    _oneView.Air_ByPass=self.Air_ByPass;
    
    [_oneView Time:self.time Flight:self.flightNo];
    
    [_oneView showInView:self.view];
    
}
//弹框
-(void)ManPiaoHaoBtnClick
{
    
    [_piaoView showInView:self.view];
    
}
-(void)OKBtnclick
{
    [NameTF resignFirstResponder];
    [PhoneLabel resignFirstResponder];
    [ManPaioHaoTF resignFirstResponder];
}

-(void)CancleBtnclick
{
    [NameTF resignFirstResponder];
    [PhoneLabel resignFirstResponder];
    [ManPaioHaoTF resignFirstResponder];
}

-(void)interTips:(UIButton *)sender
{
    
    if (!InterTipsBut){
       // UIButton *but=[self.view viewWithTag:1689];
        CGRect rect=InterView.frame;
        InterTipsBut=[UIButton buttonWithType:UIButtonTypeCustom];
        InterTipsBut.frame=CGRectMake(tipsBut.center.x-40,rect.origin.y+tipsBut.frame.origin.y+tipsBut.frame.size.height, 80, 40);
        [InterTipsBut setImage:KImage(@"提示框425") forState:UIControlStateNormal];
       // InterTipsView.image=KImage(@"提示框425");
        [InterTipsBut addTarget:self action:@selector(interTips:) forControlEvents:UIControlEventTouchUpInside];
        UILabel *tipsLab=[[UILabel alloc]initWithFrame:CGRectMake(5, 0, 70, 40)];
        tipsLab.font=KNSFONTM(10);
        tipsLab.textAlignment=NSTextAlignmentCenter;
        tipsLab.textColor=RGB(93, 143, 255);
        tipsLab.text=@"积分只能代付总金额的10%";
        tipsLab.numberOfLines=0;
        [InterTipsBut addSubview:tipsLab];
        
        
        [_scrollView addSubview:InterTipsBut];
        //[InterView addSubview:InterTipsView];
        InterTipsBut.hidden=YES;
    }
    InterTipsBut.hidden=!InterTipsBut.hidden;
    
    
    
}
/*******************************************************      协议方法       ******************************************************/

/*******************************************************      代码提取(多是复用代码)       ******************************************************/
//添加人代理
-(void)AirPlaneAddMan:(NSArray *)man
{
    
    ManArray = man;
    
    SelectArrM = man;
    
    NSLog(@"==111=ManArray===%@",ManArray);
    
    
    [self initPasserView];

}

-(void)CanClePerson:(NSArray *)man
{
    SelectArrM = man;
    
    NSLog(@"==222=ManArray===%@",SelectArrM);
    
    for (int i = 0; i < SelectArrM.count; i++) {
        
        BianMinModel *model = SelectArrM[i];
        
        model.ManSelectString = @"1";
        
    }
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex==0) {
        
        
    }else{
        
        OldManArray = ManArray;
        
        NSMutableArray *arrM = [NSMutableArray new];
        
        for (BianMinModel *model in ManArray) {
            
            [arrM addObject:model];
            
        }
        
        [arrM removeObjectAtIndex:index];
        ManArray = arrM;
        
        
        //删除的是哪个，就把他变0
        
        for (int i = 0; i < SelectArrM.count; i++) {
            
            BianMinModel *model = SelectArrM[i];
            
            if (i == index) {
                
                model.ManSelectString = @"0";
                
            }
        }
        
        [self initPasserView];
        
    }
}

- (void)protocolIsSelect:(BOOL)select {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"我已阅读并同意 《关于民航旅客行李中携带锂电池规定的公告》《关于禁止携带危险品乘机的通知》《特殊旅客购票须知》。"];
    [attributedString addAttribute:NSLinkAttributeName
                            value:@"zhifubao://"
                        range:[[attributedString string] rangeOfString:@"《关于民航旅客行李中携带锂电池规定的公告》"]];
    [attributedString addAttribute:NSLinkAttributeName
                            value:@"weixin://"
                            range:[[attributedString string] rangeOfString:@"《关于禁止携带危险品乘机的通知》"]];
    [attributedString addAttribute:NSLinkAttributeName
                        value:@"jianhang://"
                        range:[[attributedString string] rangeOfString:@"《特殊旅客购票须知》"]];
    
    NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
    
    NSMutableAttributedString *imageString = [NSMutableAttributedString attributedStringWithAttachment:textAttachment];
    [imageString addAttribute:NSLinkAttributeName
                        value:@"checkbox://"
                        range:NSMakeRange(0, imageString.length)];
    [attributedString insertAttributedString:imageString atIndex:0];
    
    [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Regular" size:12] range:NSMakeRange(0, attributedString.length)];
    _textView.attributedText = attributedString;
    _textView.linkTextAttributes = @{NSForegroundColorAttributeName: [UIColor colorWithRed:43/255.0 green:143/255.0 blue:255/255.0 alpha:1.0],
        NSUnderlineColorAttributeName: [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0],
        NSUnderlineStyleAttributeName: @(NSUnderlinePatternSolid)};
    
    _textView.delegate = self;
    _textView.editable = NO;        //必须禁止输入，否则点击将弹出输入键盘
    _textView.scrollEnabled = NO;
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange {
    if ([[URL scheme] isEqualToString:@"jianhang"]) {
                NSLog(@"建行支付---------------");
        RequestServiceVC *vc=[[RequestServiceVC alloc]initWithURLStr:JMSHTServiceAirSpecialPassengersInstructionsStr];
        
        
    //    AttentionViewController *vc = [[AttentionViewController alloc] init];
        [self.navigationController pushViewController:vc animated:NO];
        self.navigationController.navigationBar.hidden=YES;
        
                return NO;
    } else if ([[URL scheme] isEqualToString:@"zhifubao"]) {
    NSLog(@"支付宝支付---------------");
        
        PublicAnnouncementViewController *vc = [[PublicAnnouncementViewController alloc] init];
        [self.navigationController pushViewController:vc animated:NO];
        self.navigationController.navigationBar.hidden=YES;
        
            return NO;
    } else if ([[URL scheme] isEqualToString:@"weixin"]) { 
                NSLog(@"微信支付---------------");
        
        ProhibitViewController *vc = [[ProhibitViewController alloc] init];
        [self.navigationController pushViewController:vc animated:NO];
        self.navigationController.navigationBar.hidden=YES;
        
            return NO;
    } else if ([[URL scheme] isEqualToString:@"checkbox"]) {
        self.isSelect = !self.isSelect;
        [self protocolIsSelect:self.isSelect];
        return NO;
    }
        return YES;
}

-(void)AirOneMingXi
{
    UpimgView.image = [UIImage imageNamed:@"icon_more-up"];
    UpButton.selected=YES;
    
}

- (NSString*)dictionaryToJson:(NSDictionary *)dic

{
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}

-(void)contactPicker:(CNContactPickerViewController *)picker didSelectContact:(CNContact *)contact
{
//    NSLog(@"联系人的资料:===1111%@",contact);
    
    // 1.获取联系人的姓名
    NSString *lastname = contact.familyName;
    NSString *firstname = contact.givenName;
    NSLog(@"%@ %@", lastname, firstname);
    
    // 2.获取联系人的电话号码
    NSArray *phoneNums = contact.phoneNumbers;
    for (CNLabeledValue *labeledValue in phoneNums) {
        // 2.1.获取电话号码的KEY
        NSString *phoneLabel = labeledValue.label;
        
        // 2.2.获取电话号码
        CNPhoneNumber *phoneNumer = labeledValue.value;
        NSString *phoneValue = phoneNumer.stringValue;
        
        NSLog(@"==%@==%@", phoneLabel, phoneValue);
        
//        PhoneLabel.text = [NSString stringWithFormat:@"%@",phoneValue];
        
        
        
        if ([phoneNumer.stringValue rangeOfString:@"+86"].location !=NSNotFound) {
            
            NSString *cca2 = [phoneNumer.stringValue stringByReplacingOccurrencesOfString:@"+86"withString:@""];//删除
            
            if([cca2 rangeOfString:@"-"].location !=NSNotFound){
                NSLog(@"yes");
                
                PhoneLabel.text =[cca2 stringByReplacingOccurrencesOfString:@"-" withString:@""];
                
            }else{
                
               PhoneLabel.text = [NSString stringWithFormat:@"%@",phoneValue];
                
            }
            
            
            
            
        }else{
            
            if([phoneNumer.stringValue rangeOfString:@"-"].location !=NSNotFound){
                
                PhoneLabel.text =[phoneNumer.stringValue stringByReplacingOccurrencesOfString:@"-" withString:@""];
                
            }else{
                
                PhoneLabel.text = [NSString stringWithFormat:@"%@",phoneValue];
            }
        }
    }
}

-(void)resultStatus:(NSNotification *)text
{
    
    
    if ([text.userInfo[@"resultStatus"] isEqualToString:@"9000"]) {
        
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        //读取数组NSArray类型的数据
        
        
        PersonalAllDanVC *vc=[[PersonalAllDanVC alloc] init];
        [vc selectedDingDanType:@"1" AndIndexType:2];
        
        self.navigationController.viewControllers=@[self.navigationController.viewControllers.firstObject,vc];
        [self.navigationController pushViewController:vc animated:NO];
        
        
        
    }else if ([text.userInfo[@"resultStatus"] isEqualToString:@"8000"]){
        
        [JRToast showWithText:@"正在处理中" duration:2.0f];
        
        
    }else if ([text.userInfo[@"resultStatus"] isEqualToString:@"4000"]){
        
        
        [JRToast showWithText:@"订单支付失败" duration:2.0f];
        
    }else if ([text.userInfo[@"resultStatus"] isEqualToString:@"6001"]){
        
        [JRToast showWithText:@"用户中途取消" duration:2.0f];
        PersonalAllDanVC *vc=[[PersonalAllDanVC alloc] init];
        [vc selectedDingDanType:@"1" AndIndexType:1];
        self.navigationController.viewControllers=@[self.navigationController.viewControllers.firstObject,vc];
        [self.navigationController pushViewController:vc animated:NO];
        
    }else if ([text.userInfo[@"resultStatus"] isEqualToString:@"6002"]){
        
        [JRToast showWithText:@"网络连接出错" duration:2.0f];
    }
    
    
}


-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField==ManPaioHaoTF) {
    
    NSCharacterSet *cs;
    cs = [[NSCharacterSet characterSetWithCharactersInString:kAlphaNum] invertedSet];
    
    
    
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""]; //按cs分离出数组,数组按@""分离出字符串
    
    
    
    BOOL canChange = [string isEqualToString:filtered];
    
    return canChange;
    }
    else
    {
        return YES;
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)textFieldDidChange:(UITextField *)TF
{
    if (TF==ManPaioHaoTF) {
        TF.text=[NSStringHelper toUpper:TF.text];
    }
    
}

@end
