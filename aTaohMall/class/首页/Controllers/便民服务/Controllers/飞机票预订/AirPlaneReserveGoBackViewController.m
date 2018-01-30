//
//  AirPlaneReserveGoBackViewController.m
//  aTaohMall
//
//  Created by JMSHT on 2017/5/23.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "AirPlaneReserveGoBackViewController.h"

#import "AirGoBackDetailView.h"
#import "TuiKuanShuoMingView.h"

#import "RecordAirManger.h"

#import "AirOneDetailView.h"
#import "TuiKuanShuoMingView.h"
#import "AirPlaneAddManView.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

#import <ContactsUI/ContactsUI.h>

#import "AirOrderRefundViewController.h"

#import "PublicAnnouncementViewController.h"
#import "AttentionViewController.h"
#import "ProhibitViewController.h"
#import "AFNetworking.h"
#import "ZZLimitInputManager.h"
#import "ConverUtil.h"
#import "DESUtil.h"
#import "SecretCodeTool.h"
#import "AirSelectView.h"

#import "WKProgressHUD.h"

#import "BianMinModel.h"
#import "AirPiaoHaoView.h"
#import "JRToast.h"
#import "AirBaoXianView.h"

#import "AirOneMingXiView.h"
#import "AirGoBackMingXiView.h"
#import "TrainToast.h"

#import "Order.h"
#import "APAuthV2Info.h"
#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>

#import "PersonalAllDanVC.h"
#import "AirPlaneDetailViewController.h"
#import "TuiKuanGoBackView.h"
#define kAlphaNum @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
#define  TopTipsHeight ([self.ManOrKidString isEqualToString:@"1"]?45:70)
@interface AirPlaneReserveGoBackViewController ()<UITextViewDelegate,CNContactPickerDelegate,AirPlaneAddManDelegate,UIAlertViewDelegate,AirGoBackMingXiDelegate,UITextFieldDelegate>
{
    
    UIScrollView *_scrollView;
    UITextView *_textView;
    
    NSMutableArray *_GoArrM;
    NSMutableArray *_BackArrM;
    NSMutableArray *_ManArrM;
    NSArray *SelectArrM;
    
    AirGoBackDetailView *_oneView;
    TuiKuanShuoMingView *_customShareView;
    AirPiaoHaoView *_piaoView;
    AirPlaneAddManView *_addView;
    UIButton *InterTipsBut;
    TuiKuanGoBackView *_GoGoView;
    
    UITextField *PhoneLabel;
    
    NSMutableArray *_data;
    UILabel *InterLabel;
    UILabel *UseLabel;
    
    AirBaoXianView *_baoView;
    AirGoBackMingXiView *_mingxiView;
    
    NSArray *ManArray;
    NSArray *OldManArray;
    
    UIView *PhoneView;
    UIView *BaoXianView;
    UIView *InterView;
    UIView *XieYiView;
    UIView *nameView;
    
    UITextField *NameTF;
    
    int index;
    UIImageView *UpimgView;
    UIButton *UpButton;
    UILabel *PriceLabel;
    
    UISwitch *BaoXianSwitch;
    UISwitch *InterSwitch;
    
    UIView *ManPaioHaoView;
    UILabel *ManPaioHaoLabel;
    UITextField *ManPaioHaoTF;
    
    UIView *ManPaioHaoBackView;
    UILabel *ManPaioHaoBackLabel;
    UITextField *ManPaioHaoBackTF;
    
    int Height;
    
    UIWebView *webView;
    UIView *loadView;
    UIButton *tipsBut;
    
}
@property (assign, nonatomic) BOOL isSelect;
@property (nonatomic, strong) UISwipeGestureRecognizer *rightSwipeGestureRecognizer;
@end

@implementation AirPlaneReserveGoBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _data = [NSMutableArray new];
    
    
    _GoArrM = [NSMutableArray new];
    _BackArrM = [NSMutableArray new];
    _ManArrM = [NSMutableArray new];
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数组NSArray类型的数据
    self.sigen=[userDefaultes stringForKey:@"sigen"];
    
    if ([self.ManOrKidString isEqualToString:@"1"]) {
        
        Height = 0;
        
    }else if ([self.ManOrKidString isEqualToString:@"2"]){
        
        Height = 1;
        
    }
    
//    NSLog(@"=======%@",[userDefaultes stringForKey:@"goDate"]);
//    NSLog(@"=======%@",[userDefaultes stringForKey:@"goWeek"]);
//    NSLog(@"=======%@",[userDefaultes stringForKey:@"goTime"]);
//    NSLog(@"=======%@",[userDefaultes stringForKey:@"goPrice"]);
//    NSLog(@"=======%@",[userDefaultes stringForKey:@"goJiJian"]);
//    NSLog(@"=======%@",[userDefaultes stringForKey:@"goCity"]);
//    NSLog(@"=======%@",[userDefaultes stringForKey:@"endCity"]);
//    NSLog(@"=======%@",[userDefaultes stringForKey:@"flightNo"]);
    
    [self initNav];
    
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-KSafeAreaTopNaviHeight-49-KSafeAreaBottomHeight)];
    _scrollView.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1.0];
    _scrollView.showsVerticalScrollIndicator = NO;
  //  _scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height+400);
    [self.view addSubview:_scrollView];
    
    self.rightSwipeGestureRecognizer=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipes:)];
    
    [self.view addGestureRecognizer:self.rightSwipeGestureRecognizer];
    
    [self initTopTipsView];
    
    [self initTopView];
    
    [self initManView];
    
    [self initPhoneView];
    
    [self initBaoXianView];
    
    [self initInterView];
    
    [self initXieYiView];
    
    [self initBoomView];
    
    [self getInterDatas];
    
    _oneView = [[AirGoBackDetailView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:_oneView];
    
    _customShareView = [[TuiKuanShuoMingView alloc]init];
    [self.view addSubview:_customShareView];
    
    _addView = [[AirPlaneAddManView alloc]init];
    [self.view addSubview:_addView];
    
    _baoView = [[AirBaoXianView alloc] init];
    [self.view addSubview:_baoView];
    
    _mingxiView = [[AirGoBackMingXiView alloc] init];
    [self.view addSubview:_mingxiView];
    
    _piaoView = [[AirPiaoHaoView alloc] init];
    [self.view addSubview:_piaoView];
    
    _GoGoView = [[TuiKuanGoBackView alloc] init];
    [self.view addSubview:_GoGoView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resultStatus:) name:@"resultStatus" object:nil];
    
}
/*****
 *
 *  Description 右滑返回上级页面
 *
 ******/
- (void)handleSwipes:(UISwipeGestureRecognizer *)sender
{
    if (sender.direction == UISwipeGestureRecognizerDirectionLeft) {
        
    }
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        
        NSLog(@"右滑");
        [self.navigationController popViewControllerAnimated:YES];
    }
}
-(void)getInterDatas
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
   
    [self.view removeGestureRecognizer:self.rightSwipeGestureRecognizer];
    
    loadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    loadView.backgroundColor = [UIColor blackColor];
    
    loadView.alpha = 0.2;
    
    [self.view addSubview:loadView];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@getCasualtyAndIntegral_mob.shtml",URL_Str];
    //saveUserExchange_mob.shtml
    
    
    NSLog(@"===sigen===%@",self.sigen);
    NSLog(@"===ManOrKidString===%@",self.ManOrKidString);
    
    NSDictionary *dict = @{@"sigen":self.sigen,@"passenger_type":self.ManOrKidString,@"wf_type":@"0"};
    
    [manager POST:url parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
        NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];
        
        
        if (codeKey && content) {
            NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
            
            NSLog(@"xmlStr=价格=%@",xmlStr);
            
            
            NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            if ([dic[@"status"] isEqualToString:@"10000"]) {
                
                PhoneLabel.text = [NSString stringWithFormat:@"%@",dic[@"phone"]];
                InterLabel.text = [NSString stringWithFormat:@"(你有%@积分，最多可使用0.00积分)",dic[@"integral"]];
                
                self.proportion = [NSString stringWithFormat:@"%@",dic[@"proportion"]];
                self.integral = [NSString stringWithFormat:@"%@",dic[@"integral"]];
                self.sale = [NSString stringWithFormat:@"%@",dic[@"sale"]];
                self.Remark = [NSString stringWithFormat:@"%@",dic[@"remark"]];
                self.order_id = [NSString stringWithFormat:@"%@",dic[@"order_id0"]];
                self.order_id1 = [NSString stringWithFormat:@"%@",dic[@"order_id1"]];
                
                ManPaioHaoTF.text = self.order_id;
                ManPaioHaoBackTF.text = self.order_id1;
                [self initPasserView];
            }else{
                
                [JRToast showWithText:dic[@"message"] duration:2.0f];
                
                
            }
            
            
//            [hud dismiss:YES];
            
            [webView removeFromSuperview];
            [loadView removeFromSuperview];
           
            [self.view addGestureRecognizer:self.rightSwipeGestureRecognizer];
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        NSLog(@"%@",error);
//        [hud dismiss:YES];
        
        [webView removeFromSuperview];
        [loadView removeFromSuperview];
        
        [self.view addGestureRecognizer:self.rightSwipeGestureRecognizer];
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
    
    UIButton *Qurt = [UIButton buttonWithType:UIButtonTypeCustom];
    
    Qurt.frame = CGRectMake(10, 25+KSafeTopHeight, 30, 30);
    
    //    [Qurt setBackgroundImage:[UIImage imageNamed:@"iconfont-fanhui2yt"] forState:0];
    
    [Qurt setImage:[UIImage imageNamed:@"iconfont-fanhui2yt"] forState:0];
    
    
    [Qurt addTarget:self action:@selector(QurtBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [titleView addSubview:Qurt];
    
    //创建搜索
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 25+KSafeTopHeight, [UIScreen mainScreen].bounds.size.width-200, 30)];
    
    label.text = @"机票预定";
    
    label.textColor = [UIColor blackColor];
    
    label.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:19];
    
    label.textAlignment = NSTextAlignmentCenter;
    
    [titleView addSubview:label];
    
    
}
-(void)initTopTipsView
{
    if ([self.ManOrKidString isEqualToString:@"1"]) {
        UIView *tipsView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 45)];
        tipsView.backgroundColor=RGB(63, 139, 253);
        UIImageView *IV=[[UIImageView alloc]initWithFrame:CGRectMake(15, 8, 13, 13)];
        IV.image=[UIImage imageNamed:@"icon_hint"];
        [tipsView addSubview:IV];
        UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMake(33, 6,kScreen_Width-48, 34)];
        lab.font=KNSFONT(12);
        lab.textColor=RGB(255, 255, 255);
        lab.numberOfLines=0;
        lab.text=@"所售机票暂时无法提供改签服务，若急需改签请致电联系相应航空公司。最终解释权归本公司所有。";
        [tipsView addSubview:lab];
        [_scrollView addSubview:tipsView];
        
    }else
    {
        
        UIView *tipsView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 70)];
        tipsView.backgroundColor=RGB(63, 139, 253);
        UIImageView *IV=[[UIImageView alloc]initWithFrame:CGRectMake(15, 8, 13, 13)];
        IV.image=[UIImage imageNamed:@"icon_hint"];
        [tipsView addSubview:IV];
        UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMake(33, 9,kScreen_Width-48, 12)];
        lab.font=KNSFONT(12);
        lab.textColor=RGB(255, 255, 255);
        lab.text=@"儿童乘机人若无有效身份证件建议携带上户口薄原件";
        [tipsView addSubview:lab];
        
        UIImageView *IV2=[[UIImageView alloc]initWithFrame:CGRectMake(15, 30, 13, 13)];
        IV2.image=[UIImage imageNamed:@"icon_hint"];
        [tipsView addSubview:IV2];
        UILabel * lab2 = [[UILabel alloc]initWithFrame:CGRectMake(33, 28,kScreen_Width-48, 34)];
        lab2.font=KNSFONT(12);
        lab2.textColor=RGB(255, 255, 255);
        lab2.numberOfLines=0;
        lab2.text=@"所售机票暂时无法提供改签服务，若急需改签请致电联系相应航空公司。最终解释权归本公司所有。";
        [tipsView addSubview:lab2];
        [_scrollView addSubview:tipsView];
        
    }
    
    
}
-(void)initTopView
{
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
//    
//    NSLog(@"=======%@",[userDefaultes stringForKey:@"goDate"]);
//    NSLog(@"=======%@",[userDefaultes stringForKey:@"goWeek"]);
//    NSLog(@"=======%@",[userDefaultes stringForKey:@"goTime"]);
//    NSLog(@"=======%@",[userDefaultes stringForKey:@"goPrice"]);
//    NSLog(@"=======%@",[userDefaultes stringForKey:@"goJiJian"]);
//    NSLog(@"=======%@",[userDefaultes stringForKey:@"goCity"]);
//    NSLog(@"=======%@",[userDefaultes stringForKey:@"endCity"]);
    
    UIView *TopView = [[UIView alloc] initWithFrame:CGRectMake(0, TopTipsHeight+ 0, [UIScreen mainScreen].bounds.size.width, 101)];
    TopView.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:TopView];
    
    UIImageView *GoImgView = [[UIImageView alloc] initWithFrame:CGRectMake(14, 10, 20, 20)];
    GoImgView.image = [UIImage imageNamed:@"icon-qu"];
    [TopView addSubview:GoImgView];
    
    NSString *GoString = [NSString stringWithFormat:@"%@",[userDefaultes stringForKey:@"goDate"]];
    NSArray *goArray = [GoString componentsSeparatedByString:@"-"];
    
    NSString *starttime = [NSString stringWithFormat:@"%@",[userDefaultes stringForKey:@"goTime"]];
    NSArray *date = [starttime componentsSeparatedByString:@" "];
    NSArray *timearray = [date[1] componentsSeparatedByString:@":"];
    
    UILabel *Toplabel = [[UILabel alloc] initWithFrame:CGRectMake(39, 12, 200, 17)];
    Toplabel.text = [NSString stringWithFormat:@"%@-%@ %@ %@",goArray[1],goArray[2],[userDefaultes stringForKey:@"goWeek"],[NSString stringWithFormat:@"%@:%@",timearray[0],timearray[1]]];
    Toplabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    Toplabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:18];
    Toplabel.textAlignment = NSTextAlignmentLeft;
    [TopView addSubview:Toplabel];
    
    UILabel *Namelabel = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-30-200, 14, 200, 13)];
    Namelabel.text = [NSString stringWithFormat:@"%@",[userDefaultes stringForKey:@"goCity"]];
    Namelabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    Namelabel.font = [UIFont fontWithName:@"PingFangSC-Light" size:14];
    Namelabel.textAlignment = NSTextAlignmentRight;
    [TopView addSubview:Namelabel];
    
    UIImageView *BackImgView = [[UIImageView alloc] initWithFrame:CGRectMake(14, 40, 20, 20)];
    BackImgView.image = [UIImage imageNamed:@"icon-fan-hui"];
    [TopView addSubview:BackImgView];
    
    
    NSArray *string1 =[self.time componentsSeparatedByString:@"-"];
    
    
    NSArray *backdate = [self.Air_OffTime componentsSeparatedByString:@" "];
    NSArray *backarray = [backdate[1] componentsSeparatedByString:@":"];
    
    UILabel *Backlabel = [[UILabel alloc] initWithFrame:CGRectMake(39, 42, 200, 17)];
    Backlabel.text = [NSString stringWithFormat:@"%@-%@ %@ %@",string1[1],string1[2],self.DateWeek,[NSString stringWithFormat:@"%@:%@",backarray[0],backarray[1]]];
    Backlabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    Backlabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:18];
    Backlabel.textAlignment = NSTextAlignmentLeft;
    [TopView addSubview:Backlabel];
    
    NSArray *BackCity = [self.GoBackString componentsSeparatedByString:@"-"];
    
    UILabel *BackNamelabel = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-30-200, 44, 200, 13)];
    BackNamelabel.text = [NSString stringWithFormat:@"%@-%@",BackCity[0],BackCity[1]];
    BackNamelabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    BackNamelabel.font = [UIFont fontWithName:@"PingFangSC-Light" size:14];
    BackNamelabel.textAlignment = NSTextAlignmentRight;
    [TopView addSubview:BackNamelabel];
    
    
    UIButton *GoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    GoButton.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 70);
    [GoButton addTarget:self action:@selector(GoBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [TopView addSubview:GoButton];
    
    
    UIImageView *online = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-20, (70-14)/2, 8, 14)];
    online.image = [UIImage imageNamed:@"icon_more"];
    [TopView addSubview:online];
    
    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(15, 70, [UIScreen mainScreen].bounds.size.width-30, 0.5)];
    line.image = [UIImage imageNamed:@"xuxian"];
    [TopView addSubview:line];
    
    //第一次缓存票价
    NSString *onePrice = [NSString stringWithFormat:@"%@",[userDefaultes stringForKey:@"goPrice"]];
     NSString *jijianString = [NSString stringWithFormat:@"机建+燃油:¥%.02f",[self.RanYou floatValue] + [[userDefaultes stringForKey:@"goJiJian"] floatValue]];
    NSString *string = [NSString stringWithFormat:@"票价:¥%.02f %@",[self.Price floatValue] + [onePrice floatValue],jijianString];

    //价格
    self.Money = [NSString stringWithFormat:@"%.02f",[self.Price floatValue] + [onePrice floatValue] + [self.RanYou floatValue] + [[userDefaultes stringForKey:@"goJiJian"] floatValue]];
                  
    CGRect tempRect = [string boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width,13) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Light" size:14]} context:nil];
    CGFloat width=tempRect.size.width;
    UILabel *PaioJialabel = [[UILabel alloc] initWithFrame:CGRectMake(15, (30-13)/2+71, kScreenWidth-15-100, 13)];
    PaioJialabel.text = string;
    PaioJialabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    PaioJialabel.font = [UIFont fontWithName:@"PingFangSC-Light" size:14];
    PaioJialabel.textAlignment = NSTextAlignmentLeft;
    if (width>kScreenWidth-15-100) {
        PaioJialabel.font = [UIFont fontWithName:@"PingFangSC-Light" size:12];
    }
    [TopView addSubview:PaioJialabel];
    
    NSString *stringForColor3 = [NSString stringWithFormat:@"¥%.02f",[self.Price floatValue] + [onePrice floatValue]];
    // 创建对象.
    NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:PaioJialabel.text];
    //
    NSRange range3 = [PaioJialabel.text rangeOfString:stringForColor3];
    [mAttStri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0] range:range3];
    PaioJialabel.attributedText=mAttStri;
    
    //机建：第一次缓存加第二次
//    NSString *jijianString = [NSString stringWithFormat:@"机建+燃油:¥%.02f",[self.RanYou floatValue] + [[userDefaultes stringForKey:@"goJiJian"] floatValue]];
//
//    UILabel *JiJianlabel = [[UILabel alloc] initWithFrame:CGRectMake(15+tempRect.size.width+15, (30-13)/2+71, 200, 13)];
//    JiJianlabel.text = jijianString;
//    JiJianlabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
//    JiJianlabel.font = [UIFont fontWithName:@"PingFangSC-Light" size:14];
//    [TopView addSubview:JiJianlabel];

//    NSString *string = [NSString stringWithFormat:@"票价:￥%.02f %@",[self.Price floatValue], self.OilString];
//
//    CGRect tempRect = [string boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width,13) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Light" size:14]} context:nil];
//
//    CGFloat width=tempRect.size.width;
//
//
//    UILabel *PaioJialabel = [[UILabel alloc] initWithFrame:CGRectMake(15, (35-13)/2+36,kScreenWidth-15-100, 13)];
//    PaioJialabel.text = string;
//    PaioJialabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
//    PaioJialabel.font = [UIFont fontWithName:@"PingFangSC-Light" size:14];
//    if (width>kScreenWidth-15-100) {
//        PaioJialabel.font = [UIFont fontWithName:@"PingFangSC-Light" size:12];
//    }
//    PaioJialabel.textAlignment = NSTextAlignmentLeft;
//    [TopView addSubview:PaioJialabel];
//
//    NSString *stringForColor3 = [NSString stringWithFormat:@"￥%.02f",[self.Price floatValue]];
//    // 创建对象.
//    NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:PaioJialabel.text];
//    //
//    NSRange range3 = [PaioJialabel.text rangeOfString:stringForColor3];
//    [mAttStri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0] range:range3];
//    PaioJialabel.attributedText=mAttStri;

    //    UILabel *JiJianlabel = [[UILabel alloc] initWithFrame:CGRectMake(15+tempRect.size.width+15, (35-13)/2+36, 200, 13)];
    //    JiJianlabel.text = self.OilString;
    //    JiJianlabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    //    JiJianlabel.font = [UIFont fontWithName:@"PingFangSC-Light" size:14];
    //    [TopView addSubview:JiJianlabel];





    UILabel *Tuilabel = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-30-205, (30-13)/2+71, 200, 13)];
    Tuilabel.text = @"退票说明";
    Tuilabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    Tuilabel.font = [UIFont fontWithName:@"PingFangSC-Light" size:14];
    Tuilabel.textAlignment = NSTextAlignmentRight;
    [TopView addSubview:Tuilabel];
    
    UIButton *timeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    timeButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-30, (30-14)/2+71, 14, 14);
    [timeButton setImage:[UIImage imageNamed:@"icon_tip-red"] forState:0];
    [timeButton addTarget:self action:@selector(TimeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [TopView addSubview:timeButton];
    
    UIImageView *line1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 1)];
    line1.image = [UIImage imageNamed:@"分割线-拷贝"];
    [TopView addSubview:line1];
}

-(void)initManView
{
    
    UIView *ManView = [[UIView alloc] initWithFrame:CGRectMake(0, TopTipsHeight+101+10, [UIScreen mainScreen].bounds.size.width, 50)];
    ManView.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:ManView];
    
    
    UILabel *ManLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, (50-13)/2, 100, 13)];
    ManLabel.text = @"乘机人";
    ManLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    ManLabel.font = [UIFont fontWithName:@"PingFangSC-Light" size:14];
    [ManView addSubview:ManLabel];
    
    
    UIButton *ManButton = [UIButton buttonWithType:UIButtonTypeCustom];
    ManButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-91, (50-25)/2, 71, 25);
    [ManButton setTitle:@"选择乘机人" forState:0];
    ManButton.backgroundColor = [UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
    [ManButton setTitleColor:[UIColor whiteColor] forState:0];
    ManButton.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Light" size:12];
    ManButton.layer.cornerRadius = 3;
    ManButton.layer.masksToBounds = YES;
    [ManButton addTarget:self action:@selector(ManBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [ManView addSubview:ManButton];
    
    UIImageView *line1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 49, [UIScreen mainScreen].bounds.size.width, 1)];
    line1.image = [UIImage imageNamed:@"分割线-拷贝"];
    [ManView addSubview:line1];
    
    
}


//添加人代理
-(void)AirPlaneAddMan:(NSArray *)man
{
    
    ManArray = man;
    
    SelectArrM = man;
    
    NSLog(@"===ManArray===%@",ManArray);
    
    [self initPasserView];
    
}

-(void)CanClePerson:(NSArray *)man
{
    SelectArrM = man;
    
    NSLog(@"==222=ManArray===%@",SelectArrM);
    
    for (int i = 0; i < SelectArrM.count; i++) {
        
        BianMinModel *model = SelectArrM[i];
        
        model.ManSelectString = @"1";
        
    }
    
}

//创建乘车人视图
-(void)initPasserView
{
    
    //移除就试图
    if (OldManArray.count > 0) {
        
        for (int i = 0; i < OldManArray.count; i++) {
            
            UIView *view = (UIView *)[self.view viewWithTag:1100+i];
            [view removeFromSuperview];
            
            UILabel *price = (UILabel *)[self.view viewWithTag:1200+i];
            [price removeFromSuperview];
            
            UILabel *Id = (UILabel *)[self.view viewWithTag:1300+i];
            [Id removeFromSuperview];
            
            UIImageView *RedImgView = (UIImageView *)[self.view viewWithTag:1400+i];
            [RedImgView removeFromSuperview];
            
            UIButton *line = (UIButton *)[self.view viewWithTag:1500+i];
            [line removeFromSuperview];
            
        }
    }
    
    
    for (int i=0; i<ManArray.count; i++) {
        
        BianMinModel *model = ManArray[i];
        
        UIView *NameView = [[UIView alloc] initWithFrame:CGRectMake(0, TopTipsHeight+101+10+50 +50*i, [UIScreen mainScreen].bounds.size.width, 50)];
        NameView.tag = 1100+i;
        NameView.backgroundColor = [UIColor whiteColor];
        [_scrollView addSubview:NameView];
        
        UILabel *NameLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 11, 200, 13)];
        NameLabel.text = model.username;
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
        
    }
    
    nameView.frame = CGRectMake(0, TopTipsHeight+101+10+50+9+50*ManArray.count, [UIScreen mainScreen].bounds.size.width, 50);
    PhoneView.frame = CGRectMake(0, TopTipsHeight+101+10+50+9+50+50*ManArray.count, [UIScreen mainScreen].bounds.size.width, 50);
    BaoXianView.frame = CGRectMake(0, TopTipsHeight+101+10+50+9+59+50+50*ManArray.count+109*Height, [UIScreen mainScreen].bounds.size.width, 50);
    InterView.frame = CGRectMake(0, TopTipsHeight+101+10+50+9+59+60+50+50*ManArray.count+109*Height, [UIScreen mainScreen].bounds.size.width, 70);
    XieYiView.frame = CGRectMake(0,TopTipsHeight+ 101+10+50+9+59+60+70+10+50+50*ManArray.count+109*Height, [UIScreen mainScreen].bounds.size.width, 40);
    _scrollView.contentSize=CGSizeMake(kScreen_Width,TopTipsHeight+ 101+10+50+9+59+60+70+10+50+50*ManArray.count+109*Height+80);
    /*--------------Hawky-8-23----------------*/
        /*---------------------------------------*/

    ManPaioHaoView.frame = CGRectMake(0, TopTipsHeight+101+10+50+9+50+59+50*ManArray.count, [UIScreen mainScreen].bounds.size.width, 50*Height);
    
    ManPaioHaoBackView.frame = CGRectMake(0,TopTipsHeight+ 101+69+50+59+50*ManArray.count+50*Height, [UIScreen mainScreen].bounds.size.width, 50*Height);
    
    if (ManArray.count==0) {
        
        PriceLabel.text = @"￥---";
        UpButton.hidden=YES;
        UpimgView.hidden=YES;
        
        UseLabel.text = [NSString stringWithFormat:@"使用 0.00 积分兑现￥0.00"];
        
        NSString *stringForColor3 = @"0.00";
        // 创建对象.
        NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:UseLabel.text];
        //
        NSRange range3 = [UseLabel.text rangeOfString:stringForColor3];
        [mAttStri addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Regular" size:10] range:range3];
        UseLabel.attributedText=mAttStri;
        
        InterLabel.text = [NSString stringWithFormat:@"(你有%@积分，最多可使用0.00积分)",self.integral];
        
        self.CanUseInter = @"";
        
//        self.Go_Price = @"0.00";
//        self.Go_Inter = @"0.00";
//        
//        self.Back_Price = @"0.00";
//        self.Back_Inter = @"0.00";
        
        
    }else{
        
        UpButton.hidden=NO;
        UpimgView.hidden=NO;
        
        //判断保险开关是否打开
        UISwitch *baoxian = (UISwitch *)[self.view viewWithTag:20000];
        
        BOOL ret1 = [baoxian isOn];
        //判断积分按钮是否打开
        UISwitch *jifen = (UISwitch *)[self.view viewWithTag:10000];
        
        BOOL ret2 = [jifen isOn];
        //判断积分抵扣多少
        
        if (ret1) {//保险开了
            
            if (ret2) {//积分开了，保险开了
                
                NSLog(@"积分开了，保险开了");
                
                //用户积分大于抵扣积分
                if ([self.integral floatValue] >= ([self.Money floatValue]*ManArray.count + [self.sale floatValue]*2*ManArray.count)*[self.proportion floatValue]) {
                    
                    PriceLabel.text = [NSString stringWithFormat:@"￥%.02f(共%d人)",[self.Money floatValue]*ManArray.count + [self.sale floatValue]*2*ManArray.count - ([self.Money floatValue]*ManArray.count + [self.sale floatValue]*2*ManArray.count)*[self.proportion floatValue],(int)ManArray.count];
                    
                    InterLabel.text = [NSString stringWithFormat:@"(你有%@积分，最多可使用%.02f积分)",self.integral,([self.Money floatValue]*ManArray.count + [self.sale floatValue]*2*ManArray.count)*[self.proportion floatValue]];
                    
                    UseLabel.text = [NSString stringWithFormat:@"使用 %.02f 积分兑现￥%.02f",([self.Money floatValue]*ManArray.count + [self.sale floatValue]*2*ManArray.count)*[self.proportion floatValue],([self.Money floatValue]*ManArray.count + [self.sale floatValue]*2*ManArray.count)*[self.proportion floatValue]];
                    
                    self.CanUseInter = [NSString stringWithFormat:@"%.02f",([self.Money floatValue]*ManArray.count + [self.sale floatValue]*2*ManArray.count)*[self.proportion floatValue]];
                    
                    self.DiKouInter = [NSString stringWithFormat:@"%.02f",([self.Money floatValue]*ManArray.count + [self.sale floatValue]*2*ManArray.count)*[self.proportion floatValue]];
                    
                    NSString *stringForColor3 = [NSString stringWithFormat:@"%.02f",([self.Money floatValue]*ManArray.count + [self.sale floatValue]*2*ManArray.count)*[self.proportion floatValue]];
                    // 创建对象.
                    NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:UseLabel.text];
                    //
                    NSRange range3 = [UseLabel.text rangeOfString:stringForColor3];
                    [mAttStri addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Regular" size:10] range:range3];
                    UseLabel.attributedText=mAttStri;
                }else{
                    
                    PriceLabel.text = [NSString stringWithFormat:@"￥%.02f(共%d人)",[self.Money floatValue]*ManArray.count + [self.sale floatValue]*2*ManArray.count - [self.integral floatValue],(int)ManArray.count];
                    
                    InterLabel.text = [NSString stringWithFormat:@"(你有%@积分，最多可使用%.02f积分)",self.integral,[self.integral floatValue]];
                    
                    UseLabel.text = [NSString stringWithFormat:@"使用 %.02f 积分兑现￥%.02f",[self.integral floatValue],[self.integral floatValue]];
                    
                    self.CanUseInter = [NSString stringWithFormat:@"%.02f",[self.integral floatValue]];
                    
                    self.DiKouInter = [NSString stringWithFormat:@"%.02f",[self.integral floatValue]];
                    
                    NSString *stringForColor3 = [NSString stringWithFormat:@"%.02f",[self.integral floatValue]];
                    // 创建对象.
                    NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:UseLabel.text];
                    //
                    NSRange range3 = [UseLabel.text rangeOfString:stringForColor3];
                    [mAttStri addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Regular" size:10] range:range3];
                    UseLabel.attributedText=mAttStri;
                }
            }else{//保险开了，积分关了
                
                NSLog(@"保险开了，积分关了");
                
                PriceLabel.text = [NSString stringWithFormat:@"￥%.02f(共%d人)",[self.Money floatValue]*ManArray.count + [self.sale floatValue]*2*ManArray.count,(int)ManArray.count];
                
                InterLabel.text = [NSString stringWithFormat:@"(你有%@积分，最多可使用0.00积分)",self.integral];
                
                UseLabel.text = [NSString stringWithFormat:@"使用 0.00 积分兑现￥0.00"];
                
                self.CanUseInter = @"0.00";
                
                self.DiKouInter = @"0.00";
                
                NSString *stringForColor3 = @"0.00";
                // 创建对象.
                NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:UseLabel.text];
                //
                NSRange range3 = [UseLabel.text rangeOfString:stringForColor3];
                [mAttStri addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Regular" size:10] range:range3];
                UseLabel.attributedText=mAttStri;
            }
            
        }else{
            
            if (ret2) {//保险关了，积分开了
                
                NSLog(@"保险关了，积分开了");
                if ([self.integral floatValue] >= ([self.Money floatValue]*ManArray.count)*[self.proportion floatValue]) {
                    
                    PriceLabel.text = [NSString stringWithFormat:@"￥%.02f(共%d人)",[self.Money floatValue]*ManArray.count - ([self.Money floatValue]*ManArray.count)*[self.proportion floatValue],(int)ManArray.count];
                    
                    InterLabel.text = [NSString stringWithFormat:@"(你有%@积分，最多可使用%.02f积分)",self.integral,([self.Money floatValue]*ManArray.count)*[self.proportion floatValue]];
                    
                    UseLabel.text = [NSString stringWithFormat:@"使用 %.02f 积分兑现￥%.02f",([self.Money floatValue]*ManArray.count)*[self.proportion floatValue],([self.Money floatValue]*ManArray.count)*[self.proportion floatValue]];
                    
                    self.CanUseInter = [NSString stringWithFormat:@"%.02f",([self.Money floatValue]*ManArray.count)*[self.proportion floatValue]];
                    
                    self.DiKouInter = [NSString stringWithFormat:@"%.02f",([self.Money floatValue]*ManArray.count)*[self.proportion floatValue]];
                    
                    NSString *stringForColor3 = [NSString stringWithFormat:@"%.02f",([self.Money floatValue]*ManArray.count)*[self.proportion floatValue]];
                    // 创建对象.
                    NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:UseLabel.text];
                    //
                    NSRange range3 = [UseLabel.text rangeOfString:stringForColor3];
                    [mAttStri addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Regular" size:10] range:range3];
                    UseLabel.attributedText=mAttStri;
                    
                }else{
                    
                    PriceLabel.text = [NSString stringWithFormat:@"￥%.02f(共%d人)",[self.Money floatValue]*ManArray.count - [self.integral floatValue],(int)ManArray.count];
                    
                    InterLabel.text = [NSString stringWithFormat:@"(你有%@积分，最多可使用%.02f积分)",self.integral,[self.integral floatValue]];
                    
                    UseLabel.text = [NSString stringWithFormat:@"使用 %.02f 积分兑现￥%.02f",[self.integral floatValue],[self.integral floatValue]];
                    
                    self.CanUseInter = [NSString stringWithFormat:@"%.02f",[self.integral floatValue]];
                    
                    self.DiKouInter = [NSString stringWithFormat:@"%.02f",[self.integral floatValue]];
                    
                    NSString *stringForColor3 = [NSString stringWithFormat:@"%.02f",[self.integral floatValue]];
                    // 创建对象.
                    NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:UseLabel.text];
                    //
                    NSRange range3 = [UseLabel.text rangeOfString:stringForColor3];
                    [mAttStri addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Regular" size:10] range:range3];
                    UseLabel.attributedText=mAttStri;
                    
                }
                
            }else{//保险关了，积分关了
                
                NSLog(@"保险关了，积分关了");
                
                PriceLabel.text = [NSString stringWithFormat:@"￥%.02f(共%d人)",[self.Money floatValue]*ManArray.count,(int)ManArray.count];
                
                InterLabel.text = [NSString stringWithFormat:@"(你有%@积分，最多可使用0.00积分)",self.integral];
                
                UseLabel.text = [NSString stringWithFormat:@"使用 0.00 积分兑现￥0.00"];
                
                self.CanUseInter = @"0.00";
                
                self.DiKouInter = @"0.00";
                
                NSString *stringForColor3 = @"0.00";
                // 创建对象.
                NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:UseLabel.text];
                //
                NSRange range3 = [UseLabel.text rangeOfString:stringForColor3];
                [mAttStri addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Regular" size:10] range:range3];
                UseLabel.attributedText=mAttStri;
                
            }
            
        }
        
//        if ([self.integral floatValue] >= ([self.Money floatValue]*ManArray.count + [self.sale floatValue]*2*ManArray.count)*[self.proportion floatValue]) {
//            
//            
//            PriceLabel.text = [NSString stringWithFormat:@"￥%.02f(共%d人)",[self.Money floatValue]*ManArray.count + [self.sale floatValue]*2*ManArray.count - ([self.Money floatValue]*ManArray.count + [self.sale floatValue]*2*ManArray.count)*[self.proportion floatValue],(int)ManArray.count];
//            
//            InterLabel.text = [NSString stringWithFormat:@"(你有%@积分，最多可使用%.02f积分)",self.integral,([self.Money floatValue]*ManArray.count + [self.sale floatValue]*2*ManArray.count)*[self.proportion floatValue]];
//            
//            UseLabel.text = [NSString stringWithFormat:@"使用 %.02f 积分兑现￥%.02f",([self.Money floatValue]*ManArray.count + [self.sale floatValue]*2*ManArray.count)*[self.proportion floatValue],([self.Money floatValue]*ManArray.count + [self.sale floatValue]*2*ManArray.count)*[self.proportion floatValue]];
//            
//            self.CanUseInter = [NSString stringWithFormat:@"%.02f",([self.Money floatValue]*ManArray.count + [self.sale floatValue]*2*ManArray.count)*[self.proportion floatValue]];
//            
//            self.DiKouInter = [NSString stringWithFormat:@"%.02f",([self.Money floatValue]*ManArray.count + [self.sale floatValue]*2*ManArray.count)*[self.proportion floatValue]];
//            
//            NSString *stringForColor3 = [NSString stringWithFormat:@"%.02f",([self.Money floatValue]*ManArray.count + [self.sale floatValue]*2*ManArray.count)*[self.proportion floatValue]];
//            // 创建对象.
//            NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:UseLabel.text];
//            //
//            NSRange range3 = [UseLabel.text rangeOfString:stringForColor3];
//            [mAttStri addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Regular" size:10] range:range3];
//            UseLabel.attributedText=mAttStri;
//            
//        }else{
//            
//            PriceLabel.text = [NSString stringWithFormat:@"￥%.02f(共%d人)",[self.Money floatValue]*ManArray.count + [self.sale floatValue]*2*ManArray.count - [self.integral floatValue],(int)ManArray.count];
//            
//            InterLabel.text = [NSString stringWithFormat:@"(你有%@积分，最多可使用%.02f积分)",self.integral,[self.integral floatValue]];
//            
//            UseLabel.text = [NSString stringWithFormat:@"使用 %.02f 积分兑现￥%.02f",[self.integral floatValue],[self.integral floatValue]];
//            
//            self.CanUseInter = [NSString stringWithFormat:@"%.02f",[self.integral floatValue]];
//            
//            self.DiKouInter = [NSString stringWithFormat:@"%.02f",[self.integral floatValue]];
//            
//            NSString *stringForColor3 = [NSString stringWithFormat:@"%.02f",[self.integral floatValue]];
//            // 创建对象.
//            NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:UseLabel.text];
//            //
//            NSRange range3 = [UseLabel.text rangeOfString:stringForColor3];
//            [mAttStri addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Regular" size:10] range:range3];
//            UseLabel.attributedText=mAttStri;
//            
//        }
        
        
        NSString *stringForColor = @"￥";
        NSString *stringForColor1 = [NSString stringWithFormat:@"(共%d人)",(int)ManArray.count];
        // 创建对象.
        NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:PriceLabel.text];
        //
        NSRange range = [PriceLabel.text rangeOfString:stringForColor];
        NSRange range1 = [PriceLabel.text rangeOfString:stringForColor1];
        
        [mAttStri addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Medium" size:12] range:range];
        [mAttStri addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:12] range:range1];
        [mAttStri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0] range:range1];
        
        PriceLabel.attributedText=mAttStri;
        
        
        
    }
    
    CGSize size=[InterLabel.text sizeWithFont:KNSFONT(12) maxSize:CGSizeMake(kScreen_Width-30, 14)];
    tipsBut.frame=CGRectMake(size.width+15+5, 47, 11, 11);
    CGRect rect=InterView.frame;
    InterTipsBut.frame=CGRectMake(tipsBut.center.x-40,rect.origin.y+tipsBut.frame.origin.y+tipsBut.frame.size.height, 80, 40);
}

-(void)DeleteBtnClick:(UIButton *)sender
{
    
    index = (int)sender.tag-1500;
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"确定要删除该乘机人？" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
    [alert show];
    
    
    
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex==0) {
        
        
    }else{
        
        OldManArray = ManArray;
        
        NSMutableArray *arrM = [NSMutableArray new];
        
        for (BianMinModel *model in ManArray) {
            
            [arrM addObject:model];
            
        }
        
        [arrM removeObjectAtIndex:index];
        ManArray = arrM;
        
        
        //删除的是哪个，就把他变0
        
        for (int i = 0; i < SelectArrM.count; i++) {
            
            BianMinModel *model = SelectArrM[i];
            
            if (i == index) {
                
                model.ManSelectString = @"0";
                
            }
        }
        
        [self initPasserView];
        
    }
}
-(void)initPhoneView
{
    
    nameView = [[UIView alloc] initWithFrame:CGRectMake(0,TopTipsHeight+ 101+10+50+9+50*ManArray.count, [UIScreen mainScreen].bounds.size.width, 50)];
    nameView.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:nameView];
    
    UIImageView *line2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 49, [UIScreen mainScreen].bounds.size.width, 1)];
    line2.image = [UIImage imageNamed:@"分割线-拷贝"];
    [nameView addSubview:line2];
    
    UILabel *ManLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(15, (50-13)/2, 60, 13)];
    ManLabel1.text = @"联系人";
    ManLabel1.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    ManLabel1.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    [nameView addSubview:ManLabel1];
    
    NameTF = [[UITextField alloc] initWithFrame:CGRectMake(80, (50-20)/2, 200, 20)];
    NameTF.placeholder = @"请输入联系人姓名";
    NameTF.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    NameTF.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    [nameView addSubview:NameTF];
    
    UIToolbar *bar3 = [[UIToolbar alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH,44)];
    UIButton *button3 = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 60, 7,50, 30)];
    [button3 setTitle:@"确定"forState:UIControlStateNormal];
    [button3 setTitleColor:[UIColor redColor] forState:0];
    [button3 addTarget:self action:@selector(OKBtnclick) forControlEvents:UIControlEventTouchUpInside];
    [bar3 addSubview:button3];
    
    UIButton *button4 = [[UIButton alloc] initWithFrame:CGRectMake(10, 7,50, 30)];
    [button4 setTitle:@"取消"forState:UIControlStateNormal];
    [button4 setTitleColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0] forState:0];
    [bar3 addSubview:button4];
    [button4 addTarget:self action:@selector(CancleBtnclick) forControlEvents:UIControlEventTouchUpInside];
    NameTF.inputAccessoryView = bar3;
    
    PhoneView = [[UIView alloc] initWithFrame:CGRectMake(0, TopTipsHeight+101+10+50+9+50+50*ManArray.count, [UIScreen mainScreen].bounds.size.width, 50)];
    PhoneView.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:PhoneView];
    
    UILabel *ManLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, (50-13)/2, 60, 13)];
    ManLabel.text = @"联系手机";
    ManLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    ManLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    [PhoneView addSubview:ManLabel];
    
    _scrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    
    
    PhoneLabel = [[UITextField alloc] initWithFrame:CGRectMake(80, (50-20)/2, 200, 20)];
    PhoneLabel.placeholder = @"请输入联系手机号";
    PhoneLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    PhoneLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    PhoneLabel.keyboardType = UIKeyboardTypeNumberPad;
//    PhoneLabel.delegate=self;
    [ZZLimitInputManager limitInputView:PhoneLabel maxLength:11];
    [PhoneView addSubview:PhoneLabel];
    
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
    PhoneLabel.inputAccessoryView = bar1;
    
    UIButton *PhoneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    PhoneButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-42, (50-23)/2, 22, 23);
    [PhoneButton setImage:[UIImage imageNamed:@"icon-address-book"] forState:0];
    [PhoneButton addTarget:self action:@selector(PhoneBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [PhoneView addSubview:PhoneButton];
    
    UIImageView *line1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 49, [UIScreen mainScreen].bounds.size.width, 1)];
    line1.image = [UIImage imageNamed:@"分割线-拷贝"];
    [PhoneView addSubview:line1];
    
    NSLog(@"====self.ManOrKidString===%@===Height===%d",self.ManOrKidString,Height);
    
    if ([self.ManOrKidString isEqualToString:@"2"]){
        
        ManPaioHaoView = [[UIView alloc] init];
        
        ManPaioHaoView.frame = CGRectMake(0,TopTipsHeight+ 101+69+50+59+50*ManArray.count, [UIScreen mainScreen].bounds.size.width, 50*Height);
        
        ManPaioHaoView.backgroundColor = [UIColor whiteColor];
        [_scrollView addSubview:ManPaioHaoView];
        
        ManPaioHaoLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, (50-13)/2, 60, 13)];
        ManPaioHaoLabel.text = @"成人票号";
        ManPaioHaoLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        ManPaioHaoLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
        [ManPaioHaoView addSubview:ManPaioHaoLabel];
        
        UIButton *ManPiaoHaoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        ManPiaoHaoButton.frame = CGRectMake(75, (50-14)/2, 14, 14);
        [ManPiaoHaoButton setImage:[UIImage imageNamed:@"icon_tip-grey"] forState:0];
        [ManPiaoHaoButton addTarget:self action:@selector(ManPiaoHaoBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [ManPaioHaoView addSubview:ManPiaoHaoButton];
        
        ManPaioHaoTF = [[UITextField alloc] initWithFrame:CGRectMake(109, (50-20)/2, 150, 20)];
        ManPaioHaoTF.placeholder = @"请输入成人票号";
        ManPaioHaoTF.returnKeyType=UIReturnKeyDone;
        ManPaioHaoTF.delegate=self;
//        ManPaioHaoTF.text = self.order_id;
        ManPaioHaoTF.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        ManPaioHaoTF.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
        ManPaioHaoTF.keyboardType = UIKeyboardTypeASCIICapable;
        [ManPaioHaoTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
       // [ZZLimitInputManager limitInputView:ManPaioHaoTF maxLength:11];
        [ManPaioHaoView addSubview:ManPaioHaoTF];
        
        UIToolbar *bar3 = [[UIToolbar alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH,44)];
        UIButton *button3 = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 60, 7,50, 30)];
        [button3 setTitle:@"确定"forState:UIControlStateNormal];
        [button3 setTitleColor:[UIColor redColor] forState:0];
        [button3 addTarget:self action:@selector(OKBtnclick) forControlEvents:UIControlEventTouchUpInside];
        [bar3 addSubview:button3];
        
        UIButton *button4 = [[UIButton alloc] initWithFrame:CGRectMake(10, 7,50, 30)];
        [button4 setTitle:@"取消"forState:UIControlStateNormal];
        [button4 setTitleColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0] forState:0];
        [bar3 addSubview:button4];
        [button4 addTarget:self action:@selector(CancleBtnclick) forControlEvents:UIControlEventTouchUpInside];
    //    ManPaioHaoTF.inputAccessoryView = bar3;
        
        
        UIImageView *GoBack = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-16-21, (50-21)/2, 21, 21)];
        GoBack.image = [UIImage imageNamed:@"icon-qu"];
//        GoBack.image = [UIImage imageNamed:@"icon-fan-hui"];
        [ManPaioHaoView addSubview:GoBack];
        
        
        UIImageView *line3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 50*Height-1, [UIScreen mainScreen].bounds.size.width, 1)];
        line3.image = [UIImage imageNamed:@"分割线-拷贝"];
        [ManPaioHaoView addSubview:line3];
        
        
        ManPaioHaoBackView = [[UIView alloc] init];
        
        ManPaioHaoBackView.frame = CGRectMake(0,TopTipsHeight+ 101+69+50+59+50*ManArray.count+50*Height, [UIScreen mainScreen].bounds.size.width, 50*Height);
        
        ManPaioHaoBackView.backgroundColor = [UIColor whiteColor];
        [_scrollView addSubview:ManPaioHaoBackView];
        
        ManPaioHaoBackLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, (50-13)/2, 60, 13)];
        ManPaioHaoBackLabel.text = @"成人票号";
        ManPaioHaoBackLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        ManPaioHaoBackLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
        [ManPaioHaoBackView addSubview:ManPaioHaoBackLabel];
        
        UIButton *ManPiaoHaoBackButton = [UIButton buttonWithType:UIButtonTypeCustom];
        ManPiaoHaoBackButton.frame = CGRectMake(75, (50-14)/2, 14, 14);
        [ManPiaoHaoBackButton setImage:[UIImage imageNamed:@"icon_tip-grey"] forState:0];
        [ManPiaoHaoBackButton addTarget:self action:@selector(ManPiaoHaoBackBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [ManPaioHaoBackView addSubview:ManPiaoHaoBackButton];
        
        ManPaioHaoBackTF = [[UITextField alloc] initWithFrame:CGRectMake(109, (50-20)/2, 150, 20)];
        ManPaioHaoBackTF.placeholder = @"请输入成人票号";
        ManPaioHaoTF.returnKeyType=UIReturnKeyDone;
//        ManPaioHaoBackTF.text = self.order_id1;
        ManPaioHaoBackTF.delegate=self;
        ManPaioHaoBackTF.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        ManPaioHaoBackTF.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
        ManPaioHaoBackTF.keyboardType = UIKeyboardTypeASCIICapable;
        [ManPaioHaoBackTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
      //  [ZZLimitInputManager limitInputView:ManPaioHaoBackTF maxLength:11];
        [ManPaioHaoBackView addSubview:ManPaioHaoBackTF];
        
        UIToolbar *bar4 = [[UIToolbar alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH,44)];
        UIButton *button6 = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 60, 7,50, 30)];
        [button6 setTitle:@"确定"forState:UIControlStateNormal];
        [button6 setTitleColor:[UIColor redColor] forState:0];
        [button6 addTarget:self action:@selector(OKBtnclick) forControlEvents:UIControlEventTouchUpInside];
        [bar4 addSubview:button6];
        
        UIButton *button7 = [[UIButton alloc] initWithFrame:CGRectMake(10, 7,50, 30)];
        [button7 setTitle:@"取消"forState:UIControlStateNormal];
        [button7 setTitleColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0] forState:0];
        [bar4 addSubview:button7];
        [button7 addTarget:self action:@selector(CancleBtnclick) forControlEvents:UIControlEventTouchUpInside];
      //  ManPaioHaoBackTF.inputAccessoryView = bar4;
        
        
        UIImageView *GoBackBack = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-16-21, (50-21)/2, 21, 21)];
        GoBackBack.image = [UIImage imageNamed:@"icon-fan-hui"];
        [ManPaioHaoBackView addSubview:GoBackBack];
        
        
        UIImageView *lineBack3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 49, [UIScreen mainScreen].bounds.size.width, 1)];
        lineBack3.image = [UIImage imageNamed:@"分割线-拷贝"];
        [ManPaioHaoBackView addSubview:lineBack3];
        
    }
    
}

-(void)ManPiaoHaoBtnClick
{
    [_piaoView showInView:self.view];
    
}

-(void)ManPiaoHaoBackBtnClick
{
    
    [_piaoView showInView:self.view];
}
-(void)OKBtnclick
{
    [NameTF resignFirstResponder];
    [PhoneLabel resignFirstResponder];
    
}

-(void)CancleBtnclick
{
    [NameTF resignFirstResponder];
    [PhoneLabel resignFirstResponder];
}

-(void)initBaoXianView
{
    BaoXianView = [[UIView alloc] initWithFrame:CGRectMake(0, TopTipsHeight+101+10+50+9+59+50+50*ManArray.count+109*Height, [UIScreen mainScreen].bounds.size.width, 50)];
    BaoXianView.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:BaoXianView];
    
    UIImageView *line2 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 11, 13, 14)];
    line2.image = [UIImage imageNamed:@"icon-insurance"];
    [BaoXianView addSubview:line2];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(32, 11, 100, 13)];
    label1.text = @"航空意外险";
    label1.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    label1.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    [BaoXianView addSubview:label1];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(15, 29, 150, 12)];
    label2.text = @"百万保额，飞行有保障";
    label2.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
    label2.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
    [BaoXianView addSubview:label2];
    
    BaoXianSwitch = [[UISwitch alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-60, 10, 50, 30)];
    BaoXianSwitch.tag = 20000;
    BaoXianSwitch.on = YES;//设置初始为ON的一边
    [BaoXianSwitch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];   // 开关事件切换通知
    [BaoXianView addSubview:BaoXianSwitch];
    
    UIImageView *line1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 49, [UIScreen mainScreen].bounds.size.width, 1)];
    line1.image = [UIImage imageNamed:@"分割线-拷贝"];
    [BaoXianView addSubview:line1];
    
    UIButton *baoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    baoButton.frame  =CGRectMake(0, 0, 150, 50);
    [baoButton addTarget:self action:@selector(BaoXianBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [BaoXianView addSubview:baoButton];
    
    
}

-(void)initInterView
{
    InterView = [[UIView alloc] initWithFrame:CGRectMake(0,TopTipsHeight+ 101+10+50+9+59+60+50+50*ManArray.count+109*Height, [UIScreen mainScreen].bounds.size.width, 70)];
    InterView.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:InterView];
    
    UseLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 19, 200, 12)];
    //    UseLabel.text = @"使用 200 积分兑现￥20.00";
    UseLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    UseLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
    [InterView addSubview:UseLabel];
    
    UseLabel.text = [NSString stringWithFormat:@"使用 0.00 积分兑现￥0.00"];
    
    NSString *stringForColor3 = @"0.00";
    // 创建对象.
    NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:UseLabel.text];
    //
    NSRange range3 = [UseLabel.text rangeOfString:stringForColor3];
    [mAttStri addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Regular" size:10] range:range3];
    UseLabel.attributedText=mAttStri;
    
    InterLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 45, [UIScreen mainScreen].bounds.size.width-60, 13)];
    //    InterLabel.text = @"(你有4482.12积分，最多可使用200积分)";
    InterLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
    InterLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
    [InterView addSubview:InterLabel];

    tipsBut=[UIButton buttonWithType:UIButtonTypeCustom];
    [tipsBut setImage:KImage(@"提示") forState:UIControlStateNormal];
    [tipsBut addTarget:self action:@selector(interTips:) forControlEvents:UIControlEventTouchUpInside];
    
    [InterView addSubview:tipsBut];

    
    
    InterSwitch = [[UISwitch alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-60, 20, 50, 30)];
    InterSwitch.tag = 10000;
    InterSwitch.on = YES;//设置初始为ON的一边
    [InterSwitch addTarget:self action:@selector(switchAction1:) forControlEvents:UIControlEventValueChanged];   // 开关事件切换通知
    [InterView addSubview:InterSwitch];
    
    UIImageView *line1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 69, [UIScreen mainScreen].bounds.size.width, 1)];
    line1.image = [UIImage imageNamed:@"分割线-拷贝"];
    [InterView addSubview:line1];
    
}

-(void)initXieYiView
{
    
    XieYiView = [[UIView alloc] initWithFrame:CGRectMake(0,TopTipsHeight+ 101+10+50+9+50+59+60+70+10+50*ManArray.count+109*Height, [UIScreen mainScreen].bounds.size.width, 40)];
    //    XieYiView.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:XieYiView];
    
    UIButton *XieYiButton = [UIButton buttonWithType:UIButtonTypeCustom];
    XieYiButton.frame = CGRectMake(14, 10, 16, 16);
    [XieYiButton setImage:[UIImage imageNamed:@"icon-selected-blue"] forState:0];
    [XieYiButton addTarget:self action:@selector(XieYiBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [XieYiView addSubview:XieYiButton];
    
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(35, 0, [UIScreen mainScreen].bounds.size.width-50, 80)];
    _textView.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
    _textView.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1.0];
    _textView.delegate = self;
    _textView.editable = NO;        //必须禁止输入，否则点击将弹出输入键盘
    _textView.scrollEnabled = NO;
    [XieYiView addSubview:_textView];
    
    //    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(35, 0, [UIScreen mainScreen].bounds.size.width-50, 40)];
    //    label2.numberOfLines=0;
    //    label2.text = @"我已阅读并同意 《关于民航旅客行李中携带锂电池规定的公告》《关于禁止携带危险品乘机的通知》《特殊旅客购票须知》。";
    //    label2.textColor = [UIColor colorWithRed:43/255.0 green:143/255.0 blue:255/255.0 alpha:1.0];
    //    label2.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
    //    [XieYiView addSubview:label2];
    ////
    //
    //    NSString *stringForColor3 = @"我已阅读并同意";
    //    // 创建对象.
    //    NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:label2.text];
    //    //
    //    NSRange range3 = [label2.text rangeOfString:stringForColor3];
    //    [mAttStri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0] range:range3];
    //    label2.attributedText=mAttStri;
    
    
    [self protocolIsSelect:self.isSelect];
    
}

- (void)protocolIsSelect:(BOOL)select {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"我已阅读并同意 《关于民航旅客行李中携带锂电池规定的公告》《关于禁止携带危险品乘机的通知》《特殊旅客购票须知》。"];
    [attributedString addAttribute:NSLinkAttributeName
                             value:@"zhifubao://"
                             range:[[attributedString string] rangeOfString:@"《关于民航旅客行李中携带锂电池规定的公告》"]];
    [attributedString addAttribute:NSLinkAttributeName
                             value:@"weixin://"
                             range:[[attributedString string] rangeOfString:@"《关于禁止携带危险品乘机的通知》"]];
    [attributedString addAttribute:NSLinkAttributeName
                             value:@"jianhang://"
                             range:[[attributedString string] rangeOfString:@"《特殊旅客购票须知》"]];
    
    NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
    
    NSMutableAttributedString *imageString = [NSMutableAttributedString attributedStringWithAttachment:textAttachment];
    [imageString addAttribute:NSLinkAttributeName
                        value:@"checkbox://"
                        range:NSMakeRange(0, imageString.length)];
    [attributedString insertAttributedString:imageString atIndex:0];
    
    [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Regular" size:12] range:NSMakeRange(0, attributedString.length)];
    _textView.attributedText = attributedString;
    _textView.linkTextAttributes = @{NSForegroundColorAttributeName: [UIColor colorWithRed:43/255.0 green:143/255.0 blue:255/255.0 alpha:1.0],
                                     NSUnderlineColorAttributeName: [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0],
                                     NSUnderlineStyleAttributeName: @(NSUnderlinePatternSolid)};
    
    _textView.delegate = self;
    _textView.editable = NO;        //必须禁止输入，否则点击将弹出输入键盘
    _textView.scrollEnabled = NO;
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange {
    if ([[URL scheme] isEqualToString:@"jianhang"]) {
        NSLog(@"建行支付---------------");
        RequestServiceVC *vc=[[RequestServiceVC alloc]initWithURLStr:JMSHTServiceAirSpecialPassengersInstructionsStr];
      //  AttentionViewController *vc = [[AttentionViewController alloc] init];
        [self.navigationController pushViewController:vc animated:NO];
        self.navigationController.navigationBar.hidden=YES;
        
        return NO;
    } else if ([[URL scheme] isEqualToString:@"zhifubao"]) {
        NSLog(@"支付宝支付---------------");
        
        PublicAnnouncementViewController *vc = [[PublicAnnouncementViewController alloc] init];
        [self.navigationController pushViewController:vc animated:NO];
        self.navigationController.navigationBar.hidden=YES;
        
        return NO;
    } else if ([[URL scheme] isEqualToString:@"weixin"]) {
        NSLog(@"微信支付---------------");
        
        ProhibitViewController *vc = [[ProhibitViewController alloc] init];
        [self.navigationController pushViewController:vc animated:NO];
        self.navigationController.navigationBar.hidden=YES;
        
        return NO;
    } else if ([[URL scheme] isEqualToString:@"checkbox"]) {
        self.isSelect = !self.isSelect;
        [self protocolIsSelect:self.isSelect];
        return NO;
    }
    return YES;
}

-(void)initBoomView
{
    
    UIView *boomView = [[UIView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-49-KSafeAreaBottomHeight, [UIScreen mainScreen].bounds.size.width-144, 49)];
    boomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:boomView];
    
    
    PriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, [UIScreen mainScreen].bounds.size.width-144-30, 20)];
    PriceLabel.text = @"￥---";
    PriceLabel.textColor = [UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
    PriceLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:19];
    [boomView addSubview:PriceLabel];
    
    UpimgView = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-144-24, (49-8)/2, 14, 8)];
    UpimgView.image = [UIImage imageNamed:@"icon_more-up"];
    [boomView addSubview:UpimgView];
    
    
    UpButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UpButton.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width-144, 49);
    [UpButton addTarget:self action:@selector(UpBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    UpButton.selected = YES;
    UpButton.hidden=YES;
    UpimgView.hidden=YES;
    [boomView addSubview:UpButton];
    
    
    
    UIView *PayView = [[UIView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-144, [UIScreen mainScreen].bounds.size.height-49-KSafeAreaBottomHeight, 144, 49)];
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)[UIColor colorWithRed:255/255.0 green:52/255.0 blue:90/255.0 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0].CGColor];
    gradientLayer.locations = @[@0.0, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1.0);
    gradientLayer.frame = CGRectMake(0, 0, 144, 49);
    [PayView.layer addSublayer:gradientLayer];
    
    [self.view addSubview:PayView];
    
    UIButton *Pay = [UIButton buttonWithType:UIButtonTypeCustom];
    Pay.frame = CGRectMake(0, 0, 144, 49);
    Pay.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:16];
    [Pay addTarget:self action:@selector(PayBtnCLick) forControlEvents:UIControlEventTouchUpInside];
    [Pay setTitle:@"付款" forState:0];
    [Pay setTitleColor:[UIColor whiteColor] forState:0];
    [PayView addSubview:Pay];
    
}

-(void)AirGoBackMingXi
{
    UpimgView.image = [UIImage imageNamed:@"icon_more-up"];
    UpButton.selected=YES;
    
}
//明细
-(void)UpBtnClick:(UIButton *)sender
{
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数组NSArray类型的数据
    
    UISwitch *baoxian = (UISwitch *)[self.view viewWithTag:20000];
    
    BOOL ret1 = [baoxian isOn];
    //判断积分按钮是否打开
    UISwitch *jifen = (UISwitch *)[self.view viewWithTag:10000];
    
    BOOL ret2 = [jifen isOn];
    
    if (sender.selected) {
        
        [_mingxiView Price:[userDefaultes stringForKey:@"goPrice"] JiJian:[userDefaultes stringForKey:@"goJiJian"] BaoXian:self.sale DiKoi:self.DiKouInter Number:(int)ManArray.count kai1:ret1 kai2:ret2 Price1:self.Price JiJian1:self.RanYou BaoXian1:self.sale DiKoi1:self.DiKouInter];
        
        [_mingxiView showInView:self.view];
        
        _mingxiView.delegate=self;
        
        UpimgView.image = [UIImage imageNamed:@"icon_more-down"];
        sender.selected = !sender.selected;
        
    }else{
        
        [_mingxiView hideInView];
        UpimgView.image = [UIImage imageNamed:@"icon_more-up"];
        sender.selected=YES;
        
        
    }
}
-(void)switchAction:(id)sender
{
    //保险
    UISwitch *switchButton = (UISwitch*)sender;
    UISwitch *inter = (UISwitch *)[self.view viewWithTag:10000];
    
    BOOL ret = [inter isOn];
    
    BOOL isButtonOn = [switchButton isOn];
    if (isButtonOn) {
        NSLog(@"开");
        
        if (ManArray.count==0) {
            
            PriceLabel.text = @"￥---";
            
        }else{
            
            if (ret) {
                
                //                NSLog(@"积分打开");
                
                //                PriceLabel.text = [NSString stringWithFormat:@"￥%.02f(共%d人)",[self.Money floatValue]*ManArray.count + [self.sale floatValue]*ManArray.count - [self.CanUseInter floatValue],(int)ManArray.count];
                
                if ([self.integral floatValue] >= ([self.Money floatValue]*ManArray.count + [self.sale floatValue]*2*ManArray.count)*[self.proportion floatValue]) {
                    
                    
                    PriceLabel.text = [NSString stringWithFormat:@"￥%.02f(共%d人)",[self.Money floatValue]*ManArray.count + [self.sale floatValue]*2*ManArray.count - ([self.Money floatValue]*ManArray.count + [self.sale floatValue]*2*ManArray.count)*[self.proportion floatValue],(int)ManArray.count];
                    
                    InterLabel.text = [NSString stringWithFormat:@"(你有%@积分，最多可使用%.02f积分)",self.integral,([self.Money floatValue]*ManArray.count + [self.sale floatValue]*2*ManArray.count)*[self.proportion floatValue]];
                    
                    UseLabel.text = [NSString stringWithFormat:@"使用 %.02f 积分兑现￥%.02f",([self.Money floatValue]*ManArray.count + [self.sale floatValue]*2*ManArray.count)*[self.proportion floatValue],([self.Money floatValue]*ManArray.count + [self.sale floatValue]*2*ManArray.count)*[self.proportion floatValue]];
                    
                    self.CanUseInter = [NSString stringWithFormat:@"%.02f",([self.Money floatValue]*ManArray.count + [self.sale floatValue]*2*ManArray.count)*[self.proportion floatValue]];
                    
                    self.DiKouInter = [NSString stringWithFormat:@"%.02f",([self.Money floatValue]*ManArray.count + [self.sale floatValue]*2*ManArray.count)*[self.proportion floatValue]];
                    
                    NSString *stringForColor3 = [NSString stringWithFormat:@"%.02f",([self.Money floatValue]*ManArray.count + [self.sale floatValue]*2*ManArray.count)*[self.proportion floatValue]];
                    // 创建对象.
                    NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:UseLabel.text];
                    //
                    NSRange range3 = [UseLabel.text rangeOfString:stringForColor3];
                    [mAttStri addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Regular" size:10] range:range3];
                    UseLabel.attributedText=mAttStri;
                    
                }else{
                    
                    PriceLabel.text = [NSString stringWithFormat:@"￥%.02f(共%d人)",[self.Money floatValue]*ManArray.count + [self.sale floatValue]*2*ManArray.count - [self.integral floatValue],(int)ManArray.count];
                    
                    InterLabel.text = [NSString stringWithFormat:@"(你有%@积分，最多可使用%.02f积分)",self.integral,[self.integral floatValue]];
                    
                    UseLabel.text = [NSString stringWithFormat:@"使用 %.02f 积分兑现￥%.02f",[self.integral floatValue],[self.integral floatValue]];
                    
                    self.CanUseInter = [NSString stringWithFormat:@"%.02f",[self.integral floatValue]];
                    
                    self.DiKouInter = [NSString stringWithFormat:@"%.02f",[self.integral floatValue]];
                    
                    NSString *stringForColor3 = [NSString stringWithFormat:@"%.02f",[self.integral floatValue]];
                    // 创建对象.
                    NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:UseLabel.text];
                    //
                    NSRange range3 = [UseLabel.text rangeOfString:stringForColor3];
                    [mAttStri addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Regular" size:10] range:range3];
                    UseLabel.attributedText=mAttStri;
                    
                }
            }else{
                
                //                NSLog(@"积分关闭");
                
                PriceLabel.text = [NSString stringWithFormat:@"￥%.02f(共%d人)",[self.Money floatValue]*ManArray.count + [self.sale floatValue]*2*ManArray.count,(int)ManArray.count];
                
                InterLabel.text = [NSString stringWithFormat:@"(你有%@积分，最多可使用0.00积分)",self.integral];
                
                UseLabel.text = [NSString stringWithFormat:@"使用 0.00 积分兑现￥0.00"];
                
                self.DiKouInter = @"0.00";
                
                NSString *stringForColor3 = @"0.00";
                // 创建对象.
                NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:UseLabel.text];
                //
                NSRange range3 = [UseLabel.text rangeOfString:stringForColor3];
                [mAttStri addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Regular" size:10] range:range3];
                UseLabel.attributedText=mAttStri;
                
            }
            
            
            NSString *stringForColor = @"￥";
            NSString *stringForColor1 = [NSString stringWithFormat:@"(共%d人)",(int)ManArray.count];
            // 创建对象.
            NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:PriceLabel.text];
            //
            NSRange range = [PriceLabel.text rangeOfString:stringForColor];
            NSRange range1 = [PriceLabel.text rangeOfString:stringForColor1];
            
            [mAttStri addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Medium" size:12] range:range];
            [mAttStri addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:12] range:range1];
            [mAttStri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0] range:range1];
            
            PriceLabel.attributedText=mAttStri;
        }
        
        
    }else {
        NSLog(@"关");
        
        
        if (ManArray.count==0) {
            
            PriceLabel.text = @"￥---";
        }else{
            
            
            if (ret) {
                
                //                NSLog(@"积分打开");
                
                //                PriceLabel.text = [NSString stringWithFormat:@"￥%.02f(共%d人)",[self.Money floatValue]*ManArray.count- [self.CanUseInter floatValue],(int)ManArray.count];
                
                if ([self.integral floatValue] >= ([self.Money floatValue]*ManArray.count)*[self.proportion floatValue]) {
                    
                    
                    PriceLabel.text = [NSString stringWithFormat:@"￥%.02f(共%d人)",[self.Money floatValue]*ManArray.count - ([self.Money floatValue]*ManArray.count)*[self.proportion floatValue],(int)ManArray.count];
                    
                    InterLabel.text = [NSString stringWithFormat:@"(你有%@积分，最多可使用%.02f积分)",self.integral,([self.Money floatValue]*ManArray.count)*[self.proportion floatValue]];
                    
                    UseLabel.text = [NSString stringWithFormat:@"使用 %.02f 积分兑现￥%.02f",([self.Money floatValue]*ManArray.count )*[self.proportion floatValue],([self.Money floatValue]*ManArray.count)*[self.proportion floatValue]];
                    
                    self.DiKouInter = [NSString stringWithFormat:@"%.02f",([self.Money floatValue]*ManArray.count)*[self.proportion floatValue]];
                    
                    NSString *stringForColor3 = [NSString stringWithFormat:@"%.02f",([self.Money floatValue]*ManArray.count)*[self.proportion floatValue]];
                    // 创建对象.
                    NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:UseLabel.text];
                    //
                    NSRange range3 = [UseLabel.text rangeOfString:stringForColor3];
                    [mAttStri addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Regular" size:10] range:range3];
                    UseLabel.attributedText=mAttStri;
                    
                }else{
                    
                    PriceLabel.text = [NSString stringWithFormat:@"￥%.02f(共%d人)",[self.Money floatValue]*ManArray.count - [self.integral floatValue],(int)ManArray.count];
                    
                    InterLabel.text = [NSString stringWithFormat:@"(你有%@积分，最多可使用%.02f积分)",self.integral,[self.integral floatValue]];
                    
                    UseLabel.text = [NSString stringWithFormat:@"使用 %.02f 积分兑现￥%.02f",[self.integral floatValue],[self.integral floatValue]];
                    
                    self.DiKouInter = [NSString stringWithFormat:@"%.02f",[self.integral floatValue]];
                    
                    
                    NSString *stringForColor3 = [NSString stringWithFormat:@"%.02f",[self.integral floatValue]];
                    // 创建对象.
                    NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:UseLabel.text];
                    //
                    NSRange range3 = [UseLabel.text rangeOfString:stringForColor3];
                    [mAttStri addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Regular" size:10] range:range3];
                    UseLabel.attributedText=mAttStri;
                    
                }
                
            }else{
                
                //                NSLog(@"积分关闭");
                
                PriceLabel.text = [NSString stringWithFormat:@"￥%.02f(共%d人)",[self.Money floatValue]*ManArray.count,(int)ManArray.count];
                
                InterLabel.text = [NSString stringWithFormat:@"(你有%@积分，最多可使用0.00积分)",self.integral];
                
                UseLabel.text = [NSString stringWithFormat:@"使用 0.00 积分兑现￥0.00"];
                self.DiKouInter = @"0.00";
                NSString *stringForColor3 = @"0.00";
                // 创建对象.
                NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:UseLabel.text];
                //
                NSRange range3 = [UseLabel.text rangeOfString:stringForColor3];
                [mAttStri addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Regular" size:10] range:range3];
                UseLabel.attributedText=mAttStri;
                
            }
            
            
            
            
            NSString *stringForColor = @"￥";
            NSString *stringForColor1 = [NSString stringWithFormat:@"(共%d人)",(int)ManArray.count];
            // 创建对象.
            NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:PriceLabel.text];
            //
            NSRange range = [PriceLabel.text rangeOfString:stringForColor];
            NSRange range1 = [PriceLabel.text rangeOfString:stringForColor1];
            
            [mAttStri addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Medium" size:12] range:range];
            [mAttStri addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:12] range:range1];
            [mAttStri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0] range:range1];
            
            PriceLabel.attributedText=mAttStri;
            
        }
        
    }
}

-(void)switchAction1:(id)sender
{
    
    UISwitch *switchButton = (UISwitch*)sender;
    
    UISwitch *inter = (UISwitch *)[self.view viewWithTag:20000];
    
    BOOL ret = [inter isOn];
    
    BOOL isButtonOn = [switchButton isOn];
    if (isButtonOn) {
        NSLog(@"开");
        
        if (ManArray.count==0) {
            
            PriceLabel.text = @"￥---";
        }else{
            
            if (ret) {
                
                //               NSLog(@"保险打开");
                
                //                PriceLabel.text = [NSString stringWithFormat:@"￥%.02f(共%d人)",[self.Money floatValue]*ManArray.count + [self.sale floatValue]*ManArray.count - [self.CanUseInter floatValue],(int)ManArray.count];
                
                if ([self.integral floatValue] >= ([self.Money floatValue]*ManArray.count + [self.sale floatValue]*2*ManArray.count)*[self.proportion floatValue]) {
                    
                    
                    PriceLabel.text = [NSString stringWithFormat:@"￥%.02f(共%d人)",[self.Money floatValue]*ManArray.count + [self.sale floatValue]*2*ManArray.count - ([self.Money floatValue]*ManArray.count + [self.sale floatValue]*2*ManArray.count)*[self.proportion floatValue],(int)ManArray.count];
                    
                    InterLabel.text = [NSString stringWithFormat:@"(你有%@积分，最多可使用%.02f积分)",self.integral,([self.Money floatValue]*ManArray.count + [self.sale floatValue]*2*ManArray.count)*[self.proportion floatValue]];
                    
                    self.DiKouInter = [NSString stringWithFormat:@"%.02f",([self.Money floatValue]*ManArray.count + [self.sale floatValue]*2*ManArray.count)*[self.proportion floatValue]];
                    
                    UseLabel.text = [NSString stringWithFormat:@"使用 %.02f 积分兑现￥%.02f",([self.Money floatValue]*ManArray.count + [self.sale floatValue]*2*ManArray.count)*[self.proportion floatValue],([self.Money floatValue]*ManArray.count + [self.sale floatValue]*2*ManArray.count)*[self.proportion floatValue]];
                    
                    
                    NSString *stringForColor3 = [NSString stringWithFormat:@"%.02f",([self.Money floatValue]*ManArray.count + [self.sale floatValue]*2*ManArray.count)*[self.proportion floatValue]];
                    // 创建对象.
                    NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:UseLabel.text];
                    //
                    NSRange range3 = [UseLabel.text rangeOfString:stringForColor3];
                    [mAttStri addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Regular" size:10] range:range3];
                    UseLabel.attributedText=mAttStri;
                    
                }else{
                    
                    PriceLabel.text = [NSString stringWithFormat:@"￥%.02f(共%d人)",[self.Money floatValue]*ManArray.count + [self.sale floatValue]*2*ManArray.count - [self.integral floatValue],(int)ManArray.count];
                    
                    InterLabel.text = [NSString stringWithFormat:@"(你有%@积分，最多可使用%.02f积分)",self.integral,[self.integral floatValue]];
                    
                    self.DiKouInter = [NSString stringWithFormat:@"%.02f",[self.integral floatValue]];
                    
                    UseLabel.text = [NSString stringWithFormat:@"使用 %.02f 积分兑现￥%.02f",[self.integral floatValue],[self.integral floatValue]];
                    
                    
                    NSString *stringForColor3 = [NSString stringWithFormat:@"%.02f",[self.integral floatValue]];
                    // 创建对象.
                    NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:UseLabel.text];
                    //
                    NSRange range3 = [UseLabel.text rangeOfString:stringForColor3];
                    [mAttStri addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Regular" size:10] range:range3];
                    UseLabel.attributedText=mAttStri;
                    
                }
                
            }else{
                
                //                NSLog(@"保险关闭");
                
                //                PriceLabel.text = [NSString stringWithFormat:@"￥%.02f(共%d人)",[self.Money floatValue]*ManArray.count -[self.CanUseInter floatValue],(int)ManArray.count];
                
                if ([self.integral floatValue] >= ([self.Money floatValue]*ManArray.count)*[self.proportion floatValue]) {
                    
                    
                    PriceLabel.text = [NSString stringWithFormat:@"￥%.02f(共%d人)",[self.Money floatValue]*ManArray.count - ([self.Money floatValue]*ManArray.count)*[self.proportion floatValue],(int)ManArray.count];
                    
                    InterLabel.text = [NSString stringWithFormat:@"(你有%@积分，最多可使用%.02f积分)",self.integral,([self.Money floatValue]*ManArray.count)*[self.proportion floatValue]];
                    
                    self.DiKouInter = [NSString stringWithFormat:@"%.02f",([self.Money floatValue]*ManArray.count)*[self.proportion floatValue]];
                    
                    UseLabel.text = [NSString stringWithFormat:@"使用 %.02f 积分兑现￥%.02f",([self.Money floatValue]*ManArray.count + [self.sale floatValue]*2*ManArray.count)*[self.proportion floatValue],([self.Money floatValue]*ManArray.count + [self.sale floatValue]*2*ManArray.count)*[self.proportion floatValue]];
                    
                    
                    NSString *stringForColor3 = [NSString stringWithFormat:@"%.02f",([self.Money floatValue]*ManArray.count + [self.sale floatValue]*2*ManArray.count)*[self.proportion floatValue]];
                    // 创建对象.
                    NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:UseLabel.text];
                    //
                    NSRange range3 = [UseLabel.text rangeOfString:stringForColor3];
                    [mAttStri addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Regular" size:10] range:range3];
                    UseLabel.attributedText=mAttStri;
                    
                }else{
                    
                    PriceLabel.text = [NSString stringWithFormat:@"￥%.02f(共%d人)",[self.Money floatValue]*ManArray.count - [self.integral floatValue],(int)ManArray.count];
                    
                    InterLabel.text = [NSString stringWithFormat:@"(你有%@积分，最多可使用%.02f积分)",self.integral,[self.integral floatValue]];
                    
                    self.DiKouInter = [NSString stringWithFormat:@"%.02f",[self.integral floatValue]];
                    
                    UseLabel.text = [NSString stringWithFormat:@"使用 %.02f 积分兑现￥%.02f",[self.integral floatValue],[self.integral floatValue]];
                    
                    
                    NSString *stringForColor3 = [NSString stringWithFormat:@"%.02f",[self.integral floatValue]];
                    // 创建对象.
                    NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:UseLabel.text];
                    //
                    NSRange range3 = [UseLabel.text rangeOfString:stringForColor3];
                    [mAttStri addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Regular" size:10] range:range3];
                    UseLabel.attributedText=mAttStri;
                    
                }
                
                
            }
            
            
            NSString *stringForColor = @"￥";
            NSString *stringForColor1 = [NSString stringWithFormat:@"(共%d人)",(int)ManArray.count];
            // 创建对象.
            NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:PriceLabel.text];
            //
            NSRange range = [PriceLabel.text rangeOfString:stringForColor];
            NSRange range1 = [PriceLabel.text rangeOfString:stringForColor1];
            
            [mAttStri addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Medium" size:12] range:range];
            [mAttStri addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:12] range:range1];
            [mAttStri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0] range:range1];
            
            PriceLabel.attributedText=mAttStri;
        }
        
    }else {
        NSLog(@"关");
        
        if (ManArray.count==0) {
            
            PriceLabel.text = @"￥---";
        }else{
            
            
            if (ret) {
                
                //                NSLog(@"保险打开");
                
                PriceLabel.text = [NSString stringWithFormat:@"￥%.02f(共%d人)",[self.Money floatValue]*ManArray.count+[self.sale floatValue]*2*ManArray.count,(int)ManArray.count];
                
                InterLabel.text = [NSString stringWithFormat:@"(你有%@积分，最多可使用0.00积分)",self.integral];
                
                self.DiKouInter = [NSString stringWithFormat:@"0.00"];
                
                UseLabel.text = [NSString stringWithFormat:@"使用 0.00 积分兑现￥0.00"];
                
                NSString *stringForColor3 = @"0.00";
                // 创建对象.
                NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:UseLabel.text];
                //
                NSRange range3 = [UseLabel.text rangeOfString:stringForColor3];
                [mAttStri addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Regular" size:10] range:range3];
                UseLabel.attributedText=mAttStri;
                
            }else{
                
                //                NSLog(@"保险关闭");
                
                PriceLabel.text = [NSString stringWithFormat:@"￥%.02f(共%d人)",[self.Money floatValue]*ManArray.count,(int)ManArray.count];
                
                InterLabel.text = [NSString stringWithFormat:@"(你有%@积分，最多可使用0.00积分)",self.integral];
                
                self.DiKouInter = [NSString stringWithFormat:@"0.00"];
                
                UseLabel.text = [NSString stringWithFormat:@"使用 0.00 积分兑现￥0.00"];
                
                NSString *stringForColor3 = @"0.00";
                // 创建对象.
                NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:UseLabel.text];
                //
                NSRange range3 = [UseLabel.text rangeOfString:stringForColor3];
                [mAttStri addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Regular" size:10] range:range3];
                UseLabel.attributedText=mAttStri;
                
            }
            
            
            
            
            NSString *stringForColor = @"￥";
            NSString *stringForColor1 = [NSString stringWithFormat:@"(共%d人)",(int)ManArray.count];
            // 创建对象.
            NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:PriceLabel.text];
            //
            NSRange range = [PriceLabel.text rangeOfString:stringForColor];
            NSRange range1 = [PriceLabel.text rangeOfString:stringForColor1];
            
            [mAttStri addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Medium" size:12] range:range];
            [mAttStri addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:12] range:range1];
            [mAttStri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0] range:range1];
            
            PriceLabel.attributedText=mAttStri;
            
        }
        
    }
    
    CGSize size=[InterLabel.text sizeWithFont:KNSFONT(12) maxSize:CGSizeMake(kScreen_Width-30, 14)];
    tipsBut.frame=CGRectMake(size.width+15+5, 47, 11, 11);
    CGRect rect=InterView.frame;
    InterTipsBut.frame=CGRectMake(tipsBut.center.x-40,rect.origin.y+tipsBut.frame.origin.y+tipsBut.frame.size.height, 80, 40);
}

-(void)interTips:(UIButton *)sender
{
    if (!InterTipsBut){
        // UIButton *but=[self.view viewWithTag:1689];
        CGRect rect=InterView.frame;
        InterTipsBut=[UIButton buttonWithType:UIButtonTypeCustom];
        InterTipsBut.frame=CGRectMake(tipsBut.center.x-40,rect.origin.y+tipsBut.frame.origin.y+tipsBut.frame.size.height, 80, 40);
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
        
        
        [_scrollView addSubview:InterTipsBut];
        //[InterView addSubview:InterTipsView];
        InterTipsBut.hidden=YES;
    }
    InterTipsBut.hidden=!InterTipsBut.hidden;
}

-(void)GoBtnClick
{
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    
    NSLog(@"=======%@",[userDefaultes stringForKey:@"goDate"]);
    NSLog(@"=======%@",[userDefaultes stringForKey:@"flightNo"]);
    
    
    [_oneView Time:[userDefaultes stringForKey:@"goDate"] Flight:[userDefaultes stringForKey:@"flightNo"] Back:self.time backFlight:self.flightNo];
    
    [_oneView showInView:self.view];
    
}
-(void)PayBtnCLick
{
    
    [_mingxiView  hideInView];
    if (ManArray.count == 0) {
        
        [TrainToast showWithText:@"最少添加一位乘机人" duration:2.0f];
        
    }else{
        
        if (NameTF.text.length == 0) {
            
            [TrainToast showWithText:@"请输入联系人姓名" duration:2.0f];
            
        }else{
            
            if (PhoneLabel.text.length == 0) {
                
                [TrainToast showWithText:@"请输入联系电话" duration:2.0f];
                
            }else{
                
                
                if ([self.ManOrKidString isEqualToString:@"2"]) {
                    
                    
                    if (ManPaioHaoTF.text.length ==0) {
                        
                        [TrainToast showWithText:@"请输入去程成人票号" duration:2.0f];
                        
                    }else{
                        
                        if (ManPaioHaoBackTF.text.length == 0) {
                            
                            [TrainToast showWithText:@"请输入返程成人票号" duration:2.0f];
                            
                        }else{
                            
                            NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
                            
                            UISwitch *jifen = (UISwitch *)[self.view viewWithTag:10000];
                            
                            BOOL ret2 = [jifen isOn];
                            
                            UISwitch *baoxian3 = (UISwitch *)[self.view viewWithTag:20000];
                            
                            BOOL ret3 = [baoxian3 isOn];
                            
                            
                            //去的价格
                            NSString *quPrice = [NSString stringWithFormat:@"%.02f",[[userDefaultes stringForKey:@"goPrice"] floatValue] + [[userDefaultes stringForKey:@"goJiJian"] floatValue]];
                            
                            //回来的价格
                            NSString *huiPrice = [NSString stringWithFormat:@"%.02f",[self.Price floatValue] + [self.RanYou floatValue]];
                            
                            NSString *quHuiPrice = [NSString stringWithFormat:@"%.02f",[[userDefaultes stringForKey:@"goPrice"] floatValue] + [[userDefaultes stringForKey:@"goJiJian"] floatValue] + [self.Price floatValue] + [self.RanYou floatValue]];
                            
                            if (ret2) {//积分开了
                                
                                if (ret3) {//积分开了，保险开了
                                    
                                    //用户积分大于抵扣积分
                                    if ([self.integral floatValue] >= ([quHuiPrice floatValue]*ManArray.count + [self.sale floatValue]*ManArray.count)*[self.proportion floatValue]) {
                                        
                                        self.Go_Price = [NSString stringWithFormat:@"%.02f",[quPrice floatValue]*ManArray.count + [self.sale floatValue]*ManArray.count - ([quPrice floatValue]*ManArray.count + [self.sale floatValue]*ManArray.count)*[self.proportion floatValue]];
                                        
                                        self.Go_Inter = [NSString stringWithFormat:@"%.02f",([quPrice floatValue]*ManArray.count + [self.sale floatValue]*ManArray.count)*[self.proportion floatValue]];
                                        
                                        self.Back_Price = [NSString stringWithFormat:@"%.02f",[huiPrice floatValue]*ManArray.count + [self.sale floatValue]*ManArray.count - ([huiPrice floatValue]*ManArray.count + [self.sale floatValue]*ManArray.count)*[self.proportion floatValue]];
                                        
                                        self.Back_Inter = [NSString stringWithFormat:@"%.02f",([huiPrice floatValue]*ManArray.count + [self.sale floatValue]*ManArray.count)*[self.proportion floatValue]];
                                        
                                    }else{
                                        
                                        //用户积分大于去程抵扣积分
                                        if ([self.integral floatValue] >= ([quPrice floatValue]*ManArray.count + [self.sale floatValue]*ManArray.count)*[self.proportion floatValue]) {
                                            
                                            self.Go_Price = [NSString stringWithFormat:@"%.02f",[quPrice floatValue]*ManArray.count + [self.sale floatValue]*ManArray.count - ([quPrice floatValue]*ManArray.count + [self.sale floatValue]*ManArray.count)*[self.proportion floatValue]];
                                            
                                            self.Go_Inter = [NSString stringWithFormat:@"%.02f",([quPrice floatValue]*ManArray.count + [self.sale floatValue]*ManArray.count)*[self.proportion floatValue]];
                                            
                                            self.Back_Price = [NSString stringWithFormat:@"%.02f",[huiPrice floatValue]*ManArray.count + [self.sale floatValue]*ManArray.count - ([self.integral floatValue] - ([quPrice floatValue]*ManArray.count + [self.sale floatValue]*ManArray.count)*[self.proportion floatValue])];
                                            
                                            self.Back_Inter = [NSString stringWithFormat:@"%.02f",[self.integral floatValue] - ([quPrice floatValue]*ManArray.count + [self.sale floatValue]*ManArray.count)*[self.proportion floatValue]];
                                            
                                        }else{//用户积分小于去程抵扣积分
                                            
                                            self.Go_Price = [NSString stringWithFormat:@"%.02f",[quPrice floatValue]*ManArray.count + [self.sale floatValue]*ManArray.count - [self.integral floatValue]];
                                            
                                            self.Go_Inter = [NSString stringWithFormat:@"%.02f",[self.integral floatValue]];
                                            
                                            self.Back_Price = [NSString stringWithFormat:@"%.02f",[huiPrice floatValue]*ManArray.count + [self.sale floatValue]*ManArray.count];
                                            
                                            self.Back_Inter = @"0.00";
                                            
                                        }
                                        
                                    }
                                }else{//积分开了，保险关了
                                    
                                    
                                    //用户积分大于抵扣积分
                                    if ([self.integral floatValue] >= ([quHuiPrice floatValue]*ManArray.count)*[self.proportion floatValue]) {
                                        
                                        self.Go_Price = [NSString stringWithFormat:@"%.02f",[quPrice floatValue]*ManArray.count - ([quPrice floatValue]*ManArray.count)*[self.proportion floatValue]];
                                        
                                        self.Go_Inter = [NSString stringWithFormat:@"%.02f",([quPrice floatValue]*ManArray.count)*[self.proportion floatValue]];
                                        
                                        self.Back_Price = [NSString stringWithFormat:@"%.02f",[huiPrice floatValue]*ManArray.count - ([huiPrice floatValue]*ManArray.count)*[self.proportion floatValue]];
                                        
                                        self.Back_Inter = [NSString stringWithFormat:@"%.02f",([huiPrice floatValue]*ManArray.count)*[self.proportion floatValue]];
                                        
                                    }else{
                                        
                                        //用户积分大于去程抵扣积分
                                        if ([self.integral floatValue] >= ([quPrice floatValue]*ManArray.count)*[self.proportion floatValue]) {
                                            
                                            self.Go_Price = [NSString stringWithFormat:@"%.02f",[quPrice floatValue]*ManArray.count - ([quPrice floatValue]*ManArray.count)*[self.proportion floatValue]];
                                            
                                            self.Go_Inter = [NSString stringWithFormat:@"%.02f",([quPrice floatValue]*ManArray.count)*[self.proportion floatValue]];
                                            
                                            self.Back_Price = [NSString stringWithFormat:@"%.02f",[huiPrice floatValue]*ManArray.count - ([self.integral floatValue] - ([quPrice floatValue]*ManArray.count)*[self.proportion floatValue])];
                                            
                                            self.Back_Inter = [NSString stringWithFormat:@"%.02f",[self.integral floatValue] - ([quPrice floatValue]*ManArray.count)*[self.proportion floatValue]];
                                            
                                        }else{//用户积分小于去程抵扣积分
                                            
                                            self.Go_Price = [NSString stringWithFormat:@"%.02f",[quPrice floatValue]*ManArray.count - [self.integral floatValue]];
                                            
                                            self.Go_Inter = [NSString stringWithFormat:@"%.02f",[self.integral floatValue]];
                                            
                                            self.Back_Price = [NSString stringWithFormat:@"%.02f",[huiPrice floatValue]*ManArray.count];
                                            
                                            self.Back_Inter = @"0.00";
                                            
                                        }
                                        
                                    }
                                    
                                    
                                }
                            }else{//积分关了
                                
                                if (ret3) {//积分关了，保险开了
                                    
                                    self.Go_Price = [NSString stringWithFormat:@"%.02f",[quPrice floatValue]*ManArray.count + [self.sale floatValue]*ManArray.count];
                                    self.Go_Inter = @"0.00";
                                    
                                    self.Back_Price = [NSString stringWithFormat:@"%.02f",[huiPrice floatValue]*ManArray.count + [self.sale floatValue]*ManArray.count];
                                    self.Back_Inter = @"0.00";
                                    
                                    
                                }else{//积分关了，保险关了
                                    
                                    //分开计算积分、价格
                                    self.Go_Price = [NSString stringWithFormat:@"%.02f",[quPrice floatValue]*ManArray.count];
                                    self.Go_Inter = @"0.00";
                                    
                                    self.Back_Price = [NSString stringWithFormat:@"%.02f",[huiPrice floatValue]*ManArray.count];
                                    self.Back_Inter = @"0.00";
                                    
                                }
                                
                            }
                            
                            
                            
                            
                            
                            if ([self.Pay_plane_type isEqualToString:@"小"]) {
                                
                                self.Pay_plane_type = @"0";
                                
                            }else if ([self.Pay_plane_type isEqualToString:@"中"]){
                                
                                self.Pay_plane_type = @"1";
                            }else if ([self.Pay_plane_type isEqualToString:@"大"]){
                                
                                self.Pay_plane_type = @"2";
                            }else{
                                
                                self.Pay_plane_type = @"";
                            }
                            
                            
                            self.Pay_integral = self.DiKouInter;
                            self.Pay_phone1 = PhoneLabel.text;
                            self.Pay_linkman_name = NameTF.text;
                            
                            if ([self.ManOrKidString isEqualToString:@"1"]) {
                                
                                self.Pay_adultTicketNo = @"";
                                self.Pay_adultTicketNo1 = @"";
                                
                            }else if ([self.ManOrKidString isEqualToString:@"2"]){
                                
                                self.Pay_adultTicketNo = ManPaioHaoTF.text;
                                self.Pay_adultTicketNo1 = ManPaioHaoBackTF.text;
                            }
                            
                            self.Pay_psgtype = self.ManOrKidString;
                            self.Pay_is_arrive_and_depart = @"0";
                            self.Pay_clientId = @"3";
                            
                            UISwitch *baoxian = (UISwitch *)[self.view viewWithTag:20000];
                            
                            BOOL ret1 = [baoxian isOn];
                            
                            if (ret1) {
                                
                                self.Pay_is_aviation_accident_insurance = @"1";
                                self.Pay_aviation_accident_insurance_price = [NSString stringWithFormat:@"%.02f",[self.sale floatValue]];
                                
                            }else{
                                
                                self.Pay_is_aviation_accident_insurance = @"0";
                                self.Pay_aviation_accident_insurance_price = [NSString stringWithFormat:@"%.@",self.sale];
                            }
                            
                            
                            
                            [self CommitData];
                            
                            
                        }
                        
                    }
                }else{
                    
                    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
                    
                    UISwitch *jifen = (UISwitch *)[self.view viewWithTag:10000];
                    
                    BOOL ret2 = [jifen isOn];
                    
                    UISwitch *baoxian3 = (UISwitch *)[self.view viewWithTag:20000];
                    
                    BOOL ret3 = [baoxian3 isOn];
                    

                    //去的价格
                    NSString *quPrice = [NSString stringWithFormat:@"%.02f",[[userDefaultes stringForKey:@"goPrice"] floatValue] + [[userDefaultes stringForKey:@"goJiJian"] floatValue]];
                    
                    //回来的价格
                    NSString *huiPrice = [NSString stringWithFormat:@"%.02f",[self.Price floatValue] + [self.RanYou floatValue]];
                    
                    NSString *quHuiPrice = [NSString stringWithFormat:@"%.02f",[[userDefaultes stringForKey:@"goPrice"] floatValue] + [[userDefaultes stringForKey:@"goJiJian"] floatValue] + [self.Price floatValue] + [self.RanYou floatValue]];
                    
                    if (ret2) {//积分开了
                        
                        if (ret3) {//积分开了，保险开了
                            
                            //用户积分大于抵扣积分
                            if ([self.integral floatValue] >= ([quHuiPrice floatValue]*ManArray.count + [self.sale floatValue]*ManArray.count)*[self.proportion floatValue]) {
                                
                                self.Go_Price = [NSString stringWithFormat:@"%.02f",[quPrice floatValue]*ManArray.count + [self.sale floatValue]*ManArray.count - ([quPrice floatValue]*ManArray.count + [self.sale floatValue]*ManArray.count)*[self.proportion floatValue]];
                                
                                self.Go_Inter = [NSString stringWithFormat:@"%.02f",([quPrice floatValue]*ManArray.count + [self.sale floatValue]*ManArray.count)*[self.proportion floatValue]];
                                
                                self.Back_Price = [NSString stringWithFormat:@"%.02f",[huiPrice floatValue]*ManArray.count + [self.sale floatValue]*ManArray.count - ([huiPrice floatValue]*ManArray.count + [self.sale floatValue]*ManArray.count)*[self.proportion floatValue]];
                                
                                self.Back_Inter = [NSString stringWithFormat:@"%.02f",([huiPrice floatValue]*ManArray.count + [self.sale floatValue]*ManArray.count)*[self.proportion floatValue]];
                                
                            }else{
                                
                                //用户积分大于去程抵扣积分
                                if ([self.integral floatValue] >= ([quPrice floatValue]*ManArray.count + [self.sale floatValue]*ManArray.count)*[self.proportion floatValue]) {
                                    
                                    self.Go_Price = [NSString stringWithFormat:@"%.02f",[quPrice floatValue]*ManArray.count + [self.sale floatValue]*ManArray.count - ([quPrice floatValue]*ManArray.count + [self.sale floatValue]*ManArray.count)*[self.proportion floatValue]];
                                    
                                    self.Go_Inter = [NSString stringWithFormat:@"%.02f",([quPrice floatValue]*ManArray.count + [self.sale floatValue]*ManArray.count)*[self.proportion floatValue]];
                                    
                                    self.Back_Price = [NSString stringWithFormat:@"%.02f",[huiPrice floatValue]*ManArray.count + [self.sale floatValue]*ManArray.count - ([self.integral floatValue] - ([quPrice floatValue]*ManArray.count + [self.sale floatValue]*ManArray.count)*[self.proportion floatValue])];
                                    
                                    self.Back_Inter = [NSString stringWithFormat:@"%.02f",[self.integral floatValue] - ([quPrice floatValue]*ManArray.count + [self.sale floatValue]*ManArray.count)*[self.proportion floatValue]];
                                    
                                }else{//用户积分小于去程抵扣积分
                                    
                                    self.Go_Price = [NSString stringWithFormat:@"%.02f",[quPrice floatValue]*ManArray.count + [self.sale floatValue]*ManArray.count - [self.integral floatValue]];
                                    
                                    self.Go_Inter = [NSString stringWithFormat:@"%.02f",[self.integral floatValue]];
                                    
                                    self.Back_Price = [NSString stringWithFormat:@"%.02f",[huiPrice floatValue]*ManArray.count + [self.sale floatValue]*ManArray.count];
                                    
                                    self.Back_Inter = @"0.00";
                                    
                                }
                                
                            }
                        }else{//积分开了，保险关了
                            
                            
                            //用户积分大于抵扣积分
                            if ([self.integral floatValue] >= ([quHuiPrice floatValue]*ManArray.count)*[self.proportion floatValue]) {
                                
                                self.Go_Price = [NSString stringWithFormat:@"%.02f",[quPrice floatValue]*ManArray.count - ([quPrice floatValue]*ManArray.count)*[self.proportion floatValue]];
                                
                                self.Go_Inter = [NSString stringWithFormat:@"%.02f",([quPrice floatValue]*ManArray.count)*[self.proportion floatValue]];
                                
                                self.Back_Price = [NSString stringWithFormat:@"%.02f",[huiPrice floatValue]*ManArray.count - ([huiPrice floatValue]*ManArray.count)*[self.proportion floatValue]];
                                
                                self.Back_Inter = [NSString stringWithFormat:@"%.02f",([huiPrice floatValue]*ManArray.count)*[self.proportion floatValue]];
                                
                            }else{
                                
                                //用户积分大于去程抵扣积分
                                if ([self.integral floatValue] >= ([quPrice floatValue]*ManArray.count)*[self.proportion floatValue]) {
                                    
                                    self.Go_Price = [NSString stringWithFormat:@"%.02f",[quPrice floatValue]*ManArray.count - ([quPrice floatValue]*ManArray.count)*[self.proportion floatValue]];
                                    
                                    self.Go_Inter = [NSString stringWithFormat:@"%.02f",([quPrice floatValue]*ManArray.count)*[self.proportion floatValue]];
                                    
                                    self.Back_Price = [NSString stringWithFormat:@"%.02f",[huiPrice floatValue]*ManArray.count - ([self.integral floatValue] - ([quPrice floatValue]*ManArray.count)*[self.proportion floatValue])];
                                    
                                    self.Back_Inter = [NSString stringWithFormat:@"%.02f",[self.integral floatValue] - ([quPrice floatValue]*ManArray.count)*[self.proportion floatValue]];
                                    
                                }else{//用户积分小于去程抵扣积分
                                    
                                    self.Go_Price = [NSString stringWithFormat:@"%.02f",[quPrice floatValue]*ManArray.count - [self.integral floatValue]];
                                    
                                    self.Go_Inter = [NSString stringWithFormat:@"%.02f",[self.integral floatValue]];
                                    
                                    self.Back_Price = [NSString stringWithFormat:@"%.02f",[huiPrice floatValue]*ManArray.count];
                                    
                                    self.Back_Inter = @"0.00";
                                    
                                }
                                
                            }
                            
                            
                        }
                    }else{//积分关了
                        
                        if (ret3) {//积分关了，保险开了
                            
                            self.Go_Price = [NSString stringWithFormat:@"%.02f",[quPrice floatValue]*ManArray.count + [self.sale floatValue]*ManArray.count];
                            self.Go_Inter = @"0.00";
                            
                            self.Back_Price = [NSString stringWithFormat:@"%.02f",[huiPrice floatValue]*ManArray.count + [self.sale floatValue]*ManArray.count];
                            self.Back_Inter = @"0.00";
                            
                            
                        }else{//积分关了，保险关了
                            
                            //分开计算积分、价格
                            self.Go_Price = [NSString stringWithFormat:@"%.02f",[quPrice floatValue]*ManArray.count];
                            self.Go_Inter = @"0.00";
                            
                            self.Back_Price = [NSString stringWithFormat:@"%.02f",[huiPrice floatValue]*ManArray.count];
                            self.Back_Inter = @"0.00";
                            
                        }
                        
                    }
                    
                    
                   
                    
                    
                    if ([self.Pay_plane_type isEqualToString:@"小"]) {
                        
                        self.Pay_plane_type = @"0";
                        
                    }else if ([self.Pay_plane_type isEqualToString:@"中"]){
                        
                        self.Pay_plane_type = @"1";
                    }else if ([self.Pay_plane_type isEqualToString:@"大"]){
                        
                        self.Pay_plane_type = @"2";
                    }else{
                        
                        self.Pay_plane_type = @"";
                    }
                    
                    
                    self.Pay_integral = self.DiKouInter;
                    self.Pay_phone1 = PhoneLabel.text;
                    self.Pay_linkman_name = NameTF.text;
                    
                    if ([self.ManOrKidString isEqualToString:@"1"]) {
                        
                        self.Pay_adultTicketNo = @"";
                        self.Pay_adultTicketNo1 = @"";
                        
                    }else if ([self.ManOrKidString isEqualToString:@"2"]){
                        
                        self.Pay_adultTicketNo = ManPaioHaoTF.text;
                        self.Pay_adultTicketNo1 = ManPaioHaoBackTF.text;
                    }
                    
                    self.Pay_psgtype = self.ManOrKidString;
                    self.Pay_is_arrive_and_depart = @"0";
                    self.Pay_clientId = @"3";
                    
                    UISwitch *baoxian = (UISwitch *)[self.view viewWithTag:20000];
                    
                    BOOL ret1 = [baoxian isOn];
                    
                    if (ret1) {
                        
                        self.Pay_is_aviation_accident_insurance = @"1";
                        self.Pay_aviation_accident_insurance_price = [NSString stringWithFormat:@"%.02f",[self.sale floatValue]];
                        
                    }else{
                        
                        self.Pay_is_aviation_accident_insurance = @"0";
                        self.Pay_aviation_accident_insurance_price = [NSString stringWithFormat:@"%@",self.sale];
                    }
                    
                    
                    
                    [self CommitData];
                    
                    
                }
            }
        }
    }
}

-(void)CommitData
{
    [_ManArrM removeAllObjects];
    [_GoArrM removeAllObjects];
    [_BackArrM removeAllObjects];
    
   // WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
    WKProgressHUD *hud = [WKProgressHUD showInView:self.view animated:YES];
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        
    });
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@submitAirOrder_mob.shtml",URL_Str];
    //saveUserExchange_mob.shtml
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *dictGo = @{@"money":self.Go_Price,@"integral":self.Go_Inter,@"run_time":[userDefaultes stringForKey:@"run_time"],@"start_time":[userDefaultes stringForKey:@"start_time"],@"arrive_time":[userDefaultes stringForKey:@"arrive_time"],@"start_airport":[userDefaultes stringForKey:@"start_airport"],@"start_terminal":[userDefaultes stringForKey:@"start_terminal"],@"arrive_airport":[userDefaultes stringForKey:@"arrive_airport"],@"arrive_terminal":[userDefaultes stringForKey:@"arrive_terminal"],@"airport_flight":[userDefaultes stringForKey:@"airport_flight"],@"airport_name":[userDefaultes stringForKey:@"airport_name"],@"airport_code":[userDefaultes stringForKey:@"airport_code"],@"is_quick_meal":[userDefaultes stringForKey:@"is_quick_meal"],@"plane_type":[userDefaultes stringForKey:@"plane_type"],@"airrax":[userDefaultes stringForKey:@"airrax"],@"fuel_oil":[userDefaultes stringForKey:@"fuel_oil"],@"is_tehui":[userDefaultes stringForKey:@"is_tehui"],@"is_spe":[userDefaultes stringForKey:@"is_spe"],@"price":[userDefaultes stringForKey:@"Payprice"],@"cabin":[userDefaultes stringForKey:@"cabin"],@"bookpara":[userDefaultes stringForKey:@"bookpara"],@"phone1":self.Pay_phone1,@"linkman_name":self.Pay_linkman_name,@"is_aviation_accident_insurance":self.Pay_is_aviation_accident_insurance,@"adultTicketNo":self.Pay_adultTicketNo,@"aviation_accident_insurance_price":self.Pay_aviation_accident_insurance_price,@"psgtype":self.Pay_psgtype,@"shipping_space":[userDefaultes stringForKey:@"shipping_space"],@"is_arrive_and_depart":self.Pay_is_arrive_and_depart,@"clientId":self.Pay_clientId,@"refund_instructions":self.refund_instructions};
    NSLog(@"dictgo=%@",dictGo);
    [_GoArrM addObject:dictGo];
    
    
    NSLog(@"====舱位===%@====%@",[userDefaultes stringForKey:@"shipping_space"],self.Pay_shipping_space);
    
    NSDictionary *dictBack = @{@"money":self.Back_Price,@"integral":self.Back_Inter,@"run_time":self.Pay_run_time,@"start_time":self.Pay_start_time,@"arrive_time":self.Pay_arrive_time,@"start_airport":self.Pay_start_airport,@"start_terminal":self.Pay_start_terminal,@"arrive_airport":self.Pay_arrive_airport,@"arrive_terminal":self.Pay_arrive_terminal,@"airport_flight":self.Pay_airport_flight,@"airport_name":self.Pay_airport_name,@"airport_code":self.Pay_airport_code,@"is_quick_meal":self.Pay_is_quick_meal,@"plane_type":self.Pay_plane_type,@"airrax":self.Pay_airrax,@"fuel_oil":self.Pay_fuel_oil,@"is_tehui":self.Pay_is_tehui,@"is_spe":self.Pay_is_spe,@"price":self.Pay_price,@"cabin":self.Pay_cabin,@"bookpara":self.Pay_bookpara,@"phone1":self.Pay_phone1,@"linkman_name":self.Pay_linkman_name,@"is_aviation_accident_insurance":self.Pay_is_aviation_accident_insurance,@"adultTicketNo":self.Pay_adultTicketNo1,@"aviation_accident_insurance_price":self.Pay_aviation_accident_insurance_price,@"psgtype":self.Pay_psgtype,@"shipping_space":self.Pay_shipping_space,@"is_arrive_and_depart":self.Pay_is_arrive_and_depart,@"clientId":self.Pay_clientId,@"refund_instructions":self.refund_instructions};
    NSLog(@"dictBack=%@",dictBack);
    [_BackArrM addObject:dictBack];
    
    
    for (BianMinModel *model in ManArray) {
        
        NSDictionary *dict = @{@"username":model.username,@"passportseno":model.passportseno,@"phone2":model.phone};
        
        [_ManArrM addObject:dict];
        
    }
    
    NSDictionary *dict = @{@"go_plane_ticket":_GoArrM,@"return_plane_ticket":_BackArrM,@"plane_passenger_data":_ManArrM};
    
    NSString *str = [self dictionaryToJson:dict];
    
//    NSLog(@"==提交数据==%@",str);
    
    NSDictionary *dict3 = @{@"sigen":self.sigen,@"all_data":str,@"city_name":[kUserDefaults stringForKey:@"goCity"]};
    
    [manager POST:url parameters:dict3 success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
        NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];
        
        
        if (codeKey && content) {
            NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
            
            NSLog(@"xmlStr=提交=%@",xmlStr);
            
            
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
                
                self.Money_url = dic[@"money"];
                
                self.Return_url = dic[@"returnurl"];
                
                if ([dic[@"type"] isEqualToString:@"2"] && ![dic[@"money"] isEqualToString:@""] && ![dic[@"money"] isEqual:null]){//组合支付
                    
                    
                    //调用支付宝支付
                    
                    [self saveAlipayRecord];
                    
                    
                    
                }
                
                
            }else if ([dic[@"status"] isEqualToString:@"10006"])
            {
                [UIAlertTools showAlertWithTitle:@"" message:dic[@"message"] cancelTitle:@"知道了" titleArray:nil viewController:self confirm:^(NSInteger buttonTag) {
                    
                }];
                
                
            }else{
                
                [JRToast showWithText:dic[@"message"] duration:2.0f];
                
                
            }
            
            
            [hud dismiss:YES];
            
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        NSLog(@"%@",error);
        [hud dismiss:YES];
        
        
    }];
    
}


- (NSString*)dictionaryToJson:(NSDictionary *)dic
{
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}

-(void)XieYiBtnClick
{
    
    
}
-(void)PhoneBtnClick
{
    CNContactPickerViewController * vc = [[CNContactPickerViewController alloc] init];
    vc.delegate = self;
    [self presentViewController:vc animated:YES completion:nil];
    
}

-(void)BaoXianBtnClick
{
    _baoView.Text = self.Remark;
    
    [_baoView showInView:self.view];
    
}

-(void)ManBtnClick
{
    //键盘掉下
    [NameTF resignFirstResponder];
    
    NSMutableArray *arrM = [NSMutableArray new];
    
    if (ManArray.count > 0) {
        
        for (BianMinModel *model in ManArray) {
            
            [arrM addObject:model];
            
        }
        
        OldManArray = arrM;
    }
    
    _addView.TicketCount = self.TicketString;
    
    _addView.ManKidString = self.ManOrKidString;
    
//    _addView.ManArray = ManArray;
    
    _addView.ManArray = SelectArrM;
    
    _addView.PageString = @"0";
    
    _addView.delegate=self;
    
    [_addView showInView:self.view];
}

-(void)contactPicker:(CNContactPickerViewController *)picker didSelectContact:(CNContact *)contact
{
    //    NSLog(@"联系人的资料:===1111%@",contact);
    
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
        
        NSLog(@"==%@==%@", phoneLabel, phoneValue);
        
        //        PhoneLabel.text = [NSString stringWithFormat:@"%@",phoneValue];
        
        
        
        if ([phoneNumer.stringValue rangeOfString:@"+86"].location !=NSNotFound) {
            
            NSString *cca2 = [phoneNumer.stringValue stringByReplacingOccurrencesOfString:@"+86"withString:@""];//删除
            
            if([cca2 rangeOfString:@"-"].location !=NSNotFound){
                NSLog(@"yes");
                
                PhoneLabel.text =[cca2 stringByReplacingOccurrencesOfString:@"-" withString:@""];
                
            }else{
                
                PhoneLabel.text = [NSString stringWithFormat:@"%@",phoneValue];
                
            }
            
            
            
            
        }else{
            
            if([phoneNumer.stringValue rangeOfString:@"-"].location !=NSNotFound){
                
                PhoneLabel.text =[phoneNumer.stringValue stringByReplacingOccurrencesOfString:@"-" withString:@""];
                
            }else{
                
                PhoneLabel.text = [NSString stringWithFormat:@"%@",phoneValue];
            }
        }
    }
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    [_scrollView endEditing:YES];
    
}
-(void)TimeBtnClick
{
//    _customShareView.Text = self.Text;
//    
//    [_customShareView showInView:self.view Text:self.Text];
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    
    _GoGoView.Text1 = [userDefaultes stringForKey:@"texttext"];
    _GoGoView.Text2 = self.Text;
    [_GoGoView showInView:self.view Text:self.Text];
}
-(void)QurtBtnClick
{
    
    if ([self.LoginBack isEqualToString:@"888"]) {
        
        [NameTF resignFirstResponder];
        [PhoneLabel resignFirstResponder];
        [ManPaioHaoTF resignFirstResponder];
        [ManPaioHaoBackTF resignFirstResponder];
        [self.view endEditing:YES];
        
        NSArray *vcArray = self.navigationController.viewControllers;
        
        NSLog(@"==viewControllers===%@",vcArray);
        
        for(UIViewController *vc in vcArray)
        {
            
            if ([vc isKindOfClass:[AirPlaneDetailViewController class]]){
                
                
                self.navigationController.navigationBar.hidden=YES;
                
                [self.navigationController popToViewController:vc animated:NO];
                
            }
//            else{
//                
//                self.navigationController.navigationBar.hidden=YES;
//                self.tabBarController.tabBar.hidden=NO;
//                [self.navigationController popToRootViewControllerAnimated:NO];
//            }
            
        }
    }else{
        
        
        [NameTF resignFirstResponder];
        [PhoneLabel resignFirstResponder];
        [ManPaioHaoBackTF resignFirstResponder];
        [ManPaioHaoTF resignFirstResponder];
        [self.view endEditing:YES];
        
        [self.navigationController popViewControllerAnimated:NO];
        
    }
    
}

-(void)saveAlipayRecord
{
    
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
                    
                    NSNotification *notification1 = [[NSNotification alloc] initWithName:@"FJPNSNotificationGoBack" object:nil userInfo:nil];
                    
                    //通过通知中心发送通知
                    [[NSNotificationCenter defaultCenter] postNotification:notification1];
                    
                    [self GoALiPay];
                    
                    
                }else{
                    
                    [JRToast showWithText:dict1[@"message"] duration:2.0f];
                }
            }
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //        [WKProgressHUD popMessage:@"网络请求失败，请检查您的网络设置" inView:self.view duration:1.5 animated:YES];
        //        [self NoWebSeveice];
        
        NSLog(@"%@",error);
    }];
    
    
    
    //    [HTTPRequestManager POST:@"saveAlipayRecord.shtml" NSDictWithString:@{@"pay_order":self.Pay_orderno,@"pay_money":self.Money_url,@"clientId":@"10003",@"describe":@"IOS",@"returnurl":self.Return_url} parameters:nil result:^(id responseObj, NSError *error) {
    //
    //
    ////        NSLog(@"==========保存支付宝信息====%@===",responseObj);
    //
    //
    //        if (responseObj) {
    //
    //            for (NSDictionary *dict in responseObj) {
    //
    //
    //                if ([dict[@"status"] isEqualToString:@"10000"]) {
    //
    //
    //                    [self GoALiPay];
    //
    //                }else{
    //
    //
    //                    [JRToast showWithText:dict[@"message"] duration:3.0f];
    //
    //                }
    //
    //
    //            }
    //
    //
    //        }else{
    //
    //
    //            NSLog(@"error");
    //
    //        }
    //
    //
    //    }];
    
    
    
    
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
            
            
            
            NSLog(@"reslut = %@",resultDic);
            
            if ([resultDic[@"resultStatus"] isEqualToString:@"9000"]) {
                
                NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
                //读取数组NSArray类型的数据
                
                
                PersonalAllDanVC *vc=[[PersonalAllDanVC alloc] init];
                [vc selectedDingDanType:@"1" AndIndexType:2];

                self.navigationController.viewControllers=@[self.navigationController.viewControllers.firstObject,vc];
                [self.navigationController pushViewController:vc animated:NO];
                
                
                
            }else if ([resultDic[@"resultStatus"] isEqualToString:@"8000"]){
                
                [JRToast showWithText:@"正在处理中" duration:2.0f];
                
                
            }else if ([resultDic[@"resultStatus"] isEqualToString:@"4000"]){
                
                
                [JRToast showWithText:@"订单支付失败" duration:2.0f];
                
            }else if ([resultDic[@"resultStatus"] isEqualToString:@"6001"]){
                
                [JRToast showWithText:@"用户中途取消" duration:2.0f];
                PersonalAllDanVC *vc=[[PersonalAllDanVC alloc] init];
                [vc selectedDingDanType:@"1" AndIndexType:1];
                self.navigationController.viewControllers=@[self.navigationController.viewControllers.firstObject,vc];
                [self.navigationController pushViewController:vc animated:NO];
                
            }else if ([resultDic[@"resultStatus"] isEqualToString:@"6002"]){
                
                [JRToast showWithText:@"网络连接出错" duration:2.0f];
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
        
        
        PersonalAllDanVC *vc=[[PersonalAllDanVC alloc] init];
        [vc selectedDingDanType:@"1" AndIndexType:2];
        self.navigationController.viewControllers=@[self.navigationController.viewControllers.firstObject,vc];
        [self.navigationController pushViewController:vc animated:NO];
        
        
        
    }else if ([text.userInfo[@"resultStatus"] isEqualToString:@"8000"]){
        
        [JRToast showWithText:@"正在处理中" duration:2.0f];
        
        
    }else if ([text.userInfo[@"resultStatus"] isEqualToString:@"4000"]){
        
        
        [JRToast showWithText:@"订单支付失败" duration:2.0f];
        
    }else if ([text.userInfo[@"resultStatus"] isEqualToString:@"6001"]){
        
        [JRToast showWithText:@"用户中途取消" duration:2.0f];
        PersonalAllDanVC *vc=[[PersonalAllDanVC alloc] init];
        [vc selectedDingDanType:@"1" AndIndexType:2];
        self.navigationController.viewControllers=@[self.navigationController.viewControllers.firstObject,vc];
        [self.navigationController pushViewController:vc animated:NO];
        
    }else if ([text.userInfo[@"resultStatus"] isEqualToString:@"6002"]){
        
        [JRToast showWithText:@"网络连接出错" duration:2.0f];
    }
    
    
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ((textField==ManPaioHaoTF)||(textField==ManPaioHaoBackTF) ){
        
        NSCharacterSet *cs;
        cs = [[NSCharacterSet characterSetWithCharactersInString:kAlphaNum] invertedSet];
        
        
        
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""]; //按cs分离出数组,数组按@""分离出字符串
        
        
        
        BOOL canChange = [string isEqualToString:filtered];
        
        return canChange;
    }
    else
    {
        return YES;
    }
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(void)textFieldDidChange:(UITextField *)TF
{
    if ((TF==ManPaioHaoTF)||(TF==ManPaioHaoBackTF)) {
        TF.text=[NSStringHelper toUpper:TF.text];
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


@end
