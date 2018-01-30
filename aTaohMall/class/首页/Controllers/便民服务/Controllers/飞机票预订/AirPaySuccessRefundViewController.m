//
//  AirPaySuccessRefundViewController.m
//  aTaohMall
//
//  Created by JMSHT on 2017/6/5.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "AirPaySuccessRefundViewController.h"

#import "AirWaitePayOneView.h"
#import "AirOrderRefundViewController.h"


//刷新
#import "DJRefresh.h"
#import "DJRefreshProgressView.h"
#import "AFNetworking.h"

#import "ConverUtil.h"
#import "DESUtil.h"
#import "SecretCodeTool.h"
#import "AirSelectView.h"
#import "WKProgressHUD.h"
#import "JRToast.h"
#import "AirApplyRefundVC.h"
#import "BianMinModel.h"
#import "AirChengCheRenModel.h"
@interface AirPaySuccessRefundViewController ()
{
    
    UIScrollView *_scrollView;
    
    AirWaitePayOneView *_oneView;
    
    UILabel *OrderLabel;
    UILabel *StartTime;
    UILabel *EndTime;
    UILabel *StartName;
    UILabel *EndName;
    UILabel *Phone;
    UILabel *PersonName;
    UILabel *Price;
    UILabel *WeekLabel;
    UILabel *Datelabel;
    UILabel *longLabel;
    UILabel *StopOverLab;
    
    
    NSMutableArray *_dataArrM;
    NSMutableArray *_tuiArrM;
    
}
@property (nonatomic,strong)NSString *tuikuanStr;
@end

@implementation AirPaySuccessRefundViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    _dataArrM = [NSMutableArray new];
    
    _tuiArrM = [NSMutableArray new];
    
    self.view.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1.0];
    
    [self initNav];
    
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-KSafeAreaTopNaviHeight)];
//    _scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height+300);
    [self.view addSubview:_scrollView];
    
    [self initTopView];
    
    [self initCenterView];
    

    [self getDatas];
    
    [self getTuiKuanDatas];
    
    _oneView = [[AirWaitePayOneView alloc] init];
    
    [self.view addSubview:_oneView];
    
}

-(void)getDatas
{
    
   // WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
    WKProgressHUD *hud = [WKProgressHUD showInView:self.view animated:YES];
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        
        
    });
    
    
    NSLog(@"==otgjhkgmn=%@===%@",self.orderno,self.OrderStatus);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@getOrderDetails_mob.shtml",URL_Str];
    
    NSDictionary *dic = @{@"sigen":self.sigen,@"orderno":self.orderno,@"logo":@"",@"storename":self.storename,@"status":self.OrderStatus};
    
    //    NSDictionary *dic=nil;
    
    [manager POST:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
        NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];
        
        if (codeKey && content) {
            NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
            
            NSLog(@"xmlStr==待发货==%@",xmlStr);
            
            
            NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];
            
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            //            NSLog(@"%@",dic);
            
            
            
            for (NSDictionary *dict1 in dic) {
                
                if ([dict1[@"status"] isEqualToString:@"10000"]) {
                    
                    
                    for (NSDictionary *dict2 in dict1[@"exchangelist"]) {
                        
                        OrderLabel.text = [NSString stringWithFormat:@"订单号：%@",dict2[@"orderno"]];
                        
                        Price.text = [NSString stringWithFormat:@"￥%@",dict2[@"paymoney"]];
                        
                        self.NewNAme = [NSString stringWithFormat:@"%@",dict2[@"username"]];
                        
                        self.NewPhone = [NSString stringWithFormat:@"%@",dict2[@"phone"]];
                        
                        self.payintegral = [NSString stringWithFormat:@"%@",dict2[@"payintegral"]];
                        self.storename=[NSString stringWithFormat:@"%@",dict2[@"storename"]];
                        NSString *stringForColor3 = @"￥";
                        // 创建对象.
                        NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:Price.text];
                        //
                        NSRange range3 = [Price.text rangeOfString:stringForColor3];
                        [mAttStri addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:12] range:range3];
                        Price.attributedText=mAttStri;
                        
                        NSArray *list_money = dict2[@"list_money"];
                        
                        for (NSDictionary *dict5 in list_money) {
                            
                            self.Pay_price = [NSString stringWithFormat:@"%@",dict5[@"price"]];
                            self.fuel_oil_airrax = [NSString stringWithFormat:@"%@",dict5[@"fuel_oil_airrax"]];
                            self.aviation_accident_insurance_price = [NSString stringWithFormat:@"%@",dict5[@"aviation_accident_insurance_price"]];
                            self.is_aviation_accident_insurance = [NSString stringWithFormat:@"%@",dict5[@"is_aviation_accident_insurance"]];
                            
                        }
                        
                        NSArray *list_time = dict2[@"list_time"];
                        
                        for (NSDictionary *dict3 in list_time) {
                            
                            NSString *date = [NSString stringWithFormat:@"%@",dict3[@"date"]];
                            NSString *week = [NSString stringWithFormat:@"%@",dict3[@"week"]];
                            
                            NSString *city = [NSString stringWithFormat:@"%@",dict2[@"name"]];
                            
                            NSArray *array = [date componentsSeparatedByString:@"-"];
                            
                            WeekLabel.text = [NSString stringWithFormat:@"%@ | %@-%@ %@",city,array[1],array[2],week];
                        }
                        
                        
                        NSArray *list_passengers = dict2[@"list_passengers"];
                        
                        for (NSDictionary *dict6 in list_passengers) {
                            
                            BianMinModel *model = [[BianMinModel alloc] init];
                            
                            model.Newpassportseno = [NSString stringWithFormat:@"%@",dict6[@"passportseno"]];
                            model.NewadultTicketNo = [NSString stringWithFormat:@"%@",dict6[@"adultTicketNo"]];
                            model.Newpassenger_name = [NSString stringWithFormat:@"%@",dict6[@"passenger_name"]];
                            
                            [_dataArrM addObject:model];
                            
                        }
                        
                        NSArray *list_base = dict2[@"list_base"];
                        NSLog(@"list_base=%@",list_base);
                        for (NSDictionary *dict4 in list_base) {
                             NSLog(@"dict4=%@",dict4);
                            NSString *OffTime = [NSString stringWithFormat:@"%@",dict4[@"OffTime"]];
                            NSArray *array = [OffTime componentsSeparatedByString:@" "];
                            NSArray *array1 = [array[1] componentsSeparatedByString:@":"];
                            
                            NSString *ArriveTime = [NSString stringWithFormat:@"%@",dict4[@"ArriveTime"]];
                            NSArray *array2 = [ArriveTime componentsSeparatedByString:@" "];
                            NSArray *array3 = [array2[1] componentsSeparatedByString:@":"];
//                            if ([dict4[@"ByPass"] isEqualToString:@"1"])
//                            {
//                                StopOverLab.text=@"经停";
//                            }else
//                            {
//                                StopOverLab.text=@"";
//                            }
                            
                            StartTime.text = [NSString stringWithFormat:@"%@:%@",array1[0],array1[1]];
                            EndTime.text = [NSString stringWithFormat:@"%@:%@",array3[0],array3[1]];
                            
                            longLabel.text = [NSString stringWithFormat:@"%@",dict4[@"RunTime"]];
                            
                            StartName.text = [NSString stringWithFormat:@"%@%@",dict4[@"StartPortName"],dict4[@"StartT"]];
                            EndName.text = [NSString stringWithFormat:@"%@%@",dict4[@"EndPortName"],dict4[@"EndT"]];
                            
                            if ([dict4[@"PlaneModel"] isEqualToString:@""]) {
                                
                                Datelabel.text = [NSString stringWithFormat:@"%@ | %@%@",dict4[@"PlaneType"],dict4[@"CarrinerName"],dict4[@"FlightNo"]];
                            }else{
                                
                                Datelabel.text = [NSString stringWithFormat:@"%@(%@) | %@%@",dict4[@"PlaneType"],dict4[@"PlaneModel"],dict4[@"CarrinerName"],dict4[@"FlightNo"]];
                            }
                            if ([dict4[@"ByPass"] isEqualToString:@"1"])
                            {
                                Datelabel.text=[Datelabel.text stringByAppendingString:@"| 经停"];
                            }
                            
                        }
                        
                    }
                    
                    
                    [self initBoomView];
                    
                    PersonName.text = [NSString stringWithFormat:@"%@",self.NewNAme];
                    
                    Phone.text = [NSString stringWithFormat:@"%@",self.NewPhone];
                    
                }else{
                    
                    
                    
                }
            }
            
            [hud dismiss:YES];
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //        [WKProgressHUD popMessage:@"网络请求失败，请检查您的网络设置" inView:self.view duration:1.5 animated:YES];
        
        [hud dismiss:YES];
        
        
        NSLog(@"%@",error);
    }];
}


-(void)getTuiKuanDatas
{
    
    NSLog(@"==otgjhkgmn=%@",self.orderno);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@getAirOrderRefundInformation_mob.shtml",URL_Str];
    
    NSDictionary *dic = @{@"sigen":self.sigen,@"order":self.orderno};
    
    //    NSDictionary *dic=nil;
    
    [manager POST:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
        NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];
        
        
        if (codeKey && content) {
            NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
            
            NSLog(@"xmlStr==退款信息==%@",xmlStr);
            
            
            NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];
            
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            //            NSLog(@"%@",dic);
            
            
            
                if ([dic[@"status"] isEqualToString:@"10000"]) {
                    
                    
                    for (NSDictionary *dict2 in dic[@"list1"]) {
                        
                        BianMinModel *model = [[BianMinModel alloc] init];
                        
                        model.airport_name = [NSString stringWithFormat:@"%@",dict2[@"airport_name"]];
                        model.time = [NSString stringWithFormat:@"%@",dict2[@"time"]];
                        model.username = [NSString stringWithFormat:@"%@",dict2[@"username"]];
                        model.airport_flight = [NSString stringWithFormat:@"%@",dict2[@"airport_flight"]];
                        model.name = [NSString stringWithFormat:@"%@",dict2[@"name"]];
                        
                        [_tuiArrM addObject:model];
                        
                        
                    }
                    
                    for (NSDictionary *dict2 in dic[@"list2"]) {
                        
                        
                        self.Tuipaymoney = [NSString stringWithFormat:@"%@",dict2[@"paymoney"]];
                        self.Tuipayintegral = [NSString stringWithFormat:@"%@",dict2[@"payintegral"]];
                        
                        
                    }
                    
                    for (NSDictionary *dict2 in dic[@"list3"]) {
                        
                        
                        self.refund_instructions = [NSString stringWithFormat:@"%@",dict2[@"refund_instructions"]];
                        
                        
                    }
                    
                }else{
                    
                    
                    
                }
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
       
        NSLog(@"%@",error);
    }];
}


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
    
    label.text = [NSString stringWithFormat:@"订单详情"];
    
    label.textColor = [UIColor blackColor];
    
    label.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:19];
    
    label.textAlignment = NSTextAlignmentCenter;
    
    [titleView addSubview:label];
    
    
}

-(void)initTopView
{
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 111)];
    topView.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:topView];
    
    UILabel *DaiFuKuan = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 200, 18)];
    DaiFuKuan.text = @"已付款";
    if ([self.OrderStatus isEqualToString:@"2"]) {
        DaiFuKuan.text=@"交易成功";
    }
    DaiFuKuan.textColor = [UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
    DaiFuKuan.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:18];
    [topView addSubview:DaiFuKuan];
    
    Price = [[UILabel alloc] initWithFrame:CGRectMake(80, 19, [UIScreen mainScreen].bounds.size.width-30-80, 14)];
    Price.text = @"";
    Price.textAlignment = NSTextAlignmentRight;
    Price.textColor = [UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
    Price.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:18];
    [topView addSubview:Price];
    
    
    UIImageView *ImgView = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-19, 19, 8, 14)];
    ImgView.image = [UIImage imageNamed:@"icon_more"];
    [topView addSubview:ImgView];
    
    UIButton *MoreButton = [UIButton buttonWithType:UIButtonTypeCustom];
    MoreButton.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 50);
    [MoreButton addTarget:self action:@selector(MoreBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:MoreButton];
    
    OrderLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 38, 250, 12)];
    OrderLabel.text = @"";
    OrderLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
    OrderLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
    [topView addSubview:OrderLabel];
    
    
    UIButton *PayButton = [UIButton buttonWithType:UIButtonTypeCustom];
    PayButton.frame = CGRectMake(15, 64, [UIScreen mainScreen].bounds.size.width-30, 38);
    [PayButton setTitle:@"退款" forState:0];
    [PayButton setTitleColor:[UIColor whiteColor] forState:0];
    [PayButton setBackgroundImage:[UIImage imageNamed:@"btn-buy"] forState:0];
    PayButton.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15];
    [PayButton addTarget:self action:@selector(PayBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:PayButton];
    
    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 110, [UIScreen mainScreen].bounds.size.width, 1)];
    line.image = [UIImage imageNamed:@"分割线-拷贝"];
    [topView addSubview:line];
    
}

-(void)initCenterView
{
    
    UIView *CenterView = [[UIView alloc] initWithFrame:CGRectMake(0, 121, [UIScreen mainScreen].bounds.size.width, 138)];
    CenterView.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:CenterView];
    
    UILabel *Label = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 100, 14)];
    Label.text = @"航班信息";
    Label.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    Label.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15];
    [CenterView addSubview:Label];
    
    WeekLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 39, [UIScreen mainScreen].bounds.size.width-30, 13)];
    WeekLabel.text = @"";
    WeekLabel.textAlignment = NSTextAlignmentCenter;
    WeekLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
    WeekLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
    [CenterView addSubview:WeekLabel];
    
    UIView *TimeView = [[UIView alloc] initWithFrame:CGRectMake(57, 65, [UIScreen mainScreen].bounds.size.width-114, 18)];
    
    [CenterView addSubview:TimeView];
    
    StartTime = [[UILabel alloc] initWithFrame:CGRectMake(0, 3, 100, 14)];
    StartTime.text = @"";
    StartTime.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    StartTime.font = [UIFont fontWithName:@"PingFang-SC-Semibold" size:18];
    [TimeView addSubview:StartTime];
    
    UIView *NameView = [[UIView alloc] initWithFrame:CGRectMake(0, 89, [UIScreen mainScreen].bounds.size.width, 12)];
    
    [CenterView addSubview:NameView];
    
    StartName = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width/2, 12)];
    StartName.text = @"";
    StartName.textAlignment = NSTextAlignmentCenter;
    StartName.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
    StartName.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
    [NameView addSubview:StartName];
    
    EndTime = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-114-100, 3, 100, 14)];
    EndTime.text = @"";
    EndTime.textAlignment = NSTextAlignmentRight;
    EndTime.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    EndTime.font = [UIFont fontWithName:@"PingFang-SC-Semibold" size:18];
    [TimeView addSubview:EndTime];
    
    EndName = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2, 0, [UIScreen mainScreen].bounds.size.width/2, 12)];
    EndName.text = @"";
    EndName.textAlignment = NSTextAlignmentCenter;
    EndName.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
    EndName.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
    [NameView addSubview:EndName];
    
    longLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width-114, 13)];
    longLabel.text = @"";
    longLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
    longLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    longLabel.textAlignment = NSTextAlignmentCenter;
    [TimeView addSubview:longLabel];
    
    UIImageView *GOGO = [[UIImageView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-114-101)/2, 10, 101, 8)];
    GOGO.image = [UIImage imageNamed:@"icon_arrow"];
    [TimeView addSubview:GOGO];
    StopOverLab =[[UILabel alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-30-84-101)/2, 20, 101, 14)];
    StopOverLab.text=@"";
    StopOverLab.textColor=[UIColor blackColor];
    StopOverLab.textAlignment=NSTextAlignmentCenter;
    StopOverLab.font=KNSFONT(15);
    [TimeView addSubview:StopOverLab];
    
    Datelabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 110, [UIScreen mainScreen].bounds.size.width-160, 13)];
    Datelabel.text = @"";
    Datelabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
    Datelabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
    Datelabel.textAlignment = NSTextAlignmentCenter;
    [CenterView addSubview:Datelabel];
    
    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 137, [UIScreen mainScreen].bounds.size.width, 1)];
    line.image = [UIImage imageNamed:@"分割线-拷贝"];
    [CenterView addSubview:line];
    
}

-(void)initBoomView
{
    
    _scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 75*_dataArrM.count+44+44+269);
    
    UIView *BoomView = [[UIView alloc] initWithFrame:CGRectMake(0, 269, [UIScreen mainScreen].bounds.size.width, 75*_dataArrM.count+44+44)];
    BoomView.backgroundColor = [UIColor whiteColor];
    
    [_scrollView addSubview:BoomView];
    
    for (int i =0; i < _dataArrM.count; i++) {
        
        BianMinModel *model = _dataArrM[i];
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 75*i, [UIScreen mainScreen].bounds.size.width, 75)];
        [BoomView addSubview:view];
        
        if (i==0) {
            
            UILabel *Name = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, Width(100), 14)];
            Name.text = @"乘机人";
            Name.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
            Name.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15];
            [view addSubview:Name];
            
        }
        UILabel *Name = [[UILabel alloc] initWithFrame:CGRectMake(Width(116), 15, [UIScreen mainScreen].bounds.size.width-Width(116), 14)];
        Name.text = model.Newpassenger_name;
        Name.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        Name.font = [UIFont fontWithName:@"PingFang-SC-Light" size:14];
        [view addSubview:Name];
        
        UILabel *Id = [[UILabel alloc] initWithFrame:CGRectMake(Width(116), 29, [UIScreen mainScreen].bounds.size.width-Width(116), 14)];
        Id.text = model.Newpassportseno;
        Id.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        Id.font = [UIFont fontWithName:@"PingFang-SC-Light" size:14];
        [view addSubview:Id];
        
        UILabel *PiaoHao = [[UILabel alloc] initWithFrame:CGRectMake(Width(116), 45, kScreen_Width-Width(116), 15)];
        if ([model.NewadultTicketNo isEqualToString:@""]) {
            PiaoHao.text=@"";
        }else
        {
            PiaoHao.text = [NSString stringWithFormat:@"成人票号：%@",model.NewadultTicketNo];
        }
       
        PiaoHao.numberOfLines=1;
        PiaoHao.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        PiaoHao.font  =[UIFont fontWithName:@"PingFang-SC-Light" size:14];
        [view addSubview:PiaoHao];
        
        UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(Width(116), 74, [UIScreen mainScreen].bounds.size.width-Width(116), 1)];
        line.image = [UIImage imageNamed:@"分割线-拷贝"];
        [view addSubview:line];
        
    }
    
    UIView *PersonView = [[UIView alloc] initWithFrame:CGRectMake(0, 75*_dataArrM.count, [UIScreen mainScreen].bounds.size.width, 44)];
    [BoomView addSubview:PersonView];
    
    UILabel *Person = [[UILabel alloc] initWithFrame:CGRectMake(15, (44-14)/2, 80, 14)];
    Person.text = @"联系人";
    Person.numberOfLines=1;
    Person.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    Person.font  =[UIFont fontWithName:@"PingFang-SC-Regular" size:15];
    [PersonView addSubview:Person];
    
    
    PersonName = [[UILabel alloc] initWithFrame:CGRectMake(116, (44-12)/2, 200, 12)];
    PersonName.text = @"";
    PersonName.numberOfLines=1;
    PersonName.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    PersonName.font  =[UIFont fontWithName:@"PingFang-SC-Light" size:15];
    [PersonView addSubview:PersonName];
    
    UIImageView *line1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 43, [UIScreen mainScreen].bounds.size.width, 1)];
    
    line1.image = [UIImage imageNamed:@"分割线-拷贝"];
    
    [PersonView addSubview:line1];
    
    UIView *PhoneView = [[UIView alloc] initWithFrame:CGRectMake(0, 75*_dataArrM.count+44, [UIScreen mainScreen].bounds.size.width, 44)];
    [BoomView addSubview:PhoneView];
    
    UILabel *PhoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, (44-15)/2, 100, 15)];
    PhoneLabel.text = @"联系电话";
    PhoneLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    PhoneLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15];
    [PhoneView addSubview:PhoneLabel];
    
    Phone = [[UILabel alloc] initWithFrame:CGRectMake(116, (44-12)/2, [UIScreen mainScreen].bounds.size.width-116, 12)];
    Phone.text = @"";
    Phone.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    Phone.font = [UIFont fontWithName:@"PingFang-SC-Light" size:15];
    [PhoneView addSubview:Phone];
    
    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 43, [UIScreen mainScreen].bounds.size.width, 1)];
    line.image = [UIImage imageNamed:@"分割线-拷贝"];
    [PhoneView addSubview:line];
}

-(void)MoreBtnClick
{
    NSLog(@"666");
    
    [_oneView Price:self.Pay_price Inter:self.payintegral fuel_oil_airrax:self.fuel_oil_airrax aviation_accident_insurance_price:self.aviation_accident_insurance_price Number:(int)_dataArrM.count is_aviation_accident_insurance:self.is_aviation_accident_insurance];
    
    [_oneView showInView:self.view];
    
    
}


-(void)PayBtnClick
{
    NSLog(@"退款");
    NSDictionary *params=@{@"sigen":[kUserDefaults objectForKey:@"sigen"],@"orderno":self.orderno};
    
    [ATHRequestManager requestForCanRefundInfoWithParams:params successBlock:^(NSDictionary *responseObj) {
        if ([responseObj[@"status"] isEqualToString:@"10000"]) {
//            list1 =     (
//                         {
//                             "airport_flight" = CA4587;
//                             "airport_name" = "\U4e2d\U56fd\U56fd\U822a";
//                             name = "\U6210\U90fd-\U6b66\U6c49";
//                             time = "06\U670813\U65e5";
//                             username = "\U674e\U767d";
//                         },
//                         {
//                             "airport_flight" = CA4587;
//                             "airport_name" = "\U4e2d\U56fd\U56fd\U822a";
//                             name = "\U6210\U90fd-\U6b66\U6c49";
//                             time = "06\U670813\U65e5";
//                             username = "\U675c\U752b";
//                         },
//                         {
//                             "airport_flight" = CA4587;
//                             "airport_name" = "\U4e2d\U56fd\U56fd\U822a";
//                             name = "\U6210\U90fd-\U6b66\U6c49";
//                             time = "06\U670813\U65e5";
//                             username = "\U674e\U6052";
//                         }
//                         );
            
            NSArray *temp=responseObj[@"list1"];
            NSMutableArray *arr=[[NSMutableArray alloc]init];
            for (NSDictionary *dic in temp) {
                AirChengCheRenModel *model=[[AirChengCheRenModel alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                
                [arr addObject:model];
            }
            NSArray *array=responseObj[@"list3"];
            NSDictionary *dict=array[0];
          self.tuikuanStr=dict[@"refund_instructions"];
            AirApplyRefundVC *VC=[[AirApplyRefundVC alloc]init];
            VC.orderno=self.orderno;
            VC.dataArr=arr;
            VC.tuiKuanStr=self.tuikuanStr;
            VC.sigen=self.sigen;
            VC.jindu = self.jindu;
            VC.weidu = self.weidu;
            VC.MapStartAddress = self.MapStartAddress;
            [self.navigationController pushViewController:VC animated:NO];
            
        }else if ([responseObj[@"status"] isEqualToString:@"10006"])
        {
            [UIAlertTools showAlertWithTitle:@"" message:responseObj[@"message"] cancelTitle:@"知道了" titleArray:nil viewController:self confirm:^(NSInteger buttonTag) {
                
            }];
        }else
        {
            [JRToast showWithText:responseObj[@"message"] duration:2.0];
        }
        
    } faildBlock:^(NSError *error) {
        [JRToast showWithText:error.localizedDescription duration:2.0];
    }];
    
//    AirOrderRefundViewController *vc =[[AirOrderRefundViewController alloc] init];
//    
//    vc.ManArray = _tuiArrM;
//    
//    vc.paymoney = self.Tuipaymoney;
//    
//    vc.payintegral = self.Tuipayintegral;
//    
//    vc.refund_instructions = self.refund_instructions;
//    
//    vc.orderno = self.orderno;//订单号
//    
//    vc.sigen=self.sigen;
//    vc.jindu = self.jindu;
//    vc.weidu = self.weidu;
//    vc.MapStartAddress = self.MapStartAddress;
//    
//    [self.navigationController pushViewController:vc animated:NO];
//    
//    self.navigationController.navigationBar.hidden = YES;
    
    
}

-(void)QurtBtnClick
{
    
    [self.navigationController popViewControllerAnimated:NO];
    
}

@end
