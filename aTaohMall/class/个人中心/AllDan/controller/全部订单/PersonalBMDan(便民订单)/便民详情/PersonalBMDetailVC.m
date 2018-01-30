//
//  PersonalBMDetailVC.m
//  aTaohMall
//
//  Created by Hawky on 2017/11/29.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "PersonalBMDetailVC.h"
#import "TrainBuyTicketVC.h"
//店铺
#import "BMNewGameAndPhoneViewController.h"
#import "BMPlaneAndTrainViewController.h"
#import "PeccantViewController.h"
//退款
#import "TrainToReturnMoneyViewController.h"
#import "AirApplyRefundVC.h"

#import "XLRedNaviView.h"

#import "PersonalBMDetailModel.h"


@interface PersonalBMDetailVC ()<XLRedNaviViewDelegate>
{
    CGFloat height;
    XLRedNaviView *navi;
    UILabel *DetailStatusLab;
    WKProgressHUD *hud;
}
@property (nonatomic,strong)NSString *order_batchild;
@property (nonatomic,strong)NSString *order_type;
@property (nonatomic,strong)PersonalBMDetailModel *DataModel;

@property (nonatomic,strong)UIScrollView *scoll;
@property (nonatomic,strong)UIImage *BackImage;
/*
 */
@property (nonatomic,strong)NSString *statusImgName;
@property (nonatomic,strong)NSString *statusStr;
@property (nonatomic,strong)NSString *detailStatusStr;
@property (nonatomic,strong)NSTimer *timer;
@property (nonatomic, assign) NSTimeInterval time;

@end


@implementation PersonalBMDetailVC

/*******************************************************      控制器生命周期       ******************************************************/
-(instancetype)initWithOrderBatchid:(NSString *)orderBatchid AndOrderType:(NSString *)orderType
{
    if (self=[super init]) {
        self.order_batchild=orderBatchid;
        self.order_type=orderType;
        self.DataModel.order_type=orderType;
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden=YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self getDatas];
    [KNotificationCenter addObserver:self selector:@selector(PayCallBack:) name:JMSHTPayCallBack object:nil];
}


/*******************************************************      数据请求       ******************************************************/



//
-(void)getDatas
{
    hud=[WKProgressHUD showInView:self.view.window withText:@"" animated:YES];
    NSDictionary *params=@{@"sigen":[kUserDefaults objectForKey:@"sigen"],@"orderno":self.order_batchild};
    if ([self.order_type isEqualToString:@"1"]||[self.order_type isEqualToString:@"2"]) {
        params=@{@"sigen":[kUserDefaults objectForKey:@"sigen"],@"orderno":self.order_batchild,@"order_type":self.order_type};
        [self getPhoneAndFlowDataWithParams:params];
    }
    else if ([self.order_type isEqualToString:@"4"])
    {
        [self getAirDataWithParams:params];
    }else if([self.order_type isEqualToString:@"5"])
    {
        [self getTrainDataWithParams:params];
    }else if ([self.order_type isEqualToString:@"6"])
    {
        [self getIllegalDataWithParams:params];

    }

}
//
-(void)getPhoneAndFlowDataWithParams:(NSDictionary *)params
{

    [ATHRequestManager requestforgetOrderDetailsByPhoneWithParams:params successBlock:^(NSDictionary *responseObj) {
        _scoll=nil;
        navi=nil;
        if ([responseObj[@"status"] isEqualToString:@"10000"]) {

        self.DataModel.alone_integral=[NSString stringWithFormat:@"%@",responseObj[@"alone_integral"]];

        self.DataModel.storename=[NSString stringWithFormat:@"安淘惠便民服务"];

        self.DataModel.phone=[NSString stringWithFormat:@"%@",responseObj[@"phone"]];
        //
        self.DataModel.paymoney=[NSString stringWithFormat:@"%@",responseObj[@"paymoney"]];

        self.DataModel.card_name=[NSString stringWithFormat:@"%@",responseObj[@"card_name"]];

        self.DataModel.message=[NSString stringWithFormat:@"%@",responseObj[@"message"]];
        //
        self.DataModel.end_date=[NSString stringWithFormat:@"%@",responseObj[@"end_date"]];

      //  self.DataModel.order_type=[NSString stringWithFormat:@"%@",responseObj[@"order_type"]];

        self.DataModel.payintegral=[NSString stringWithFormat:@"%@",responseObj[@"payintegral"]];
        //
        self.DataModel.orderno=[NSString stringWithFormat:@"%@",responseObj[@"orderno"]];
        //
            self.DataModel.type=[NSString stringWithFormat:@"%@",responseObj[@"type"]];

        self.DataModel.refund_date=[NSString stringWithFormat:@"%@",responseObj[@"refund_date"]];

        self.DataModel.alone_money=[NSString stringWithFormat:@"%@",responseObj[@"alone_money"]];

        self.DataModel.number=[NSString stringWithFormat:@"%@",responseObj[@"number"]];

        self.DataModel.scopeimg=[NSString stringWithFormat:@"%@",responseObj[@"scopeimg"]];

        self.DataModel.arrive_date=[NSString stringWithFormat:@"%@",responseObj[@"arrive_date"]];

        self.DataModel.status=[NSString stringWithFormat:@"%@",responseObj[@"status"]];
        //
        self.DataModel.getdate=[NSString stringWithFormat:@"%@",responseObj[@"getdate"]];
        }
        else
        {
            [TrainToast showWithText:responseObj[@"message"] duration:2.0];
        }
        [self setUI];
 [hud dismiss:YES];
    } faildBlock:^(NSError *error) {
 [hud dismiss:YES];
    }];
}
//
-(void)getTrainDataWithParams:(NSDictionary *)params
{
    [ATHRequestManager requestforgetOrderDetailsByTrainWithParams:params successBlock:^(NSDictionary *responseObj) {
        _scoll=nil;
        navi=nil;
        if ([responseObj[@"status"] isEqualToString:@"10000"]) {

            self.DataModel.storename=[NSString stringWithFormat:@"安淘惠便民服务"];
        self.DataModel.phone=[NSString stringWithFormat:@"%@",responseObj[@"phone"]];
        //
        self.DataModel.paymoney=[NSString stringWithFormat:@"%@",responseObj[@"paymoney"]];
        //
        self.DataModel.message=[NSString stringWithFormat:@"%@",responseObj[@"message"]];
        //
        self.DataModel.end_date=[NSString stringWithFormat:@"%@",responseObj[@"end_date"]];
        //
        self.DataModel.payintegral=[NSString stringWithFormat:@"%@",responseObj[@"payintegral"]];

        self.DataModel.service_charge=[NSString stringWithFormat:@"%@",responseObj[@"service_charge"]];

        self.DataModel.order_id=[NSString stringWithFormat:@"%@",responseObj[@"order_id"]];

        self.DataModel.orderno=[NSString stringWithFormat:@"%@",responseObj[@"orderno"]];
        //
        self.DataModel.type=[NSString stringWithFormat:@"%@",responseObj[@"type"]];
        //
        self.DataModel.logo=[NSString stringWithFormat:@"%@",responseObj[@"logo"]];

        self.DataModel.refunds_date=[NSString stringWithFormat:@"%@",responseObj[@"refunds_date"]];

        self.DataModel.refund_type=[NSString stringWithFormat:@"%@",responseObj[@"refund_type"]];
        //
        [self.DataModel getlistUserWithArray:responseObj[@"list_user"]];
        //
        self.DataModel.actual_time=[NSString stringWithFormat:@"%@",responseObj[@"actual_time"]];

       // @property (nonatomic, strong) NSArray *list;
        [self.DataModel getTrainListWithArray:responseObj[@"list"]];

        self.DataModel.ticket_code=[NSString stringWithFormat:@"%@",responseObj[@"ticket_code"]];

        self.DataModel.dishonour_arrive_time=[NSString stringWithFormat:@"%@",responseObj[@"dishonour_arrive_time"]];
        //
        self.DataModel.status=[NSString stringWithFormat:@"%@",responseObj[@"status"]];
        //
        self.DataModel.getdate=[NSString stringWithFormat:@"%@",responseObj[@"getdate"]];

            self.DataModel.is_refund=[NSString stringWithFormat:@"%@",responseObj[@"is_refund"]];
        }
        else
        {
            [TrainToast showWithText:responseObj[@"message"] duration:2.0];
        }
        [self setUI];
         [hud dismiss:YES];
    } faildBlock:^(NSError *error) {
 [hud dismiss:YES];
    }];
}
//
-(void)getAirDataWithParams:(NSDictionary *)params
{
    [ATHRequestManager requestforgetOrderDetailsByAirplaneWithParams:params successBlock:^(NSDictionary *responseObj) {
        _scoll=nil;
        navi=nil;
        if ([responseObj[@"status"] isEqualToString:@"10000"]) {
            self.DataModel.storename=[NSString stringWithFormat:@"安淘惠便民服务"];

            self.DataModel.phone=[NSString stringWithFormat:@"%@",responseObj[@"phone"]];
            
            self.DataModel.paymoney=[NSString stringWithFormat:@"%@",responseObj[@"paymoney"]];

            
            self.DataModel.end_date=[NSString stringWithFormat:@"%@",responseObj[@"end_date"]];
            
            self.DataModel.is_aviation_accident_insurance=[NSString stringWithFormat:@"%@",responseObj[@"is_aviation_accident_insurance"]];
            
            self.DataModel.dishonour_start_time=[NSString stringWithFormat:@"%@",responseObj[@"dishonour_start_time"]];
            
            self.DataModel.linkman_name=[NSString stringWithFormat:@"%@",responseObj[@"linkman_name"]];
            
            self.DataModel.orderno=[NSString stringWithFormat:@"%@",responseObj[@"orderno"]];
            
            self.DataModel.type=[NSString stringWithFormat:@"%@",responseObj[@"type"]];
            
            self.DataModel.logo=[NSString stringWithFormat:@"%@",responseObj[@"logo"]];
            
            self.DataModel.payintegral=[NSString stringWithFormat:@"%@",responseObj[@"payintegral"]];
            
            self.DataModel.refund_type=[NSString stringWithFormat:@"%@",responseObj[@"refund_type"]];
            
         //   @property (nonatomic, strong) NSArray *list_user;
            [self.DataModel getlistUserWithArray:responseObj[@"list_user"]];
            
            self.DataModel.actual_time=[NSString stringWithFormat:@"%@",responseObj[@"actual_time"]];
            
          //  @property (nonatomic, strong) NSArray *list_airplane;
            [self.DataModel getListAirplaneWithArray:responseObj[@"list_airplane"]];

            self.DataModel.dishonour_arrive_time=[NSString stringWithFormat:@"%@",responseObj[@"dishonour_arrive_time"]];
            
            self.DataModel.getdate=[NSString stringWithFormat:@"%@",responseObj[@"getdate"]];

             self.DataModel.is_refund=[NSString stringWithFormat:@"%@",responseObj[@"is_refund"]];
        }
        else
        {
            [TrainToast showWithText:responseObj[@"message"] duration:2.0];
        }
        [hud dismiss:YES];
[self setUI];
    } faildBlock:^(NSError *error) {
 [hud dismiss:YES];
    }];
}
//
-(void)getIllegalDataWithParams:(NSDictionary *)params
{
    [ATHRequestManager requestforillegalOrderDetailsWithParams:params successBlock:^(NSDictionary *responseObj) {
        _scoll=nil;
        navi=nil;
        if ([responseObj[@"status"] isEqualToString:@"10000"]) {

            self.DataModel.storename=[NSString stringWithFormat:@"安淘惠便民服务"];

        self.DataModel.carNo=[NSString stringWithFormat:@"%@",responseObj[@"carNo"]];

        self.DataModel.dishonour_time=[NSString stringWithFormat:@"%@",responseObj[@"dishonour_time"]];

        self.DataModel.uid=[NSString stringWithFormat:@"%@",responseObj[@"uid"]];

        self.DataModel.paymoney=[NSString stringWithFormat:@"%@",responseObj[@"paymoney"]];

        self.DataModel.message=[NSString stringWithFormat:@"%@",responseObj[@"message"]];

        self.DataModel.order_type=[NSString stringWithFormat:@"%@",responseObj[@"order_type"]];

        self.DataModel.payintegral=[NSString stringWithFormat:@"%@",responseObj[@"payintegral"]];

        self.DataModel.contactName=[NSString stringWithFormat:@"%@",responseObj[@"contactName"]];

        self.DataModel.orderno=[NSString stringWithFormat:@"%@",responseObj[@"orderno"]];

        self.DataModel.sta=[NSString stringWithFormat:@"%@",responseObj[@"sta"]];

        self.DataModel.tel=[NSString stringWithFormat:@"%@",responseObj[@"tel"]];

        self.DataModel.totalfreight=[NSString stringWithFormat:@"%@",responseObj[@"totalfreight"]];

      //  @property (nonatomic, strong) NSArray *list2;
        [self.DataModel GetIllegalList2WithArray:responseObj[@"list2"]];

        self.DataModel.status=[NSString stringWithFormat:@"%@",responseObj[@"status"]];

        self.DataModel.pay_time=[NSString stringWithFormat:@"%@",responseObj[@"pay_time"]];
        }else
        {
            [TrainToast showWithText:responseObj[@"message"] duration:2.0];
        }
        [self setUI];
        [hud dismiss:YES];

    } faildBlock:^(NSError *error) {
        [hud dismiss:YES];

    }];

}


/*******************************************************      初始化视图       ******************************************************/
//火车票
-(void)setTrainUI
{
    UIView *OrderView = [[UIView alloc] initWithFrame:CGRectMake(0, height, [UIScreen mainScreen].bounds.size.width, 70+Height(30))];
    OrderView.backgroundColor = RGB(244, 244, 244);
    [self.scoll addSubview:OrderView];
    height+=OrderView.frame.size.height;

    XLTrainModel *model=_DataModel.list.firstObject;
    UIImageView *scopIV=[[UIImageView alloc] initWithFrame:CGRectMake(Width(15), Height(15), 70, 70)];
    [scopIV sd_setImageWithURL:KNSURL(_DataModel.logo) placeholderImage:KImage(@"default_imge")];
    [OrderView addSubview:scopIV];



    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"]; // 年-月-日 时:分:秒
    // 这个格式可以随便定义,比如：@"yyyy,MM,dd,HH,mm,ss"
    NSDate * date = [formatter dateFromString:model.date];
    NSString *Week=@"";
    NSLog(@"the date = %@",date);

    NSCalendar * calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar]; // 指定日历的算法 NSCalendarIdentifierGregorian,NSGregorianCalendar
    // NSDateComponent 可以获得日期的详细信息，即日期的组成
    NSDateComponents *comps = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit|NSWeekCalendarUnit|NSWeekdayCalendarUnit fromDate:date];

    NSLog(@"星期 =weekDay = %ld ",comps.weekday);
    if ([comps weekday] == 1) {

        Week = [NSString stringWithFormat:@"星期日"];
    }else if ([comps weekday] == 2){

        Week = [NSString stringWithFormat:@"星期一"];
    }else if ([comps weekday] == 3){

        Week = [NSString stringWithFormat:@"星期二"];
    }else if ([comps weekday] == 4){

        Week = [NSString stringWithFormat:@"星期三"];
    }else if ([comps weekday] == 5){

        Week = [NSString stringWithFormat:@"星期四"];
    }else if ([comps weekday] == 6){

        Week = [NSString stringWithFormat:@"星期五"];
    }else if ([comps weekday] == 7){

        Week = [NSString stringWithFormat:@"星期六"];
    }

    UILabel *DateLabel = [[UILabel alloc] initWithFrame:CGRectMake(Width(30)+70, Height(19), [UIScreen mainScreen].bounds.size.width-Width(45)-70, 13)];
    DateLabel.text = [NSString stringWithFormat:@"%@ %@ 开",model.date,Week];
    DateLabel.numberOfLines=1;
    DateLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    DateLabel.font  =[UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    [OrderView addSubview:DateLabel];

    UILabel *StartName = [[UILabel alloc] initWithFrame:CGRectMake(Width(30)+70, Height(19)+13+Height(15), 100, 13)];
    StartName.text = model.start_station_name;
    StartName.numberOfLines=1;
    StartName.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    StartName.font  =[UIFont fontWithName:@"PingFang-SC-Medium" size:13];
    [OrderView addSubview:StartName];

    UILabel *StartTime = [[UILabel alloc] initWithFrame:CGRectMake(Width(30)+68, Height(19)+13+Height(15)+13+Height(12), 100, 11)];
    StartTime.text = [model.start_time stringByReplacingOccurrencesOfString:@" " withString:@""];
    StartTime.numberOfLines=1;
    StartTime.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    StartTime.font  =[UIFont fontWithName:@"PingFang-SC-Regular" size:11];
    [OrderView addSubview:StartTime];

    NSArray *TimeArray = [model.run_time componentsSeparatedByString:@":"];

    UILabel *LongLabel = [[UILabel alloc] initWithFrame:CGRectMake(Width(30)+70, Height(19)+13+Height(15), [UIScreen mainScreen].bounds.size.width-Width(45)-70, 13)];
    if ([TimeArray[0] floatValue]==0) {
        LongLabel.text=[NSString stringWithFormat:@"%@分钟",TimeArray[1]];
    }else
    {
        LongLabel.text = [NSString stringWithFormat:@"%@时%@分",TimeArray[0],TimeArray[1]];
    }

    LongLabel.numberOfLines=1;
    LongLabel.textAlignment = NSTextAlignmentCenter;
    LongLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    LongLabel.font  =[UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    [OrderView addSubview:LongLabel];

    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-88)/2+(Width(15)+70)/2, Height(19)+13+Height(15)+13, 88, 9)];
    imgView.image = [UIImage imageNamed:@"开往-(1)"];
    [OrderView addSubview:imgView];

    UILabel *CheCiLabel = [[UILabel alloc] initWithFrame:CGRectMake(Width(30)+70, Height(19)+13+Height(15)+13+Height(12), [UIScreen mainScreen].bounds.size.width-Width(45)-70, 13)];
    CheCiLabel.text = model.checi;
    CheCiLabel.numberOfLines=1;
    CheCiLabel.textAlignment = NSTextAlignmentCenter;
    CheCiLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    CheCiLabel.font  =[UIFont fontWithName:@"PingFang-SC-Medium" size:14];
    [OrderView addSubview:CheCiLabel];

    UILabel *EndName = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-100-Width(15), Height(19)+13+Height(15), 100, 13)];
    EndName.text = model.arrive_station_name;
    EndName.numberOfLines=1;
    EndName.textAlignment = NSTextAlignmentRight;
    EndName.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    EndName.font  =[UIFont fontWithName:@"PingFang-SC-Medium" size:13];
    [OrderView addSubview:EndName];

    UILabel *EndTime = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-100-Width(15), Height(19)+13+Height(15)+13+Height(12), 100, 11)];
    EndTime.text =[model.arrive_time stringByReplacingOccurrencesOfString:@" " withString:@""];;
    EndTime.numberOfLines=1;
    EndTime.textAlignment = NSTextAlignmentRight;
    EndTime.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    EndTime.font  =[UIFont fontWithName:@"PingFang-SC-Regular" size:11];
    [OrderView addSubview:EndTime];


    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, height, kScreenWidth, Height(10)+13)];
    [view setBackgroundColor:[UIColor whiteColor]];
    [self.scoll addSubview:view];

    height+=view.frame.size.height;

    UILabel *chengcheLab=[[UILabel alloc] initWithFrame:CGRectMake(Width(15), Height(10), kScreenWidth, 13)];
    [chengcheLab setFont:KNSFONTM(13)];
    [chengcheLab setTextColor:RGB(51, 51, 51)];
    [chengcheLab setText:@"乘车人"];

    [view addSubview:chengcheLab];



    for (int i = 0; i < _DataModel.list_user.count; i++) {

        XLUserModel *model = _DataModel.list_user[i];

        UIView *ManView = [[UIView alloc] initWithFrame:CGRectMake(0, height, [UIScreen mainScreen].bounds.size.width, Height(10)+12+Height(10)+12+Height(10)+1)];
        ManView.backgroundColor = [UIColor whiteColor];
        [self.scoll addSubview:ManView];

        height+=ManView.frame.size.height;

        UILabel *NameLabel = [[UILabel alloc] initWithFrame:CGRectMake(Width(30)+70, Height(10), ([UIScreen mainScreen].bounds.size.width-Width(45)-70)/2, 12)];
        NameLabel.text = [NSString stringWithFormat:@"%@  %@",model.passengersename,model.piaotypename];
        NameLabel.numberOfLines=1;
        NameLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        NameLabel.font  =[UIFont fontWithName:@"PingFang-SC-Regular" size:12];
        [ManView addSubview:NameLabel];

        UILabel *IdLabel = [[UILabel alloc] initWithFrame:CGRectMake(Width(30)+70, Height(10)+12+Height(10), [UIScreen mainScreen].bounds.size.width-Width(45)-70-20, 12)];
        IdLabel.text =[NSString stringWithFormat:@"证件号:%@",model.passportseno];
        IdLabel.numberOfLines=1;
        IdLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        IdLabel.font  =[UIFont fontWithName:@"PingFang-SC-Regular" size:12];
        [ManView addSubview:IdLabel];

        UILabel *NumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth-Width(15)-120, Height(10), 120, 12)];
        NumberLabel.text = model.cxin;
        NumberLabel.numberOfLines=1;
        NumberLabel.textAlignment = NSTextAlignmentRight;
        NumberLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
        NumberLabel.font  =[UIFont fontWithName:@"PingFang-SC-Regular" size:12];
        [ManView addSubview:NumberLabel];

        UILabel *TypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth-Width(15)-120, Height(10)+12+Height(10), 120, 12)];
        TypeLabel.text = model.seat_type_name;
        TypeLabel.numberOfLines=1;
        TypeLabel.textAlignment = NSTextAlignmentRight;
        TypeLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        TypeLabel.font  =[UIFont fontWithName:@"PingFang-SC-Regular" size:12];
        [ManView addSubview:TypeLabel];

        UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, Height(30)+24, [UIScreen mainScreen].bounds.size.width, 1)];
        line.image = [UIImage imageNamed:@"分割线-拷贝"];
        [ManView addSubview:line];
    }
}
//机票
-(void)setAirplaneUI
{
    UIView *OrderView = [[UIView alloc] initWithFrame:CGRectMake(0, height, [UIScreen mainScreen].bounds.size.width, 70+Height(50))];
    OrderView.backgroundColor = RGB(244, 244, 244);
    [self.scoll addSubview:OrderView];
    height+=OrderView.frame.size.height;
    XLAirplaneModel *model=_DataModel.list_airplane.firstObject;

    UIImageView *scopIV=[[UIImageView alloc] initWithFrame:CGRectMake(Width(15), Height(25), 70, 70)];
    [scopIV sd_setImageWithURL:KNSURL(_DataModel.logo) placeholderImage:KImage(@"default_imge")];
    [OrderView addSubview:scopIV];

    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"]; // 年-月-日 时:分:秒
    // 这个格式可以随便定义,比如：@"yyyy,MM,dd,HH,mm,ss"
    NSString *jingting=@"";
    if ([model.flight_type isEqualToString:@"1"])
    {
        jingting=@"经停";
    }

    UILabel *DateLabel = [[UILabel alloc] initWithFrame:CGRectMake(Width(30)+70, Height(16), [UIScreen mainScreen].bounds.size.width-Width(45)-70, 13)];
    DateLabel.text = [NSString stringWithFormat:@"%@-%@|%@ %@ ",model.start_city_name,model.arrive_city_name,model.date,model.week];
    DateLabel.numberOfLines=1;
    DateLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    DateLabel.font  =[UIFont fontWithName:@"PingFang-SC-Regular" size:13];
    [OrderView addSubview:DateLabel];

    UILabel *StartName = [[UILabel alloc] initWithFrame:CGRectMake(Width(30)+70, Height(16)+13+Height(5)+13,(kScreen_Width-Width(30)-70-Width(30)-Width(15)-88)/2,40+Height(4))];
    StartName.text =model.start_airport;
    StartName.numberOfLines=0;
    StartName.textAlignment=NSTextAlignmentCenter;
    StartName.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    StartName.font  =[UIFont fontWithName:@"PingFang-SC-Medium" size:13];
    [OrderView addSubview:StartName];

    UILabel *StartTime = [[UILabel alloc] initWithFrame:CGRectMake(Width(30)+70, Height(16)+13+Height(5), (kScreen_Width-Width(30)-70-Width(30)-Width(15)-88)/2, 13)];
    StartTime.text = model.start_time;
    StartTime.numberOfLines=1;
    StartTime.textAlignment=NSTextAlignmentCenter;
    StartTime.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    StartTime.font  =[UIFont fontWithName:@"PingFang-SC-Regular" size:13];
    [OrderView addSubview:StartTime];


    UILabel *LongLabel = [[UILabel alloc] initWithFrame:CGRectMake(Width(30)+70, Height(16)+13+Height(9), [UIScreen mainScreen].bounds.size.width-Width(45)-70, 13)];

    LongLabel.text=model.run_time;
    LongLabel.numberOfLines=1;
    LongLabel.textAlignment = NSTextAlignmentCenter;
    LongLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    LongLabel.font  =[UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    [OrderView addSubview:LongLabel];

    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-88)/2+(Width(15)+70)/2, Height(16)+13+Height(9)+13+5, 88, 9)];
    imgView.image = [UIImage imageNamed:@"开往-(1)"];
    [OrderView addSubview:imgView];

    UILabel *CheCiLabel = [[UILabel alloc] initWithFrame:CGRectMake(Width(30)+70, Height(16)+13+Height(9)+13+5+9+Height(3), [UIScreen mainScreen].bounds.size.width-Width(45)-70, 13)];
    CheCiLabel.text = jingting;
    CheCiLabel.numberOfLines=1;
    CheCiLabel.textAlignment = NSTextAlignmentCenter;
    CheCiLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    CheCiLabel.font  =[UIFont fontWithName:@"PingFang-SC-Medium" size:14];
    [OrderView addSubview:CheCiLabel];

    UILabel *EndName = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-(kScreen_Width-Width(30)-70-Width(30)-Width(15)-88)/2-Width(15), Height(16)+13+Height(5)+13, (kScreen_Width-Width(30)-70-Width(30)-Width(15)-88)/2, 40+Height(4))];
    EndName.text =model.arrive_airport;
    EndName.numberOfLines=0;
    EndName.textAlignment = NSTextAlignmentCenter;
    EndName.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    EndName.font  =[UIFont fontWithName:@"PingFang-SC-Medium" size:13];
    [OrderView addSubview:EndName];

    UILabel *EndTime = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-(kScreen_Width-Width(30)-70-Width(30)-Width(15)-88)/2-Width(15), Height(16)+13+Height(5), (kScreen_Width-Width(30)-70-Width(30)-Width(15)-88)/2, 13)];
    EndTime.text = model.arrive_time;
    EndTime.numberOfLines=1;
    EndTime.textAlignment = NSTextAlignmentCenter;
    EndTime.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    EndTime.font  =[UIFont fontWithName:@"PingFang-SC-Regular" size:13];
    [OrderView addSubview:EndTime];

    UILabel *totalLab=[[UILabel alloc] initWithFrame:CGRectMake(Width(30)+70, Height(50)+70-Height(16)-13, kScreenWidth-Width(45)-70, 13 )];
    [totalLab setTextColor:RGB(153, 153, 153)];
    [totalLab setFont:KNSFONTM(13)];

    NSString *totalStr=@"";
    totalStr=[NSString stringWithFormat:@"%@|%@%@",model.PlaneType,model.airport_name,model.airport_flight];
    if ([jingting isEqualToString:@"经停"]) {
        totalStr=[totalStr stringByAppendingString:@"|"];
        totalStr=[totalStr stringByAppendingString:jingting];
    }
    [totalLab setText:totalStr];
    [OrderView addSubview:totalLab];

    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, height, kScreenWidth, Height(10)+13)];
    [view setBackgroundColor:[UIColor whiteColor]];
    [self.scoll addSubview:view];
    height+=view.frame.size.height;

    UILabel *chengcheLab=[[UILabel alloc] initWithFrame:CGRectMake(Width(15), Height(10), kScreenWidth, 13)];
    [chengcheLab setFont:KNSFONTM(13)];
    [chengcheLab setTextColor:RGB(51, 51, 51)];
    [chengcheLab setText:@"乘机人"];

    [view addSubview:chengcheLab];



    for (int i = 0; i < _DataModel.list_user.count; i++) {

        XLUserModel *model = _DataModel.list_user[i];

        UIView *ManView = [[UIView alloc] initWithFrame:CGRectMake(0, height, [UIScreen mainScreen].bounds.size.width, Height(10)+12+Height(10)+12+Height(10)+12+Height(10)+1)];
        ManView.backgroundColor = [UIColor whiteColor];
        [self.scoll addSubview:ManView];
        height+=ManView.frame.size.height;


        CGSize size=[model.username sizeWithFont:KNSFONT(12) maxSize:CGSizeMake(kScreenWidth, 12)];

        UILabel *NameLabel = [[UILabel alloc] initWithFrame:CGRectMake(Width(30)+70, Height(10), size.width+5, 12)];
        NameLabel.text = [NSString stringWithFormat:@"%@",model.username];
        NameLabel.numberOfLines=1;
        NameLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        NameLabel.font  =[UIFont fontWithName:@"PingFang-SC-Regular" size:12];
        [ManView addSubview:NameLabel];

        if ([_DataModel.is_aviation_accident_insurance isEqualToString:@"1"]) {
        UIImageView *IV=[[UIImageView alloc] initWithFrame:CGRectMake(Width(30)+70+size.width+10, Height(10)-2, 14, 16)];
        [IV setImage:KImage(@"保")];
        [ManView addSubview:IV];
        }


        UILabel *IdLabel = [[UILabel alloc] initWithFrame:CGRectMake(Width(30)+70, Height(10)+12+Height(10), [UIScreen mainScreen].bounds.size.width-Width(45)-70, 12)];
        IdLabel.text = [NSString stringWithFormat:@"证件号:%@", model.passportseno];
        IdLabel.numberOfLines=1;
        IdLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
        IdLabel.font  =[UIFont fontWithName:@"PingFang-SC-Regular" size:12];
        [ManView addSubview:IdLabel];

        if ([model.adult_banks isEqualToString:@""]||[model.adult_banks containsString:@"null"]) {

        }else
        {
        UILabel *NumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(Width(30)+70, Height(10)+12+Height(10)+12+Height(10), [UIScreen mainScreen].bounds.size.width-Width(45)-70, 12)];
        NumberLabel.text =  [NSString stringWithFormat:@"成人票号:%@",model.adult_banks];
        NumberLabel.numberOfLines=1;
        NumberLabel.textAlignment = NSTextAlignmentLeft;
        NumberLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
        NumberLabel.font  =[UIFont fontWithName:@"PingFang-SC-Regular" size:12];
        [ManView addSubview:NumberLabel];

        UIButton *but=[UIButton buttonWithType:UIButtonTypeCustom];
        [but setFrame:CGRectMake(kScreenWidth-Width(15)-30, Height(10)+12+Height(10)+12+Height(10), 30, 14)];
        [but.layer setCornerRadius:7];
        [but.layer setBorderWidth:1];
        [but.layer setBorderColor:RGB(153, 153, 153).CGColor];
        [but setTitle:@"复制" forState:UIControlStateNormal];
        but.titleLabel.font=KNSFONTM(9);
        [but setTitleColor:RGB(153, 153, 153) forState:UIControlStateNormal];
        but.tag=100+i;
        [ManView addSubview:but];

        [but addTarget:self action:@selector(CopyPiaoHao:) forControlEvents:UIControlEventTouchUpInside];
        }
        UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, Height(40)+36, [UIScreen mainScreen].bounds.size.width, 1)];
        line.image = [UIImage imageNamed:@"分割线-拷贝"];
        [ManView addSubview:line];
    }
}
//违章
-(void)setIllegalUI
{

     for (int i = 0; i < _DataModel.list2.count; i++) {

        XLIllegalModel *model=_DataModel.list2[i];

        CGSize typeSize=[model.behavior sizeWithFont:KNSFONT(13) maxSize:CGSizeMake(kScreen_Width-75, 300)];
        CGSize placeSize=[[NSString stringWithFormat:@"%@%@",model.cityName,model.address] sizeWithFont:KNSFONT(13) maxSize:CGSizeMake(kScreen_Width-75, 300)];

        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, height, [UIScreen mainScreen].bounds.size.width, 20+13+10+typeSize.height+10+placeSize.height+12+13+20)];

        height+=view.frame.size.height;
        if(i==_DataModel.list2.count-1)
        {
            view.frame=CGRectMake(0, view.frame.origin.y, [UIScreen mainScreen].bounds.size.width, 20+13+10+typeSize.height+10+placeSize.height+12+13+10);
            height=height-10;
        }
        view.backgroundColor = [UIColor whiteColor];
        [self.scoll addSubview:view];

        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 20, [UIScreen mainScreen].bounds.size.width-30, 13)];

        NSString *deductText=[NSString stringWithFormat:@"扣%@分",model.deductPoint];
        if ([model.fine floatValue]!=0) {
            deductText=[deductText stringByAppendingString:[NSString stringWithFormat:@" 罚%@元",model.fine]];
        }
        if([model.zhinajin floatValue]!=0)
        {
            deductText=[deductText stringByAppendingString:[NSString stringWithFormat:@" 滞纳金%@元",model.zhinajin]];
        }
        if ([model.serviceFee floatValue]!=0) {
            deductText=[deductText stringByAppendingString:[NSString stringWithFormat:@" 服务费%@元",model.serviceFee]];
        }
        label.text  =deductText;
        label.textColor = [UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
        label.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:13];
        [view addSubview:label];

        NSString *ShiFuPriceForColor = @"分 罚";
        NSString *ShiFuPriceForColor2 = @"元 滞纳金";
        NSString *ShiFuPriceForColor3 = @"分 滞纳金";
        NSString *ShiFuPriceForColor4 = @"分 服务费";
        NSString *ShiFuPriceForColor5 = @"元 服务费";

        // 创建对象.
        NSMutableAttributedString *mAttStri1 = [[NSMutableAttributedString alloc] initWithString:label.text];
        //
        NSRange range1 = [label.text rangeOfString:ShiFuPriceForColor];
        NSRange range2 = [label.text rangeOfString:ShiFuPriceForColor2];
        NSRange range3 = NSMakeRange(0, 1);
        NSRange range4=NSMakeRange(label.text.length-1, 1);
        NSRange range5 = [label.text rangeOfString:ShiFuPriceForColor3];
        NSRange range6 = [label.text rangeOfString:ShiFuPriceForColor4];
        NSRange range7 = [label.text rangeOfString:ShiFuPriceForColor5];

        [mAttStri1 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0] range:range1];
        [mAttStri1 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0] range:range3];
        [mAttStri1 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0] range:range2];
        [mAttStri1 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0] range:range4];
        [mAttStri1 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0] range:range5];
        [mAttStri1 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0] range:range6];
        [mAttStri1 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0] range:range7];
        label.attributedText=mAttStri1;

        UILabel *TypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 46, 35, 12)];
        TypeLabel.text =@"类型";
        TypeLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        TypeLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:13];
        [view addSubview:TypeLabel];


        UILabel *type=[[UILabel alloc]initWithFrame:CGRectMake(60, 43, typeSize.width, typeSize.height)];
        type.text=model.behavior;
        type.numberOfLines=0;
        type.textColor=RGB(51, 51, 51);
        type.font=KNSFONT(13);
        [view addSubview:type];


        UILabel *AddressLabel = [[UILabel alloc] initWithFrame:CGRectMake(15,20+13+10+typeSize.height+10+3,35, 12)];
        AddressLabel.text  =@"地点";
        AddressLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        AddressLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:13];
        AddressLabel.numberOfLines = 2;
        [view addSubview:AddressLabel];

        UILabel *address=[[UILabel alloc] initWithFrame:CGRectMake(60, 20+13+10+typeSize.height+10, placeSize.width, placeSize.height)];
        address.text=[NSString stringWithFormat:@"%@%@",model.cityName,model.address];
        address.textColor=RGB(51, 51, 51);
        address.font=KNSFONT(13);
        [view addSubview:address];
        UILabel *TimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 20+13+10+typeSize.height+10+placeSize.height+12, 35, 12)];
        TimeLabel.text  =@"时间";
        TimeLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        TimeLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:13];
        [view addSubview:TimeLabel];

        UILabel *time=[[UILabel alloc]initWithFrame:CGRectMake(60, 20+13+10+typeSize.height+9+placeSize.height+12, kScreen_Width-75, 13)];
        time.text=model.time;
        time.textColor=RGB(51, 51, 51);
        time.font=KNSFONT(13);
        [view addSubview:time];


        UIImageView *line3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, view.frame.size.height-1, [UIScreen mainScreen].bounds.size.width, 1)];
        line3.image = [UIImage imageNamed:@"分割线-拷贝"];
        if (i<_DataModel.list2.count-1) {
            [view addSubview:line3];
        }
    }
}
//流量话费
-(void)setPhoneAndFlowUI
{

    UIView *backView=[[UIView alloc] initWithFrame:CGRectMake(0, height, kScreenWidth, Height(30)+70)];
    [backView setBackgroundColor:RGB(244, 244, 244)];
    [self.scoll addSubview:backView];
    height+=backView.frame.size.height;

    UIImageView* ShoppingIV=[[UIImageView alloc] init];
    [backView addSubview:ShoppingIV];

    UILabel *stationLab=[[UILabel alloc] init];
    [stationLab setFont:KNSFONTM(12)];
    [stationLab setTextColor:RGB(51, 51, 51)];
    [backView addSubview:stationLab];

    UILabel *priceLab=[[UILabel alloc] init];
    [priceLab setFont:KNSFONTM(12)];
    [priceLab setTextColor:RGB(255, 93, 94)];
    [backView addSubview:priceLab];

    UILabel *numLab=[[UILabel alloc] init];
    [numLab setFont:KNSFONTM(12)];
    [numLab setTextColor:RGB(51, 51, 51)];
    [numLab setTextAlignment:NSTextAlignmentRight];
    [backView addSubview:numLab];

    [ShoppingIV setFrame:CGRectMake(Width(15), Height(15), 70, 70)];
    [stationLab setFrame:CGRectMake(Width(25)+70, Height(25), kScreenWidth-Width(40)-70, 14)];
    [priceLab setFrame:CGRectMake(Width(25)+70,Height(30)+70-Height(25)-12, kScreenWidth-Width(40)-70-20, 12)];
    [numLab setFrame:CGRectMake(kScreenWidth-Width(15)-20, Height(30)+70-Height(25)-12, 20, 12)];

    [stationLab setText:_DataModel.card_name];
    [ShoppingIV sd_setImageWithURL:KNSURL(_DataModel.scopeimg) placeholderImage:KImage(@"default_image") options:SDWebImageProgressiveDownload];
    NSString * priceStr=[NSString stringWithFormat:@"￥%@+%@积分",_DataModel.alone_money,_DataModel.alone_integral];
    [priceLab setText:priceStr];
    NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:priceLab.text];
    NSString *str1=@"￥";
    NSString *str2=@"积分";
    NSRange range1 = [priceLab.text rangeOfString:str1];
    NSRange range2 = [priceLab.text rangeOfString:str2];
    [mAttStri addAttribute:NSFontAttributeName value:KNSFONTM(9) range:range1];
    [mAttStri addAttribute:NSFontAttributeName value:KNSFONTM(9) range:range2];
    priceLab.attributedText=mAttStri;
    [numLab setText:[NSString stringWithFormat:@"x%@",_DataModel.number]];

}

-(void)setUI
{
    height=0;
    [self initNavi];
    [self initTopBackView];
    [self initPhoneAndNameVIew];
    [self initMerchantView];
    [self initCenterView];
    [self initOrderView];
    [self initBottomBar];
}
//实际付款和订单状态等等
-(void)initOrderView
{
    UIView *OrderView=[[UIView alloc] initWithFrame:CGRectMake(0, height, kScreenWidth, 200)];
    [OrderView setBackgroundColor:[UIColor whiteColor]];
    [self.scoll addSubview:OrderView];



    CGFloat shiftHeight=Height(20);
    CGFloat rightShift=0;
    if ([_DataModel.order_type isEqualToString:@"5"]) {
        rightShift+=5+Width(10);
        UILabel *freightLab=[[UILabel alloc] initWithFrame:CGRectMake(Width(15), shiftHeight, 100, 12)];
        [freightLab setFont:KNSFONTM(12)];
        [freightLab setTextColor:RGB(51, 51, 51)];
        [freightLab setText:@"服务费"];
        [OrderView addSubview:freightLab];

        UILabel *intergralNumLab=[[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth-Width(15)-100-rightShift, shiftHeight, 100, 12)];
        [intergralNumLab setFont:KNSFONTM(12)];
        [intergralNumLab setTextColor:RGB(51, 51, 51)];
        [intergralNumLab setText:[NSString stringWithFormat:@"￥%@",_DataModel.service_charge]];
        [intergralNumLab setTextAlignment:NSTextAlignmentRight];
        [OrderView addSubview:intergralNumLab];
        shiftHeight+=freightLab.frame.size.height+Height(10);

        UIImageView *IV=[[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth-Width(15)-5, Height(20)+(12+12+14+Height(20))/2-6.5, 8, 13)];
        [IV setImage:KImage(@"icon_more")];
        [OrderView addSubview:IV];

        UIButton *but=[UIButton buttonWithType:UIButtonTypeCustom];
        [but setFrame:CGRectMake(kScreenWidth-Width(60), 0, Width(60), Height(60)+12+12+14)];
        [but addTarget:self action:@selector(checkTrainTotalDeatil:) forControlEvents:UIControlEventTouchUpInside];
        [OrderView addSubview:but];
        
    }

    if ([_DataModel.order_type isEqualToString:@"6"]) {
        UILabel *freightLab=[[UILabel alloc] initWithFrame:CGRectMake(Width(15), shiftHeight, 100, 12)];
        [freightLab setFont:KNSFONTM(12)];
        [freightLab setTextColor:RGB(51, 51, 51)];
        [freightLab setText:@"服务费"];
        [OrderView addSubview:freightLab];

        UILabel *intergralNumLab=[[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth-Width(15)-100-rightShift, shiftHeight, 100, 12)];
        [intergralNumLab setFont:KNSFONTM(12)];
        [intergralNumLab setTextColor:RGB(51, 51, 51)];
        [intergralNumLab setText:[NSString stringWithFormat:@"￥%@",_DataModel.totalfreight]];
        [intergralNumLab setTextAlignment:NSTextAlignmentRight];
        [OrderView addSubview:intergralNumLab];
        shiftHeight+=freightLab.frame.size.height+Height(10);

    }


    UILabel *intergralLab=[[UILabel alloc] initWithFrame:CGRectMake(Width(15), shiftHeight, 100, 12)];
    [intergralLab setFont:KNSFONTM(12)];
    [intergralLab setTextColor:RGB(51, 51, 51)];
    [intergralLab setText:@"积分"];
    [OrderView addSubview:intergralLab];

    UILabel *intergralNumLab=[[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth-Width(15)-100-rightShift, shiftHeight, 100, 12)];
    [intergralNumLab setFont:KNSFONTM(12)];
    [intergralNumLab setTextColor:RGB(51, 51, 51)];
    [intergralNumLab setText:_DataModel.payintegral];
    [intergralNumLab setTextAlignment:NSTextAlignmentRight];
    [OrderView addSubview:intergralNumLab];
    shiftHeight+=intergralLab.frame.size.height+Height(10);


    UILabel *payMoneyLab=[[UILabel alloc] initWithFrame:CGRectMake(Width(15), shiftHeight, 100, 14)];
    [payMoneyLab setFont:KNSFONTM(14)];
    [payMoneyLab setTextColor:RGB(51, 51, 51)];
    [payMoneyLab setText:@"实付"];
    [OrderView addSubview:payMoneyLab];

    UILabel *payMoneyNumLab=[[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth-Width(15)-100-rightShift, shiftHeight, 100, 14)];
    [payMoneyNumLab setFont:KNSFONTM(14)];
    [payMoneyNumLab setTextColor:RGB(255, 93, 94)];
    [payMoneyNumLab setTextAlignment:NSTextAlignmentRight];
    [payMoneyNumLab setText:[NSString stringWithFormat:@"￥%@",_DataModel.paymoney]];
    [OrderView addSubview:payMoneyNumLab];
    shiftHeight+=payMoneyLab.frame.size.height+Height(20);


    UIImageView *lineView=[[UIImageView alloc] initWithFrame:CGRectMake(0, shiftHeight, kScreenWidth, 1)];
    [lineView setImage:KImage(@"分割线-拷贝")];
    [OrderView addSubview:lineView];
    shiftHeight+=1+Height(20);

    /*

     */
    UILabel *orderNumLab=[[UILabel alloc] initWithFrame:CGRectMake(Width(15), shiftHeight, kScreenWidth-Width(30), 12)];
    [orderNumLab setFont:KNSFONTM(12)];
    [orderNumLab setTextColor:RGB(102, 102, 102)];
    [orderNumLab setText:[NSString stringWithFormat:@"订单号:%@",_DataModel.orderno]];
    [OrderView addSubview:orderNumLab];
    shiftHeight+=orderNumLab.frame.size.height+Height(12);

    UILabel *createTimeLab=[[UILabel alloc] initWithFrame:CGRectMake(Width(15), shiftHeight, kScreenWidth-Width(30), 12)];
    [createTimeLab setFont:KNSFONTM(12)];
    [createTimeLab setTextColor:RGB(102, 102, 102)];
    [createTimeLab setText:[NSString stringWithFormat:@"创建时间:%@",_DataModel.getdate]];
    [OrderView addSubview:createTimeLab];
    shiftHeight+=createTimeLab.frame.size.height+Height(12);

    if (![_DataModel.type isEqualToString:@"1"]||[_DataModel.type isEqualToString:@"6"])
    {
        NSString *paystr=@"";
        NSString *refundTimeStr=@"";
        NSString *refundMoneyTimeStr=@"";
        if ([_DataModel.order_type isEqualToString:@"1"]||[_DataModel.order_type isEqualToString:@"2"]||[_DataModel.order_type isEqualToString:@"3"]) {
            paystr=_DataModel.end_date;
            refundTimeStr=_DataModel.refund_date;
            refundMoneyTimeStr=_DataModel.arrive_date;
        }else if ([_DataModel.order_type isEqualToString:@"4"])
        {
            paystr=_DataModel.end_date;
            refundTimeStr=_DataModel.dishonour_start_time;
            refundMoneyTimeStr=_DataModel.dishonour_arrive_time;
        }else if ([_DataModel.order_type isEqualToString:@"5"])
        {
            paystr=_DataModel.end_date;
            refundTimeStr=_DataModel.refunds_date;
            refundMoneyTimeStr=_DataModel.dishonour_arrive_time;
        }else if ([_DataModel.order_type isEqualToString:@"6"])
        {
            paystr=_DataModel.pay_time;
            refundTimeStr=_DataModel.dishonour_time;
            refundMoneyTimeStr=_DataModel.dishonour_arrive_time;
        }
        if ([_DataModel.type isEqualToString:@"0"]) {
            paystr=@"正在等待买家付款...";
        }
        UILabel *payTimeLab=[[UILabel alloc] initWithFrame:CGRectMake(Width(15), shiftHeight, kScreenWidth-Width(30), 12)];
        [payTimeLab setFont:KNSFONTM(12)];
        [payTimeLab setTextColor:RGB(102, 102, 102)];
        [payTimeLab setText:[NSString stringWithFormat:@"付款时间:%@",paystr]];
        [OrderView addSubview:payTimeLab];
        shiftHeight+=payTimeLab.frame.size.height+Height(12);

        if ([_DataModel.type isEqualToString:@"4"]||[_DataModel.type isEqualToString:@"5"])
        {




            UILabel *refundTimeLab=[[UILabel alloc] initWithFrame:CGRectMake(Width(15), shiftHeight, kScreenWidth-Width(30), 12)];
            [refundTimeLab setFont:KNSFONTM(12)];
            [refundTimeLab setTextColor:RGB(102, 102, 102)];
            [refundTimeLab setText:[NSString stringWithFormat:@"退款时间:%@",refundTimeStr]];
            [OrderView addSubview:refundTimeLab];
            shiftHeight+=refundTimeLab.frame.size.height+Height(12);
            if ([_DataModel.type isEqualToString:@"5"])
            {
            UILabel *refundMoneyTimeLab=[[UILabel alloc] initWithFrame:CGRectMake(Width(15), shiftHeight, kScreenWidth-Width(30), 12)];
            [refundMoneyTimeLab setFont:KNSFONTM(12)];
            [refundMoneyTimeLab setTextColor:RGB(102, 102, 102)];
                [refundMoneyTimeLab setText:[NSString stringWithFormat:@"退款到账时间:%@",refundMoneyTimeStr]];
            [OrderView addSubview:refundMoneyTimeLab];
                shiftHeight+=refundMoneyTimeLab.frame.size.height+Height(12);
            }
        }
    }
    shiftHeight+=Height(8);

    OrderView.frame=CGRectMake(0, height, kScreenWidth, shiftHeight);
    height+=OrderView.frame.size.height;
    self.scoll.contentSize=CGSizeMake(kScreenWidth, height);
}
//中间内容
-(void)initCenterView
{

    if ([_DataModel.order_type isEqualToString:@"1"]||[_DataModel.order_type isEqualToString:@"2"]||[_DataModel.order_type isEqualToString:@"3"]) {
        [self setPhoneAndFlowUI];
    }else if ([_DataModel.order_type isEqualToString:@"4"])
    {
        [self setAirplaneUI];
    }else if ([_DataModel.order_type isEqualToString:@"5"])
    {

        [self setTrainUI];
    }else
    {
        [self setIllegalUI];

    }

}

//店铺
-(void)initMerchantView
{
    UIView *backView=[[UIView alloc] initWithFrame:CGRectMake(0, height, kScreenWidth, Height(30)+14)];
    [backView setBackgroundColor:[UIColor whiteColor]];
    [self.scoll addSubview:backView];
    height+=backView.frame.size.height;

    UIButton *storeDetailBut=[UIButton buttonWithType:UIButtonTypeCustom];
    [backView addSubview:storeDetailBut];

    UIImageView *storeIV=[[UIImageView alloc] init];
    [backView addSubview:storeIV];

    UILabel *storeNameLab=[[UILabel alloc] init];
    [storeNameLab setFont:KNSFONTM(14)];
    [storeNameLab setTextColor:RGB(51, 51, 51)];
    [backView addSubview:storeNameLab];

    UIImageView *moreIV=[[UIImageView alloc] init];
    [backView addSubview:moreIV];

    [storeIV setImage:KImage(@"店铺111")];

    [storeNameLab setText:_DataModel.storename];

    [moreIV setImage:KImage(@"icon_more")];

    [storeIV setFrame:CGRectMake(Width(15), Height(14), 15, 14)];

    CGSize storeNameSize=[storeNameLab.text sizeWithFont:KNSFONTM(14) maxSize:CGSizeMake(kScreen_Width/2.0-Width(22)-15+60, 14)];
    [storeNameLab setFrame:CGRectMake(Width(22)+15,Height(14), storeNameSize.width, 14)];

    [moreIV setFrame:CGRectMake(Width(22)+15+storeNameSize.width+5, Height(15), 8, 13)];
    [storeDetailBut setFrame:CGRectMake(0, 0, kScreen_Width, 14+Height(28))];
    [storeDetailBut addTarget:self action:@selector(storeDetailButClick:) forControlEvents:UIControlEventTouchUpInside];

}
//联系信息
-(void)initPhoneAndNameVIew
{
    UIView *backView=[[UIView alloc] initWithFrame:CGRectMake(0, height, kScreenWidth, Height(80))];
    [backView setBackgroundColor:[UIColor whiteColor]];
    [self.scoll addSubview:backView];

    height+=backView.frame.size.height;
    height+=Height(10);

    NSString *phoneNameSTr=@"";
    NSString *ticketNumStr=@"";
    BOOL flag=NO;
    if ([_DataModel.order_type isEqualToString:@"1"]||[_DataModel.order_type isEqualToString:@"2"])
    {
        phoneNameSTr=[NSString stringWithFormat:@"充值号码: %@",_DataModel.phone];
    }else if ([_DataModel.order_type isEqualToString:@"4"])
    {
        phoneNameSTr=[NSString stringWithFormat:@"联系人:%@ %@",_DataModel.linkman_name,_DataModel.phone];
    }else if ([_DataModel.order_type isEqualToString:@"5"])
    {
        phoneNameSTr=[NSString stringWithFormat:@"联系电话: %@",_DataModel.phone];

        if ([_DataModel.type isEqualToString:@"3"]||(([_DataModel.type isEqualToString:@"4"]||[_DataModel.type isEqualToString:@"5"])&&[_DataModel.refund_type isEqualToString:@"1"])) {
            flag=YES;
            ticketNumStr=[NSString stringWithFormat:@"取票号: %@",_DataModel.ticket_code];
        }
    }else if ([_DataModel.order_type isEqualToString:@"6"])
    {
        phoneNameSTr=[NSString stringWithFormat:@"车主姓名:%@ %@",_DataModel.contactName,_DataModel.tel];
    }

    UILabel * phoneOrNameLab = [[UILabel alloc]init];
    phoneOrNameLab.font=KNSFONTM(14);
    phoneOrNameLab.textColor=RGB(51, 51, 51);
    [backView addSubview:phoneOrNameLab];
    phoneOrNameLab.text=phoneNameSTr;
    if (!flag) {
        [phoneOrNameLab setFrame:CGRectMake(Width(15), (Height(80)-14)/2, kScreenWidth-Width(30), 14)];
    }else
    {
        [phoneOrNameLab setFrame:CGRectMake(Width(15), Height(80)-14-Height(20)-14-14, kScreenWidth-Width(30), 14)];
        UILabel *ticketsCodeLab=[[UILabel alloc] initWithFrame:CGRectMake(Width(15),Height(80)-14-( Height(80)-14-Height(20)-14-14), kScreenWidth-Width(30), 14)];
        ticketsCodeLab.font=KNSFONTM(14);
        ticketsCodeLab.textColor=RGB(51, 51, 51);
        [backView addSubview:ticketsCodeLab];
        ticketsCodeLab.text=ticketNumStr;
    }

    UIImageView *lineIV=[[UIImageView alloc] initWithFrame:CGRectMake(0, backView.frame.size.height-1, kScreenWidth,1)];
    [lineIV setImage:KImage(@"分割线-拷贝")];
    [backView addSubview:lineIV];


}
//底部操作按钮
-(void)initBottomBar
{

    CGFloat shiftHeight=0;

    if ([_DataModel.type isEqualToString:@"0"]) {
        UIView *OrderView=[[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight-28-Height(30)-KSafeAreaBottomHeight, kScreenWidth, 28+Height(30)-KSafeAreaBottomHeight)];
        [OrderView setBackgroundColor:[UIColor whiteColor]];
        [self.view addSubview:OrderView];
        UIImageView *lineView=[[UIImageView alloc] initWithFrame:CGRectMake(0, shiftHeight, kScreenWidth, 1)];
        [lineView setImage:KImage(@"分割线-拷贝")];
        [OrderView addSubview:lineView];
        shiftHeight+=1+Height(15);

        UIButton *continuePayBut=[UIButton buttonWithType:UIButtonTypeCustom];
        [continuePayBut setFrame:CGRectMake(kScreenWidth-Width(15)-90, shiftHeight, 90, 27)];
        [continuePayBut setTitle:@"继续付款" forState:UIControlStateNormal];
        [continuePayBut setTitleColor:RGB(255, 93, 94) forState:UIControlStateNormal];
        [continuePayBut.layer setBorderWidth:1];
        [continuePayBut.layer setBorderColor:RGB(255, 93, 94).CGColor];
        [continuePayBut.layer setCornerRadius:13.5];
        continuePayBut.titleLabel.font=KNSFONTM(14);
        [continuePayBut addTarget:self action:@selector(continuePayButClick:) forControlEvents:UIControlEventTouchUpInside];
        [OrderView addSubview:continuePayBut];
        shiftHeight+=continuePayBut.frame.size.height+Height(15);
    }
    if ([_DataModel.type isEqualToString:@"3"]&& (([_DataModel.is_refund isEqualToString:@"0"]&&[_DataModel.order_type isEqualToString:@"4"])||[self.DataModel.order_type isEqualToString:@"5"])) {
        UIView *OrderView=[[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight-28-Height(30)-KSafeAreaBottomHeight, kScreenWidth, 28+Height(30)-KSafeAreaBottomHeight)];
        [OrderView setBackgroundColor:[UIColor whiteColor]];
        [self.view addSubview:OrderView];
        UIImageView *lineView=[[UIImageView alloc] initWithFrame:CGRectMake(0, shiftHeight, kScreenWidth, 1)];
        [lineView setImage:KImage(@"分割线-拷贝")];
        [OrderView addSubview:lineView];
        shiftHeight+=1+Height(15);

        UIButton *refundBut=[UIButton buttonWithType:UIButtonTypeCustom];
        [refundBut setFrame:CGRectMake(kScreenWidth-Width(15)-90, shiftHeight, 90, 27)];
        [refundBut setTitle:@"退款" forState:UIControlStateNormal];
        [refundBut setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
        [refundBut.layer setBorderWidth:1];
        [refundBut.layer setBorderColor:RGB(51, 51, 51).CGColor];
        [refundBut.layer setCornerRadius:13.5];
        refundBut.titleLabel.font=KNSFONTM(14);
        [refundBut addTarget:self action:@selector(refundButClick:) forControlEvents:UIControlEventTouchUpInside];
        [OrderView addSubview:refundBut];
        shiftHeight+=refundBut.frame.size.height+Height(15);
    }
}

//导航栏
-(void)initNavi
{
    if (!navi) {
    navi=[[XLRedNaviView alloc] initWithMessage:@"订单详情" ImageName:@""];
    navi.delegate=self;
    [self.view addSubview:navi];
    }

}
//返回
-(void)QurtBtnClick
{
    [self.timer invalidate];
    self.timer=nil;
    [self.navigationController popViewControllerAnimated:YES];
}
//顶部红色状态视图
-(void)initTopBackView
{

    UIImageView *topBackIV=[[UIImageView alloc] initWithFrame:CGRectMake(0, height, kScreenWidth, Height(92))];
    UIImage *img=[self.BackImage getSubImage:CGRectMake(0, KSafeAreaTopNaviHeight, kScreenWidth, Height(92))];
    [topBackIV setImage:img];
    [self.scoll addSubview:topBackIV];
    [self.scoll setBackgroundColor:RGB(244, 244, 244)];
    height+=topBackIV.frame.size.height;

    UIImageView *topStatusIV=[[UIImageView alloc] init];
    [topStatusIV setImage:KImage(self.statusImgName)];
    [topBackIV addSubview:topStatusIV];

    UILabel *topStatusLab=[[UILabel alloc]init];
    [topStatusLab setText:self.statusStr];
    [topStatusLab setFont:KNSFONTM(17)];
    [topStatusLab setTextColor:RGB(255, 161, 92)];
    [topBackIV addSubview:topStatusLab];

    CGSize statusSize=[self.statusStr sizeWithFont:KNSFONTM(17) maxSize:CGSizeMake(kScreen_Width, 17)];

    if (
        ([self.DataModel.type isEqualToString:@"0"]&&([self.DataModel.order_type isEqualToString:@"4"]||[self.DataModel.order_type isEqualToString:@"5"]||[self.DataModel.order_type isEqualToString:@"6"]))||
        (([self.DataModel.type isEqualToString:@"4"]||[self.DataModel.type isEqualToString:@"5"])&&
         ((([self.DataModel.order_type isEqualToString:@"4"]||[self.DataModel.order_type isEqualToString:@"5"])&&[_DataModel.refund_type isEqualToString:@"0"])
          ||[self.DataModel.order_type isEqualToString:@"1"]||[self.DataModel.order_type isEqualToString:@"2"]||[self.DataModel.order_type isEqualToString:@"3"]))
        ) {


        DetailStatusLab=[[UILabel alloc]init];
        if ([self.DataModel.type isEqualToString:@"0"]) {
            self.time = [self.DataModel.actual_time intValue]/1000;
        }else
        {
        [DetailStatusLab setText:self.detailStatusStr];
        }
        [DetailStatusLab setFont:KNSFONTM(14)];
        [DetailStatusLab setTextColor:RGB(255, 161, 92)];
        [DetailStatusLab setTextAlignment:NSTextAlignmentCenter];
        [topBackIV addSubview:DetailStatusLab];

        [topStatusIV setFrame:CGRectMake((kScreen_Width-23-statusSize.width-Width(10))/2.0, Height(22), 30, 23)];
        [topStatusLab setFrame:CGRectMake((kScreen_Width-23-statusSize.width-Width(10))/2.0+23+Width(10), Height(25)-4, statusSize.width, statusSize.height)];

        [DetailStatusLab setFrame:CGRectMake(0 , Height(60), kScreenWidth, 15)];

    }else
    {
        [topStatusIV setFrame:CGRectMake((kScreen_Width-23-statusSize.width-Width(10))/2.0, (Height(92)-30)/2.0, 30, 23)];
        [topStatusLab setFrame:CGRectMake((kScreen_Width-23-statusSize.width-Width(10))/2.0+30+Width(10), (Height(92)-15)/2.0-7, statusSize.width, statusSize.height)];
    }


}


/*******************************************************      各种button执行方法、页面间的跳转       ******************************************************/
//店铺详情
-(void)storeDetailButClick:(UIButton *)sender
{
    if ([_DataModel.order_type isEqualToString:@"1"]) {

        BMNewGameAndPhoneViewController *vc = [[BMNewGameAndPhoneViewController alloc] init];

        vc.tag0 = 100;

        [self.navigationController pushViewController:vc animated:NO];


    }else if ([_DataModel.order_type isEqualToString:@"2"]){

        BMNewGameAndPhoneViewController *vc = [[BMNewGameAndPhoneViewController alloc] init];

        vc.tag1 = 101;

        [self.navigationController pushViewController:vc animated:NO];


    }else if ([_DataModel.order_type isEqualToString:@"3"]){

        BMNewGameAndPhoneViewController *vc = [[BMNewGameAndPhoneViewController alloc] init];

        vc.tag2 = 102;

        [self.navigationController pushViewController:vc animated:NO];

    }else if ([_DataModel.order_type isEqualToString:@"4"]){

        BMPlaneAndTrainViewController *vc = [[BMPlaneAndTrainViewController alloc] init];

        vc.tag0 = 100;

        [self.navigationController pushViewController:vc animated:NO];

    }else if([_DataModel.order_type isEqualToString:@"5"]){

        BMPlaneAndTrainViewController *vc = [[BMPlaneAndTrainViewController alloc] init];

        vc.tag1 = 101;

        [self.navigationController pushViewController:vc animated:NO];

    }else if([_DataModel.order_type isEqualToString:@"6"])
    {
        PeccantViewController *vc=[[PeccantViewController alloc]init];

        [self.navigationController pushViewController:vc animated:NO];

    }
    YLog(@"店铺");
    
}
//
-(void)CopyPiaoHao:(UIButton *)sender
{
    XLUserModel *model=_DataModel.list_user[sender.tag-100];




    UIPasteboard *pab = [UIPasteboard generalPasteboard];

    NSString *string =model.adult_banks;

    [pab setString:string];

    if (pab == nil) {
        [TrainToast showWithText:@"成人票号复制失败" duration:2.0];
    }else
    {
        [TrainToast showWithText:@"成人票号复制成功" duration:2.0];
    }
    YLog(@"复制");
}
//
-(void)checkTrainTotalDeatil:(UIButton *)sender
{
    TrainBuyTicketVC *VC=[[TrainBuyTicketVC alloc] init];
    VC.orderno=_DataModel.orderno;
    VC.status=_DataModel.type;
    [self.navigationController pushViewController:VC animated:NO];
    YLog(@"火车票");
}
//
-(void)refundButClick:(UIButton *)sender
{
    if([_DataModel.order_type isEqualToString:@"5"]){//火车票退款

        TrainToReturnMoneyViewController *vc = [[TrainToReturnMoneyViewController alloc] init];
        vc.ordrno = _DataModel.orderno;
        [self.navigationController pushViewController:vc animated:NO];
        self.navigationController.navigationBar.hidden = YES;

    }else if ([_DataModel.order_type isEqualToString:@"4"]){//飞机票退款

        AirApplyRefundVC *VC=[[AirApplyRefundVC alloc]init];
        VC.orderno=_DataModel.orderno;
        [self.navigationController pushViewController:VC animated:NO];

    }
    YLog(@"退款");
}
//
-(void)continuePayButClick:(UIButton *)sender
{
    [[AliPayRequestTools shareAlipayTool] BMContinuePayWithOrderNum:_DataModel.orderno OnViewController:self AndResponseSuccess:^(NSDictionary *responseObj) {
        [self.view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self getDatas];
        if (_delegate&&[_delegate respondsToSelector:@selector(BMDetailSelectIndexType:)]) {
            [_delegate BMDetailSelectIndexType:2];
        }
    } failed:^(NSError *error) {
        [self.view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self getDatas];
    }];
    YLog(@"继续付款");
}

-(void)PayCallBack:(NSNotification *)text
{
    if ([text.userInfo[@"resultStatus"] isEqualToString:@"9000"]) {
        [self.view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self getDatas];
        if (_delegate&&[_delegate respondsToSelector:@selector(BMDetailSelectIndexType:)]) {
            [_delegate BMDetailSelectIndexType:2];
        }
    }else if ([text.userInfo[@"resultStatus"] isEqualToString:@"8000"]){

        [TrainToast showWithText:@"正在处理中" duration:2.0f];


    }else if ([text.userInfo[@"resultStatus"] isEqualToString:@"4000"]){


        [TrainToast showWithText:@"订单支付失败" duration:2.0f];

    }else if ([text.userInfo[@"resultStatus"] isEqualToString:@"6001"]){


    }else if ([text.userInfo[@"resultStatus"] isEqualToString:@"6002"]){

        [TrainToast showWithText:@"网络连接出错" duration:2.0f];
    }

}
/*******************************************************      协议方法       ******************************************************/



/*******************************************************      代码提取(多是复用代码)       ******************************************************/


- (void)setTime:(NSTimeInterval)time {

    _time = time;

    NSLog(@"=======%f",_time);

    [self setViewWith:_time];

    [self.timer invalidate];
    self.timer = nil;

    if (_time == 0) {


    }else{

        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeRun) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
        [self.timer fire];

    }

}

- (void)timeRun {

    if (_time <= 0) {
        [self.timer invalidate];
        self.timer = nil;
        _time = 0;

    } else {
        _time --;
    }

    [self setViewWith:_time];
}

- (void)setViewWith:(NSTimeInterval)time {

    NSInteger hour = time/3600.0;
    NSInteger min  = (time - hour*3600)/60;
    NSInteger sec  = time - hour*3600 - min*60;

    [DetailStatusLab setText:[NSString stringWithFormat:@"请在%ld分%ld秒内付款",min,sec]];


}


-(PersonalBMDetailModel *)DataModel
{
    if (!_DataModel) {
        _DataModel=[[PersonalBMDetailModel alloc] init];
    }
    return _DataModel;
}

-(UIImage *)BackImage
{
    if (!_BackImage) {
        _BackImage=[UIImage imageWithImageView:CGRectMake(0, 0, kScreen_Width, 64+Height(92)) StartColor:RGB(255, 52, 90) EndColor:RGB(255, 93, 94) startPoint:CGPointMake(0, 0) endPoint:CGPointMake(0, 64+Height(92))];
    }
    return _BackImage;
}

-(NSString *)detailStatusStr
{
    _detailStatusStr=@"";
    switch ([_DataModel.type integerValue]) {
        case 0:
            _detailStatusStr=[NSString stringWithFormat:@"请在%@内付款",_DataModel.actual_time];
            break;
        case 4:
            if (([_DataModel.order_type isEqualToString:@"4"]||[_DataModel.order_type isEqualToString:@"5"])&&[_DataModel.refund_type isEqualToString:@"0"]) {
                _detailStatusStr=@"出票失败，自动退款";
            }
            if ([_DataModel.order_type isEqualToString:@"1"]||[_DataModel.order_type isEqualToString:@"2"]) {
                _detailStatusStr=@"充值失败，自动退款";
            }
            break;
        case 5:
            if (([_DataModel.order_type isEqualToString:@"4"]||[_DataModel.order_type isEqualToString:@"5"])&&[_DataModel.refund_type isEqualToString:@"0"]) {
                _detailStatusStr=@"出票失败，自动退款";
            }
            if ([_DataModel.order_type isEqualToString:@"1"]||[_DataModel.order_type isEqualToString:@"2"]) {
                _detailStatusStr=@"充值失败，自动退款";
            }
            break;
        default:
            break;
    }
    return _detailStatusStr;
}

-(NSString *)statusStr
{
    //  order_type :   1 话费  2 流量   3 游戏  4 机票购买  5:火车购买 6.违章查询
    //0：未付款     1：未付款交易关闭   2：已付款（充值中） 3：交易完成（充值成功） 4：退款中（充值失败） 5：已付款，交易关闭（退   6：交易失败（异常订单）
    //refundType  :   0 出票失败 1 用户手动退款
    _statusStr=@"";
    switch ([_DataModel.type integerValue]) {
        case 0:
            _statusStr=@"待付款";
            break;
        case 1:
            _statusStr=@"交易关闭";
            break;
        case 2:
            if ([_DataModel.order_type isEqualToString:@"1"]||[_DataModel.order_type isEqualToString:@"2"]) {
                _statusStr=@"充值中";
            }else if([_DataModel.order_type isEqualToString:@"4"]||[_DataModel.order_type isEqualToString:@"5"])
            {
                _statusStr=@"出票中";
            }else
            {
                _statusStr=@"缴费中";
            }
            break;
        case 3:
            _statusStr=@"交易成功";
            break;
        case 4:
            _statusStr=@"退款中";

            break;
        case 5:
            _statusStr=@"已退款";
            break;
        case 6:
            _statusStr=@"交易失败";
            break;
        default:
            break;
    }
    return _statusStr;
}
-(NSString *)statusImgName
{
    //  order_type :   1 话费  2 流量   3 游戏  4 机票购买  5:火车购买 6.违章查询
    //0：未付款     1：未付款交易关闭   2：已付款（充值中） 3：交易完成（充值成功） 4：退款中（充值失败） 5：已付款，交易关闭（退   6：交易失败（异常订单）
    //refundType  :   0 出票失败 1 用户手动退款
    _statusImgName=@"";
    switch ([_DataModel.type integerValue]) {
        case 0:
            _statusImgName=@"icon_Pendingpayment";
            break;
        case 1:
            _statusImgName=@"icon_Transactionclosed";
            break;
        case 2:
            _statusImgName=@"icon_Recharge";
             if([_DataModel.order_type isEqualToString:@"4"]||[_DataModel.order_type isEqualToString:@"5"])
            {
             _statusImgName=@"icon_Inbill";
            }
            break;
        case 3:
            _statusImgName=@"icon_Successfultrade-1";
            break;
        case 4:
            _statusImgName=@"icon_Refund-1";

            break;
        case 5:
            _statusImgName=@"icon_Refunded";
            break;
        case 6:
            _statusImgName=@"icon_Transactionclosed";
            break;
        default:
            break;
    }
    return _statusImgName;
}
-(UIScrollView *)scoll
{
    if (!_scoll) {
        CGFloat bottomHeight=0;
        if ([_DataModel.type isEqualToString:@"0"]||([_DataModel.type isEqualToString:@"3"]&&
                                                    ( ([_DataModel.is_refund isEqualToString:@"0"]&&[_DataModel.order_type isEqualToString:@"4"])||[_DataModel.order_type isEqualToString:@"5"]) )) {
            bottomHeight=1+Height(15)+27+Height(15);
        }
        _scoll=[[UIScrollView alloc] initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight, kScreenWidth, kScreenHeight-KSafeAreaTopNaviHeight-bottomHeight-KSafeAreaBottomHeight)];
        _scoll.showsVerticalScrollIndicator=NO;
        _scoll.bounces=NO;
        [self.view addSubview:_scoll];
    }
    return _scoll;
}
@end
