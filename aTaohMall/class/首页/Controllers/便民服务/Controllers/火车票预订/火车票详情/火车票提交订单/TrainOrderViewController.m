//
//  TrainOrderViewController.m
//  火车票
//
//  Created by 阳涛 on 17/5/15.
//  Copyright © 2017年 yangtao. All rights reserved.
//

#import "TrainOrderViewController.h"

#import "TrainToReturnMoneyViewController.h"
#import "TimeModel.h"
#import "BianMinModel.h"
#import "TrainMingXiView.h"
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

#import "TrainToast.h"

#import "Order.h"
#import "APAuthV2Info.h"
#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>

#import "PersonalAllDanVC.h"
#import "AirPlaneDetailViewController.h"

#import "PersonalBMDetailVC.h"
#import "PersonalAllDanVC.h"

@interface TrainOrderViewController ()<TrainMingXiDelegate,UIAlertViewDelegate>
{
    UIScrollView *_scrollerView;
    UILabel *TimeLabel;
    UILabel *label2;
    UILabel *label4;
    
    UILabel *PayLabel;
    UILabel *IntegerLabel;
    UILabel *Integer;
    
    UIImageView *UpimgView;
    UIButton *UpButton;
    TrainMingXiView *_MingXi;
    
    UIView *IntegerView;
    UIButton *InterTipsBut;
    
}

@property (nonatomic, weak)   id           m_data;
@property (nonatomic, weak)   NSIndexPath *m_tmpIndexPath;

@property (nonatomic, strong) NSTimer        *m_timer; //定时器

@end

@implementation TrainOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1.0];
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数组NSArray类型的数据
    self.sigen=[userDefaultes stringForKey:@"sigen"];
    
//    self.time  = 1800;
    
    [self initNav];
    
    _scrollerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight+5, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-KSafeAreaTopNaviHeight-51-KSafeAreaBottomHeight)];
    _scrollerView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height+200);
    [self.view addSubview:_scrollerView];
    
    [self initTop];
    
    [self initManView];
    
    [self inittabView];
    
    
    _MingXi = [[TrainMingXiView alloc] init];
    
    [self.view addSubview:_MingXi];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resultStatus:) name:@"resultStatus" object:nil];
    
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
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 25+KSafeTopHeight, [UIScreen mainScreen].bounds.size.width-200, 30)];
    
    label.text = @"付款";
    
    label.textColor = [UIColor blackColor];
    
    label.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:19];
    
    label.textAlignment = NSTextAlignmentCenter;
    
    [titleView addSubview:label];
    
}
-(void)initTop
{
    
    
    

    UIView *OrderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 120)];
    OrderView.backgroundColor = [UIColor whiteColor];
    [_scrollerView addSubview:OrderView];
    
    UILabel *DateLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 21, [UIScreen mainScreen].bounds.size.width-30, 13)];
    DateLabel.text = [NSString stringWithFormat:@"%@ 星期%@ 开",self.train_date,[self.week stringByReplacingOccurrencesOfString:@"周" withString:@""]];
    DateLabel.numberOfLines=1;
    DateLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    DateLabel.font  =[UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    [OrderView addSubview:DateLabel];
    
    UILabel *StartName = [[UILabel alloc] initWithFrame:CGRectMake(45, 62, 100, 14)];
    StartName.text = self.from_stationName;
    StartName.numberOfLines=1;
    StartName.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    StartName.font  =[UIFont fontWithName:@"PingFang-SC-Bold" size:14];
    [OrderView addSubview:StartName];
    
    UILabel *StartTime = [[UILabel alloc] initWithFrame:CGRectMake(47, 86, 100, 11)];
    StartTime.text = self.start_time;
    StartTime.numberOfLines=1;
    StartTime.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    StartTime.font  =[UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    [OrderView addSubview:StartTime];
    
    NSArray *array = [self.run_time componentsSeparatedByString:@":"];
    
    UILabel *LongLabel = [[UILabel alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-100)/2, 56, 100, 13)];
    LongLabel.text = [NSString stringWithFormat:@"%@时%@分",array[0],array[1]];
    LongLabel.numberOfLines=1;
    LongLabel.textAlignment = NSTextAlignmentCenter;
    LongLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    LongLabel.font  =[UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    [OrderView addSubview:LongLabel];
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-88)/2, 73, 88, 9)];
    imgView.image = [UIImage imageNamed:@"开往-(1)"];
    [OrderView addSubview:imgView];
    
    UILabel *CheCiLabel = [[UILabel alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-100)/2, 92, 100, 13)];
    CheCiLabel.text = self.checi;
    CheCiLabel.numberOfLines=1;
    CheCiLabel.textAlignment = NSTextAlignmentCenter;
    CheCiLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    CheCiLabel.font  =[UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    [OrderView addSubview:CheCiLabel];
    
    UILabel *EndName = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-100-45, 62, 100, 14)];
    EndName.text = self.to_stationName;
    EndName.numberOfLines=1;
    EndName.textAlignment = NSTextAlignmentRight;
    EndName.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    EndName.font  =[UIFont fontWithName:@"PingFang-SC-Bold" size:14];
    [OrderView addSubview:EndName];
    
    UILabel *EndTime = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-100-47, 86, 100, 11)];
    EndTime.text = self.arrive_time;
    EndTime.numberOfLines=1;
    EndTime.textAlignment = NSTextAlignmentRight;
    EndTime.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    EndTime.font  =[UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    [OrderView addSubview:EndTime];
    
    
    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 119, [UIScreen mainScreen].bounds.size.width, 1)];
    
    line.image = [UIImage imageNamed:@"分割线-拷贝"];
    
    [OrderView addSubview:line];
    
}

-(void)initManView
{
    
    for (int i = 0; i < _CommitArray.count; i++) {
        
        BianMinModel *model = _CommitArray[i];
        
        UIView *ManView = [[UIView alloc] initWithFrame:CGRectMake(0, 120 + 82*i, [UIScreen mainScreen].bounds.size.width, 82)];
        ManView.backgroundColor = [UIColor whiteColor];
        [_scrollerView addSubview:ManView];

        UILabel *IdLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 51, ([UIScreen mainScreen].bounds.size.width-30)/2, 14)];

        IdLabel.numberOfLines=1;
        IdLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        IdLabel.font  =[UIFont fontWithName:@"PingFang-SC-Regular" size:14];
        [ManView addSubview:IdLabel];
        UILabel *NameLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 20, ([UIScreen mainScreen].bounds.size.width-30)/2, 14)];
        if ([model.Commit_piaotypename isEqualToString:@"成人票"]) {
            
            NameLabel.text = [NSString stringWithFormat:@"%@ %@",model.Commit_passengersename,model.Commit_piaotypename];
            IdLabel.text = model.Commit_passportseno;
        }else{
            
            NameLabel.text = [NSString stringWithFormat:@"%@ %@",model.Commit_child_name,model.Commit_piaotypename];
            IdLabel.text = [NSString stringWithFormat:@"请使用%@的证件取票",model.Commit_passengersename];
        }
        
        NameLabel.numberOfLines=1;
        NameLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        NameLabel.font  =[UIFont fontWithName:@"PingFang-SC-Regular" size:14];
        [ManView addSubview:NameLabel];
        

        
//        UILabel *NumberLabel = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-([UIScreen mainScreen].bounds.size.width-30)/2-15, 20, ([UIScreen mainScreen].bounds.size.width-30)/2, 14)];
//        NumberLabel.text = @"11车02号上铺";
//        NumberLabel.numberOfLines=1;
//        NumberLabel.textAlignment = NSTextAlignmentRight;
//        NumberLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
//        NumberLabel.font  =[UIFont fontWithName:@"PingFang-SC-Regular" size:14];
//        [ManView addSubview:NumberLabel];
        
        UILabel *TypeLabel = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-([UIScreen mainScreen].bounds.size.width-30)/2-15, 51, ([UIScreen mainScreen].bounds.size.width-30)/2, 14)];
        
        if ([model.Commit_zwcode isEqualToString:@"1"]) {
            
            if ([self.is_accept_standing isEqualToString:@"yes"]) {
                
                TypeLabel.text = @"无座";
            }else{
                
                TypeLabel.text = @"硬座";
            }
            
        }else if ([model.Commit_zwcode isEqualToString:@"2"]){
            
            if ([self.is_accept_standing isEqualToString:@"yes"]) {
                
                TypeLabel.text = @"无座";
            }else{
                
                TypeLabel.text = @"软座";
            }
            
            
        }else if ([model.Commit_zwcode isEqualToString:@"3"]){
            
            if ([self.is_accept_standing isEqualToString:@"yes"]) {
                
                TypeLabel.text = @"无座";
            }else{
                
                TypeLabel.text = @"硬卧";
            }
            
            
        }else if ([model.Commit_zwcode isEqualToString:@"4"]){
            
            if ([self.is_accept_standing isEqualToString:@"yes"]) {
                
                TypeLabel.text = @"无座";
            }else{
                
                TypeLabel.text = @"软卧";
            }
            
            
        }else if ([model.Commit_zwcode isEqualToString:@"6"]){
            
            if ([self.is_accept_standing isEqualToString:@"yes"]) {
                
                TypeLabel.text = @"无座";
            }else{
                
                TypeLabel.text = @"高级软卧";
            }
            
            
        }else if ([model.Commit_zwcode isEqualToString:@"M"]){
            
            if ([self.is_accept_standing isEqualToString:@"yes"]) {
                
                TypeLabel.text = @"无座";
            }else{
                
                TypeLabel.text = @"一等座";
            }
            
            
        }else if ([model.Commit_zwcode isEqualToString:@"O"]){
            
            if ([self.is_accept_standing isEqualToString:@"yes"]) {
                
                TypeLabel.text = @"无座";
            }else{
                
                TypeLabel.text = @"二等座";
            }
            
            
        }else if ([model.Commit_zwcode isEqualToString:@"9"]){
            
            if ([self.is_accept_standing isEqualToString:@"yes"]) {
                
                TypeLabel.text = @"无座";
            }else{
                
                TypeLabel.text = @"商务座";
            }
            
            
        }else if ([model.Commit_zwcode isEqualToString:@"P"]){
            
            if ([self.is_accept_standing isEqualToString:@"yes"]) {
                
                TypeLabel.text = @"无座";
            }else{
                
                TypeLabel.text = @"特等座";
            }
            
        }
//        else{
//            
//            
//        }
        
        
        TypeLabel.numberOfLines=1;
        TypeLabel.textAlignment = NSTextAlignmentRight;
        TypeLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        TypeLabel.font  =[UIFont fontWithName:@"PingFang-SC-Regular" size:14];
        [ManView addSubview:TypeLabel];
        
        UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 81, [UIScreen mainScreen].bounds.size.width, 1)];
        line.image = [UIImage imageNamed:@"分割线-拷贝"];
        [ManView addSubview:line];
    }
    
    UIView *PhoneView = [[UIView alloc] initWithFrame:CGRectMake(0, 120 + 82*_CommitArray.count, [UIScreen mainScreen].bounds.size.width, 50)];
    PhoneView.backgroundColor = [UIColor whiteColor];
    [_scrollerView addSubview:PhoneView];
    
    UILabel *PhoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, (50-14)/2, 100, 14)];
    PhoneLabel.text = @"联系电话";
    PhoneLabel.numberOfLines=1;
    PhoneLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    PhoneLabel.font  =[UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    [PhoneView addSubview:PhoneLabel];
    
    UILabel *Phone = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-165, (50-14)/2, 150, 14)];
    Phone.text = self.phone;
    Phone.numberOfLines=1;
    Phone.textAlignment = NSTextAlignmentRight;
    Phone.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    Phone.font  =[UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    [PhoneView addSubview:Phone];
    
    UIImageView *line1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 49, [UIScreen mainScreen].bounds.size.width, 1)];
    line1.image = [UIImage imageNamed:@"分割线-拷贝"];
    [PhoneView addSubview:line1];
    
    UIView *PriceView = [[UIView alloc] initWithFrame:CGRectMake(0, 120 + 82*_CommitArray.count +50, [UIScreen mainScreen].bounds.size.width, 50)];
    PriceView.backgroundColor = [UIColor whiteColor];
    [_scrollerView addSubview:PriceView];
    
    UIImageView *line2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 49, [UIScreen mainScreen].bounds.size.width, 1)];
    line2.image = [UIImage imageNamed:@"分割线-拷贝"];
    [PriceView addSubview:line2];
    
    UILabel *PriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, (50-14)/2, 100, 14)];
    PriceLabel.text = @"服务费";
    PriceLabel.numberOfLines=1;
    PriceLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    PriceLabel.font  =[UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    [PriceView addSubview:PriceLabel];
    
    UIButton *Button = [UIButton buttonWithType:UIButtonTypeCustom];
    Button.frame = CGRectMake(50, 0, 50, 50);
    [Button setImage:[UIImage imageNamed:@"待付款718"] forState:0];
    [Button addTarget:self action:@selector(BtnClick) forControlEvents:UIControlEventTouchUpInside];
    [PriceView addSubview:Button];
    
    UILabel *Price = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-165, (50-14)/2, 150, 14)];
    Price.text = [NSString stringWithFormat:@"￥%@",self.service_fee];
    Price.numberOfLines=1;
    Price.textAlignment = NSTextAlignmentRight;
    Price.textColor = [UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
    Price.font  =[UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    [PriceView addSubview:Price];
    
    NSString *stringForColor = @"￥";
    
    // 创建对象.
    NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:Price.text];
    //
    NSRange range = [Price.text rangeOfString:stringForColor];
    
    [mAttStri addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:15] range:range];
    Price.attributedText=mAttStri;
    
    IntegerView = [[UIView alloc] initWithFrame:CGRectMake(0, 120 + 82*_CommitArray.count+100+10, [UIScreen mainScreen].bounds.size.width, 70)];
    IntegerView.backgroundColor = [UIColor whiteColor];
    [_scrollerView addSubview:IntegerView];
    
    IntegerLabel = [[UILabel alloc] initWithFrame:CGRectMake(17, 19, 200, 12)];
    IntegerLabel.text = [NSString stringWithFormat:@"使用 %@ 积分兑现￥%@",self.payintegral,self.payintegral];
    IntegerLabel.numberOfLines=1;
    IntegerLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    IntegerLabel.font  =[UIFont fontWithName:@"PingFang-SC-Regular" size:12];
    [IntegerView addSubview:IntegerLabel];
    
    NSString *stringForColor1 = [NSString stringWithFormat:@"%@",self.payintegral];
    
    // 创建对象.
    NSMutableAttributedString *mAttStri1 = [[NSMutableAttributedString alloc] initWithString:IntegerLabel.text];
    //
    NSRange range1 = [IntegerLabel.text rangeOfString:stringForColor1];
    
    [mAttStri1 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:10] range:range1];
    IntegerLabel.attributedText=mAttStri1;
    
    Integer = [[UILabel alloc] initWithFrame:CGRectMake(17, 45, 300, 14)];
    Integer.text = [NSString stringWithFormat:@"(你有%@积分，最多可使用%@积分)",self.userIntegral,self.payintegral];
    Integer.numberOfLines=1;
    Integer.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
    Integer.font  =[UIFont fontWithName:@"PingFang-SC-Regular" size:12];
    [IntegerView addSubview:Integer];
    CGSize size=[Integer.text sizeWithFont:KNSFONT(12) maxSize:CGSizeMake(300, 14)];
    
    UIButton * but=[UIButton buttonWithType:UIButtonTypeCustom];
    but.frame=CGRectMake(size.width+17+5, 47, 11, 11);
    but.tag=1689;
    [but setImage:KImage(@"提示") forState:UIControlStateNormal];
    [but addTarget:self action:@selector(interTips:) forControlEvents:UIControlEventTouchUpInside];
    
    [IntegerView addSubview:but];
    
    
    
    
    UISwitch *Switch =[[UISwitch alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-60, (70-30)/2, 50, 30)];
    Switch.on = YES;
    Switch.tag = 1000;
    
    [Switch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];   // 开关事件切换通知
    
    [IntegerView addSubview:Switch];
    
    
    UIView *ZhiFuBao = [[UIView alloc] initWithFrame:CGRectMake(0, 120 + 82*_CommitArray.count+100+10+70+10, [UIScreen mainScreen].bounds.size.width, 71)];
    ZhiFuBao.backgroundColor=[UIColor whiteColor];
    
    [_scrollerView addSubview:ZhiFuBao];
    
    UIImageView *line3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 1)];
    
    line3.image = [UIImage imageNamed:@"分割线-拷贝"];
    
    [ZhiFuBao addSubview:line3];
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(15, (71-18)/2, 70, 18)];
    imgView.image = [UIImage imageNamed:@"支付宝"];
    [ZhiFuBao addSubview:imgView];
    
    UIImageView *imgView1 = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-30, (71-12)/2, 12, 12)];
    imgView1.image = [UIImage imageNamed:@"选中425"];
    [ZhiFuBao addSubview:imgView1];
    
}
-(void)interTips:(UIButton *)sender
{
    
    
    if (!InterTipsBut){
        UIButton *but=[self.view viewWithTag:1689];
        CGRect rect=IntegerView.frame;
        InterTipsBut=[UIButton buttonWithType:UIButtonTypeCustom];
        InterTipsBut.frame=CGRectMake(but.center.x-40,5+rect.origin.y+but.frame.origin.y+but.frame.size.height, 80, 40);
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
        
        
        [_scrollerView addSubview:InterTipsBut];
        //[InterView addSubview:InterTipsView];
        InterTipsBut.hidden=YES;
    }
    InterTipsBut.hidden=!InterTipsBut.hidden;
    
}
-(void)inittabView
{
    UIImageView *line2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-51-KSafeAreaBottomHeight, [UIScreen mainScreen].bounds.size.width, 1)];
    line2.image = [UIImage imageNamed:@"分割线-拷贝"];
    [self.view addSubview:line2];
    
    UIView *PayView = [[UIView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-50-KSafeAreaBottomHeight, [UIScreen mainScreen].bounds.size.width, 50)];
    PayView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:PayView];
    
    
    UIButton *PayButton = [UIButton buttonWithType:UIButtonTypeCustom];
    PayButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-101, 0, 101, 50);
    [PayButton setTitle:@"付款" forState:0];
    [PayButton setTitleColor:[UIColor whiteColor] forState:0];
    PayButton.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15];
    PayButton.backgroundColor = [UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
    [PayButton addTarget:self action:@selector(payBtnCLick) forControlEvents:UIControlEventTouchUpInside];
    [PayView addSubview:PayButton];
    
    
    UpimgView = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-101-24, (49-8)/2, 14, 8)];
    UpimgView.image = [UIImage imageNamed:@"icon_more-down"];
    [PayView addSubview:UpimgView];
    
    
    UpButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UpButton.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width-101, 49);
    [UpButton addTarget:self action:@selector(UpBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    UpButton.selected = YES;
    [PayView addSubview:UpButton];
    
    
    PayLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, [UIScreen mainScreen].bounds.size.width-101-15-30, 20)];
    
    PayLabel.text = [NSString stringWithFormat:@"实付金额:￥%.02f",[self.order_cash floatValue] - [self.payintegral floatValue]];
    PayLabel.numberOfLines=1;
    PayLabel.textAlignment = NSTextAlignmentRight;
    PayLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    PayLabel.font  =[UIFont fontWithName:@"PingFang-SC-Regular" size:15];
    [PayView addSubview:PayLabel];
    
    NSString *stringForColor = [NSString stringWithFormat:@"￥%.02f",[self.order_cash floatValue] - [self.payintegral floatValue]];
    
    // 创建对象.
    NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:PayLabel.text];
    //
    NSRange range = [PayLabel.text rangeOfString:stringForColor];
    
    [mAttStri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0] range:range];
    PayLabel.attributedText=mAttStri;
    
    
}

//明细
-(void)UpBtnClick:(UIButton *)sender
{
    
    //判断积分按钮是否打开
    UISwitch *jifen = (UISwitch *)[self.view viewWithTag:1000];
    
    BOOL ret2 = [jifen isOn];
    
    if (sender.selected) {
        
        
        if (ret2) {
            
            [_MingXi Price:self.price JiJian:self.service_fee BaoXian:self.payintegral];
            
        }else{
            
            [_MingXi Price:self.price JiJian:self.service_fee BaoXian:@"0.00"];
        }
        
        
        [_MingXi showInView:self.view];
//        
        _MingXi.delegate=self;
        
        UpimgView.image = [UIImage imageNamed:@"icon_more-up"];
        sender.selected = !sender.selected;
        
    }else{
        
        [_MingXi hideInView];
        UpimgView.image = [UIImage imageNamed:@"icon_more-down"];
        sender.selected=YES;
        
        
    }
}

-(void)TrainmingXi
{
    UpimgView.image = [UIImage imageNamed:@"icon_more-down"];
    UpButton.selected=YES;
    
}

-(void)switchAction:(id)sender
{

    UISwitch *switchButton = (UISwitch*)sender;
    BOOL isButtonOn = [switchButton isOn];
    if (isButtonOn) {
        NSLog(@"开");
        
        Integer.text = [NSString stringWithFormat:@"(你有%@积分，最多可使用%@积分)",self.userIntegral,self.payintegral];
        
        PayLabel.text = [NSString stringWithFormat:@"实付金额:￥%.02f",[self.order_cash floatValue] - [self.payintegral floatValue]];
        NSString *stringForColor = [NSString stringWithFormat:@"￥%.02f",[self.order_cash floatValue] - [self.payintegral floatValue]];
        
        // 创建对象.
        NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:PayLabel.text];
        //
        NSRange range = [PayLabel.text rangeOfString:stringForColor];
        
        [mAttStri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0] range:range];
        PayLabel.attributedText=mAttStri;
        
        
        IntegerLabel.text = [NSString stringWithFormat:@"使用 %@ 积分兑现￥%@",self.payintegral,self.payintegral];
       
        NSString *stringForColor1 = [NSString stringWithFormat:@"%@",self.payintegral];
        
        // 创建对象.
        NSMutableAttributedString *mAttStri1 = [[NSMutableAttributedString alloc] initWithString:IntegerLabel.text];
        //
        NSRange range1 = [IntegerLabel.text rangeOfString:stringForColor1];
        
        [mAttStri1 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:10] range:range1];
        IntegerLabel.attributedText=mAttStri1;
       
    }else {
        NSLog(@"关");
        
        Integer.text = [NSString stringWithFormat:@"(你有%@积分，最多可使用0.00积分)",self.userIntegral];
        
        PayLabel.text = [NSString stringWithFormat:@"实付金额:￥%.02f",[self.order_cash floatValue] ];
        NSString *stringForColor = [NSString stringWithFormat:@"￥%.02f",[self.order_cash floatValue]];
        
        // 创建对象.
        NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:PayLabel.text];
        //
        NSRange range = [PayLabel.text rangeOfString:stringForColor];
        
        [mAttStri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0] range:range];
        PayLabel.attributedText=mAttStri;
        
        
        IntegerLabel.text = [NSString stringWithFormat:@"使用 0.00 积分兑现￥0.00"];
        
        NSString *stringForColor1 = [NSString stringWithFormat:@"0.00"];
        
        // 创建对象.
        NSMutableAttributedString *mAttStri1 = [[NSMutableAttributedString alloc] initWithString:IntegerLabel.text];
        //
        NSRange range1 = [IntegerLabel.text rangeOfString:stringForColor1];
        
        [mAttStri1 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:10] range:range1];
        IntegerLabel.attributedText=mAttStri1;
        
        
    }

}


-(void)BtnClick
{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"服务费为第三方平台代购费用，本平台不收取任何费用。" message:nil delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
    
    [alert show];
    
}
-(void)payBtnCLick
{
    
   // WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
    WKProgressHUD *hud = [WKProgressHUD showInView:self.view animated:YES];
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        
    });
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@trainPaymentValidation_mob.shtml",URL_Str];
    //saveUserExchange_mob.shtml
    
    
    NSDictionary *dict = @{@"sigen":self.sigen,@"orderno":self.orderno};
    
    [manager POST:url parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
        NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];
        
        
        if (codeKey && content) {
            NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
            
            NSLog(@"xmlStr=付款=%@",xmlStr);
            
            
            NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            
            
            if ([dic[@"type"] isEqualToString:@"0"]) {
                
              
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:dic[@"message"] message:nil delegate:self cancelButtonTitle:@"我不买了" otherButtonTitles:@"继续付款", nil];
                alert.tag=100;
                [alert show];
                
                
                
            }else if([dic[@"type"] isEqualToString:@"1"]){
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:dic[@"message"] message:nil delegate:self cancelButtonTitle:@"我不买了" otherButtonTitles:@"重新选择", nil];
                alert.tag = 200;
                [alert show];
                
            }else if([dic[@"type"] isEqualToString:@"2"]){
                
                [self getdatas];
                
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

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (alertView.tag==100) {
        
        if (buttonIndex==0) {
            
            
        }else{
            
            [self getdatas];
            
        }
    }else{
        
        if (buttonIndex==0) {
            
            
        }else{
            
            //重新选择
            
            UIViewController *vc = self.navigationController.viewControllers[2];
            [self.navigationController popToViewController:vc animated:NO];
            
        }
    }
}

-(void)getdatas
{
    
    
   // WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
    WKProgressHUD *hud = [WKProgressHUD showInView:self.view animated:YES];
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        
    });
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@trainPayment_mob.shtml",URL_Str];
    //saveUserExchange_mob.shtml
    
    
    
    NSLog(@"===self.sigen===%@",self.sigen);
    NSLog(@"===self.train_date===%@",self.train_date);
    NSLog(@"===self.start_time===%@",self.start_time);
    NSLog(@"===self.run_time===%@",self.run_time);
    NSLog(@"===self.zwcode===%@",self.zwcode);
    NSLog(@"===self.phone===%@",self.phone);
    NSLog(@"===self.orderno===%@",self.orderno);
    UISwitch *jifen = (UISwitch *)[self.view viewWithTag:1000];
    NSDictionary *dict = @{@"sigen":self.sigen,@"orderno":self.orderno,@"start_station_name":self.from_stationName,@"arrive_station_name":self.to_stationName,@"train_date":self.train_date,@"from_station_code":self.from_station_code,@"to_station_code":self.to_station_code,@"start_time":self.start_time,@"checi":self.checi,@"zwcode":self.zwcode,@"total_number":self.Number,@"payintegral":jifen.on?self.payintegral:@"0"};
    
    [manager POST:url parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
        NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];
        
        
        if (codeKey && content) {
            NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
            
            NSLog(@"xmlStr=付款=%@",xmlStr);
            
            
            NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            NSNull *null = [[NSNull alloc] init];
            
            
            if ([dic[@"status"] isEqualToString:@"10000"]) {
                
                
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
   // NSLog(@"orderSpec = %@",orderInfo);
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
                
                //订单详情
                
//                PersonalBMDetailVC *vc=[[PersonalBMDetailVC alloc] initWithOrderBatchid:[self getorderNO] AndOrderType:@"5"];
//
//                NSArray *arr=@[self.navigationController.viewControllers.firstObject,vc];
//                self.navigationController.viewControllers=arr;
//                [self.navigationController pushViewController:vc animated:NO];

                PersonalAllDanVC *vc=[[PersonalAllDanVC alloc] init];
                [vc selectedDingDanType:@"1" AndIndexType:2];
                PersonalBMDetailVC *VC2=[[PersonalBMDetailVC alloc] initWithOrderBatchid:[self getorderNO] AndOrderType:@"5"];
                VC2.delegate=vc;
                self.navigationController.viewControllers=@[self.navigationController.viewControllers.firstObject,vc,VC2];
                [self.navigationController pushViewController:vc animated:NO];
                
            }else if ([resultDic[@"resultStatus"] isEqualToString:@"8000"]){
                
                [JRToast showWithText:@"正在处理中" duration:2.0f];
                
            }else if ([resultDic[@"resultStatus"] isEqualToString:@"4000"]){
                
                [JRToast showWithText:@"订单支付失败" duration:2.0f];
                
            }else if ([resultDic[@"resultStatus"] isEqualToString:@"6001"]){
                
                PersonalAllDanVC *vc=[[PersonalAllDanVC alloc] init];
                [vc selectedDingDanType:@"1" AndIndexType:1];
                PersonalBMDetailVC *VC2=[[PersonalBMDetailVC alloc] initWithOrderBatchid:[self getorderNO] AndOrderType:@"5"];
                VC2.delegate=vc;
                self.navigationController.viewControllers=@[self.navigationController.viewControllers.firstObject,vc,VC2];
                [self.navigationController pushViewController:vc animated:NO];
                
                [JRToast showWithText:@"用户中途取消" duration:2.0f];
                
            }else if ([resultDic[@"resultStatus"] isEqualToString:@"6002"]){
                
                [JRToast showWithText:@"网络连接出错" duration:2.0f];
            }else
            {
                
                
                
            }
            
            
        }];
        //
        
        
        
    }
    
    
}

-(void)resultStatus:(NSNotification *)text
{
    
    
    if ([text.userInfo[@"resultStatus"] isEqualToString:@"9000"]) {
        
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        //读取数组NSArray类型的数据
        
        //跳订单详情
        
        PersonalAllDanVC *vc=[[PersonalAllDanVC alloc] init];
        [vc selectedDingDanType:@"1" AndIndexType:2];
        PersonalBMDetailVC *VC2=[[PersonalBMDetailVC alloc] initWithOrderBatchid:[self getorderNO] AndOrderType:@"5"];
        VC2.delegate=vc;
        self.navigationController.viewControllers=@[self.navigationController.viewControllers.firstObject,vc,VC2];
        [self.navigationController pushViewController:vc animated:NO];
        
        
        
    }else if ([text.userInfo[@"resultStatus"] isEqualToString:@"8000"]){
        
        [JRToast showWithText:@"正在处理中" duration:2.0f];
        
        
    }else if ([text.userInfo[@"resultStatus"] isEqualToString:@"4000"]){
        
        
        [JRToast showWithText:@"订单支付失败" duration:2.0f];
        
    }else if ([text.userInfo[@"resultStatus"] isEqualToString:@"6001"]){
        
        PersonalAllDanVC *vc=[[PersonalAllDanVC alloc] init];
        [vc selectedDingDanType:@"1" AndIndexType:1];
        PersonalBMDetailVC *VC2=[[PersonalBMDetailVC alloc] initWithOrderBatchid:[self getorderNO] AndOrderType:@"5"];
        VC2.delegate=vc;
        self.navigationController.viewControllers=@[self.navigationController.viewControllers.firstObject,vc,VC2];
        [self.navigationController pushViewController:vc animated:NO];
        [JRToast showWithText:@"用户中途取消" duration:2.0f];
        
    }else if ([text.userInfo[@"resultStatus"] isEqualToString:@"6002"]){
        
        [JRToast showWithText:@"网络连接出错" duration:2.0f];
    }
    
    
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


-(void)QurtBtnClick
{
    self.time=0;
    
    [self.navigationController popViewControllerAnimated:NO];
    
}

#pragma mark - setter
- (void)setTime:(NSTimeInterval)time {
    
    _time = time;
    
    [self setViewWith:_time];
    
    [self.timer invalidate];
    self.timer = nil;
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeRun) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    [self.timer fire];
    
}

#pragma mark - personal
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
    
    
    label2.text = [NSString stringWithFormat:@"%ld",(long)min];
    label4.text = [NSString stringWithFormat:@"%ld",(long)sec];
//    TimeLabel.text = [NSString stringWithFormat:@"请在%ld分%ld秒内支付",(long)min,(long)sec];
    

    
    
}


-(NSString *)getorderNO
{
    NSString *ordernum= [NSString stringWithFormat:@"%@",self.orderno];
    NSString *codeKey = [SecretCodeTool getDesCodeKey:ordernum];
    NSString *content = [SecretCodeTool getReallyDesCodeString:ordernum];

    ordernum=[DesUtil decryptUseDES:content key:codeKey];
    YLog(@"%@",ordernum);
    return ordernum;
}

@end
