//
//  TrainYuDingViewController.m
//  aTaohMall
//
//  Created by JMSHT on 2017/5/15.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "TrainYuDingViewController.h"

#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

#import <ContactsUI/ContactsUI.h>

#import "TrainToast.h"
#import "CheCiChangeView.h"
#import "TrainAddView.h"
#import "TrainXieYiViewController.h"
#import "TrainAddManViewController.h"
#import "TrainOrderViewController.h"
#import "TrainAddKidViewController.h"
#import "BianMinModel.h"
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
#import "CheCiDetailViewController.h"
@interface TrainYuDingViewController ()<CNContactPickerDelegate,CheCiChangeDelegate,TrainAddManDelegate,UIAlertViewDelegate,TrainAddKidReloadDelegate,UITextFieldDelegate>
{
    UIScrollView *_scrollView;
    UILabel *MeLabel;
    UITextField *MePhoneTF;
    UIImageView *xieyiImgView;
    CheCiChangeView *_customShareView;
    TrainAddView *_addView;
    
    UILabel *PriceLabel;
    
    NSMutableArray *_data;
    NSMutableArray *_GoArrM;
    NSMutableArray *_ManArrM;
    NSArray *SelectArrM;
    
    NSArray *OldManArray;
    
    UILabel *ChangeLabel;
    UIButton *AddButton;
    UIButton *ChangeButton;
    UIView *blackView;
    UIView *MeView;
    UILabel *Shuoming;
    UIButton *XieYiButton;
    UIView *PayView;
    int index;
    
    UIAlertController *alertCon;
    
    NSMutableArray *KidArrM;
    NSMutableArray *CommitArrM;
    
    NSInteger ChildCount;
}
@property(nonatomic,strong)NSMutableArray *ManArray;
@end

@implementation TrainYuDingViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数组NSArray类型的数据
    self.sigen=[userDefaultes stringForKey:@"sigen"];
    
    CommitArrM = [NSMutableArray new];
    
    KidArrM = [NSMutableArray new];
    
    self.view.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1.0];
    
    [self initNav];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-KSafeAreaTopNaviHeight)];
    _scrollView.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1.0];
    _scrollView.showsVerticalScrollIndicator = NO;
//    _scrollView.delegate=self;
    _scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height+100);
    [self.view addSubview:_scrollView];
    
    [self initRedView];
    
    [self initOtherView];
    
    _customShareView = [[CheCiChangeView alloc]init];
    [self.view addSubview:_customShareView];
    
    _addView = [[TrainAddView alloc]init];
    [self.view addSubview:_addView];
    
}

//创建导航栏
-(void)initNav
{
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, KSafeAreaTopNaviHeight)];
    
    titleView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:titleView];
    
    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight, [UIScreen mainScreen].bounds.size.width, 1)];
    
    line.image = [UIImage imageNamed:@"分割线-拷贝"];
    
    [self.view addSubview:line];
    
    
    //返回按钮
    
    UIButton *Qurt = [UIButton buttonWithType:UIButtonTypeCustom];
    
    Qurt.frame = CGRectMake(10, 25+KSafeTopHeight, 30, 30);
    
    [Qurt setImage:[UIImage imageNamed:@"iconfont-fanhui2yt"] forState:0];
    
    
    [Qurt addTarget:self action:@selector(QurtBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [titleView addSubview:Qurt];
    
    //创建搜索
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(50, 25+KSafeTopHeight, [UIScreen mainScreen].bounds.size.width-100, 30)];
    
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

-(void)initOtherView
{
    
    UIView *PriceView = [[UIView alloc] initWithFrame:CGRectMake(0, 90, [UIScreen mainScreen].bounds.size.width, 51)];
    PriceView.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:PriceView];
    
    PriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, (51-13)/2, 200, 13)];
    PriceLabel.text = [NSString stringWithFormat:@"%@￥%@",self.Name,self.Price];
    PriceLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    PriceLabel.font  =[UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    [PriceView addSubview:PriceLabel];
    
    UIImageView *logoImgView = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-15-11, (51-15)/2, 15, 15)];
    logoImgView.image = [UIImage imageNamed:@"iconfont-enter111"];
    
    [PriceView addSubview:logoImgView];
    
    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 50, [UIScreen mainScreen].bounds.size.width, 1)];
    line.image = [UIImage imageNamed:@"分割线-拷贝"];
    [PriceView addSubview:line];
    
    UIButton *PriceButton = [UIButton buttonWithType:UIButtonTypeCustom];
    PriceButton.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 51);
    [PriceButton addTarget:self action:@selector(PriceBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [PriceView addSubview:PriceButton];
    
    UIView *ChangeView = [[UIView alloc] initWithFrame:CGRectMake(0, 90+51+10, [UIScreen mainScreen].bounds.size.width, 51)];
    ChangeView.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:ChangeView];
    
    ChangeLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, (51-13)/2, 200, 13)];
    ChangeLabel.text = @"添加/修改乘车人";
    ChangeLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    ChangeLabel.font  =[UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    [ChangeView addSubview:ChangeLabel];
    
    AddButton = [UIButton buttonWithType:UIButtonTypeCustom];
    AddButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-95, (51-25)/2, 80, 25);
    [AddButton setTitle:@"添加乘车人" forState:0];
    [AddButton setTitleColor:[UIColor whiteColor] forState:0];
    AddButton.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
    AddButton.backgroundColor = [UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
    [AddButton addTarget:self action:@selector(AddBtnClick) forControlEvents:UIControlEventTouchUpInside];
    AddButton.layer.cornerRadius = 3;
    AddButton.layer.masksToBounds = YES;
    AddButton.hidden = YES;
    [ChangeView addSubview:AddButton];
    
    UIImageView *line1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 50, [UIScreen mainScreen].bounds.size.width, 1)];
    line1.image = [UIImage imageNamed:@"分割线-拷贝"];
    [ChangeView addSubview:line1];
    
    ChangeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    ChangeButton.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 51);
    [ChangeButton addTarget:self action:@selector(ChangeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [ChangeView addSubview:ChangeButton];
    
    //弹框
    blackView = [[UIView alloc] initWithFrame:CGRectMake(21, 90+51+10+51, 94, 28)];
    [_scrollView addSubview:blackView];
    
    UIImageView *blackImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 94, 28)];
    blackImg.image = [UIImage imageNamed:@"添加乘车人弹窗"];
    [blackView addSubview:blackImg];
    
    UILabel *blackLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 94, 12)];
    blackLabel.text = @"请先添加乘车人";
    blackLabel.textColor = [UIColor whiteColor];
    blackLabel.textAlignment = NSTextAlignmentCenter;
    blackLabel.font  =[UIFont fontWithName:@"PingFang-SC-Regular" size:12];
    [blackView addSubview:blackLabel];
    
    
    MeView = [[UIView alloc] initWithFrame:CGRectMake(0, 90+51+10+51+39+50*_ManArray.count, [UIScreen mainScreen].bounds.size.width, 51)];
    MeView.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:MeView];
    
    UIImageView *line4 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 50, [UIScreen mainScreen].bounds.size.width, 1)];
    line4.image = [UIImage imageNamed:@"分割线-拷贝"];
    [MeView addSubview:line4];
    
    MeLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, (51-13)/2, 60, 13)];
    MeLabel.text = [NSString stringWithFormat:@"联系手机"];
    MeLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    MeLabel.font  =[UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    [MeView addSubview:MeLabel];
    

    MePhoneTF=[[UITextField alloc]initWithFrame:CGRectMake(85, (51-13)/2, 150, 13)];
    MePhoneTF.placeholder=@"请输入手机号";
    MePhoneTF.text=self.phone;
    MePhoneTF.textColor=RGB(51, 51, 51);
    MePhoneTF.font=[UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    MePhoneTF.keyboardType=UIKeyboardTypeNumberPad;
    MePhoneTF.delegate=self;
    [ZZLimitInputManager limitInputView:MePhoneTF maxLength:11];
    [MeView addSubview:MePhoneTF];
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
    MePhoneTF.inputAccessoryView = bar1;
//    PhoneLabel = [[UITextField alloc] initWithFrame:CGRectMake(80, (50-20)/2, 200, 20)];
//    PhoneLabel.placeholder = @"请输入联系手机号";
//    PhoneLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
//    PhoneLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
//    PhoneLabel.keyboardType = UIKeyboardTypeNumberPad;
//    PhoneLabel.delegate=self;
//    [ZZLimitInputManager limitInputView:PhoneLabel maxLength:11];
//    [PhoneView addSubview:PhoneLabel];
//    
    MePhoneTF.keyboardType=UIKeyboardTypeNumberPad;
    
    UIImageView *line3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 50, [UIScreen mainScreen].bounds.size.width, 1)];
    line3.image = [UIImage imageNamed:@"分割线-拷贝"];
    [ChangeView addSubview:line3];
    
    UIButton *MeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    MeButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-51, 0, 51, 51);
    [MeButton setImage:[UIImage imageNamed:@"通讯录"] forState:0];
    [MeButton addTarget:self action:@selector(MeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [MeView addSubview:MeButton];
    
    Shuoming = [[UILabel alloc] init];
    Shuoming.numberOfLines=0;
    Shuoming.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    Shuoming.font  =[UIFont fontWithName:@"PingFang-SC-Regular" size:12];
    [_scrollView addSubview:Shuoming];
    
    xieyiImgView = [[UIImageView alloc] init];
    xieyiImgView.image = [UIImage imageNamed:@"选中协议"];
    [_scrollView addSubview:xieyiImgView];
    
    XieYiButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [XieYiButton setTitle:@"《火车票预订协议》" forState:0];
    [XieYiButton setTitleColor:[UIColor colorWithRed:43/255.0 green:143/255.0 blue:255/255.0 alpha:1.0] forState:0];
    XieYiButton.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
    [XieYiButton addTarget:self action:@selector(XieYiBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:XieYiButton];
    
    
    PayView = [[UIView alloc] init];
    PayView.layer.cornerRadius = 3;
    PayView.layer.masksToBounds = YES;
    
    if ([self.TypeString isEqualToString:@"1"]) {
        
        Shuoming.frame = CGRectMake(17, 90+51+10+51+39+51+10+50*_ManArray.count, [UIScreen mainScreen].bounds.size.width-34, 90);
        Shuoming.text = @"提示:\n*火车票无法保证100%出票，如出票失败将短信通知，票款将原路退回到您的付款账户；\n*卧铺将随机出票，预定收取下铺价格，出票后将按照实际票价按支付渠道退还差额。";
        xieyiImgView.frame = CGRectMake(18, 90+51+10+51+39+51+10+30+15+45+50*_ManArray.count, 15, 15);
        XieYiButton.frame = CGRectMake(40, 90+51+10+51+39+51+10+30+12+45+50*_ManArray.count, 120, 20);
        PayView.frame = CGRectMake(15, 90+51+10+51+39+51+10+30+12+72+45+50*_ManArray.count, [UIScreen mainScreen].bounds.size.width-30, 38);
        
    }else{
        
        Shuoming.frame = CGRectMake(17, 90+51+10+51+39+51+10+50*_ManArray.count, [UIScreen mainScreen].bounds.size.width-34, 35);
        Shuoming.text = @"提示：火车票无法保证100%出票，如出票失败将短信通知，票款将原路退回您付款的账户。";
        xieyiImgView.frame = CGRectMake(18, 90+51+10+51+39+51+10+30+15+50*_ManArray.count, 15, 15);
        XieYiButton.frame = CGRectMake(40, 90+51+10+51+39+51+10+30+12+50*_ManArray.count, 120, 20);
        PayView.frame = CGRectMake(15, 90+51+10+51+39+51+10+30+12+72+50*_ManArray.count, [UIScreen mainScreen].bounds.size.width-30, 38);
        
    }
    
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)[UIColor colorWithRed:255/255.0 green:52/255.0 blue:90/255.0 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0].CGColor];
    gradientLayer.locations = @[@0.0, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1.0);
    gradientLayer.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width-30, 38);
    [PayView.layer addSublayer:gradientLayer];
    
    [_scrollView addSubview:PayView];
    
    UIButton *Pay = [UIButton buttonWithType:UIButtonTypeCustom];
    Pay.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width-30, 38);
    Pay.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:15];
    [Pay addTarget:self action:@selector(PayBtnCLick) forControlEvents:UIControlEventTouchUpInside];
    [Pay setTitle:@"下一步" forState:0];
    Pay.layer.cornerRadius = 3;
    Pay.layer.masksToBounds = YES;
    [Pay setTitleColor:[UIColor whiteColor] forState:0];
    [PayView addSubview:Pay];
    
}

//创建乘车人视图
-(void)initPasserView
{
    
    if (self.ManArray.count == 0) {
        
        ChangeLabel.text = @"添加/修改乘车人";
        AddButton.hidden = YES;
        ChangeButton.hidden = NO;
        blackView.hidden = NO;
        
    }else{
        
        ChangeLabel.text = @"乘车人";
        AddButton.hidden = NO;
        ChangeButton.hidden = YES;
        blackView.hidden = YES;
        
        
        
    }
    
    //移除就试图
    
    for (int i = 0; i < 5; i++) {
        
        UIView *view = (UIView *)[self.view viewWithTag:1100+i];
        [view removeFromSuperview];
        for (id obj in view.subviews) {
            [obj removeFromSuperview];
        }
        
    }
    ChildCount=0;
    for (int i=0; i<_ManArray.count; i++) {
        
        BianMinModel *model = _ManArray[i];
        CGRect Frame=CGRectMake(0, 90+51+10+51+50*i, kScreen_Width, 50+model.childArr.count*50);
        if (i>0) {
            Frame=CGRectMake(0, 90+51+10+51+50*i+ChildCount*50, kScreen_Width, 50+model.childArr.count*50);
        }
        UIView *NameView = [[UIView alloc] initWithFrame:Frame];
        
        NameView.tag = 1100+i;
        NameView.backgroundColor = [UIColor whiteColor];
        [_scrollView addSubview:NameView];
        
        UILabel *NameLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 11, 200, 13)];
        NameLabel.text = [NSString stringWithFormat:@"%@ 成人票",model.username];
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
        
        UIButton *KidButton = [UIButton buttonWithType:UIButtonTypeCustom];
        KidButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-120, (50-20)/2, 100, 20);
        KidButton.tag = 1600+i;
        KidButton.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
        [KidButton setTitleColor:[UIColor colorWithRed:43/255.0 green:143/255.0 blue:255/255.0 alpha:1.0] forState:0];
        KidButton.titleLabel.textAlignment = NSTextAlignmentRight;
        [KidButton setTitle:@"添加随行儿童" forState:0];
        [KidButton addTarget:self action:@selector(KidBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [NameView addSubview:KidButton];
        
        
        if (model.childArr.count>0) {
            for (int k=0; k<model.childArr.count; k++) {
                
                BianMinModel *ChildModel=model.childArr[k];
                ChildCount+=1;
                UILabel *NameLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(40, 11+k*50+50, 200, 13)];
                NameLabel2.text = [NSString stringWithFormat:@"%@ 儿童票",ChildModel.username];
                NameLabel2.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
                NameLabel2.font  =[UIFont fontWithName:@"PingFang-SC-Regular" size:14];
                [NameView addSubview:NameLabel2];
                
                UILabel *idLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(40, 30+k*50+50, 200, 13)];
                idLabel2.text = [NSString stringWithFormat:@"请使用%@的证件取票",model.username];
                idLabel2.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
                idLabel2.font  =[UIFont fontWithName:@"PingFang-SC-Regular" size:12];
                [NameView addSubview:idLabel2];
                
                UIImageView *line2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 49+k*50+50, [UIScreen mainScreen].bounds.size.width, 1)];
                line2.image = [UIImage imageNamed:@"分割线-拷贝"];
                [NameView addSubview:line2];
                
                UIButton *DeleteButton2 = [UIButton buttonWithType:UIButtonTypeCustom];
                DeleteButton2.frame = CGRectMake(14, (50-16)/2+k*50+50, 16, 16);
                DeleteButton2.tag=9400+ChildCount;
                [DeleteButton2 setImage:[UIImage imageNamed:@"删除"] forState:0];
                [DeleteButton2 addTarget:self action:@selector(KidDeleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                [NameView addSubview:DeleteButton2];
                
                
            }
        }

    }
    
    if (_ManArray.count == 0) {
    
        MeView.frame = CGRectMake(0, 90+51+10+51+39+50*_ManArray.count+ChildCount*50, [UIScreen mainScreen].bounds.size.width, 51);
        
    }else{
        
        MeView.frame = CGRectMake(0, 90+51+10+51+20+50*_ManArray.count+ChildCount*50, [UIScreen mainScreen].bounds.size.width, 51);

    }
    
    
    if ([self.TypeString isEqualToString:@"1"] || [self.zwcode isEqualToString:@"3"] || [self.zwcode isEqualToString:@"4"]) {
        
        if (_ManArray.count == 0) {
            
            Shuoming.frame = CGRectMake(17, 90+51+10+51+39+51+10+50*_ManArray.count+ChildCount*50, [UIScreen mainScreen].bounds.size.width-34, 90);
            xieyiImgView.frame = CGRectMake(18, 90+51+10+51+39+51+10+30+15+45+50*_ManArray.count+ChildCount*50, 15, 15);
            XieYiButton.frame = CGRectMake(40, 90+51+10+51+39+51+10+30+12+45+50*_ManArray.count+ChildCount*50, 120, 20);
            PayView.frame = CGRectMake(15, 90+51+10+51+39+51+10+30+12+72+45+50*_ManArray.count+ChildCount*50, [UIScreen mainScreen].bounds.size.width-30, 38);
            
        }else{
            
            Shuoming.frame = CGRectMake(17, 90+51+10+51+20+51+10+50*_ManArray.count+ChildCount*50, [UIScreen mainScreen].bounds.size.width-34, 90);
            xieyiImgView.frame = CGRectMake(18, 90+51+10+51+20+51+10+30+15+45+50*_ManArray.count+ChildCount*50, 15, 15);
            XieYiButton.frame = CGRectMake(40, 90+51+10+51+20+51+10+30+12+45+50*_ManArray.count+ChildCount*50, 120, 20);
            PayView.frame = CGRectMake(15, 90+51+10+51+20+51+10+30+12+72+45+50*_ManArray.count+ChildCount*50, [UIScreen mainScreen].bounds.size.width-30, 38);
    
        }
        
    }else{
        
        if (_ManArray.count == 0) {
            
            Shuoming.frame = CGRectMake(17, 90+51+10+51+39+51+10+50*_ManArray.count+ChildCount*50, [UIScreen mainScreen].bounds.size.width-34, 35);
            xieyiImgView.frame = CGRectMake(18, 90+51+10+51+39+51+10+30+15+50*_ManArray.count+ChildCount*50, 15, 15);
            XieYiButton.frame = CGRectMake(40, 90+51+10+51+39+51+10+30+12+50*_ManArray.count+ChildCount*50, 120, 20);
            PayView.frame = CGRectMake(15, 90+51+10+51+39+51+10+30+12+72+50*_ManArray.count+ChildCount*50, [UIScreen mainScreen].bounds.size.width-30, 38);
            
        }else{
            
            Shuoming.frame = CGRectMake(17, 90+51+10+51+20+51+10+50*_ManArray.count+ChildCount*50, [UIScreen mainScreen].bounds.size.width-34, 35);
            xieyiImgView.frame = CGRectMake(18, 90+51+10+51+20+51+10+30+15+50*_ManArray.count+ChildCount*50, 15, 15);
            XieYiButton.frame = CGRectMake(40, 90+51+10+51+20+51+10+30+12+50*_ManArray.count+ChildCount*50, 120, 20);
            PayView.frame = CGRectMake(15, 90+51+10+51+20+51+10+30+12+72+50*_ManArray.count+ChildCount*50, [UIScreen mainScreen].bounds.size.width-30, 38);
        
        }
        
    }
    
}

//电话输入框确定
-(void)OKBtnclick
{
    [MePhoneTF resignFirstResponder];
}

//电话输入框取消
-(void)CancleBtnclick
{
    [MePhoneTF resignFirstResponder];

}

/**
 修改座次
 */
-(void)PriceBtnClick
{
    
    NSLog(@"价格");
    
//    _customShareView.delegate=self;
    
    _customShareView.delegate = self;
    
    _customShareView.Array = self.PriceArray;
    
    [_customShareView showInView:self.view];
    
}

/**
 座次返回放阿飞

 @param Price 座次价格
 @param array 座次数组
 */
-(void)Price:(NSString *)Price ZW:(NSString *)zw Array:(NSArray *)array Is_accept_standing:(NSString *)is_accept_standing
{
    
    PriceLabel.text = Price;
    
    NSLog(@"=====%@===%@",Price,zw);
    
    self.zwcode = zw;
    
    self.PriceArray = nil;
    
    self.PriceArray = array;
    
    self.is_accept_standing = is_accept_standing;
    
//    for (BianMinModel *model in array) {
//        
//        NSLog(@"====%@===%@===%@",model.Detail_name,model.Detail_select,model.zwcode);
//        
//    }
    
    if ([self.zwcode isEqualToString:@"3"] || [self.zwcode isEqualToString:@"4"]) {
        
        self.TypeString = @"1";
        
        Shuoming.frame = CGRectMake(17, 90+51+10+51+39+51+10+50*_ManArray.count, [UIScreen mainScreen].bounds.size.width-34, 90);
        Shuoming.text = @"提示:\n*火车票无法保证100%出票，如出票失败将短信通知，票款将原路退回到您的付款账户；\n*卧铺将随机出票，预定收取下铺价格，出票后将按照实际票价按支付渠道退还差额。";
        xieyiImgView.frame = CGRectMake(18, 90+51+10+51+39+51+10+30+15+45+50*_ManArray.count, 15, 15);
        XieYiButton.frame = CGRectMake(40, 90+51+10+51+39+51+10+30+12+45+50*_ManArray.count, 120, 20);
        PayView.frame = CGRectMake(15, 90+51+10+51+39+51+10+30+12+72+45+50*_ManArray.count, [UIScreen mainScreen].bounds.size.width-30, 38);
        
    }else{
        
        self.TypeString = @"";
        
        Shuoming.frame = CGRectMake(17, 90+51+10+51+39+51+10+50*_ManArray.count, [UIScreen mainScreen].bounds.size.width-34, 35);
        Shuoming.text = @"提示：火车票无法保证100%出票，如出票失败将短信通知，票款将原路退回您付款的账户。";
        xieyiImgView.frame = CGRectMake(18, 90+51+10+51+39+51+10+30+15+50*_ManArray.count, 15, 15);
        XieYiButton.frame = CGRectMake(40, 90+51+10+51+39+51+10+30+12+50*_ManArray.count, 120, 20);
        PayView.frame = CGRectMake(15, 90+51+10+51+39+51+10+30+12+72+50*_ManArray.count, [UIScreen mainScreen].bounds.size.width-30, 38);
        
    }
    
    
    if (_ManArray.count == 0) {
        
        MeView.frame = CGRectMake(0, 90+51+10+51+39+50*_ManArray.count+ChildCount*50, [UIScreen mainScreen].bounds.size.width, 51);
        
    }else{
        
        MeView.frame = CGRectMake(0, 90+51+10+51+20+50*_ManArray.count+ChildCount*50, [UIScreen mainScreen].bounds.size.width, 51);
        
    }
    
    
    if ([self.zwcode isEqualToString:@"3"] || [self.zwcode isEqualToString:@"4"]) {
        
        if (_ManArray.count == 0) {
            
            Shuoming.frame = CGRectMake(17, 90+51+10+51+39+51+10+50*_ManArray.count+ChildCount*50, [UIScreen mainScreen].bounds.size.width-34, 90);
            xieyiImgView.frame = CGRectMake(18, 90+51+10+51+39+51+10+30+15+45+50*_ManArray.count+ChildCount*50, 15, 15);
            XieYiButton.frame = CGRectMake(40, 90+51+10+51+39+51+10+30+12+45+50*_ManArray.count+ChildCount*50, 120, 20);
            PayView.frame = CGRectMake(15, 90+51+10+51+39+51+10+30+12+72+45+50*_ManArray.count+ChildCount*50, [UIScreen mainScreen].bounds.size.width-30, 38);
            
        }else{
            
            Shuoming.frame = CGRectMake(17, 90+51+10+51+20+51+10+50*_ManArray.count+ChildCount*50, [UIScreen mainScreen].bounds.size.width-34, 90);
            xieyiImgView.frame = CGRectMake(18, 90+51+10+51+20+51+10+30+15+45+50*_ManArray.count+ChildCount*50, 15, 15);
            XieYiButton.frame = CGRectMake(40, 90+51+10+51+20+51+10+30+12+45+50*_ManArray.count+ChildCount*50, 120, 20);
            PayView.frame = CGRectMake(15, 90+51+10+51+20+51+10+30+12+72+45+50*_ManArray.count+ChildCount*50, [UIScreen mainScreen].bounds.size.width-30, 38);
            
        }
        
    }else{
        
        if (_ManArray.count == 0) {
            
            Shuoming.frame = CGRectMake(17, 90+51+10+51+39+51+10+50*_ManArray.count+ChildCount*50, [UIScreen mainScreen].bounds.size.width-34, 35);
            xieyiImgView.frame = CGRectMake(18, 90+51+10+51+39+51+10+30+15+50*_ManArray.count+ChildCount*50, 15, 15);
            XieYiButton.frame = CGRectMake(40, 90+51+10+51+39+51+10+30+12+50*_ManArray.count+ChildCount*50, 120, 20);
            PayView.frame = CGRectMake(15, 90+51+10+51+39+51+10+30+12+72+50*_ManArray.count+ChildCount*50, [UIScreen mainScreen].bounds.size.width-30, 38);
            
        }else{
            
            Shuoming.frame = CGRectMake(17, 90+51+10+51+20+51+10+50*_ManArray.count+ChildCount*50, [UIScreen mainScreen].bounds.size.width-34, 35);
            xieyiImgView.frame = CGRectMake(18, 90+51+10+51+20+51+10+30+15+50*_ManArray.count+ChildCount*50, 15, 15);
            XieYiButton.frame = CGRectMake(40, 90+51+10+51+20+51+10+30+12+50*_ManArray.count+ChildCount*50, 120, 20);
            PayView.frame = CGRectMake(15, 90+51+10+51+20+51+10+30+12+72+50*_ManArray.count+ChildCount*50, [UIScreen mainScreen].bounds.size.width-30, 38);
            
        }
        
    }
    
}


/**
 addManView代理方法,

 @param man 返回选中的数组
 */
-(void)TrainAddMan:(NSArray *)man
{

    [self.ManArray removeAllObjects];
    [self.ManArray addObjectsFromArray:man];
//    for (int i=0; i<man.count; i++) {
//        BianMinModel *model=[man objectAtIndex:i];
//        
//        
//        if (self.ManArray.count==0) {
//            [self.ManArray addObject:model];
//        }
//        for (int j=0; j<self.ManArray.count; j++) {
//            BianMinModel *model2=[_ManArray objectAtIndex:j];
//            if (model.ManId==model2.ManId) {
//                j=(int)_ManArray.count;
//            }else if (j==(int)_ManArray.count-1)
//            {
//                [self.ManArray addObject:model];
//            }
//        }
//        NSLog(@"1234");
//    }
    if (_ManArray.count == 0) {
        
        ChangeLabel.text = @"添加/修改乘车人";
        AddButton.hidden = YES;
        ChangeButton.hidden = NO;
        blackView.hidden = NO;
        
    }else{
        
        ChangeLabel.text = @"乘车人";
        AddButton.hidden = NO;
        ChangeButton.hidden = YES;
        blackView.hidden = YES;

    }

    
    [self initPasserView];
    
}

//儿童代理
-(void)TrainKid:(NSString *)Kid Name:(NSString *)name Passportseno:(NSString *)passportseno Index:(NSString *)Index
{
    BianMinModel *model = [[BianMinModel alloc] init];

    model.ManId = Kid;
    model.username = name;
    model.passportseno = passportseno;
    model.Index = Index;
    BianMinModel *model2=[_ManArray objectAtIndex:[Index integerValue]];
    if (!model2.childArr) {
        model2.childArr=[[NSMutableArray alloc]init];
    }
    [model2.childArr addObject:model];
    [_ManArray replaceObjectAtIndex:[Index integerValue] withObject:model2];
    [self initPasserView];
    
    NSLog(@"=====%@===%@==%@==%@",Kid,name,passportseno,Index);
    
}

//获取乘车人数目
-(NSInteger)GetCountOfManAndChild
{
    int i=0;
    for (BianMinModel *model in self.ManArray) {
        i+=model.childArr.count;
    }
    return i+self.ManArray.count;
}

//获取乘车人数目
-(NSInteger)GetCountChild
{
    int i=0;
    for (BianMinModel *model in self.ManArray) {
        i+=model.childArr.count;
    }
    return i;
}

//添加随行儿童
-(void)KidBtnClick:(UIButton *)sender
{
    if ([self GetCountOfManAndChild]>=[self.TicketCount integerValue]) {
        [TrainToast showWithText:[NSString stringWithFormat:@"余票不足,你只能为%@人购买车票",self.TicketCount] duration:2.0f];
        return;
    }
    if ([self GetCountOfManAndChild]>=5) {
        [TrainToast showWithText:@"一次最多可为5个乘客购票" duration:2.0];
        return;
    }
    
    BianMinModel *model = _ManArray[sender.tag-1600];
    
    NSLog(@"==添加随行儿童==%ld===%@",(long)sender.tag,model.username);
    
    TrainAddKidViewController *vc = [[TrainAddKidViewController alloc] init];
    vc.delegate=self;
    vc.IId = model.ManId;
    vc.Index = [NSString stringWithFormat:@"%ld",sender.tag-1600];
    vc.passportseno = model.passportseno;
    
    [self.navigationController pushViewController:vc animated:NO];
    self.navigationController.navigationBar.hidden = YES;
    
}

/**
 删除随行儿童
 
 @param sender 点击随行儿童前的图标
 */
-(void)KidDeleteBtnClick:(UIButton *)sender
{
    
    index = (int)sender.tag-9400;
    
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"确定要删除该乘车人？" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
    alert.tag = 200;
    
    [alert show];
    
    
    
    
}

/**
 添加乘车人
 */
-(void)AddBtnClick
{
    
    NSLog(@"===添加乘车人===%@",[NSString stringWithFormat:@"%ld",(long)[self GetCountOfManAndChild]]);
    
    if ([self GetCountOfManAndChild]>=[self.TicketCount integerValue]) {
        [TrainToast showWithText:[NSString stringWithFormat:@"余票不足,你只能为%@人购买车票",self.TicketCount] duration:2.0f];
        return;
    }
    
    if ([self GetCountOfManAndChild]>=5) {
        [TrainToast showWithText:@"一次最多可为5个乘客购票" duration:2.0];
        return;
    }
    
    _addView.delegate=self;
    
    _addView.ManArray = _ManArray;
    
    _addView.Number = [NSString stringWithFormat:@"%ld",(long)[self GetCountChild]];
    
//    _addView.delegate=self;
    
    _addView.TicketCount = self.TicketCount;
    
    [_addView showInView:self.view];
    
}

/**
 删除成人

 @param sender 点击成人前的图标
 */
-(void)DeleteBtnClick:(UIButton *)sender
{

    index = (int)sender.tag-1500;
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"确定要删除该乘车人？" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
     
    [alert show];
    
}

/**
 尚未添加乘车人是点击添加/修改乘车人按钮执行的方法
 */
-(void)ChangeBtnClick
{
    
    NSLog(@"修改");
    
    _addView.delegate=self;
    _addView.ManArray=_ManArray;
    _addView.TicketCount = self.TicketCount;
    
    [_addView showInView:self.view];
}

/**
 删除执行方法

 @param alertView 点击弹出的AlertView的取消和确定执行的方法
 @param buttonIndex 点击的but下标
 */
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
 
        if (buttonIndex==0)
        {
            
            
        }else
        {
            OldManArray=[NSArray arrayWithArray:_ManArray];
            //删除儿童票
            if (alertView.tag == 200)
            {
                int totalCount=0;
                for (int i=0; i<_ManArray.count; i++)
                {
                    BianMinModel *model=_ManArray[i];
                    for (int j=0; j<model.childArr.count; j++)
                    {
                        totalCount++;
                        if (totalCount==index)
                        {
                            [model.childArr removeObjectAtIndex:j];
                            [_ManArray replaceObjectAtIndex:i withObject:model];
                            j=(int)model.childArr.count+1;
                            i=(int)_ManArray.count+1;
                        }
                    }
                }
                
            }
            else//删除成人票
            {
                
                BianMinModel *model=[self.ManArray objectAtIndex:index];
                [model.childArr removeAllObjects];
                [_ManArray removeObjectAtIndex:index];
            
            }
            [self initPasserView];
            
        }
    
    
}

/**
 提交按钮执行方法
 */
-(void)PayBtnCLick
{
    
    if (_ManArray.count == 0) {
        
        [TrainToast showWithText:@"请先添加一位乘车人" duration:2.0f];
    }else{
        
        if (_ManArray.count > 5) {
            
            [TrainToast showWithText:@"最多添加5位乘车人" duration:2.0f];
            
        }else{
            
            if (MePhoneTF.text.length == 0) {
                
                [TrainToast showWithText:@"请输入正确的手机号码" duration:2.0f];
                
            }else{
                
                /**
                 * 移动号段正则表达式
                 */
                NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
                /**
                 * 联通号段正则表达式
                 */
                NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
                /**
                 * 电信号段正则表达式
                 */
                NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
                NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
                BOOL isMatch1 = [pred1 evaluateWithObject:MePhoneTF.text];
                NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
                BOOL isMatch2 = [pred2 evaluateWithObject:MePhoneTF.text];
                NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
                BOOL isMatch3 = [pred3 evaluateWithObject:MePhoneTF.text];
                if (!(isMatch1 || isMatch2 || isMatch3)) {
                    
                    [TrainToast showWithText:@"请输入正确的手机号码" duration:2.0f];
                    
                }else{
                
                    [self getdatas];
                    
                }
            }
        }
    }
}


/**
 提交订单
 */
-(void)getdatas
{
    
    NSMutableArray *IdArrM = [NSMutableArray new];
    
    for (BianMinModel *model in _ManArray) {
        [IdArrM addObject:[NSString stringWithFormat:@"'%@'",model.ManId]];
        for (BianMinModel *model2 in model.childArr) {
            [IdArrM addObject:[NSString stringWithFormat:@"'%@'",model2.ManId]];
        }
    }
    self.ids = [IdArrM componentsJoinedByString:@","];
    
   // WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
    WKProgressHUD *hud = [WKProgressHUD showInView:self.view animated:YES];
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        
    });
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@trainSubmit_mob.shtml",URL_Str];
    //saveUserExchange_mob.shtml
    
    
//    NSLog(@"===self.sigen===%@",self.sigen);
//    NSLog(@"===self.train_date===%@",self.train_date);
//    NSLog(@"===self.from_station===%@",self.from_station);
//    NSLog(@"===self.to_station===%@",self.to_station);
//    NSLog(@"===self.train_code===%@",self.train_code);
//    NSLog(@"===self.start_time===%@",self.start_time);
//    NSLog(@"===self.StartCity===%@",self.StartCity);
//    NSLog(@"===self.ArriveCity===%@",self.ArriveCity);
//    NSLog(@"===self.CheCi===%@",self.CheCi);
//    NSLog(@"===self.run_time===%@",self.run_time);
//    NSLog(@"===self.zwcode===%@",self.zwcode);
//    NSLog(@"===self.phone===%@",self.phone);
//    NSLog(@"===self.che_type===%@",self.che_type);
//    NSLog(@"===self.ids===%@",self.ids);
//    NSLog(@"===count===%@",[NSString stringWithFormat:@"%ld",(long)_ManArray.count]);
    
    
    NSDictionary *dict = @{@"sigen":self.sigen,@"train_date":self.train_date,@"from_station_code":self.from_station,@"to_station_code":self.to_station,@"start_time":self.StartTime,@"arrive_time":self.ArriveTime,@"to_stationName":self.ArriveCity,@"from_stationName":self.StartCity,@"checi":self.CheCi,@"clientId":@"3",@"run_time":self.run_time,@"zwcode":self.zwcode,@"phone":MePhoneTF.text,@"che_type":self.che_type,@"ids":self.ids,@"is_accept_standing":self.is_accept_standing,@"total_number":[NSString stringWithFormat:@"%ld",(long)[self GetCountOfManAndChild]]};
    NSLog(@"*********%@",dict);
    [manager POST:url parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
        NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];
        
        if (codeKey && content) {
            NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
            
            NSLog(@"xmlStr=火车票提交=%@",xmlStr);
            
            
            NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            [CommitArrM removeAllObjects];
            
            
            if ([dic[@"status"] isEqualToString:@"10000"]) {
                
                
                for (NSDictionary *dict in dic[@"user_message"]) {
                    
                    BianMinModel *model = [[BianMinModel alloc] init];
                    
                    model.Commit_child_name = [NSString stringWithFormat:@"%@",dict[@"child_name"]];
                    model.Commit_piaotypename = [NSString stringWithFormat:@"%@",dict[@"piaotypename"]];
                    model.Commit_zwcode = [NSString stringWithFormat:@"%@",dict[@"zwcode"]];
                    model.Commit_piaotype = [NSString stringWithFormat:@"%@",dict[@"piaotype"]];
                    model.Commit_passportseno = [NSString stringWithFormat:@"%@",dict[@"passportseno"]];
                    model.Commit_passengersename = [NSString stringWithFormat:@"%@",dict[@"passengersename"]];
                    model.Commit_passporttypeseidname = [NSString stringWithFormat:@"%@",dict[@"passporttypeseidname"]];
                    model.Commit_passporttypeseid = [NSString stringWithFormat:@"%@",dict[@"passporttypeseid"]];
                    
                    [CommitArrM addObject:model];
                    
                }
                
                TrainOrderViewController *vc = [[TrainOrderViewController alloc] init];
                
                NSArray *array = [self.DateString componentsSeparatedByString:@" "];
                
                vc.week = [NSString stringWithFormat:@"%@",array[1]];
                vc.phone = [NSString stringWithFormat:@"%@",dic[@"phone"]];
                vc.userIntegral = [NSString stringWithFormat:@"%@",dic[@"userIntegral"]];
                vc.che_type = [NSString stringWithFormat:@"%@",dic[@"che_type"]];
                vc.from_stationName = [NSString stringWithFormat:@"%@",dic[@"from_stationName"]];

                vc.orderno= [NSString stringWithFormat:@"%@",dic[@"orderno"]];
                vc.checi = [NSString stringWithFormat:@"%@",dic[@"checi"]];
                vc.to_stationName = [NSString stringWithFormat:@"%@",dic[@"to_stationName"]];
                vc.from_station_code = [NSString stringWithFormat:@"%@",dic[@"from_station_code"]];
                vc.clientId = [NSString stringWithFormat:@"%@",dic[@"clientId"]];
                vc.order_cash = [NSString stringWithFormat:@"%@",dic[@"order_cash"]];
                vc.arrive_time = [NSString stringWithFormat:@"%@",dic[@"arrive_time"]];
                vc.to_station_code = [NSString stringWithFormat:@"%@",dic[@"to_station_code"]];
                vc.price = [NSString stringWithFormat:@"%@",dic[@"price"]];
                vc.train_date = [NSString stringWithFormat:@"%@",dic[@"train_date"]];
                vc.zwcode = [NSString stringWithFormat:@"%@",dic[@"zwcode"]];
                vc.start_time = [NSString stringWithFormat:@"%@",dic[@"start_time"]];
                vc.run_time = [NSString stringWithFormat:@"%@",dic[@"run_time"]];
                vc.payintegral = [NSString stringWithFormat:@"%@",dic[@"payintegral"]];
                vc.CommitArray = CommitArrM;
                vc.service_fee = [NSString stringWithFormat:@"%@",dic[@"service_fee"]];
                vc.is_accept_standing = self.is_accept_standing;
                
                vc.Number = [NSString stringWithFormat:@"%ld",(long)[self GetCountOfManAndChild]];
                
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


/**
 协议按钮执行方法、弹出协议视图
 */
-(void)XieYiBtnClick
{
    
    xieyiImgView.image = [UIImage imageNamed:@"选中协议"];
    
    TrainXieYiViewController *vc = [[TrainXieYiViewController alloc] init];
    [self.navigationController pushViewController:vc animated:NO];
    self.navigationController.navigationBar.hidden=YES;
}

/**
 弹出系统通讯录视图
 */
-(void)MeBtnClick{
    
    CNContactPickerViewController * vc = [[CNContactPickerViewController alloc] init];
    vc.delegate = self;
    [self presentViewController:vc animated:YES completion:nil];
}

/**
 读取系统通讯录协议中的方法

 @param picker 联系人选择框
 @param contact 返回的选择联系人信息
 */
-(void)contactPicker:(CNContactPickerViewController *)picker didSelectContact:(CNContact *)contact
{
    
    NSLog(@"联系人的资料:===1111%@",contact);
    
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
        
        NSString *cca2 = [phoneNumer.stringValue stringByReplacingOccurrencesOfString:@"-"withString:@""];
        
        NSLog(@"==%@==%@", phoneLabel, cca2);
        
//        MePhoneTF.text =cca2;
        
        if ([phoneNumer.stringValue rangeOfString:@"+86"].location !=NSNotFound) {
            
            NSString *cca2 = [phoneNumer.stringValue stringByReplacingOccurrencesOfString:@"+86"withString:@""];//删除
            
            if([cca2 rangeOfString:@"-"].location !=NSNotFound){
     
                NSLog(@"yes");
                
                MePhoneTF.text =[cca2 stringByReplacingOccurrencesOfString:@"-" withString:@""];
                
            }else{
                
                MePhoneTF.text = [NSString stringWithFormat:@"%@",phoneValue];
                
            }
            
        }else{
            
            if([phoneNumer.stringValue rangeOfString:@"-"].location !=NSNotFound){
                
                MePhoneTF.text =[phoneNumer.stringValue stringByReplacingOccurrencesOfString:@"-" withString:@""];
                
            }else{
                
                MePhoneTF.text = [NSString stringWithFormat:@"%@",phoneValue];
        
            }
        
        }
        
    }
    
}

/**
 导航栏返回按钮
 */
-(void)QurtBtnClick
{
    
    [MePhoneTF resignFirstResponder];
    
    if ([self.LoginBack isEqualToString:@"888"]) {
        
        [self.view endEditing:YES];
        
        NSArray *vcArray = self.navigationController.viewControllers;
        
//        NSLog(@"==viewControllers===%@",vcArray);
        
        for(UIViewController *vc in vcArray){
            
            if ([vc isKindOfClass:[CheCiDetailViewController class]]){
                
                self.navigationController.navigationBar.hidden=YES;
                
                [self.navigationController popToViewController:vc animated:NO];
                
            }
            
        }
        
    }else{
        
        [self.navigationController popViewControllerAnimated:NO];
        
    }
    
}

/**
 懒加载乘车人数据数组
 
 @return 懒加载数组
 */
-(NSMutableArray *)ManArray
{
    if (!_ManArray) {
        _ManArray=[[NSMutableArray alloc]init];
    }
    return _ManArray;
}

@end
