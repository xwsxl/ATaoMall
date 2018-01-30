//
//  TrainNumberViewController.m
//  aTaohMall
//
//  Created by JMSHT on 2017/5/12.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "TrainNumberViewController.h"

#import "TrainSelectDateViewController.h"

#import "CheCiDetailViewController.h"
#import "CheXingCell.h"

#import "CustomPaiXuView.h"
#import "CheXingView.h"
#import "GaoJiView.h"
#define UIBounds [[UIScreen mainScreen] bounds] //window外框大小

#import "WKProgressHUD.h"
#import "TrainToast.h"
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
#import "JRToast.h"

#define TrainWidh [UIScreen mainScreen].bounds.size.width*0.427

@interface TrainNumberViewController ()<UITableViewDelegate,UITableViewDataSource,PaiXuDelegate,CheXingDelegate,GaoJiDelegate,DJRefreshDelegate>
{
    
    UILabel *RedLabel;
    UIImageView *TrainTicketImgView;
    UILabel *TrainTicketLabel;
    
    UIImageView *ArpTicketImgView;
    UILabel *ArpTicketLabel;
    
    UIImageView *MeImgView;
    UILabel *MeLabel;
    
    UIView *TrainTicketView;
    UIView *ArpTicketView;
    UIView *MeView;
    
    UILabel *StartLabel;
    UILabel *EndLabel;
    
    UILabel *DateLabel;
    
    UITableView *_tableView;
    
    UIView *_popview;
    
    CustomPaiXuView *_customShareView;
    CheXingView *_CheXingView;
    
    UIView *NodataView;
    UIImageView *NoImgView;
    UILabel *NoLabel;
    UIView *tabView;
    
    NSMutableArray *_data;
    NSMutableArray *start_cityArrM;;
    NSMutableArray *arrive_cityArrM;
    UIImageView *line1;
    
    UILabel *RightLabel;
    UILabel *leftLabel;
    UIImageView *Rightimg;
    UIImageView *leftimg;
    
    UIButton *Qurt;
    
    
}
@property (nonatomic,strong)NSString *fromStationStr;
@property (nonatomic,strong)NSString *toStationStr;
@property (nonatomic,strong)NSString *sitTypeStr;
@property (nonatomic,strong)GaoJiView *Gaojiview;
@property (nonatomic,strong)DJRefresh *refresh;

@end

@implementation TrainNumberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    //查询记录刷新数据
    
    if (_delegate && [_delegate respondsToSelector:@selector(TrainRecordReloadData)]) {
        
        [_delegate TrainRecordReloadData];
        
    }
    
    _data = [NSMutableArray new];
    
    start_cityArrM = [NSMutableArray new];
    arrive_cityArrM = [NSMutableArray new];
    
//    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
//    
//    self.automaticallyAdjustsScrollViewInsets=NO;
    
    NSLog(@"=self.train_date==%@",self.train_date);
    NSLog(@"=self.from_station==%@",self.from_station);
    NSLog(@"=self.from_city==%@",self.from_city);
    NSLog(@"=self.to_station==%@",self.to_station);
    NSLog(@"=self.to_city==%@",self.to_city);
    
    self.time_type = @"1";
    self.che_type = @"";
    
    
    [self initNav];
    
    [self redView];
    
    [self tabView];
    
    [self initTableView];
    
    [self initNoDataView];
    
    [self getdatas];
    
    
    _customShareView = [[CustomPaiXuView alloc]init];
    [self.view addSubview:_customShareView];
    
    _CheXingView = [[CheXingView alloc]init];
    [self.view addSubview:_CheXingView];
    
    
    
}


-(void)getdatas
{
    NoLabel.hidden = YES;
    NodataView.hidden=YES;
    NoImgView.hidden=YES;
    
   // WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
    WKProgressHUD *hud = [WKProgressHUD showInView:self.view animated:YES];
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        
    });
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@getTrainList_mob.shtml",URL_Str];
    //saveUserExchange_mob.shtml
    
    NSDictionary *dic = @{@"train_date":self.train_date,@"from_station":self.from_station,@"from_city":self.from_city,@"to_station":self.to_station,@"to_city":self.to_city,@"time_type":self.time_type,@"che_type":self.che_type,@"from_station_names":self.fromStationStr,@"to_station_names":self.toStationStr,@"seats":self.sitTypeStr};
    NSLog(@"dic=%@,self.from_station=%@,to=%@",dic,self.from_city,self.to_city);
    
    [manager POST:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
        NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];
        
        
        if (codeKey && content) {
            NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
            
            NSLog(@"===火车票列表xmlStr===%@",xmlStr);
            
            
            NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            
            
            [_data removeAllObjects];
            
            [arrive_cityArrM removeAllObjects];
            
            [start_cityArrM removeAllObjects];
            
            
            NSNull *null = [[NSNull alloc] init];
            
            if ([dic[@"status"] isEqualToString:@"10000"]) {
                
                
                for (NSDictionary *dict in dic[@"result"]) {
                    
                    BianMinModel *model = [[BianMinModel alloc] init];
                    
                    model.arrive_time = [NSString stringWithFormat:@"%@",dict[@"arrive_time"]];
                    model.from_station_code = [NSString stringWithFormat:@"%@",dict[@"from_station_code"]];
                    model.from_station_name = [NSString stringWithFormat:@"%@",dict[@"from_station_name"]];
                    model.last_price = [NSString stringWithFormat:@"%@",dict[@"last_price"]];
                    model.run_time = [NSString stringWithFormat:@"%@",dict[@"run_time"]];
                    model.run_time_minute = [NSString stringWithFormat:@"%@",dict[@"run_time_minute"]];
                    
                    
                    if (![[dict allKeys] containsObject:@"rw_num"]) {
                        
                        model.rw_num = @"";
                    }else{
                        
                        model.rw_num = [NSString stringWithFormat:@"%@",dict[@"rw_num"]];
                    }
                    
                    model.rw_price = [NSString stringWithFormat:@"%@",dict[@"rw_price"]];
                    
                    if (![[dict allKeys] containsObject:@"rwx_num"]) {
                        
                        model.rwx_num = @"";
                    }else{
                        
                        model.rwx_num = [NSString stringWithFormat:@"%@",dict[@"rwx_num"]];
                    }
                    
                    
                    model.rwx_price = [NSString stringWithFormat:@"%@",dict[@"rwx_price"]];
                    model.start_time = [NSString stringWithFormat:@"%@",dict[@"start_time"]];
                    model.to_station_code = [NSString stringWithFormat:@"%@",dict[@"to_station_code"]];
                    model.to_station_name = [NSString stringWithFormat:@"%@",dict[@"to_station_name"]];
                    model.traincode = [NSString stringWithFormat:@"%@",dict[@"train_code"]];
                    model.train_type = [NSString stringWithFormat:@"%@",dict[@"train_type"]];
                    
                    if (![[dict allKeys] containsObject:@"wz_num"]) {
                        
                        model.wz_num = @"";
                    }else{
                        
                        model.wz_num = [NSString stringWithFormat:@"%@",dict[@"wz_num"]];
                    }
                    
                    
                    
                    model.wz_price = [NSString stringWithFormat:@"%@",dict[@"wz_price"]];
                    
                    if (![[dict allKeys] containsObject:@"yw_num"]) {
                        
                        model.yw_num = @"";
                    }else{
                        
                        model.yw_num = [NSString stringWithFormat:@"%@",dict[@"yw_num"]];
                    }
                    
                    
                    model.yw_price = [NSString stringWithFormat:@"%@",dict[@"yw_price"]];
                    
                    if (![[dict allKeys] containsObject:@"ywx_num"]) {
                        
                        model.ywx_num = @"";
                    }else{
                        
                        model.ywx_num = [NSString stringWithFormat:@"%@",dict[@"ywx_num"]];
                    }
                    
                    
                    model.ywx_price = [NSString stringWithFormat:@"%@",dict[@"ywx_price"]];
                    
                    if (![[dict allKeys] containsObject:@"yz_num"]) {
                        
                        model.yz_num = @"";
                    }else{
                        
                        model.yz_num = [NSString stringWithFormat:@"%@",dict[@"yz_num"]];
                    }
                    
                    
                    model.yz_price = [NSString stringWithFormat:@"%@",dict[@"yz_price"]];
                    model.rz_price = [NSString stringWithFormat:@"%@",dict[@"rz_price"]];
                    model.ydz_price = [NSString stringWithFormat:@"%@",dict[@"ydz_price"]];//一等座
                    model.edz_price = [NSString stringWithFormat:@"%@",dict[@"edz_price"]];//二等座
                    model.swz_price = [NSString stringWithFormat:@"%@",dict[@"swz_price"]];//商务座
                    model.tdz_price = [NSString stringWithFormat:@"%@",dict[@"tdz_price"]];//特等座
                    model.gjrw_price = [NSString stringWithFormat:@"%@",dict[@"gjrw_price"]];//高级软卧
                    
                    if (![[dict allKeys] containsObject:@"rz_num"]) {
                        
                        model.rz_num = @"";//一等座
                    }else{
                        
                        model.rz_num = [NSString stringWithFormat:@"%@",dict[@"rz_num"]];//一等座
                    }
                    
                    if (![[dict allKeys] containsObject:@"ydz_num"]) {
                        
                        model.ydz_num = @"";//一等座
                    }else{
                        
                        model.ydz_num = [NSString stringWithFormat:@"%@",dict[@"ydz_num"]];//一等座
                    }
                    
                    if (![[dict allKeys] containsObject:@"edz_num"]) {
                        
                        model.edz_num = @"";//二等座
                    }else{
                        
                        model.edz_num = [NSString stringWithFormat:@"%@",dict[@"edz_num"]];//二等座
                    }
                    
                    if (![[dict allKeys] containsObject:@"swz_num"]) {
                        
                        model.swz_num = @"";//商务座
                    }else{
                        
                        model.swz_num = [NSString stringWithFormat:@"%@",dict[@"swz_num"]];//商务座
                    }
                    
                    if (![[dict allKeys] containsObject:@"tdz_num"]) {
                        
                        model.tdz_num = @"";//特等座
                    }else{
                        
                        model.tdz_num = [NSString stringWithFormat:@"%@",dict[@"tdz_num"]];//特等座
                    }
                    
                    if (![[dict allKeys] containsObject:@"gjrw_num"]) {
                        
                        model.gjrw_num = @"";//高级软卧
                    }else{
                        
                        model.gjrw_num = [NSString stringWithFormat:@"%@",dict[@"gjrw_num"]];//高级软卧
                    }
                    
                    
                    [_data addObject:model];
                    
                }
                
                
                [start_cityArrM addObject:@"不限"];
                
                [arrive_cityArrM addObject:@"不限"];
                
                for (NSString *name in dic[@"start_city"]) {
                    
                    [start_cityArrM addObject:name];

                }
                
                for (NSString *name in dic[@"arrive_city"]) {
                    
                    [arrive_cityArrM addObject:name];
                    
                }
                
                if (_data.count == 0) {
                    
                    tabView.hidden=NO;
                    line1.hidden = NO;
//                    [self initNoDataView];
                    _refresh.topEnabled=NO;//下拉刷新
                    NodataView.hidden=NO;
                    NoImgView.hidden=NO;
                    NoLabel.hidden=NO;
                    
                }else{
                    tabView.hidden = NO;
                    line1.hidden=NO;
                    NoLabel.hidden = YES;
                    NodataView.hidden=YES;
                    NoImgView.hidden=YES;
                    _tableView.scrollEnabled=YES;
                }
                
                
            }else{
                
                
//                [JRToast showWithText:dic[@"message"] duration:1.0f];
                
                tabView.hidden = NO;
                line1.hidden=NO;
//                [self initNoDataView];
                _refresh.topEnabled=NO;//下拉刷新
                NodataView.hidden=NO;
                NoImgView.hidden=NO;
                NoLabel.hidden=NO;
                
            }
            
            
            [hud dismiss:YES];
            
            [_tableView reloadData];
            _tableView.contentOffset=CGPointMake(0, 0);
            
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //        [WKProgressHUD popMessage:@"网络请求失败，请检查您的网络设置" inView:self.view duration:1.5 animated:YES];
        [hud dismiss:YES];
        
        
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
    
    Qurt = [UIButton buttonWithType:UIButtonTypeCustom];
    
    Qurt.frame = CGRectMake(10, 25+KSafeTopHeight, 30, 30);
    
    //    [Qurt setBackgroundImage:[UIImage imageNamed:@"iconfont-fanhui2yt"] forState:0];
    
    [Qurt setImage:[UIImage imageNamed:@"iconfont-fanhui2yt"] forState:0];
    
    
    [Qurt addTarget:self action:@selector(QurtBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [titleView addSubview:Qurt];
    
    //创建搜索
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 25+KSafeTopHeight, [UIScreen mainScreen].bounds.size.width-200, 30)];
    
    label.text = [NSString stringWithFormat:@"%@-%@",self.Start,self.End];
    
    label.textColor = [UIColor blackColor];
    
    label.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:19];
    
    label.textAlignment = NSTextAlignmentCenter;
    
    [titleView addSubview:label];
    
    
}

-(void)initTableView
{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 60+KSafeAreaTopNaviHeight, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-60-KSafeAreaTopNaviHeight-51-KSafeAreaBottomHeight) style:UITableViewStylePlain];
    
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    _tableView.dataSource=self;
    _tableView.delegate=self;
    [self.view addSubview:_tableView];
    
    [_tableView registerClass:[CheXingCell class] forCellReuseIdentifier:@"cell"];
    
    
    _refresh=[[DJRefresh alloc] initWithScrollView:_tableView delegate:self];
    _refresh.topEnabled=YES;//下拉刷新
    _refresh.bottomEnabled=NO;//上拉加载
    
    
}

-(void)redView
{
    UIView *redView=[[UIView alloc] initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight, [UIScreen mainScreen].bounds.size.width, 60)];
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)[UIColor colorWithRed:255/255.0 green:52/255.0 blue:90/255.0 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0].CGColor];
    gradientLayer.locations = @[@0.0, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1.0);
    gradientLayer.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 60);
    [redView.layer addSublayer:gradientLayer];
    
//    redView.backgroundColor = [UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
    
    [self.view addSubview:redView];
    
    leftimg = [[UIImageView alloc] initWithFrame:CGRectMake(15, (60-12)/2, 7, 12)];
    leftimg.image = [UIImage imageNamed:@"前一天"];
    [redView addSubview:leftimg];
    
    leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(32, (60-14)/2, 60, 14)];
    leftLabel.text = @"前一天";
    leftLabel.textColor = [UIColor whiteColor];
    leftLabel.font = [UIFont fontWithName:@"PingFang-SC-Regualr" size:14];
    [redView addSubview:leftLabel];
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame  =CGRectMake(0, 0, 92, 60);
    [leftButton addTarget:self action:@selector(leftButtonBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [redView addSubview:leftButton];
    
    UIView *writeView = [[UIView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-TrainWidh)/2, (60-30)/2, TrainWidh, 30)];
    writeView.layer.cornerRadius = 3;
    writeView.layer.masksToBounds = YES;
    writeView.backgroundColor = [UIColor whiteColor];
    [redView addSubview:writeView];
    
    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(TrainWidh-38, 0, 1, 30)];
    line.image = [UIImage imageNamed:@"分割线"];
    [writeView addSubview:line];
    
    UIImageView *Riliimg = [[UIImageView alloc] initWithFrame:CGRectMake(TrainWidh-27, (30-18)/2, 17, 18)];
    Riliimg.image = [UIImage imageNamed:@"日历"];
    [writeView addSubview:Riliimg];
    
    RedLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, TrainWidh-38, 30)];
    
    if ([UIScreen mainScreen].bounds.size.width > 320) {
        
        NSLog(@"1111");
        
        RedLabel.font = [UIFont fontWithName:@"PingFang-SC-Light" size:17];
        
    }else{
        
        NSLog(@"2222");
    
        RedLabel.font = [UIFont fontWithName:@"PingFang-SC-Light" size:14];
    }
    
    NSLog(@"===前一天==%@",RedLabel.font);
    
    RedLabel.text = [NSString stringWithFormat:@"%@ %@",self.Date,self.Week];
    RedLabel.textColor = [UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
    
    RedLabel.textAlignment = NSTextAlignmentCenter;
    [writeView addSubview:RedLabel];
    
    UIButton *RedButton = [UIButton buttonWithType:UIButtonTypeCustom];
    RedButton.frame  =CGRectMake(TrainWidh-38, 0, 38, 30);
    [RedButton addTarget:self action:@selector(RedButtonBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [writeView addSubview:RedButton];
    
    
    
    Rightimg = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-22, (60-12)/2, 7, 12)];
    Rightimg.image = [UIImage imageNamed:@"后一天"];
    [redView addSubview:Rightimg];
    
    RightLabel = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-32-60, (60-14)/2, 60, 14)];
    RightLabel.text = @"后一天";
    RightLabel.textColor = [UIColor whiteColor];
    RightLabel.font = [UIFont fontWithName:@"PingFang-SC-Regualr" size:14];
    RightLabel.textAlignment = NSTextAlignmentRight;
    [redView addSubview:RightLabel];
    
    UIButton *RightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    RightButton.frame  =CGRectMake([UIScreen mainScreen].bounds.size.width-92, 0, 92, 60);
    [RightButton addTarget:self action:@selector(RightButtonBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [redView addSubview:RightButton];
    
    //判断是否置灰前一天按钮
    NSString *string=self.train_date;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *sendDate=[NSDate date];
    NSString *currentDateString=[formatter stringFromDate:sendDate];
    NSString *maxDateString=[formatter stringFromDate:[NSDate dateWithTimeInterval:29*60*60*24 sinceDate:sendDate]];
    if (![self Datestring:string CompareDateString:currentDateString]||[string isEqualToString:currentDateString]) {
        leftimg.image=[leftimg.image imageWithColor:UIColorFromRGB(0xff8c90)];
        leftLabel.textColor=UIColorFromRGB(0xff8c90);
        Rightimg.image=[Rightimg.image imageWithColor:[UIColor whiteColor]];
        RightLabel.textColor=[UIColor whiteColor];
        
    }else if ([self Datestring:string CompareDateString:maxDateString])
    {
        Rightimg.image=[Rightimg.image imageWithColor:UIColorFromRGB(0xff8c90)];
        RightLabel.textColor=UIColorFromRGB(0xff8c90);
        
        leftimg.image=[leftimg.image imageWithColor:[UIColor whiteColor]];
        leftLabel.textColor=[UIColor whiteColor];
    }else
    {
        leftimg.image=[leftimg.image imageWithColor:[UIColor whiteColor]];
        leftLabel.textColor=[UIColor whiteColor];
        
        Rightimg.image=[Rightimg.image imageWithColor:[UIColor whiteColor]];
        RightLabel.textColor=[UIColor whiteColor];
    }
}

-(void)tabView
{
    line1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-51-KSafeAreaBottomHeight, [UIScreen mainScreen].bounds.size.width, 1)];
    line1.image = [UIImage imageNamed:@"分割线-拷贝"];
    [self.view addSubview:line1];
    
    tabView = [[UIView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-50-KSafeAreaBottomHeight, [UIScreen mainScreen].bounds.size.width, 50)];
    tabView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:tabView];
    
    //火车票
    TrainTicketView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width/3, 50)];
    TrainTicketView.backgroundColor = [UIColor whiteColor];
    [tabView addSubview:TrainTicketView];
    
    TrainTicketImgView = [[UIImageView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width/3-22)/2, 8, 22, 22)];
    TrainTicketImgView.image = [UIImage imageNamed:@"排序选中"];
    [TrainTicketView addSubview:TrainTicketImgView];
    
    TrainTicketLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 33, [UIScreen mainScreen].bounds.size.width/3, 10)];
    TrainTicketLabel.text = @"排序";
    TrainTicketLabel.textColor = [UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
    TrainTicketLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:10];
    TrainTicketLabel.textAlignment = NSTextAlignmentCenter;
    [TrainTicketView addSubview:TrainTicketLabel];
    
    
    UIButton *TrainTicketButton = [UIButton buttonWithType:UIButtonTypeCustom];
    TrainTicketButton.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width/3, 50);
    [TrainTicketButton addTarget:self action:@selector(TrainTicketBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [TrainTicketView addSubview:TrainTicketButton];
    
    
    //飞机票
    ArpTicketView = [[UIView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/3, 0, [UIScreen mainScreen].bounds.size.width/3, 50)];
    ArpTicketView.backgroundColor = [UIColor whiteColor];
    [tabView addSubview:ArpTicketView];
    
    ArpTicketImgView = [[UIImageView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width/3-22)/2, 8, 22, 22)];
    ArpTicketImgView.image = [UIImage imageNamed:@"车型"];
    [ArpTicketView addSubview:ArpTicketImgView];
    
    ArpTicketLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 33, [UIScreen mainScreen].bounds.size.width/3, 10)];
    ArpTicketLabel.text = @"车型";
    ArpTicketLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
    ArpTicketLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:10];
    ArpTicketLabel.textAlignment = NSTextAlignmentCenter;
    [ArpTicketView addSubview:ArpTicketLabel];
    
    UIButton *ArpTicketButton = [UIButton buttonWithType:UIButtonTypeCustom];
    ArpTicketButton.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width/3, 50);
    [ArpTicketButton addTarget:self action:@selector(ArpTicketBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [ArpTicketView addSubview:ArpTicketButton];
    
    //个人中心
    MeView = [[UIView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/3*2, 0, [UIScreen mainScreen].bounds.size.width/3, 50)];
    MeView.backgroundColor = [UIColor whiteColor];
    [tabView addSubview:MeView];
    
    MeImgView = [[UIImageView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width/3-22)/2, 8, 22, 22)];
    MeImgView.image = [UIImage imageNamed:@"高级筛选"];
    [MeView addSubview:MeImgView];
    
    MeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 33, [UIScreen mainScreen].bounds.size.width/3, 10)];
    MeLabel.text = @"高级筛选";
    MeLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
    MeLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:10];
    MeLabel.textAlignment = NSTextAlignmentCenter;
    [MeView addSubview:MeLabel];
    
    UIButton *MeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    MeButton.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width/3, 50);
    [MeButton addTarget:self action:@selector(MeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [MeView addSubview:MeButton];
    
}

//暂无车次
-(void)initNoDataView
{

//    [NodataView removeFromSuperview];
//    [NoImgView removeFromSuperview];
//    [NoLabel removeFromSuperview];
    
    NodataView = [[UIView alloc] initWithFrame:CGRectMake(0, ([UIScreen mainScreen].bounds.size.height-150)/2, [UIScreen mainScreen].bounds.size.width, 150)];
    //NodataView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:NodataView];
    
    NoImgView = [[UIImageView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-65)/2, 0, 65, 78)];
    NoImgView.image = [UIImage imageNamed:@"btn-empty"];
    [NodataView addSubview:NoImgView];
    
    NoLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 95, [UIScreen mainScreen].bounds.size.width-60, 15)];
    NoLabel.text = @"未查询到对应车次";
    NoLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    NoLabel.textAlignment = NSTextAlignmentCenter;
    NoLabel.font  =[UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    [NodataView addSubview:NoLabel];
    
    
}
//排序
-(void)TrainTicketBtnClick
{
    
    NSLog(@"排序");
    TrainTicketImgView.image = [UIImage imageNamed:@"排序选中"];
    
   // ArpTicketLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
 //   MeLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
    TrainTicketLabel.textColor = [UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
    
    _customShareView.delegate=self;
    
   [_customShareView showInView:self.view];
    
    
}
//车型
-(void)ArpTicketBtnClick
{
    
    NSLog(@"车型");
//    TrainTicketLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
//    MeLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
    ArpTicketImgView.image = [UIImage imageNamed:@"车型选中"];
    ArpTicketLabel.textColor = [UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
    
    _CheXingView.delegate=self;
    
    [_CheXingView showInView:self.view];
    
    
}

//高级筛选
-(void)MeBtnClick
{
    
    NSLog(@"高级筛选");
    MeImgView.image = [UIImage imageNamed:@"高级筛选选中"];
   // TrainTicketLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
    MeLabel.textColor = [UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
    //ArpTicketLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
    for (NSString *name in start_cityArrM) {
        NSLog(@"name=%@",name);
    }
    self.Gaojiview.delegate=self;
    [_Gaojiview showInView:self.view];
}


/**
 比较两个时间字符串
 
 @param dataString1 时间字符串格式为 yyMMddMMss可以在中间加@“-”
 @param dataString2 同上
 @return 返回NO表示dataString1小于dataString2  返回YES表示dataString1大于或等于dataString2
 */
-(BOOL)Datestring:(NSString *)dataString1 CompareDateString:(NSString *)dataString2
{

    NSString *string1=[dataString1 stringByReplacingOccurrencesOfString:@"-" withString:@""];
    NSString *string2=[dataString2 stringByReplacingOccurrencesOfString:@"-" withString:@""];
    NSInteger dataInt1=[string1 integerValue];
    NSInteger dataInt2=[string2 integerValue];
    NSLog(@"%ld,%ld",dataInt1,dataInt2);
    if (dataInt1<dataInt2) {
        return NO;
    }else
    {
        return YES;
    }
}
//前一天
-(void)leftButtonBtnClick
{
    
    NSLog(@"===%@",self.train_date);
    
    NSString *dateString = self.train_date;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    Rightimg.image=[Rightimg.image imageWithColor:[UIColor whiteColor]];
    RightLabel.textColor=[UIColor whiteColor];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *date = [formatter dateFromString:dateString];
    
    NSDate *yesterday = [NSDate dateWithTimeInterval:-60 * 60 * 24 sinceDate:date];
    NSDate *qianDay=[NSDate dateWithTimeInterval:-2*60*60*24 sinceDate:date];
    
    NSDate *sendDate=[NSDate date];
    NSString *currentDateString=[formatter stringFromDate:sendDate];
    NSLog(@"current=%@",currentDateString);
    //判断当前时间和日历前一天时间
    if (![self Datestring:[formatter stringFromDate:yesterday] CompareDateString:currentDateString]) {
        [TrainToast showWithText:@"不能再往前了" duration:2.0f];
       
        return;
    }
    if (![self Datestring:[formatter stringFromDate:qianDay] CompareDateString:currentDateString]) {
        leftimg.image=[leftimg.image imageWithColor:UIColorFromRGB(0xff8c90)];
        leftLabel.textColor=UIColorFromRGB(0xff8c90);
    }
    
    self.train_date = [formatter stringFromDate:yesterday];
    
    NSCalendar * calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar]; // 指定日历的算法 NSCalendarIdentifierGregorian,NSGregorianCalendar
    // NSDateComponent 可以获得日期的详细信息，即日期的组成
    NSDateComponents *comps = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit|NSWeekCalendarUnit|NSWeekdayCalendarUnit fromDate:yesterday];
    
    NSLog(@"星期 =weekDay = %ld ",comps.weekday);
    if ([comps weekday] == 1) {
        
        self.Week = [NSString stringWithFormat:@"周日"];
        
        NSString *string = [formatter stringFromDate:yesterday];
        
        NSArray *arrray = [string componentsSeparatedByString:@"-"];
        
        RedLabel.text = [NSString stringWithFormat:@"%@月%@日 %@",arrray[1],arrray[2],self.Week];
        
        
    }else if ([comps weekday] == 2){
        
        self.Week = [NSString stringWithFormat:@"周一"];
        
        NSString *string = [formatter stringFromDate:yesterday];
        
        NSArray *arrray = [string componentsSeparatedByString:@"-"];
        
        RedLabel.text = [NSString stringWithFormat:@"%@月%@日 %@",arrray[1],arrray[2],self.Week];
        
    }else if ([comps weekday] == 3){
        
        self.Week = [NSString stringWithFormat:@"周二"];
        
        NSString *string = [formatter stringFromDate:yesterday];
        
        NSArray *arrray = [string componentsSeparatedByString:@"-"];
        
        RedLabel.text = [NSString stringWithFormat:@"%@月%@日 %@",arrray[1],arrray[2],self.Week];
        
    }else if ([comps weekday] == 4){
        
        self.Week = [NSString stringWithFormat:@"周三"];
        
        NSString *string = [formatter stringFromDate:yesterday];
        
        NSArray *arrray = [string componentsSeparatedByString:@"-"];
        
        RedLabel.text = [NSString stringWithFormat:@"%@月%@日 %@",arrray[1],arrray[2],self.Week];
        
    }else if ([comps weekday] == 5){
        
        self.Week = [NSString stringWithFormat:@"周四"];
        
        NSString *string = [formatter stringFromDate:yesterday];
        
        NSArray *arrray = [string componentsSeparatedByString:@"-"];
        
        RedLabel.text = [NSString stringWithFormat:@"%@月%@日 %@",arrray[1],arrray[2],self.Week];
        
    }else if ([comps weekday] == 6){
        
        self.Week = [NSString stringWithFormat:@"周五"];
        
        NSString *string = [formatter stringFromDate:yesterday];
        
        NSArray *arrray = [string componentsSeparatedByString:@"-"];
        
        RedLabel.text = [NSString stringWithFormat:@"%@月%@日 %@",arrray[1],arrray[2],self.Week];
        
    }else if ([comps weekday] == 7){
        
        self.Week = [NSString stringWithFormat:@"周六"];
        
        NSString *string = [formatter stringFromDate:yesterday];
        
        NSArray *arrray = [string componentsSeparatedByString:@"-"];
        
        RedLabel.text = [NSString stringWithFormat:@"%@月%@日 %@",arrray[1],arrray[2],self.Week];
        
    }
    
    
    NSLog(@"前一天===%@",[formatter stringFromDate:yesterday]);
    
    [self getdatas];
}
//后一天
-(void)RightButtonBtnClick
{
    
    NSString *dateString = self.train_date;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *date = [formatter dateFromString:dateString];
    
    NSDate *tomorrow = [NSDate dateWithTimeInterval:60 * 60 * 24 sinceDate:date];
    NSDate *houTian = [NSDate dateWithTimeInterval:2*60 * 60 * 24 sinceDate:date];
    leftimg.image=[leftimg.image imageWithColor:[UIColor whiteColor]];
    leftLabel.textColor=[UIColor whiteColor];
    
    NSLog(@"后一天==%@",[formatter stringFromDate:tomorrow]);
    
    NSDate *standardDate=[NSDate dateWithTimeIntervalSinceNow:29*24*60*60];

    NSString *currentString=[formatter stringFromDate:standardDate];
    
    if (![self Datestring:currentString CompareDateString:[formatter stringFromDate:tomorrow]]) {
      Rightimg.image=[Rightimg.image imageWithColor:UIColorFromRGB(0xff8c90)];
        RightLabel.textColor=UIColorFromRGB(0xff8c90);
        [TrainToast showWithText:@"已经选择最后一天" duration:2.0];
        return;
    }
    if (![self Datestring:currentString CompareDateString:[formatter stringFromDate:houTian]]) {
        Rightimg.image=[Rightimg.image imageWithColor:UIColorFromRGB(0xff8c90)];
        RightLabel.textColor=UIColorFromRGB(0xff8c90);
    }
    self.train_date = [formatter stringFromDate:tomorrow];
    
    NSCalendar * calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar]; // 指定日历的算法 NSCalendarIdentifierGregorian,NSGregorianCalendar
    // NSDateComponent 可以获得日期的详细信息，即日期的组成
    NSDateComponents *comps = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit|NSWeekCalendarUnit|NSWeekdayCalendarUnit fromDate:tomorrow];
    
    NSLog(@"星期 =weekDay = %ld ",comps.weekday);
    if ([comps weekday] == 1) {
        
        self.Week = [NSString stringWithFormat:@"周日"];
        
        NSString *string = [formatter stringFromDate:tomorrow];
        
        NSArray *arrray = [string componentsSeparatedByString:@"-"];
        
        RedLabel.text = [NSString stringWithFormat:@"%@月%@日 %@",arrray[1],arrray[2],self.Week];
        
    }else if ([comps weekday] == 2){
        
        self.Week = [NSString stringWithFormat:@"周一"];
        
        NSString *string = [formatter stringFromDate:tomorrow];
        
        NSArray *arrray = [string componentsSeparatedByString:@"-"];
        
        RedLabel.text = [NSString stringWithFormat:@"%@月%@日 %@",arrray[1],arrray[2],self.Week];
        
    }else if ([comps weekday] == 3){
        
        self.Week = [NSString stringWithFormat:@"周二"];
        
        NSString *string = [formatter stringFromDate:tomorrow];
        
        NSArray *arrray = [string componentsSeparatedByString:@"-"];
        
        RedLabel.text = [NSString stringWithFormat:@"%@月%@日 %@",arrray[1],arrray[2],self.Week];
        
    }else if ([comps weekday] == 4){
        
        self.Week = [NSString stringWithFormat:@"周三"];
        
        NSString *string = [formatter stringFromDate:tomorrow];
        
        NSArray *arrray = [string componentsSeparatedByString:@"-"];
        
        RedLabel.text = [NSString stringWithFormat:@"%@月%@日 %@",arrray[1],arrray[2],self.Week];
        
    }else if ([comps weekday] == 5){
        
        self.Week = [NSString stringWithFormat:@"周四"];
        
        NSString *string = [formatter stringFromDate:tomorrow];
        
        NSArray *arrray = [string componentsSeparatedByString:@"-"];
        
        RedLabel.text = [NSString stringWithFormat:@"%@月%@日 %@",arrray[1],arrray[2],self.Week];
        
    }else if ([comps weekday] == 6){
        
        self.Week = [NSString stringWithFormat:@"周五"];
        
        NSString *string = [formatter stringFromDate:tomorrow];
        
        NSArray *arrray = [string componentsSeparatedByString:@"-"];
        
        RedLabel.text = [NSString stringWithFormat:@"%@月%@日 %@",arrray[1],arrray[2],self.Week];
        
    }else if ([comps weekday] == 7){
        
        self.Week = [NSString stringWithFormat:@"周六"];
        
        NSString *string = [formatter stringFromDate:tomorrow];
        
        NSArray *arrray = [string componentsSeparatedByString:@"-"];
        
        RedLabel.text = [NSString stringWithFormat:@"%@月%@日 %@",arrray[1],arrray[2],self.Week];
        
    }
    
    [self getdatas];
    
}
//日历
-(void)RedButtonBtnClick
{
    NSLog(@"日历");
    
    TrainSelectDateViewController *vc = [[TrainSelectDateViewController alloc] init];
    //    vc.delegate=self;
    //    vc.Type = @"2";
    
    [vc setTrainToDay:30 ToDateforString:self.train_date];
    
    vc.calendarblock = ^(CalendarDayModel *model){
        
        NSLog(@"\n---------------------------");
        NSLog(@"1星期 %@",[model getWeek]);
        NSLog(@"2字符串 %@",[model toString]);
        NSLog(@"3节日  %@",model.holiday);
        
        NSString *string = [NSString stringWithFormat:@"%@",[model toString]];
        NSArray *array = [string componentsSeparatedByString:@"-"];
        self.Week = [NSString stringWithFormat:@"%@",[model getWeek]];
        self.Date = [NSString stringWithFormat:@"%@月%@日",array[1],array[2]];
        RedLabel.text = [NSString stringWithFormat:@"%@ %@",self.Date,self.Week];
        self.train_date = [NSString stringWithFormat:@"%@",[model toString]];
       
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSDate *sendDate=[NSDate date];
        NSString *currentDateString=[formatter stringFromDate:sendDate];
        NSString *maxDateString=[formatter stringFromDate:[NSDate dateWithTimeInterval:29*60*60*24 sinceDate:sendDate]];
        NSLog(@"currentstring=%@,%@",currentDateString,maxDateString);
        if (![self Datestring:string CompareDateString:currentDateString]||[string isEqualToString:currentDateString]) {
            leftimg.image=[leftimg.image imageWithColor:UIColorFromRGB(0xff8c90)];
            leftLabel.textColor=UIColorFromRGB(0xff8c90);
            Rightimg.image=[Rightimg.image imageWithColor:[UIColor whiteColor]];
            RightLabel.textColor=[UIColor whiteColor];
            
        }else if ([self Datestring:string CompareDateString:maxDateString])
        {
            Rightimg.image=[Rightimg.image imageWithColor:UIColorFromRGB(0xff8c90)];
            RightLabel.textColor=UIColorFromRGB(0xff8c90);
            
            leftimg.image=[leftimg.image imageWithColor:[UIColor whiteColor]];
            leftLabel.textColor=[UIColor whiteColor];
        }else
        {
            leftimg.image=[leftimg.image imageWithColor:[UIColor whiteColor]];
            leftLabel.textColor=[UIColor whiteColor];
        
            Rightimg.image=[Rightimg.image imageWithColor:[UIColor whiteColor]];
            RightLabel.textColor=[UIColor whiteColor];
        }
        
        [self getdatas];
        
        
    };
    
    
    
    [self.navigationController pushViewController:vc animated:NO];
    
    self.navigationController.navigationBar.hidden=YES;
    
    
}

-(void)QurtBtnClick{
    
    [self.navigationController popViewControllerAnimated:NO];
    self.tabBarController.tabBar.hidden=YES;
}
#pragma-mark TableViewDelegate的方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _data.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 80;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    CheXingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    BianMinModel *model = _data[indexPath.row];
    
    cell.StartTimeLabel.text = model.start_time;
    
    cell.EndTimeLabel.text = model.arrive_time;
    
    cell.StartNameLabel.text = model.from_station_name;
    
    cell.EndNameLabel.text = model.to_station_name;
    
    cell.CheCiLabel.text = model.traincode;
    
    NSArray *array = [model.run_time componentsSeparatedByString:@":"];
    if ([array[0] integerValue]==0) {
        cell.TimeLabel.text=[NSString stringWithFormat:@"%@分钟",array[1]];
    }else
    {
    cell.TimeLabel.text = [NSString stringWithFormat:@"%@时%@分",array[0],array[1]];
    }
    
    
    cell.PriceLabel.text = [NSString stringWithFormat:@"￥%@起",model.last_price];
    
    NSString *ShiFuPriceForColor = @"￥";
    NSString *ShiFuPriceForColor2 = @"起";
    // 创建对象.
    NSMutableAttributedString *mAttStri1 = [[NSMutableAttributedString alloc] initWithString:cell.PriceLabel.text];
    //
    NSRange range1 = [cell.PriceLabel.text rangeOfString:ShiFuPriceForColor];
    NSRange range2 = [cell.PriceLabel.text rangeOfString:ShiFuPriceForColor2];
                            
   [mAttStri1 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:20] range:range1];
   [mAttStri1 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:14] range:range2];
   [mAttStri1 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0] range:range2];
   cell.PriceLabel.attributedText=mAttStri1;
    
    NSMutableArray *numArrM = [NSMutableArray new];
    
//    if ([model.train_type isEqualToString:@"0"]) {//G/D/C
        
        NSString *CharString = [model.traincode substringToIndex:1];
        
     //   NSLog(@"======%@",model.traincode);
        if ([CharString isEqualToString:@"C"]) {
            
            
            if (![model.edz_num isEqualToString:@""]) {
                
                [numArrM addObject:[NSString stringWithFormat:@"二等座:%@张",model.edz_num]];
            
            }
            
            if (![model.ydz_num isEqualToString:@""]) {
                
                [numArrM addObject:[NSString stringWithFormat:@"一等座:%@张",model.ydz_num]];
            }
            
            if (![model.tdz_num isEqualToString:@""]) {
                
                [numArrM addObject:[NSString stringWithFormat:@"特等座:%@张",model.tdz_num]];
            }
            
            if (![model.swz_num isEqualToString:@""]) {
                
                [numArrM addObject:[NSString stringWithFormat:@"商务座:%@张",model.swz_num]];
            }
            
            if (![model.wz_num isEqualToString:@""]) {
                
                [numArrM addObject:[NSString stringWithFormat:@"无座:%@张",model.wz_num]];
            }
            
//            cell.array = numArrM;
            
        } else if([CharString isEqualToString:@"G"]){
            
//            NSMutableArray *numArrM = [NSMutableArray new];
            
            if (![model.edz_num isEqualToString:@""]) {
                
                [numArrM addObject:[NSString stringWithFormat:@"二等座:%@张",model.edz_num]];
            }
            
            if (![model.ydz_num isEqualToString:@""]) {
                
                [numArrM addObject:[NSString stringWithFormat:@"一等座:%@张",model.ydz_num]];
            }
            
            if (![model.tdz_num isEqualToString:@""]) {
                
                [numArrM addObject:[NSString stringWithFormat:@"特等座:%@张",model.tdz_num]];
            }
            
            if (![model.swz_num isEqualToString:@""]) {
                
                [numArrM addObject:[NSString stringWithFormat:@"商务座:%@张",model.swz_num]];
            }
            
            if (![model.wz_num isEqualToString:@""]) {
                
                [numArrM addObject:[NSString stringWithFormat:@"无座:%@张",model.wz_num]];
            }
            
//            cell.array = numArrM;
            
            
        }else if([CharString isEqualToString:@"D"]){
            
//            NSMutableArray *numArrM = [NSMutableArray new];
            
            if (![model.edz_num isEqualToString:@""]) {
                
                [numArrM addObject:[NSString stringWithFormat:@"二等座:%@张",model.edz_num]];
            }
            
            if (![model.ydz_num isEqualToString:@""]) {
                
                [numArrM addObject:[NSString stringWithFormat:@"一等座:%@张",model.ydz_num]];
            }
            
            if (![model.gjrw_num isEqualToString:@""]) {
                
                [numArrM addObject:[NSString stringWithFormat:@"高级软卧:%@张",model.gjrw_num]];
            }
            
            if (![model.tdz_num isEqualToString:@""]) {
                
                [numArrM addObject:[NSString stringWithFormat:@"特等座:%@张",model.tdz_num]];
            }
            
            if (![model.wz_num isEqualToString:@""]) {
                
                [numArrM addObject:[NSString stringWithFormat:@"无座:%@张",model.wz_num]];
            }
            
            
//            cell.array = numArrM;
        }else{
            
            
            if (![model.yw_num isEqualToString:@""]) {
                
                [numArrM addObject:[NSString stringWithFormat:@"硬卧:%@张",model.yw_num]];
            }
            
            if (![model.rw_num isEqualToString:@""]) {
                
                [numArrM addObject:[NSString stringWithFormat:@"软卧:%@张",model.rw_num]];
            }
            
            if (![model.yz_num isEqualToString:@""]) {
                
                [numArrM addObject:[NSString stringWithFormat:@"硬座:%@张",model.yz_num]];
            }
            
            if (![model.rz_num isEqualToString:@""]) {
                
                [numArrM addObject:[NSString stringWithFormat:@"软座:%@张",model.rz_num]];
            }
            
            if (![model.wz_num isEqualToString:@""]) {
                
                [numArrM addObject:[NSString stringWithFormat:@"无座:%@张",model.wz_num]];
            }
        }
    
    cell.array = numArrM;
    
    [numArrM removeAllObjects];
    
    return cell;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    BianMinModel *model = _data[indexPath.row];
    
    CheCiDetailViewController *vc = [[CheCiDetailViewController alloc] init];
    
    vc.DateString = RedLabel.text;
    vc.train_date = self.train_date;
    vc.from_station = model.from_station_code;
    vc.to_station = model.to_station_code;
    vc.train_code = model.traincode;
    vc.start_time = model.start_time;
    
    vc.StartCity = model.from_station_name;
    vc.StartTime = model.start_time;
    vc.ArriveCity = model.to_station_name;
    vc.ArriveTime = model.arrive_time;
    vc.CheCi = model.traincode;
    
    NSArray *array = [model.run_time componentsSeparatedByString:@":"];
    if ([array[0] floatValue]==0) {
        vc.RunTime=[NSString stringWithFormat:@"%@分钟",array[1]];
    }else
    {
    vc.RunTime = [NSString stringWithFormat:@"%@时%@分",array[0],array[1]];
    }
    [self.navigationController pushViewController:vc animated:NO];
    self.navigationController.navigationBar.hidden=YES;
    
}

#pragma-mark PaiXuDelegate的方法
-(void)PaiXuString:(NSString *)string
{
    
    NSLog(@"==string==%@",string);
    
    self.time_type = string;
    
    [self getdatas];
    
    
}

#pragma-mark CheXingDelegate的方法
-(void)CheXingString:(NSString *)string
{
    
    
    NSLog(@"======%@",string);
    
    if (string.length == 0) {
        
        ArpTicketImgView.image = [UIImage imageNamed:@"车型"];
        ArpTicketLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
        
    }else{
        
        self.che_type = string;
        
        [self getdatas];
        
        ArpTicketImgView.image = [UIImage imageNamed:@"车型选中"];
        ArpTicketLabel.textColor = [UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
        
    }
    
}

#pragma-mark GaojiDelegate的方法
-(void)fromString:(NSString *)fromString ToStationString:(NSString *)toStationString SitTypeString:(NSString *)typeString
{
    
    NSLog(@"===高级刷选666===%@===%@===%@",fromString,toStationString,typeString);
    
    if (fromString.length==0 && toStationString.length==0 && typeString.length==0) {
        
        MeImgView.image = [UIImage imageNamed:@"高级筛选"];
        
//        self.from_station = @"";
//        self.to_station = @"";
        
        self.fromStationStr = @"";
        self.toStationStr = @"";
        self.sitTypeStr = @"";
            
        [self getdatas];
        MeLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
        
    }else{
        
        if (fromString) {
            self.fromStationStr=fromString;
        }
        if (toStationString) {
            self.toStationStr=toStationString;
        }
        if (typeString) {
            self.sitTypeStr=typeString;
        }
        
       
        [self getdatas];
        
        MeImgView.image = [UIImage imageNamed:@"高级筛选选中"];
        MeLabel.textColor = [UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
        
    }
    
}

- (void)refresh:(DJRefresh *)refresh didEngageRefreshDirection:(DJRefreshDirection)direction{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self addDataWithDirection:direction];
    });
    
}

- (void)addDataWithDirection:(DJRefreshDirection)direction{
    
    if (direction==DJRefreshDirectionTop) {
        
        
        [self getdatas];
        
    }
    [_refresh finishRefreshingDirection:direction animation:YES];
    [_tableView reloadData];
}


-(void)setUnselect
{
    
    MeImgView.image = [UIImage imageNamed:@"高级筛选"];
    MeLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
}

-(NSString *)fromStationStr
{
    if (!_fromStationStr) {
        _fromStationStr=@"";
    }
    return _fromStationStr;
}

-(NSString *)toStationStr
{
    if (!_toStationStr) {
        _toStationStr=@"";
    }
    return _toStationStr;
}

-(NSString *)sitTypeStr
{
    if (!_sitTypeStr) {
        _sitTypeStr=@"";
    }
    return _sitTypeStr;
}

-(GaoJiView *)Gaojiview
{
    if (!_Gaojiview) {
        _Gaojiview=[[GaoJiView alloc]initWithFrame:CGRectMake(0, 200, 375, 400) withStart:start_cityArrM andEndArray:arrive_cityArrM];
        [self.view addSubview:_Gaojiview];
    }
    return _Gaojiview;
}

@end
