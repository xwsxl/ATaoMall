//
//  TrainViewController.m
//  aTaohMall
//
//  Created by JMSHT on 2017/5/11.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "TrainViewController.h"

#import "TrainSelectStationViewController.h"
#import "TrainSelectDateViewController.h"

#import "SelectDateViewController.h"

#import "CalendarHomeViewController.h"
#import "CalendarViewController.h"
//#import "CalendarDayModel.h"
#import "Color.h"
#import "TrainNumberViewController.h"
#import "TrainToast.h"
//MapKit是原生地图框架
#import <MapKit/MapKit.h>
#import "RecordAirManger.h"
//CoreLocation是定位框架
#import <CoreLocation/CoreLocation.h>

#import "AFNetworking.h"
#import "BianMinModel.h"
#import "ConverUtil.h"
#import "DESUtil.h"
#import "SecretCodeTool.h"

@interface TrainViewController ()<TrainSelectStationDelegate,MKMapViewDelegate, CLLocationManagerDelegate>
{
    
    SelectDateViewController *chvc;
    
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
    
    //地图View
    MKMapView *_mapView;
    
    //定位管理器
    CLLocationManager *_locationManager;
    
    UIView *recordView;//搜索记录
    
    UIScrollView *_scrollView;
    
    NSMutableArray *_WeekArrM;
    
    UIView *NameView;
    
    UIImageView *line;
    
    UIImageView *line1;
    UIView *TimeView;
    UIImageView *line2;
    UIView *LookView;
    
    NSString *codeStr;
    NSString *codeStr2;
    
}

@property(nonatomic,strong)NSMutableArray *myArrM;

@property(nonatomic,strong)NSMutableArray *ArrM;

@property (nonatomic,strong)NSArray *myArray;//搜索记录的数组

@end

@implementation TrainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
   
    _myArrM=[NSMutableArray new];
    
    _ArrM = [NSMutableArray new];
    
    _WeekArrM = [NSMutableArray new];
    
    
    self.to_station = @"";
    self.from_station = @"";
    
     [self readNSUserDefaults];
    
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    self.view.backgroundColor=[UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1.0];
    
    [self initNameView];
    
    [self initTimeView];
    
    
    [self getData];
    
    
//    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
//    
//    NSDateComponents *comps = [[NSDateComponents alloc] init];
//    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
//    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
//    int addDays = 1;
//    NSDateFormatter *dateFormatter = [NSDateFormatter new];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
//    NSDate *myDate = [dateFormatter dateFromString:[self getTadayTime]];
//    NSDate *newDate = [myDate dateByAddingTimeInterval:60 * 60 * 24 * addDays];
//    comps = [calendar components:unitFlags fromDate:newDate];
//    
////    NSLog(@"-----------weekday is %d",[comps weekday]);//在这里需要注意的是：星期日是数字1，星期一时数字2，以此类推。。。
//    
//    if ([comps weekday] == 1) {
//        
//        self.Week = [NSString stringWithFormat:@"周日"];
//    }else if ([comps weekday] == 2){
//        
//        self.Week = [NSString stringWithFormat:@"周一"];
//    }else if ([comps weekday] == 3){
//        
//        self.Week = [NSString stringWithFormat:@"周二"];
//    }else if ([comps weekday] == 4){
//        
//        self.Week = [NSString stringWithFormat:@"周三"];
//    }else if ([comps weekday] == 5){
//        
//        self.Week = [NSString stringWithFormat:@"周四"];
//    }else if ([comps weekday] == 6){
//        
//        self.Week = [NSString stringWithFormat:@"周五"];
//    }else if ([comps weekday] == 7){
//        
//        self.Week = [NSString stringWithFormat:@"周六"];
//    }
    
    
//    self.Date = [NSString stringWithFormat:@"05月12日"];
    
    //创建地图View
    _mapView = [[MKMapView alloc] init];

    //设置代理
    _mapView.delegate = self;


    //定位
    _locationManager = [[CLLocationManager alloc] init];

    //设置代理,通过代理方法接收自己的位置
    _locationManager.delegate = self;


    //启动定位
    [_locationManager startUpdatingLocation];

}


-(void)getData
{
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@getTrainBuyTicketTime_mob.shtml",URL_Str];
    
    NSDictionary *dict = nil;
    
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
            
            
            
            
            if ([dic[@"status"] isEqualToString:@"10000"]) {
                
                NameView.frame = CGRectMake(0, 70-65, [UIScreen mainScreen].bounds.size.width, 50);
                line.frame = CGRectMake(0, 120, [UIScreen mainScreen].bounds.size.width, 1);
                TimeView.frame = CGRectMake(0, 121-65, [UIScreen mainScreen].bounds.size.width, 50);
                line1.frame = CGRectMake(0, 171-65, [UIScreen mainScreen].bounds.size.width, 1);
                line2.frame = CGRectMake(0, 250-65, [UIScreen mainScreen].bounds.size.width, 1);
                recordView.frame = CGRectMake(0, 251-65, [UIScreen mainScreen].bounds.size.width, 33);
                LookView.frame = CGRectMake(0, 172-65, [UIScreen mainScreen].bounds.size.width, 78);
                
                
            }else{
                
                
                UIView *Notice = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 40)];
                Notice.backgroundColor = [UIColor colorWithRed:63/255.0 green:139/255.0 blue:253/255.0 alpha:1.0];
                [self.view addSubview:Notice];
                
                UIImageView *Iimg = [[UIImageView alloc] initWithFrame:CGRectMake(15, 5, 13, 13)];
                Iimg.image = [UIImage imageNamed:@"提示712"];
                [Notice addSubview:Iimg];
                
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(35, 0, [UIScreen mainScreen].bounds.size.width-70, 40)];
                label.text = [NSString stringWithFormat:@"%@",dic[@"message"]];
                label.numberOfLines = 2;
                label.textColor = [UIColor whiteColor];
                label.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
                [Notice addSubview:label];
                
                NameView.frame = CGRectMake(0, 70-65+40-5, [UIScreen mainScreen].bounds.size.width, 50);
                line.frame = CGRectMake(0, 120+40-5, [UIScreen mainScreen].bounds.size.width, 1);
                TimeView.frame = CGRectMake(0, 121-65+40-5, [UIScreen mainScreen].bounds.size.width, 50);
                line1.frame = CGRectMake(0, 171-65+40-5, [UIScreen mainScreen].bounds.size.width, 1);
                line2.frame = CGRectMake(0, 250-65+40-5, [UIScreen mainScreen].bounds.size.width, 1);
                recordView.frame = CGRectMake(0, 251-65+40-5, [UIScreen mainScreen].bounds.size.width, 33);
                LookView.frame = CGRectMake(0, 172-65+40-5, [UIScreen mainScreen].bounds.size.width, 78);
                
            }
          
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NameView.frame = CGRectMake(0, 70-65, [UIScreen mainScreen].bounds.size.width, 50);
        line.frame = CGRectMake(0, 120, [UIScreen mainScreen].bounds.size.width, 1);
        TimeView.frame = CGRectMake(0, 121-65, [UIScreen mainScreen].bounds.size.width, 50);
        line1.frame = CGRectMake(0, 171-65, [UIScreen mainScreen].bounds.size.width, 1);
        line2.frame = CGRectMake(0, 250-65, [UIScreen mainScreen].bounds.size.width, 1);
        recordView.frame = CGRectMake(0, 251-65, [UIScreen mainScreen].bounds.size.width, 33);
        LookView.frame = CGRectMake(0, 172-65, [UIScreen mainScreen].bounds.size.width, 78);
        NSLog(@"%@",error);
        
    }];

}

-(void)TrainSelectStation:(NSString *)name Type:(NSString *)type Code:(NSString *)code
{
    NSLog(@"=====%@===%@===%@",name,type,code);
    UILabel *lab=[self.view viewWithTag:1111];
    UILabel *lab2=[self.view viewWithTag:2222];
    if ([type isEqualToString:@"1"]) {
        
        lab.text = name;
        codeStr=code;
       // self.from_station = code;
        
    }else{
        
        lab2.text = name;
        codeStr2=code;
       // self.to_station = code;
        
    }
    
}


-(void)initNameView
{
    
    NameView = [[UIView alloc] init];
    NameView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:NameView];
    
    StartLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 100, 20)];
    StartLabel.text = @"深圳";
    StartLabel.tag=1111;
    StartLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    StartLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:18];
    [NameView addSubview:StartLabel];
    
    UIButton *StartButton = [UIButton buttonWithType:UIButtonTypeCustom];
    StartButton.frame = CGRectMake(0, 0, 115, 50);
    [StartButton addTarget:self action:@selector(StartBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [NameView addSubview:StartButton];
    
    UIButton *WFButton = [UIButton buttonWithType:UIButtonTypeCustom];
    WFButton.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width-22)/2, (50-22)/2, 22, 22);
    [WFButton setImage:[UIImage imageNamed:@"往返"] forState:0];
    [WFButton addTarget:self action:@selector(WFBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [NameView addSubview:WFButton];
    
    EndLabel = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-117, 15, 100, 20)];
    EndLabel.text = @"请选择";
    EndLabel.tag=2222;
    EndLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    EndLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:18];
    EndLabel.textAlignment = NSTextAlignmentRight;
    [NameView addSubview:EndLabel];
    
    
    if (_ArrM.count > 0) {
        
        NSString *name = _ArrM[0];
        NSArray *arrray = [name componentsSeparatedByString:@"-"];
        UILabel *lab=[self.view viewWithTag:1111];
        lab.text = [NSString stringWithFormat:@"%@",arrray[0]];
        UILabel *lab2=[self.view viewWithTag:2222];
        lab2.text = [NSString stringWithFormat:@"%@",arrray[1]];
    }
    
    UIButton *EndButton = [UIButton buttonWithType:UIButtonTypeCustom];
    EndButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-117, 0, 117, 50);
    [EndButton addTarget:self action:@selector(EndBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [NameView addSubview:EndButton];
    
    line = [[UIImageView alloc] init];
    
    line.image = [UIImage imageNamed:@"分割线-拷贝"];
    
    [self.view addSubview:line];
    
}


-(void)initTimeView
{
    
    TimeView = [[UIView alloc] init];
    TimeView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:TimeView];
    
    int addDays = 1;
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *myDate = [dateFormatter dateFromString:[self getTadayTime]];
    NSDate *newDate = [myDate dateByAddingTimeInterval:60 * 60 * 24 * addDays];
    NSLog(@"===火车票计算日期==%@",[dateFormatter stringFromDate:newDate]);
    
    self.GoDateString = [dateFormatter stringFromDate:newDate];
    
    NSArray *DateArray = [self.GoDateString componentsSeparatedByString:@"-"];
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    
    NSLog(@"==火车票缓存日期==%@",[userDefaultes stringForKey:@"TrainDate"]);
    
    DateLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 100, 20)];
    
  //  if ([userDefaultes stringForKey:@"TrainDate"].length == 0) {
        
        DateLabel.text = [NSString stringWithFormat:@"%@月%@日",DateArray[1],DateArray[2]];
        
        self.train_date = [NSString stringWithFormat:@"%@-%@-%@",DateArray[0],DateArray[1],DateArray[2]];
        
//    }
//    else
//    {
//        
//        NSString *string = [userDefaultes stringForKey:@"TrainDate"];
//    
//        DateLabel.text = string;
//        
//        self.Week = [userDefaultes stringForKey:@"TrainWeek"];
//        
//        NSString *start = [string stringByReplacingOccurrencesOfString:@"月" withString:@"-"];
//        NSString *start1 = [start stringByReplacingOccurrencesOfString:@"日" withString:@""];
//        
//        self.GoDateString = [NSString stringWithFormat:@"%@-%@",DateArray[0],start1];
//        
//        self.train_date = [NSString stringWithFormat:@"%@-%@",DateArray[0],start1];
//
//        NSLog(@"===self.StartTimeString===%@",self.GoDateString);
//        
//    }
    
    
    
    DateLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    DateLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    [TimeView addSubview:DateLabel];
    
    UIImageView *logoImgView = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-30, (50-15)/2, 15, 15)];
    logoImgView.image = [UIImage imageNamed:@"iconfont-enter111"];
    
    [TimeView addSubview:logoImgView];
    
    UIButton *DateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    DateButton.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 50);
    [DateButton addTarget:self action:@selector(DateBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [TimeView addSubview:DateButton];
    
    line1 = [[UIImageView alloc] init];
    line1.image = [UIImage imageNamed:@"分割线-拷贝"];
    [self.view addSubview:line1];
    
    LookView = [[UIView alloc] init];
    LookView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:LookView];

    UIView *PayView = [[UIView alloc] initWithFrame:CGRectMake(15, 20, [UIScreen mainScreen].bounds.size.width-30, 38)];
    PayView.layer.cornerRadius = 3;
    PayView.layer.masksToBounds = YES;
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)[UIColor colorWithRed:255/255.0 green:52/255.0 blue:90/255.0 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0].CGColor];
    gradientLayer.locations = @[@0.0, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1.0);
    gradientLayer.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width-30, 38);
    [PayView.layer addSublayer:gradientLayer];
    
    [LookView addSubview:PayView];
    
    UIButton *Pay = [UIButton buttonWithType:UIButtonTypeCustom];
    Pay.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width-30, 38);
    Pay.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:15];
    [Pay addTarget:self action:@selector(PayBtnCLick) forControlEvents:UIControlEventTouchUpInside];
    [Pay setTitle:@"查询" forState:0];
    Pay.layer.cornerRadius = 3;
    Pay.layer.masksToBounds = YES;
    [Pay setTitleColor:[UIColor whiteColor] forState:0];
    [PayView addSubview:Pay];
    
    line2 = [[UIImageView alloc] init];
    line2.image = [UIImage imageNamed:@"分割线-拷贝"];
    [self.view addSubview:line2];
    
    recordView = [[UIView alloc] init];
    recordView.backgroundColor=[UIColor whiteColor];
    
    [self.view addSubview:recordView];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 33)];
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    [recordView addSubview:_scrollView];
    
    _scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width/2*_ArrM.count, 33);
    
    [self initRecordView];

}

-(void)initRecordView
{
    recordView.hidden=NO;
    NSInteger Weight = [UIScreen mainScreen].bounds.size.width/5;
    
    CGSize size = CGSizeMake(20, 33);
    
    CGFloat padding = 20.0;
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    for (UIView *view1 in _scrollView.subviews) {
    
        [view1 removeFromSuperview];
    
    }
    
    for (NSString *name in _ArrM) {
    
        NSLog(@"火车票选择车站===%@",name);
        
    }
    
    if (_ArrM.count > 0) {
        recordView.backgroundColor=[UIColor whiteColor];
        for (int i =0; i < _ArrM.count; i++) {
            
            UIButton *name = [UIButton buttonWithType:UIButtonTypeCustom];
            
            CGFloat keyWorldWidth = [self getSizeByString:_ArrM[i] AndFontSize:12].width;
            if (keyWorldWidth > width) {
                keyWorldWidth = width;
            }
            
            name.frame = CGRectMake(size.width, 0, keyWorldWidth, 33);
            [name setTitle:_ArrM[i] forState:0];
            [name setTitleColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0] forState:0];
            name.tag = 100+i;
            name.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
            [name addTarget:self action:@selector(NAmeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [_scrollView addSubview:name];
            
            
            size.width += keyWorldWidth+padding;
            
            if (i == _ArrM.count-1) {
                UIButton *DeleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
                DeleteButton.frame = CGRectMake(size.width, 0, Weight, 33);
                [DeleteButton setTitle:@"清除" forState:0];
                [DeleteButton setTitleColor:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0] forState:0];
                DeleteButton.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
                [DeleteButton addTarget:self action:@selector(DeleteBtnClick) forControlEvents:UIControlEventTouchUpInside];
                [_scrollView addSubview:DeleteButton];
                size.width+=Weight+20;
            }
        }
    }else{
        recordView.backgroundColor=[UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1.0];
    }
    _scrollView.contentSize = size;
}


//计算文字所占大小
- (CGSize)getSizeByString:(NSString*)string AndFontSize:(CGFloat)font
{
    CGSize size = [string boundingRectWithSize:CGSizeMake(999, 25) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFang-SC-Regular" size:font]} context:nil].size;
    //    size.width += 5;
    return size;
}

-(void)NAmeBtnClick:(UIButton *)sender
{
    
    int addDays = 1;
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *myDate = [dateFormatter dateFromString:[self getTadayTime]];
    NSDate *newDate = [myDate dateByAddingTimeInterval:60 * 60 * 24 * addDays];
    NSLog(@"===火车票计算日期==%@",[dateFormatter stringFromDate:newDate]);
    
    NSArray *DateArray = [[dateFormatter stringFromDate:newDate] componentsSeparatedByString:@"-"];
    
    NSString *start = [DateLabel.text stringByReplacingOccurrencesOfString:@"月" withString:@"-"];
    NSString *start1 = [start stringByReplacingOccurrencesOfString:@"日" withString:@""];
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"]; // 年-月-日 时:分:秒
    // 这个格式可以随便定义,比如：@"yyyy,MM,dd,HH,mm,ss"
    NSString * dateStr = [NSString stringWithFormat:@"%@-%@",DateArray[0],start1];
    
    NSDate * date = [formatter dateFromString:dateStr];
    NSLog(@"the date = %@",date);
    
    
    NSCalendar * calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar]; // 指定日历的算法 NSCalendarIdentifierGregorian,NSGregorianCalendar
    // NSDateComponent 可以获得日期的详细信息，即日期的组成
    NSDateComponents *comps = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit|NSWeekCalendarUnit|NSWeekdayCalendarUnit fromDate:date];
    
    NSLog(@"星期 =weekDay = %ld ",comps.weekday);
    if ([comps weekday] == 1) {
        
        self.Week = [NSString stringWithFormat:@"周日"];
    }else if ([comps weekday] == 2){
        
        self.Week = [NSString stringWithFormat:@"周一"];
    }else if ([comps weekday] == 3){
        
        self.Week = [NSString stringWithFormat:@"周二"];
    }else if ([comps weekday] == 4){
        
        self.Week = [NSString stringWithFormat:@"周三"];
    }else if ([comps weekday] == 5){
        
        self.Week = [NSString stringWithFormat:@"周四"];
    }else if ([comps weekday] == 6){
        
        self.Week = [NSString stringWithFormat:@"周五"];
    }else if ([comps weekday] == 7){
        
        self.Week = [NSString stringWithFormat:@"周六"];
    }
    
    NSString *string = _ArrM[sender.tag-100];
    
    NSLog(@"=====%@",string);
    
    NSArray *array = [string componentsSeparatedByString:@"-"];
    
    TrainNumberViewController *vc = [[TrainNumberViewController alloc] init];
    
    vc.Start = [NSString stringWithFormat:@"%@",array[0]];
    vc.End = [NSString stringWithFormat:@"%@",array[1]];
    vc.Date = DateLabel.text;
    vc.Week = self.Week;
    vc.delegate=self;
    vc.train_date = self.train_date;
    vc.from_station = @"";
    vc.from_city = [NSString stringWithFormat:@"%@",array[0]];
    vc.to_station = @"";
    vc.to_city = [NSString stringWithFormat:@"%@",array[1]];
    UILabel *lab=[self.view viewWithTag:1111];
    UILabel *lab2=[self.view viewWithTag:2222];
    lab.text=vc.from_city;
    lab2.text=vc.to_city;
    [self.navigationController pushViewController:vc animated:NO];
    
    self.navigationController.navigationBar.hidden=YES;
    
    
    
}

//#pragma Mark - 查询记录代理
//-(void)TrainRecordReloadData
//{
//    
//    [self initRecordView];
//    recordView.backgroundColor=[UIColor whiteColor];
//    recordView.hidden=NO;
//}
- (NSString *)getTadayTime {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    return dateTime;
}

//往返
-(void)WFBtnClick:(UIButton *)sender
{
    
    NSLog(@"往返");
    [UIView animateWithDuration:0.5 animations:^{
        CGPoint point=StartLabel.center;
        StartLabel.center=EndLabel.center;
        EndLabel.center=point;
        NSInteger temp=StartLabel.tag;
        StartLabel.tag=EndLabel.tag;
        EndLabel.tag=temp;
        UILabel *lab=[self.view viewWithTag:1111];
        UILabel *lab2=[self.view viewWithTag:2222];
        lab.textAlignment=NSTextAlignmentLeft;
        lab2.textAlignment=NSTextAlignmentRight;
        if (!codeStr) {
            codeStr=self.from_station;
        }
        if (!codeStr2) {
            codeStr2=self.to_station;
        }
        NSString *str=codeStr;
        codeStr=codeStr2;
        codeStr2=str;
        
        
    } completion:nil];
    CABasicAnimation *animation =  [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    //默认是顺时针效果，若将fromValue和toValue的值互换，则为逆时针效果
    animation.fromValue = [NSNumber numberWithFloat:0.f];
    animation.toValue =  [NSNumber numberWithFloat: M_PI ];
    animation.duration  = 0.5;
    animation.autoreverses = NO;
    animation.fillMode =kCAFillModeForwards;
    animation.repeatCount = 1; //如果这里想设置成一直自旋转，可以设置为MAXFLOAT，否则设置具体的数值则代表执行多少次
    [sender.layer addAnimation:animation forKey:nil];
    
    //    NSString *string1 = StartLabel.text;
//    NSString *string2 = EndLabel.text;
//
//    StartLabel.text = string2;
//    EndLabel.text = string1;
//    CGRect rect1=StartLabel.frame;
//    CGRect rect2=EndLabel.frame;
//    StartLabel.frame=rect2;
//    EndLabel.frame=rect1;
//    
//    
//    self.to_station = @"";
//    
//    self.from_station = @"";
//    
    
}

//起始
-(void)StartBtnClick
{
    
    NSLog(@"起始");
    
    TrainSelectStationViewController *vc = [[TrainSelectStationViewController alloc] init];
    vc.delegate=self;
    vc.Type = @"1";
    [self.navigationController pushViewController:vc animated:NO];
    
    self.navigationController.navigationBar.hidden=YES;
    
}
//目的地
-(void)EndBtnClick
{
    NSLog(@"目的地");
    
    TrainSelectStationViewController *vc = [[TrainSelectStationViewController alloc] init];
    vc.delegate=self;
    vc.Type = @"2";
    [self.navigationController pushViewController:vc animated:NO];
    
    self.navigationController.navigationBar.hidden=YES;
    
}
//日期选择
-(void)DateBtnClick
{
    NSLog(@"日期选择");
    
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
        DateLabel.text = [NSString stringWithFormat:@"%@",self.Date];
        
        if (model.holiday) {
        
            
        }else{
            
            
        }
    };

    
    
    [self.navigationController pushViewController:vc animated:NO];
    
    self.navigationController.navigationBar.hidden=YES;
    

}

//查询
-(void)PayBtnCLick
{
    UILabel *lab=[self.view viewWithTag:1111];
    UILabel *lab2=[self.view viewWithTag:2222];
    if ([lab.text isEqualToString:@"请选择"]) {
        
        [TrainToast showWithText:@"请选择出发站" duration:2.0f];
        
    }else{
        
        if ([lab2.text isEqualToString:@"请选择"]) {
            
            [TrainToast showWithText:@"请选择到达站" duration:2.0f];
            
        }else{
            
            
            if ([lab.text isEqualToString:lab2.text]) {
                
                [TrainToast showWithText:@"出发站与到达站不能相同" duration:2.0f];
                
            }else{
                
                
                
                int addDays = 1;
                NSDateFormatter *dateFormatter = [NSDateFormatter new];
                [dateFormatter setDateFormat:@"yyyy-MM-dd"];
                NSDate *myDate = [dateFormatter dateFromString:self.train_date];
                NSDate *newDate = [myDate dateByAddingTimeInterval:60 * 60 * 24 * addDays];
                NSLog(@"===火车票计算日期==%@",[dateFormatter stringFromDate:newDate]);
                
                NSArray *DateArray = [[dateFormatter stringFromDate:newDate] componentsSeparatedByString:@"-"];
                
                NSString *start = [DateLabel.text stringByReplacingOccurrencesOfString:@"月" withString:@"-"];
                NSString *start1 = [start stringByReplacingOccurrencesOfString:@"日" withString:@""];
                
                NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yyyy-MM-dd"]; // 年-月-日 时:分:秒
                // 这个格式可以随便定义,比如：@"yyyy,MM,dd,HH,mm,ss"
                NSString * dateStr = [NSString stringWithFormat:@"%@-%@",DateArray[0],start1];
                
                NSDate * date = [formatter dateFromString:dateStr];
                NSLog(@"the date = %@",date);
                
                
                NSCalendar * calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar]; // 指定日历的算法 NSCalendarIdentifierGregorian,NSGregorianCalendar
                // NSDateComponent 可以获得日期的详细信息，即日期的组成
                NSDateComponents *comps = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit|NSWeekCalendarUnit|NSWeekdayCalendarUnit fromDate:date];
                
                NSLog(@"星期 =weekDay = %ld ",comps.weekday);
                if ([comps weekday] == 1) {
                    
                    self.Week = [NSString stringWithFormat:@"周日"];
                }else if ([comps weekday] == 2){
                    
                    self.Week = [NSString stringWithFormat:@"周一"];
                }else if ([comps weekday] == 3){
                    
                    self.Week = [NSString stringWithFormat:@"周二"];
                }else if ([comps weekday] == 4){
                    
                    self.Week = [NSString stringWithFormat:@"周三"];
                }else if ([comps weekday] == 5){
                    
                    self.Week = [NSString stringWithFormat:@"周四"];
                }else if ([comps weekday] == 6){
                    
                    self.Week = [NSString stringWithFormat:@"周五"];
                }else if ([comps weekday] == 7){
                    
                    self.Week = [NSString stringWithFormat:@"周六"];
                }
                
                
                NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
                NSArray * myArray = [userDefaultes arrayForKey:@"Train"];
                UILabel *lab=[self.view viewWithTag:1111];
                UILabel *lab2=[self.view viewWithTag:2222];
                NSString *name = [NSString stringWithFormat:@"%@-%@",lab.text,lab2.text];
                
                
                //记录不相等，缓存
                if (![myArray containsObject:name] && name.length!=0) {
                    
                    [RecordAirManger SearchTrain:[NSString stringWithFormat:@"%@-%@",lab.text,lab2.text]];//缓存搜索记录
                    [self readNSUserDefaults];
                    [self initRecordView];
                }else
                {
                    [RecordAirManger SearchTrainwithRepeat:[NSString stringWithFormat:@"%@-%@",lab.text,lab2.text]];
                    [self readNSUserDefaults];
                    [self initRecordView];
                }
            
                
                //缓存查询日期
                [RecordAirManger TrainDate:DateLabel.text Week:self.Week];
                
                
                TrainNumberViewController *vc = [[TrainNumberViewController alloc] init];
                
                vc.Start = lab.text;
                vc.End = lab2.text;
                vc.Date = DateLabel.text;
                vc.Week = self.Week;
               // vc.delegate = self;
                vc.train_date = self.train_date;
               NSLog(@"code====from=%@,to=%@",codeStr,codeStr2);
//                vc.from_station = self.from_station;
//                vc.to_station = self.to_station;
                if (!codeStr) {
                    codeStr=self.from_station;
                }
                if (!codeStr2) {
                    codeStr2=self.to_station;
                }
                vc.from_station = codeStr;
                vc.to_station = codeStr2;
                
                
                
                vc.from_city = lab.text;
                
                vc.to_city = lab2.text;
                
                [self.navigationController pushViewController:vc animated:NO];
                
                self.navigationController.navigationBar.hidden=YES;
                
            }
        }
    }
}
//删除
-(void)DeleteBtnClick
{
    [_ArrM removeAllObjects];
    [RecordAirManger TrainremoveAllArray];
  //  [recordView removeFromSuperview];
    recordView.hidden=YES;
    [self initRecordView];
    
}



#pragma  mark - CLLocationManagerDelegate
//定位成功
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    [_locationManager requestWhenInUseAuthorization];

    NSLog(@"火车票定位成功!");
    
    //获取到定位的位置信息
    CLLocation *location = [locations firstObject];
    
    //定位到的当前坐标
    CLLocationCoordinate2D coordinate = location.coordinate;
    
    //    NSLog(@"(%f, %f)", coordinate.latitude, coordinate.longitude);
    
    
    _mapView.centerCoordinate = CLLocationCoordinate2DMake(coordinate.latitude, coordinate.longitude);
    
    
    //反地理编码(逆地理编码): 将位置信息转换成地址信息
    //地理编码: 把地址信息转换成位置信息
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    
    //反地理编码
    //尽量不要一次性调用很多次
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        UILabel *lab=[self.view viewWithTag:1111];
        UILabel *lab2=[self.view viewWithTag:2222];
        if (error) {
            NSLog(@"火车票反地理编码失败!%@",error);
            
            lab.text = @"深圳";
            
            return ;
        }
        
        //地址信息
        CLPlacemark *placemark = [placemarks firstObject];
        NSString *country = placemark.country;
        NSString *administrativeArea = placemark.administrativeArea;
        NSString *subLocality = placemark.subLocality;
        NSString *name = placemark.name;
        NSString *city = placemark.locality;
        
        NSLog(@"======火车票==%@ %@ %@ %@ %@", country, administrativeArea, city,subLocality, name);
        
        NSArray *array = [city componentsSeparatedByString:@"市"];
        
        lab.text = [NSString stringWithFormat:@"%@",array[0]];
        
        
        if (_ArrM.count==0) {
            
            
        }else{
            
            NSArray *array1 = [_ArrM[0] componentsSeparatedByString:@"-"];
            
            lab.text = [NSString stringWithFormat:@"%@",array1[0]];
            
            lab2.text = [NSString stringWithFormat:@"%@",array1[1]];
            
            
        }
        
        
    }];
    
    
    //停止定位
    [_locationManager stopUpdatingLocation];
    
    
}

-(void)readNSUserDefaults{//取出缓存的数据
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数组NSArray类型的数据
    NSArray * myArray = [userDefaultes arrayForKey:@"Train"];
    //    self.myArray = myArray;
    //
    //    for (NSString *str in self.myArray) {
    //        [_deleteArrM addObject:str];
    //    }
    //
    //    [self.myTableView reloadData];
    
    [_ArrM removeAllObjects];
    
    _myArray = myArray;
    
    for (NSString *name in myArray) {
        
        NSLog(@"==name==%@",name);
        
    }
    
    NSLog(@"myArray======%@====_myArray==%@",myArray,_myArray);
    
    if (myArray.count <= 4) {
        
        for (int i =(int)myArray.count-1; i >=0; i--) {
            
            [_ArrM addObject:myArray[i]];
            
        }
    }else{
        
        for (int i =(int)myArray.count-1; i >=myArray.count-4; i--) {
            
            [_ArrM addObject:myArray[i]];
            
        }
    }
    
    
    for (NSString *name in _ArrM) {
        
        NSLog(@"==_ArrM==%@",name);
    }
}

-(void)QurtBtnClick{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    self.tabBarController.tabBar.hidden=NO;
}
@end
