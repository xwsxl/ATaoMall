//
//  CheCiDetailViewController.m
//  火车票
//
//  Created by 阳涛 on 17/5/13.
//  Copyright © 2017年 yangtao. All rights reserved.
//

#import "CheCiDetailViewController.h"

#import "TrainYuDingViewController.h"

#import "ConverUtil.h"
#import "DESUtil.h"
#import "SecretCodeTool.h"
#import "AirSelectView.h"
#import "RecordAirManger.h"
#import "BianMinModel.h"
#import "AFNetworking.h"
#import "WKProgressHUD.h"
#import "JRToast.h"
#import "UserMessageManager.h"
#import "TrainSelectDateViewController.h"

#import "SelectDateViewController.h"
#import "ATHLoginViewController.h"
#import "TrainToast.h"
@interface CheCiDetailViewController ()<LoginMessageDelegate>
{
    SelectDateViewController *chvc;
    UIScrollView *_scrollView;
    
    UILabel *RiLiLabel;
    
    NSMutableArray *_data;
    
    UIView *NodataView;
    UIImageView *NoImgView;
    UILabel *NoLabel;
    
    UILabel *label;
    
}
@end

@implementation CheCiDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    NSLog(@"=====%@",self.train_date);
    NSLog(@"=====%@",self.from_station);
    NSLog(@"=====%@",self.to_station);
    NSLog(@"=====%@",self.train_code);
    NSLog(@"=====%@",self.start_time);
    
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数组NSArray类型的数据
    self.sigen=[userDefaultes stringForKey:@"sigen"];
    
    _data = [NSMutableArray new];
    
    self.view.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1.0];
    
    [self initNav];
    
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-KSafeAreaTopNaviHeight)];
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height+100);
    [self.view addSubview:_scrollView];
    
    
    [self initRedView];
    
    [self initRiLiView];
    
    [self getdatas];
    
}

-(void)getdatas
{
    
    NoLabel.hidden = YES;
    NodataView.hidden=YES;
    NoImgView.hidden=YES;
    
    for (int i = 0; i < _data.count; i++) {
        
        UIButton *view1 = (UIButton *)[self.view viewWithTag:100+i];
        [view1 removeFromSuperview];
        
        UIView *view2 = (UIView *)[self.view viewWithTag:200+i];
        [view2 removeFromSuperview];
        
        UILabel *view3 = (UILabel *)[self.view viewWithTag:300+i];
        [view3 removeFromSuperview];
        
        UILabel *view4 = (UILabel *)[self.view viewWithTag:400+i];
        [view4 removeFromSuperview];
        
        UILabel *view5 = (UILabel *)[self.view viewWithTag:500+i];
        [view5 removeFromSuperview];
        
        UIImageView *view6 = (UIImageView *)[self.view viewWithTag:600+i];
        [view6 removeFromSuperview];
        
        
    }
  //  WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
    WKProgressHUD *hud = [WKProgressHUD showInView:self.view animated:YES];
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        
    });
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@getSpecifiedTrainInformation_mob.shtml",URL_Str];
    //saveUserExchange_mob.shtml
    
    NSDictionary *dict = @{@"train_date":self.train_date,@"from_station":self.from_station,@"to_station":self.to_station,@"train_code":self.train_code,@"start_time":self.start_time};
    
    [manager POST:url parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
        NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];
        
        
        if (codeKey && content) {
            NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
            
            NSLog(@"xmlStr=火车票预订=%@",xmlStr);
            
            
            NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            
            [_data removeAllObjects];
            
            if ([dic[@"status"] isEqualToString:@"10000"]) {
                
                for (NSDictionary *dict1 in dic[@"list1"]) {
                    
                    
//                    self.StartTime = [NSString stringWithFormat:@"%@",dict1[@"start_time"]];
//                    self.ArriveTime = [NSString stringWithFormat:@"%@",dict1[@"arrive_time"]];
//                    self.StartCity = [NSString stringWithFormat:@"%@",dict1[@"from_station_name"]];
//                    self.ArriveCity = [NSString stringWithFormat:@"%@",dict1[@"to_station_name"]];
//                    self.to_station = [NSString stringWithFormat:@"%@",dict1[@"to_station_code"]];
//                    self.from_station = [NSString stringWithFormat:@"%@",dict1[@"from_station_code"]];
                    
                    self.che_type = [NSString stringWithFormat:@"%@",dict1[@"train_type"]];
                    self.run_time = [NSString stringWithFormat:@"%@",dict1[@"run_time"]];
                }
                
                for (NSDictionary *dict1 in dic[@"list2"]) {
                    
                    
                    BianMinModel *model = [[BianMinModel alloc] init];
                    
                    model.Detail_num = [NSString stringWithFormat:@"%@",dict1[@"num"]];
                    model.Detail_price = [NSString stringWithFormat:@"%@",dict1[@"price"]];
                    model.Detail_name = [NSString stringWithFormat:@"%@",dict1[@"name"]];
                    model.Detail_type = [NSString stringWithFormat:@"%@",dict1[@"type"]];
                    model.zwcode = [NSString stringWithFormat:@"%@",dict1[@"zwcode"]];
                    model.Detail_select = @"0";
                    model.is_accept_standing = [NSString stringWithFormat:@"%@",dict1[@"is_accept_standing"]];
                    [_data addObject:model];
                    
                }
                
                
                [self initSelectView];
                
                if (_data.count == 0) {
                    
                    [self initNoDataView];

                    NodataView.hidden=NO;
                    NoImgView.hidden=NO;
                    NoLabel.hidden=NO;
                    
                }else{

                    NoLabel.hidden = YES;
                    NodataView.hidden=YES;
                    NoImgView.hidden=YES;
                }
                
                
            }else{
                
                [self initNoDataView];
                NodataView.hidden=NO;
                NoImgView.hidden=NO;
                NoLabel.hidden=NO;
                
            }
            
            
                
            [hud dismiss:YES];
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [hud dismiss:YES];
        
        NSLog(@"%@",error);

        
    }];
    
}

//暂无车次
-(void)initNoDataView
{
    
    [NodataView removeFromSuperview];
    [NoImgView removeFromSuperview];
    [NoLabel removeFromSuperview];
    
    NodataView = [[UIView alloc] initWithFrame:CGRectMake(0, 90+47+100, [UIScreen mainScreen].bounds.size.width, 150)];
    NodataView.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1.0];
    [_scrollView addSubview:NodataView];
    
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
    
    [Qurt setImage:[UIImage imageNamed:@"iconfont-fanhui2yt"] forState:0];
    
    
    [Qurt addTarget:self action:@selector(QurtBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [titleView addSubview:Qurt];
    
    //创建搜索
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(50, 25+KSafeTopHeight, [UIScreen mainScreen].bounds.size.width-100, 30)];
    
    label.text = self.DateString;
    
    label.textColor = [UIColor blackColor];
    
    label.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:19];
    
    label.textAlignment = NSTextAlignmentCenter;
    
    [titleView addSubview:label];
    
}

-(void)initRedView
{
    UIView *redView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 80)];
    [_scrollView addSubview:redView];
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)[UIColor colorWithRed:255/255.0 green:52/255.0 blue:90/255.0 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0].CGColor];
    gradientLayer.locations = @[@0.0, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1.0);
    gradientLayer.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 80);
    [redView.layer addSublayer:gradientLayer];
    
    UILabel *StartLabel = [[UILabel alloc] initWithFrame:CGRectMake(45, 23, 100, 13)];
    StartLabel.text = self.StartCity;
    StartLabel.textColor = [UIColor whiteColor];
    StartLabel.font  =[UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    [redView addSubview:StartLabel];
    
    UILabel *StartTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(47, 47, 100, 11)];
    StartTimeLabel.text = self.StartTime;
    StartTimeLabel.textColor = [UIColor whiteColor];
    StartTimeLabel.font  =[UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    [redView addSubview:StartTimeLabel];
    
    
    UILabel *EndLabel = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-100-45, 23, 100, 13)];
    EndLabel.text = self.ArriveCity;
    EndLabel.textColor = [UIColor whiteColor];
    EndLabel.textAlignment = NSTextAlignmentRight;
    EndLabel.font  =[UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    [redView addSubview:EndLabel];
    
    UILabel *EndTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-100-47, 47, 100, 11)];
    EndTimeLabel.text = self.ArriveTime;
    EndTimeLabel.textColor = [UIColor whiteColor];
    EndTimeLabel.textAlignment = NSTextAlignmentRight;
    EndTimeLabel.font  =[UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    [redView addSubview:EndTimeLabel];
    
    UILabel *TimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-100)/2, 17, 100, 13)];
    TimeLabel.text = self.RunTime;
    TimeLabel.textColor = [UIColor whiteColor];
    TimeLabel.textAlignment = NSTextAlignmentCenter;
    TimeLabel.font  =[UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    [redView addSubview:TimeLabel];
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-88)/2, 34, 88, 9)];
    imgView.image = [UIImage imageNamed:@"开往"];
    [redView addSubview:imgView];
    
    UILabel *CheCiLabel = [[UILabel alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-100)/2, 53, 100, 11)];
    CheCiLabel.text = self.CheCi;
    CheCiLabel.textColor = [UIColor whiteColor];
    CheCiLabel.textAlignment = NSTextAlignmentCenter;
    CheCiLabel.font  =[UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    [redView addSubview:CheCiLabel];
    
}

-(void)initRiLiView
{
    
    UIView *RiliVew = [[UIView alloc] initWithFrame:CGRectMake(0, 80, [UIScreen mainScreen].bounds.size.width, 47)];
    RiliVew.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:RiliVew];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-180)/2, 0, 180, 47)];
    [RiliVew addSubview:view];
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 14, 20, 20)];
    imgView.image = [UIImage imageNamed:@"日历713"];
    [view addSubview:imgView];
    
    RiLiLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 17.5, 150, 13.5)];
    RiLiLabel.text = self.DateString;
    RiLiLabel.textAlignment = NSTextAlignmentCenter;
    RiLiLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    RiLiLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15];
    [view addSubview:RiLiLabel];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 47);
    [button addTarget:self action:@selector(ButtonBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [RiliVew addSubview:button];
    
}
-(void)initSelectView
{
    
    for (int i = 0; i < _data.count; i++) {
        
        BianMinModel *model = _data[i];
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 155 + 50*i-65+47, [UIScreen mainScreen].bounds.size.width, 50)];
        view.backgroundColor = [UIColor whiteColor];
        view.tag = 200+i;
        [_scrollView addSubview:view];
        
        UILabel *dengci = [[UILabel alloc] initWithFrame:CGRectMake(15, (50-14)/2, 80, 14)];
        dengci.text = model.Detail_name;
        dengci.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        dengci.font  =[UIFont fontWithName:@"PingFang-SC-Regular" size:14];
        dengci.tag = 300+i;
        [view addSubview:dengci];
        
        UILabel *number = [[UILabel alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-100)/2, (50-13)/2, 100, 13)];
        
        number.tag = 400+i;
        if ([model.Detail_num intValue] <= 20 && [model.Detail_num intValue] != 0) {
            
            number.text = [NSString stringWithFormat:@"仅剩%@张",model.Detail_num];
            number.textColor = [UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
            
        }else if ([model.Detail_num intValue] == 0){
            
            number.text = @"无票";
            number.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
            
        }else{
            
            number.text = [NSString stringWithFormat:@"%@张",model.Detail_num];
            number.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        }
        
        number.textAlignment = NSTextAlignmentCenter;
        number.font  =[UIFont fontWithName:@"PingFang-SC-Regular" size:14];
        [view addSubview:number];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-15-41, (50-25)/2, 41, 25);
        [button setTitle:@"预订" forState:0];
        [button setTitleColor:[UIColor whiteColor] forState:0];
        button.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
        button.layer.cornerRadius = 3;
        button.layer.masksToBounds = YES;
        button.tag = 100+i;
        
        if ([model.Detail_num intValue] == 0) {
            
            button.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:246/255.0 alpha:1.0];
            
        }else{
            
            button.backgroundColor = [UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
            
            [button addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
            
        }
        
        [view addSubview:button];
        
        UILabel *price = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-15-41-4-100, (50-12)/2, 100, 12)];
        price.text = [NSString stringWithFormat:@"￥%@",model.Detail_price];
        price.textAlignment = NSTextAlignmentRight;
        price.textColor = [UIColor colorWithRed:255/255.0 green:92/255.0 blue:94/255.0 alpha:1.0];
        price.font  =[UIFont fontWithName:@"PingFang-SC-Regular" size:14];
        price.tag = 500+i;
        [view addSubview:price];
        
        NSString *stringForColor = @"￥";
        
        // 创建对象.
        NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:price.text];
        //
        NSRange range = [price.text rangeOfString:stringForColor];
        
        [mAttStri addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:15] range:range];
        
        price.attributedText=mAttStri;
        
        
        
        
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 49, [UIScreen mainScreen].bounds.size.width, 1)];
        imgView.image = [UIImage imageNamed:@"分割线-拷贝"];
        imgView.tag = 600+i;
        [view addSubview:imgView];
        
        
    }
}

//日历选择
-(void)ButtonBtnClick
{
    
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
        
        self.train_date = [NSString stringWithFormat:@"%@",[model toString]];
        
        self.Week = [NSString stringWithFormat:@"%@",[model getWeek]];
        self.Date = [NSString stringWithFormat:@"%@月%@日",array[1],array[2]];
        RiLiLabel.text = [NSString stringWithFormat:@"%@ %@",self.Date,self.Week];
        self.DateString = [NSString stringWithFormat:@"%@ %@",self.Date,self.Week];
        
        
        label.text = self.DateString;
        
        
        [self getdatas];
        
    };
    
    
    
    [self.navigationController pushViewController:vc animated:NO];
    
    self.navigationController.navigationBar.hidden=YES;
    
}
-(void)BtnClick:(UIButton *)sender
{
    
    //全部不选中
    for (BianMinModel *model in _data) {
        
        model.Detail_select = @"0";
    }
    
    BianMinModel *model = _data[sender.tag-100];
    
    model.Detail_select = @"1";
    
    NSLog(@"======%@",model.Detail_name);

    if (self.sigen.length == 0) {
        
        self.sigen = @"";
        
    }
   // WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
    WKProgressHUD *hud = [WKProgressHUD showInView:self.view animated:YES];
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        
    });
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@getTrainReservation_mob.shtml",URL_Str];
    //saveUserExchange_mob.shtml
    
    NSDictionary *dict = @{@"sigen":self.sigen,@"price":model.Detail_price};
    
    [manager POST:url parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
        NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];
        
        
        if (codeKey && content) {
            NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
            
            NSLog(@"xmlStr=预订=%@",xmlStr);
            
            
            NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            
            if ([dic[@"status"] isEqualToString:@"10000"]) {
                
                TrainYuDingViewController *vc = [[TrainYuDingViewController alloc] init];
                
                vc.phone = [NSString stringWithFormat:@"%@",dic[@"phone"]];
                vc.StartCity = self.StartCity;
                vc.StartTime = self.StartTime;
                vc.ArriveCity = self.ArriveCity;
                vc.ArriveTime = self.ArriveTime;
                vc.CheCi = self.CheCi;
                vc.RunTime = self.RunTime;
                vc.from_station = self.from_station;
                vc.to_station = self.to_station;
                vc.DateString = self.DateString;
                vc.Name = model.Detail_name;
                vc.Price = model.Detail_price;
                vc.TicketCount = model.Detail_num;
                vc.PriceArray = _data;
                vc.TypeString = model.Detail_type;
                vc.zwcode = model.zwcode;
                vc.run_time = self.run_time;
                vc.che_type = self.che_type;
                vc.train_date = self.train_date;
                vc.is_accept_standing = model.is_accept_standing;
                
                [self.navigationController pushViewController:vc animated:NO];
                self.navigationController.navigationBar.hidden=YES;
                
                
            }else if([dic[@"status"] isEqualToString:@"10002"]){
                
                
//                [TrainToast showWithText:dic[@"message"] duration:2.0f];
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:dic[@"message"] message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                
                [alert show];
                
            }else if([dic[@"status"] isEqualToString:@"10003"]){
                
                //跳转登录页
                
                ATHLoginViewController *vc=[[ATHLoginViewController alloc] init];
                vc.delegate=self;
                vc.backString=@"719";
                
                vc.Train_StartCity = self.StartCity;
                vc.Train_StartTime = self.StartTime;
                vc.Train_ArriveCity = self.ArriveCity;
                vc.Train_ArriveTime = self.ArriveTime;
                vc.Train_CheCi = self.CheCi;
                vc.Train_RunTime = self.RunTime;
                vc.Train_from_station = self.from_station;
                vc.Train_to_station = self.to_station;
                vc.Train_DateString = self.DateString;
                vc.Train_Name = model.Detail_name;
                vc.Train_Price = model.Detail_price;
                vc.Train_TicketCount = model.Detail_num;
                vc.Train_PriceArray = _data;
                vc.Train_TypeString = model.Detail_type;
                vc.Train_zwcode = model.zwcode;
                vc.Train_run_time = self.run_time;
                vc.Train_che_type = self.che_type;
                vc.Train_train_date = self.train_date;
                vc.Train_is_accept_standing = model.is_accept_standing;
                
                
                [self.navigationController pushViewController:vc animated:NO];
                
                self.navigationController.navigationBar.hidden=YES;
                
            }else{
                
                
                [TrainToast showWithText:dic[@"message"] duration:2.0f];
            }
            
            
            
            [hud dismiss:YES];
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [hud dismiss:YES];
        
        NSLog(@"%@",error);
        
        
    }];
    
    
}

//登录返回代理
-(void)LoginToBackCrat:(NSString *)sigen
{
    
    self.sigen = sigen;
    [KNotificationCenter postNotificationName:@"login" object:nil];
    
}

-(void)QurtBtnClick
{
    
    
    [self.navigationController popViewControllerAnimated:NO];
    
}

@end
