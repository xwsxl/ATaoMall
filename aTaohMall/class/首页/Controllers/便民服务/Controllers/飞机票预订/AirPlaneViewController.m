//
//  AirPlaneViewController.m
//  aTaohMall
//
//  Created by JMSHT on 2017/5/17.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "AirPlaneViewController.h"
#import "JRToast.h"
#import "AirPlaneDateSelectViewController.h"
#import "AirPlaneHBCell.h"

#import "WKProgressHUD.h"

#import "goodListModel.h"

#import "UIImageView+WebCache.h"

#import "NewGoodsDetailViewController.h"//商品详情

#import "NoDataCell.h"

#import "AirPlaneDetailViewController.h"
//刷新
#import "DJRefresh.h"
#import "DJRefreshProgressView.h"
#import "AFNetworking.h"

#import "ConverUtil.h"
#import "DESUtil.h"
#import "SecretCodeTool.h"
#import "AirSelectView.h"
#import "RecordAirManger.h"
#import "BianMinModel.h"
@interface AirPlaneViewController ()<UITableViewDataSource,UITableViewDelegate,DJRefreshDelegate,AirSelectDelegate,AirPlaneDetailBackDetegate>
{
    
    NSTimer *timer;   //验证码时间
    int TT;
    
//    UIScrollView *_scrollerView;
    UITableView *_tableView;
    UIImageView *selectImgView;
    UILabel *selectLabel;
    UIImageView *TimeImgView;
    UILabel *TimeLabel1;
    UIImageView *HighImgView;
    UILabel *HighLabel;
    
    NSMutableArray *_NameArrM;
    NSMutableArray *_DataArrM;
    NSMutableArray *_ModelArrM;
    NSMutableArray *_WeekArrM;
    NSMutableArray *ArrM;
    
    AirSelectView *_customShareView;
    
    UIView *NodataView;
    UIImageView *NoImgView;
    UILabel *NoLabel;
    
    UIView *TopView;
    UIScrollView *_scrollerView;
    
    UIImageView *GoBack;
    
    
    WKProgressHUD *hud;
    
    UIWebView *webView;
    UIView *loadView;
    
    UIView *viewNo;
    BOOL first;

    NSInteger selectindex;
}

@property (nonatomic,strong)DJRefresh *refresh;
@property (nonatomic, strong) UISwipeGestureRecognizer *leftSwipeGestureRecognizer;
@property (nonatomic, strong) UISwipeGestureRecognizer *rightSwipeGestureRecognizer;
@end

@implementation AirPlaneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    first=YES;
    _NameArrM = [NSMutableArray new];
    _DataArrM = [NSMutableArray new];
    _ModelArrM  =[NSMutableArray new];
    _WeekArrM = [NSMutableArray new];
    _DateArrM = [NSMutableArray new];
    ArrM = [NSMutableArray new];
    
    self.airline_airway = @"";
    self.shipping_space = @"";
    self.plane_type = @"";
    self.price_high_low = @"0";//价格
    self.time_long_short = @"";//时间
    
    self.Type = @"";
    
    [self initNav];

    [self initTableView];
    [self initTabView];
    
    
    
//    [self NoDataView];
    
    TT = 600;
    
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(strTimer:) userInfo:nil repeats:YES];
    
    [self getDatas];
    
    
    [self initTopView];
    self.leftSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
    self.rightSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
    
    self.leftSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    self.rightSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;

}

- (void)handleSwipes:(UISwipeGestureRecognizer *)sender
{
    if (sender.direction == UISwipeGestureRecognizerDirectionLeft) {

        if (selectindex+1<_DateArray.count) {
            selectindex++;
        [self TopSelectIndex:selectindex];
        }
    }
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        if (selectindex-1>=0) {
            selectindex--;
            [self TopSelectIndex:selectindex];
        }
    }
}

-(void)getDatas
{
    
    if (first) {
        [_NameArrM removeAllObjects];
        [_ModelArrM removeAllObjects];
        [_WeekArrM removeAllObjects];
        [ArrM removeAllObjects];
        BianMinModel *model = [[BianMinModel alloc] init];
        
        model.Air_name = @"不限";
        model.Air_value = @"10";
        model.Air_selectGongsi = @"0";
        
        [_NameArrM addObject:model];
        
        
        BianMinModel *model4 = [[BianMinModel alloc] init];
        
        model4.Air_name = @"不限";
        model4.Air_value = @"10";
        model4.Air_selectjiXing = @"0";
        
        
        [_ModelArrM addObject:model4];
        
        
        
        BianMinModel *model1 = [[BianMinModel alloc] init];
        BianMinModel *model2 = [[BianMinModel alloc] init];
        BianMinModel *model3 = [[BianMinModel alloc] init];
        
        model1.Air_name = @"不限";
        model2.Air_name = @"经济舱";
        model3.Air_name = @"商务舱/头等舱";
        
        model1.Air_value = @"10";
        model2.Air_value = @"0";
        model3.Air_value = @"1";
        
        model1.Air_selectCangwei = @"0";
        model2.Air_selectCangwei = @"0";
        model3.Air_selectCangwei = @"0";
        
        [ArrM addObject:model1];
        [ArrM addObject:model2];
        [ArrM addObject:model3];
    }

//        hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
//    
//        dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
//        dispatch_after(time, dispatch_get_main_queue(), ^{
//    
//        });
    
    
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
    
    loadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    loadView.backgroundColor = [UIColor blackColor];
    
    loadView.alpha = 0.2;
    
    [self.view addSubview:loadView];
    // self.navigationController.interactivePopGestureRecognizer.enabled=NO;
    [self.view removeGestureRecognizer:self.leftSwipeGestureRecognizer];
    [self.view removeGestureRecognizer:self.rightSwipeGestureRecognizer];

//    NSLog(@"===self.time====%@",self.time);
//    NSLog(@"===self.start_city====%@",self.start_city);
//    NSLog(@"===self.arrive_city====%@",self.arrive_city);
//    NSLog(@"===self.start_code====%@",self.start_code);
//    NSLog(@"===self.arrive_code====%@",self.arrive_code);
//    NSLog(@"===self.airline_airway====%@",self.airline_airway);
//    NSLog(@"===self.shipping_space====%@",self.shipping_space);
//    NSLog(@"===self.plane_type====%@",self.plane_type);
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@getPlaneInformationList_mob.shtml",URL_Str];
    //saveUserExchange_mob.shtml
    
    viewNo.hidden=YES;
    
    NSDictionary *dict = @{@"time":self.time,@"start_city":self.start_city,@"arrive_city":self.arrive_city,@"start_code":self.start_code,@"arrive_code":self.arrive_code,@"airline_airway":self.airline_airway,@"shipping_space":self.shipping_space,@"plane_type":self.plane_type,@"price_high_low":self.price_high_low,@"time_long_short":self.time_long_short,@"passenger_type":self.ManOrKidString};
    
    NSLog(@"dict=%@,startcity=%@,arrivecity=%@",dict,self.start_city,self.arrive_city);
    
    [manager POST:url parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
        NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];
        
        if (codeKey && content) {
            NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
            
            NSLog(@"xmlStr==%@",xmlStr);
            
            NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
//            NSLog(@"分类查看更多书局=%@",dic);
            
            [_DataArrM removeAllObjects];
            
            
            if ([dic[@"status"] isEqualToString:@"10000"]) {
                
                if (first) {
                
                for (NSDictionary *dict in dic[@"list_company"]) {
                    
                    BianMinModel *model = [[BianMinModel alloc] init];
                    
                    model.Air_name = [NSString stringWithFormat:@"%@",dict[@"name"]];
                    model.Air_value = [NSString stringWithFormat:@"%@",dict[@"value"]];
                    model.Air_selectGongsi = @"0";
                    
                    [_NameArrM addObject:model];
                    
                }
                
                
                for (NSDictionary *dict in dic[@"plane_model"]) {
                  //  NSNull *null=[[NSNull alloc]init];
                    BianMinModel *model = [[BianMinModel alloc] init];
                    model.Air_name = [NSString stringWithFormat:@"%@机型",dict[@"model"]];
                    model.Air_selectjiXing = @"0";
                    model.Air_value = [NSString stringWithFormat:@"%@",dict[@"value"]];
                    NSString *str=[NSString stringWithFormat:@"%@",dict[@"model"]];
                    if ([str isEqualToString:@"(null)"]||[str isEqualToString:@""]) {
                        
                    }else
                    {
                    [_ModelArrM addObject:model];
                    }
                }
                }
                first=NO;
                
                
                for (NSDictionary *dict in dic[@"list_flight"]) {
                    
                    BianMinModel *model = [[BianMinModel alloc] init];
//                    {"AirLineCode":"MU","CarrinerName":"东方航空","StartPortName":"北京首都国际机场","StartPort":"PEK","EndPortName":"上海虹桥机场","EndPort":"SHA","FlightNo":"MU5138","JoinPort":"","JoinDate":"0001-01-01","MinCabin":"Z","MinDiscount":"47","MinFare":"580","MinTicketCount":"10","OffTime":"2017-09-21 07:00:00","ArriveTime":"2017-09-21 09:20:00","StartT":"T2","EndT":"T2","ByPass":"0","Meat":"1","StaFare":1240,"Oil":0,"Tax":50,"Distance":0,"PlaneType":"333","PlaneModel":"大","RunTime":"2小时20分钟","ETicket":"1"}
                    model.Air_AirLineCode = [NSString stringWithFormat:@"%@",dict[@"AirLineCode"]];
                    model.Air_CarrinerName = [NSString stringWithFormat:@"%@",dict[@"CarrinerName"]];
                    model.Air_StartPortName = [NSString stringWithFormat:@"%@",dict[@"StartPortName"]];
                    model.Air_StartPort = [NSString stringWithFormat:@"%@",dict[@"StartPort"]];
                    model.Air_EndPortName = [NSString stringWithFormat:@"%@",dict[@"EndPortName"]];
                    model.Air_EndPort = [NSString stringWithFormat:@"%@",dict[@"EndPort"]];
                    model.Air_FlightNo = [NSString stringWithFormat:@"%@",dict[@"FlightNo"]];
                    model.Air_MinCabin = [NSString stringWithFormat:@"%@",dict[@"MinCabin"]];
                    model.Air_MinDiscount = [NSString stringWithFormat:@"%@",dict[@"MinDiscount"]];
                    model.Air_MinFare = [NSString stringWithFormat:@"%@",dict[@"MinFare"]];
                    model.Air_MinTicketCount = [NSString stringWithFormat:@"%@",dict[@"MinTicketCount"]];
                    model.Air_OffTime = [NSString stringWithFormat:@"%@",dict[@"OffTime"]];
                    model.Air_ArriveTime = [NSString stringWithFormat:@"%@",dict[@"ArriveTime"]];
                    model.Air_StartT = [NSString stringWithFormat:@"%@",dict[@"StartT"]];
                    model.Air_EndT = [NSString stringWithFormat:@"%@",dict[@"EndT"]];
                    model.Air_ByPass = [NSString stringWithFormat:@"%@",dict[@"ByPass"]];
                    model.Air_Meat = [NSString stringWithFormat:@"%@",dict[@"Meat"]];
                    model.Air_StaFare = [NSString stringWithFormat:@"%@",dict[@"StaFare"]];
                    model.Air_Oil = [NSString stringWithFormat:@"%@",dict[@"Oil"]];
                    model.Air_Tax = [NSString stringWithFormat:@"%@",dict[@"Tax"]];
                    model.Air_Distance = [NSString stringWithFormat:@"%@",dict[@"Distance"]];
                    model.Air_PlaneType = [NSString stringWithFormat:@"%@",dict[@"PlaneType"]];
                    model.Air_PlaneModel = [NSString stringWithFormat:@"%@",dict[@"PlaneModel"]];
                    model.Air_RunTime = [NSString stringWithFormat:@"%@",dict[@"RunTime"]];
                    model.Air_ETicket = [NSString stringWithFormat:@"%@",dict[@"ETicket"]];
                    
                    [_DataArrM addObject:model];
                    
                }
                
                if (_DataArrM.count == 0) {
                    
                    [self NoDataView];
                    _refresh.topEnabled=NO;//下拉刷新
                    NodataView.hidden=NO;
                    NoImgView.hidden=NO;
                    NoLabel.hidden=NO;
                }else{
                    
                    NoLabel.hidden = YES;
                    NodataView.hidden=YES;
                    NoImgView.hidden=YES;
                    _tableView.scrollEnabled=YES;
                }
                
                
                
                
            }
            
            
            
            else{
                
                if ([dic[@"status"] isEqualToString:@"10001"]){
                    
                    [TrainToast showWithText:dic[@"message"] duration:1.0f];
        
                }
                
                
                [self NoDataView];
                _refresh.topEnabled=NO;//下拉刷新
                NodataView.hidden=NO;
                NoImgView.hidden=NO;
                NoLabel.hidden=NO;
                
            }
            
            [webView removeFromSuperview];
            
            [loadView removeFromSuperview];
            
            [hud dismiss:YES];
            [self.view addGestureRecognizer:self.leftSwipeGestureRecognizer];
            [self.view addGestureRecognizer:self.rightSwipeGestureRecognizer];
            [_tableView reloadData];
            
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        NSLog(@"%@",error);
        [hud dismiss:YES];
        [self.view addGestureRecognizer:self.leftSwipeGestureRecognizer];
        [self.view addGestureRecognizer:self.rightSwipeGestureRecognizer];
        [webView removeFromSuperview];
        
        [loadView removeFromSuperview];
        
        [self NoWebSeveice];
        
    }];
    
}

-(void)NoWebSeveice
{
    
    viewNo=[[UIView alloc] initWithFrame:CGRectMake(0, 65, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-65)];
    
    viewNo.backgroundColor=[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];
    
    [self.view addSubview:viewNo];
    
    
    UIImageView *image=[[UIImageView alloc] initWithFrame:CGRectMake((viewNo.frame.size.width-82)/2, 100, 82, 68)];
    
    image.image=[UIImage imageNamed:@"网络连接失败"];
    
    [viewNo addSubview:image];
    
    
    UILabel *label1=[[UILabel alloc] initWithFrame:CGRectMake(100, 180, viewNo.frame.size.width-200, 20)];
    
    label1.text=@"网络连接失败";
    
    label1.textAlignment=NSTextAlignmentCenter;
    
    label1.font=[UIFont fontWithName:@"PingFangSC-Medium" size:15];
    
    label1.textColor=[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    
    [viewNo addSubview:label1];
    
    
    UILabel *label2=[[UILabel alloc] initWithFrame:CGRectMake(100, 210, viewNo.frame.size.width-200, 20)];
    
    label2.text=@"请检查你的网络";
    
    label2.textAlignment=NSTextAlignmentCenter;
    
    label2.font=[UIFont fontWithName:@"PingFangSC-Medium" size:12];
    
    label2.textColor=[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    
    [viewNo addSubview:label2];
    
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    
    button.frame=CGRectMake(100, 250, viewNo.frame.size.width-200, 50);
    
    [button setTitle:@"重新加载" forState:0];
    button.titleLabel.font=[UIFont fontWithName:@"PingFangSC-Medium" size:12];
    [button setTitleColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0] forState:0];
    
    [viewNo addSubview:button];
    
    [button addTarget:self action:@selector(loadData) forControlEvents:UIControlEventTouchUpInside];
    
    
    
}

-(void)loadData
{
    
    viewNo.hidden=YES;
    
    [self getDatas];
    
    
}

-(void)ChangeString:(NSString *)airline_airway Space:(NSString *)shipping_space Type:(NSString *)plane_type
{
    
    if ([airline_airway isEqualToString:@""] && [shipping_space isEqualToString:@""] && [plane_type isEqualToString:@""]) {
        
        selectImgView.image  =[UIImage imageNamed:@"icon_sift"];
        selectLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
        
    }else{
        
        selectImgView.image  =[UIImage imageNamed:@"icon_sift-selected"];
        selectLabel.textColor = [UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
        
    }
    
}

-(void)AirSelect:(NSString *)airline_airway Space:(NSString *)shipping_space Type:(NSString *)plane_type
{
    
    NSLog(@"AirSelect");
    
    NSLog(@"=====airline_airway====%@",airline_airway);
    NSLog(@"=====shipping_space====%@",shipping_space);
    NSLog(@"=====plane_type====%@",plane_type);
    
    if ([airline_airway isEqualToString:@""] && [shipping_space isEqualToString:@""] && [plane_type isEqualToString:@""]) {
        
        selectImgView.image  =[UIImage imageNamed:@"icon_sift"];
        selectLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
        
    }else{
        
        selectImgView.image  =[UIImage imageNamed:@"icon_sift-selected"];
        selectLabel.textColor = [UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
        
    }
    self.airline_airway = airline_airway;
    self.shipping_space = shipping_space;
    self.plane_type = plane_type;
    
    [self getDatas];
    
    
}

-(void)ChangeString
{
    selectImgView.image  =[UIImage imageNamed:@"icon_sift"];
    selectLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
    
}
-(void)GetDateDatas
{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@getDateAndWeek_mob.shtml",URL_Str];
    //saveUserExchange_mob.shtml
    
    NSLog(@"===self.time==%@",self.time);
    NSLog(@"===self.Type==%@",self.Type);
    
    NSDictionary *dict = @{@"time":self.time,@"type":self.Type};
    
    [manager POST:url parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
        NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];
        
        
        if (codeKey && content) {
            NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
            
            NSLog(@"==日期==xmlStr==%@",xmlStr);
            
            
            NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            //            NSLog(@"分类查看更多书局=%@",dic);
            
            [_DateArrM removeAllObjects];
            
            if ([dic[@"status"] isEqualToString:@"10000"]) {
                
                
                for (NSDictionary *dict in dic[@"list_time"]) {
                    
                    BianMinModel *model = [[BianMinModel alloc] init];
                    
                    model.date = [NSString stringWithFormat:@"%@",dict[@"date"]];
                    model.week = [NSString stringWithFormat:@"%@",dict[@"week"]];
                    
                    
                    [_DateArrM addObject:model];
                    
                    if ([model.date isEqualToString:self.time]) {
                        
                        //                        NSLog(@"===xiabiao===%ld",_WeekArrM.count);
                        
                        self.Index = (int)_DateArrM.count;
                        
                    }
                    
                    
                }
                
                
                _DateArray = _DateArrM;
                
                
                [self initTopView];
                
                
            }else{
                
                
                [JRToast showWithText:dic[@"message"] duration:1.0f];
                
                [hud dismiss:YES];
                
            }
            
            
            
            [hud dismiss:YES];
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        NSLog(@"%@",error);
        
        [hud dismiss:YES];
        
        
    }];
    
}

- (void)strTimer:(NSTimer *)time{
    
//    NSLog(@"===%@",[NSString stringWithFormat:@"%dS",TT]);
    
    TT --;
    
    
    if (TT == -1) {
//        [timer invalidate];
//        timer = nil;
        
        [self getDatas];
        TT = 600;
        
        
    }
    
    
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
    
    label.text = [NSString stringWithFormat:@"%@-%@",self.StartCity,self.ArriveCity];
    
    label.textColor = [UIColor blackColor];
    
    label.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:19];
    
    label.textAlignment = NSTextAlignmentCenter;
    
    [titleView addSubview:label];
    
    CGRect tempRect = [label.text boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-150,13) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFang-SC-Medium" size:19]} context:nil];
    
    GoBack = [[UIImageView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-tempRect.size.width)/2-10-21, 30+KSafeTopHeight, 21, 21)];
    
//    GoBack = [[UIImageView alloc] initWithFrame:CGRectMake(128, 30, 21, 21)];
    
    if ([self.TypeString isEqualToString:@"200"]) {
        
        GoBack.image = [UIImage imageNamed:@"icon-qu"];

    }else if([self.TypeString isEqualToString:@"666"]){
        
        GoBack.image = [UIImage imageNamed:@"icon-fan-hui"];
        
    }else{
        
        GoBack.image = [UIImage imageNamed:@""];
    }
    
    
    [titleView addSubview:GoBack];
    
    
}


//往返代理
-(void)AirPlaneDetailBack
{
    GoBack.image = [UIImage imageNamed:@"icon-fan-hui"];
    
    self.TypeString = @"666";
    
    self.Type = @"1";
    
    self.time = self.BackDate;
    
    
    NSString *string1 = self.start_city;
    NSString *string2 = self.arrive_city;
    NSString *string3 = self.start_code;
    NSString *string4 = self.arrive_code;
    
    self.start_city = string2;
    self.arrive_city = string1;
    
    self.start_code = @"";
    self.arrive_code = @"";
    
    [self GetDateDatas];
    
    [self getDatas];
    
    
    
}
-(void)initTopView
{
    
    NSLog(@"===_WeekArrM.count===%d===%ld",self.Index,_DateArray.count);
    

    
    for (int i = 0; i < _DateArray.count; i++) {
        
        UILabel *price = (UILabel *)[self.view viewWithTag:300+i];
        [price removeFromSuperview];
        
        UIView *write = (UIView *)[self.view viewWithTag:200+i];
        [write removeFromSuperview];
        
        UILabel *Date = (UILabel *)[self.view viewWithTag:500+i];
        [Date removeFromSuperview];
        
        UIButton *button = (UIButton *)[self.view viewWithTag:10+i];
        [button removeFromSuperview];
        
    }
    
    TopView = [[UIView alloc] initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight, [UIScreen mainScreen].bounds.size.width, 45)];
    TopView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:TopView];
    
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)[UIColor colorWithRed:255/255.0 green:52/255.0 blue:90/255.0 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0].CGColor];
    gradientLayer.locations = @[@0.0, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1.0);
    gradientLayer.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 45);
    [TopView.layer addSublayer:gradientLayer];
    
    
    
    _scrollerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width-60, 45)];
    _scrollerView.contentSize = CGSizeMake(80*_DateArray.count, 45);
    _scrollerView.showsHorizontalScrollIndicator = NO;
    
    //控制滑动区域
    if (self.Index-1 > 2) {
        
        CGPoint position = CGPointMake(80*(self.Index-2), 0);
        
        [_scrollerView setContentOffset:position animated:NO];
        
    }
    
    
    
    [TopView addSubview:_scrollerView];
    
//    NSArray *PriceArrM = @[@"￥100",@"￥200",@"￥300",@"￥400",@"￥500",@"￥600",@"￥700",@"￥800",@"￥900",@"￥1000",@"￥1100",@"￥1200",@"￥1300",@"￥1400"];
//    NSArray *DateArrM = @[@"05-10",@"05-11",@"05-12",@"05-13",@"05-14",@"05-15",@"05-16",@"05-17",@"05-18",@"05-19",@"05-20",@"05-21",@"05-22",@"05-23"];
//    NSArray *WeekArrM = @[@"周二",@"周三",@"周四",@"周五",@"周六",@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",@"周日",@"周一"];
    
    NSLog(@"=====%@",self.time);
    NSArray *timeArray = [self.time componentsSeparatedByString:@"-"];
    NSString *timeString = [NSString stringWithFormat:@"%@-%@",timeArray[1],timeArray[2]];
    
    for (int i = 0; i < _DateArray.count; i++) {
        
        BianMinModel *model = _DateArray[i];
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(80*i, 0, 80, 45)];
//        view.tag = 999;
        [_scrollerView addSubview:view];
        
        
        UIView *write = [[UIView alloc] initWithFrame:CGRectMake((80-76)/2, (45-34)/2, 76, 34)];
        write.layer.cornerRadius = 3;
        write.layer.masksToBounds = YES;
        write.tag = 200+i;
        [view addSubview:write];
        
        NSArray *array =[model.date componentsSeparatedByString:@"-"];
        
        NSString *string = [NSString stringWithFormat:@"%@-%@",array[1],array[2]];
        
        UILabel *price = [[UILabel alloc] initWithFrame:CGRectMake(0, 4, 80, 11)];
        price.text = [NSString stringWithFormat:@"%@-%@",array[1],array[2]];
        price.textColor = [UIColor whiteColor];
        price.textAlignment = NSTextAlignmentCenter;
        price.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
        price.tag = 300+i;
        [write addSubview:price];
        
        
        
        UILabel *Date = [[UILabel alloc] initWithFrame:CGRectMake(0, 21, 76, 10)];
        Date.text = [NSString stringWithFormat:@"%@",model.week];
        Date.textColor = [UIColor whiteColor];
        Date.textAlignment = NSTextAlignmentCenter;
        Date.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:10];
        Date.tag = 500+i;
        [write addSubview:Date];
        
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, 80, 45);
        button.tag = 10+i;
        [button addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button];
        
        if ([string isEqualToString:timeString]) {
            
            self.DateWeek = model.week;
            selectindex=i;
            write.backgroundColor = [UIColor whiteColor];
            price.textColor = [UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
            Date.textColor = [UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
        }
        
    }
    
    
    UIView *RiLiView = [[UIView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-60, 0, 60, 45)];
    [TopView addSubview:RiLiView];
    
    UIImageView *Ying = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-61, 0, 1, 45)];
    Ying.image = [UIImage imageNamed:@"shadow111"];
    [TopView addSubview:Ying];
    
    
    UIImageView *rili = [[UIImageView alloc] initWithFrame:CGRectMake((60-17)/2, 6, 17, 18)];
    rili.image = [UIImage imageNamed:@"icon-calendar"];
    [RiLiView addSubview:rili];
    
    UILabel *riliLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 29, 60, 10)];
    riliLabel.text = @"日历";
    riliLabel.textColor = [UIColor whiteColor];
    riliLabel.textAlignment = NSTextAlignmentCenter;
    riliLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:10];
    [RiLiView addSubview:riliLabel];
    
    UIButton *RiLi = [UIButton buttonWithType:UIButtonTypeCustom];
    RiLi.frame = CGRectMake(0, 0, 60, 45);
    [RiLi addTarget:self action:@selector(RiLiBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [RiLiView addSubview:RiLi];
    
    
    
}

-(void)RiLiBtnClick
{
    AirPlaneDateSelectViewController *vc = [[AirPlaneDateSelectViewController alloc] init];
    
    [vc setAirPlaneToDay:365 ToDateforString:self.time back:@""];//飞机初始化方法
    
    
    vc.calendarblock = ^(CalendarDayModel *model){
        
        NSLog(@"\n---------------------------");
        NSLog(@"1星期 %@",[model getWeek]);
        NSLog(@"2字符串 %@",[model toString]);
        NSLog(@"3节日  %@",model.holiday);
        
        self.time = [NSString stringWithFormat:@"%@",[model toString]];
        
        _DateArray = nil;
        
        [self GetDateDatas];
        [self getDatas];
        
        
    };
    
    
    [self.navigationController pushViewController:vc animated:NO];
    self.navigationController.navigationBar.hidden=YES;
    
}
-(void)BtnClick:(UIButton *)sender
{

    NSLog(@"0000000000000====%ld",_DateArray.count);
    selectindex=sender.tag-10;
    [self TopSelectIndex:sender.tag-10];
}

-(void)TopSelectIndex:(NSInteger )index
{

    CGFloat viewWidth=_scrollerView.frame.size.width;
    CGFloat butwidth=80;

    CGFloat scrollwidth=butwidth*index-(kScreen_Width-80)/2.0;

    if (scrollwidth<0) {
        scrollwidth=0;
    }else if (scrollwidth>(butwidth*_DateArray.count-viewWidth))
    {
        scrollwidth=butwidth*_DateArray.count-viewWidth;


    }
    YLog(@"%.2f",scrollwidth);
    
    [UIView animateWithDuration:0.2 animations:^{
        _scrollerView.contentOffset=CGPointMake(scrollwidth, 0);
    }];
    for (int i = 0; i < _DateArray.count; i++) {

        BianMinModel *model = _DateArray[i];

        UIView *view = (UIView *)[self.view viewWithTag:200+i];
        UILabel *price = (UILabel *)[self.view viewWithTag:300+i];
        UILabel *date = (UILabel *)[self.view viewWithTag:500+i];

        view.backgroundColor = [UIColor clearColor];
        price.textColor = [UIColor whiteColor];
        date.textColor = [UIColor whiteColor];

        if (index==i) {

            NSLog(@"=====选择日期==%@",model.date);
            view.backgroundColor = [UIColor whiteColor];
            price.textColor = [UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
            date.textColor = [UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];

            self.time = model.date;

            [self getDatas];

        }
    }
}

-(void)NoDataView
{
    if (!NodataView) {
        NodataView = [[UIView alloc] initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight+45, [UIScreen mainScreen].bounds.size.width, 300)];
        [self.view addSubview:NodataView];
    }
    
    
    NoImgView = [[UIImageView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-158)/2, 75, 158, 86)];
    NoImgView.image = [UIImage imageNamed:@"icon_airplay"];
    [NodataView addSubview:NoImgView];
    
    
    NoLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 172, [UIScreen mainScreen].bounds.size.width-60, 15)];
    NoLabel.text = @"抱歉，没有查询到对应航班信息";
    NoLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    NoLabel.textAlignment = NSTextAlignmentCenter;
    NoLabel.font  =[UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    [NodataView addSubview:NoLabel];
    
    
}

-(void)initTableView
{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight+45, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-KSafeAreaTopNaviHeight-50-45-KSafeAreaBottomHeight) style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    [_tableView registerClass:[AirPlaneHBCell class] forCellReuseIdentifier:@"cell"];
    
    
    _refresh=[[DJRefresh alloc] initWithScrollView:_tableView delegate:self];
    _refresh.topEnabled=YES;//下拉刷新
    _refresh.bottomEnabled=NO;//上拉加载
    
}

-(void)initTabView
{
    
    UIView *tabView = [[UIView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-50-KSafeAreaBottomHeight, [UIScreen mainScreen].bounds.size.width, 50)];
    tabView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:tabView];
    
    UIView *selectView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width/3, 50)];
    selectView.backgroundColor = [UIColor whiteColor];
    [tabView addSubview:selectView];
    
    selectImgView = [[UIImageView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width/3-22)/2, 8, 22, 22)];
    selectImgView.image  =[UIImage imageNamed:@"icon_sift"];
    [selectView addSubview:selectImgView];
    
    selectLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 32, [UIScreen mainScreen].bounds.size.width/3, 10)];
    selectLabel.text = @"筛选";
    selectLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
    selectLabel.textAlignment = NSTextAlignmentCenter;
    selectLabel.font  =[UIFont fontWithName:@"PingFang-SC-Regular" size:10];
    [selectView addSubview:selectLabel];
    
    UIButton *selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
    selectButton.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width/3, 50);
    [selectButton addTarget:self action:@selector(SelectBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [selectView addSubview:selectButton];
    
    UIView *TimeView = [[UIView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/3, 0, [UIScreen mainScreen].bounds.size.width/3, 50)];
    TimeView.backgroundColor = [UIColor whiteColor];
    [tabView addSubview:TimeView];
    
    TimeImgView = [[UIImageView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width/3-22)/2, 8, 22, 22)];
    TimeImgView.image  =[UIImage imageNamed:@"icon_time"];
    [TimeView addSubview:TimeImgView];
    
    TimeLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 32, [UIScreen mainScreen].bounds.size.width/3, 10)];
    TimeLabel1.text = @"时间";
    TimeLabel1.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
    TimeLabel1.textAlignment = NSTextAlignmentCenter;
    TimeLabel1.font  =[UIFont fontWithName:@"PingFang-SC-Regular" size:10];
    [TimeView addSubview:TimeLabel1];
    
    UIButton *timeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    timeButton.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width/3, 50);
    timeButton.selected=YES;
    [timeButton addTarget:self action:@selector(TimeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [TimeView addSubview:timeButton];
    
    UIView *HighView = [[UIView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/3*2, 0, [UIScreen mainScreen].bounds.size.width/3, 50)];
    HighView.backgroundColor = [UIColor whiteColor];
    [tabView addSubview:HighView];
    
    HighImgView = [[UIImageView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width/3-22)/2, 8, 22, 22)];
    HighImgView.image  =[UIImage imageNamed:@"icon_price"];
    [HighView addSubview:HighImgView];
    
    HighLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 32, [UIScreen mainScreen].bounds.size.width/3, 10)];
    HighLabel.text = @"由低到高";
    HighLabel.textColor = [UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
    HighLabel.textAlignment = NSTextAlignmentCenter;
    HighLabel.font  =[UIFont fontWithName:@"PingFang-SC-Regular" size:10];
    [HighView addSubview:HighLabel];
    
    UIButton *HighButton = [UIButton buttonWithType:UIButtonTypeCustom];
    HighButton.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width/3, 50);
    HighButton.selected=NO;
    [HighButton addTarget:self action:@selector(HighBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [HighView addSubview:HighButton];
    
    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 1)];
    line.image = [UIImage imageNamed:@"分割线-拷贝"];
    [tabView addSubview:line];
    
}

-(void)SelectBtnClick
{
    
   
    selectImgView.image  =[UIImage imageNamed:@"icon_sift-selected"];
    selectLabel.textColor = [UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
    
//    TimeImgView.image  =[UIImage imageNamed:@"icon_time"];
//    TimeLabel1.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
//    HighLabel.text = @"由低到高";
//    TimeLabel1.text = @"时间";
//    HighImgView.image  =[UIImage imageNamed:@"icon_price_default"];
//    HighLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
    
    
    _customShareView = [[AirSelectView alloc]init];
    
    _customShareView.AirArray = _NameArrM;
    
    _customShareView.ModelArray = _ModelArrM;
    
    _customShareView.TypeArray = ArrM;
    
    [_customShareView AirArray:_NameArrM ModelArray:_ModelArrM TypeArray:ArrM];
    
    _customShareView.delegate=self;
    
    [self.view addSubview:_customShareView];
    
    [_customShareView showInView:self.view];
    
}
-(void)TimeBtnClick:(UIButton *)sender
{
    
    if (sender.selected) {
        
//        selectImgView.image  =[UIImage imageNamed:@"icon_sift"];
//        selectLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
        
        TimeImgView.image  =[UIImage imageNamed:@"icon_time-selected"];
        TimeLabel1.textColor = [UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
        HighLabel.text = @"价格";
        TimeLabel1.text = @"由早到晚";
        HighImgView.image  =[UIImage imageNamed:@"icon_price_default"];
        HighLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
        
        self.time_long_short = @"0";
        self.price_high_low = @"";
        [self getDatas];
        
        
        
        sender.selected = !sender.selected;
        
    }else{
        
//        selectImgView.image  =[UIImage imageNamed:@"icon_sift"];
//        selectLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
        
        TimeImgView.image  =[UIImage imageNamed:@"icon_time-selected"];
        TimeLabel1.textColor = [UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
        HighLabel.text = @"价格";
        TimeLabel1.text = @"由晚到早";
        HighImgView.image  =[UIImage imageNamed:@"icon_price_default"];
        HighLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
        
        self.time_long_short = @"1";
        self.price_high_low = @"";
        [self getDatas];
        
        sender.selected=YES;
        
    }
    
    
}
-(void)HighBtnClick:(UIButton *)sender
{
    
    if (sender.selected) {
        
        
//        selectImgView.image  =[UIImage imageNamed:@"icon_sift"];
//        selectLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
        
        TimeImgView.image  =[UIImage imageNamed:@"icon_time"];
        TimeLabel1.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
        
        HighLabel.text = @"由高到低";
        TimeLabel1.text = @"时间";
        HighImgView.image  =[UIImage imageNamed:@"icon_price"];
        HighLabel.textColor = [UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
        
        self.price_high_low = @"1";
        self.time_long_short = @"";
        [self getDatas];
        
        sender.selected = !sender.selected;
        
    }else{
        
        
//        selectImgView.image  =[UIImage imageNamed:@"icon_sift"];
//        selectLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
        
        TimeImgView.image  =[UIImage imageNamed:@"icon_time"];
        TimeLabel1.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
        
        HighLabel.text = @"由低到高";
        TimeLabel1.text = @"时间";
        HighImgView.image  =[UIImage imageNamed:@"icon_price"];
        HighLabel.textColor = [UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
        
        self.price_high_low = @"0";
        self.time_long_short = @"";
        [self getDatas];
        
        sender.selected=YES;
        
    }
    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _DataArrM.count;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 78;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    AirPlaneHBCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    BianMinModel *model = _DataArrM[indexPath.row];
    
    cell.PriceLabel.text = [NSString stringWithFormat:@"￥%@",model.Air_MinFare];
    
    NSString *stringForColor = @"￥";
    // 创建对象.
    NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:cell.PriceLabel.text];
    NSRange range = [cell.PriceLabel.text rangeOfString:stringForColor];
    [mAttStri addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Medium" size:20] range:range];
    cell.PriceLabel.attributedText=mAttStri;
    
    NSArray *date = [model.Air_OffTime componentsSeparatedByString:@" "];
    NSArray *array = [date[1] componentsSeparatedByString:@":"];
    cell.StartTimeLabel.text = [NSString stringWithFormat:@"%@:%@",array[0],array[1]];
    
    NSArray *date1 = [model.Air_ArriveTime componentsSeparatedByString:@" "];
    NSArray *array1 = [date1[1] componentsSeparatedByString:@":"];
    cell.EndTimeLabel.text = [NSString stringWithFormat:@"%@:%@",array1[0],array1[1]];
    
    cell.LongLabel.text = [NSString stringWithFormat:@"%@",model.Air_RunTime];
    
    cell.StartCityLabel.text = [NSString stringWithFormat:@"%@%@",model.Air_StartPortName,model.Air_StartT];
    
    cell.EndCityLabel.text = [NSString stringWithFormat:@"%@%@",model.Air_EndPortName,model.Air_EndT];
    
   
    
    if ([model.Air_PlaneModel isEqualToString:@""]) {
        
        cell.TypeLabel.text = [NSString stringWithFormat:@"%@ | %@",model.Air_CarrinerName,model.Air_FlightNo];
    }else{
        
        cell.TypeLabel.text = [NSString stringWithFormat:@"%@ | %@(%@)",model.Air_CarrinerName,model.Air_FlightNo,model.Air_PlaneModel];
    }
    if ([model.Air_ByPass isEqualToString:@"1"]) {
        cell.TypeLabel.text=[cell.TypeLabel.text stringByAppendingString:@" | 经停"];
    }
    if ([model.Air_MinTicketCount isEqualToString:@""]) {
        
        cell.TicketLabel.text = [NSString stringWithFormat:@"%@",model.Air_MinTicketCount];
        cell.RedImgView.hidden=YES;
        
    }else{
        
        if ([model.Air_MinTicketCount intValue] <=8) {
            
            cell.TicketLabel.text = [NSString stringWithFormat:@"%@张",model.Air_MinTicketCount];
            cell.RedImgView.hidden=NO;
            
        }else{
            
            cell.RedImgView.hidden=YES;
            cell.TicketLabel.text = @"";
            
        }
    }
    
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    BianMinModel *model = _DataArrM[indexPath.row];
    [kUserDefaults setObject:self.time forKey:@"AirDate"];
    if ([XLDateTools compareDate:self.time AndDate:self.BackDate]==XLComparedResult_Descending) {
        self.BackDate=self.time;
    }
    
    AirPlaneDetailViewController *vc = [[AirPlaneDetailViewController alloc] init];
    
    vc.delegate=self;
    vc.time = self.time;
    vc.flightNo = model.Air_FlightNo;
    vc.GoBackString = [NSString stringWithFormat:@"%@-%@",self.StartCity,self.ArriveCity];
    vc.ManOrKidString = self.ManOrKidString;
    vc.CarrinerName = model.Air_CarrinerName;
    vc.Air_OffTime = model.Air_OffTime;
    vc.ArriveTime = model.Air_ArriveTime;
    vc.Air_RunTime = model.Air_RunTime;
    vc.Air_StartT = model.Air_StartT;
    vc.Air_EndT = model.Air_EndT;
    vc.Air_Meat = model.Air_Meat;
    vc.Air_PlaneType = model.Air_PlaneType;
    vc.Air_PlaneModel = model.Air_PlaneModel;
    vc.Air_StartPortName = model.Air_StartPortName;
    vc.Air_EndPortName = model.Air_EndPortName;
    vc.Air_ByPass=model.Air_ByPass;
    
    
    vc.DateWeek = self.DateWeek;
    vc.TypeString = self.TypeString;
    vc.ManOrKidString = self.ManOrKidString;
    vc.BackDate = self.BackDate;
    vc.start_code = model.Air_StartPort;
    vc.arrive_code = model.Air_EndPort;
    vc.start_city = self.arrive_city;
    vc.arrive_city = self.start_city;
    
    [self.navigationController pushViewController:vc animated:NO];
    
    self.navigationController.navigationBar.hidden=YES;
    
}
- (void)refresh:(DJRefresh *)refresh didEngageRefreshDirection:(DJRefreshDirection)direction{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self addDataWithDirection:direction];
    });
    
}

- (void)addDataWithDirection:(DJRefreshDirection)direction{
    
    if (direction==DJRefreshDirectionTop) {
        
        
//        WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
//        
//        dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
//        dispatch_after(time, dispatch_get_main_queue(), ^{
//            [hud dismiss:YES];
//        });
        
        [self getDatas];
        
    }
    [_refresh finishRefreshingDirection:direction animation:YES];
    [_tableView reloadData];
    
}

-(void)QurtBtnClick{
    
    [RecordAirManger removeAirline_airway];
    
    [timer invalidate];
    timer = nil;
    
    [self.navigationController popViewControllerAnimated:NO];

}


@end
