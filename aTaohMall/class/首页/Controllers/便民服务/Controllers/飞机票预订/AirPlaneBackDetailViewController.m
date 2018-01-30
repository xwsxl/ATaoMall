//
//  AirPlaneBackDetailViewController.m
//  aTaohMall
//
//  Created by JMSHT on 2017/6/27.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "AirPlaneBackDetailViewController.h"

#import "TuiKuanShuoMingView.h"
#import "AirPlaneReserveViewController.h"//单程
#import "AirPlaneReserveGoBackViewController.h"//往返

#import "AFNetworking.h"

#import "ConverUtil.h"
#import "DESUtil.h"
#import "SecretCodeTool.h"
#import "AirSelectView.h"

#import "WKProgressHUD.h"

#import "JRToast.h"
#import "RecordAirManger.h"
#import "BianMinModel.h"
#import "ATHLoginViewController.h"//登录

@interface AirPlaneBackDetailViewController ()<UIAlertViewDelegate,LoginMessageDelegate>
{
    
    UIScrollView *_scrollView;
     UIView *TopView;
    UILabel *label1;
    UILabel *label2;
    UIImageView *GOGO;
    UIImageView *redImgView2;
    UIImageView *redImgView1;
    
    TuiKuanShuoMingView *_customShareView;
    
    UILabel *Date;
    
    NSMutableArray *_DataArrM;
    
    NSMutableArray *_JinJiArrM;
    
    NSMutableArray *_HeaderArrM;
    
    UILabel *Companylabel;
    UILabel *StartTime;
    UILabel *EndTime;
    UILabel *StartName;
    UILabel *EndName;
    UILabel *longLabel;
    UILabel *Datelabel;
    UILabel *StopOverLab;
    NSArray *AirArray;//仓位数据
    
    UILabel *ShuoMing1;
    UIView *NoView;
    UIImageView *NoImgView;
    UILabel *NoLabel;
    
    UIWebView *webView;
    UIView *loadView;
    NSString *isChild;
    
    UILabel *ShuoMing;
    UIView *CangTypeView;
    
}
@property (nonatomic, strong) UISwipeGestureRecognizer *leftSwipeGestureRecognizer;
@property (nonatomic, strong) UISwipeGestureRecognizer *rightSwipeGestureRecognizer;
@end

@implementation AirPlaneBackDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数组NSArray类型的数据
    self.sigen=[userDefaultes stringForKey:@"sigen"];
    
    AirArray  =nil;
    
    _DataArrM = [NSMutableArray new];
    
    _JinJiArrM = [NSMutableArray new];
    
    _HeaderArrM = [NSMutableArray new];
    
    [self initNav];
    
    self.PanDuan = @"100";
    
    
    TopView=[[UIView alloc]initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight, kScreen_Width, 200)];
    [self.view addSubview:TopView];
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 200+KSafeAreaTopNaviHeight, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-265)];
    _scrollView.showsVerticalScrollIndicator = NO;
//    _scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height+400);
    [self.view addSubview:_scrollView];
    self.leftSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
    self.rightSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
    
    self.leftSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    self.rightSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    
    [self.view addGestureRecognizer:self.leftSwipeGestureRecognizer];
    [self.view addGestureRecognizer:self.rightSwipeGestureRecognizer];
    
    [self initTopView];
    
    [self initOtherView];
    
    _customShareView = [[TuiKuanShuoMingView alloc]init];
    [self.view addSubview:_customShareView];
    
    [self getDatas];
    
}
- (void)handleSwipes:(UISwipeGestureRecognizer *)sender
{
    if (sender.direction == UISwipeGestureRecognizerDirectionLeft) {
        [self BackBtnClick2];
    }
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        
        NSLog(@"右滑");
        [self BackBtnClick1];
    }
}

//创建导航栏
-(void)initNav
{
    self.navigationController.interactivePopGestureRecognizer.enabled=NO;
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
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 27+KSafeTopHeight, [UIScreen mainScreen].bounds.size.width-200, 17)];
    
    label.text = self.GoBackString;
    
    label.textColor = [UIColor blackColor];
    
    label.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:19];
    
    label.textAlignment = NSTextAlignmentCenter;
    
    [titleView addSubview:label];
    
    
    NSArray *string =[self.time componentsSeparatedByString:@"-"];
    
    Date = [[UILabel alloc] initWithFrame:CGRectMake(100, 48+KSafeTopHeight, [UIScreen mainScreen].bounds.size.width-200, 11)];
    Date.text = [NSString stringWithFormat:@"%@-%@ %@",string[1],string[2],self.DateWeek];
    Date.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    Date.font = [UIFont fontWithName:@"PingFang-SC-Light" size:12];
    Date.textAlignment = NSTextAlignmentCenter;
    [titleView addSubview:Date];
    
    CGRect tempRect = [self.GoBackString boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-150,13) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFang-SC-Medium" size:19]} context:nil];
    
    UIImageView *GoBack = [[UIImageView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-tempRect.size.width)/2-10-21, 25+KSafeTopHeight, 21, 21)];
    
//    if ([self.TypeString isEqualToString:@"200"]) {
//        
//        GoBack.image = [UIImage imageNamed:@"icon-qu"];
//        
//    }else if([self.TypeString isEqualToString:@"666"]){
        
        GoBack.image = [UIImage imageNamed:@"icon-fan-hui"];
        
//    }else{
//        
//        GoBack.image = [UIImage imageNamed:@""];
//    }
    
    
    [titleView addSubview:GoBack];
    
    
}


-(void)initTopView
{
    
    UIView *RedView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 118)];
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)[UIColor colorWithRed:255/255.0 green:52/255.0 blue:90/255.0 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0].CGColor];
    gradientLayer.locations = @[@0.0, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1.0);
    gradientLayer.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 118);
    [RedView.layer addSublayer:gradientLayer];
    [TopView addSubview:RedView];
    
    Companylabel = [[UILabel alloc] initWithFrame:CGRectMake(57, 20, 200, 12)];
    Companylabel.text = [NSString stringWithFormat:@"%@%@",self.CarrinerName,self.flightNo];
    Companylabel.textColor = [UIColor whiteColor];
    Companylabel.font = [UIFont fontWithName:@"PingFang-SC-Light" size:12];
    [RedView addSubview:Companylabel];
    
    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(130, 23, 20, 5)];
    line.image = [UIImage imageNamed:@"icon_small-arrow-"];
    //    [RedView addSubview:line];
    
    UILabel *BanCilabel = [[UILabel alloc] initWithFrame:CGRectMake(154, 20, 130, 12)];
    BanCilabel.text = @"实际承运：深航ZH9429";
    BanCilabel.textColor = [UIColor whiteColor];
    BanCilabel.font = [UIFont fontWithName:@"PingFang-SC-Light" size:12];
    //    [RedView addSubview:BanCilabel];
    
    
    UIView *TimeView = [[UIView alloc] initWithFrame:CGRectMake(57, 41, [UIScreen mainScreen].bounds.size.width-114, 18)];
    [RedView addSubview:TimeView];
    
    NSArray *date = [self.Air_OffTime componentsSeparatedByString:@" "];
    NSArray *array = [date[1] componentsSeparatedByString:@":"];
    
    StartTime = [[UILabel alloc] initWithFrame:CGRectMake(0, 4, 100, 14)];
    StartTime.text = [NSString stringWithFormat:@"%@:%@",array[0],array[1]];
    StartTime.textColor = [UIColor whiteColor];
    StartTime.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:18];
    [TimeView addSubview:StartTime];
    
    UIView *NameView = [[UIView alloc] initWithFrame:CGRectMake(0, 65, [UIScreen mainScreen].bounds.size.width, 12)];
    [RedView addSubview:NameView];
    
    StartName = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ([UIScreen mainScreen].bounds.size.width)/2, 12)];
    StartName.text = [NSString stringWithFormat:@"%@%@",self.Air_StartPortName,self.Air_StartT];
    StartName.textColor = [UIColor whiteColor];
    StartName.textAlignment = NSTextAlignmentCenter;
    StartName.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
    [NameView addSubview:StartName];
    
    NSArray *date1 = [self.ArriveTime componentsSeparatedByString:@" "];
    NSArray *array1 = [date1[1] componentsSeparatedByString:@":"];
    
    EndTime = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-114-100, 4, 100, 14)];
    EndTime.text = [NSString stringWithFormat:@"%@:%@",array1[0],array1[1]];
    EndTime.textColor = [UIColor whiteColor];
    EndTime.textAlignment = NSTextAlignmentRight;
    EndTime.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:18];
    [TimeView addSubview:EndTime];
    
    EndName = [[UILabel alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width)/2, 0, ([UIScreen mainScreen].bounds.size.width)/2, 12)];
    EndName.text = [NSString stringWithFormat:@"%@%@",self.Air_EndPortName,self.Air_EndT];
    EndName.textColor = [UIColor whiteColor];
    EndName.textAlignment = NSTextAlignmentCenter;
    EndName.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
    [NameView addSubview:EndName];
    
    longLabel = [[UILabel alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-200-114)/2, 0, 200, 13)];
    longLabel.text = [NSString stringWithFormat:@"%@",self.Air_RunTime];
    longLabel.textColor = [UIColor whiteColor];
    longLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    longLabel.textAlignment = NSTextAlignmentCenter;
    [TimeView addSubview:longLabel];
    
    GOGO = [[UIImageView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-101-114)/2, 10, 101, 8)];
    GOGO.image = [UIImage imageNamed:@"icon_arrow-white"];
    [TimeView addSubview:GOGO];
    
//    if ([self.Air_ByPass isEqualToString:@"1"]) {
//        StopOverLab=[[UILabel alloc]initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-101-114)/2, 65, 200, 13)];
//        StopOverLab.font=KNSFONT(14);
//        StopOverLab.textColor=[UIColor whiteColor];
//        StopOverLab.textAlignment=NSTextAlignmentCenter;
//        StopOverLab.text=@"经停";
//        [RedView addSubview:StopOverLab];
//    }
    
    NSString *Meat;
    
    if ([self.Air_Meat isEqualToString:@"0"]) {
        
        Meat = @"无餐";
        
    }else if ([self.Air_Meat isEqualToString:@"1"]){
        
        Meat = @"有餐";
    }
    
    Datelabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 86, [UIScreen mainScreen].bounds.size.width-100, 13)];
    if ([self.Air_PlaneModel isEqualToString:@""]) {
        
        Datelabel.text = [NSString stringWithFormat:@"%@ | %@",self.Air_PlaneType,Meat];
    }else{
        
        Datelabel.text = [NSString stringWithFormat:@"%@(%@) | %@",self.Air_PlaneType,self.Air_PlaneModel,Meat];
        
    }
    if ([self.Air_ByPass isEqualToString:@"1"]) {
        Datelabel.text=[Datelabel.text stringByAppendingString:@" | 经停"];
    }

    Datelabel.textColor = [UIColor whiteColor];
    Datelabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
    Datelabel.textAlignment = NSTextAlignmentCenter;
    [RedView addSubview:Datelabel];
    
    UIView *ShuoMingView = [[UIView alloc] initWithFrame:CGRectMake(0, 118, [UIScreen mainScreen].bounds.size.width, 32)];
    ShuoMingView.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1.0];
    [TopView addSubview:ShuoMingView];
    
    
    ShuoMing = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, [UIScreen mainScreen].bounds.size.width-30, 12)];
    ShuoMing.text = @"*请在实际乘坐的航空公司柜台办理登记手续";
    ShuoMing.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
    ShuoMing.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
    [ShuoMingView addSubview:ShuoMing];
    
    
    
}
-(void)initOtherView
{
    
    CangTypeView = [[UIView alloc] init];
    CangTypeView.frame = CGRectMake(0, 118+32, [UIScreen mainScreen].bounds.size.width, 50);
    [TopView addSubview:CangTypeView];
    
    label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 19, [UIScreen mainScreen].bounds.size.width/2, 14)];
    label1.text = @"经济舱";
    label1.textColor = [UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
    label1.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15];
    label1.textAlignment = NSTextAlignmentCenter;
    [CangTypeView addSubview:label1];
    
    redImgView1 = [[UIImageView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width/2-51)/2, 47, 51, 3)];
    redImgView1.image = [UIImage imageNamed:@"icon-underline"];
    [CangTypeView addSubview:redImgView1];
    
    UIButton *Backbutton1 = [UIButton buttonWithType:UIButtonTypeCustom];
    Backbutton1.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width/2, 50);
    [Backbutton1 addTarget:self action:@selector(BackBtnClick1) forControlEvents:UIControlEventTouchUpInside];
    [CangTypeView addSubview:Backbutton1];
    
    label2 = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2, 19, [UIScreen mainScreen].bounds.size.width/2, 14)];
    label2.text = @"商务/头等舱";
    label2.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    label2.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15];
    label2.textAlignment = NSTextAlignmentCenter;
    [CangTypeView addSubview:label2];
    
    redImgView2 = [[UIImageView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width/2-101)/2+[UIScreen mainScreen].bounds.size.width/2, 47, 101, 3)];
    redImgView2.image = [UIImage imageNamed:@""];
    [CangTypeView addSubview:redImgView2];
    
    UIButton *Backbutton2 = [UIButton buttonWithType:UIButtonTypeCustom];
    Backbutton2.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2, 0, [UIScreen mainScreen].bounds.size.width/2, 50);
    [Backbutton2 addTarget:self action:@selector(BackBtnClick2) forControlEvents:UIControlEventTouchUpInside];
    [CangTypeView addSubview:Backbutton2];
    
    
    UIImageView *line2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 49, [UIScreen mainScreen].bounds.size.width, 1)];
    line2.image = [UIImage imageNamed:@"分割线-拷贝"];
    [CangTypeView addSubview:line2];
    
    
    
    
    
    
}

-(void)initJinJiView
{
    
    NSLog(@"===AirArray.count===%ld",(long)AirArray.count);
    if ([isChild isEqualToString:@"0"]) {
        TopView.frame=CGRectMake(0, 105, kScreen_Width, 200);
        _scrollView.frame=CGRectMake(0, 305, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-305);
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 65, kScreen_Width, 40)];
        
        view.backgroundColor = RGB(63, 139, 253);
        
        [self.view addSubview:view];
        
        UIImageView *IV=[[UIImageView alloc]initWithFrame:CGRectMake(15, 13.5, 13, 13)];
        IV.image=[UIImage imageNamed:@"icon_hint"];
        [view addSubview:IV];
        
        UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMake(33, 14, kScreen_Width-48, 12)];
        lab.font=KNSFONTM(12);
        lab.textColor=RGB(255, 255, 255);
        lab.text=@"本航班暂不支持购买儿童票";
        [view addSubview:lab];
        
    }
    _scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width,70*AirArray.count+100);
    
    for (int i = 0; i < AirArray.count; i++) {
        
        BianMinModel *model = AirArray[i];
        
        UIView *TypeView = [[UIView alloc] initWithFrame:CGRectMake(0, 70*i, [UIScreen mainScreen].bounds.size.width, 70)];
        TypeView.tag = 200+i;
        [_scrollView addSubview:TypeView];
        
        CGSize size=[[NSString stringWithFormat:@"￥%@",model.Sale] sizeWithFont:KNSFONTM(15) maxSize:CGSizeMake(200, 14)];
        
        UILabel *Price = [[UILabel alloc] initWithFrame:CGRectMake(15, 16, size.width, size.height)];
        Price.text = [NSString stringWithFormat:@"￥%@",model.Sale];
        Price.tag = 300+i;
        Price.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        Price.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:15];
        [TypeView addSubview:Price];
        
//        BOOL ISSPE=[model.IsSpe isEqualToString:@"1"];
//        
//        if (ISSPE) {
//            UILabel *specialOfferLab=[[UILabel alloc]initWithFrame:CGRectMake(15+size.width+5, 21, 27, 12)];
//            specialOfferLab.font=KNSFONTM(10);
//            specialOfferLab.text=@"特价";
//            specialOfferLab.textAlignment=NSTextAlignmentCenter;
//            specialOfferLab.layer.borderWidth=1;
//            specialOfferLab.layer.borderColor=[RGB(255, 93, 94) CGColor];
//            specialOfferLab.textColor=RGB(255, 93, 94);
//            [TypeView addSubview:specialOfferLab];
//        }
        
        //        CGSize textSize1 = [Price.text boundingRectWithSize:CGSizeMake(200, 12) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont fontWithName:@"PingFang-SC-Medium" size:15]} context:nil].size;
        //
        //        UIView *redView = [[UIView alloc] initWithFrame:CGRectMake(15+textSize1.width+5, 19, 27, 16)];
        //        redView.tag = 400+i;
        //        [TypeView addSubview:redView];
        //
        //        UIImageView *RedImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 27, 16)];
        //        RedImgView.image = [UIImage imageNamed:@"square"];
        //        RedImgView.tag = 500+i;
        //        [redView addSubview:RedImgView];
        
        
        
        UILabel *TuiPiaoLabel = [[UILabel alloc] init];
        
        
        
        TuiPiaoLabel.text = [NSString stringWithFormat:@"退票说明"];
        
        CGSize textSize = [TuiPiaoLabel.text boundingRectWithSize:CGSizeMake(200, 12) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont fontWithName:@"PingFang-SC-Light" size:12]} context:nil].size;
        
        TuiPiaoLabel.frame = CGRectMake(15+12+5, 45, textSize.width, 12);
        
        TuiPiaoLabel.tag = 700+i;
        TuiPiaoLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        TuiPiaoLabel.font  =[UIFont fontWithName:@"PingFang-SC-Light" size:12];
        [TypeView addSubview:TuiPiaoLabel];
        
        UIImageView *ImgVIew = [[UIImageView alloc] initWithFrame:CGRectMake(15, 45, 12, 12)];
        ImgVIew.image = [UIImage imageNamed:@"icon_tip"];
        [TypeView addSubview:ImgVIew];
        
        UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMake(32+textSize.width+10, 45, 100, 12)];
        lab.font=KNSFONT(12);
        lab.textColor=RGB(255, 93, 94);
        [TypeView addSubview:lab];
        if ([model.Discount floatValue]<100) {
            lab.text=[NSString stringWithFormat:@"%@折",model.Discount];
        }else
        {
            lab.text=@"全价";
        }
        
        
        
        UIButton *WenHao = [UIButton buttonWithType:UIButtonTypeCustom];
        WenHao.frame = CGRectMake(20, 45, 12+textSize.width, 12);
        WenHao.tag = 800+i;
        //        [WenHao setImage:[UIImage imageNamed:@"icon_tip"] forState:0];
        [WenHao addTarget:self action:@selector(WenHaoBtnCLick:) forControlEvents:UIControlEventTouchUpInside];
        [TypeView addSubview:WenHao];
        
        
        UIButton *Pay = [UIButton buttonWithType:UIButtonTypeCustom];
        Pay.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-70, 20, 50, 30);
        Pay.backgroundColor = [UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
        Pay.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Light" size:14];
        [Pay addTarget:self action:@selector(PayBtnCLick:) forControlEvents:UIControlEventTouchUpInside];
        [Pay setTitle:@"预订" forState:0];
        Pay.layer.cornerRadius = 3;
        Pay.layer.masksToBounds = YES;
        Pay.tag = 100+i;
        [Pay setTitleColor:[UIColor whiteColor] forState:0];
        [TypeView addSubview:Pay];
        
        
        UIImageView *line2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 69, [UIScreen mainScreen].bounds.size.width, 1)];
        line2.tag = 900+i;
        line2.image = [UIImage imageNamed:@"分割线-拷贝"];
        [TypeView addSubview:line2];
        UILabel *TicketLabel = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-70, 55, 50, 10)];
        TicketLabel.text = [NSString stringWithFormat:@"仅剩%@张",model.TicketCount];
        TicketLabel.tag = 600+i;
        TicketLabel.textColor = [UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
        TicketLabel.textAlignment = NSTextAlignmentCenter;
        TicketLabel.font  =KNSFONTM(10);
        [TypeView addSubview:TicketLabel];
        //判断库存
        if ([model.TicketCount intValue] <= 8) {
            
            TicketLabel.hidden=NO;
            
        }else{
            
            TicketLabel.hidden=YES;
        }
    }
    
    
    ShuoMing1 = [[UILabel alloc] initWithFrame:CGRectMake(15, 70*AirArray.count+11, [UIScreen mainScreen].bounds.size.width-30, 12)];
    ShuoMing1.text = @"*机型及准点率信息以实际航班为准";
    ShuoMing1.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
    ShuoMing1.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
    [_scrollView addSubview:ShuoMing1];
    
}


-(void)getDatas
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
    
    loadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    loadView.backgroundColor = [UIColor blackColor];
    
    loadView.alpha = 0.2;
    
    [self.view addSubview:loadView];
    
    NSLog(@"===self.time====%@",self.time);
    NSLog(@"===self.flightNo====%@",self.flightNo);
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@getPlaneTypeList_mob.shtml",URL_Str];
    //saveUserExchange_mob.shtml
    //};
    NSDictionary *dict = @{@"time":self.time,@"flightNo":self.flightNo,@"passenger_type":self.ManOrKidString};
    
    [manager POST:url parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
        NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];
        
        
        if (codeKey && content) {
            NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
            
            NSLog(@"xmlStr==预订数据==%@",xmlStr);
            
            
            NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            //            NSLog(@"分类查看更多书局=%@",dic);
            
            
            
            if ([dic[@"status"] isEqualToString:@"10000"]) {
                
                isChild=[NSString stringWithFormat:@"%@",dic[@"isChild"]];
                //日期
                for (NSDictionary *dict in dic[@"list3"]) {
                    
                    NSString *string = [NSString stringWithFormat:@"%@",dict[@"date"]];
                    
                    NSArray *array = [string componentsSeparatedByString:@"-"];
                    
                    Date.text = [NSString stringWithFormat:@"%@-%@ %@",array[1],array[2],dict[@"week"]];
                    
                }
                
                for (NSDictionary *dict in dic[@"base_list"]) {
                    
                    BianMinModel *model = [[BianMinModel alloc] init];
                    
                    model.Air_AirLineCode = [NSString stringWithFormat:@"%@",dict[@"AirLineCode"]];
                    model.Air_CarrinerName = [NSString stringWithFormat:@"%@",dict[@"CarrinerName"]];
                    model.Air_StartPortName = [NSString stringWithFormat:@"%@",dict[@"StartPortName"]];
                    model.Air_StartPort = [NSString stringWithFormat:@"%@",dict[@"StartPort"]];
                    model.Air_EndPortName = [NSString stringWithFormat:@"%@",dict[@"EndPortName"]];
                    model.Air_EndPort = [NSString stringWithFormat:@"%@",dict[@"EndPort"]];
                    model.Air_FlightNo = [NSString stringWithFormat:@"%@",dict[@"FlightNo"]];
                    model.Air_MinCabin = [NSString stringWithFormat:@"%@",dict[@"MicnCabin"]];
                    model.Air_MinDiscount = [NSString stringWithFormat:@"%@",dict[@"MinDisount"]];
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
                    
                    
                    //下级页面支付
                    self.Pay_run_time = [NSString stringWithFormat:@"%@",dict[@"RunTime"]];
                    self.Pay_start_time = [NSString stringWithFormat:@"%@",dict[@"OffTime"]];
                    self.Pay_arrive_time = [NSString stringWithFormat:@"%@",dict[@"ArriveTime"]];
                    self.Pay_start_airport = [NSString stringWithFormat:@"%@",dict[@"StartPort"]];
                    self.Pay_start_terminal = [NSString stringWithFormat:@"%@",dict[@"StartT"]];
                    self.Pay_arrive_airport = [NSString stringWithFormat:@"%@",dict[@"EndPort"]];
                    self.Pay_arrive_terminal = [NSString stringWithFormat:@"%@",dict[@"EndT"]];
                    self.Pay_airport_flight	= [NSString stringWithFormat:@"%@",dict[@"FlightNo"]];
                    self.Pay_airport_name = [NSString stringWithFormat:@"%@",dict[@"CarrinerName"]];
                    self.Pay_airport_code = [NSString stringWithFormat:@"%@",dict[@"AirLineCode"]];
                    self.Pay_is_quick_meal = [NSString stringWithFormat:@"%@",dict[@"Meat"]];
                    self.Pay_plane_type	= [NSString stringWithFormat:@"%@",dict[@"PlaneModel"]];
                    self.Pay_airrax	= [NSString stringWithFormat:@"%@",dict[@"Tax"]];
                    self.Pay_fuel_oil = [NSString stringWithFormat:@"%@",dict[@"Oil"]];
                    
                    
                    
                    
                    
                    self.OilString = [NSString stringWithFormat:@"机建+燃油:￥%.02f",[model.Air_Oil floatValue]+[model.Air_Tax floatValue]];
                    
                    self.JiJian = [NSString stringWithFormat:@"%d",[model.Air_Oil intValue]+[model.Air_Tax intValue]];
                    [_DataArrM addObject:model];
                }
                
                
                for (NSDictionary *dict in dic[@"list1"]) {
                    
                    BianMinModel *model = [[BianMinModel alloc] init];
                    
                    model.AirLineCode = [NSString stringWithFormat:@"%@",dict[@"AirLineCode"]];
                    model.Cabin = [NSString stringWithFormat:@"%@",dict[@"Cabin"]];
                    model.CabinName = [NSString stringWithFormat:@"%@",dict[@"CabinName"]];
                    model.Discount = [NSString stringWithFormat:@"%@",dict[@"Discount"]];
                    model.IsTeHui = [NSString stringWithFormat:@"%@",dict[@"IsTeHui"]];
                    model.Fare = [NSString stringWithFormat:@"%@",dict[@"Fare"]];
                    model.IsSpe = [NSString stringWithFormat:@"%@",dict[@"IsSpe"]];
                    model.IsSpePolicy = [NSString stringWithFormat:@"%@",dict[@"IsSpePolicy"]];
                    model.Sale = [NSString stringWithFormat:@"%@",dict[@"Sale"]];
                    model.BabySalePrice = [NSString stringWithFormat:@"%@",dict[@"BabySalePrice"]];
                    model.TicketCount = [NSString stringWithFormat:@"%@",dict[@"TicketCount"]];
                    model.TuiGaiQian = [NSString stringWithFormat:@"%@",dict[@"TuiGaiQian"]];
                    model.UserRate = [NSString stringWithFormat:@"%@",dict[@"UserRate"]];
                    model.VTWorteTime = [NSString stringWithFormat:@"%@",dict[@"VTWorteTime"]];
                    model.WorkTime = [NSString stringWithFormat:@"%@",dict[@"WorkTime"]];
                    model.YouHui = [NSString stringWithFormat:@"%@",dict[@"YouHui"]];
                    model.Bookpara = [NSString stringWithFormat:@"%@",dict[@"Bookpara"]];
                    
                    [_JinJiArrM addObject:model];
                    
                    
                }
                
                for (NSDictionary *dict in dic[@"list2"]) {
                    
                    BianMinModel *model = [[BianMinModel alloc] init];
                    
                    model.AirLineCode = [NSString stringWithFormat:@"%@",dict[@"AirLineCode"]];
                    model.Cabin = [NSString stringWithFormat:@"%@",dict[@"Cabin"]];
                    model.CabinName = [NSString stringWithFormat:@"%@",dict[@"CabinName"]];
                    model.Discount = [NSString stringWithFormat:@"%@",dict[@"Discount"]];
                    model.IsTeHui = [NSString stringWithFormat:@"%@",dict[@"IsTeHui"]];
                    model.Fare = [NSString stringWithFormat:@"%@",dict[@"Fare"]];
                    model.IsSpe = [NSString stringWithFormat:@"%@",dict[@"IsSpe"]];
                    model.IsSpePolicy = [NSString stringWithFormat:@"%@",dict[@"IsSpePolicy"]];
                    model.Sale = [NSString stringWithFormat:@"%@",dict[@"Sale"]];
                    model.BabySalePrice = [NSString stringWithFormat:@"%@",dict[@"BabySalePrice"]];
                    model.TicketCount = [NSString stringWithFormat:@"%@",dict[@"TicketCount"]];
                    model.TuiGaiQian = [NSString stringWithFormat:@"%@",dict[@"TuiGaiQian"]];
                    model.UserRate = [NSString stringWithFormat:@"%@",dict[@"UserRate"]];
                    model.VTWorteTime = [NSString stringWithFormat:@"%@",dict[@"VTWorteTime"]];
                    model.WorkTime = [NSString stringWithFormat:@"%@",dict[@"WorkTime"]];
                    model.YouHui = [NSString stringWithFormat:@"%@",dict[@"YouHui"]];
                    model.Bookpara = [NSString stringWithFormat:@"%@",dict[@"Bookpara"]];
                    
                    [_HeaderArrM addObject:model];
                    
                    
                }
                
                [NoView removeFromSuperview];
                [NoImgView removeFromSuperview];
                [NoLabel removeFromSuperview];
                
                AirArray = _JinJiArrM;
                
                [self BackBtnClick1];
                
                ShuoMing.hidden = NO;
                
                
            }else{
                
                
                //                [JRToast showWithText:dic[@"message"] duration:2.0f];
                
                ShuoMing.hidden = YES;
                
                [self initNoView];
            }
            
            
            //            [hud dismiss:YES];
            
            [webView removeFromSuperview];
            [loadView removeFromSuperview];
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        NSLog(@"%@",error);
        //        [hud dismiss:YES];
        
        ShuoMing.hidden = YES;
        
        [self initNoView];
        
        [webView removeFromSuperview];
        
        [loadView removeFromSuperview];
        
    }];
    
}



-(void)initNoView
{
    
    ShuoMing1.hidden=YES;
    
    //    CangTypeView.frame = CGRectMake(0, 118+10, [UIScreen mainScreen].bounds.size.width, 50);
    
    NoView = [[UIView alloc] initWithFrame:CGRectMake(0, (kScreen_Height-265-106)/2, [UIScreen mainScreen].bounds.size.width, 300)];
    [_scrollView addSubview:NoView];
    
    NoImgView = [[UIImageView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-87)/2, 51, 87, 81)];
    NoImgView.image = [UIImage imageNamed:@"icon-seat"];
    [NoView addSubview:NoImgView];
    
    NoLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 142, [UIScreen mainScreen].bounds.size.width-100, 15)];
    NoLabel.text = @"抱歉，该舱位已售完";
    NoLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    NoLabel.textAlignment = NSTextAlignmentCenter;
    NoLabel.font  =[UIFont fontWithName:@"PingFang-SC-Light" size:14];
    [NoView addSubview:NoLabel];
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex==0) {
        
        
        [ShuoMing1 removeFromSuperview];
        
        for (int i = 0; i < AirArray.count; i++) {
            
            UIView *view = (UIView *)[self.view viewWithTag:200+i];
            [view removeFromSuperview];
            
            UILabel *price = (UILabel *)[self.view viewWithTag:300+i];
            [price removeFromSuperview];
            
            UIView *redView = (UIView *)[self.view viewWithTag:400+i];
            [redView removeFromSuperview];
            
            UIImageView *RedImgView = (UIImageView *)[self.view viewWithTag:500+i];
            [RedImgView removeFromSuperview];
            
            UILabel *TicketLabel = (UILabel *)[self.view viewWithTag:600+i];
            [TicketLabel removeFromSuperview];
            
            UILabel *TuiPiaoLabel = (UILabel *)[self.view viewWithTag:700+i];
            [TuiPiaoLabel removeFromSuperview];
            
            UIButton *WenHao = (UIButton *)[self.view viewWithTag:800+i];
            [WenHao removeFromSuperview];
            
            UIImageView *line = (UIImageView *)[self.view viewWithTag:900+i];
            [line removeFromSuperview];
            
            
            UIButton *WenHao1 = (UIButton *)[self.view viewWithTag:100+i];
            [WenHao1 removeFromSuperview];
            
            
        }
        
        
        [NoView removeFromSuperview];
        [NoImgView removeFromSuperview];
        [NoLabel removeFromSuperview];
        
        AirArray = nil;
        
        
        if ([self.PanDuan isEqualToString:@"100"]) {
            
            for (int i =0; i < _JinJiArrM.count; i++) {
                
                
                BianMinModel *model = _JinJiArrM[i];
                
                if (i == [self.TagString intValue]) {
                    
                    
                    model.Sale = [NSString stringWithFormat:@"%@",self.fares];
                    
                }
            }
            
            
            AirArray = _JinJiArrM;
            
            [self initJinJiView];
            
        }else{
            
            for (int i =0; i < _HeaderArrM.count; i++) {
                
                
                BianMinModel *model = _HeaderArrM[i];
                
                if (i == [self.TagString intValue]) {
                    
                    
                    model.Sale = [NSString stringWithFormat:@"%@",self.fares];
                    
                }
            }
            
            
            AirArray = _HeaderArrM;
            
            [self initJinJiView];
        }
        
        
    }else{
        
        [ShuoMing1 removeFromSuperview];
        
        for (int i = 0; i < AirArray.count; i++) {
            
            UIView *view = (UIView *)[self.view viewWithTag:200+i];
            [view removeFromSuperview];
            
            UILabel *price = (UILabel *)[self.view viewWithTag:300+i];
            [price removeFromSuperview];
            
            UIView *redView = (UIView *)[self.view viewWithTag:400+i];
            [redView removeFromSuperview];
            
            UIImageView *RedImgView = (UIImageView *)[self.view viewWithTag:500+i];
            [RedImgView removeFromSuperview];
            
            UILabel *TicketLabel = (UILabel *)[self.view viewWithTag:600+i];
            [TicketLabel removeFromSuperview];
            
            UILabel *TuiPiaoLabel = (UILabel *)[self.view viewWithTag:700+i];
            [TuiPiaoLabel removeFromSuperview];
            
            UIButton *WenHao = (UIButton *)[self.view viewWithTag:800+i];
            [WenHao removeFromSuperview];
            
            UIImageView *line = (UIImageView *)[self.view viewWithTag:900+i];
            [line removeFromSuperview];
            
            
            UIButton *WenHao1 = (UIButton *)[self.view viewWithTag:100+i];
            [WenHao1 removeFromSuperview];
        }
        
        
        [NoView removeFromSuperview];
        [NoImgView removeFromSuperview];
        [NoLabel removeFromSuperview];
        
        AirArray = nil;
        
        
        if ([self.PanDuan isEqualToString:@"100"]) {
            
            for (int i =0; i < _JinJiArrM.count; i++) {
                
                
                BianMinModel *model = _JinJiArrM[i];
                
                if (i == [self.TagString intValue]) {
                    
                    
                    model.Sale = [NSString stringWithFormat:@"%@",self.fares];
                    
                    //                    self.Pay_price = [NSString stringWithFormat:@"%@",model.Fare];
                    //                    self.fare = model.Fare;
                    
                    self.Price = model.Sale;
                    
                }
            }
            
            
            AirArray = _JinJiArrM;
            
            [self initJinJiView];
            
        }else{
            
            for (int i =0; i < _HeaderArrM.count; i++) {
                
                
                BianMinModel *model = _HeaderArrM[i];
                
                if (i == [self.TagString intValue]) {
                    
                    
                    model.Sale = [NSString stringWithFormat:@"%@",self.fares];
                    
                    //                    self.Pay_price = [NSString stringWithFormat:@"%@",model.Fare];
                    //                    self.fare = model.Fare;
                    
                    self.Price = model.Sale;
                    
                }
            }
            
            
            AirArray = _HeaderArrM;
            
            [self initJinJiView];
        }
        
        //单程
        if ([self.TypeString isEqualToString:@"200"]) {
            
            NSLog(@"选择的返程");
            
            
//            if (_delegate && [_delegate respondsToSelector:@selector(AirPlaneDetailBack)]) {
//                
//                [_delegate AirPlaneDetailBack];
//            }
//            
//            //缓存第一次选择航班数据
//            [RecordAirManger AirGo:self.time Week:self.DateWeek Time:self.Air_OffTime Price:self.Price JiJian:self.JiJian StartCity:self.GoBackString EndCity:self.GoBackString FlightNo:self.flightNo];
//            
//            NSString *plane_type;
//            
//            if ([self.Pay_plane_type isEqualToString:@"小"]) {
//                
//                plane_type = @"0";
//                
//            }else if ([self.Pay_plane_type isEqualToString:@"中"]){
//                
//                plane_type = @"1";
//            }else if ([self.Pay_plane_type isEqualToString:@"大"]){
//                
//                plane_type = @"2";
//            }else{
//                
//                plane_type = @"-1";
//            }
//            
//            [RecordAirManger run_time:self.Pay_run_time start_time:self.Pay_start_time arrive_time:self.Pay_arrive_time start_airport:self.Pay_start_airport start_terminal:self.Pay_start_terminal arrive_airport:self.Pay_arrive_airport arrive_terminal:self.Pay_arrive_terminal airport_flight:self.Pay_airport_flight airport_name:self.Pay_airport_name airport_code:self.Pay_airport_code is_quick_meal:self.Pay_is_quick_meal plane_type:plane_type airrax:self.Pay_airrax fuel_oil:self.Pay_fuel_oil is_tehui:self.Pay_is_tehui is_spe:self.Pay_is_spe price:self.Pay_price cabin:self.Pay_cabin bookpara:self.Pay_bookpara shipping_space:self.Pay_shipping_space];
//            
//            [self.navigationController popViewControllerAnimated:NO];
            
        }else if([self.TypeString isEqualToString:@"666"]){
            
            
            if (self.sigen.length==0) {
                
                ATHLoginViewController *vc=[[ATHLoginViewController alloc] init];
                vc.delegate=self;
                vc.backString=@"618";
                
                vc.Text = self.Text;
                
                
                vc.time = self.time;
                vc.flightNo = self.flightNo;
                vc.GoBackString = self.GoBackString;
                vc.CarrinerName = self.CarrinerName;
                vc.Air_OffTime = self.Air_OffTime;
                vc.ArriveTime = self.ArriveTime;
                vc.Air_RunTime = self.Air_RunTime;
                vc.Air_StartT = self.Air_StartT;
                vc.Air_EndT = self.Air_EndT;
                vc.Air_Meat = self.Air_Meat;
                vc.Air_PlaneType = self.Air_PlaneType;
                vc.Air_PlaneModel = self.Air_PlaneModel;
                vc.Air_StartPortName = self.Air_StartPortName;
                vc.Air_EndPortName = self.Air_EndPortName;
                vc.DateWeek = self.DateWeek;
                vc.TypeString = self.TypeString;
                vc.OilString = self.OilString;
                vc.Money = [NSString stringWithFormat:@"%d",[self.JiJian intValue] + [self.Price intValue]];
                vc.RanYou = [NSString stringWithFormat:@"%d",[self.JiJian intValue]];
                vc.Price = self.Price;
                vc.TicketString = self.TicketString;
                vc.ManOrKidString = self.ManOrKidString;
                
                //支付参数
                vc.Pay_shipping_space = self.Pay_shipping_space;
                vc.Pay_is_tehui = self.Pay_is_tehui;
                vc.Pay_is_spe = self.Pay_is_spe;
                vc.Pay_price = self.Pay_price;
                vc.Pay_cabin = self.Pay_cabin;
                vc.Pay_bookpara = self.Pay_bookpara;
                vc.Pay_run_time = self.Pay_run_time;
                vc.Pay_start_time = self.Pay_start_time;
                vc.Pay_arrive_time = self.Pay_arrive_time;
                vc.Pay_start_airport = self.Pay_start_airport;
                vc.Pay_start_terminal = self.Pay_start_terminal;
                vc.Pay_arrive_airport = self.Pay_arrive_airport;
                vc.Pay_arrive_terminal = self.Pay_arrive_terminal;
                vc.Pay_airport_flight = self.Pay_airport_flight;
                vc.Pay_airport_name = self.Pay_airport_name;
                vc.Pay_airport_code = self.Pay_airport_code;
                vc.Pay_is_quick_meal = self.Pay_is_quick_meal;
                vc.Pay_plane_type = self.Pay_plane_type;
                vc.Pay_airrax = self.Pay_airrax;
                vc.Pay_fuel_oil = self.Pay_fuel_oil;
                vc.refund_instructions = self.refund_instructions;
                
                
                [self.navigationController pushViewController:vc animated:NO];
                
                self.navigationController.navigationBar.hidden=YES;
                
            }else{
                
                
                AirPlaneReserveGoBackViewController *vc = [[AirPlaneReserveGoBackViewController alloc] init];
                
                vc.Text = self.Text;
                vc.time = self.time;
                vc.flightNo = self.flightNo;
                vc.GoBackString = self.GoBackString;
                vc.CarrinerName = self.CarrinerName;
                vc.Air_OffTime = self.Air_OffTime;
                vc.ArriveTime = self.ArriveTime;
                vc.Air_RunTime = self.Air_RunTime;
                vc.Air_StartT = self.Air_StartT;
                vc.Air_EndT = self.Air_EndT;
                vc.Air_Meat = self.Air_Meat;
                vc.Air_PlaneType = self.Air_PlaneType;
                vc.Air_PlaneModel = self.Air_PlaneModel;
                vc.Air_StartPortName = self.Air_StartPortName;
                vc.Air_EndPortName = self.Air_EndPortName;
                vc.DateWeek = self.DateWeek;
                vc.TypeString = self.TypeString;
                vc.OilString = self.OilString;
                vc.Price = self.Price;
                vc.TicketString = self.TicketString;
                vc.Money = [NSString stringWithFormat:@"%d",[self.JiJian intValue] + [self.Price intValue]];
                vc.RanYou = [NSString stringWithFormat:@"%d",[self.JiJian intValue]];
                vc.ManOrKidString = self.ManOrKidString;
                
                //支付参数
                vc.Pay_shipping_space = self.Pay_shipping_space;
                vc.Pay_is_tehui = self.Pay_is_tehui;
                vc.Pay_is_spe = self.Pay_is_spe;
                vc.Pay_price = self.Pay_price;
                vc.Pay_cabin = self.Pay_cabin;
                vc.Pay_bookpara = self.Pay_bookpara;
                vc.Pay_run_time = self.Pay_run_time;
                vc.Pay_start_time = self.Pay_start_time;
                vc.Pay_arrive_time = self.Pay_arrive_time;
                vc.Pay_start_airport = self.Pay_start_airport;
                vc.Pay_start_terminal = self.Pay_start_terminal;
                vc.Pay_arrive_airport = self.Pay_arrive_airport;
                vc.Pay_arrive_terminal = self.Pay_arrive_terminal;
                vc.Pay_airport_flight = self.Pay_airport_flight;
                vc.Pay_airport_name = self.Pay_airport_name;
                vc.Pay_airport_code = self.Pay_airport_code;
                vc.Pay_is_quick_meal = self.Pay_is_quick_meal;
                vc.Pay_plane_type = self.Pay_plane_type;
                vc.Pay_airrax = self.Pay_airrax;
                vc.Pay_fuel_oil = self.Pay_fuel_oil;
                vc.refund_instructions = self.refund_instructions;
                
                [self.navigationController pushViewController:vc animated:NO];
                self.navigationController.navigationBar.hidden=YES;
                
            }
            
            
        }else{
            
            NSLog(@"选择的单程");
            
            
            if (self.sigen.length==0) {
                
                ATHLoginViewController *vc=[[ATHLoginViewController alloc] init];
                vc.delegate=self;
                vc.backString=@"612";
                
                vc.Text = self.Text;
                
                
                vc.time = self.time;
                vc.flightNo = self.flightNo;
                vc.GoBackString = self.GoBackString;
                vc.CarrinerName = self.CarrinerName;
                vc.Air_OffTime = self.Air_OffTime;
                vc.ArriveTime = self.ArriveTime;
                vc.Air_RunTime = self.Air_RunTime;
                vc.Air_StartT = self.Air_StartT;
                vc.Air_EndT = self.Air_EndT;
                vc.Air_Meat = self.Air_Meat;
                vc.Air_PlaneType = self.Air_PlaneType;
                vc.Air_PlaneModel = self.Air_PlaneModel;
                vc.Air_StartPortName = self.Air_StartPortName;
                vc.Air_EndPortName = self.Air_EndPortName;
                vc.DateWeek = self.DateWeek;
                vc.TypeString = self.TypeString;
                vc.OilString = self.OilString;
                vc.Money = [NSString stringWithFormat:@"%d",[self.JiJian intValue] + [self.Price intValue]];
                vc.RanYou = [NSString stringWithFormat:@"%d",[self.JiJian intValue]];
                vc.Price = self.Price;
                vc.TicketString = self.TicketString;
                vc.ManOrKidString = self.ManOrKidString;
                
                //支付参数
                vc.Pay_shipping_space = self.Pay_shipping_space;
                vc.Pay_is_tehui = self.Pay_is_tehui;
                vc.Pay_is_spe = self.Pay_is_spe;
                vc.Pay_price = self.Pay_price;
                vc.Pay_cabin = self.Pay_cabin;
                vc.Pay_bookpara = self.Pay_bookpara;
                vc.Pay_run_time = self.Pay_run_time;
                vc.Pay_start_time = self.Pay_start_time;
                vc.Pay_arrive_time = self.Pay_arrive_time;
                vc.Pay_start_airport = self.Pay_start_airport;
                vc.Pay_start_terminal = self.Pay_start_terminal;
                vc.Pay_arrive_airport = self.Pay_arrive_airport;
                vc.Pay_arrive_terminal = self.Pay_arrive_terminal;
                vc.Pay_airport_flight = self.Pay_airport_flight;
                vc.Pay_airport_name = self.Pay_airport_name;
                vc.Pay_airport_code = self.Pay_airport_code;
                vc.Pay_is_quick_meal = self.Pay_is_quick_meal;
                vc.Pay_plane_type = self.Pay_plane_type;
                vc.Pay_airrax = self.Pay_airrax;
                vc.Pay_fuel_oil = self.Pay_fuel_oil;
                vc.refund_instructions = self.refund_instructions;
                
                
                [self.navigationController pushViewController:vc animated:NO];
                
                self.navigationController.navigationBar.hidden=YES;
                
            }else{
                
                
                AirPlaneReserveViewController *vc = [[AirPlaneReserveViewController alloc] init];
                vc.Text = self.Text;
                vc.time = self.time;
                vc.flightNo = self.flightNo;
                vc.GoBackString = self.GoBackString;
                vc.CarrinerName = self.CarrinerName;
                vc.Air_OffTime = self.Air_OffTime;
                vc.ArriveTime = self.ArriveTime;
                vc.Air_RunTime = self.Air_RunTime;
                vc.Air_StartT = self.Air_StartT;
                vc.Air_EndT = self.Air_EndT;
                vc.Air_Meat = self.Air_Meat;
                vc.Air_PlaneType = self.Air_PlaneType;
                vc.Air_PlaneModel = self.Air_PlaneModel;
                vc.Air_StartPortName = self.Air_StartPortName;
                vc.Air_EndPortName = self.Air_EndPortName;
                vc.DateWeek = self.DateWeek;
                vc.TypeString = self.TypeString;
                vc.OilString = self.OilString;
                vc.Price = self.Price;
                vc.TicketString = self.TicketString;
                vc.Money = [NSString stringWithFormat:@"%d",[self.JiJian intValue] + [self.Price intValue]];
                vc.RanYou = [NSString stringWithFormat:@"%d",[self.JiJian intValue]];
                vc.ManOrKidString = self.ManOrKidString;
                
                //支付参数
                vc.Pay_shipping_space = self.Pay_shipping_space;
                vc.Pay_is_tehui = self.Pay_is_tehui;
                vc.Pay_is_spe = self.Pay_is_spe;
                vc.Pay_price = self.Pay_price;
                vc.Pay_cabin = self.Pay_cabin;
                vc.Pay_bookpara = self.Pay_bookpara;
                vc.Pay_run_time = self.Pay_run_time;
                vc.Pay_start_time = self.Pay_start_time;
                vc.Pay_arrive_time = self.Pay_arrive_time;
                vc.Pay_start_airport = self.Pay_start_airport;
                vc.Pay_start_terminal = self.Pay_start_terminal;
                vc.Pay_arrive_airport = self.Pay_arrive_airport;
                vc.Pay_arrive_terminal = self.Pay_arrive_terminal;
                vc.Pay_airport_flight = self.Pay_airport_flight;
                vc.Pay_airport_name = self.Pay_airport_name;
                vc.Pay_airport_code = self.Pay_airport_code;
                vc.Pay_is_quick_meal = self.Pay_is_quick_meal;
                vc.Pay_plane_type = self.Pay_plane_type;
                vc.Pay_airrax = self.Pay_airrax;
                vc.Pay_fuel_oil = self.Pay_fuel_oil;
                vc.refund_instructions = self.refund_instructions;
                
                [self.navigationController pushViewController:vc animated:NO];
                self.navigationController.navigationBar.hidden=YES;
            }
            
        }
        
    }
}
//判断票价改变
-(void)getPriceChange
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
    
    loadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    loadView.backgroundColor = [UIColor blackColor];
    
    loadView.alpha = 0.2;
    
    [self.view addSubview:loadView];
    
    NSLog(@"===self.time====%@",self.time);
    NSLog(@"===self.flightNo====%@",self.flightNo);
    NSLog(@"===self.start_code====%@",self.start_code);
    NSLog(@"===self.arrive_code====%@",self.arrive_code);
    NSLog(@"===self.cabin====%@",self.cabin);
    NSLog(@"===self.fare====%@",self.fare);
    NSLog(@"===self.isspe====%@",self.isspe);
    NSLog(@"===self.istehui====%@",self.istehui);
    NSLog(@"===StartTime.text====%@",StartTime.text);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@reservationAirTicket_mob.shtml",URL_Str];
    //saveUserExchange_mob.shtml
    
    NSDictionary *dict = @{@"time":self.time,@"flightno":self.flightNo,@"start_code":self.start_code,@"arrive_code":self.arrive_code,@"cabin":self.cabin,@"fare":self.fare,@"isspe":self.isspe,@"istehui":self.istehui,@"stime":StartTime.text,@"passenger_type":self.ManOrKidString};
    
    [manager POST:url parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
        NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];
        
        
        if (codeKey && content) {
            NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
            
            NSLog(@"xmlStr=价格改变=%@",xmlStr);
            
            
            NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            //            NSLog(@"分类查看更多书局=%@",dic);
            
            
            
            if ([dic[@"status"] isEqualToString:@"10000"]) {
                
                NSString *canbook = [NSString stringWithFormat:@"%@",dic[@"canbook"]];
                self.fares = [NSString stringWithFormat:@"%@",dic[@"fares"]];
                
                //价格没有变动
                if ([canbook isEqualToString:@"0"]) {
                    
                    
                    //单程
                    if ([self.TypeString isEqualToString:@"200"]) {
                        
                        
                    }else if([self.TypeString isEqualToString:@"666"]){
                        
                        
                        if (self.sigen.length==0) {
                            
                            ATHLoginViewController *vc=[[ATHLoginViewController alloc] init];
                            vc.delegate=self;
                            vc.backString=@"618";
                            
                            vc.Text = self.Text;
                            
                            
                            vc.time = self.time;
                            vc.flightNo = self.flightNo;
                            vc.GoBackString = self.GoBackString;
                            vc.CarrinerName = self.CarrinerName;
                            vc.Air_OffTime = self.Air_OffTime;
                            vc.ArriveTime = self.ArriveTime;
                            vc.Air_RunTime = self.Air_RunTime;
                            vc.Air_StartT = self.Air_StartT;
                            vc.Air_EndT = self.Air_EndT;
                            vc.Air_Meat = self.Air_Meat;
                            vc.Air_PlaneType = self.Air_PlaneType;
                            vc.Air_PlaneModel = self.Air_PlaneModel;
                            vc.Air_StartPortName = self.Air_StartPortName;
                            vc.Air_EndPortName = self.Air_EndPortName;
                            vc.DateWeek = self.DateWeek;
                            vc.TypeString = self.TypeString;
                            vc.OilString = self.OilString;
                            vc.Money = [NSString stringWithFormat:@"%d",[self.JiJian intValue] + [self.Price intValue]];
                            vc.RanYou = [NSString stringWithFormat:@"%d",[self.JiJian intValue]];
                            vc.Price = self.Price;
                            vc.TicketString = self.TicketString;
                            vc.ManOrKidString = self.ManOrKidString;
                            vc.Air_ByPass=self.Air_ByPass;
                            //支付参数
                            vc.Pay_shipping_space = self.Pay_shipping_space;
                            vc.Pay_is_tehui = self.Pay_is_tehui;
                            vc.Pay_is_spe = self.Pay_is_spe;
                            vc.Pay_price = self.Pay_price;
                            vc.Pay_cabin = self.Pay_cabin;
                            vc.Pay_bookpara = self.Pay_bookpara;
                            vc.Pay_run_time = self.Pay_run_time;
                            vc.Pay_start_time = self.Pay_start_time;
                            vc.Pay_arrive_time = self.Pay_arrive_time;
                            vc.Pay_start_airport = self.Pay_start_airport;
                            vc.Pay_start_terminal = self.Pay_start_terminal;
                            vc.Pay_arrive_airport = self.Pay_arrive_airport;
                            vc.Pay_arrive_terminal = self.Pay_arrive_terminal;
                            vc.Pay_airport_flight = self.Pay_airport_flight;
                            vc.Pay_airport_name = self.Pay_airport_name;
                            vc.Pay_airport_code = self.Pay_airport_code;
                            vc.Pay_is_quick_meal = self.Pay_is_quick_meal;
                            vc.Pay_plane_type = self.Pay_plane_type;
                            vc.Pay_airrax = self.Pay_airrax;
                            vc.Pay_fuel_oil = self.Pay_fuel_oil;
                            vc.refund_instructions = self.refund_instructions;
                            
                            
                            [self.navigationController pushViewController:vc animated:NO];
                            
                            self.navigationController.navigationBar.hidden=YES;
                            
                        }else{
                            
                            AirPlaneReserveGoBackViewController *vc = [[AirPlaneReserveGoBackViewController alloc] init];
                            
                            vc.Text = self.Text;
                            
                            
                            vc.time = self.time;
                            vc.flightNo = self.flightNo;
                            vc.GoBackString = self.GoBackString;
                            vc.CarrinerName = self.CarrinerName;
                            vc.Air_OffTime = self.Air_OffTime;
                            vc.ArriveTime = self.ArriveTime;
                            vc.Air_RunTime = self.Air_RunTime;
                            vc.Air_StartT = self.Air_StartT;
                            vc.Air_EndT = self.Air_EndT;
                            vc.Air_Meat = self.Air_Meat;
                            vc.Air_PlaneType = self.Air_PlaneType;
                            vc.Air_PlaneModel = self.Air_PlaneModel;
                            vc.Air_StartPortName = self.Air_StartPortName;
                            vc.Air_EndPortName = self.Air_EndPortName;
                            vc.DateWeek = self.DateWeek;
                            vc.TypeString = self.TypeString;
                            vc.OilString = self.OilString;
                            vc.Money = [NSString stringWithFormat:@"%d",[self.JiJian intValue] + [self.Price intValue]];
                            vc.RanYou = [NSString stringWithFormat:@"%d",[self.JiJian intValue]];
                            vc.Price = self.Price;
                            vc.TicketString = self.TicketString;
                            vc.ManOrKidString = self.ManOrKidString;
                            
                            vc.Air_ByPass=self.Air_ByPass;
                            //支付参数
                            vc.Pay_shipping_space = self.Pay_shipping_space;
                            vc.Pay_is_tehui = self.Pay_is_tehui;
                            vc.Pay_is_spe = self.Pay_is_spe;
                            vc.Pay_price = self.Pay_price;
                            vc.Pay_cabin = self.Pay_cabin;
                            vc.Pay_bookpara = self.Pay_bookpara;
                            vc.Pay_run_time = self.Pay_run_time;
                            vc.Pay_start_time = self.Pay_start_time;
                            vc.Pay_arrive_time = self.Pay_arrive_time;
                            vc.Pay_start_airport = self.Pay_start_airport;
                            vc.Pay_start_terminal = self.Pay_start_terminal;
                            vc.Pay_arrive_airport = self.Pay_arrive_airport;
                            vc.Pay_arrive_terminal = self.Pay_arrive_terminal;
                            vc.Pay_airport_flight = self.Pay_airport_flight;
                            vc.Pay_airport_name = self.Pay_airport_name;
                            vc.Pay_airport_code = self.Pay_airport_code;
                            vc.Pay_is_quick_meal = self.Pay_is_quick_meal;
                            vc.Pay_plane_type = self.Pay_plane_type;
                            vc.Pay_airrax = self.Pay_airrax;
                            vc.Pay_fuel_oil = self.Pay_fuel_oil;
                            vc.refund_instructions = self.refund_instructions;
                            
                            [self.navigationController pushViewController:vc animated:NO];
                            self.navigationController.navigationBar.hidden=YES;
                            
                        }
                        
                        
                    }else{
                        
                        NSLog(@"选择的单程");
                        
                        
                        if (self.sigen.length==0) {
                            
                            ATHLoginViewController *vc=[[ATHLoginViewController alloc] init];
                            vc.delegate=self;
                            vc.backString=@"612";
                            
                            vc.Text = self.Text;
                            
                            
                            vc.time = self.time;
                            vc.flightNo = self.flightNo;
                            vc.GoBackString = self.GoBackString;
                            vc.CarrinerName = self.CarrinerName;
                            vc.Air_OffTime = self.Air_OffTime;
                            vc.ArriveTime = self.ArriveTime;
                            vc.Air_RunTime = self.Air_RunTime;
                            vc.Air_StartT = self.Air_StartT;
                            vc.Air_EndT = self.Air_EndT;
                            vc.Air_Meat = self.Air_Meat;
                            vc.Air_PlaneType = self.Air_PlaneType;
                            vc.Air_PlaneModel = self.Air_PlaneModel;
                            vc.Air_StartPortName = self.Air_StartPortName;
                            vc.Air_EndPortName = self.Air_EndPortName;
                            vc.DateWeek = self.DateWeek;
                            vc.TypeString = self.TypeString;
                            vc.OilString = self.OilString;
                            vc.Money = [NSString stringWithFormat:@"%d",[self.JiJian intValue] + [self.Price intValue]];
                            vc.RanYou = [NSString stringWithFormat:@"%d",[self.JiJian intValue]];
                            vc.Price = self.Price;
                            vc.TicketString = self.TicketString;
                            vc.ManOrKidString = self.ManOrKidString;
                            vc.Air_ByPass=self.Air_ByPass;
                            //支付参数
                            vc.Pay_shipping_space = self.Pay_shipping_space;
                            vc.Pay_is_tehui = self.Pay_is_tehui;
                            vc.Pay_is_spe = self.Pay_is_spe;
                            vc.Pay_price = self.Pay_price;
                            vc.Pay_cabin = self.Pay_cabin;
                            vc.Pay_bookpara = self.Pay_bookpara;
                            vc.Pay_run_time = self.Pay_run_time;
                            vc.Pay_start_time = self.Pay_start_time;
                            vc.Pay_arrive_time = self.Pay_arrive_time;
                            vc.Pay_start_airport = self.Pay_start_airport;
                            vc.Pay_start_terminal = self.Pay_start_terminal;
                            vc.Pay_arrive_airport = self.Pay_arrive_airport;
                            vc.Pay_arrive_terminal = self.Pay_arrive_terminal;
                            vc.Pay_airport_flight = self.Pay_airport_flight;
                            vc.Pay_airport_name = self.Pay_airport_name;
                            vc.Pay_airport_code = self.Pay_airport_code;
                            vc.Pay_is_quick_meal = self.Pay_is_quick_meal;
                            vc.Pay_plane_type = self.Pay_plane_type;
                            vc.Pay_airrax = self.Pay_airrax;
                            vc.Pay_fuel_oil = self.Pay_fuel_oil;
                            vc.refund_instructions = self.refund_instructions;
                            
                            
                            [self.navigationController pushViewController:vc animated:NO];
                            
                            self.navigationController.navigationBar.hidden=YES;
                            
                        }else{
                            
                            AirPlaneReserveViewController *vc = [[AirPlaneReserveViewController alloc] init];
                            vc.Text = self.Text;
                            
                            
                            vc.time = self.time;
                            vc.flightNo = self.flightNo;
                            vc.GoBackString = self.GoBackString;
                            vc.CarrinerName = self.CarrinerName;
                            vc.Air_OffTime = self.Air_OffTime;
                            vc.ArriveTime = self.ArriveTime;
                            vc.Air_RunTime = self.Air_RunTime;
                            vc.Air_StartT = self.Air_StartT;
                            vc.Air_EndT = self.Air_EndT;
                            vc.Air_Meat = self.Air_Meat;
                            vc.Air_PlaneType = self.Air_PlaneType;
                            vc.Air_PlaneModel = self.Air_PlaneModel;
                            vc.Air_StartPortName = self.Air_StartPortName;
                            vc.Air_EndPortName = self.Air_EndPortName;
                            vc.DateWeek = self.DateWeek;
                            vc.TypeString = self.TypeString;
                            vc.OilString = self.OilString;
                            vc.Money = [NSString stringWithFormat:@"%d",[self.JiJian intValue] + [self.Price intValue]];
                            vc.RanYou = [NSString stringWithFormat:@"%d",[self.JiJian intValue]];
                            vc.Price = self.Price;
                            vc.TicketString = self.TicketString;
                            vc.ManOrKidString = self.ManOrKidString;
                            vc.Air_ByPass=self.Air_ByPass;
                            //支付参数
                            vc.Pay_shipping_space = self.Pay_shipping_space;
                            vc.Pay_is_tehui = self.Pay_is_tehui;
                            vc.Pay_is_spe = self.Pay_is_spe;
                            vc.Pay_price = self.Pay_price;
                            vc.Pay_cabin = self.Pay_cabin;
                            vc.Pay_bookpara = self.Pay_bookpara;
                            vc.Pay_run_time = self.Pay_run_time;
                            vc.Pay_start_time = self.Pay_start_time;
                            vc.Pay_arrive_time = self.Pay_arrive_time;
                            vc.Pay_start_airport = self.Pay_start_airport;
                            vc.Pay_start_terminal = self.Pay_start_terminal;
                            vc.Pay_arrive_airport = self.Pay_arrive_airport;
                            vc.Pay_arrive_terminal = self.Pay_arrive_terminal;
                            vc.Pay_airport_flight = self.Pay_airport_flight;
                            vc.Pay_airport_name = self.Pay_airport_name;
                            vc.Pay_airport_code = self.Pay_airport_code;
                            vc.Pay_is_quick_meal = self.Pay_is_quick_meal;
                            vc.Pay_plane_type = self.Pay_plane_type;
                            vc.Pay_airrax = self.Pay_airrax;
                            vc.Pay_fuel_oil = self.Pay_fuel_oil;
                            vc.refund_instructions = self.refund_instructions;
                            
                            [self.navigationController pushViewController:vc animated:NO];
                            self.navigationController.navigationBar.hidden=YES;
                            
                        }
                        
                    }
                    
                    
                }else{
                    
                    
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"该航班价格已变更为￥%@\n确定继续购买?",self.fares] message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                    
                    [alert show];
                    
                    
                    
                    
                }
                
                
                
                
            }else{
                
                
                [JRToast showWithText:dic[@"message"] duration:2.0f];
                
            }
            
            
            [webView removeFromSuperview];
            [loadView removeFromSuperview];
            
            //            [hud dismiss:YES];
            
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        NSLog(@"%@",error);
        //        [hud dismiss:YES];
        
        [webView removeFromSuperview];
        [loadView removeFromSuperview];
        
    }];
    
}

//登录返回代理
-(void)LoginToBackCrat:(NSString *)sigen
{
    
    self.sigen = sigen;
    
}
//预定
-(void)PayBtnCLick:(UIButton *)sender
{
    
    
    BianMinModel *model = AirArray[sender.tag-100];
    
    NSLog(@"===model.Sale===%@==model.CabinName==%@",model.Sale,model.CabinName);
    
    self.TagString = [NSString stringWithFormat:@"%ld",sender.tag-100];
    
    if ([model.CabinName isEqualToString:@"经济舱"]) {
        
        self.Pay_shipping_space = @"0";
        
    }else if ([model.CabinName isEqualToString:@"商务舱"]){
        
        self.Pay_shipping_space = @"1";
    }
    self.Pay_is_tehui = [NSString stringWithFormat:@"%@",model.IsTeHui];
    self.Pay_is_spe = [NSString stringWithFormat:@"%@",model.IsSpe];
    self.Pay_price = [NSString stringWithFormat:@"%@",model.Fare];
    self.Pay_cabin = [NSString stringWithFormat:@"%@",model.Cabin];
    self.Pay_bookpara = [NSString stringWithFormat:@"%@",model.Bookpara];
    
    self.cabin = model.Cabin;
    self.fare = model.Fare;
    self.isspe = model.IsSpe;
    self.istehui = [NSString stringWithFormat:@"%@",model.IsTeHui];
    self.TicketString = model.TicketCount;
    self.Price = model.Sale;
    self.refund_instructions = [NSString stringWithFormat:@"%@",model.TuiGaiQian];
    
    if ([model.TuiGaiQian containsString:@"\n"]) {
        
        NSString *string = [model.TuiGaiQian stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        
        self.Text = string;
    }else{
        
        
        self.Text = model.TuiGaiQian;
    }
    
    [self getPriceChange];
    
    
    
    
    
    
    
}

-(void)WenHaoBtnCLick:(UIButton *)sender
{
    BianMinModel *model = AirArray[sender.tag-800];
    
    if ([model.TuiGaiQian containsString:@"\n"]) {
        
        NSString *string = [model.TuiGaiQian stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        
        _customShareView.Text = string;
        
        [_customShareView showInView:self.view Text:string];
        
    }else{
        
        
        _customShareView.Text = model.TuiGaiQian;
        
        [_customShareView showInView:self.view Text:model.TuiGaiQian];
        
    }
    
    
    
}
-(void)BackBtnClick2
{
    self.PanDuan = @"200";
    
    redImgView1.image = [UIImage imageNamed:@""];
    label1.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    
    label2.textColor = [UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
    redImgView2.image = [UIImage imageNamed:@"icon-underline"];
    
    [ShuoMing1 removeFromSuperview];
    
    for (int i = 0; i < AirArray.count; i++) {
        
        UIView *view = (UIView *)[self.view viewWithTag:200+i];
        [view removeFromSuperview];
        
        UILabel *price = (UILabel *)[self.view viewWithTag:300+i];
        [price removeFromSuperview];
        
        UIView *redView = (UIView *)[self.view viewWithTag:400+i];
        [redView removeFromSuperview];
        
        UIImageView *RedImgView = (UIImageView *)[self.view viewWithTag:500+i];
        [RedImgView removeFromSuperview];
        
        UILabel *TicketLabel = (UILabel *)[self.view viewWithTag:600+i];
        [TicketLabel removeFromSuperview];
        
        UILabel *TuiPiaoLabel = (UILabel *)[self.view viewWithTag:700+i];
        [TuiPiaoLabel removeFromSuperview];
        
        UIButton *WenHao = (UIButton *)[self.view viewWithTag:800+i];
        [WenHao removeFromSuperview];
        
        UIImageView *line = (UIImageView *)[self.view viewWithTag:900+i];
        [line removeFromSuperview];
        
        
        UIButton *WenHao1 = (UIButton *)[self.view viewWithTag:100+i];
        [WenHao1 removeFromSuperview];
    }
    
    if(NoView)
    {
        [NoView removeFromSuperview];
    }
    if (_HeaderArrM.count == 0) {
        
        AirArray = nil;
        [self initNoView];
        
    }else{
        
        [NoView removeFromSuperview];
        [NoImgView removeFromSuperview];
        [NoLabel removeFromSuperview];
        
        AirArray = nil;
        
        AirArray = _HeaderArrM;
        
        [self initJinJiView];
        
    }
    
    
    
}

-(void)BackBtnClick1
{
    
    self.PanDuan = @"100";
    
    label1.textColor = [UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
    redImgView1.image = [UIImage imageNamed:@"icon-underline"];
    
    label2.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    redImgView2.image = [UIImage imageNamed:@""];
    
    
    [ShuoMing1 removeFromSuperview];
    
    for (int i = 0; i < AirArray.count; i++) {
        
        UIView *view = (UIView *)[self.view viewWithTag:200+i];
        [view removeFromSuperview];
        
        UILabel *price = (UILabel *)[self.view viewWithTag:300+i];
        [price removeFromSuperview];
        
        UIView *redView = (UIView *)[self.view viewWithTag:400+i];
        [redView removeFromSuperview];
        
        UIImageView *RedImgView = (UIImageView *)[self.view viewWithTag:500+i];
        [RedImgView removeFromSuperview];
        
        UILabel *TicketLabel = (UILabel *)[self.view viewWithTag:600+i];
        [TicketLabel removeFromSuperview];
        
        UILabel *TuiPiaoLabel = (UILabel *)[self.view viewWithTag:700+i];
        [TuiPiaoLabel removeFromSuperview];
        
        UIButton *WenHao = (UIButton *)[self.view viewWithTag:800+i];
        [WenHao removeFromSuperview];
        
        UIImageView *line = (UIImageView *)[self.view viewWithTag:900+i];
        [line removeFromSuperview];
        
        
        UIButton *WenHao1 = (UIButton *)[self.view viewWithTag:100+i];
        [WenHao1 removeFromSuperview];
    }
    if(NoView)
    {
        [NoView removeFromSuperview];
    }
    if (_JinJiArrM.count==0) {
        
        AirArray = nil;
        
        [self initNoView];
        
    }else{
        
        [NoView removeFromSuperview];
        [NoImgView removeFromSuperview];
        [NoLabel removeFromSuperview];
        
        AirArray = nil;
        
        AirArray = _JinJiArrM;
        
        [self initJinJiView];
        
    }
    
    
}
-(void)QurtBtnClick{
    
    [self.navigationController popViewControllerAnimated:NO];
    
}

@end
