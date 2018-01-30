//
//  AeroplaneViewController.m
//  aTaohMall
//
//  Created by JMSHT on 2017/5/11.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "AeroplaneViewController.h"
#import "TrainSelectStationViewController.h"
#import "RecordAirManger.h"
#import "JRToast.h"
#import "AirPlaneDateSelectViewController.h"
#import "AirPlaneSelectCityViewController.h"
#import "AirPlaneViewController.h"
#import "TrainToast.h"

#import "AFNetworking.h"
#import "BianMinModel.h"
#import "ConverUtil.h"
#import "DESUtil.h"
#import "SecretCodeTool.h"

#import "WKProgressHUD.h"

//MapKit是原生地图框架
#import <MapKit/MapKit.h>

//CoreLocation是定位框架
#import <CoreLocation/CoreLocation.h>

#import "Masonry.h"
@interface AeroplaneViewController ()<AirPlaneSelectStationDelegate,MKMapViewDelegate, CLLocationManagerDelegate>
{
    UIImageView *logoImgView;
    UILabel *StartName;
    UILabel *EndName;
    UIView *recordView;
    UILabel *EndTime;
    UILabel *EndTimeLabel;
    UILabel *one;
    UILabel *two;
    //地图View
    MKMapView *_mapView;
    
    //定位管理器
    CLLocationManager *_locationManager;
    
    UILabel *StartTimeLabel;
    
    UIImageView *redImg2;
    UIImageView *redImg1;
    
    NSMutableArray *_WeekArrM;
    
    UIImageView *ManImg;
    UIImageView *KidsImg;
    
    UIButton *Gobutton;
    UIButton *NewGobutton;
    UIButton *Backbutton;
    NSString *codeStr;
    NSString *codeStr2;
}

@property(nonatomic,strong)NSMutableArray *myArrM;

@property(nonatomic,strong)NSMutableArray *ArrM;

@property (nonatomic,strong)NSArray *myArray;//搜索记录的数组

@end

@implementation AeroplaneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _myArrM=[NSMutableArray new];
    
    _ArrM = [NSMutableArray new];
    
    _WeekArrM = [NSMutableArray new];
                 
    self.view.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1.0];
    
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    
    NSLog(@"==缓存日期==%@===%@",[userDefaultes stringForKey:@"AirDate"],[userDefaultes stringForKey:@"endDate"]);
    
    
   
    [self readNSUserDefaults];
    
//    [self initNav];
    
    [self initOtherView];
    
    [self getDatas];
    
    //创建地图View
    _mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 65, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-65)];
    
    //    [self.view addSubview:_mapView];
    
    //中心坐标点
    //CL开头:CoreLocation框架中的
    CLLocationCoordinate2D centerCoordinate = CLLocationCoordinate2DMake(22.541476, 113.951361);
    
    
    //缩放系数,参数越小,放得越大
    MKCoordinateSpan span = MKCoordinateSpanMake(0.01, 0.01);
    
    //区域
    MKCoordinateRegion region = MKCoordinateRegionMake(centerCoordinate, span);
    
    //设置地图的显示区域
    [_mapView setRegion:region animated:YES];
    
    //设置中心坐标(缩放系数不变)
    //    _mapView.centerCoordinate = CLLocationCoordinate2DMake(22.541476, 113.951361);
    
    
    //设置代理
    _mapView.delegate = self;
    
    /*
     MKMapTypeStandard = 0, //标准地图
     MKMapTypeSatellite,  //卫星地图
     MKMapTypeHybrid      //混合地图
     */
    _mapView.mapType = MKMapTypeStandard;
    
    //是否能缩放
    _mapView.zoomEnabled = YES;
    
    //是否能移动
    _mapView.scrollEnabled = YES;
    
    //是否能旋转
    _mapView.rotateEnabled = NO;
    
    //是否显示自己的位置
    _mapView.showsUserLocation = YES;
    
    
    //定位
    _locationManager = [[CLLocationManager alloc] init];
    
    //设置代理,通过代理方法接收自己的位置
    _locationManager.delegate = self;
    
    //iOS8.0的定位
//    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0 ) {
//        [_locationManager requestAlwaysAuthorization];
//        [_locationManager requestWhenInUseAuthorization];
//    }
    
    //启动定位
    [_locationManager startUpdatingLocation];
    
    
    
    
}

-(void)AirPlaneSelectStation:(NSString *)name City_Code:(NSString *)code Type:(NSString *)type
{
    NSLog(@"=====%@===%@=code=%@",name,type,code);
    UILabel *lab=[self.view viewWithTag:1111];
    UILabel *lab2=[self.view viewWithTag:2222];
    
    if ([type isEqualToString:@"1"]) {
        
        lab.text = name;
        codeStr=code;
    }else{
        
        lab2.text = name;
        codeStr2=code;
    }
    
    
    
    
}


-(void)readNSUserDefaults{//取出缓存的数据
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数组NSArray类型的数据
    NSArray * myArray = [userDefaultes arrayForKey:@"Air"];
  //  [kUserDefaults removeObjectForKey:@"Air"];
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



-(void)initOtherView
{
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 65+6-65, [UIScreen mainScreen].bounds.size.width, 44)];
    topView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:topView];
    
    one = [[UILabel alloc] initWithFrame:CGRectMake(0, 12, [UIScreen mainScreen].bounds.size.width/2, 20)];
    one.text = @"单程";
    one.textColor = [UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
    one.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15];
    one.textAlignment = NSTextAlignmentCenter;
    [topView addSubview:one];
    
    
    redImg1= [[UIImageView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width/2-40)/2, 42, 40, 2)];
    redImg1.image = [UIImage imageNamed:@"icon-underline"];
    [topView addSubview:redImg1];
    
    UIButton *Onebutton = [UIButton buttonWithType:UIButtonTypeCustom];
    Onebutton.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width/2, 44);
    [Onebutton addTarget:self action:@selector(OneBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:Onebutton];
    
    two = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2, 12, [UIScreen mainScreen].bounds.size.width/2, 20)];
    two.text = @"往返";
    two.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    two.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15];
    two.textAlignment = NSTextAlignmentCenter;
    [topView addSubview:two];
    
//    redImg2= [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2+([UIScreen mainScreen].bounds.size.width/2-40)/2, 42, 40, 2)];
//    redImg2.image = [UIImage imageNamed:@""];
//    [topView addSubview:redImg2];
    
    UIButton *twobutton = [UIButton buttonWithType:UIButtonTypeCustom];
    twobutton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2, 0, [UIScreen mainScreen].bounds.size.width/2, 44);
    [twobutton addTarget:self action:@selector(twoBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:twobutton];
    
    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 43, [UIScreen mainScreen].bounds.size.width, 1)];
    line.image = [UIImage imageNamed:@"分割线-拷贝"];
    [topView addSubview:line];
    
    UIView *centerView = [[UIView alloc] initWithFrame:CGRectMake(0, 65+6+44+6-65, [UIScreen mainScreen].bounds.size.width, 50)];
    centerView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:centerView];
    
    
    StartName = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 100, 20)];
//    StartName.text = @"深圳";
    StartName.tag=1111;
    StartName.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    StartName.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:18];
    [centerView addSubview:StartName];
    
    UIButton *Startbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    Startbutton.frame = CGRectMake(0, 0, 100, 50);
    [Startbutton addTarget:self action:@selector(StrartBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [centerView addSubview:Startbutton];
    
    
    EndName = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-120, 15, 100, 20)];
//    EndName.text = @"上海";
    EndName.tag=2222;
    EndName.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    EndName.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:18];
    EndName.textAlignment = NSTextAlignmentRight;
    [centerView addSubview:EndName];
    
    UIButton *Endbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    Endbutton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-100, 0, 100, 50);
    [Endbutton addTarget:self action:@selector(EndBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [centerView addSubview:Endbutton];
    
    UIButton *WFButton = [UIButton buttonWithType:UIButtonTypeCustom];
    WFButton.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width-22)/2, (50-22)/2, 22, 22);
    [WFButton setImage:[UIImage imageNamed:@"往返"] forState:0];
    [WFButton addTarget:self action:@selector(WFBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [centerView addSubview:WFButton];
    
    UIImageView *line1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 49, [UIScreen mainScreen].bounds.size.width, 1)];
    line1.image = [UIImage imageNamed:@"分割线-拷贝"];
    [centerView addSubview:line1];
    
    
    UIView *BootmView = [[UIView alloc] initWithFrame:CGRectMake(0, 65+6+44+6+50-65, [UIScreen mainScreen].bounds.size.width, 50)];
    BootmView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:BootmView];
    
    logoImgView = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-30, (50-15)/2, 15, 15)];
    logoImgView.image = [UIImage imageNamed:@"iconfont-enter111"];
    
    [BootmView addSubview:logoImgView];
    
    NSString *dateString = [self getCurrentTime];
//    NSArray *dateArray = [dateString componentsSeparatedByString:@"-"];
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    
    NSLog(@"==缓存日期==%@===%@",[userDefaultes stringForKey:@"AirDate"],[userDefaultes stringForKey:@"endDate"]);
    
    StartTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 150, 20)];
    
    if ([userDefaultes stringForKey:@"AirDate"].length == 0) {
        
        
        int addDays = 2;
        NSDateFormatter *dateFormatter = [NSDateFormatter new];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSDate *todayDate = [dateFormatter dateFromString:[self getTadayTime]];
        NSDate *newDate = [todayDate dateByAddingTimeInterval:60 * 60 * 24 * addDays];
        NSLog(@"===计算日期==%@",[dateFormatter stringFromDate:newDate]);
        
        NSString *EndString = [dateFormatter stringFromDate:newDate];
        
        NSArray *dateArray1 = [EndString componentsSeparatedByString:@"-"];
        
        
        StartTimeLabel.text = [NSString stringWithFormat:@"%@月%@日",dateArray1[1],dateArray1[2]];
        
        self.StartTimeLabelStr = [NSString stringWithFormat:@"%@-%@",dateArray1[1],dateArray1[2]];
        
        self.StartTimeString = EndString;
        
    }else{
        
        
        //获取当前时间
        NSDateFormatter *dateFormatter = [NSDateFormatter new];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSDate *todayDate = [dateFormatter dateFromString:[self getTadayTime]];
        
        
        NSString *newstr=[dateFormatter stringFromDate:todayDate];
        //获取缓存时间
        NSString *string = [userDefaultes stringForKey:@"AirDate"];
        
        if ([self compareDate:newstr withDate:string]==-1) {
            //返回-1，表示newstr>string 0相等 1表示newstr<string
            
            //默认获取两天后的时间
            int addDays = 2;
            NSDate *newDate = [todayDate dateByAddingTimeInterval:60 * 60 * 24 * addDays];
            NSLog(@"===计算日期==%@",[dateFormatter stringFromDate:newDate]);
            NSString *EndString = [dateFormatter stringFromDate:newDate];
            NSArray *array = [EndString componentsSeparatedByString:@"-"];
            StartTimeLabel.text = [NSString stringWithFormat:@"%@月%@日",array[1],array[2]];
            self.StartTimeLabelStr = [NSString stringWithFormat:@"%@-%@",array[1],array[2]];
            
            self.StartTimeString = EndString;
            
        
        }else
        {
            NSArray *arr=[string componentsSeparatedByString:@"-"];
            if (arr.count<=1) {
                int addDays = 2;
                NSDate *newDate = [todayDate dateByAddingTimeInterval:60 * 60 * 24 * addDays];
                NSLog(@"===计算日期==%@",[dateFormatter stringFromDate:newDate]);
                NSString *EndString = [dateFormatter stringFromDate:newDate];
                NSArray *array = [EndString componentsSeparatedByString:@"-"];
                StartTimeLabel.text = [NSString stringWithFormat:@"%@月%@日",array[1],array[2]];
                self.StartTimeLabelStr = [NSString stringWithFormat:@"%@-%@",array[1],array[2]];
                
                self.StartTimeString = EndString;
            }
            else
            {
            StartTimeLabel.text=[NSString stringWithFormat:@"%@月%@日",arr[1],arr[2]];
            
            self.StartTimeLabelStr = [NSString stringWithFormat:@"%@-%@",arr[1],arr[2]];
            
            self.StartTimeString=string;
            }
        }
        NSLog(@"===self.StartTimeString===%@",self.StartTimeString);
        
    }
    
    StartTimeLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    StartTimeLabel.font = [UIFont fontWithName:@"PingFang-SC-Light" size:14];
    [BootmView addSubview:StartTimeLabel];
    
    NewGobutton = [UIButton buttonWithType:UIButtonTypeCustom];
    NewGobutton.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 50);
    [NewGobutton addTarget:self action:@selector(NewGoBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [BootmView addSubview:NewGobutton];
    
    Gobutton = [UIButton buttonWithType:UIButtonTypeCustom];
    Gobutton.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width/2, 50);
    [Gobutton addTarget:self action:@selector(GoBtnClick) forControlEvents:UIControlEventTouchUpInside];
    Gobutton.hidden=YES;
    [BootmView addSubview:Gobutton];
    
    
    
    
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    
    
    EndTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-170, 15, 150, 20)];
    
    if ([userDefaultes stringForKey:@"endDate"].length ==0) {
        int addDays = 7;
        NSDate *myDate = [dateFormatter dateFromString:[self getTadayTime]];
        NSDate *newDate = [myDate dateByAddingTimeInterval:60 * 60 * 24 * addDays];
        NSLog(@"===计算日期==%@",[dateFormatter stringFromDate:newDate]);
        
        NSString *EndString = [dateFormatter stringFromDate:newDate];
        
        NSArray *dateArray1 = [EndString componentsSeparatedByString:@"-"];
        
        EndTimeLabel.text = [NSString stringWithFormat:@"%@月%@日",dateArray1[1],dateArray1[2]];
        
        self.BackDate = EndString;
        
    }else{
        
        NSString *backDateStr=[NSString stringWithFormat:@"%@",[userDefaultes stringForKey:@"endDate"]];
        
        NSArray *arr=[backDateStr componentsSeparatedByString:@"-"];


        int addDays = 7;
        NSDate *myDate = [dateFormatter dateFromString:[self getTadayTime]];
        NSDate *newDate = [myDate dateByAddingTimeInterval:60 * 60 * 24 * addDays];
        NSLog(@"===计算日期==%@",[dateFormatter stringFromDate:newDate]);

        NSString *EndString = [dateFormatter stringFromDate:newDate];

        if ([self compareDate:EndString withDate:backDateStr]==-1) {

            NSArray *dateArray1 = [EndString componentsSeparatedByString:@"-"];
            
            EndTimeLabel.text = [NSString stringWithFormat:@"%@月%@日",dateArray1[1],dateArray1[2]];
            
            self.BackDate = EndString;
        }else
        {
        
        EndTimeLabel.text =[NSString stringWithFormat:@"%@月%@日",arr[1],arr[2]];
        
        self.BackDate = backDateStr;
        }
    }
    
    EndTimeLabel.hidden=YES;
    EndTimeLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    EndTimeLabel.font = [UIFont fontWithName:@"PingFang-SC-Light" size:14];
    EndTimeLabel.textAlignment = NSTextAlignmentRight;
    [BootmView addSubview:EndTimeLabel];
    
    Backbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    Backbutton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2, 0, [UIScreen mainScreen].bounds.size.width/2, 50);
    [Backbutton addTarget:self action:@selector(BackBtnClick) forControlEvents:UIControlEventTouchUpInside];
    Backbutton.hidden=YES;
    [BootmView addSubview:Backbutton];
    
    UIImageView *line3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 49, [UIScreen mainScreen].bounds.size.width, 1)];
    line3.image = [UIImage imageNamed:@"分割线-拷贝"];
    [BootmView addSubview:line3];
    
    
    UIView *BgView = [[UIView alloc] initWithFrame:CGRectMake(0, 65+6+44+6+50+50-65, [UIScreen mainScreen].bounds.size.width, 90)];
    BgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:BgView];
    
    self.ManOrKidString = @"1";
    
    ManImg = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 13, 13)];
    ManImg.image = [UIImage imageNamed:@"btn_selected"];
    [BgView addSubview:ManImg];
    
    UILabel *ManLabel = [[UILabel alloc] initWithFrame:CGRectMake(34, 10, 97, 13)];
    ManLabel.text = @"成人(12周岁以上)";
    ManLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    ManLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    [BgView addSubview:ManLabel];
    
    UIButton *ManButton = [UIButton buttonWithType:UIButtonTypeCustom];
    ManButton.frame = CGRectMake(0, 0, 100, 23);
    [ManButton addTarget:self action:@selector(ManBtnCLick) forControlEvents:UIControlEventTouchUpInside];
    [BgView addSubview:ManButton];
    
    NSString *stringForColor1 = @"(12周岁以上)";
    
    // 创建对象.
    NSMutableAttributedString *mAttStri1 = [[NSMutableAttributedString alloc] initWithString:ManLabel.text];
    //
    NSRange range1 = [ManLabel.text rangeOfString:stringForColor1];
    
    [mAttStri1 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:12] range:range1];
    [mAttStri1 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0] range:range1];
    
    ManLabel.attributedText=mAttStri1;
    
    
    KidsImg = [[UIImageView alloc] initWithFrame:CGRectMake(156, 10, 13, 13)];
    KidsImg.image = [UIImage imageNamed:@"botton-choose-default"];
    [BgView addSubview:KidsImg];
    
    UILabel *KidLabel = [[UILabel alloc] initWithFrame:CGRectMake(174, 10, 97, 13)];
    KidLabel.text = @"儿童(2-12周岁)";
    KidLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    KidLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    [BgView addSubview:KidLabel];
    
    UIButton *KidButton = [UIButton buttonWithType:UIButtonTypeCustom];
    KidButton.frame = CGRectMake(156, 0, 100, 23);
    [KidButton addTarget:self action:@selector(KidBtnCLick) forControlEvents:UIControlEventTouchUpInside];
    [BgView addSubview:KidButton];
    
    NSString *stringForColor2 = @"(2-12周岁)";
    
    // 创建对象.
    NSMutableAttributedString *mAttStri2 = [[NSMutableAttributedString alloc] initWithString:KidLabel.text];
    //
    NSRange range2 = [KidLabel.text rangeOfString:stringForColor2];
    
    [mAttStri2 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:12] range:range2];
    [mAttStri2 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0] range:range2];
    
    KidLabel.attributedText=mAttStri2;
    
    
    UIImageView *line4 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 89, [UIScreen mainScreen].bounds.size.width, 1)];
    line4.image = [UIImage imageNamed:@"分割线-拷贝"];
    [BgView addSubview:line4];
    
    UIView *LookView = [[UIView alloc] initWithFrame:CGRectMake(0, 43, [UIScreen mainScreen].bounds.size.width, 38)];
    LookView.backgroundColor=[UIColor whiteColor];
    [BgView addSubview:LookView];
    
    UIView *PayView = [[UIView alloc] initWithFrame:CGRectMake(15, 0, [UIScreen mainScreen].bounds.size.width-30, 38)];
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
    
    recordView = [[UIView alloc] initWithFrame:CGRectMake(0, 65+6+44+6+50+50+90-65, [UIScreen mainScreen].bounds.size.width, 33)];
    recordView.backgroundColor=[UIColor whiteColor];
    
    [self.view addSubview:recordView];
    
    [self initRecordView];
    
    
    
//    if (_ArrM.count > 0) {
//        
//        for (int i = 0; i < _ArrM.count; i++) {
//            
//            if (i==0) {
//                
//                NSLog(@"==array==%@",_ArrM[i]);
//                NSArray *array = [_ArrM[i] componentsSeparatedByString:@"-"];
//                StartName.text = [NSString stringWithFormat:@"%@",array[0]];
//                EndName.text = [NSString stringWithFormat:@"%@",array[1]];
//                
//            }
//        }
//    }else{
//        
//        StartName.text = self.CityString;
//        
//    }
    
}

-(void)initRecordView
{
    [[recordView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    recordView.backgroundColor=[UIColor whiteColor];
    NSInteger Weight = [UIScreen mainScreen].bounds.size.width/5;
    
    
    UIScrollView *_scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 33)];
    
    _scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width/2*_ArrM.count, 33);
    
    [recordView addSubview:_scrollView];
    
    CGSize size = CGSizeMake(20, 33);
    
    CGFloat padding = 20.0;
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    if (_ArrM.count > 0) {
        
    
        for (int i =0; i < _ArrM.count; i++) {
            
            UIButton *name = [UIButton buttonWithType:UIButtonTypeCustom];
            
//            CGRect tempRect = [_ArrM[i] boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-100,12) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFang-SC-Regular" size:12]} context:nil];
            
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
            
//            name.frame = CGRectMake(Weight*i, 10, Weight, 12);
//            [name setTitle:_ArrM[i] forState:0];
//            [name setTitleColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0] forState:0];
//            name.tag = 100+i;
//            name.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
//            [name addTarget:self action:@selector(NAmeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//            [recordView addSubview:name];
//            
//            
//            if (i == _ArrM.count-1) {
//                
//                UIButton *DeleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
//                DeleteButton.frame = CGRectMake(Weight*_ArrM.count, 0, Weight, 33);
//                [DeleteButton setTitle:@"清除" forState:0];
//                [DeleteButton setTitleColor:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0] forState:0];
//                DeleteButton.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
//                [DeleteButton addTarget:self action:@selector(DeleteBtnClick) forControlEvents:UIControlEventTouchUpInside];
//                [recordView addSubview:DeleteButton];
//                
//                
//            }
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
    
//    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
//    //读取数组NSArray类型的数据
//    NSArray * myArray = [userDefaultes arrayForKey:@"Air"];
//
//    for (NSString *name in myArray) {
//        
//        NSLog(@"==name==%@",name);
//        
//    }
    
//    [RecordAirManger removeAllArray];
//    
//    
//    NSLog(@"=====%@",_ArrM[sender.tag-100]);
//    
//    
//    NSLog(@"===交换前==%@",_ArrM);
//    
//    [_ArrM exchangeObjectAtIndex:sender.tag-100 withObjectAtIndex:0];
//    
//    
//    NSLog(@"===交换后==%@",_ArrM);
//    
//    
//    //刷新缓存
//    for (NSString *name in _ArrM) {
//        
//        [RecordAirManger SearchText:name];//缓存搜索记录
////        [self readNSUserDefaults];
//        
//    }
    
    
    
    NSString *string = _ArrM[sender.tag-100];

    NSArray *array = [string componentsSeparatedByString:@"-"];

    UILabel *lab=[self.view viewWithTag:1111];
    UILabel *lab2=[self.view viewWithTag:2222];
    lab.text=array[0];
    lab2.text=array[1];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@getDateAndWeek_mob.shtml",URL_Str];
    //saveUserExchange_mob.shtml
    
    NSLog(@"--------time--%@",self.StartTimeString);
    
    NSDictionary *dict = @{@"time":self.StartTimeString,@"type":@""};
    
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
            
            [_WeekArrM removeAllObjects];
            
            if ([dic[@"status"] isEqualToString:@"10000"]) {
                
                
                for (NSDictionary *dict in dic[@"list_time"]) {
                    
                    BianMinModel *model = [[BianMinModel alloc] init];
                    
                    model.date = [NSString stringWithFormat:@"%@",dict[@"date"]];
                    model.week = [NSString stringWithFormat:@"%@",dict[@"week"]];
                    
                    
                    [_WeekArrM addObject:model];
                    
                    if ([model.date isEqualToString:self.StartTimeString]) {
                        
                        //                        NSLog(@"===xiabiao===%ld",_WeekArrM.count);
                        
                        self.Index = (int)_WeekArrM.count;
                        
                    }
                    
                    
                }
                
                
                
                AirPlaneViewController *vc = [[AirPlaneViewController alloc] init];
                
                vc.TypeString = self.TypeString;
                vc.time = self.StartTimeString;
                vc.start_city = [NSString stringWithFormat:@"%@",array[0]];
                vc.arrive_city = [NSString stringWithFormat:@"%@",array[1]];
                vc.start_code = @"";
                vc.arrive_code = @"";
                vc.StartCity = [NSString stringWithFormat:@"%@",array[0]];
                vc.ArriveCity = [NSString stringWithFormat:@"%@",array[1]];
                vc.DateArray = _WeekArrM;
                vc.Index = self.Index;
                vc.BackDate = self.BackDate;
                vc.ManOrKidString = self.ManOrKidString;
                
                [self.navigationController pushViewController:vc animated:NO];
                self.navigationController.navigationBar.hidden=YES;
                
                
                
            }else{
                
                
//                [JRToast showWithText:dic[@"message"] duration:1.0f];
                
            }
        
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        NSLog(@"%@",error);
        
        
        
        
    }];
    
    
    
    
}

-(void)DeleteBtnClick
{
    [_ArrM removeAllObjects];
    [RecordAirManger removeAllArray];
   // [recordView removeFromSuperview];
    
    [self initRecordView];
    
}

-(void)PayBtnCLick
{
    UILabel *lab=[self.view viewWithTag:1111];
    UILabel *lab2=[self.view viewWithTag:2222];

    
    NSNull *null = [[NSNull alloc] init];
    
    if ([lab.text isEqualToString:lab2.text] || ([lab isEqual:null] && [lab2 isEqual:null])) {
        
        [TrainToast showWithText:@"出发城市与到达城市不能相同" duration:2.0f];
        
    }else{
        
        if ([self.TypeString isEqualToString:@"200"]) {//往返
            
            
            if ([self compareDate:self.StartTimeString withDate:self.BackDate] == -1) {
                
                [TrainToast showWithText:@"返程日期必须大于出发日期" duration:2.0f];
                
            }else{
                
                NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
                NSArray * myArray = [userDefaultes arrayForKey:@"Air"];
                
                NSString *name = [NSString stringWithFormat:@"%@-%@",lab.text,lab2.text];
                
                
                //记录不相等，缓存
                if (![myArray containsObject:name] && name.length!=0) {
                    
                    [RecordAirManger SearchText:[NSString stringWithFormat:@"%@-%@",lab.text,lab2.text]];//缓存搜索记录
                    [self readNSUserDefaults];
                    
                    [self initRecordView];
                    
                }else
                {
                    [RecordAirManger SearchTextwithRepeat:[NSString stringWithFormat:@"%@-%@",lab.text,lab2.text]];//缓存搜索记录
                    [self readNSUserDefaults];
                    [self initRecordView];
                }
                
                
                NSLog(@"==111==StartTimeLabelStr===%@==EndTimeLabel==%@",self.StartTimeLabelStr,EndTimeLabel.text);
                
                //缓存查询日期
                [RecordAirManger AirDate:self.StartTimeString End:self.BackDate];
                
                [self GetDateDatas];
                
//                AirPlaneViewController *vc = [[AirPlaneViewController alloc] init];
//                
//                vc.TypeString = self.TypeString;
//                vc.time = self.StartTimeString;
//                vc.start_city = StartName.text;
//                vc.arrive_city = EndName.text;
//                vc.start_code = @"";
//                vc.arrive_code = @"";
//                vc.StartCity = StartName.text;
//                vc.ArriveCity = EndName.text;
//                
//                [self.navigationController pushViewControlle r:vc animated:NO];
//                self.navigationController.navigationBar.hidden=YES;
                
                
            }
        }else{//单程
            UILabel *lab=[self.view viewWithTag:1111];
            UILabel *lab2=[self.view viewWithTag:2222];

            NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
            NSArray * myArray = [userDefaultes arrayForKey:@"Air"];
            
            NSString *name = [NSString stringWithFormat:@"%@-%@",lab.text,lab2.text];
            
            
            //记录不相等，缓存
            if (![myArray containsObject:name] && name.length!=0) {
                
                [RecordAirManger SearchText:[NSString stringWithFormat:@"%@-%@",lab.text,lab2.text]];//缓存搜索记录
                [self readNSUserDefaults];
                [self initRecordView];
            }else
            {
                [RecordAirManger SearchTextwithRepeat:[NSString stringWithFormat:@"%@-%@",lab.text,lab2.text]];//缓存搜索记录
                [self readNSUserDefaults];
                [self initRecordView];
            }
            
            NSLog(@"==222==StartTimeLabelStr===%@==EndTimeLabel==%@",self.StartTimeLabelStr,EndTimeLabel.text);
            
            //缓存查询日期
            [RecordAirManger AirDate:self.StartTimeString End:self.BackDate];
            
            
            [self GetDateDatas];
            
//            AirPlaneViewController *vc = [[AirPlaneViewController alloc] init];
//            vc.TypeString = self.TypeString;
//            
//            vc.TypeString = self.TypeString;
//            vc.time = self.StartTimeString;
//            vc.start_city = StartName.text;
//            vc.arrive_city = EndName.text;
//            vc.start_code = @"";
//            vc.arrive_code = @"";
//            vc.StartCity = StartName.text;
//            vc.ArriveCity = EndName.text;
//            
//            [self.navigationController pushViewController:vc animated:NO];
//            self.navigationController.navigationBar.hidden=YES;
            
        }
        
    }
    
}

- (NSInteger)compareDate:(NSString*)aDate withDate:(NSString*)bDate
{
    NSInteger aa = 0;
    NSDateFormatter *dateformater = [[NSDateFormatter alloc] init];
    [dateformater setDateFormat:@"yyyy-MM-dd"];
    NSDate *dta = [[NSDate alloc] init];
    NSDate *dtb = [[NSDate alloc] init];
    
    dta = [dateformater dateFromString:aDate];
    dtb = [dateformater dateFromString:bDate];
    NSComparisonResult result = [dta compare:dtb];
    if (result==NSOrderedSame)
    {
        //        相等  aa=0
    }else if (result==NSOrderedAscending)
    {
        //bDate比aDate大
        aa=1;
    }else if (result==NSOrderedDescending)
    {
        //bDate比aDate小
        aa=-1;
        
    }
    
    return aa;
}

-(void)StrartBtnClick
{
    AirPlaneSelectCityViewController *vc = [[AirPlaneSelectCityViewController alloc] init];
    vc.delegate=self;
    vc.Type = @"1";
    [self.navigationController pushViewController:vc animated:NO];
    
    self.navigationController.navigationBar.hidden=YES;
    
}

-(void)EndBtnClick
{
    
    AirPlaneSelectCityViewController *vc = [[AirPlaneSelectCityViewController alloc] init];
    vc.delegate=self;
    vc.Type = @"2";
    [self.navigationController pushViewController:vc animated:NO];
    
    self.navigationController.navigationBar.hidden=YES;
}

-(void)WFBtnClick:(UIButton *)sender
{
    
    [UIView animateWithDuration:0.5 animations:^{
        CGPoint point=StartName.center;
        StartName.center=EndName.center;
        EndName.center=point;
        NSInteger temp=StartName.tag;
        StartName.tag=EndName.tag;
        EndName.tag=temp;
        UILabel *lab=[self.view viewWithTag:1111];
        UILabel *lab2=[self.view viewWithTag:2222];
        lab.textAlignment=NSTextAlignmentLeft;
        lab2.textAlignment=NSTextAlignmentRight;
        
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
    
//    NSString *string1 = StartName.text;
//    NSString *string2 = EndName.text;
//    
//    StartName.text = string2;
//    EndName.text = string1;
    
}

-(void)twoBtnClick
{
    
    [UIView animateWithDuration:0.5 animations:^{
        redImg1.frame=CGRectMake([UIScreen mainScreen].bounds.size.width/2+([UIScreen mainScreen].bounds.size.width/2-40)/2, 42, 40, 2);
        one.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        two.textColor = [UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
        logoImgView.hidden=YES;
        EndTimeLabel.hidden=NO;
        EndTime.hidden=NO;
        Backbutton.hidden=NO;
        Gobutton.hidden=NO;
        NewGobutton.hidden=YES;
    }];
    
//    redImg2.image = [UIImage imageNamed:@"icon-underline"];
//    redImg1.image = [UIImage imageNamed:@""];
    self.TypeString = @"200";
    Backbutton.enabled=YES;
}

-(void)BackBtnClick
{
    NSLog(@"==返回日期===%@",self.BackDate);
    
    AirPlaneDateSelectViewController *vc = [[AirPlaneDateSelectViewController alloc] init];
    
    [vc setAirPlaneToDay:365 ToDateforString:self.BackDate back:@""];//飞机初始化方法
    
    
    vc.calendarblock = ^(CalendarDayModel *model){
        
        NSLog(@"\n---------------------------");
        NSLog(@"1星期 %@",[model getWeek]);
        NSLog(@"2字符串 %@",[model toString]);
        NSLog(@"3节日  %@",model.holiday);
        
        NSString *string = [NSString stringWithFormat:@"%@",[model toString]];
        NSArray *array = [string componentsSeparatedByString:@"-"];
        
        self.Week = [NSString stringWithFormat:@"%@",[model getWeek]];
        self.Date = [NSString stringWithFormat:@"%@月%@日",array[1],array[2]];
        EndTimeLabel.text = self.Date;
        
        self.BackDate = [NSString stringWithFormat:@"%@",[model toString]];
        
        NSLog(@"===返回日期选择===%@",self.BackDate);
        
    };
    
    
    [self.navigationController pushViewController:vc animated:NO];
    self.navigationController.navigationBar.hidden=YES;
    
}

-(void)NewGoBtnClick
{
    AirPlaneDateSelectViewController *vc = [[AirPlaneDateSelectViewController alloc] init];
    
    //传入日期
    NSLog(@"====传入日期====%@",self.StartTimeString);
    [vc setAirPlaneToDay:365 ToDateforString:self.StartTimeString back:@""];//飞机初始化方法
    
    
    vc.calendarblock = ^(CalendarDayModel *model){
        
        NSLog(@"\n---------------------------");
        NSLog(@"1星期 %@",[model getWeek]);
        NSLog(@"2字符串 %@",[model toString]);
        NSLog(@"3节日  %@",model.holiday);
        
        NSString *string = [NSString stringWithFormat:@"%@",[model toString]];
        NSArray *array = [string componentsSeparatedByString:@"-"];
        
        self.Week = [NSString stringWithFormat:@"%@",[model getWeek]];
        self.Date = [NSString stringWithFormat:@"%@月%@日",array[1],array[2]];
        StartTimeLabel.text = self.Date;
        
        self.StartTimeString = [NSString stringWithFormat:@"%@",[model toString]];
        
        self.StartTimeLabelStr = [NSString stringWithFormat:@"%@-%@",array[1],array[2]];
        
        int addDays = 5;
        NSDateFormatter *dateFormatter = [NSDateFormatter new];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSDate *myDate = [dateFormatter dateFromString:[model toString]];
        NSDate *newDate = [myDate dateByAddingTimeInterval:60 * 60 * 24 * addDays];
        NSLog(@"===计算日期==%@",[dateFormatter stringFromDate:newDate]);
        
        NSString *EndString = [dateFormatter stringFromDate:newDate];
        
        NSArray *dateArray1 = [EndString componentsSeparatedByString:@"-"];
        
        EndTimeLabel.text = [NSString stringWithFormat:@"%@月%@日",dateArray1[1],dateArray1[2]];
        
        
        
        self.BackDate = [NSString stringWithFormat:@"%@-%@-%@",dateArray1[0],dateArray1[1],dateArray1[2]];
        
        NSLog(@"===点击去日期选择===%@",self.BackDate);
        
    };
    
    
    [self.navigationController pushViewController:vc animated:NO];
    self.navigationController.navigationBar.hidden=YES;
    
}

-(void)GoBtnClick
{
    
    AirPlaneDateSelectViewController *vc = [[AirPlaneDateSelectViewController alloc] init];
    
    //传入日期
    NSLog(@"====传入日期====%@",self.StartTimeString);
    [vc setAirPlaneToDay:365 ToDateforString:self.StartTimeString back:@""];//飞机初始化方法
    
    
    vc.calendarblock = ^(CalendarDayModel *model){
        
        NSLog(@"\n---------------------------");
        NSLog(@"1星期 %@",[model getWeek]);
        NSLog(@"2字符串 %@",[model toString]);
        NSLog(@"3节日  %@",model.holiday);
        
        NSString *string = [NSString stringWithFormat:@"%@",[model toString]];
        NSArray *array = [string componentsSeparatedByString:@"-"];
        
        self.Week = [NSString stringWithFormat:@"%@",[model getWeek]];
        self.Date = [NSString stringWithFormat:@"%@月%@日",array[1],array[2]];
        StartTimeLabel.text = self.Date;
        
        self.StartTimeString = [NSString stringWithFormat:@"%@",[model toString]];
        
        self.StartTimeLabelStr = [NSString stringWithFormat:@"%@-%@",array[1],array[2]];
        
        int addDays = 5;
        NSDateFormatter *dateFormatter = [NSDateFormatter new];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSDate *myDate = [dateFormatter dateFromString:[model toString]];
        NSDate *newDate = [myDate dateByAddingTimeInterval:60 * 60 * 24 * addDays];
        NSLog(@"===计算日期==%@",[dateFormatter stringFromDate:newDate]);
        
        NSString *EndString = [dateFormatter stringFromDate:newDate];
        
        NSArray *dateArray1 = [EndString componentsSeparatedByString:@"-"];
        
        EndTimeLabel.text = [NSString stringWithFormat:@"%@月%@日",dateArray1[1],dateArray1[2]];
        
        
        
        self.BackDate = [NSString stringWithFormat:@"%@-%@-%@",dateArray1[0],dateArray1[1],dateArray1[2]];
        
        NSLog(@"===点击去日期选择===%@",self.BackDate);
        
    };
    
    
    [self.navigationController pushViewController:vc animated:NO];
    self.navigationController.navigationBar.hidden=YES;
    
}

-(void)OneBtnClick
{
    [UIView animateWithDuration:0.5 animations:^{
        two.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        one.textColor = [UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
        redImg1.frame=CGRectMake(([UIScreen mainScreen].bounds.size.width/2-40)/2, 42, 40, 2);
        logoImgView.hidden=NO;
        EndTimeLabel.hidden=YES;
        EndTime.hidden=YES;
        
        Backbutton.hidden=YES;
        NewGobutton.hidden=NO;
        Gobutton.hidden=YES;
        
    }];
    
   
    self.TypeString = @"100";
    Backbutton.enabled=NO;
}

-(void)QurtBtnClick{
    
    [self.navigationController popToRootViewControllerAnimated:NO];
    self.tabBarController.tabBar.hidden=NO;
}

#pragma  mark - CLLocationManagerDelegate
//定位成功
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    [_locationManager requestWhenInUseAuthorization];
    
    CLLocation *location1 = [locations lastObject];
    CLLocationDegrees latitude1 = location1.coordinate.latitude;
    CLLocationDegrees longitude1 = location1.coordinate.longitude;
    
    
    //    self.jindu=[NSString stringWithFormat:@"%f",longitude1];
    //    self.weidu=[NSString stringWithFormat:@"%f",latitude1];
    
    
    //    NSLog(@">>>>%f",latitude1);
    //    NSLog(@">>>>%f",longitude1);
    
    
    NSLog(@"飞机票定位成功!");
    
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
        
        if (error) {
            NSLog(@"商户首页反地理编码失败!%@",error);
            return ;
        }
        
        //地址信息
        CLPlacemark *placemark = [placemarks firstObject];
        NSString *country = placemark.country;
        NSString *administrativeArea = placemark.administrativeArea;
        NSString *subLocality = placemark.subLocality;
        NSString *name = placemark.name;
        NSString *city = placemark.locality;
        
        NSLog(@"%@ %@ %@ %@ %@", country, administrativeArea, city,subLocality, name);
        
        NSArray *array = [city componentsSeparatedByString:@"市"];
        
        self.CityString = [NSString stringWithFormat:@"%@",array[0]];
        
        
        
        UILabel *lab=[self.view viewWithTag:1111];
        UILabel *lab2=[self.view viewWithTag:2222];

        if (_ArrM.count==0) {
            
            lab.text = self.CityString;
            
        }else{
            
            NSArray *array1 = [_ArrM[0] componentsSeparatedByString:@"-"];
            
            lab.text = [NSString stringWithFormat:@"%@",array1[0]];
            
            lab2.text = [NSString stringWithFormat:@"%@",array1[1]];
            
            
        }
        
        
    }];
    
    
    //停止定位
    [_locationManager stopUpdatingLocation];
    
    
}

//获取当地时间
- (NSString *)getCurrentTime {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM-dd"];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    return dateTime;
}

- (NSString *)getTadayTime {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    return dateTime;
}

//传入今天的时间，返回明天的时间
- (NSString *)GetTomorrowDay:(NSDate *)aDate {
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorian components:NSCalendarUnitWeekday | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:aDate];
    [components setDay:([components day]+2)];
    
    NSDate *beginningOfWeek = [gregorian dateFromComponents:components];
    NSDateFormatter *dateday = [[NSDateFormatter alloc] init];
    [dateday setDateFormat:@"MM月dd日"];
    return [dateday stringFromDate:beginningOfWeek];
}

//定位失败
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"定位失败:%@", error);
}

-(void)GetDateDatas
{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@getDateAndWeek_mob.shtml",URL_Str];
    //saveUserExchange_mob.shtml
    
    NSLog(@"========%@",self.StartTimeString);
    
    NSDictionary *dict = @{@"time":self.StartTimeString};
    
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
            
             [_WeekArrM removeAllObjects];
            
            if ([dic[@"status"] isEqualToString:@"10000"]) {
                
                
                for (NSDictionary *dict in dic[@"list_time"]) {
                    
                    BianMinModel *model = [[BianMinModel alloc] init];
                    
                    model.date = [NSString stringWithFormat:@"%@",dict[@"date"]];
                    model.week = [NSString stringWithFormat:@"%@",dict[@"week"]];
                    
                    
                    [_WeekArrM addObject:model];
                    
                    if ([model.date isEqualToString:self.StartTimeString]) {
                        
//                        NSLog(@"===xiabiao===%ld",_WeekArrM.count);
                        
                        self.Index = (int)_WeekArrM.count;
                        
                    }
                    
                    
                }
                
                UILabel *lab=[self.view viewWithTag:1111];
                UILabel *lab2=[self.view viewWithTag:2222];

                AirPlaneViewController *vc = [[AirPlaneViewController alloc] init];
                vc.TypeString = self.TypeString;
                
                vc.TypeString = self.TypeString;
                vc.time = self.StartTimeString;
                vc.start_city = lab.text;
                vc.arrive_city = lab2.text;
                vc.start_code = @"";
                vc.arrive_code = @"";
                vc.StartCity = lab.text;
                vc.ArriveCity = lab2.text;
                vc.DateArray = _WeekArrM;
                vc.Index = self.Index;
                vc.BackDate = self.BackDate;
                vc.ManOrKidString = self.ManOrKidString;
                
                [self.navigationController pushViewController:vc animated:NO];
                self.navigationController.navigationBar.hidden=YES;
                
                
                
            }else if ([dic[@"status"] isEqualToString:@"10006"])
            {
                [UIAlertTools showAlertWithTitle:@"" message:dic[@"message"] cancelTitle:@"知道了" titleArray:nil viewController:self confirm:^(NSInteger buttonTag) {
                    
                }];
                
                
            }
            else{
                
                
                [JRToast showWithText:dic[@"message"] duration:1.0f];
                
            }
            
            
            
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        NSLog(@"%@",error);
        
        
        
        
    }];
    
}
-(void)getDatas
{
    
//    WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
//    
//    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
//    dispatch_after(time, dispatch_get_main_queue(), ^{
//        
//    });
    
    NSLog(@"====self.CityString.length===%ld",self.CityString.length);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@getPlaneDefaultCity_mob.shtml",URL_Str];
    //saveUserExchange_mob.shtml
    
    [manager POST:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
        NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];
        
        
        if (codeKey && content) {
            NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
            
          //  NSLog(@"xmlStr==%@",xmlStr);
            
            NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            NSLog(@"分类查看更多书局=%@",dic);
            
            if ([dic[@"status"] isEqualToString:@"10000"]) {
                
                self.start_city = dic[@"start_city"][@"city_name"];
                
                
                
//                for (NSString *name in _ArrM) {
//                    
//                    NSLog(@"====缓存地址===%@",name);
//                    
//                }
                UILabel *lab=[self.view viewWithTag:1111];
                UILabel *lab2=[self.view viewWithTag:2222];

                if (_ArrM.count==0) {
                    
                    if (self.CityString.length == 0) {
                        
                        lab.text = [NSString stringWithFormat:@"%@",self.start_city];
                    
                    }
                    
                    lab2.text = [NSString stringWithFormat:@"%@",dic[@"arrive_city"][@"city_name"]];
                    
                }else{
                    
                    NSArray *array = [_ArrM[0] componentsSeparatedByString:@"-"];
                    
                    if (self.CityString.length == 0) {
                        
                        lab.text = [NSString stringWithFormat:@"%@",array[0]];
                    
                    }
                    
                    lab2.text = [NSString stringWithFormat:@"%@",array[1]];
                    
                }
                
            }            
            else{
                
                [JRToast showWithText:dic[@"message"] duration:1.0f];
                
            }
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@",error);
        UILabel *lab=[self.view viewWithTag:1111];
        UILabel *lab2=[self.view viewWithTag:2222];

        if (_ArrM.count==0) {
            
            if (self.CityString.length == 0) {
                
                lab.text = @"深圳";
            
            }
            
            lab2.text = @"北京";
            
        }else{
            
            NSArray *array = [_ArrM[0] componentsSeparatedByString:@"-"];
            
            if (self.CityString.length == 0) {
                
                lab.text = [NSString stringWithFormat:@"%@",array[0]];
         
            }
            
            lab2.text = [NSString stringWithFormat:@"%@",array[1]];
            
        }
        
    }];
    
}

-(void)KidBtnCLick
{
    ManImg.image = [UIImage imageNamed:@"botton-choose-default"];
    KidsImg.image = [UIImage imageNamed:@"btn_selected"];
    self.ManOrKidString = @"2";
}

-(void)ManBtnCLick
{
    
    ManImg.image = [UIImage imageNamed:@"btn_selected"];
    KidsImg.image = [UIImage imageNamed:@"botton-choose-default"];
    self.ManOrKidString = @"1";
}
@end
