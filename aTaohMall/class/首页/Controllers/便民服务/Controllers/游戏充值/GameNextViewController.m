//
//  GameNextViewController.m
//  aTaohMall
//
//  Created by JMSHT on 2017/4/27.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "GameNextViewController.h"

#import "SelectServiceViewController.h"

#import "UIView+Extension.h"
#import "ABButton.h"

#import "AFNetworking.h"

#import "ConverUtil.h"
#import "DESUtil.h"
#import "SecretCodeTool.h"

#import "WKProgressHUD.h"

#import "JRToast.h"

#import "BianMinModel.h"

#import "ATHLoginViewController.h"
#import "UserMessageManager.h"

#import "NewHomeViewController.h"

#import "PhoneAndFlowPayViewController.h"

#define ABColor(R, G, B, Alpha) [UIColor colorWithRed:(R)/255.0 green:(G)/255.0 blue:(B)/255.0 alpha:(Alpha)]
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define LINECOLOR [UIColor colorWithWhite:0.8 alpha:0.5]
#define ABButtonMargin 10.0

@interface GameNextViewController ()<UITextFieldDelegate,SelectServiceDelegate,LoginMessageDelegate>
{
    UITextField *CountTF;
    UITextField *PassTF;
    UIView *view;
    UIButton *ServiceButton;
    UILabel *ServiceLabel;
    UIView *ServiceView;
    UIButton *add;
    UIButton *reduce;
    
    NSMutableArray *_Money;
    
    NSMutableArray *_LOLArrM;
    
    NSMutableArray *_Tag;
    
    NSMutableArray *_amountsArrM;
    
    NSMutableArray *_JiKa;
    
    NSMutableArray *_ArrM1;
    
    NSMutableArray *_Left;
    NSMutableArray *_Right;
    
    UIScrollView *_titleScroll;
    UILabel *ChangeLabel;
    UILabel *ChangeLabel1;
    NSArray *price;
    int num ;
    
}
@end

@implementation GameNextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.hidden=YES;
    
//    self.navigationItem.hidesBackButton = YES;
//    
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 25, [UIScreen mainScreen].bounds.size.width-200, 30)];
//    
//    label.text = @"游戏点卡";
//    
//    label.textColor = [UIColor blackColor];
//    
//    label.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:20];
//    
//    label.textAlignment = NSTextAlignmentCenter;
//    
//    self.navigationItem.titleView = label;
//    
//    
//    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    backBtn.frame = CGRectMake(0, 0, 30, 30);
//    
//    [backBtn setImage:[UIImage imageNamed:@"iconfont-fanhui2yt"] forState:UIControlStateNormal];
//    [backBtn addTarget:self action:@selector(LeftBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    
//    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
//    //    self.navigationItem.leftBarButtonItem = backItem;
//    
//    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
//    spaceItem.width = - 10;
//    self.navigationItem.leftBarButtonItems = @[spaceItem, backItem];
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数组NSArray类型的数据
    self.sigen=[userDefaultes stringForKey:@"sigen"];
    
    _Money = [NSMutableArray new];
    _Tag = [NSMutableArray new];
    _JiKa = [NSMutableArray new];
    _ArrM1 = [NSMutableArray new];
    _amountsArrM = [NSMutableArray new];
    _LOLArrM = [NSMutableArray new];
    _Left = [NSMutableArray new];
    _Right = [NSMutableArray new];
    
    num = 0;
    
    
    [self initNav];
    
    _titleScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 65, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-65)];
    
    _titleScroll.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height+100);
    //Button的高
    
    _titleScroll.showsVerticalScrollIndicator = NO;
    
    [self.view addSubview:_titleScroll];
    
    [self getDatas];
    
    
//    [self initName];
//    [self initCount];
//    [self initService];
//    
//    //创建充值视图
//    [self initNumberView];
    
    
}

-(void)LeftBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
    self.tabBarController.tabBar.hidden=YES;
    
}


-(void)getDatas
{
    //先清空数据源
    
    WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
    
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        
    });
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@getFaceValue_mob.shtml",URL_Str];
    //saveUserExchange_mob.shtml
    
    
    
    NSDictionary *dic = @{@"type":@"2",@"phone":@"",@"id":self.Id,@"cardid":self.cardid};
    
    
    [manager POST:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
        NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];
        
        
        if (codeKey && content) {
            NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
            
            NSLog(@"xmlStr==111===%@",xmlStr);
            
            
            NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
           NSLog(@"分类查看更多书局=%@",dic);
            
            view.hidden=YES;
            
            
            
            if ([dic[@"status"] isEqualToString:@"10000"]) {
                
                
                self.isnull = [NSString stringWithFormat:@"%@",dic[@"isnull"]];
                self.is_traffic_permit = [NSString stringWithFormat:@"%@",dic[@"is_traffic_permit"]];
                self.conversion_rate = [NSString stringWithFormat:@"%@",dic[@"conversion_rate"]];
                self.game_currency_name = [NSString stringWithFormat:@"%@",dic[@"game_currency_name"]];
                self.istype = [NSString stringWithFormat:@"%@",dic[@"istype"]];
                
                NSLog(@"==111=%@==%@=",self.game_currency_name,self.conversion_rate);
                
                
                for (NSDictionary *dict in dic[@"bmGameSonList"]) {
                    
                    BianMinModel *model = [[BianMinModel alloc] init];
                    model.amounts = [NSString stringWithFormat:@"%@",dict[@"amounts"]];
                    model.pervalue = [NSString stringWithFormat:@"%@",dict[@"pervalue"]];
                    model.ji_cardid = [NSString stringWithFormat:@"%@",dict[@"ji_cardid"]];
                    model.you_cardid = [NSString stringWithFormat:@"%@",dict[@"you_cardid"]];
                    model.cardname = [NSString stringWithFormat:@"%@",dict[@"cardname"]];
                    model.recharge_type = [NSString stringWithFormat:@"%@",dict[@"recharge_type"]];
                    model.cardname_type = [NSString stringWithFormat:@"%@",dict[@"cardname_type"]];
                    
                    
                    self.seveiceid = [NSString stringWithFormat:@"%@",dict[@"cardid"]];
                    model.cardid = [NSString stringWithFormat:@"%@",dict[@"cardid"]];
                    
                    if ([dict[@"cardname"] rangeOfString:@"月卡"].location !=NSNotFound) {
                        
                        [_ArrM1 addObject:@"月卡"];
                        
                        
                    }
                    
                    if ([dict[@"cardname"] rangeOfString:@"季卡"].location !=NSNotFound) {
                        
                        [_ArrM1 addObject:@"季卡"];
                        
                    }
                    
                    if ([self.istype isEqualToString:@"2"]) {
                        
                        NSArray *array = [model.recharge_type componentsSeparatedByString:@"_"];
                        
                        if ([model.cardid isEqualToString:array[0]]) {
                            
                            
                            [_Left addObject:model];
                            
                        }else if([model.cardid isEqualToString:array[1]]){
                            
                            [_Right addObject:model];
                            
                        }
                        
                    }
                    
                    
                    
                    [_JiKa addObject:model];
                    
                    [_LOLArrM addObject:model];
                    
                    
                    if (![_Tag containsObject:model.pervalue]) {
                        
                        [_Tag addObject:model.pervalue];
                        
                        [_Money addObject:model];
                    }
                    
                    
                }
                
                if ([self.is_traffic_permit isEqualToString:@"1"]) {
                    
                    [self initPassView];
                    
                }else{
                    
                    [self initName];
                    [self initCount];
                    [self initService];
                
                    //创建充值视图
                    [self initNumberView];
                    
                }
                
                
                if ([self.isnull isEqualToString:@"0"]) {
                    
                    ServiceButton.enabled=NO;
                    
                }else{
                    
                    ServiceButton.enabled=YES;
                }
                
                
            }else{
                

                [JRToast showWithText:dic[@"message"] duration:1.0f];
                
            }
            
            
            [hud dismiss:YES];
            
            
            
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //        [WKProgressHUD popMessage:@"网络请求失败，请检查您的网络设置" inView:self.view duration:1.5 animated:YES];
        [hud dismiss:YES];
        
        [self NoWebSeveice];
        
        NSLog(@"%@",error);
    }];
}

-(void)NoWebSeveice
{
    
    view=[[UIView alloc] initWithFrame:CGRectMake(0, 65, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-65)];
    
    view.backgroundColor=[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];
    
    [self.view addSubview:view];
    
    
    UIImageView *image=[[UIImageView alloc] initWithFrame:CGRectMake((view.frame.size.width-82)/2, 100, 82, 68)];
    
    image.image=[UIImage imageNamed:@"网络连接失败"];
    
    [view addSubview:image];
    
    
    UILabel *label1=[[UILabel alloc] initWithFrame:CGRectMake(100, 180, view.frame.size.width-200, 20)];
    
    label1.text=@"网络连接失败";
    
    label1.textAlignment=NSTextAlignmentCenter;
    
    label1.font=[UIFont fontWithName:@"PingFangSC-Medium" size:15];
    
    label1.textColor=[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    
    [view addSubview:label1];
    
    
    UILabel *label2=[[UILabel alloc] initWithFrame:CGRectMake(100, 210, view.frame.size.width-200, 20)];
    
    label2.text=@"请检查你的网络";
    
    label2.textAlignment=NSTextAlignmentCenter;
    
    label2.font=[UIFont fontWithName:@"PingFangSC-Medium" size:12];
    
    label2.textColor=[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    
    [view addSubview:label2];
    
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    
    button.frame=CGRectMake(100, 250, view.frame.size.width-200, 50);
    
    [button setTitle:@"重新加载" forState:0];
    button.titleLabel.font=[UIFont fontWithName:@"PingFangSC-Medium" size:12];
    [button setTitleColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0] forState:0];
    
    [view addSubview:button];
    
    [button addTarget:self action:@selector(loadData) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)loadData{
    
    WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
    
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        [hud dismiss:YES];
    });
    
    [self getDatas];
    
}

//创建导航栏
-(void)initNav
{
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64)];
    
    titleView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:titleView];
    
    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, 1)];
    
    line.image = [UIImage imageNamed:@"分割线-拷贝"];
    
    [self.view addSubview:line];
    
    
    //返回按钮
    
    UIButton *Qurt = [UIButton buttonWithType:UIButtonTypeCustom];
    
    Qurt.frame = CGRectMake(10, 25, 30, 30);
    
    //    [Qurt setBackgroundImage:[UIImage imageNamed:@"iconfont-fanhui2yt"] forState:0];
    
    [Qurt setImage:[UIImage imageNamed:@"iconfont-fanhui2yt"] forState:0];
    
    
    [Qurt addTarget:self action:@selector(QurtBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [titleView addSubview:Qurt];
    
    //创建搜索
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 25, [UIScreen mainScreen].bounds.size.width-200, 30)];
    
    label.text = @"游戏点卡";
    
    label.textColor = [UIColor blackColor];
    
    label.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:20];
    
    label.textAlignment = NSTextAlignmentCenter;
    
    [titleView addSubview:label];
    
    
}

-(void)initName
{
    
    UIView *NameView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 50)];
    
    [_titleScroll addSubview:NameView];
    
    UILabel *NameLabel = [[UILabel alloc] init];
    NameLabel.text=@"游戏名称";
    CGRect tempRect = [NameLabel.text boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-100,13) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFang-SC-Regular" size:13]} context:nil];
    NameLabel.frame =CGRectMake(15, (50-13)/2, tempRect.size.width, 13);
    
    NameLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    NameLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:13];
    [NameView addSubview:NameLabel];
    
    UILabel *GameLabel = [[UILabel alloc] init];
    GameLabel.text=self.cardname;
    CGRect tempRect1 = [GameLabel.text boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-100,13) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFang-SC-Regular" size:13]} context:nil];
    GameLabel.frame =CGRectMake(15+tempRect.size.width+20, (50-13)/2, tempRect1.size.width, 13);
    
    GameLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    GameLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:13];
    [NameView addSubview:GameLabel];
    
    
    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(15, 50, [UIScreen mainScreen].bounds.size.width-15, 1)];
    line.image = [UIImage imageNamed:@"分割线-拷贝"];
    [_titleScroll addSubview:line];
    
}
-(void)initCount
{
    UIView *CountView = [[UIView alloc] initWithFrame:CGRectMake(0, 51, [UIScreen mainScreen].bounds.size.width, 50)];
    
    [_titleScroll addSubview:CountView];
    
    UILabel *NameLabel = [[UILabel alloc] init];
    NameLabel.text=@"游戏账号";
    CGRect tempRect = [NameLabel.text boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-100,13) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFang-SC-Regular" size:13]} context:nil];
    NameLabel.frame =CGRectMake(15, (50-13)/2, tempRect.size.width, 13);
    
    NameLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    NameLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:13];
    [CountView addSubview:NameLabel];
    
    CountTF = [[UITextField alloc] initWithFrame:CGRectMake(15+tempRect.size.width+20, (50-13)/2, [UIScreen mainScreen].bounds.size.width-100, 13)];
    CountTF.placeholder=@"请输入游戏账号";
    CountTF.delegate=self;
    CountTF.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    CountTF.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    CountTF.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:13];
    [CountView addSubview:CountTF];
    
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
    CountTF.inputAccessoryView = bar1;
    
    
    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(15, 51+50, [UIScreen mainScreen].bounds.size.width-15, 1)];
    
    line.image = [UIImage imageNamed:@"分割线-拷贝"];
    
    [_titleScroll addSubview:line];
    
}

-(void)CancleBtnclick
{
    
    [self.view endEditing:YES];
    CountTF.text = @"";
}

-(void)OKBtnclick
{
   // [];
    [self.view endEditing:YES];
}

-(void)CancleBtnclick4
{
    
    [self.view endEditing:YES];
    PassTF.text = @"";
}

-(void)OKBtnclick3
{
    
    [self.view endEditing:YES];
}

//创建战网通行证
-(void)initPassView
{
    UIView *NameView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 50)];
    
    [_titleScroll addSubview:NameView];
    
    UILabel *NameLabel = [[UILabel alloc] init];
    NameLabel.text=@"游戏名称";
    CGRect tempRect = [NameLabel.text boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-100,13) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFang-SC-Regular" size:13]} context:nil];
    NameLabel.frame =CGRectMake(15, (50-13)/2, tempRect.size.width, 13);
    
    NameLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    NameLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:13];
    [NameView addSubview:NameLabel];
    
    UILabel *GameLabel = [[UILabel alloc] init];
    GameLabel.text=self.cardname;
    CGRect tempRect1 = [GameLabel.text boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-100,13) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFang-SC-Regular" size:13]} context:nil];
    GameLabel.frame =CGRectMake(15+tempRect.size.width+20, (50-13)/2, tempRect1.size.width, 13);
    
    GameLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    GameLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:13];
    [NameView addSubview:GameLabel];
    
    
    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(15, 50, [UIScreen mainScreen].bounds.size.width-15, 1)];
    line.image = [UIImage imageNamed:@"分割线-拷贝"];
    [_titleScroll addSubview:line];
    
    UIView *CountView = [[UIView alloc] initWithFrame:CGRectMake(0, 51, [UIScreen mainScreen].bounds.size.width, 50)];
    
    [_titleScroll addSubview:CountView];
    
    UILabel *NameLabel1 = [[UILabel alloc] init];
    NameLabel1.text=@"游戏账号";
    CGRect tempRect2 = [NameLabel1.text boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-100,13) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFang-SC-Regular" size:13]} context:nil];
    NameLabel1.frame =CGRectMake(15, (50-13)/2, tempRect2.size.width, 13);
    
    NameLabel1.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    NameLabel1.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:13];
    [CountView addSubview:NameLabel1];
    
    CountTF = [[UITextField alloc] initWithFrame:CGRectMake(15+tempRect2.size.width+20, (50-13)/2, [UIScreen mainScreen].bounds.size.width-100, 13)];
    CountTF.placeholder=@"请输入游戏账号";
    CountTF.delegate=self;
    CountTF.tag = 100;
    CountTF.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    CountTF.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    CountTF.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:13];
    [CountView addSubview:CountTF];
    
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
    CountTF.inputAccessoryView = bar1;
    
    
    UIImageView *line1 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 51+50, [UIScreen mainScreen].bounds.size.width-15, 1)];
    
    line1.image = [UIImage imageNamed:@"分割线-拷贝"];
    
    [_titleScroll addSubview:line1];
    
    
    UIView *PassView = [[UIView alloc] initWithFrame:CGRectMake(0, 51+51, [UIScreen mainScreen].bounds.size.width, 50)];
    
    [_titleScroll addSubview:PassView];
    
    UILabel *PassLabel = [[UILabel alloc] init];
    PassLabel.text=@"战网通行证";
    CGRect PasstempRect = [PassLabel.text boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-100,13) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFang-SC-Regular" size:13]} context:nil];
    PassLabel.frame =CGRectMake(15, (50-13)/2, PasstempRect.size.width, 13);
    
    PassLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    PassLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:13];
    [PassView addSubview:PassLabel];
    
    PassTF = [[UITextField alloc] initWithFrame:CGRectMake(15+PasstempRect.size.width+20, (50-13)/2, [UIScreen mainScreen].bounds.size.width-100, 13)];
    PassTF.placeholder=@"请输入战网通行证";
    PassTF.delegate=self;
    PassTF.tag = 200;
    PassTF.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    PassTF.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    PassTF.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:13];
    [PassView addSubview:PassTF];
    
    UIToolbar *bar2 = [[UIToolbar alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH,44)];
    UIButton *button3 = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 60, 7,50, 30)];
    [button3 setTitle:@"确定"forState:UIControlStateNormal];
    [button3 setTitleColor:[UIColor redColor] forState:0];
    [button3 addTarget:self action:@selector(OKBtnclick3) forControlEvents:UIControlEventTouchUpInside];
    [bar2 addSubview:button3];
    
    UIButton *button4 = [[UIButton alloc] initWithFrame:CGRectMake(10, 7,50, 30)];
    [button4 setTitle:@"取消"forState:UIControlStateNormal];
    [button4 setTitleColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0] forState:0];
    [bar2 addSubview:button4];
    [button2 addTarget:self action:@selector(CancleBtnclick4) forControlEvents:UIControlEventTouchUpInside];
    PassTF.inputAccessoryView = bar2;
    
    UIImageView *line2 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 51+51+50, [UIScreen mainScreen].bounds.size.width-15, 1)];
    
    line2.image = [UIImage imageNamed:@"分割线-拷贝"];
    
    [_titleScroll addSubview:line2];
    
    
    ServiceView = [[UIView alloc] initWithFrame:CGRectMake(0, 51+51+51, [UIScreen mainScreen].bounds.size.width, 50)];
    
    [_titleScroll addSubview:ServiceView];
    
    UILabel *qufuLabel = [[UILabel alloc] init];
    
    qufuLabel.text=@"游戏区服";
    CGRect qufutempRect = [qufuLabel.text boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-100,13) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFang-SC-Regular" size:13]} context:nil];
    qufuLabel.frame =CGRectMake(15, (50-13)/2, qufutempRect.size.width, 13);
    
    qufuLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    qufuLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:13];
    [ServiceView addSubview:qufuLabel];
    
    ServiceLabel = [[UILabel alloc] init];
    ServiceLabel.text=@"";
    //    CGRect tempRect1 = [ServiceLabel.text boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-100,13) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFang-SC-Regular" size:13]} context:nil];
    ServiceLabel.frame =CGRectMake(15+qufutempRect.size.width+20, (50-13)/2, [UIScreen mainScreen].bounds.size.width-100, 13);
    
    ServiceLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    ServiceLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:13];
    [ServiceView addSubview:ServiceLabel];
    
    
    UIImageView *GoGo = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-29, (50-14)/2, 14, 14)];
    GoGo.image = [UIImage imageNamed:@"iconfont-enter111"];
    [ServiceView addSubview:GoGo];
    
    ServiceButton = [UIButton buttonWithType:UIButtonTypeCustom];
    ServiceButton.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 50);
    [ServiceButton addTarget:self action:@selector(ServiceButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [ServiceView addSubview:ServiceButton];
    
    UIImageView *line3 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 51+51+51+50, [UIScreen mainScreen].bounds.size.width-15, 1)];
    line3.image = [UIImage imageNamed:@"分割线-拷贝"];
    [_titleScroll addSubview:line3];
    
    UILabel *MianeLabel = [[UILabel alloc] init];
    MianeLabel.text=@"面额";
    MianeLabel.frame =CGRectMake(15, 51+51+51+51+19, 100, 14);
    MianeLabel.textColor = [UIColor colorWithRed:226/255.0 green:226/255.0 blue:226/255.0 alpha:1.0];
    MianeLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15];
    [_titleScroll addSubview:MianeLabel];
    
    ABButton *abBtn;
    
    
    for (int i = 0; i < _JiKa.count; i++) {
        
        BianMinModel *model = _JiKa[i];
        
        abBtn = [[ABButton alloc] init];
        abBtn.tag = [_Tag[i] integerValue];
        [abBtn setTitleColor:[UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0] forState:0];
        
        if ([model.cardname rangeOfString:_ArrM1[i]].location !=NSNotFound) {
            
            [abBtn setTitle:_ArrM1[i] forState:0];
            
        }else{
            
            [abBtn setTitle:[NSString stringWithFormat:@"%@元",model.pervalue] forState:0];
            
        }
        
        [abBtn setBackgroundImage:[UIImage imageNamed:@"框未选425"] forState:0];
        abBtn.enabled=YES;
        abBtn.size = CGSizeMake((SCREEN_WIDTH-60)/3, 59);
        int col = i % 3;
        abBtn.x = col * (abBtn.width + ABButtonMargin)+20;
        int row = i / 3;
        abBtn.y = row * (abBtn.height + ABButtonMargin)+51+51+51+51+19+10+14;
        
        if (i==0) {
            
            [abBtn setTitleColor:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0] forState:0];
            [abBtn setBackgroundImage:[UIImage imageNamed:@"框选中425"] forState:0];
            
            
        }
        
        [_titleScroll addSubview:abBtn];
        [abBtn addTarget:self action:@selector(chargePhone1:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    UILabel *ShuLiangLabel = [[UILabel alloc] init];
    ShuLiangLabel.text=@"数量";
    ShuLiangLabel.frame =CGRectMake(15, abBtn.y+59+19, 100, 14);
    ShuLiangLabel.textColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0];
    ShuLiangLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15];
    [_titleScroll addSubview:ShuLiangLabel];
    
    UIView *numberView = [[UIView alloc] initWithFrame:CGRectMake(15, abBtn.y+59+19+14+10, [UIScreen mainScreen].bounds.size.width-30, 35)];
//    numberView.backgroundColor=[UIColor orangeColor];
    [_titleScroll addSubview:numberView];
    
    UIImageView *numberImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width-30, 35)];
    numberImgView.image = [UIImage imageNamed:@"边框"];
    [numberView addSubview:numberImgView];
    
//    UIView *reduceView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 35, 35)];
//    [numberView addSubview:reduceView];
//    
//    UIImageView *reduceImgView = [[UIImageView alloc] initWithFrame:CGRectMake((35-20)/2, (35-2)/2, 20, 2)];
//    reduceImgView.image = [UIImage imageNamed:@"减1509"];
//    [numberView addSubview:reduceImgView];
    
    reduce = [UIButton buttonWithType:UIButtonTypeCustom];
    reduce.frame = CGRectMake(0, 0, 35, 35);
    reduce.tag=111;
    [reduce setImage:[UIImage imageNamed:@"减1509"] forState:0];
    [reduce addTarget:self action:@selector(ReduceBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [numberView addSubview:reduce];
    
    UIImageView *shu1 = [[UIImageView alloc] initWithFrame:CGRectMake(35, 0, 1, 35)];
    shu1.image = [UIImage imageNamed:@"分割线"];
    [numberView addSubview:shu1];
    
    
    add = [UIButton buttonWithType:UIButtonTypeCustom];
    add.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-30-35, 0, 35, 35);
    [add setImage:[UIImage imageNamed:@"加-(1)509"] forState:0];
    add.tag=222;
    [add addTarget:self action:@selector(AddBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [numberView addSubview:add];
    
    UIImageView *shu2 = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-30-36, 0, 1, 35)];
    shu2.image = [UIImage imageNamed:@"分割线"];
    [numberView addSubview:shu2];
    
    
    ChangeLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(36, 0, [UIScreen mainScreen].bounds.size.width-30-72, 35)];
    ChangeLabel1.text = @"";
    ChangeLabel1.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    ChangeLabel1.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15];
    ChangeLabel1.textAlignment = NSTextAlignmentCenter;
    [numberView addSubview:ChangeLabel1];
    
    
    UIView *PayView = [[UIView alloc] initWithFrame:CGRectMake(15, abBtn.y+59+19+14+10+35+50, [UIScreen mainScreen].bounds.size.width-30, 38)];
    PayView.layer.cornerRadius = 3;
    PayView.layer.masksToBounds = YES;
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)[UIColor colorWithRed:255/255.0 green:52/255.0 blue:90/255.0 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:255/255.0 green:91/255.0 blue:94/255.0 alpha:1.0].CGColor];
    gradientLayer.locations = @[@0.0, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1.0);
    gradientLayer.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width-30, 38);
    [PayView.layer addSublayer:gradientLayer];
    
    [_titleScroll addSubview:PayView];
    
    UIButton *Pay = [UIButton buttonWithType:UIButtonTypeCustom];
    Pay.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width-30, 38);
    Pay.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:15];
    [Pay addTarget:self action:@selector(PayBtnCLick) forControlEvents:UIControlEventTouchUpInside];
    [Pay setTitle:@"立即充值" forState:0];
    Pay.layer.cornerRadius = 3;
    Pay.layer.masksToBounds = YES;
    [Pay setTitleColor:[UIColor whiteColor] forState:0];
    [PayView addSubview:Pay];
    
    
    for (int i = 0; i < _JiKa.count; i++) {
        
        BianMinModel *model = _JiKa[i];
        
        ABButton *button = (ABButton *)[self.view viewWithTag:[_Tag[i] integerValue]];
        [button setTitleColor:[UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0] forState:0];
        
        button.aboveL.textColor=[UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0];
        button.belowL.textColor=[UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0];
        button.centerL.textColor=[UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0];
        [button setBackgroundImage:[UIImage imageNamed:@"框未选425"] forState:0];
        
        if (i==0) {
            
            UIButton *btn= [self.view viewWithTag:[_Tag[i] integerValue]];
            [btn setTitleColor:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0] forState:0];
            [btn setBackgroundImage:[UIImage imageNamed:@"框选中425"] forState:0];
            
            self.Commitpervalue = model.pervalue;
            self.Commitcardid = model.cardid;
            self.Commitcardname = model.cardname;
            self.recharge_type = model.recharge_type;
            
            NSArray *array = [model.amounts componentsSeparatedByString:@"-"];
            ChangeLabel1.text = [NSString stringWithFormat:@"%@",array[0]];
            [reduce setImage:[UIImage imageNamed:@"减509"] forState:0];
            self.Max = [NSString stringWithFormat:@"%@",array[1]];
            self.Min = [NSString stringWithFormat:@"%@",array[0]];
        }
        
    }
    
    
    
}

//加
-(void)AddBtnClick:(UIButton *)sender
{
    [self.view endEditing:YES];
    UIButton *button = (UIButton *)[self.view viewWithTag:222];
    button.enabled=YES;
    UIButton *button1 = (UIButton *)[self.view viewWithTag:111];
    button1.enabled=YES;
    [button1 setImage:[UIImage imageNamed:@"减1509"] forState:0];
    
    if ([ChangeLabel1.text intValue] >= [self.Max intValue]) {
        
        [button setImage:[UIImage imageNamed:@"加509"] forState:0];
        
        button.enabled=NO;
        
    }else{
        
        ChangeLabel1.text = [NSString stringWithFormat:@"%d",[ChangeLabel1.text intValue] + 1];
        
        if ([ChangeLabel1.text intValue] == [self.Max intValue]) {
            
            [add setImage:[UIImage imageNamed:@"加509"] forState:0];
        }
        
    }
    
    
}
//减
-(void)ReduceBtnClick:(UIButton *)sender
{
    NSLog(@"111");
    
    [self.view endEditing:YES];
    
    UIButton *button = (UIButton *)[self.view viewWithTag:111];
    button.enabled=YES;
    UIButton *button1 = (UIButton *)[self.view viewWithTag:222];
    button1.enabled=YES;
    [button1 setImage:[UIImage imageNamed:@"加-(1)509"] forState:0];
    
    if ([ChangeLabel1.text intValue] <= [self.Min intValue]) {
        
        [button setImage:[UIImage imageNamed:@"减509"] forState:0];
        
        button.enabled=NO;
        
    }else{
        
        ChangeLabel1.text = [NSString stringWithFormat:@"%d",[ChangeLabel1.text intValue] - 1];
        
        if ([ChangeLabel1.text intValue] == [self.Min intValue]) {
            
            [reduce setImage:[UIImage imageNamed:@"减509"] forState:0];
        }
        
    }
    
    
    
}

//加
-(void)AddBtnClick1:(UIButton *)sender
{
    [self.view endEditing:YES];
    UIButton *button = (UIButton *)[self.view viewWithTag:444];
    button.enabled=YES;
    UIButton *button1 = (UIButton *)[self.view viewWithTag:333];
    button1.enabled=YES;
    [button1 setImage:[UIImage imageNamed:@"减1509"] forState:0];
    
    if ([ChangeLabel1.text intValue] >= [self.Max intValue]) {
        
        [button setImage:[UIImage imageNamed:@"加509"] forState:0];
        
        button.enabled=NO;
        
    }else{
        
        ChangeLabel1.text = [NSString stringWithFormat:@"%d",[ChangeLabel1.text intValue] + 1];
        
        if ([ChangeLabel1.text intValue] == [self.Max intValue]) {
            
            [add setImage:[UIImage imageNamed:@"加509"] forState:0];
        }
        
    }
    
    
}
//减
-(void)ReduceBtnClick1:(UIButton *)sender
{
    NSLog(@"222");
    
    [self.view endEditing:YES];
    UIButton *button = (UIButton *)[self.view viewWithTag:333];
    button.enabled=YES;
    UIButton *button1 = (UIButton *)[self.view viewWithTag:444];
    button1.enabled=YES;
    [button1 setImage:[UIImage imageNamed:@"加-(1)509"] forState:0];
    
    if ([ChangeLabel1.text intValue] <= [self.Min intValue]) {
        
        [button setImage:[UIImage imageNamed:@"减509"] forState:0];
        
        button.enabled=NO;
        
    }else{
        
        ChangeLabel1.text = [NSString stringWithFormat:@"%d",[ChangeLabel1.text intValue] - 1];
        
        if ([ChangeLabel1.text intValue] == [self.Min intValue]) {
            
            [reduce setImage:[UIImage imageNamed:@"减509"] forState:0];
        }
        
    }
    
}


//加
-(void)AddBtnClick2:(UIButton *)sender
{
    
//    NSLog(@"====%@",price);
    
    
    [self.view endEditing:YES];
    UIButton *button = (UIButton *)[self.view viewWithTag:666];
    button.enabled=YES;
    UIButton *button1 = (UIButton *)[self.view viewWithTag:555];
    button1.enabled=YES;
    [button1 setImage:[UIImage imageNamed:@"减1509"] forState:0];
    
    if ([price[0] rangeOfString:@"-"].location !=NSNotFound) {
        
        NSArray *array = [price[0] componentsSeparatedByString:@"-"];
        
        if (price.count==1) {
            
            self.Max = array[1];
            
            if ([ChangeLabel1.text intValue] >= [self.Max intValue]) {
                
                [button setImage:[UIImage imageNamed:@"加509"] forState:0];
                
                button.enabled=NO;
                
            }else{
                
                ChangeLabel1.text = [NSString stringWithFormat:@"%d",[ChangeLabel1.text intValue] + 1];
                
                if ([ChangeLabel1.text intValue] == [self.Max intValue]) {
                    
                    [add setImage:[UIImage imageNamed:@"加509"] forState:0];
                }
                
            }
            
            
        }else{
            
            self.Max =price[price.count-1];
            
            if ([ChangeLabel1.text intValue] >= [self.Max intValue]) {
                
                [button setImage:[UIImage imageNamed:@"加509"] forState:0];
                
                button.enabled=NO;
                
            }else{
                
                
                
                if ([ChangeLabel1.text intValue] < [array[1] intValue]) {
                    
                     ChangeLabel1.text = [NSString stringWithFormat:@"%d",[ChangeLabel1.text intValue] + 1];
                    
                }else{
                    
                    if (num < price.count-1) {
                        
                        num = num + 1;
                    }
                    
                    NSLog(@"=====%d",num);
                    
                    ChangeLabel1.text = [NSString stringWithFormat:@"%d",[price[num] intValue]];
                    
                    if ([ChangeLabel1.text intValue] == [self.Max intValue]) {
                        
                        [add setImage:[UIImage imageNamed:@"加509"] forState:0];
                    }
                }
               
                
            }
            
        }
        
        
        
    }else{
        
        if (num < price.count-1) {
            
            num = num + 1;
        }
        
        self.Max =price[price.count-1];
        
        NSLog(@"===self.Max===%@====%d",self.Max,num);
        
        if ([ChangeLabel1.text intValue] >= [self.Max intValue]) {
            
            [button setImage:[UIImage imageNamed:@"加509"] forState:0];
            
            button.enabled=NO;
            
        }else{
            
                
            ChangeLabel1.text = [NSString stringWithFormat:@"%d",[price[num] intValue]];
            
            if ([ChangeLabel1.text intValue] == [self.Max intValue]) {
                
                [add setImage:[UIImage imageNamed:@"加509"] forState:0];
            }
        }
        
        
        
        
    }
    
}
//减
-(void)ReduceBtnClick2:(UIButton *)sender
{
    NSLog(@"333");
    
    [self.view endEditing:YES];
    
    UIButton *button = (UIButton *)[self.view viewWithTag:555];
    button.enabled=YES;
    UIButton *button1 = (UIButton *)[self.view viewWithTag:666];
    button1.enabled=YES;
    [button1 setImage:[UIImage imageNamed:@"加-(1)509"] forState:0];
    
    NSLog(@"===减===%d",num);
    
    
    
    if ([price[0] rangeOfString:@"-"].location !=NSNotFound) {
        
        NSArray *array = [price[0] componentsSeparatedByString:@"-"];
        
//        ChangeLabel1.text = [NSString stringWithFormat:@"%@",array[0]];
        
        if (price.count==1) {
            
            self.Min = array[0];
            
            if ([ChangeLabel1.text intValue] <= [self.Min intValue]) {
                
                [button setImage:[UIImage imageNamed:@"减509"] forState:0];
                
                button.enabled=NO;
                
            }else{
                
                ChangeLabel1.text = [NSString stringWithFormat:@"%d",[ChangeLabel1.text intValue] - 1];
                
//                NSLog(@"=====%d=====%d",[ChangeLabel1.text intValue] - 1,[self.Min intValue]);
                
                if ([ChangeLabel1.text intValue] == [self.Min intValue]) {
                    
                    [reduce setImage:[UIImage imageNamed:@"减509"] forState:0];
                }
            }
            
            
        }else{
            
            self.Min =price[0];
            
            if ([ChangeLabel1.text intValue] <= [self.Min intValue]) {
                
                [button setImage:[UIImage imageNamed:@"减509"] forState:0];
                
                button.enabled=NO;
                
            }else{
                
                
                
                if ([ChangeLabel1.text intValue] <= [array[1] intValue]) {
                    
                    NSLog(@"小于");
                    
                    ChangeLabel1.text = [NSString stringWithFormat:@"%d",[ChangeLabel1.text intValue] - 1];
                    
                    if ([ChangeLabel1.text intValue] == [self.Min intValue]) {
                        
                        [reduce setImage:[UIImage imageNamed:@"减509"] forState:0];
                    }
                    
                }else{
                    
                    if (num > 0) {
                        
                        num = num - 1;
                    }
                    
                    NSLog(@"===num==%d====%@",num,price[0]);
                    
                    if (num==0) {
                        
                        ChangeLabel1.text = [NSString stringWithFormat:@"%d",[array[1] intValue]];
                        
                        if ([ChangeLabel1.text intValue] == [self.Min intValue]) {
                            
                            [reduce setImage:[UIImage imageNamed:@"减509"] forState:0];
                        }
                        
                    }else{
                        
                        ChangeLabel1.text = [NSString stringWithFormat:@"%d",[price[num] intValue]];
                        
                        if ([ChangeLabel1.text intValue] == [self.Min intValue]) {
                            
                            [reduce setImage:[UIImage imageNamed:@"减509"] forState:0];
                        }
                        
                    }
                    
                }
                
                
            }
            
        }
        
        
    }else{
        
        if (num > 0) {
            
            num = num - 1;
        }
        
        self.Min =price[0];
        
        NSLog(@"===self.Min===%@====%d",self.Min,num);
        
        if ([ChangeLabel1.text intValue] <= [self.Min intValue]) {
            
            [button setImage:[UIImage imageNamed:@"减509"] forState:0];
            
            button.enabled=NO;
            
        }else{
            
            
            ChangeLabel1.text = [NSString stringWithFormat:@"%d",[price[num] intValue]];
            
            if ([ChangeLabel1.text intValue] == [self.Min intValue]) {
                
                [reduce setImage:[UIImage imageNamed:@"减509"] forState:0];
            }
            
        }
        
        
        
    }
    
}

-(void)initService
{
    ServiceView = [[UIView alloc] initWithFrame:CGRectMake(0, 51+51, [UIScreen mainScreen].bounds.size.width, 50)];
    
    [_titleScroll addSubview:ServiceView];
    
    UILabel *NameLabel = [[UILabel alloc] init];
    
    NameLabel.text=@"游戏区服";
    CGRect tempRect = [NameLabel.text boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-100,13) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFang-SC-Regular" size:13]} context:nil];
    NameLabel.frame =CGRectMake(15, (50-13)/2, tempRect.size.width, 13);
    
    NameLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    NameLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:13];
    [ServiceView addSubview:NameLabel];
    
    ServiceLabel = [[UILabel alloc] init];
    ServiceLabel.text=@"";
//    CGRect tempRect1 = [ServiceLabel.text boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-100,13) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFang-SC-Regular" size:13]} context:nil];
    ServiceLabel.frame =CGRectMake(15+tempRect.size.width+20, (50-13)/2, [UIScreen mainScreen].bounds.size.width-100, 13);
    
    ServiceLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    ServiceLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:13];
    [ServiceView addSubview:ServiceLabel];
    
    
    UIImageView *GoGo = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-29, (50-14)/2, 14, 14)];
    GoGo.image = [UIImage imageNamed:@"iconfont-enter111"];
    [ServiceView addSubview:GoGo];
    
    ServiceButton = [UIButton buttonWithType:UIButtonTypeCustom];
    ServiceButton.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 50);
    [ServiceButton addTarget:self action:@selector(ServiceButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [ServiceView addSubview:ServiceButton];
    
    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(15, 51+51+50, [UIScreen mainScreen].bounds.size.width-15, 1)];
    line.image = [UIImage imageNamed:@"分割线-拷贝"];
    [_titleScroll addSubview:line];
    
    
//    UIView *PayView = [[UIView alloc] initWithFrame:CGRectMake(15, [UIScreen mainScreen].bounds.size.height-38, [UIScreen mainScreen].bounds.size.width-30, 38)];
//    PayView.layer.cornerRadius = 3;
//    PayView.layer.masksToBounds = YES;
//    
//    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
//    gradientLayer.colors = @[(__bridge id)[UIColor colorWithRed:255/255.0 green:52/255.0 blue:90/255.0 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:255/255.0 green:91/255.0 blue:94/255.0 alpha:1.0].CGColor];
//    gradientLayer.locations = @[@0.0, @1.0];
//    gradientLayer.startPoint = CGPointMake(0, 0);
//    gradientLayer.endPoint = CGPointMake(0, 1.0);
//    gradientLayer.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width-30, 38);
//    [PayView.layer addSublayer:gradientLayer];
//    
//    [_titleScroll addSubview:PayView];
//    
//    UIButton *Pay = [UIButton buttonWithType:UIButtonTypeCustom];
//    Pay.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width-30, 38);
//    Pay.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:15];
//    [Pay addTarget:self action:@selector(PayBtnCLick) forControlEvents:UIControlEventTouchUpInside];
//    [Pay setTitle:@"支付" forState:0];
//    Pay.layer.cornerRadius = 3;
//    Pay.layer.masksToBounds = YES;
//    [Pay setTitleColor:[UIColor whiteColor] forState:0];
//    [PayView addSubview:Pay];
    
    
}

-(void)initNumberView
{
    UILabel *MianE = [[UILabel alloc] init];
    MianE.text=@"面额";
    MianE.frame =CGRectMake(15, 233-65, 100, 14);
    MianE.textColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0];
    MianE.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15];
    [_titleScroll addSubview:MianE];
    ABButton *abBtn;
    
    for (int i = 0; i < _Money.count; i++) {
        
        BianMinModel *model = _Money[i];
        
        abBtn = [[ABButton alloc] init];
        abBtn.tag = [_Tag[i] integerValue];
        [abBtn setTitleColor:[UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0] forState:0];
        [abBtn buttonWithAboveLabelTitle:model.pervalue belowLabelTitle:self.game_currency_name Name:self.conversion_rate Rate:self.conversion_rate];
        [abBtn setBackgroundImage:[UIImage imageNamed:@"框未选425"] forState:0];
        abBtn.enabled=YES;
        abBtn.size = CGSizeMake((SCREEN_WIDTH-60)/3, 59);
        int col = i % 3;
        abBtn.x = col * (abBtn.width + ABButtonMargin)+20;
        int row = i / 3;
        abBtn.y = row * (abBtn.height + ABButtonMargin)+233+30-65;
        
        if (i==0) {
            
            abBtn.centerL.textColor = [UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
            abBtn.aboveL.textColor = [UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
            abBtn.belowL.textColor = [UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
            [abBtn setBackgroundImage:[UIImage imageNamed:@"框选中425"] forState:0];
            
            
            
        }
        [_titleScroll addSubview:abBtn];
        [abBtn addTarget:self action:@selector(chargePhone:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    if ([self.istype isEqualToString:@"2"]) {
        
        UILabel *Way = [[UILabel alloc] init];
        Way.text=@"充值类型";
        Way.frame =CGRectMake(15, abBtn.y+70, 100, 14);
        Way.textColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0];
        Way.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15];
        [_titleScroll addSubview:Way];
        
        UIButton *typeBtn;
        NSArray *titArrM = @[@"游戏点卡",@"交易寄售"];
        NSArray *TagArrM = @[@"666",@"777"];
        for (int i = 0; i < 2; i++) {
            
            
            typeBtn = [[UIButton alloc] init];
            typeBtn.tag = [TagArrM[i] integerValue];
            [typeBtn setTitleColor:[UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0] forState:0];
            [typeBtn setTitle:titArrM[i] forState:0];
            [typeBtn setBackgroundImage:[UIImage imageNamed:@"框未选425"] forState:0];
            typeBtn.enabled=YES;
            typeBtn.size = CGSizeMake(121, 59);
            int col = i % 3;
            typeBtn.x = col * (typeBtn.width + ABButtonMargin)+20;
            int row = i / 3;
            typeBtn.y = row * (typeBtn.height + ABButtonMargin)+abBtn.y+70+24;
            
            if (i==0) {
                
                
                [typeBtn setTitleColor:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0] forState:0];
                [typeBtn setBackgroundImage:[UIImage imageNamed:@"框选中425"] forState:0];
            }
            
            [_titleScroll addSubview:typeBtn];
            [typeBtn addTarget:self action:@selector(chargePhone3:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        UILabel *ShuLiangLabel = [[UILabel alloc] init];
        ShuLiangLabel.text=@"数量";
        ShuLiangLabel.frame =CGRectMake(15, typeBtn.y+20+59, 100, 14);
        ShuLiangLabel.textColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0];
        ShuLiangLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15];
        [_titleScroll addSubview:ShuLiangLabel];
        
        UIView *numberView = [[UIView alloc] initWithFrame:CGRectMake(15, typeBtn.y+20+14+59+10, [UIScreen mainScreen].bounds.size.width-30, 35)];
        //    numberView.backgroundColor=[UIColor orangeColor];
        [_titleScroll addSubview:numberView];
        
        UIImageView *numberImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width-30, 35)];
        numberImgView.image = [UIImage imageNamed:@"边框"];
        [numberView addSubview:numberImgView];
        
        //    UIView *reduceView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 35, 35)];
        //    [numberView addSubview:reduceView];
        //
        //    UIImageView *reduceImgView = [[UIImageView alloc] initWithFrame:CGRectMake((35-20)/2, (35-2)/2, 20, 2)];
        //    reduceImgView.image = [UIImage imageNamed:@"减1509"];
        //    [numberView addSubview:reduceImgView];
        
        reduce = [UIButton buttonWithType:UIButtonTypeCustom];
        reduce.frame = CGRectMake(0, 0, 35, 35);
        [reduce setImage:[UIImage imageNamed:@"减1509"] forState:0];
        reduce.tag=333;
        [reduce addTarget:self action:@selector(ReduceBtnClick1:) forControlEvents:UIControlEventTouchUpInside];
        [numberView addSubview:reduce];
        
        UIImageView *shu1 = [[UIImageView alloc] initWithFrame:CGRectMake(35, 0, 1, 35)];
        shu1.image = [UIImage imageNamed:@"分割线"];
        [numberView addSubview:shu1];
        
        
        add = [UIButton buttonWithType:UIButtonTypeCustom];
        add.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-30-35, 0, 35, 35);
        [add setImage:[UIImage imageNamed:@"加-(1)509"] forState:0];
        add.tag=444;
        [add addTarget:self action:@selector(AddBtnClick1:) forControlEvents:UIControlEventTouchUpInside];
        [numberView addSubview:add];
        
        UIImageView *shu2 = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-30-36, 0, 1, 35)];
        shu2.image = [UIImage imageNamed:@"分割线"];
        [numberView addSubview:shu2];
        
        
        ChangeLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(36, 0, [UIScreen mainScreen].bounds.size.width-30-72, 35)];
        ChangeLabel1.text = @"";
        ChangeLabel1.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        ChangeLabel1.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15];
        ChangeLabel1.textAlignment = NSTextAlignmentCenter;
        [numberView addSubview:ChangeLabel1];
        
        
        UIView *PayView = [[UIView alloc] initWithFrame:CGRectMake(15, typeBtn.y+20+14+35+50+59+10, [UIScreen mainScreen].bounds.size.width-30, 38)];
        PayView.layer.cornerRadius = 3;
        PayView.layer.masksToBounds = YES;
        
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        gradientLayer.colors = @[(__bridge id)[UIColor colorWithRed:255/255.0 green:52/255.0 blue:90/255.0 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:255/255.0 green:91/255.0 blue:94/255.0 alpha:1.0].CGColor];
        gradientLayer.locations = @[@0.0, @1.0];
        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint = CGPointMake(0, 1.0);
        gradientLayer.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width-30, 38);
        [PayView.layer addSublayer:gradientLayer];
        
        [_titleScroll addSubview:PayView];
        
        UIButton *Pay = [UIButton buttonWithType:UIButtonTypeCustom];
        Pay.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width-30, 38);
        Pay.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:15];
        [Pay addTarget:self action:@selector(PayBtnCLick) forControlEvents:UIControlEventTouchUpInside];
        [Pay setTitle:@"立即充值" forState:0];
        Pay.layer.cornerRadius = 3;
        Pay.layer.masksToBounds = YES;
        [Pay setTitleColor:[UIColor whiteColor] forState:0];
        [PayView addSubview:Pay];
        
        
        for (int i = 0; i < _Money.count; i++) {
            
            BianMinModel *model = _Money[i];
            
            ABButton *button = (ABButton *)[self.view viewWithTag:[_Tag[i] integerValue]];
            [button setTitleColor:[UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0] forState:0];
            
            button.aboveL.textColor=[UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0];
            button.belowL.textColor=[UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0];
            button.centerL.textColor=[UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0];
            [button setBackgroundImage:[UIImage imageNamed:@"框未选425"] forState:0];
            
            if (i==0) {
                
                ABButton *btn= [self.view viewWithTag:[_Tag[i] integerValue]];
                btn.centerL.textColor = [UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
                btn.aboveL.textColor = [UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
                btn.belowL.textColor = [UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
                [btn setTitleColor:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0] forState:0];
                [btn setBackgroundImage:[UIImage imageNamed:@"框选中425"] forState:0];
                
                self.Commitpervalue = model.pervalue;
                self.Commitcardid = model.cardid;
                self.Commitcardname = model.cardname;
                self.recharge_type = model.recharge_type;
                self.cardname_type= model.cardname_type;
                
                price = [model.amounts componentsSeparatedByString:@","];
                
                if ([price[0] rangeOfString:@"-"].location !=NSNotFound) {
                    
                    NSArray *array = [price[0] componentsSeparatedByString:@"-"];
                    
                    ChangeLabel1.text = [NSString stringWithFormat:@"%@",array[0]];
                    [reduce setImage:[UIImage imageNamed:@"减509"] forState:0];
                    self.Max = [NSString stringWithFormat:@"%@",array[1]];
                    self.Min = [NSString stringWithFormat:@"%@",array[0]];
                    
                }else{
                    
                    ChangeLabel1.text = [NSString stringWithFormat:@"%@",price[0]];
                    [reduce setImage:[UIImage imageNamed:@"减509"] forState:0];
                }
                
//                NSArray *array = [model.amounts componentsSeparatedByString:@"-"];
//                ChangeLabel1.text = [NSString stringWithFormat:@"%@",array[0]];
//                
//                self.Max = [NSString stringWithFormat:@"%@",array[1]];
//                self.Min = [NSString stringWithFormat:@"%@",array[0]];
            }
            
        }
        
        
        
        NSArray *TagArrM1 = @[@"666",@"777"];
        
        for (int i = 0; i < 2; i++) {
            
            
            UIButton *button = (UIButton *)[self.view viewWithTag:[TagArrM1[i] integerValue]];
            [button setTitleColor:[UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0] forState:0];
            
            [button setBackgroundImage:[UIImage imageNamed:@"框未选425"] forState:0];
            
            if (i==0) {
                
                
                for (BianMinModel *model in _Left) {
                    
                    if ([model.pervalue isEqualToString:self.Commitpervalue]) {
                        
                        self.Commitcardid = model.cardid;
                        self.Commitcardname = model.cardname;
                    }
                }
                UIButton *btn= [self.view viewWithTag:[TagArrM1[i] integerValue]];
                [btn setTitleColor:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0] forState:0];
                [btn setBackgroundImage:[UIImage imageNamed:@"框选中425"] forState:0];
                
                
            }
            

        }

        
        
    }else{
        
        
        UILabel *ShuLiangLabel = [[UILabel alloc] init];
        ShuLiangLabel.text=@"数量";
        ShuLiangLabel.frame =CGRectMake(15, abBtn.y+20+59, 100, 14);
        ShuLiangLabel.textColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0];
        ShuLiangLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15];
        [_titleScroll addSubview:ShuLiangLabel];
        
        UIView *numberView = [[UIView alloc] initWithFrame:CGRectMake(15, abBtn.y+20+14+59+10, [UIScreen mainScreen].bounds.size.width-30, 35)];
        //    numberView.backgroundColor=[UIColor orangeColor];
        [_titleScroll addSubview:numberView];
        
        UIImageView *numberImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width-30, 35)];
        numberImgView.image = [UIImage imageNamed:@"边框"];
        [numberView addSubview:numberImgView];
        
        
        reduce = [UIButton buttonWithType:UIButtonTypeCustom];
        reduce.frame = CGRectMake(0, 0, 35, 35);
        [reduce setImage:[UIImage imageNamed:@"减1509"] forState:0];
        reduce.tag=555;
        [reduce addTarget:self action:@selector(ReduceBtnClick2:) forControlEvents:UIControlEventTouchUpInside];
        [numberView addSubview:reduce];
        
        UIImageView *shu1 = [[UIImageView alloc] initWithFrame:CGRectMake(35, 0, 1, 35)];
        shu1.image = [UIImage imageNamed:@"分割线"];
        [numberView addSubview:shu1];
        
        
        add = [UIButton buttonWithType:UIButtonTypeCustom];
        add.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-30-35, 0, 35, 35);
        [add setImage:[UIImage imageNamed:@"加-(1)509"] forState:0];
        add.tag=666;
        [add addTarget:self action:@selector(AddBtnClick2:) forControlEvents:UIControlEventTouchUpInside];
        [numberView addSubview:add];
        
        UIImageView *shu2 = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-30-36, 0, 1, 35)];
        shu2.image = [UIImage imageNamed:@"分割线"];
        [numberView addSubview:shu2];
        
        
        ChangeLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(36, 0, [UIScreen mainScreen].bounds.size.width-30-72, 35)];
        ChangeLabel1.text = @"";
        ChangeLabel1.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        ChangeLabel1.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15];
        ChangeLabel1.textAlignment = NSTextAlignmentCenter;
        [numberView addSubview:ChangeLabel1];
        
        
        UIView *PayView = [[UIView alloc] initWithFrame:CGRectMake(15, abBtn.y+20+14+35+50+59+10, [UIScreen mainScreen].bounds.size.width-30, 38)];
        PayView.layer.cornerRadius = 3;
        PayView.layer.masksToBounds = YES;
        
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        gradientLayer.colors = @[(__bridge id)[UIColor colorWithRed:255/255.0 green:52/255.0 blue:90/255.0 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:255/255.0 green:91/255.0 blue:94/255.0 alpha:1.0].CGColor];
        gradientLayer.locations = @[@0.0, @1.0];
        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint = CGPointMake(0, 1.0);
        gradientLayer.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width-30, 38);
        [PayView.layer addSublayer:gradientLayer];
        
        [_titleScroll addSubview:PayView];
        
        UIButton *Pay = [UIButton buttonWithType:UIButtonTypeCustom];
        Pay.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width-30, 38);
        Pay.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:15];
        [Pay addTarget:self action:@selector(PayBtnCLick) forControlEvents:UIControlEventTouchUpInside];
        [Pay setTitle:@"立即充值" forState:0];
        Pay.layer.cornerRadius = 3;
        Pay.layer.masksToBounds = YES;
        [Pay setTitleColor:[UIColor whiteColor] forState:0];
        [PayView addSubview:Pay];
        
        for (int i = 0; i < _LOLArrM.count; i++) {
            
            BianMinModel *model = _LOLArrM[i];
            
            ABButton *button = (ABButton *)[self.view viewWithTag:[_Tag[i] integerValue]];
            [button setTitleColor:[UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0] forState:0];
            
            button.aboveL.textColor=[UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0];
            button.belowL.textColor=[UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0];
            button.centerL.textColor=[UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0];
            [button setBackgroundImage:[UIImage imageNamed:@"框未选425"] forState:0];
            
            if (i==0) {
                
                NSLog(@"===3==model.pervalue===%@===model.cardid==%@====%@",model.pervalue,model.cardid,model.cardname);
                
                self.Commitpervalue = model.pervalue;
                self.Commitcardid = model.cardid;
                self.Commitcardname = model.cardname;
                
                ABButton *btn= [self.view viewWithTag:[_Tag[i] integerValue]];
                btn.centerL.textColor = [UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
                btn.aboveL.textColor = [UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
                btn.belowL.textColor = [UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
                [btn setTitleColor:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0] forState:0];
                [btn setBackgroundImage:[UIImage imageNamed:@"框选中425"] forState:0];
                
                price = [model.amounts componentsSeparatedByString:@","];
                
                if ([price[0] rangeOfString:@"-"].location !=NSNotFound) {
                    
                    NSArray *array = [price[0] componentsSeparatedByString:@"-"];
                    
                    ChangeLabel1.text = [NSString stringWithFormat:@"%@",array[0]];
                    [reduce setImage:[UIImage imageNamed:@"减509"] forState:0];
                }else{
                    
                    ChangeLabel1.text = [NSString stringWithFormat:@"%@",price[0]];
                    [reduce setImage:[UIImage imageNamed:@"减509"] forState:0];
                }
                
            }
            
        }
        
    }
    
}


-(void)chargePhone3:(UIButton *)sender{
    
    [self.view endEditing:YES];
    
    NSLog(@"======chargePhone3=====%@==999=%@",self.recharge_type,self.Commitpervalue);
    
//    NSArray *array = [self.recharge_type componentsSeparatedByString:@"_"];
//    NSArray *array1 = [self.cardname_type componentsSeparatedByString:@"@"];
    
    NSArray *TagArrM = @[@"666",@"777"];
    for (int i = 0; i < 2; i++) {
        
//        BianMinModel *model = _JiKa[i];
        
        UIButton *button = (UIButton *)[self.view viewWithTag:[TagArrM[i] integerValue]];
        [button setTitleColor:[UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0] forState:0];
        
        [button setBackgroundImage:[UIImage imageNamed:@"框未选425"] forState:0];
        
        if (sender.tag ==[TagArrM[i] integerValue]) {
            
//            NSLog(@"====sender.tag====%ld=====%ld",sender.tag,[TagArrM[i] integerValue]);
            
            NSString *Tag = [NSString stringWithFormat:@"%ld",sender.tag];
            
            if ([Tag isEqualToString:TagArrM[0]]) {
                
                self.ChangeString = @"666";
                
                for (BianMinModel *model in _Left) {
                    
                    if ([model.pervalue isEqualToString:self.Commitpervalue]) {
                        
                        self.Commitcardid = model.cardid;
                        self.Commitcardname = model.cardname;
                        
                        NSLog(@"===666===self.Commitcardid=====%@===self.Commitcardname==%@",self.Commitcardid,self.Commitcardname);
                        
                    }
                }
                
                
            }else if([Tag isEqualToString:TagArrM[1]]){
                
                NSLog(@"9999===%ld",_Right.count);
                
                self.ChangeString = @"777";
                
                for (BianMinModel *model in _Right) {
                    
                    if ([model.pervalue isEqualToString:self.Commitpervalue]) {
                        
                        self.Commitcardid = model.cardid;
                        self.Commitcardname = model.cardname;
                        
                        NSLog(@"===777===self.Commitcardid=====%@===self.Commitcardname==%@",self.Commitcardid,self.Commitcardname);
                        
                    }
                }
            }
            UIButton *btn= [self.view viewWithTag:sender.tag];
            [btn setTitleColor:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0] forState:0];
            [btn setBackgroundImage:[UIImage imageNamed:@"框选中425"] forState:0];
            
            
        }
        
    }
    
}

-(void)chargePhone1:(ABButton*)sender{
    
    NSLog(@"======chargePhone1=====");
    [self.view endEditing:YES];
    
    for (int i = 0; i < _JiKa.count; i++) {
        
        BianMinModel *model = _JiKa[i];
        
        ABButton *button = (ABButton *)[self.view viewWithTag:[_Tag[i] integerValue]];
        [button setTitleColor:[UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0] forState:0];
        
        button.aboveL.textColor=[UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0];
        button.belowL.textColor=[UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0];
        button.centerL.textColor=[UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0];
        [button setBackgroundImage:[UIImage imageNamed:@"框未选425"] forState:0];
        
        if (sender.tag ==[_Tag[i] integerValue]) {
            
            add.enabled=YES;
            
            UIButton *btn= [self.view viewWithTag:sender.tag];
            sender.aboveL.textColor=[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
            sender.belowL.textColor=[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
            sender.centerL.textColor=[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
            [btn setTitleColor:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0] forState:0];
            [btn setBackgroundImage:[UIImage imageNamed:@"框选中425"] forState:0];
            
            self.Commitpervalue = model.pervalue;
            self.Commitcardid = model.cardid;
            self.Commitcardname = model.cardname;
            self.recharge_type = model.recharge_type;
            
            
            NSArray *array = [model.amounts componentsSeparatedByString:@"-"];
            ChangeLabel1.text = [NSString stringWithFormat:@"%@",array[0]];
            [reduce setImage:[UIImage imageNamed:@"减509"] forState:0];
            [add setImage:[UIImage imageNamed:@"加-(1)509"] forState:0];
            self.Max = [NSString stringWithFormat:@"%@",array[1]];
            self.Min = [NSString stringWithFormat:@"%@",array[0]];
        }
        
    }
    
}

-(void)chargePhone:(ABButton*)sender{
    
    NSLog(@"===========");
    
    [self.view endEditing:YES];
    for (int i = 0; i < _Money.count; i++) {
        
        BianMinModel *model = _Money[i];
        
        ABButton *button = (ABButton *)[self.view viewWithTag:[_Tag[i] integerValue]];
        [button setTitleColor:[UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0] forState:0];
        
        button.aboveL.textColor=[UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0];
        button.belowL.textColor=[UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0];
        button.centerL.textColor=[UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0];
        [button setBackgroundImage:[UIImage imageNamed:@"框未选425"] forState:0];
        
        if (sender.tag ==[_Tag[i] integerValue]) {
            
            add.enabled=YES;
            
            UIButton *btn= [self.view viewWithTag:sender.tag];
            sender.aboveL.textColor=[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
            sender.belowL.textColor=[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
            sender.centerL.textColor=[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
            [btn setTitleColor:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0] forState:0];
            [btn setBackgroundImage:[UIImage imageNamed:@"框选中425"] forState:0];
            
//            NSArray *array = [model.amounts componentsSeparatedByString:@"-"];
//            ChangeLabel1.text = [NSString stringWithFormat:@"%@",array[0]];
//            
//            self.Max = [NSString stringWithFormat:@"%@",array[1]];
//            self.Min = [NSString stringWithFormat:@"%@",array[0]];
            
            NSLog(@"====self.ChangeString===%@",self.ChangeString);
            
            self.Commitpervalue = model.pervalue;
            self.Commitcardid = model.cardid;
            self.Commitcardname = model.cardname;
            self.recharge_type = model.recharge_type;
            
            if ([self.ChangeString isEqualToString:@"777"]) {
                
                for (BianMinModel *right in _Right) {
                    
                    if ([self.Commitpervalue isEqualToString:right.pervalue]) {
                        
                        self.Commitcardid = right.cardid;
                        self.Commitcardname = right.cardname;
                        
                    }
                }
            }else if ([self.ChangeString isEqualToString:@"666"]){
                
                for (BianMinModel *left in _Left) {
                    
                    if ([self.Commitpervalue isEqualToString:left.pervalue]) {
                        
                        self.Commitcardid = left.cardid;
                        self.Commitcardname = left.cardname;
                        
                    }
                }
                
            }else{
                
                self.Commitpervalue = model.pervalue;
                self.Commitcardid = model.cardid;
                self.Commitcardname = model.cardname;
                self.recharge_type = model.recharge_type;
                
            }
            
            price = [model.amounts componentsSeparatedByString:@","];
            
            if ([price[0] rangeOfString:@"-"].location !=NSNotFound) {
                
                NSArray *array = [price[0] componentsSeparatedByString:@"-"];
                
                ChangeLabel1.text = [NSString stringWithFormat:@"%@",array[0]];
                [reduce setImage:[UIImage imageNamed:@"减509"] forState:0];
                [add setImage:[UIImage imageNamed:@"加-(1)509"] forState:0];
                self.Max = [NSString stringWithFormat:@"%@",array[1]];
                self.Min = [NSString stringWithFormat:@"%@",array[0]];
                
            }else{
                
                ChangeLabel1.text = [NSString stringWithFormat:@"%@",price[0]];
                [reduce setImage:[UIImage imageNamed:@"减509"] forState:0];
                [add setImage:[UIImage imageNamed:@"加-(1)509"] forState:0];
            }
        }
        
    }
    
}


-(void)PayBtnCLick
{
    [self.view endEditing:YES];
    
    NSLog(@"支付");
    
    if (CountTF.text.length==0) {
        
        [JRToast showWithText:@"请输入游戏账号" duration:1.0f];
        
    }else{
        
        if ([self.isnull isEqualToString:@"1"]) {
            
            if (ServiceLabel.text.length==0) {
                
                [JRToast showWithText:@"请选择游戏区服" duration:1.0f];
                
            }else{
                
                if ([self.is_traffic_permit isEqualToString:@"1"]) {
                    
                    if (PassTF.text.length==0) {
                        
                        [JRToast showWithText:@"请输入战网通行证" duration:1.0f];
                        
                    }else{
                        
                        if (self.sigen.length==0) {
                            
                            self.Commitprice = [NSString stringWithFormat:@"%d",[self.Commitpervalue intValue] * [ChangeLabel1.text intValue]];
                            
                            if ([self.is_traffic_permit isEqualToString:@"0"]) {
                                
                                self.Commitis_traffic_permit = @"";
                                
                            }else{
                                
                                self.Commitis_traffic_permit = PassTF.text;
                                
                            }
                            
                            ATHLoginViewController *vc=[[ATHLoginViewController alloc] init];
                            vc.delegate=self;
                            vc.backString=@"426";
                            vc.BianMinType = @"2";
                            vc.BianMinPhone =@"";
                            vc.BianMinPrice = self.Commitprice;
                            vc.TitleString=@"300";
                            vc.BianMinFlow_size = @"";
                            vc.BianMinFlow_id = @"";
                            vc.Commitid = self.Commitid;
                            vc.Commitcardid = self.Commitcardid;
                            vc.Commitcardnum = ChangeLabel1.text;
                            vc.Commitgame_userid = CountTF.text;
                            vc.Commitcardname = self.Commitcardname;
                            vc.Commitgame_area = self.Commitgame_area;
                            vc.Commitis_traffic_permit = self.Commitis_traffic_permit;
                            vc.Commitgame_srv = self.Commitgame_srv;
                            
                            
                            [self.navigationController pushViewController:vc animated:NO];
                            
                            self.navigationController.navigationBar.hidden=YES;
                            
                        }else{
                            
                            if (self.sigen.length==0) {
                                
                                self.Commitprice = [NSString stringWithFormat:@"%d",[self.Commitpervalue intValue] * [ChangeLabel1.text intValue]];
                                
                                if ([self.is_traffic_permit isEqualToString:@"0"]) {
                                    
                                    self.Commitis_traffic_permit = @"";
                                    
                                }else{
                                    
                                    self.Commitis_traffic_permit = PassTF.text;
                                    
                                }
                                
                                ATHLoginViewController *vc=[[ATHLoginViewController alloc] init];
                                vc.delegate=self;
                                vc.backString=@"426";
                                vc.BianMinType = @"2";
                                vc.BianMinPhone =@"";
                                vc.BianMinPrice = self.Commitprice;
                                vc.TitleString=@"300";
                                vc.BianMinFlow_size = @"";
                                vc.BianMinFlow_id = @"";
                                vc.Commitid = self.Commitid;
                                vc.Commitcardid = self.Commitcardid;
                                vc.Commitcardnum = ChangeLabel1.text;
                                vc.Commitgame_userid = CountTF.text;
                                vc.Commitcardname = self.Commitcardname;
                                vc.Commitgame_area = self.Commitgame_area;
                                vc.Commitis_traffic_permit = self.Commitis_traffic_permit;
                                vc.Commitgame_srv = self.Commitgame_srv;
                                
                                
                                [self.navigationController pushViewController:vc animated:NO];
                                
                                self.navigationController.navigationBar.hidden=YES;
                                
                            }else{
                                
                                [self submitMoneyPay];
                                
                            }
                            
                        }
                    }
                    
                }else{
                    
                    if (self.sigen.length==0) {
                        
                        self.Commitprice = [NSString stringWithFormat:@"%d",[self.Commitpervalue intValue] * [ChangeLabel1.text intValue]];
                        
                        if ([self.is_traffic_permit isEqualToString:@"0"]) {
                            
                            self.Commitis_traffic_permit = @"";
                            
                        }else{
                            
                            self.Commitis_traffic_permit = PassTF.text;
                            
                        }
                        
                        ATHLoginViewController *vc=[[ATHLoginViewController alloc] init];
                        vc.delegate=self;
                        vc.backString=@"426";
                        vc.BianMinType = @"2";
                        vc.BianMinPhone =@"";
                        vc.BianMinPrice = self.Commitprice;
                        vc.TitleString=@"300";
                        vc.BianMinFlow_size = @"";
                        vc.BianMinFlow_id = @"";
                        vc.Commitid = self.Commitid;
                        vc.Commitcardid = self.Commitcardid;
                        vc.Commitcardnum = ChangeLabel1.text;
                        vc.Commitgame_userid = CountTF.text;
                        vc.Commitcardname = self.Commitcardname;
                        vc.Commitgame_area = self.Commitgame_area;
                        vc.Commitis_traffic_permit = self.Commitis_traffic_permit;
                        vc.Commitgame_srv = self.Commitgame_srv;
                        
                        
                        [self.navigationController pushViewController:vc animated:NO];
                        
                        self.navigationController.navigationBar.hidden=YES;
                        
                    }else{
                        
                        if (self.sigen.length==0) {
                            
                            self.Commitprice = [NSString stringWithFormat:@"%d",[self.Commitpervalue intValue] * [ChangeLabel1.text intValue]];
                            
                            if ([self.is_traffic_permit isEqualToString:@"0"]) {
                                
                                self.Commitis_traffic_permit = @"";
                                
                            }else{
                                
                                self.Commitis_traffic_permit = PassTF.text;
                                
                            }
                            
                            ATHLoginViewController *vc=[[ATHLoginViewController alloc] init];
                            vc.delegate=self;
                            vc.backString=@"426";
                            vc.BianMinType = @"2";
                            vc.BianMinPhone =@"";
                            vc.BianMinPrice = self.Commitprice;
                            vc.TitleString=@"300";
                            vc.BianMinFlow_size = @"";
                            vc.BianMinFlow_id = @"";
                            vc.Commitid = self.Commitid;
                            vc.Commitcardid = self.Commitcardid;
                            vc.Commitcardnum = ChangeLabel1.text;
                            vc.Commitgame_userid = CountTF.text;
                            vc.Commitcardname = self.Commitcardname;
                            vc.Commitgame_area = self.Commitgame_area;
                            vc.Commitis_traffic_permit = self.Commitis_traffic_permit;
                            vc.Commitgame_srv = self.Commitgame_srv;
                            
                            
                            [self.navigationController pushViewController:vc animated:NO];
                            
                            self.navigationController.navigationBar.hidden=YES;
                            
                        }else{
                            
                            [self submitMoneyPay];
                            
                        }
                        
                    }
                }
            }
            
        }else{
            
            if ([self.is_traffic_permit isEqualToString:@"1"]) {
                
                if (PassTF.text.length==0) {
                    
                    [JRToast showWithText:@"请输入战网通行证" duration:1.0f];
                    
                }else{
                    
                    if (self.sigen.length==0) {
                        
                        self.Commitprice = [NSString stringWithFormat:@"%d",[self.Commitpervalue intValue] * [ChangeLabel1.text intValue]];
                        
                        if ([self.is_traffic_permit isEqualToString:@"0"]) {
                            
                            self.Commitis_traffic_permit = @"";
                            
                        }else{
                            
                            self.Commitis_traffic_permit = PassTF.text;
                            
                        }
                        
                        ATHLoginViewController *vc=[[ATHLoginViewController alloc] init];
                        vc.delegate=self;
                        vc.backString=@"426";
                        vc.BianMinType = @"2";
                        vc.BianMinPhone =@"";
                        vc.BianMinPrice = self.Commitprice;
                        vc.TitleString=@"300";
                        vc.BianMinFlow_size = @"";
                        vc.BianMinFlow_id = @"";
                        vc.Commitid = self.Commitid;
                        vc.Commitcardid = self.Commitcardid;
                        vc.Commitcardnum = ChangeLabel1.text;
                        vc.Commitgame_userid = CountTF.text;
                        vc.Commitcardname = self.Commitcardname;
                        vc.Commitgame_area = self.Commitgame_area;
                        vc.Commitis_traffic_permit = self.Commitis_traffic_permit;
                        vc.Commitgame_srv = self.Commitgame_srv;
                        
                        
                        [self.navigationController pushViewController:vc animated:NO];
                        
                        self.navigationController.navigationBar.hidden=YES;
                        
                    }else{
                        
                        [self submitMoneyPay];
                        
                    }
                }
                
            }else{
                
                if (self.sigen.length==0) {
                    
                    self.Commitprice = [NSString stringWithFormat:@"%d",[self.Commitpervalue intValue] * [ChangeLabel1.text intValue]];
                    
                    if ([self.is_traffic_permit isEqualToString:@"0"]) {
                        
                        self.Commitis_traffic_permit = @"";
                        
                    }else{
                        
                        self.Commitis_traffic_permit = PassTF.text;
                        
                    }
                    
                    ATHLoginViewController *vc=[[ATHLoginViewController alloc] init];
                    vc.delegate=self;
                    vc.backString=@"426";
                    vc.BianMinType = @"2";
                    vc.BianMinPhone =@"";
                    vc.BianMinPrice = self.Commitprice;
                    vc.TitleString=@"300";
                    vc.BianMinFlow_size = @"";
                    vc.BianMinFlow_id = @"";
                    vc.Commitid = self.Commitid;
                    vc.Commitcardid = self.Commitcardid;
                    vc.Commitcardnum = ChangeLabel1.text;
                    vc.Commitgame_userid = CountTF.text;
                    vc.Commitcardname = self.Commitcardname;
                    vc.Commitgame_area = self.Commitgame_area;
                    vc.Commitis_traffic_permit = self.Commitis_traffic_permit;
                    vc.Commitgame_srv = self.Commitgame_srv;
                    
                    
                    [self.navigationController pushViewController:vc animated:NO];
                    
                    self.navigationController.navigationBar.hidden=YES;
                    
                }else{
                    
                    [self submitMoneyPay];
                    
                }
            }
        }
    }
}

-(void)ServiceButtonClick
{
    [self.view endEditing:YES];
    
    SelectServiceViewController *vc =[[SelectServiceViewController alloc] init];
    vc.delegate=self;
    vc.cardid = self.seveiceid;
    
    [self.navigationController pushViewController:vc animated:NO];
    
}
-(void)SelectService:(NSString *)SERVER AREA:(NSString *)AREA Name:(NSString *)qufuName
{
    
    
    
//    NSArray *array = [SERVER componentsSeparatedByString:@"w"];
    
    
    ServiceLabel.text = [NSString stringWithFormat:@"%@",qufuName];
    
    
    NSLog(@"===select==%@==%@===ServiceLabel.text==%@",SERVER,AREA,ServiceLabel.text);
    
    self.Commitgame_area = AREA;
    
    self.Commitgame_srv = SERVER;
    
}
-(void)QurtBtnClick
{
    [self.view endEditing:YES];
    
     self.navigationController.navigationBar.hidden=YES;
    
    [self.navigationController popViewControllerAnimated:NO];
    
   
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    
    if (textField.tag==100) {
        
        
        
        
    }else{
        
        
    }
    
}


-(void)submitMoneyPay
{
    
    WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
    
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        
    });
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@submitMoneyPay_mob.shtml",URL_Str];
    //saveUserExchange_mob.shtml
    
    
    self.Commitprice = [NSString stringWithFormat:@"%d",[self.Commitpervalue intValue] * [ChangeLabel1.text intValue]];
    
    if ([self.is_traffic_permit isEqualToString:@"0"]) {
        
        self.Commitis_traffic_permit = @"";
        
    }else{
        
        self.Commitis_traffic_permit = PassTF.text;
        
    }
    
    if ([self.isnull isEqualToString:@"0"]) {
        
        self.Commitgame_area = @"";
        self.Commitgame_srv = @"";
        
    }
    
    NSLog(@"====self.sigen====%@",self.sigen);
    NSLog(@"====self.Commitprice====%@",self.Commitprice);
    NSLog(@"====self.Commitid====%@",self.Commitid);
    NSLog(@"====self.Commitcardid====%@",self.Commitcardid);
    NSLog(@"====ChangeLabel1.text====%@",ChangeLabel1.text);
    NSLog(@"====CountTF.text====%@",CountTF.text);
    NSLog(@"====self.cardname====%@",self.Commitcardname);
    NSLog(@"====self.Commitgame_area====%@",self.Commitgame_area);
    NSLog(@"====self.Commitgame_srv====%@",self.Commitgame_srv);
    NSLog(@"====self.Commitis_traffic_permit====%@",self.Commitis_traffic_permit);
    
    NSDictionary *dic = @{@"sigen":self.sigen,@"type":@"2",@"clientId":@"3",@"price":self.Commitprice,@"id":self.Commitid,@"cardid":self.Commitcardid,@"cardnum":ChangeLabel1.text,@"game_userid":CountTF.text,@"cardname":self.Commitcardname,@"game_area":self.Commitgame_area,@"game_srv":self.Commitgame_srv,@"is_traffic_permit":self.Commitis_traffic_permit};
    
    
    [manager POST:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
        NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];
        
        
        if (codeKey && content) {
            NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
            
            //            NSLog(@"xmlStr%@",xmlStr);
            
            
            NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            NSLog(@"分类查看更多书局=%@",dic);
            
            view.hidden=YES;
            
            if ([dic[@"status"] isEqualToString:@"10000"]) {
                
                PhoneAndFlowPayViewController *vc=[[PhoneAndFlowPayViewController alloc] init];
                
                vc.Sigen=self.sigen;
                vc.integral = [NSString stringWithFormat:@"%@",dic[@"integral"]];
                vc.orderno = [NSString stringWithFormat:@"%@",dic[@"orderno"]];
                vc.pay_integral = [NSString stringWithFormat:@"%@",dic[@"pay_integral"]];
                vc.pay_money = [NSString stringWithFormat:@"%@",dic[@"pay_money"]];
                vc.price = [NSString stringWithFormat:@"%@",dic[@"price"]];
                vc.type = [NSString stringWithFormat:@"%@",dic[@"type"]];
                vc.sta = [NSString stringWithFormat:@"%@",dic[@"sta"]];
                vc.Phone =@"";
                vc.title = @"游戏点卡";
                vc.proportion = [NSString stringWithFormat:@"%@",dic[@"proportion"]];
                self.navigationController.navigationBar.hidden=YES;
                
                [self.navigationController pushViewController:vc animated:NO];
                
                
            }else{
                
                
                [JRToast showWithText:dic[@"message"] duration:1.0f];
                
            }
            
            
            [hud dismiss:YES];
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [hud dismiss:YES];
        [self NoWebSeveice];
        
        NSLog(@"%@",error);
    }];
    
}

@end
