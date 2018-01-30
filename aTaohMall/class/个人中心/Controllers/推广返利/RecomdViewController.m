//
//  RecomdViewController.m
//  aTaohMall
//
//  Created by JMSHT on 2016/12/5.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import "RecomdViewController.h"

#import "NumberCell.h"
#import "RecordCell.h"

#import "SSPopup.h"

#import "ChangeMesssage2ViewController.h"


#import "AFNetworking.h"

#import "ConverUtil.h"
#import "DESUtil.h"
#import "SecretCodeTool.h"

#import "WKProgressHUD.h"

#import "QRCodeGenerator.h"//生成二维码


#import "FanLiRecordCell.h"
#import "AFNetworking.h"

#import "ConverUtil.h"
#import "DESUtil.h"
#import "SecretCodeTool.h"

#import "PayCardModel.h"

#import "NoCell.h"

#import "FanLiFooter.h"

//刷新
#import "DJRefresh.h"
#import "DJRefreshProgressView.h"

#import "HomeLookFooter.h"//点击加载更多
#import "WKProgressHUD.h"

#import "JRToast.h"

#import "RecordModel.h"

#import "UIImage+LXDCreateBarcode.h"

#define KScWith [UIScreen mainScreen].bounds.size.width

#define  KScHeight [UIScreen mainScreen].bounds.size.height/3.5

#define  YTHeight1 ([UIScreen mainScreen].bounds.size.height/3.5)*0.184

#define  YTHeight2 ([UIScreen mainScreen].bounds.size.height/3.5)*0.121

#define  KSYT [UIScreen mainScreen].bounds.size.height/3/1.85

@interface RecomdViewController ()<UITableViewDelegate,UITableViewDataSource,SSPopupDelegate,ChangePhoneDelegate,DJRefreshDelegate,FooterViewDelegate>
{
    
    
    
    UIView *ScoreView;
    UILabel *ScoreLabel;
    
    
    UIButton *WayButton;
    UIButton *NumberButton;
    UIButton *RecordButton;
    
    
    UIImageView *WayImgView;
    UIImageView *NumberImgView;
    UIImageView *RecordImgView;
    
    
    UIImageView *line1;
    
    UIView *JiHuoView;
    UIView *ErWeimaView;
    
    
    UIButton *YTButton;
    
    UIView *view;
    
    UITableView *_numberTableView;
    
    UITableView *_recordTableView;
    
    UIView *NoData;
    
    NSMutableArray *_numberData;
    NSMutableArray *_recordDaTa;
    
    UIImageView *imgView;
    
    UILabel *MyLabel;
    
    NSMutableArray *_datas;
    NSString *_page;
    
    NSString *_currentPageNo;
    
    int num1;
    int num2;
    
    HomeLookFooter *footer;
    
    NSString *string10;
    BOOL bo;//用来判断点击的是哪一个；
    UILabel *noData;
    
    
}

@property (nonatomic,strong)DJRefresh *refresh;

@end

@implementation RecomdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    _page=@"0";
    _currentPageNo=@"1";
    num1=0;
    num2=1;
    
    _numberData=[NSMutableArray new];
    
    _recordDaTa=[NSMutableArray new];
    
    
    self.view.backgroundColor=[UIColor whiteColor];
    self.view.frame=kScreen_Bounds;
    
    [self getWayDatas];
    
    
    [self initUI];
    
    
    
//
    
    
}

//验证
-(void)initJiHuoView
{
    self.YTString=@"10";
    
    self.GoToShallButton.hidden=YES;
    
    JiHuoView=[[UIView alloc] initWithFrame:CGRectMake(0, KScHeight+64, ScoreView.frame.size.width, [UIScreen mainScreen].bounds.size.height/3)];
    
    JiHuoView.backgroundColor=[UIColor whiteColor];
    
    [self.view addSubview:JiHuoView];
    
    UIButton *jihuoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    jihuoButton.frame=CGRectMake((ScoreView.frame.size.width-180)/2, (JiHuoView.frame.size.height-44-30)/2, 180, 44);
    
    [jihuoButton setBackgroundImage:[UIImage imageNamed:@"按钮蓝色"] forState:0];
    
    [jihuoButton setTitleColor:[UIColor whiteColor] forState:0];
    
    [jihuoButton setTitle:@"先去激活邀请码" forState:0];
    
    jihuoButton.titleLabel.font=[UIFont fontWithName:@"PingFangSC-Medium" size:15];
    
    [jihuoButton addTarget:self action:@selector(jihuoBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [JiHuoView addSubview:jihuoButton];
    
    
    UILabel *label2=[[UILabel alloc] initWithFrame:CGRectMake(20, (JiHuoView.frame.size.height-44-30)/2+54, ScoreView.frame.size.width-40, 20)];
    
    label2.text=@"激活验证码后，即可使用3种方式推荐好友";
    
    label2.textAlignment=NSTextAlignmentCenter;
    
    label2.textColor=[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    
    label2.font=[UIFont fontWithName:@"PingFangSC-Regular" size:11];
    
    [JiHuoView addSubview:label2];
    
    
    UIImageView *fengeline=[[UIImageView alloc] initWithFrame:CGRectMake(15, JiHuoView.frame.size.height-1, ScoreView.frame.size.width-30, 1)];
    
    fengeline.image=[UIImage imageNamed:@"分割线-拷贝"];
    
    [JiHuoView addSubview:fengeline];
    
    
    UIView *ShallView=[[UIView alloc] initWithFrame:CGRectMake(0, JiHuoView.frame.origin.y+([UIScreen mainScreen].bounds.size.height/3), ScoreView.frame.size.width, [UIScreen mainScreen].bounds.size.height-JiHuoView.frame.origin.y-([UIScreen mainScreen].bounds.size.height/3))];
    
    ShallView.backgroundColor=[UIColor whiteColor];
    
    [self.view addSubview:ShallView];
    
    
    
    UIImageView *imgView1=[[UIImageView alloc] initWithFrame:CGRectMake((ScoreView.frame.size.width-150-44-80)/2, 30, 50, 50)];
    
    imgView1.image=[UIImage imageNamed:@"发送链接"];
    
    [ShallView addSubview:imgView1];
    
    
    UILabel *imgLabel1=[[UILabel alloc] initWithFrame:CGRectMake((ScoreView.frame.size.width-150-44-80)/2, 80, 50, 50)];
    
    imgLabel1.text=@"发送链接推荐好友";
    imgLabel1.font=[UIFont fontWithName:@"PingFangSC-Regular" size:11];
    imgLabel1.textAlignment=NSTextAlignmentCenter;
    imgLabel1.textColor=[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    imgLabel1.numberOfLines=2;
    [ShallView addSubview:imgLabel1];
    
    
    UIImageView *imgView2=[[UIImageView alloc] initWithFrame:CGRectMake((ScoreView.frame.size.width-150-44-80)/2+70, 45, 22, 22)];
    
    imgView2.image=[UIImage imageNamed:@"展开箭头"];
    
    [ShallView addSubview:imgView2];
    
    
    UIImageView *imgView3=[[UIImageView alloc] initWithFrame:CGRectMake((ScoreView.frame.size.width-150-44-80)/2+70+42, 30, 50, 50)];
    
    imgView3.image=[UIImage imageNamed:@"好友注册"];
    
    [ShallView addSubview:imgView3];
    
    
    UILabel *imgLabel2=[[UILabel alloc] initWithFrame:CGRectMake((ScoreView.frame.size.width-150-44-80)/2+70+42, 80, 50, 50)];
    
    imgLabel2.text=@"好友注册成功";
    imgLabel2.font=[UIFont fontWithName:@"PingFangSC-Regular" size:11];
    imgLabel2.textColor=[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    imgLabel2.textAlignment=NSTextAlignmentCenter;
    imgLabel2.numberOfLines=2;
    [ShallView addSubview:imgLabel2];
    
    
    
    UIImageView *imgView4=[[UIImageView alloc] initWithFrame:CGRectMake((ScoreView.frame.size.width-150-44-80)/2+70+42+70, 45, 22, 22)];
    
    imgView4.image=[UIImage imageNamed:@"展开箭头"];
    
    [ShallView addSubview:imgView4];
    
    
    UIImageView *imgView5=[[UIImageView alloc] initWithFrame:CGRectMake((ScoreView.frame.size.width-150-44-80)/2+70+42+70+42, 30, 50, 50)];
    
    imgView5.image=[UIImage imageNamed:@"购物成功"];
    
    [ShallView addSubview:imgView5];
    
    UILabel *imgLabel3=[[UILabel alloc] initWithFrame:CGRectMake((ScoreView.frame.size.width-150-44-80)/2+70+42+70+42, 80, 50, 50)];
    
    imgLabel3.text=@"购物成功获得奖励";
    imgLabel3.font=[UIFont fontWithName:@"PingFangSC-Regular" size:11];
    imgLabel3.textColor=[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    imgLabel3.textAlignment=NSTextAlignmentCenter;
    imgLabel3.numberOfLines=2;
    [ShallView addSubview:imgLabel3];
    
    
}

//反向代理

-(void)setDataReload
{
    NSLog(@"====反向代理====");
    
    
    [self getWayDatas];
    
    
}

-(void)jihuoBtnClick
{
    ChangeMesssage2ViewController *vc=[[ChangeMesssage2ViewController alloc] init];
    
    vc.delegate=self;
    
    vc.sigens=self.sigen;
    
    
    [self.navigationController pushViewController:vc animated:NO];
    
    
    
}
//我二维码
-(void)initErWeimaView
{
    
    self.YTString=@"20";
    
    self.GoToShallButton.hidden=NO;
    
//    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, KScHeight+64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-KScHeight-64)];
//    
//    scrollView.contentSize=CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
//    scrollView.backgroundColor=[UIColor whiteColor];
//    
//    [self.view addSubview:scrollView];
    
    
    ErWeimaView=[[UIView alloc] initWithFrame:CGRectMake(0, KScHeight+64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height/3)];
    ErWeimaView.backgroundColor=[UIColor whiteColor];
    
    [self.view addSubview:ErWeimaView];
    
    MyLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 20, ScoreView.frame.size.width-100, 20)];
    
    
    
    MyLabel.font=[UIFont fontWithName:@"PingFangSC-Regular" size:14];
    
    [ErWeimaView addSubview:MyLabel];
    
    
    imgView=[[UIImageView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-KSYT+10)/2, 60, KSYT-10, KSYT-10)];
    
    
    
    UIImage * QRImage  = [UIImage imageOfQRFromURL: self.href codeSize: KSYT-10 red: 0 green: 0 blue: 0 insertImage: [UIImage imageNamed: @""] roundRadius: 15.0f];
    
    imgView.image = QRImage;
    
//    imgView.layer.borderColor = LayerColor;
//    imgView.layer.borderWidth = 0.5;
    
    
//    imgView.layer.borderColor = [[UIColor whiteColor] CGColor];
//    imgView.layer.borderWidth = 10.0;
    
    [imgView setImage:QRImage];
    
    [ErWeimaView addSubview:imgView];
    
    
    UIImageView *YTLine1=[[UIImageView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-KSYT+10)/2-10, 50, 1, KSYT+10)];
    YTLine1.backgroundColor=[UIColor redColor];
    
    YTLine1.image=[UIImage imageNamed:@"分割线"];
    
    [ErWeimaView addSubview:YTLine1];
    
    UIImageView *YTLine2=[[UIImageView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-KSYT+10)/2+KSYT, 50, 1, KSYT+10)];
    YTLine2.backgroundColor=[UIColor redColor];
    
    YTLine2.image=[UIImage imageNamed:@"分割线"];
    
    [ErWeimaView addSubview:YTLine2];
    
    UIImageView *YTLine3=[[UIImageView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-KSYT+10)/2-10, 50, KSYT+10, 1)];
    YTLine3.backgroundColor=[UIColor redColor];
    
    YTLine3.image=[UIImage imageNamed:@"分割线-拷贝"];
    
    [ErWeimaView addSubview:YTLine3];
    
     
    
    UIImageView *YTLine4=[[UIImageView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-KSYT+10)/2-10, 60+KSYT, KSYT+10, 1)];
    YTLine4.backgroundColor=[UIColor redColor];
    YTLine4.image=[UIImage imageNamed:@"分割线-拷贝"];
    
    [ErWeimaView addSubview:YTLine4];

    UILabel *label2=[[UILabel alloc] initWithFrame:CGRectMake(80, KSYT+50+10+5, ScoreView.frame.size.width-160, 20)];
    
    label2.text=@"推荐好友扫描二维码注册";
    label2.textAlignment=NSTextAlignmentCenter;
    label2.textColor=[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    label2.font=[UIFont fontWithName:@"PingFangSC-Regular" size:10];
    
    [ErWeimaView addSubview:label2];
    
    UIImageView *fengeline=[[UIImageView alloc] initWithFrame:CGRectMake(15, ErWeimaView.frame.size.height-1, ScoreView.frame.size.width-30, 1)];
    
    fengeline.image=[UIImage imageNamed:@"分割线-拷贝"];
    
    [ErWeimaView addSubview:fengeline];
    
    
    
    UIView *ShallView=[[UIView alloc] initWithFrame:CGRectMake(0, ErWeimaView.frame.origin.y+([UIScreen mainScreen].bounds.size.height/3), ScoreView.frame.size.width, [UIScreen mainScreen].bounds.size.height-ErWeimaView.frame.origin.y-([UIScreen mainScreen].bounds.size.height/3))];
    
    ShallView.backgroundColor=[UIColor whiteColor];
    
    [self.view addSubview:ShallView];
    
    NSLog(@"===ShallView.frame.size.height=====%f===",ShallView.frame.size.height);
    
    
    UIImageView *imgView1=[[UIImageView alloc] initWithFrame:CGRectMake((ScoreView.frame.size.width-150-44-80)/2, 10, 50, 50)];
    
    imgView1.image=[UIImage imageNamed:@"发送链接"];
    
    [ShallView addSubview:imgView1];
    
    
    UILabel *imgLabel1=[[UILabel alloc] initWithFrame:CGRectMake((ScoreView.frame.size.width-150-44-80)/2, 60, 50, 50)];
    
    imgLabel1.text=@"发送链接推荐好友";
    imgLabel1.font=[UIFont fontWithName:@"PingFangSC-Regular" size:11];
    imgLabel1.textAlignment=NSTextAlignmentCenter;
    imgLabel1.textColor=[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    imgLabel1.numberOfLines=2;
    [ShallView addSubview:imgLabel1];
    
    
    UIImageView *imgView2=[[UIImageView alloc] initWithFrame:CGRectMake((ScoreView.frame.size.width-150-44-80)/2+70, 25, 22, 22)];
    
    imgView2.image=[UIImage imageNamed:@"展开箭头"];
    
    [ShallView addSubview:imgView2];
    
    
    UIImageView *imgView3=[[UIImageView alloc] initWithFrame:CGRectMake((ScoreView.frame.size.width-150-44-80)/2+70+42, 10, 50, 50)];
    
    imgView3.image=[UIImage imageNamed:@"好友注册"];
    
    [ShallView addSubview:imgView3];
    
    
    UILabel *imgLabel2=[[UILabel alloc] initWithFrame:CGRectMake((ScoreView.frame.size.width-150-44-80)/2+70+42, 60, 50, 50)];
    
    imgLabel2.text=@"好友注册成功";
    imgLabel2.font=[UIFont fontWithName:@"PingFangSC-Regular" size:11];
    imgLabel2.textColor=[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    imgLabel2.textAlignment=NSTextAlignmentCenter;
    imgLabel2.numberOfLines=2;
    [ShallView addSubview:imgLabel2];
    
    
    
    UIImageView *imgView4=[[UIImageView alloc] initWithFrame:CGRectMake((ScoreView.frame.size.width-150-44-80)/2+70+42+70, 25, 22, 22)];
    
    imgView4.image=[UIImage imageNamed:@"展开箭头"];
    
    [ShallView addSubview:imgView4];
    
    
    UIImageView *imgView5=[[UIImageView alloc] initWithFrame:CGRectMake((ScoreView.frame.size.width-150-44-80)/2+70+42+70+42, 10, 50, 50)];
    
    imgView5.image=[UIImage imageNamed:@"购物成功"];
    
    [ShallView addSubview:imgView5];
    
    UILabel *imgLabel3=[[UILabel alloc] initWithFrame:CGRectMake((ScoreView.frame.size.width-150-44-80)/2+70+42+70+42, 60, 50, 50)];
    
    imgLabel3.text=@"购物成功获得奖励";
    imgLabel3.font=[UIFont fontWithName:@"PingFangSC-Regular" size:11];
    imgLabel3.textColor=[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    imgLabel3.textAlignment=NSTextAlignmentCenter;
    imgLabel3.numberOfLines=2;
    [ShallView addSubview:imgLabel3];
    
    
    YTButton=[UIButton buttonWithType:UIButtonTypeCustom];
    
    YTButton.frame=CGRectMake((ScoreView.frame.size.width-[UIScreen mainScreen].bounds.size.width/2.08)/2, ShallView.frame.size.height-[UIScreen mainScreen].bounds.size.width/2.08/4.1-10, [UIScreen mainScreen].bounds.size.width/2.08, [UIScreen mainScreen].bounds.size.width/2.08/4.1);
//    [YTButton setBackgroundImage:[UIImage imageNamed:@""] forState:0];
    
    [YTButton setTitle:@"推荐好友" forState:0];
    [YTButton setTitleColor:[UIColor whiteColor] forState:0];
    [YTButton setBackgroundColor:[UIColor colorWithRed:255/255.0 green:67/255.0 blue:68/255.0 alpha:1.0]];
    YTButton.layer.cornerRadius  = 2;
    YTButton.layer.masksToBounds = YES;
    YTButton.titleLabel.font=[UIFont fontWithName:@"PingFangSC-Medium" size:15];
    [ShallView addSubview:YTButton];
    
    [YTButton addTarget:self action:@selector(YTBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    
}
//创建页面
-(void)initUI
{
    //红色
    ScoreView=[[UIView alloc] initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight, [UIScreen mainScreen].bounds.size.width, KScHeight)];
    
    [self.view addSubview:ScoreView];
    
    UIImageView *bgImgView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KScWith, KScHeight)];
    bgImgView.image=[UIImage imageNamed:@"BGYT"];
    [ScoreView addSubview:bgImgView];
    
    //积分
    ScoreLabel=[[UILabel alloc] initWithFrame:CGRectMake(50, YTHeight1, ScoreView.frame.size.width-100, 30)];
//    ScoreLabel.text=@"25.36";
    ScoreLabel.textColor=[UIColor whiteColor];
    ScoreLabel.font=[UIFont fontWithName:@"PingFangSC-Semibold" size:30];
    ScoreLabel.textAlignment=NSTextAlignmentCenter;
    [ScoreView addSubview:ScoreLabel];
    
    
    UILabel *label1=[[UILabel alloc] initWithFrame:CGRectMake(100, YTHeight1+YTHeight2+30, ScoreView.frame.size.width-200, 20)];
    label1.text=@"累计获得推荐奖励";
    label1.textColor=[UIColor whiteColor];
    label1.font=[UIFont fontWithName:@"PingFangSC-Regular" size:15];
    label1.textAlignment=NSTextAlignmentCenter;
    [ScoreView addSubview:label1];
    
    
    
    WayButton= [UIButton buttonWithType:UIButtonTypeCustom];
    WayButton.frame=CGRectMake(30, KScHeight-53,60, 30);
    [WayButton setTitle:@"推荐方式" forState:0];
    [WayButton setTitleColor:[UIColor whiteColor] forState:0];
    WayButton.titleLabel.font=[UIFont fontWithName:@"PingFangSC-Regular" size:15];
    [WayButton addTarget:self action:@selector(WayBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [ScoreView addSubview:WayButton];
    
    WayImgView = [[UIImageView alloc] initWithFrame:CGRectMake(30+20, KScHeight-10, 19, 10)];
    WayImgView.image=[UIImage imageNamed:@"三角YT"];
    [ScoreView addSubview:WayImgView];
    
    
    NumberButton= [UIButton buttonWithType:UIButtonTypeCustom];
    NumberButton.frame=CGRectMake(90+(KScWith-180-60)/2, KScHeight-53,60 , 30);
    [NumberButton setTitle:@"推荐人数" forState:0];
    [NumberButton setTitleColor:[UIColor whiteColor] forState:0];
    NumberButton.titleLabel.font=[UIFont fontWithName:@"PingFangSC-Regular" size:15];
    [NumberButton addTarget:self action:@selector(NumberBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [ScoreView addSubview:NumberButton];
    
    
    NumberImgView = [[UIImageView alloc] initWithFrame:CGRectMake(NumberButton.frame.origin.x+20, KScHeight-10, 19, 10)];
    [ScoreView addSubview:NumberImgView];
    
    
    RecordButton= [UIButton buttonWithType:UIButtonTypeCustom];
    RecordButton.frame=CGRectMake(90+60+(KScWith-180-60)/2+(KScWith-180-60)/2, KScHeight-53,60 , 30);
    [RecordButton setTitle:@"奖励记录" forState:0];
    [RecordButton setTitleColor:[UIColor whiteColor] forState:0];
    RecordButton.titleLabel.font=[UIFont fontWithName:@"PingFangSC-Regular" size:15];
    [RecordButton addTarget:self action:@selector(RecordBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [ScoreView addSubview:RecordButton];
    
    
    RecordImgView = [[UIImageView alloc] initWithFrame:CGRectMake(RecordButton.frame.origin.x+20, KScHeight-10, 19, 10)];
    [ScoreView addSubview:RecordImgView];
    
}
//返回
- (IBAction)BackbtnClick:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


-(void)initWayUI
{
    
    line1=[[UIImageView alloc] initWithFrame:CGRectMake(20, ScoreView.frame.size.height+10+64+50, ScoreView.frame.size.width-40, 1)];
    
    line1.image=[UIImage imageNamed:@"分割线"];
    
    [self.view addSubview:line1];
    
    
    //    [self initJiHuoView];
    
    [self initErWeimaView];
    
    UIImageView *line2=[[UIImageView alloc] initWithFrame:CGRectMake(20, ScoreView.frame.size.height+10+64+50+161+20, ScoreView.frame.size.width-40, 1)];
    
    line2.image=[UIImage imageNamed:@"分割线"];
    
    [self.view addSubview:line2];
    
    UIView *YTView=[[UIView alloc] initWithFrame:CGRectMake(0, ScoreView.frame.size.height+10+64+50+161+20+50, ScoreView.frame.size.width, 100)];
    
    YTView.backgroundColor=[UIColor orangeColor];
    
    UIImageView *imgView1=[[UIImageView alloc] initWithFrame:CGRectMake((ScoreView.frame.size.width-210-60)/2, 15, 70, 70)];
    
    imgView1.image=[UIImage imageNamed:@"外圈"];
    
    [YTView addSubview:imgView1];
    
    
    UILabel *imgLabel1=[[UILabel alloc] initWithFrame:CGRectMake((ScoreView.frame.size.width-210-60)/2+10, 25, 50, 50)];
    
    imgLabel1.text=@"发送链接推荐好友";
    imgLabel1.font=[UIFont fontWithName:@"PingFangSC-Regular" size:12];
    imgLabel1.textAlignment=NSTextAlignmentCenter;
    imgLabel1.numberOfLines=2;
    [YTView addSubview:imgLabel1];
    
    
    UIImageView *imgView2=[[UIImageView alloc] initWithFrame:CGRectMake((ScoreView.frame.size.width-210-60)/2+70, 15, 30, 70)];
    
    imgView2.image=[UIImage imageNamed:@"分类右键"];
    
    [YTView addSubview:imgView2];
    
    
    UIImageView *imgView3=[[UIImageView alloc] initWithFrame:CGRectMake((ScoreView.frame.size.width-210-60)/2+100, 15, 70, 70)];
    
    imgView3.image=[UIImage imageNamed:@"外圈"];
    
    [YTView addSubview:imgView3];
    
    
    UILabel *imgLabel2=[[UILabel alloc] initWithFrame:CGRectMake((ScoreView.frame.size.width-210-60)/2+110, 25, 50, 50)];
    
    imgLabel2.text=@"好友注册成功";
    imgLabel2.font=[UIFont fontWithName:@"PingFangSC-Regular" size:12];
    imgLabel2.textAlignment=NSTextAlignmentCenter;
    imgLabel2.numberOfLines=2;
    [YTView addSubview:imgLabel2];
    
    
    
    UIImageView *imgView4=[[UIImageView alloc] initWithFrame:CGRectMake((ScoreView.frame.size.width-210-60)/2+170, 15, 30, 70)];
    
    imgView4.image=[UIImage imageNamed:@"分类右键"];
    
    [YTView addSubview:imgView4];
    
    
    UIImageView *imgView5=[[UIImageView alloc] initWithFrame:CGRectMake((ScoreView.frame.size.width-210-60)/2+200, 15, 70, 70)];
    
    imgView5.image=[UIImage imageNamed:@"外圈"];
    
    [YTView addSubview:imgView5];
    
    UILabel *imgLabel3=[[UILabel alloc] initWithFrame:CGRectMake((ScoreView.frame.size.width-210-60)/2+210, 25, 50, 50)];
    
    imgLabel3.text=@"购物成功获得奖励";
    imgLabel3.font=[UIFont fontWithName:@"PingFangSC-Regular" size:12];
    imgLabel3.textAlignment=NSTextAlignmentCenter;
    imgLabel3.numberOfLines=2;
    [YTView addSubview:imgLabel3];
    
    
    [self.view addSubview:YTView];
    
    
    
    YTButton=[UIButton buttonWithType:UIButtonTypeCustom];
    
    YTButton.frame=CGRectMake((ScoreView.frame.size.width-100)/2, [UIScreen mainScreen].bounds.size.height-60, 100, 30);
    [YTButton setBackgroundImage:[UIImage imageNamed:@""] forState:0];
    
    [YTButton setTitle:@"推荐好友" forState:0];
    
    [YTButton setTitleColor:[UIColor whiteColor] forState:0];
    
    [YTButton setBackgroundColor:[UIColor redColor]];
    
    YTButton.layer.cornerRadius  = 2;
    YTButton.layer.masksToBounds = YES;
    
    
    YTButton.titleLabel.font=[UIFont fontWithName:@"PingFangSC-Regular" size:18];
    
    [self.view addSubview:YTButton];
    
    [YTButton addTarget:self action:@selector(YTBtnClick) forControlEvents:UIControlEventTouchUpInside];
}

//创建推荐人数tableView
-(void)initNumberTableView
{
    _numberTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, KScHeight+64, KScWith, [UIScreen mainScreen].bounds.size.height-KScHeight-64) style:UITableViewStyleGrouped];
    _numberTableView.delegate=self;
    _numberTableView.dataSource=self;
    
    
    _numberTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
//    _numberTableView.separatorColor = [UIColor colorWithRed:18/255.0 green:18/255.0 blue:18/255.0 alpha:1.0];
    
//    _numberTableView.separatorInset = UIEdgeInsetsMake(0,0, 0, 0); // 设置端距，这里表示separator离左边和右边均80像素
    
    _numberTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    _numberTableView.backgroundColor=[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    
    [_numberTableView setSeparatorInset:UIEdgeInsetsZero];
    [_numberTableView setLayoutMargins:UIEdgeInsetsZero];
    
    
    //去掉底部多余的分割线
    _numberTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [_numberTableView registerNib:[UINib nibWithNibName:@"NumberCell" bundle:nil] forCellReuseIdentifier:@"cell1"];
    
    
    [_numberTableView registerNib:[UINib nibWithNibName:@"HomeLookFooter" bundle:nil] forHeaderFooterViewReuseIdentifier:@"header"];
    //点击加载更多
    
    
    _refresh=[[DJRefresh alloc] initWithScrollView:_numberTableView delegate:self];
    _refresh.topEnabled=YES;//下拉刷新
    _refresh.bottomEnabled=NO;//上拉加载
    
    [self.view addSubview:_numberTableView];
    
}

//创建推荐记录tableView
-(void)initRecordTableView
{
    _recordTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, KScHeight+64, KScWith, [UIScreen mainScreen].bounds.size.height-KScHeight-64) style:UITableViewStyleGrouped];
    _recordTableView.delegate=self;
    _recordTableView.dataSource=self;
    
    
    _recordTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
//    _recordTableView.separatorColor = [UIColor colorWithRed:18/255.0 green:18/255.0 blue:18/255.0 alpha:1.0];
    
//    _recordTableView.separatorInset = UIEdgeInsetsMake(0,0, 0, 0); // 设置端距，这里表示separator离左边和右边均80像素
    
    _recordTableView.backgroundColor=[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    
    _recordTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    
    [_recordTableView setSeparatorInset:UIEdgeInsetsZero];
    [_recordTableView setLayoutMargins:UIEdgeInsetsZero];
    
    //去掉底部多余的分割线
    _recordTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    
    [_recordTableView registerNib:[UINib nibWithNibName:@"RecordCell" bundle:nil] forCellReuseIdentifier:@"cell2"];
    
    
    [_recordTableView registerNib:[UINib nibWithNibName:@"HomeLookFooter" bundle:nil] forHeaderFooterViewReuseIdentifier:@"header"];
    //点击加载更多
    
    
    _refresh=[[DJRefresh alloc] initWithScrollView:_recordTableView delegate:self];
    _refresh.topEnabled=YES;//下拉刷新
    _refresh.bottomEnabled=NO;//上拉加载
    
    [self.view addSubview:_recordTableView];
    
}

//暂无相关数据文案
-(void)NoDataText
{
    
    noData=[[UILabel alloc] initWithFrame:CGRectMake(50, KScHeight+64+80, [UIScreen mainScreen].bounds.size.width-100, 30)];
    noData.text=@"暂无相关数据";
    noData.textAlignment=NSTextAlignmentCenter;
    noData.font=[UIFont fontWithName:@"PingFangSC-Regular" size:15];
    noData.textColor=[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    [self.view addSubview:noData];
    
    
}
//推荐方式
-(void)WayBtnClick
{
    
    if ([self.YTString isEqualToString:@"10"]) {
        
        self.GoToShallButton.hidden=YES;
        
    }else{
        
        self.GoToShallButton.hidden=NO;
        
    }
    
    WayImgView.image=[UIImage imageNamed:@"三角YT"];
    NumberImgView.image=[UIImage imageNamed:@""];
    RecordImgView.image=[UIImage imageNamed:@""];
    
    [self getWayDatas];
    
    
}
//推荐人数
-(void)NumberBtnClick
{
    
    self.GoToShallButton.hidden=YES;
    
    WayImgView.image=[UIImage imageNamed:@""];
    NumberImgView.image=[UIImage imageNamed:@"三角YT"];
    RecordImgView.image=[UIImage imageNamed:@""];
    
    [self initNumberTableView];
    
    
    [_numberData removeAllObjects];
    
    
    _page=@"0";
    _currentPageNo=@"1";
    
    num1=0;
    num2=1;
    
    [self getNumberDatas];
    
    bo = YES;
    
}
//推荐记录

-(void)RecordBtnClick
{
    
    self.GoToShallButton.hidden=YES;
    
    WayImgView.image=[UIImage imageNamed:@""];
    NumberImgView.image=[UIImage imageNamed:@""];
    RecordImgView.image=[UIImage imageNamed:@"三角YT"];
    
    [self initRecordTableView];
    
    
    [_recordDaTa removeAllObjects];
    
    bo = NO;
    
    _page=@"0";
    _currentPageNo=@"1";
    
    num1=0;
    num2=1;
    
    
    [self getRecordDatas];
    
    
}
//去推荐
- (IBAction)GoToRecomdBtnClick:(UIButton *)sender {
    
    SSPopup* selection=[[SSPopup alloc]init];
    selection.backgroundColor=[UIColor colorWithWhite:0.00 alpha:0.4];
    
    selection.frame = CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height);
    selection.SSPopupDelegate=self;
    [self.view  addSubview:selection];
    
    

    [selection CreateShallView:nil withSender:nil withTitle:self.href setCompletionBlock:^(int tag) {
        
    }];
    
}

//好友推荐
-(void)YTBtnClick
{
    
    SSPopup* selection=[[SSPopup alloc]init];
    
    
    selection.backgroundColor=[UIColor colorWithWhite:0.00 alpha:0.4];
    
    selection.frame = CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height);
    selection.SSPopupDelegate=self;
    [self.view  addSubview:selection];
    
    
    
    
    [selection CreateShallView:nil withSender:nil withTitle:self.href setCompletionBlock:^(int tag) {
        
    }];
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0000000001;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[UIView alloc]init];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==_numberTableView) {
        
        return _numberData.count;
        
    }else{
        
        
        return _recordDaTa.count;
        
    }
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView==_numberTableView) {
        
        NumberCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell1"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        //去除分割线空余
        [cell setSeparatorInset:UIEdgeInsetsZero];
        [cell setLayoutMargins:UIEdgeInsetsZero];
        
        
        RecordModel *model=_numberData[indexPath.row];
        
        cell.NameLabel.text=model.username;
        cell.TimeLabel.text=model.regdate;
        
        
        return cell;
        
        
        
    }else{
        
        RecordCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell2"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setSeparatorInset:UIEdgeInsetsZero];
        [cell setLayoutMargins:UIEdgeInsetsZero];
        
        
        RecordModel *model=_recordDaTa[indexPath.row];
        
        cell.TimeLabel.text=model.sysdate;
        cell.NumberLabel.text=[NSString stringWithFormat:@"+%@",model.integral];
        
        if ([model.type isEqualToString:@"8"]) {
            
            cell.WayLabel.text=@"推荐好友购物";
            
        }else if ([model.type isEqualToString:@"10"]){
            
            cell.WayLabel.text=@"推荐好友退款退货";
        }
        
        
        return cell;
        
        
    }
}

//推荐方式数据
-(void)getWayDatas
{
    //隐藏暂无更多数据
    noData.hidden = YES;
    
    
    WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
    
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        
        
        
    });
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@to_queryUserSpread_mob.shtml",URL_Str];
    //saveUserExchange_mob.shtml
    NSDictionary *dic = @{@"sigen":self.sigen};
    
    //        NSDictionary *dic=nil;
    //        NSDictionary *dic = @{@"classId":@"129"};
    [manager POST:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
        NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];
        
        
        
        
        if (codeKey && content) {
            NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
            
            //NSLog(@"xmlStr%@",xmlStr);
            
            
            NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];
            
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            NSLog(@"%@",dic);
            
            NoData.hidden=YES;
            
            for (NSDictionary *dict1 in dic) {//1
                
                
                NSNull *null=[[NSNull alloc] init];
                
                if ([dict1[@"status"] isEqualToString:@"10000"]) {//2
                    
                    
//                    NSLog(@"======%@",dict1[@"href"]);
                    
                    
                    self.href=dict1[@"href"];
                    
                    
                    
                    for (NSDictionary *dict2 in dict1[@"list_number"]) {//3
                        
//                         NSLog(@"======%@",dict2[@"integral"]);
                        
                        NSString *integral=[NSString stringWithFormat:@"%@",dict2[@"integral"]];
                        
                        
//                        NSLog(@"======%@====%ld",integral,integral.length);
                        
                        
                        if ([integral isEqual:null] || [integral isEqualToString:@""]) {//4
                            
                            ScoreLabel.text=[NSString stringWithFormat:@"0.00"];
                            
                        }else{
                            
                             ScoreLabel.text=[NSString stringWithFormat:@"%.02f",[integral floatValue]];
                            
                        }//4
                        

                    }//3
                    
                    
                    for (NSDictionary *dict3 in dict1[@"list_sigen"]) {
                        
//                        NSLog(@"======%@",dict3[@"sigen"]);
                        
                        self.Code=dict3[@"sigen"];
                        
                        
                    }
                    
                    for (NSDictionary *dict4 in dict1[@"list_phone"]) {//5
                        
//                        NSLog(@"======%@",dict4[@"phone"]);
                        
                        if ([dict4[@"phone"] isEqual:null] || [dict4[@"phone"] isEqualToString:@""] || [dict4[@"phone"] isEqualToString:@"0"]) {
                            
                            //激活
                            [self initJiHuoView];
                            
                        }else{
                            
                            //二维码
                            [self initErWeimaView];
                            
                            
                            
                            MyLabel.text=[NSString stringWithFormat:@"我的专属邀请码：%@",self.Code];
                            
//                            MyLabel.text=@"我的专属邀请码：26342852";
                            
                            MyLabel.textColor=[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
                            
                            NSString *stringForColor = self.Code;
                            
                            // 创建对象.
                            NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:MyLabel.text];
                            //
                            NSRange range = [MyLabel.text rangeOfString:stringForColor];
                            
                            [mAttStri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255/255.0 green:26/255.0 blue:27/255.0 alpha:1.0] range:range];
                            
                            MyLabel.attributedText=mAttStri;
                            
                            MyLabel.textAlignment=NSTextAlignmentCenter;
                            
                            
                        }
                    }//5
                    
                    
                }else{//2
                    
                    
                    [JRToast showWithText:dict1[@"message"] duration:3.0f];
                }
            }
            
            [hud dismiss:YES];
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //        [WKProgressHUD popMessage:@"网络请求失败，请检查您的网络设置" inView:self.view duration:1.5 animated:YES];
        
        [self NoWebSeveice];
        
        NSLog(@"%@",error);
    }];
}


//推荐人数数据
-(void)getNumberDatas
{
    
    
    WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
    
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        
        
    });
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@getReferralBonuses_mob.shtml",URL_Str];
    NSLog(@"===1==%@",self.sigen);
    NSLog(@"===1==%@",_page);
    NSLog(@"===1==%@",_currentPageNo);
    NSDictionary *dic = @{@"sigen":self.sigen,@"page":_page,@"currentPageNo":_currentPageNo};
    
    //        NSDictionary *dic=nil;
    //        NSDictionary *dic = @{@"classId":@"129"};
    [manager POST:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
        NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];
        
        
        if (codeKey && content) {
            NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
            
            //NSLog(@"xmlStr%@",xmlStr);
            
            
            NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];
            
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            NSLog(@"===推荐人数数据=====%@",dic);
            
            NoData.hidden=YES;
            
            NSNull *null=[[NSNull alloc] init];
            
            for (NSDictionary *dict1 in dic) {
                
                string10 = dict1[@"totalCount"];
                
                
                if ([dict1[@"status"] isEqualToString:@"10001"]) {
                    
                    footer.hidden=YES;
                    
                }else{
                    
                    footer.hidden=NO;
                }
                
                if ([dict1[@"status"] isEqualToString:@"10000"]) {
                    
                    for (NSDictionary *dict2 in dict1[@"integrallist"]) {
                        
                        RecordModel *model=[[RecordModel alloc] init];
                        
                        if (![dict2[@"regdate"] isEqual:null]) {
                            
                            model.regdate=dict2[@"regdate"];
                        }
                        
                        
                        if (![dict2[@"username"] isEqual:null]) {
                            
                            model.username=dict2[@"username"];
                        }
                        
//                        NSLog(@"===%@==%@",model.regdate,model.username);
                        
                        [_numberData addObject:model];
                        
                    }
                    
                    
                }else if([dict1[@"status"] isEqualToString:@"20000"]){
                    
                    
                }else{
                    
                    
                    [JRToast showWithText:dict1[@"message"] duration:3.0f];
                }
                
                
            }
            
            
            if (_numberData.count == 0) {
                
                [self NoDataText];
                _refresh.topEnabled=NO;//下拉刷新
                noData.hidden = NO;
                
            }else{
                
                noData.hidden = YES;
                
            }
            
            
            
            if (_numberData.count%20==0&&_numberData.count!=0&&_numberData.count !=[string10 integerValue]) {
                
                footer.hidden=NO;
                [footer.loadMoreBtn setTitle:@"点击加载更多" forState:0];
                footer.loadMoreBtn.enabled=YES;
                
            }else if (_numberData.count == [string10 integerValue]){
                footer.hidden = NO;
                footer.moreView.hidden=YES;
                [footer.loadMoreBtn setTitle:@"暂无更多数据" forState:0];
                [footer.loadMoreBtn setTitleColor:[UIColor colorWithRed:154/255.0 green:154/255.0 blue:154/255.0 alpha:1.0] forState:0];
                footer.loadMoreBtn.enabled=NO;
                
                
            }else{
                
                //隐藏点击加载更多
                footer.hidden=YES;
                
            }
            
            [hud dismiss:YES];
            
            [_numberTableView reloadData];
            
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //        [WKProgressHUD popMessage:@"网络请求失败，请检查您的网络设置" inView:self.view duration:1.5 animated:YES];
        
        [self NoWebSeveice];
        
        NSLog(@"%@",error);
    }];
}

//奖励记录数据
-(void)getRecordDatas
{
    
    WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
    
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        
    });
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@getRewardsRecord_mob.shtml",URL_Str];
    //saveUserExchange_mob.shtml
    
    NSLog(@"===2==%@",self.sigen);
    NSLog(@"===2==%@",_page);
    NSLog(@"===2==%@",_currentPageNo);
    
    NSDictionary *dic = @{@"sigen":self.sigen,@"page":_page,@"currentPageNo":_currentPageNo};
    
    
    [manager POST:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
        NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];
        
        
        
        
        if (codeKey && content) {
            NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
            
            //NSLog(@"xmlStr%@",xmlStr);
            
            
            NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];
            
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            NSLog(@"===奖励记录数据====%@",dic);
            
            NoData.hidden=YES;
            
            NSNull *null=[[NSNull alloc] init];
            
            for (NSDictionary *dict1 in dic) {
                
                string10 = dict1[@"totalCount"];
                
                
                if ([dict1[@"status"] isEqualToString:@"10001"]) {
                    
                    footer.hidden=YES;
                    
                }else{
                    
                    footer.hidden=NO;
                }
                
                    
                if ([dict1[@"status"] isEqualToString:@"10000"]) {
                        
                    for (NSDictionary *dict2 in dict1[@"integrallist"]) {
                            
                        RecordModel *model=[[RecordModel alloc] init];
                        
                        NSString *integral=[NSString stringWithFormat:@"%@",dict2[@"integral"]];
                        
                        if (![integral isEqual:null]) {
                                
                            model.integral=integral;
                        }
                            
                            
                        if (![dict2[@"sysdate"] isEqual:null]) {
                                
                            model.sysdate=dict2[@"sysdate"];
                        }
                            
                        
                        if (![dict2[@"type"] isEqual:null]) {
                            
                            model.type=dict2[@"type"];
                        }
                        
                        [_recordDaTa addObject:model];
                        
                        }

                        
                    
                }else if([dict1[@"status"] isEqualToString:@"20000"]){
                    
                    
                }else{
                    
                    
                    [JRToast showWithText:dict1[@"message"] duration:3.0f];
                    
                }
                
                
            }
            
            
            if (_recordDaTa.count == 0) {
                
                [self NoDataText];
                _refresh.topEnabled=NO;//下拉刷新
                noData.hidden = NO;
                
            }else{
                
                noData.hidden = YES;
                
            }
            
            
            
            if (_recordDaTa.count%20==0&&_recordDaTa.count!=0&&_recordDaTa.count !=[string10 integerValue]) {
                
                footer.hidden=NO;
                [footer.loadMoreBtn setTitle:@"点击加载更多" forState:0];
                footer.loadMoreBtn.enabled=YES;
                
            }else if (_recordDaTa.count == [string10 integerValue]){
                footer.hidden = NO;
                footer.moreView.hidden=YES;
                [footer.loadMoreBtn setTitle:@"暂无更多数据" forState:0];
                [footer.loadMoreBtn setTitleColor:[UIColor colorWithRed:154/255.0 green:154/255.0 blue:154/255.0 alpha:1.0] forState:0];
                footer.loadMoreBtn.enabled=NO;
                
                
            }else{
                
                //隐藏点击加载更多
                footer.hidden=YES;
                
            }
            
            [hud dismiss:YES];
            
            [_recordTableView reloadData];
            
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //        [WKProgressHUD popMessage:@"网络请求失败，请检查您的网络设置" inView:self.view duration:1.5 animated:YES];
        
        [self NoWebSeveice];
        
        NSLog(@"%@",error);
    }];
}

-(void)NoWebSeveice
{
    
    NoData=[[UIView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64)];
    
    NoData.backgroundColor=[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];
    
    [self.view addSubview:NoData];
    
    
    UIImageView *image=[[UIImageView alloc] initWithFrame:CGRectMake((NoData.frame.size.width-82)/2, 100, 82, 68)];
    
    image.image=[UIImage imageNamed:@"网络连接失败"];
    
    [NoData addSubview:image];
    
    
    UILabel *label1=[[UILabel alloc] initWithFrame:CGRectMake(100, 180, NoData.frame.size.width-200, 20)];
    
    label1.text=@"网络连接失败";
    
    label1.textAlignment=NSTextAlignmentCenter;
    
    label1.font=[UIFont fontWithName:@"PingFangSC-Medium" size:15];
    
    label1.textColor=[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    
    [NoData addSubview:label1];
    
    
    UILabel *label2=[[UILabel alloc] initWithFrame:CGRectMake(100, 210, NoData.frame.size.width-200, 20)];
    
    label2.text=@"请检查你的网络";
    
    label2.textAlignment=NSTextAlignmentCenter;
    
    label2.font=[UIFont fontWithName:@"PingFangSC-Medium" size:12];
    
    label2.textColor=[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    
    [NoData addSubview:label2];
    
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    
    button.frame=CGRectMake(100, 250, NoData.frame.size.width-200, 50);
    
    [button setTitle:@"重新加载" forState:0];
    button.titleLabel.font=[UIFont fontWithName:@"PingFangSC-Medium" size:12];
    [button setTitleColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0] forState:0];
    
    [NoData addSubview:button];
    
    [button addTarget:self action:@selector(loadData) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)loadData
{
    
    [self getWayDatas];
    
}

- (void)refresh:(DJRefresh *)refresh didEngageRefreshDirection:(DJRefreshDirection)direction{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self addDataWithDirection:direction];
    });
    
}

- (void)addDataWithDirection:(DJRefreshDirection)direction{
    
    if (direction==DJRefreshDirectionTop) {
        
        _page=@"0";
        _currentPageNo=@"1";
        
        
        //获取数据
        if(bo == 1){
            [_numberData removeAllObjects];
            [self getNumberDatas];
            [_numberTableView reloadData];
            bo = 1;
        }
        if(bo == 0){
            [_recordDaTa removeAllObjects];
            [self getRecordDatas];
            [_recordTableView reloadData];
            bo = 0;
        }
        
    }
    
    
    
    [_refresh finishRefreshingDirection:direction animation:YES];
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 44;
}


-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    footer=[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
    
    footer.delegate=self;
    if(_numberData.count==0 && bo == 1){
        footer.hidden = YES;
    }
    if(_recordDaTa.count==0 && bo == 0){
        footer.hidden = YES;
    }
    return footer;
}
//加载更多数据代理方法
- (void)FooterViewClickedloadMoreData
{
    
        //获取数据
        if(bo == 1){
            
            if (_numberData.count%20==0) {
                
                num1=num1+20;
                
                num2=num2+1;
                
                _page=[NSString stringWithFormat:@"%d",num1];
                
                _currentPageNo=[NSString stringWithFormat:@"%d",num2];
                
            }
            
            [self getNumberDatas];
            
        }
        
        if(bo == 0){
            
            if (_recordDaTa.count%20==0) {
                
                num1=num1+20;
                
                num2=num2+1;
                
                _page=[NSString stringWithFormat:@"%d",num1];
                
                _currentPageNo=[NSString stringWithFormat:@"%d",num2];
                
            }
            
            [self getRecordDatas];
            
        }
}




@end
