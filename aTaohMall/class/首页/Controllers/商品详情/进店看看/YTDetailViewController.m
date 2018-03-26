//
//  YTDetailViewController.m
//  aTaohMall
//
//  Created by JMSHT on 2016/10/9.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import "YTDetailViewController.h"
//刷新
#import "DJRefresh.h"
#import "DJRefreshProgressView.h"

#import "WKProgressHUD.h"

#import "MJRefresh.h"

#import "YTLoginViewController.h"

#import "YTWebViewViewController.h"

#import "GoodsDetailHeaderView.h"
#import "GoodsDetailCell.h"

#import "AFNetworking.h"
#import "ConverUtil.h"
#import "DESUtil.h"
#import "SecretCodeTool.h"
#import "UIImageView+WebCache.h"

#import "GoodsDetailModel.h"

#import "GotoShopLookViewController.h"//店铺详情

#import "TuWenViewController.h"//图文详情
#import "QueDingDingDanViewController.h"//确定订单

#import "NewAddAddressViewController.h"

//弹出视图
#import "WBPopMenuModel.h"
#import "WBPopMenuSingleton.h"
#import "CustomActionSheet.h"

#import "GoodsDetailImageModel.h"

#import "NewGoodsDetailViewController.h"

#import "WKProgressHUD.h"

#import "NewLoginViewController.h"

#import "GGClockView.h"//倒计时


#import "TimeModel.h"
//刷新
#import "DJRefresh.h"
#import "DJRefreshProgressView.h"

#import "UserMessageManager.h"

#import "XSInfoView.h"

#import "JRToast.h"

#import "SVProgressHUD.h"

#import "GoodsAttributeCell.h"//商品属性的cell
#import "GoodsAttributeCell2.h"
#import "GoodsDetailMainView.h"

#import "ChoseView.h"

#import "CartChoseView.h"

#import "GoodsAttributeModel.h"//属性

#import "TuWenViewController.h"

#define fwidth [UIScreen mainScreen].bounds.size.width

#import "YTGoodsDetailViewController.h"

#import "ATHLoginViewController.h"

#import "NoGoodsDetailViewController.h"

#import "UpLookCell.h"
#import "BackCartViewController.h"

#import "LZCartViewController.h"

#import "ThrowLineTool.h"

#import "SMProgressHUD.h"
#import "SMProgressHUDActionSheet.h"


#import "GoodsDetailAttributeCell.h"

#import "MerchantDetailViewController.h"//新商圈

//MapKit是原生地图框架
#import <MapKit/MapKit.h>

//CoreLocation是定位框架
#import <CoreLocation/CoreLocation.h>

#define AddButtonWidth [UIScreen mainScreen].bounds.size.width*0.32

#define BuyButtonWidth [UIScreen mainScreen].bounds.size.width*0.266
@interface YTDetailViewController ()<UITableViewDelegate,UITableViewDataSource,DJRefreshDelegate, MJRefreshBaseViewDelegate,UIWebViewDelegate,LoginMessageDelegate,UIScrollViewDelegate,BusinessReloadDataDelegate,ThrowLineToolDelegate,SMProgressHUDAlertViewDelegate, SMProgressHUDActionSheetDelegate,CartNumberDelegate,MKMapViewDelegate, CLLocationManagerDelegate>
{
    
    //地图View
    MKMapView *_mapView;
    
    //定位管理器
    CLLocationManager *_locationManager;
    
    
    UIWebView *_webView;
    
    UITableView *_tableView;
    //刷新尾
    MJRefreshFooterView *refreshFooterView;
    UIView *view;
    UIView *view1;
    UIView *view2;
    NSMutableArray *_datasArrM;
    
    NSMutableArray *_ArrM;
    
    NSString *sendWayString;//配送方式
    
    NSMutableArray *_ImageArrM;//轮番图片
    
    GoodsDetailHeaderView *_header;
    
    UIImageView *imgView;
    
    UILabel *label2;
    
    UIView *topView;
    
    UIButton *rightButton;//图文详情
    
    
    GoodsDetailMainView *goodsMainview;
    ChoseView *choseView;
    CartChoseView *cartchoseView;
    NSArray *sizearr;//尺寸数组
    NSArray *colorarr;//颜色数组
    NSArray *BuLiaoarr3;//布料数组
    NSArray *Stylearr4;//风格数组
    NSArray *Titlearr5;//标题数组；
    NSString *Goods_Type;
    NSString *Goods_Status;
    
    NSMutableArray *TitleArrM1;//中间可变数组
    NSMutableArray *ColorArrM2;//颜色可变数组
    NSMutableArray *SizeArrM3;//尺寸数组
    NSMutableArray *BuLiaoArrM4;//布料可变数组
    NSMutableArray *StyleArrM5;//风格可变数组
    
    NSString *ImageString;//图片
    NSString *MoneyString;//现金
    NSString *IntergelString;//积分
    NSString *StockString;//库存
    
    UILabel *timeLabel1;
    
    NSDictionary *stockdic;//商品库存量
    int goodsStock;
    
//    GoodsAttributeCell *cell10;
    
    GoodsDetailAttributeCell *cell10;
    
    UILabel *Newprice;
    
    BOOL isFirstLoadWeb;
    
    UIAlertController *alertCon;
    
    UIButton *_zhiding;
    
    UIButton *button1;
    NSString *SStatus;
    
    UIButton *CartButton;//加入购物车
    
    UIView *CartView;
    
    UILabel *countLabel;//购物车件数
    
    NSString *CartString;//购物车数量
    
    UIImageView *RedImgView;
    
    
    UIView *NoGoods;
    
    UIImageView *bgImgView;
    UIImageView *bgImgView1;
    
    UIImageView *bgImgView2;
    
    UIImageView *CartImgView;
    
    UIImageView *Newfenge;
    
}


@property (strong, nonatomic) UIImageView *redImg;//加入购物车红点

@property (strong, nonatomic) UIView *redView;//加入购物车红点

@property (nonatomic, weak)   id           m_data;
@property (nonatomic, weak)   NSIndexPath *m_tmpIndexPath;

@property (nonatomic,strong)YTGoodsDetailViewController *YTView;
@property (nonatomic,strong)DJRefresh *refresh;
@property (nonatomic, weak) GGClockView *clockView;
@property (nonatomic,strong)NSString *shouCangStr;
@end

@implementation YTDetailViewController

@synthesize leftSwipeGestureRecognizer,rightSwipeGestureRecognizer;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
   
    
    //获取自己的经纬度
    [self MakeSelfMessage];
    
    //自动偏移
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    
    [ThrowLineTool sharedTool].delegate = self;//加入购物车动画
    
    
    [refreshFooterView endRefreshing];
    
    self.PayMoneyLabel=[[UILabel alloc] init];
    
//    self.view.backgroundColor=[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];
    
    
    TitleArrM1=[NSMutableArray new];
    
    ColorArrM2=[NSMutableArray new];
    
    SizeArrM3=[NSMutableArray new];
    
    BuLiaoArrM4=[NSMutableArray new];
    
    StyleArrM5=[NSMutableArray new];
    
    //    NSLog(@"===========self.gid===%@==",self.gid);
    
    
    
    // Do any additional setup after loading the view from its nib.
//    [self SetDataForButton];
    
    //    [self initview];
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数组NSArray类型的数据
    self.sigen=[userDefaultes stringForKey:@"sigen"];
    
    NSLog(@">>>>>>%@",self.sigen);
    
    
    self.xuanze=@"20";
    
    self.sigen=@"";
    
    
    
    if ([[userDefaultes stringForKey:@"gouxuan"] isEqualToString:@"2"]){
        
        sendWayString=@"线下自取";
        
    }else{
        
        sendWayString=@"快递邮寄";
        
    }

    
    self.MoneyType = @"0";
    
    _datasArrM=[NSMutableArray new];
    
    _ArrM=[NSMutableArray new];
    
    _ImageArrM=[NSMutableArray new];
    
    

    Newfenge=[[UIImageView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-50-KSafeAreaTopNaviHeight-KSafeAreaBottomHeight, [UIScreen mainScreen].bounds.size.width, 1)];
    Newfenge.image=[UIImage imageNamed:@"分割线-拷贝"];
    
    [self.view addSubview:Newfenge];
    
    
    view1=[[UIView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-49-KSafeAreaTopNaviHeight-KSafeAreaBottomHeight, [UIScreen mainScreen].bounds.size.width-AddButtonWidth-BuyButtonWidth, 49)];
    
    view1.backgroundColor=[UIColor whiteColor];
    
//    [self.view addSubview:view1];
    
    UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(20, 15, 35, 20)];
    label.text=@"小计:";
    label.font=[UIFont systemFontOfSize:15];
//    [view1 addSubview:label];
    
    
    Newprice=[[UILabel alloc] initWithFrame:CGRectMake(55, 15, view1.frame.size.width-100-55, 20)];
    Newprice.textColor=[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
    Newprice.font=[UIFont systemFontOfSize:15];
//    [view1 addSubview:Newprice];
    
    
    //店铺
    
    UIView *ShopView = [[UIView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-49-KSafeAreaTopNaviHeight-KSafeAreaBottomHeight,([UIScreen mainScreen].bounds.size.width-AddButtonWidth-BuyButtonWidth-1)/2 , 49)];
//    ShopView.backgroundColor=[UIColor redColor];
    
    
    [self.view addSubview:ShopView];
    
    UIImageView *Shop = [[UIImageView alloc] initWithFrame:CGRectMake((ShopView.frame.size.width-20)/2, 5, 20, 20)];
    
    Shop.image = [UIImage imageNamed:@"店铺"];
    
    [ShopView addSubview:Shop];
    
    UILabel *shopName = [[UILabel alloc] initWithFrame:CGRectMake((ShopView.frame.size.width-30)/2, 30, 30, 10)];
    
    shopName.text = @"店铺";
    shopName.textAlignment = NSTextAlignmentCenter;
    shopName.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
    shopName.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
    
    [ShopView addSubview:shopName];
    
    UIImageView *ShopLine = [[UIImageView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-AddButtonWidth-BuyButtonWidth-1)/2, [UIScreen mainScreen].bounds.size.height-49-KSafeAreaTopNaviHeight+5-KSafeAreaBottomHeight, 1, 39)];
    
    ShopLine.image =[UIImage imageNamed:@"分割线"];
    
    [self.view addSubview:ShopLine];
    
    
    UIButton *ShopButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    ShopButton.frame = CGRectMake(0, 0, ShopView.frame.size.width, 49);
    
    [ShopButton addTarget:self action:@selector(GoToShopBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [ShopView addSubview:ShopButton];
    
    
    //购物车
    
    CartView = [[UIView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-AddButtonWidth-BuyButtonWidth-1)/2+1, [UIScreen mainScreen].bounds.size.height-49-KSafeAreaTopNaviHeight-KSafeAreaBottomHeight, ([UIScreen mainScreen].bounds.size.width-AddButtonWidth-BuyButtonWidth-1)/2, 49)];
//    CartView.backgroundColor=[UIColor yellowColor];
    
    [self.view addSubview:CartView];
    
    CartImgView = [[UIImageView alloc] initWithFrame:CGRectMake((ShopView.frame.size.width-20)/2, 5, 20, 20)];
    
    CartImgView.image = [UIImage imageNamed:@"购物车888"];
    
    
    [CartView addSubview:CartImgView];
    
    
    RedImgView = [[UIImageView alloc] initWithFrame:CGRectMake((ShopView.frame.size.width-30)/2+22, 0, 15, 15)];
    
    RedImgView.image = [UIImage imageNamed:@"标签888"];
    
    RedImgView.hidden = YES;
    
    [CartView addSubview:RedImgView];
    
    countLabel = [[UILabel alloc] initWithFrame:CGRectMake((ShopView.frame.size.width-30)/2+22, 0, 15, 15)];
    countLabel.backgroundColor=[UIColor clearColor];
    countLabel.textColor=[UIColor whiteColor];
    countLabel.textAlignment=NSTextAlignmentCenter;
    countLabel.layer.masksToBounds = YES;
    countLabel.layer.cornerRadius = 9;
    countLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:6];
    
    countLabel.hidden = YES;
    
    [CartView addSubview:countLabel];
    
    
    UILabel *CartName = [[UILabel alloc] initWithFrame:CGRectMake((ShopView.frame.size.width-40)/2, 30, 40, 10)];
    
    CartName.text = @"购物车";
    CartName.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
    CartName.textAlignment = NSTextAlignmentCenter;
    
    CartName.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
    
    [CartView addSubview:CartName];
    
    UIButton *LookCart = [UIButton buttonWithType:UIButtonTypeCustom];
    
    LookCart.frame = CGRectMake(0, 0, CartView.frame.size.width, 49);
    
    [LookCart addTarget:self action:@selector(GoToCartBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [CartView addSubview:LookCart];
    
    
    
    
    //加入购物车小圆点
    _redView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    _redView.backgroundColor = [UIColor redColor];
    _redView.center = CartButton.center;
    _redView.layer.cornerRadius = 10;
    
    
    _redImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    _redImg.backgroundColor = [UIColor redColor];
    _redImg.center = CartButton.center;
    _redImg.layer.cornerRadius = 10;
    
    //加入购物车
    
    CartButton=[UIButton buttonWithType:UIButtonTypeCustom];
    CartButton.frame=CGRectMake([UIScreen mainScreen].bounds.size.width-AddButtonWidth-BuyButtonWidth, [UIScreen mainScreen].bounds.size.height-49-KSafeAreaTopNaviHeight-KSafeAreaBottomHeight, AddButtonWidth, 49);
    [CartButton setTitle:@"加入购物车" forState:0];
    CartButton.titleLabel.font=[UIFont fontWithName:@"PingFangSC-Medium" size:16];
    CartButton.backgroundColor=[UIColor colorWithRed:255/255.0 green:169/255.0 blue:93/255.0 alpha:1.0];
    [CartButton setTitleColor:[UIColor whiteColor] forState:0];
    
    CartButton.userInteractionEnabled=YES;
    
    [CartButton addTarget:self action:@selector(AddCartbtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:CartButton];
    
    button1=[UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame=CGRectMake([UIScreen mainScreen].bounds.size.width-BuyButtonWidth, [UIScreen mainScreen].bounds.size.height-49-KSafeAreaTopNaviHeight-KSafeAreaBottomHeight, BuyButtonWidth, 49);
    
    [button1 setTitle:@"立即购买" forState:0];
    button1.titleLabel.font=[UIFont fontWithName:@"PingFangSC-Medium" size:16];
    button1.backgroundColor=[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
    [button1 setTitleColor:[UIColor whiteColor] forState:0];
    
    button1.userInteractionEnabled=YES;
    
    [self.view addSubview:button1];
    
    
    [self initTableView];
    
    
    NSLog(@"===self.good_type====%@====self.status===%@===",self.good_type,self.status);


    [self getDatas];
    
    
    
    
    
    
    
//     _header.YTTimeLabel.hidden=YES;
    
    topView=[[UIView alloc] initWithFrame:CGRectMake(0, 106, [UIScreen mainScreen].bounds.size.width, 64)];
    topView.backgroundColor=[UIColor clearColor];
    
    
    NSLog(@"===88888==%@=8888=%@",self.good_type,self.status);
    
    
    
    
    
    
    
//    [button1 addTarget:self action:@selector(BuyBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tongzhi:) name:@"xuanzeshangping" object:nil];
    
    
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shangpinGr) name:@"shangpinGr" object:nil];
    
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(xiangqingGr) name:@"xiangqingGr" object:nil];

    [KNotificationCenter addObserver:self selector:@selector(getDatas) name:JMSHTLoginSuccessNoti object:Nil];
    //[];

    //读取数组NSArray类型的数据
    
    if ([userDefaultes stringForKey:@"text"].length>0) {

        cell10.GoodsAttribute.text=[userDefaultes stringForKey:@"text"];

        [_tableView reloadData];

    }

    
    self.leftSwipeGestureRecognizer=[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
    self.rightSwipeGestureRecognizer=[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
    
    self.leftSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    self.rightSwipeGestureRecognizer.direction=UISwipeGestureRecognizerDirectionRight;
    
    [self.view addGestureRecognizer:self.leftSwipeGestureRecognizer];
//    [self.view addGestureRecognizer:self.rightSwipeGestureRecognizer];
    
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(TimeStop2:) name:@"TimeStop2" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ShuXingNoKuCun:) name:@"ShuXingNoKuCun" object:nil];
    
    
    
//    [self initNoGoodsUI];
    
    //回显通知
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dismiss:) name:@"dismiss" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moren:) name:@"moren" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tuwenmoren:) name:@"tuwenmoren" object:nil];
    
    
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NowBuyGoToDingDan:) name:@"NowBuyGoToDingDan" object:nil];
    
    
    //属性，购物车已满，跳转购物车，返回时，刷新购物车件数
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ShuXingChangeGoodsDetailCartNumber:) name:@"ShuXingChangeGoodsDetailCartNumber" object:nil];
    
    
    
    //属性加入购物车是否点击
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(GoodsCart:) name:@"GoodsCart" object:nil];
    
    
    //属性点立即购买改变属性值
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(GoToGoPayChangeAttribute:) name:@"GoToGoPayChangeAttribute" object:nil];
    
    //确认订单返回
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(QueRenDingDanBack:) name:@"QueRenDingDanBack" object:nil];
    
    //图文详情修改已选提示
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(TuWenXiangQingChangeAttribute) name:@"TuWenXiangQingChangeAttribute" object:nil];
    
    
    //图文详情修改已选提示
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notification4) name:@"notification4" object:nil];
    
    
    //确认订单返回，显示购物车件数
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(GoodsDetailAndTuWenCartNumber) name:@"GoodsDetailAndTuWenCartNumber" object:nil];
    
    
//    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数组NSArray类型的数据
    self.MoRenString = [userDefaultes stringForKey:@"text"];
    
    
}

-(void)setBottom
{
    if ([self.good_type isEqualToString:@"1"]||[self.good_type isEqualToString:@"8"]) {


        CartButton.enabled=NO;//纯积分不能加入购物车
        CartButton.backgroundColor=[UIColor colorWithRed:226/255.0 green:226/255.0 blue:226/255.0 alpha:1.0];

        [bgImgView1 removeFromSuperview];

        [bgImgView2 removeFromSuperview];

        //创建遮罩层
        bgImgView1 = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-AddButtonWidth-BuyButtonWidth, [UIScreen mainScreen].bounds.size.height-49-KSafeAreaTopNaviHeight, AddButtonWidth,49)];
        bgImgView1.image = [UIImage imageNamed:@"遮造层"];

        // [self.view addSubview:bgImgView1];

        label2=[[UILabel alloc] initWithFrame:CGRectMake(fwidth/4+90+fwidth/25, 25, 50, 30)];
        if ([self.good_type isEqualToString:@"8"]) {
            _header.YTTimeLabel.hidden=YES;
            button1.enabled=YES;
            [button1 addTarget:self action:@selector(BuyBtnClick) forControlEvents:UIControlEventTouchUpInside];

        }else if ([self.status isEqualToString:@"4"]) {

            _header.YTTimeLabel.hidden=NO;
            button1.enabled=YES;
            [button1 addTarget:self action:@selector(BuyBtnClick) forControlEvents:UIControlEventTouchUpInside];

        }else if ([self.status isEqualToString:@"0"]){

            _header.YTTimeLabel.hidden=NO;
            button1.enabled=YES;
            [button1 addTarget:self action:@selector(BuyBtnClick) forControlEvents:UIControlEventTouchUpInside];

        }else if ([self.status isEqualToString:@"6"]){

            _header.YTTimeLabel.hidden=NO;

            button1.enabled=NO;

            button1.backgroundColor=[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];

        }else{

            _header.YTTimeLabel.hidden=YES;
            button1.enabled=YES;
            [button1 addTarget:self action:@selector(BuyBtnClick) forControlEvents:UIControlEventTouchUpInside];
        }


    }else{


        _header.YTTimeLabel.hidden=YES;

        button1.enabled=YES;
        [button1 addTarget:self action:@selector(BuyBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
}

-(void)GoodsDetailAndTuWenCartNumber
{
    
//    countLabel.hidden=NO;
//    RedImgView.hidden = NO;
//    
//    countLabel.text = CartString;
    
    [self ReloadCartNumber];
    
    
}
-(void)ShuXingChangeGoodsDetailCartNumber:(NSNotification *)text
{
    
    [HTTPRequestManager POST:@"getShoppingSum_mob.shtml" NSDictWithString:@{@"sigen":self.sigen} parameters:nil result:^(id responseObj, NSError *error) {
        
        
        NSLog(@"==888888888==%@===",responseObj);
        
        
        if (responseObj) {
            
            
            if ([responseObj[@"status"] isEqualToString:@"10000"]) {
                
                
                CartString = responseObj[@"goods_sum"];
                
                if ([CartString isEqualToString:@"0"]) {
                    
                    
                    countLabel.hidden=YES;
                    RedImgView.hidden = YES;
                    
                }else{
                    
                    countLabel.text = CartString;
                }
                
                
            }
            
            
            
        }else{
            
            
            NSLog(@"error");
            
        }
        
        
    }];
    
}

-(void)notification4
{
    
    [self.view addGestureRecognizer:self.leftSwipeGestureRecognizer];
    [self.view addGestureRecognizer:self.rightSwipeGestureRecognizer];
}

-(void)TuWenXiangQingChangeAttribute
{
    
    NSLog(@"==TuWenXiangQingChangeAttribute==");
    
    
}
-(void)QueRenDingDanBack:(NSNotification *)text
{
    
    NSLog(@"确认订单返回数据=%@",text.userInfo[@"textOne"]);
    
    self.YXZattribute = text.userInfo[@"textOne"];
    
    [_tableView reloadData];
    
    
}
//修改属性时，库存为0，出现红色框

//回显通知
-(void)ShuXingNoKuCun:(NSNotification *)text
{
    
    
    self.TTTTTT = text.userInfo[@"textOne"];
    
    NSLog(@"点击属性框不点确认显示数据===%@",self.TTTTTT);
    
    if([text.userInfo[@"textOne"] isEqualToString:@"0"]){
        
        [self GoodsByNone];
        
    }else{
        
        NoGoods.hidden=YES;
        
        bgImgView.hidden=YES;

        if ([self.good_type isEqualToString:@"1"]||[self.good_type isEqualToString:@"8"]) {
            CartButton.enabled = NO;
            button1.enabled =YES;
        }else
        {

        CartButton.enabled = YES;
        button1.enabled =YES;
        }
    }
    
}

//通知加入购物车是否点击

-(void)GoodsCart:(NSNotification *)text
{
    
    self.CartString = @"100";
    
    self.attribute = @"2";
    
    self.Panduan =@"1";
    
    self.ytString =@"2";
            
            
    NSLog(@"PPPPPPPPPPPPPP");
    
    
}


//回显通知
-(void)NowBuyGoToDingDan:(NSNotification *)text
{
    
    
    
    NSLog(@"==666==sigen====%@",text.userInfo[@"textOne"]);
    NSLog(@"==666==gid====%@",text.userInfo[@"textTwo"]);
    NSLog(@"==666==mid====%@",text.userInfo[@"textThree"]);
    NSLog(@"==666==num====%@",text.userInfo[@"textFour"]);
    NSLog(@"==666==type====%@",text.userInfo[@"textFive"]);
    NSLog(@"==666==exchange====%@",text.userInfo[@"textSix"]);
    NSLog(@"==666==detailId====%@",text.userInfo[@"textSeven"]);
    NSLog(@"==666==NewGoods_Type====%@",text.userInfo[@"textEight"]);
    NSLog(@"==666==NewGoods_Type====%@",text.userInfo[@"textNine"]);
    NSLog(@"==666==NewGoods_Type====%@",text.userInfo[@"textTen"]);
    NSLog(@"===666=NewGoods_Type====%@",text.userInfo[@"textTen1"]);
    NSLog(@"==666==NewGoods_Type====%@",text.userInfo[@"textTen2"]);
    NSLog(@"==666==NewGoods_Type====%@",text.userInfo[@"textTen3"]);

    NSLog(@"==666==text.userInfotextNine==%@",text.userInfo[@"textNine"]);
    
    QueDingDingDanViewController *vc=[[QueDingDingDanViewController alloc] init];
    
    
    if ([text.userInfo[@"textSix"] integerValue]==1 || [text.userInfo[@"textSix"] integerValue]==2) {
        
        self.SendWayType = @"0";
        
    }else if ([text.userInfo[@"textSix"] integerValue]==3 || [text.userInfo[@"textSix"] integerValue]==4){
        
        
        self.SendWayType = @"1";
        
    }
    
    vc.CutLogin = @"";
    
    vc.gid=text.userInfo[@"textTwo"];
    
    vc.sigen=text.userInfo[@"textOne"];
    
    vc.storename=text.userInfo[@"textThree"];
    
    vc.logo=text.userInfo[@"textFour"];
    
    vc.GoodsDetailType=text.userInfo[@"textFive"];
    
    vc.Goods_Type_Switch=text.userInfo[@"textSix"];
    
    vc.SendWayType=text.userInfo[@"textSeven"];
    
    vc.MoneyType=text.userInfo[@"textEight"];
    
    vc.midddd=text.userInfo[@"textNine"];
    
    vc.yunfei=text.userInfo[@"textTen"];
    
    
    vc.exchange = text.userInfo[@"textTen1"];
   
    vc.detailId = @"";
    
    [self.navigationController pushViewController:vc animated:NO];
    
    self.navigationController.navigationBar.hidden=YES;
    
}

-(void)GoToGoPayChangeAttribute:(NSNotification *)text
{
    
    
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];


    NSLog(@"===购买=回显通知=====%@",[userDefaultes stringForKey:@"backshow"]);

    if ([userDefaultes stringForKey:@"backshow"].length>0) {

        cell10.GoodsAttribute.text=[userDefaultes stringForKey:@"backshow"];

        [_tableView reloadData];

    }
}

-(void)tuwenmoren:(NSNotification *)text
{
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    
    if ([userDefaultes stringForKey:@"moren"].length>0) {
        
//        self.YXZattribute = text.userInfo[@"moren"];
        
        self.MoRenString = [userDefaultes stringForKey:@"moren"];
        
        
        NSLog(@"==MoRen==%@",self.MoRenString);
        
        if (self.MoRenString.length > 0) {
            
            [_tableView reloadData];
        }
        
        
        
    }
}

-(void)moren:(NSNotification *)text
{
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];

    if ([userDefaultes stringForKey:@"moren"].length>0) {

        cell10.GoodsAttribute.text=[userDefaultes stringForKey:@"moren"];

        [_tableView reloadData];

    }

}
//回显通知
-(void)dismiss:(NSNotification *)text
{
    
    NSLog(@"====回显通知====");
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];

    if ([userDefaultes stringForKey:@"backshow"].length>0) {

        cell10.GoodsAttribute.text=[userDefaultes stringForKey:@"backshow"];

        [_tableView reloadData];

    }
}
//创建商品已售完
-(void)GoodsByNone
{
    
    self.ShuXingUnable = @"100";
    
    [NoGoods removeFromSuperview];
    
    NoGoods = [[UIView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-KSafeAreaBottomHeight-49-25-KSafeAreaTopNaviHeight, [UIScreen mainScreen].bounds.size.width, 25)];
    
    NoGoods.backgroundColor = [UIColor colorWithRed:255/255.0 green:52/255.0 blue:53/255.0 alpha:1.0];
    
    [self.view addSubview:NoGoods];
    
    UILabel *NoLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, NoGoods.frame.size.width-100, 25)];
    
    if ([_attribute isEqualToString:@"1"]||[self.StockString isEqualToString:@"0"]) {
    
    NoLabel.text = @"商品已售完了~要不要瞧瞧别的~";
    }
    else
    {
        NoLabel.text = @"该组库存为0，要不试试其他规格~";
    }
    NoLabel.textColor = [UIColor whiteColor];
    
    NoLabel.textAlignment= NSTextAlignmentCenter;
    
    NoLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:10];
    
    [NoGoods addSubview:NoLabel];
    
    [bgImgView removeFromSuperview];
    
    //创建遮罩层
    bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-AddButtonWidth-BuyButtonWidth, [UIScreen mainScreen].bounds.size.height-49-KSafeAreaTopNaviHeight-KSafeAreaBottomHeight, AddButtonWidth+BuyButtonWidth,49)];
    bgImgView.image = [UIImage imageNamed:@"遮造层"];
    
    CartButton.enabled = NO;
    button1.enabled =NO;
    
    [self.view addSubview:bgImgView];
    
    
}

//创建商品已下架
-(void)GoodsDownToStore
{
    
    self.ShuXingUnable = @"100";
    
    [NoGoods removeFromSuperview];
    
    NoGoods = [[UIView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-49-25-KSafeAreaTopNaviHeight-KSafeAreaBottomHeight, [UIScreen mainScreen].bounds.size.width, 25)];
    
    NoGoods.backgroundColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0];
    
    [self.view addSubview:NoGoods];
    
    UILabel *NoLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, NoGoods.frame.size.width-100, 25)];
    
    NoLabel.text = @"商品已下架啦~";
    
    NoLabel.textColor = [UIColor whiteColor];
    
    NoLabel.textAlignment= NSTextAlignmentCenter;
    
    NoLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:10];
    
    [NoGoods addSubview:NoLabel];
    
    [bgImgView removeFromSuperview];
    
    //创建遮罩层
    bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-AddButtonWidth-BuyButtonWidth, [UIScreen mainScreen].bounds.size.height-49-KSafeAreaTopNaviHeight-KSafeAreaBottomHeight, AddButtonWidth+BuyButtonWidth,49)];
    bgImgView.image = [UIImage imageNamed:@"遮造层"];
    
    CartButton.enabled = NO;
    button1.enabled =NO;


    [self.view addSubview:bgImgView];
    
}
//查看店铺
-(void)GoToShopBtnClick
{
    
    //移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:@"TimeStop2"];
    
    
    MerchantDetailViewController *vc=[[MerchantDetailViewController alloc] init];
    
//    vc.delegate=self;
    
//    if ([self.Attribute_back isEqualToString:@"1"]) {
//        
//        vc.GetString=@"2";
//        
//    }else if ([self.Attribute_back isEqualToString:@"2"]){
//        
//        vc.GetString=@"3";
//    }else if ([self.Attribute_back isEqualToString:@"3"]){
//        
//        vc.GetString=@"4";
//    }else if ([self.Attribute_back isEqualToString:@"4"]){
//        
//        vc.GetString=@"5";
//    }
    
    vc.BackString = @"333";
    
//    vc.type=@"1";//判断返回界面
    
    for (GoodsDetailModel *model in _datasArrM) {
        vc.mid=model.mid;
        
    }
    
    for (GoodsDetailModel *model in _ArrM) {
        
        vc.coordinates = model.coordinates;
    }
    
    vc.jindu=self.jindu;
    
    vc.weidu=self.weidu;
    
    vc.MapStartAddress = self.MapStartAddress;
    
    
    [self.navigationController pushViewController:vc animated:NO];
    
    self.navigationController.navigationBar.hidden=YES;
    
    
}

-(void)ReloadCartNumber
{
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数组NSArray类型的数据
    self.sigen=[userDefaultes stringForKey:@"sigen"];
    
    [HTTPRequestManager POST:@"getShoppingSum_mob.shtml" NSDictWithString:@{@"sigen":self.sigen} parameters:nil result:^(id responseObj, NSError *error) {
        
        
        NSLog(@"====%@===",responseObj);
        
        
        if (responseObj) {
            
           
            if ([responseObj[@"status"] isEqualToString:@"10000"]) {
                    
                    
                CartString = responseObj[@"goods_sum"];
                    
                if ([CartString isEqualToString:@"0"]) {
                    
                    
                    countLabel.hidden=YES;
                    RedImgView.hidden = YES;
                    
                }else{
                    
                    countLabel.hidden=NO;
                    RedImgView.hidden = NO;
                    
                    countLabel.text = CartString;
                }
                
            }
            
            
            
        }else{
            
            
            NSLog(@"error");
            
        }
        
        
    }];
    
}

-(void)LoginToBackCrat:(NSString *)sigen
{
    
    NSLog(@"邓丽君");
    
    
}
//查看购物车
-(void)GoToCartBtnClick
{
    
    NSLog(@"查看购物车");
    
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数组NSArray类型的数据
    self.sigen=[userDefaultes stringForKey:@"sigen"];
    
    //        NSLog(@">>>>>>%@",self.sigen);
    
    
    if (self.sigen.length==0 || [self.sigen isEqualToString:@""]) {
        
        
        
        ATHLoginViewController *vc=[[ATHLoginViewController alloc] init];
        vc.delegate=self;
        
        vc.backString=@"123";
        
        vc.jindu = self.jindu;
        vc.weidu = self.weidu;
        vc.MapStartAddress = self.MapStartAddress;
        
        
        [self.navigationController pushViewController:vc animated:NO];
        
        self.navigationController.navigationBar.hidden=YES;
        
    }else{
        
        
        BackCartViewController *vc = [[BackCartViewController alloc] init];
        
        vc.sigen=self.sigen;
        
        vc.delegate=self;
        
        vc.jindu = self.jindu;
        
        vc.weidu = self.weidu;
        
        vc.MapStartAddress = self.MapStartAddress;
        
        [self.navigationController pushViewController:vc animated:NO];
        
    }
    
    
    
    
}

//加入购物车
-(void)AddCartbtnClick
{
    
    NSLog(@"加入购物车");
    
    
    self.YYYYYYY = @"1";
    
    if ([self.attribute isEqualToString:@"2"]) {
        
        [self initview];
        [goodsMainview show];
        
    }else{
        
        
        NSLog(@"====正常商品====");
        
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        //读取数组NSArray类型的数据
        self.sigen=[userDefaultes stringForKey:@"sigen"];
        
//        NSLog(@">>>>>>%@",self.sigen);
        
        
        if (self.sigen.length==0 || [self.sigen isEqualToString:@""]) {
            

            
            ATHLoginViewController *vc=[[ATHLoginViewController alloc] init];
            vc.delegate=self;
            
            vc.backString=@"520";
            
            
            [self.navigationController pushViewController:vc animated:NO];
            
            self.navigationController.navigationBar.hidden=YES;
            
        }else{
            
            
            NSLog(@"加入购物车成功!");
            
            NSLog(@"===self.sigen===%@",self.sigen);
            NSLog(@"===self.gid===%@",self.gid);
            NSLog(@"===self.mid===%@",self.mid);
            NSLog(@"===self.good_type===%@",self.NewGoods_Type);
            NSLog(@"===self.detailId===%@",self.detailId);
            NSLog(@"===exchange_type===%@",self.MoneyType);
            
            
            [self JoinCartReauest];
            
            
        }
        
        
    }
    
    
}

-(void)GoodsDetailReloadData:(NSString *)sigen
{
    
    self.sigen = sigen;
    
    [self JoinCartReauest];

}
//购物车结束动画
- (void)animationDidFinish
{
    
    [self.redView removeFromSuperview];
    
     [self.redImg removeFromSuperview];
    
    [UIView animateWithDuration:0.1 animations:^{
        CartView.transform = CGAffineTransformMakeScale(0.8, 0.8);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
            CartView.transform = CGAffineTransformMakeScale(1, 1);
        } completion:^(BOOL finished) {
            
            //加入其它代码
            RedImgView.hidden = NO;
            countLabel.hidden =NO;
            
            if ([CartString isEqualToString:@"0"]) {

                countLabel.hidden=YES;
                RedImgView.hidden = YES;
                
            }else{
                
                countLabel.text = CartString;
            }
            
            
            //发送通知，动画结束，返回按钮可点击
            
            NSNotification *BackNotification = [[NSNotification alloc] initWithName:@"BackNotificationEnd" object:nil userInfo:nil];
            
            [[NSNotificationCenter defaultCenter] postNotification:BackNotification];
            
            
        }];
        
    }];
}

//加入购物车
-(void)JoinCartReauest
{
    
    if (self.detailId.length==0) {
        
        self.detailId=@"";
        
    }
    
    
    NSLog(@"====加入购物车==%@",self.MoneyType);
    
    
    WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
    
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        
        
        
    });
    if ([self.NewGoods_Type isEqualToString:@"1"]||[self.NewGoods_Type isEqualToString:@"8"]) {
        [TrainToast showWithText:@"非法操作" duration:2.0];
        return;
    }
    
    [HTTPRequestManager POST:@"joinShopping_mob.shtml" NSDictWithString:@{@"sigen":self.sigen,@"id":self.gid,@"mid":self.mid,@"pay_number_hidden":@"1",@"good_type":self.NewGoods_Type,@"detailId":self.detailId,@"exchange_type":self.MoneyType} parameters:nil result:^(id responseObj, NSError *error) {
    
    
            NSLog(@"====%@===",responseObj);
    
            if (responseObj) {
    
                for (NSDictionary *dict in responseObj) {
    
//                    NSLog(@"======%@==",dict[@"message"]);
//                    NSLog(@"======%@==",dict[@"status"]);
                    
                    if ([dict[@"status"] isEqualToString:@"10000"]) {
                        
                        
                        [hud dismiss:YES];
                        
//                        [self.view addSubview:self.redView];
                        
                        [self.view addSubview:self.redImg];
                        
                        
//                        [JRToast showWithText:dict[@"message"] duration:1.0f];
                        
                        
                                
//                        [[SMProgressHUD shareInstancetype] showTip:@"加入购物车成功"];
                        
                    
                        CGPoint center = CartView.center;
                        center.x = CartView.frame.size.width ;
                        center.y = CartView.frame.size.height-20;
//                        redView.center = center;
                        
                        
                        //发送通知，动画结束之前，返回按钮不可点击
                        
                        NSNotification *BackNotification = [[NSNotification alloc] initWithName:@"BackNotificationBegin" object:nil userInfo:nil];
                        
                        [[NSNotificationCenter defaultCenter] postNotification:BackNotification];
                        
                        
                        [[ThrowLineTool sharedTool] throwObject:self.redImg from:CartButton.center to:CartView.center height:-300 duration:1.4];
                        
//                        [[ThrowLineTool sharedTool] throwObject:self.redImg from:self.view.center to:CartView.center height:-450 duration:1.4];
                        
                        
                        CartString = dict[@"goods_sum"];
                        
                        
                    }else if([dict[@"status"] isEqualToString:@"10002"]){
                        
                        
                        [hud dismiss:YES];
                        
                        CartString = dict[@"goods_sum"];
                        
                        countLabel.hidden = NO;
                        RedImgView.hidden = NO;
                        
                        alertCon = [UIAlertController alertControllerWithTitle:dict[@"message"] message:nil preferredStyle:UIAlertControllerStyleAlert];
                        [alertCon addAction: [UIAlertAction actionWithTitle: @"确定" style: UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                            
                            
                            
                            BackCartViewController *vc = [[BackCartViewController alloc] init];
                            
                            vc.sigen=self.sigen;
                            
                            vc.delegate=self;
                            
                            vc.jindu = self.jindu;
                            
                            vc.weidu = self.weidu;
                            
                            vc.MapStartAddress = self.MapStartAddress;
                            
                            [self.navigationController pushViewController:vc animated:NO];
                            
                            
                            
                        }]];
                        
                        [self presentViewController: alertCon animated: YES completion: nil];
                        
                        
//                        [JRToast showWithText:dict[@"message"] duration:1.0f];
                        
                        
                    }else if ([dict[@"status"] isEqualToString:@"10004"]){
                        
                        [hud dismiss:YES];
                        
                        [JRToast showWithText:dict[@"message"] duration:1.0f];
                        
                        CartString = dict[@"goods_sum"];
                        
                        countLabel.hidden = NO;
                        RedImgView.hidden = NO;
                        
//                        alertCon = [UIAlertController alertControllerWithTitle:dict[@"message"] message:nil preferredStyle:UIAlertControllerStyleAlert];
//                        [alertCon addAction: [UIAlertAction actionWithTitle: @"确认" style: UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//                            
//                            
//                            
//                        }]];
//                        
//                        [self presentViewController: alertCon animated: YES completion: nil];
                        
                    }else{
                        
                        [hud dismiss:YES];
                        
                        [JRToast showWithText:dict[@"message"] duration:1.0f];
                        
                        CartString = dict[@"goods_sum"];
                        
                        countLabel.hidden = NO;
                        RedImgView.hidden = NO;
                        
//                        alertCon = [UIAlertController alertControllerWithTitle:dict[@"message"] message:nil preferredStyle:UIAlertControllerStyleAlert];
//                        [alertCon addAction: [UIAlertAction actionWithTitle: @"确认" style: UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//                            
//                            
//                            
//                        }]];
//                        
//                        [self presentViewController: alertCon animated: YES completion: nil];
                        
                        
                    }
                    
    
                }
    
            }else{
    
    
                NSLog(@"error");
                
            }
            
            
        }];
    
}
-(void)reloadData1
{
//    [TitleArrM1 removeAllObjects];
//    
//    [ColorArrM2 removeAllObjects];
//    
//    [SizeArrM3 removeAllObjects];
//    
//    [BuLiaoArrM4 removeAllObjects];
//    
//    [StyleArrM5 removeAllObjects];
//    
//    
//    [_datasArrM removeAllObjects];
//    
//    [_ArrM removeAllObjects];
//    
//    [_ImageArrM removeAllObjects];
//    
//    
//    //获取数据
//    [self getDatas];
    
    
    NSLog(@"=====NoGoodsDetailViewController======");
    
//    [NoGoods removeFromSuperview];
//    
//    [bgImgView removeFromSuperview];
    
    NoGoods.hidden=YES;
    bgImgView.hidden=YES;
    
    NoGoodsDetailViewController *vc=[[NoGoodsDetailViewController alloc] init];
    
    
    [self.navigationController pushViewController:vc animated:NO];
    
    self.navigationController.navigationBar.hidden=YES;
    
    
}
- (void)TimeStop2:(NSNotification *)text{
    
    
    NSLog(@"0000000000");
    
    [TitleArrM1 removeAllObjects];
    
    [ColorArrM2 removeAllObjects];
    
    [SizeArrM3 removeAllObjects];
    
    [BuLiaoArrM4 removeAllObjects];
    
    [StyleArrM5 removeAllObjects];
    
    
    [_datasArrM removeAllObjects];
    
    [_ArrM removeAllObjects];
    
    [_ImageArrM removeAllObjects];
    
    
    //获取数据
    [self getDatas];
    
    
//    [_tableView reloadData];
    
}


-(void)shangpinGr
{
    
    
    if ([_YTStatus isEqualToString:@"7"]) {
        
       
        
        [self initNoGoodsUI];
        
    }else{
        
        _tableView.hidden=NO;
        
        _webView.hidden=YES;
        view2.hidden=YES;
        
        //        }
        
        [self getDatas];
        
    }
    
    
    
   
    
}



-(void)xiangqingGr
{
    
    
    if ([_YTStatus isEqualToString:@"7"]) {
        
        
        
        [self initNoGoodsUI];
        
    }else{
        
        [self getDatasyt];
        
    }
    
    
    
    
}


-(void)getDatasyt
{
    
    
    WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
    
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        
    });

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@getMerchantsGoodsDetails_mob.shtml",URL_Str];
    
    NSDictionary *dic = @{@"id":self.gid};//,@"page":@"0",@"currentPageNo":@"1"};
    

    [manager POST:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
        NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];
        
        
        
        
        if (codeKey && content) {
            NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
            
            NSLog(@"xmlStr%@",xmlStr);
            
//            [hud dismiss:YES];
            NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];
            
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            //            NSLog(@"tuwen  = %@",dic);
            view2.hidden=YES;
            
            
          
            
            for (NSDictionary *dict in dic) {
                
                if ([dict[@"status"] isEqualToString:@"10000"]) {
                    
                    for (NSDictionary *dict1 in dict[@"list_goods"]) {
                        
                        
                        self.note=dict1[@"note"];
                        
                        self.TTTType =dict1[@"good_type"];
                        
                        SStatus=dict1[@"status"];
                        
                        //有属性商品取库存total_stock、正常商品取库存stock
                        
                        if ([dict1[@"is_attribute"] isEqualToString:@"2"]) {
                            
                            self.StockString = dict1[@"total_stock"];//判断库存为0，设置遮罩层
                            

                            
                        }else{
                            
                            self.StockString = dict1[@"stock"];//判断库存为0，设置遮罩层
                            
                        }
                        
                    }
                    
                    
                    
                }else{
                    
                    
                    //                   self.gid=[NSString stringWithFormat:@"1"];
                }
                
                
            }
            
        }
        
        [hud dismiss:YES];
        
        [_webView removeFromSuperview];
        
        
        if ([SStatus isEqualToString:@"7"]) {
            
            [self initNoGoodsUI];
            
        }else{
            
            
            [self initWebView];
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        
        [self NoWebSeveice1];
        
    }];
}


-(void)initWebView
{
    
    _tableView.hidden=YES;
    
    view2.hidden=YES;
    
    //先移除
    [goodsMainview removeFromSuperview];
    
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-49-KSafeAreaTopNaviHeight-KSafeAreaBottomHeight)];
    
    //缩放到屏幕大小0
    _webView.scalesPageToFit=YES;
    //
    //        [_webView setScalesPageToFit:YES];
    _webView.delegate = self;
    
    _webView.scrollView.delegate=self;
    
    
    _webView.scrollView.bounces = NO;
    
    NSString *bb = self.note;
    NSLog(@"888888888==%@",bb);
    [_webView loadHTMLString:bb baseURL:nil];
    //        [_webView loadHTMLString:self.note baseURL:nil];
    
    
    [self.view addSubview:_webView];
    
    NSLog(@"====YTYTYT====%ld===",_webView.scrollView.frame.size.height);
    
    
    
    
    if ([self.StockString isEqualToString:@"0"]) {
        
        [self GoodsByNone];
        
    }
    
    _zhiding=[UIButton buttonWithType:UIButtonTypeCustom];
    
    _zhiding.hidden=YES;
    
    _zhiding.frame=CGRectMake(_webView.frame.size.width-44, _webView.frame.size.height-80, 44, 44);
    //        _zhiding.backgroundColor=[UIColor orangeColor];
    [_zhiding setBackgroundImage:[UIImage imageNamed:@"置顶"] forState:0];
    _zhiding.layer.masksToBounds = YES;
    _zhiding.layer.cornerRadius = _zhiding.bounds.size.width*0.5;
    
    
    
    
    [_zhiding addTarget:self action:@selector(gotoYT) forControlEvents:UIControlEventTouchUpInside];
    
    [_webView addSubview:_zhiding];
    
    
    [NoGoods removeFromSuperview];
    
    [bgImgView removeFromSuperview];
    
    if ([self.StockString isEqualToString:@"0"]) {
        
        NSLog(@"()()()()()()()");
        
        [self GoodsByNone];
        
    }else{
        
        if([self.TTTTTT isEqualToString:@"0"]){
            
            [self GoodsByNone];
            
        }else{
            
            NoGoods.hidden=YES;
            
            bgImgView.hidden=YES;
            
            CartButton.enabled = YES;
            button1.enabled =YES;
            
        }
        
    }
    
    
    NSLog(@"*******6666*****%@===%@==%@",self.NewHomeString,self.StockString,SStatus);
    
    if ([self.NewHomeString isEqualToString:@"1"]) {
        
        if ([SStatus isEqualToString:@"1"] && [self.StockString isEqualToString:@"0"]) {
            
            
            [self GoodsByNone];
            
            
        }else if([SStatus isEqualToString:@"1"] && ![self.StockString isEqualToString:@"0"]){
            
            [self GoodsDownToStore];
            
        }else{
            
            
            
        }
        
    }else{
        
        if ([SStatus isEqualToString:@"1"]) {
            
            [self GoodsDownToStore];
        }
        
    }
    
    
    if ([self.TTTType isEqualToString:@"1"]||[self.TTTType isEqualToString:@"8"]) {
        
        
        CartButton.enabled=NO;//纯积分不能加入购物车
        CartButton.backgroundColor=[UIColor colorWithRed:226/255.0 green:226/255.0 blue:226/255.0 alpha:1.0];
        
        [bgImgView1 removeFromSuperview];
        
        [bgImgView2 removeFromSuperview];
        
        //创建遮罩层
        bgImgView2 = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-AddButtonWidth-BuyButtonWidth, [UIScreen mainScreen].bounds.size.height-49-KSafeAreaTopNaviHeight-KSafeAreaBottomHeight, AddButtonWidth,49)];
        bgImgView2.image = [UIImage imageNamed:@"遮造层"];
        
     //   [self.view addSubview:bgImgView2];
        
    }
    
    
    
}
-(void)gotoYT
{
    
    NSLog(@"gotoYT");
    
    //    [self getDatas];
    
    //回到头部
    [_webView.scrollView setContentOffset:CGPointZero animated:YES];
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    
    
    CGFloat offset = webView.scrollView.contentSize.height;
    
    
    NSLog(@"===$$$$$$==%f",offset);
    
    NSLog(@"=============小朋友，叫爸爸");
    //程序会一直调用该方法，所以判断若是第一次加载后就使用我们自己定义的js，此后不在调用JS,否则会出现网页抖动现象
    //    if (!isFirstLoadWeb) {
    //        isFirstLoadWeb = YES;
    //    }else
    //        return;
    //给webview添加一段自定义的javascript
    
    [webView stringByEvaluatingJavaScriptFromString:@"var script = document.createElement('script');"
     "script.type = 'text/javascript';"
     "script.text = \"function myFunction() { "
     
     //     //注意这里的Name为搜索引擎的Name,不同的搜索引擎使用不同的Name
     //     //<input type="text" name="word" maxlength="64" size="20" id="word"/> 百度手机端代码
     //     "var field = document.getElementsByName('word')[0];"
     //
     //     //给变量取值，就是我们通常输入的搜索内容，这里为 code4app.com
     //     "field.value='code4app.com';"
     //
     //     "document.forms[0].submit();"
     
     "var objs = document.getElementsByTagName('img');"
     "for(var i=0;i<objs.length;i++){"
     "var img=objs[i];"
     "img.style.width = '100%';"
     "img.style.height = 'auto'"
     "}"
     "}\";"
     "document.getElementsByTagName('head')[0].appendChild(script);"];
    //开始调用自定义的javascript
    [webView stringByEvaluatingJavaScriptFromString:@"myFunction();"];
    
    //以上内容均参考自互联网，再次分享给互联网
    
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    
    return YES;
}

#pragma  mark - scrollView 代理方法
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGPoint offset = scrollView.contentOffset;
    
    NSInteger index = offset.y / [UIScreen mainScreen].bounds.size.height;
    
    //
    
    
}


//正在滚动中
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //使用偏移量获取当前的页
    NSInteger currentPage = scrollView.contentOffset.y / [UIScreen mainScreen].bounds.size.height;
    
    
    NSLog(@"===888888======%ld",currentPage);
    
    if (currentPage==0) {
        
        
        _zhiding.hidden=YES;
        
    }else{
        
        _zhiding.hidden=NO;
        
    }
    
}

- (void)handleSwipes:(UISwipeGestureRecognizer *)sender
{
    if (sender.direction == UISwipeGestureRecognizerDirectionLeft) {
        
        
//        if ([self.webString isEqualToString:@"100"]) {
//            
//            [self NoWebSeveice];
//            
//        }else{
        
//            [self initWebView];
//        }
        
        [self.view removeGestureRecognizer:self.leftSwipeGestureRecognizer];
        
        [self.view addGestureRecognizer:self.rightSwipeGestureRecognizer];
        
        [self getDatasyt];
        
        NSLog(@"尼玛的, 你在往左边跑啊....");
        
        //创建通知
        NSNotification *notification =[NSNotification notificationWithName:@"xiangzuo" object:nil userInfo:nil];
        //通过通知中心发送通知
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        
    }
    
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
       
        
        

            _tableView.hidden=NO;
        
           _webView.hidden=YES;
           view2.hidden=YES;

        [self.view removeGestureRecognizer:self.rightSwipeGestureRecognizer];
        
        [self.view addGestureRecognizer:self.leftSwipeGestureRecognizer];
        
        [self getDatas];
        NSLog(@"尼玛的, 你在往右边跑啊....");
        
        //创建通知
        NSNotification *notification =[NSNotification notificationWithName:@"xiangyou" object:nil userInfo:nil];
        //通过通知中心发送通知
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        
    }
}

-(void)BuyBtnClick
{

    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数组NSArray类型的数据
    self.sigen=[userDefaultes stringForKey:@"sigen"];
    
    NSLog(@">>>>>>%@",self.sigen);
    
    NSLog(@"=====self.attribute===%@",self.attribute);

    
    
    if ([self.attribute isEqualToString:@"2"]) {

        
                
                _YTView.view1.hidden=YES;
                
                self.YYYYYYY = @"2";
                
                [self initview];
                [goodsMainview show];

    }else{

        if (self.sigen.length==0 || [self.sigen isEqualToString:@""]) {

            ATHLoginViewController *vc=[[ATHLoginViewController alloc] init];

            vc.delegate=self;
            
            vc.backString=@"300";
            
            vc.OOOOOOOOO = @"333";
            
            vc.gid=self.gid;
            
            vc.sigen=self.sigen;
            
            vc.storename=self.storename;
            
            vc.logo=self.logo;
            
            vc.GoodsDetailType=self.SendWayType;
            
            vc.Goods_Type_Switch=self.good_type;
            
            vc.SendWayType=self.SendWayType;
            
            vc.MoneyType=self.MoneyType;
            
            vc.midddd=self.mid;
            
            vc.yunfei=self.yunfei;
            
            vc.exchange =self.exchange2;
            
            vc.Good_status = self.Good_status;
            
            vc.YTStatus = self.YTStatus;
            
            vc.stock = self.stock;
            
            NSLog(@"===登录====self.good_type===%@",self.good_type);
            
            
            [self.navigationController pushViewController:vc animated:NO];
            
            self.navigationController.navigationBar.hidden=YES;
            
        }else{
            
            [self getDatas1];
        }
        
    }
    
    
    
    NSLog(@"++XXXX++++self.NotBuy++++++%@",self.NotBuy);

    
    NSLog(@"点击了购买");
    
}

//同店铺的不能购买
-(void)getDatas1
{
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeCustom];
    [SVProgressHUD showWithStatus:@"请耐心等待..."];
    NSNull *null=[[NSNull alloc] init];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@getConfirmOrderInfo_mob.shtml",URL_Str];
    
    NSLog(@"=====self.sigen====%@========",self.sigen);
    NSLog(@"=====self.mid====%@========",self.mid);
    NSLog(@"=====self.gid====%@========",self.gid);
    NSLog(@"=====self.logo====%@========",self.logo);
    NSLog(@"=====self.storename====%@========",self.storename);
    
    NSDictionary *dic = @{@"sigen":self.sigen,@"mid":self.mid,@"gid":self.gid,@"logo":@"",@"storename":self.storename};
    //logo可能为空报错
    
    [manager POST:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
        NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];
        
        
        if (codeKey && content) {
            NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
            
            //            NSLog(@"xmlStr==%@",xmlStr);
            //菊花消失
            [SVProgressHUD dismiss];
            
            NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];
            
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            NSLog(@"=======商品信息555555555555555555555555555%@",dic);
            view.hidden=YES;
            for (NSDictionary *dict1 in dic) {
                
                
                self.NotBuy=dict1[@"status"];
                
                self.NotBuyMessage=dict1[@"message"];
                
                
                NSString *YTType;
                NSString *YTStatus;
                
                for (NSDictionary *dict2 in dict1[@"list"]) {
                    
                    
                    YTType=dict2[@"good_type"];
                    
                    YTStatus=dict2[@"status"];
                    
                }
                
                if ([self.NotBuy isEqualToString:@"10001"]) {
                    
                    [JRToast showWithText:self.NotBuyMessage duration:3.0f];
                    
                    
                }else if([self.NotBuy isEqualToString:@"10002"]){
                    
                    [JRToast showWithText:self.NotBuyMessage duration:3.0f];
                    
                }else if([self.NotBuy isEqualToString:@"10000"]){
                    
                    if (([self.good_type isEqualToString:@"1"] && [self.Good_status isEqualToString:@"0"]) || ([YTType isEqualToString:@"1"] && [YTStatus isEqualToString:@"0"])) {
                        
                        [JRToast showWithText:@"请等待，限购商品暂未开抢" duration:3.0f];
                        
                        
                    }else if(([self.good_type isEqualToString:@"1"] && [self.Good_status isEqualToString:@"7"]) || ([YTType isEqualToString:@"1"] && [YTStatus isEqualToString:@"7"])) {
                        
                        [JRToast showWithText:@"该商品已结束抢购！" duration:3.0f];
                        
                        
                    }else if(([self.good_type isEqualToString:@"1"] && [self.Good_status isEqualToString:@"6"]) || ([YTType isEqualToString:@"1"] && [YTStatus isEqualToString:@"6"])) {
                        
                        [JRToast showWithText:@"该商品已售完！" duration:3.0f];
                        
                        
                    }else if(([self.good_type isEqualToString:@"1"] && [self.Good_status isEqualToString:@"1"]) || ([YTType isEqualToString:@"1"] && [YTStatus isEqualToString:@"1"])) {
                        
                        [JRToast showWithText:@"该商品已下架！" duration:3.0f];
                        
                        
                    }else if(([self.good_type isEqualToString:@"1"] && [self.Good_status isEqualToString:@"5"]) || ([YTType isEqualToString:@"1"] && [YTStatus isEqualToString:@"5"])) {
                        
                        [JRToast showWithText:@"该商品已删除！" duration:3.0f];
                        
                        
                    }else{
                        
                        if ([self.stock isEqualToString:@"0"]) {
                            
                            [JRToast showWithText:@"库存为0，无法购买" duration:3.0f];
                            
                            
                        }else if([self.YTStatus isEqualToString:@"1"]){
                            
                            [JRToast showWithText:@"该商品已下架！" duration:3.0f];
                            
                        }else{
                            
                            QueDingDingDanViewController *vc=[[QueDingDingDanViewController alloc] init];
                            
                            //    NewAddAddressViewController *vc=[[NewAddAddressViewController alloc] init];
                            
                            NSLog(@"yyyyyyyyy==%@",self.yunfei);
                            
                            vc.gid=self.gid;
                            
                            vc.sigen=self.sigen;
                            
                            vc.storename=self.storename;
                            
                            vc.logo=self.logo;
                            
                            vc.GoodsDetailType=self.SendWayType;
                            
                            vc.Goods_Type_Switch=self.good_type;
                            
                            vc.good_type=self.good_type;
                            vc.SendWayType=self.SendWayType;
                            
                            vc.MoneyType=self.MoneyType;
                            
                            vc.midddd=self.mid;
                            
                            vc.yunfei=self.yunfei;
                            
                            
                            NSLog(@"===1111==&&&&===%@==%@==%@",self.exchange,self.Panduan,self.attribute);
                            
                            if ([self.Panduan integerValue]==2) {
                                vc.attributenum = self.num;
                                vc.exchange = self.exchange;
                                vc.detailId = self.detailId;
                                if (self.detailId.length != 0) {
                                    
                                    [self.navigationController pushViewController:vc animated:NO];
                                    
                                    self.navigationController.navigationBar.hidden=YES;
                                }
                                
                            }else if([self.attribute integerValue]!=2 ){
                                vc.exchange = self.exchange2;
                                
                                NSLog(@"===222222==&&&&===%@",self.exchange2);
                                
                                [self.navigationController pushViewController:vc animated:NO];
                                self.navigationController.navigationBar.hidden=YES;
                                
                            }
                        }
                    }
                }
            }
            
            NSLog(@"++++++self.NotBuy++++++%@",self.NotBuy);
            NSLog(@"++++++self.NotBuyMessage++++++%@",self.NotBuyMessage);
            //            [_tableView reloadData];
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //        [WKProgressHUD popMessage:@"网络请求失败，请检查您的网络设置" inView:self.view duration:1.5 animated:YES];
        
        [self NoWebSeveice];
        
        NSLog(@"%@",error);
    }];
}


- (void)tongzhi:(NSNotification *)text{
    
    
    [goodsMainview dismiss];
    
    _YTView.view1.hidden=YES;
    
    NSLog(@"点击了商品属性");
    self.YYYYYYY = @"1";
    
    [self initview];
    [goodsMainview show];
    
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"xuanzeshangping" object:nil];
    
}

//- (void)dealloc{
//    //移除指定的通知，不然会造成内存泄露
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"xuanzeshangping" object:nil];
//    
//    //Children对象可以添加多个通知
//    //下面的方法是可以移除Children中所有通知
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//}


-(void)initTableView
{
   // _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, -35, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-49-35+5-KSafeAreaBottomHeight) style:UITableViewStyleGrouped];
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, -35, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-50-KSafeAreaBottomHeight-KSafeAreaTopNaviHeight+35) style:UITableViewStyleGrouped];
    _tableView.delegate=self;
    
    _tableView.dataSource=self;
    
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    //    UIView *view1=[[UIView alloc] initWithFrame:self.view.frame];
    //   _tableView.frame=view1.bounds;
    //    self.view=view1;
    //
    //    [view1 addSubview:_tableView];
    
    
    
//    _tableView.backgroundColor=[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];
    
    _tableView.backgroundColor=[UIColor whiteColor];
    
    _tableView.showsVerticalScrollIndicator=NO;
    _tableView.showsHorizontalScrollIndicator=NO;
    
    
    
    [self.view addSubview:_tableView];
    
    
    _tableView.tableHeaderView=_header;
    
    
    _header.userInteractionEnabled=YES;
    
    [_tableView registerNib:[UINib nibWithNibName:@"GoodsDetailCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [_tableView registerNib:[UINib nibWithNibName:@"GoodsAttributeCell" bundle:nil] forCellReuseIdentifier:@"cell1"];
    [_tableView registerNib:[UINib nibWithNibName:@"GoodsAttributeCell2" bundle:nil] forCellReuseIdentifier:@"cell2"];
    [_tableView registerNib:[UINib nibWithNibName:@"GoodsDetailHeaderView" bundle:nil] forHeaderFooterViewReuseIdentifier:@"header"];
    
    [_tableView registerClass:[GoodsDetailAttributeCell class] forCellReuseIdentifier:@"cell3"];
    
    [_tableView registerClass:[UpLookCell class] forCellReuseIdentifier:@"UpLook"];
    
    
    _refresh=[[DJRefresh alloc] initWithScrollView:_tableView delegate:self];
    _refresh.topEnabled=YES;//下拉刷新
    _refresh.bottomEnabled=NO;//上拉加载
    
    refreshFooterView = [[MJRefreshFooterView alloc] initWithScrollView:_tableView];
    refreshFooterView.delegate = self;
    
    [refreshFooterView endRefreshing];
}



-(void)NoWebSeveice
{
    
    view=[[UIView alloc] initWithFrame:CGRectMake(0, -35, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    
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
    
    
    UILabel *label3=[[UILabel alloc] initWithFrame:CGRectMake(100, 210, view.frame.size.width-200, 20)];
    
    label3.text=@"请检查你的网络";
    
    label3.textAlignment=NSTextAlignmentCenter;
    
    label3.font=[UIFont fontWithName:@"PingFangSC-Medium" size:12];
    
    label3.textColor=[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    
    [view addSubview:label3];
    
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    
    button.frame=CGRectMake(100, 250, view.frame.size.width-200, 50);
    
    [button setTitle:@"重新加载" forState:0];
    button.titleLabel.font=[UIFont fontWithName:@"PingFangSC-Medium" size:12];
    [button setTitleColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0] forState:0];
    
    [view addSubview:button];
    
    [button addTarget:self action:@selector(loadData) forControlEvents:UIControlEventTouchUpInside];
    
}


-(void)NoWebSeveice1
{
    
    view2=[[UIView alloc] initWithFrame:CGRectMake(0, -35, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    
    view2.backgroundColor=[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];
    
    [self.view addSubview:view2];
    
    
    UIImageView *image=[[UIImageView alloc] initWithFrame:CGRectMake((view2.frame.size.width-82)/2, 100, 82, 68)];
    
    image.image=[UIImage imageNamed:@"网络连接失败"];
    
    [view2 addSubview:image];
    
    
    UILabel *label1=[[UILabel alloc] initWithFrame:CGRectMake(100, 180, view2.frame.size.width-200, 20)];
    
    label1.text=@"网络连接失败";
    
    label1.textAlignment=NSTextAlignmentCenter;
    
    label1.font=[UIFont fontWithName:@"PingFangSC-Medium" size:15];
    
    label1.textColor=[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    
    [view2 addSubview:label1];
    
    
    UILabel *label3=[[UILabel alloc] initWithFrame:CGRectMake(100, 210, view2.frame.size.width-200, 20)];
    
    label3.text=@"请检查你的网络";
    
    label3.textAlignment=NSTextAlignmentCenter;
    
    label3.font=[UIFont fontWithName:@"PingFangSC-Medium" size:12];
    
    label3.textColor=[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    
    [view2 addSubview:label3];
    
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    
    button.frame=CGRectMake(100, 250, view2.frame.size.width-200, 50);
    
    [button setTitle:@"重新加载" forState:0];
    button.titleLabel.font=[UIFont fontWithName:@"PingFangSC-Medium" size:12];
    [button setTitleColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0] forState:0];
    
    [view2 addSubview:button];
    
    [button addTarget:self action:@selector(loadData1) forControlEvents:UIControlEventTouchUpInside];
    
}


//获取商品详情数据
-(void)getDatas
{
    
    WKProgressHUD *hud;
    
    if ([self.JuHuaShow isEqualToString:@"100"]) {
        
        
    }else{
        
        
        hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
        
        dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
        dispatch_after(time, dispatch_get_main_queue(), ^{
            
        });
        
        
    }
    
    
    
    //    创建菊花
//    WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
    
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数组NSArray类型的数据
    self.sigen=[userDefaultes stringForKey:@"sigen"];
    
    if (self.sigen.length==0) {
        
        self.sigen = @"";
        
    }
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@getMerchantsGoodsDetails_mob.shtml",URL_Str];
    
    NSDictionary *dic = @{@"sigen":self.sigen,@"id":self.gid};
    YLog(@"%@,%@",self.sigen,self.gid);
    //    NSDictionary *dic=nil;
    
    [manager POST:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
        NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];
        
        
        if (codeKey && content) {
            NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
            
                        NSLog(@"=====商品详情xmlStr%@",xmlStr);
            //菊花消失

            NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];
            
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            NSLog(@"=====商品详情：%@",dic);

            view.hidden=YES;
            for (NSDictionary *dict1 in dic) {
                NSLog(@"dict1=%@",dict1);
                self.shouCangStr=[NSString stringWithFormat:@"%@",dict1[@"is_status"]];
                self.String=dict1[@"status"];
                
                //进入商品详情显示购物车数量
                if ([dict1[@"goods_sum"] isEqualToString:@""]) {
                    
                    countLabel.hidden =YES;
                    RedImgView.hidden = YES;
                    
                }else{
                    
                    RedImgView.hidden = NO;
                    countLabel.hidden =NO;
                    
                    if ([dict1[@"goods_sum"] isEqualToString:@"0"]) {
                        
                        
                        countLabel.hidden=YES;
                        RedImgView.hidden = YES;
                        
                    }else{
                        
                        countLabel.text = dict1[@"goods_sum"];
                    }
//                    countLabel.text = dict1[@"goods_sum"];
                    
                }
                
                
                for (NSDictionary *dict2 in dict1[@"list_goods"]) {
                    GoodsDetailModel *model=[[GoodsDetailModel alloc] init];
                    NSLog(@"dict2=%@",dict2);
                    //                    GoodsDetailImageModel *model1=[[GoodsDetailImageModel alloc] init];
                    model.is_attribute = dict2[@"is_attribute"];//商品属性判断
                    _attribute = dict2[@"is_attribute"];
                    
                    self.YTAttribute=dict2[@"is_attribute"];
                    
                    _count = dict2[@"count"];
                    model.amount=dict2[@"amount"];
                    model.freight=dict2[@"freight"];
                    model.id=dict2[@"id"];
                    model.integral=dict2[@"integral"];
                    model.name=dict2[@"name"];
                    model.pay_integer=dict2[@"pay_integer"];
                    model.pay_maney=dict2[@"pay_maney"];
                    model.scopeimg=dict2[@"scopeimg"];
//                    model.storename = dict2[@"storename"];
                    [_redImg sd_setImageWithURL:[NSURL URLWithString:dict2[@"scopeimg"]] placeholderImage:[UIImage imageNamed:@"default_image"] options:SDWebImageProgressiveDownload];
                    
                    model.coordinates = dict2[@"coordinates"];
                    
                    self.note=dict2[@"note"];
                    
                    NSNull *null=[[NSNull alloc] init];
                    
                    if ([dict2[@"integral_type"] isEqual:null]) {
                        
                        self.integral_type=@"0";
                        
                    }else{
                        
                        self.integral_type=dict2[@"integral_type"];
                    }
                    
                    
                    ImageString = dict2[@"scopeimg"];
                    MoneyString = dict2[@"pay_maney"];
                    IntergelString = dict2[@"pay_integer"];
                    //                    StockString = dict2[@"stock"];
                    
                    self.ytString=dict2[@"is_attribute"];
                    
                    if (![self.ytString isEqualToString:@"2"]) {
                        
                        self.xuanze=@"10000";
                        
                    }

                    
                    NSLog(@"===========freight====%@=====%@=======%@",dict2[@"coordinates"],dict2[@"status"],dict2[@"status"]);
                    
                    
                    
                    model.tname=dict2[@"tname"];
                    model.pice=dict2[@"pice"];
                    model.mid=dict2[@"mid"];
                    
                    self.mid=dict2[@"mid"];
                    
                    model.type=dict2[@"type"];
                    model.good_type=dict2[@"good_type"];
                    model.status=dict2[@"status"];
                    
                    self.NewGoods_Type = dict2[@"good_type"];
                    self.good_type=self.NewGoods_Type;
                    self.YTGood_type=dict2[@"good_type"];
                    self.YTStatus=dict2[@"status"];
                    
                    model.min_price = dict2[@"min_price"];
                    model.max_price = dict2[@"max_price"];
                    
                    [self setBottom];
//                    self.StockString = dict2[@"stock"];//判断库存为0，设置遮罩层
                    
                    if ([dict2[@"is_attribute"] isEqualToString:@"2"]) {
                        
                        self.StockString = dict2[@"total_stock"];//判断库存为0，设置遮罩层
                        

                        
                    }else{
                        
                        self.stock=dict2[@"stock"];
                        
                        self.StockString = dict2[@"stock"];//判断库存为0，设置遮罩层
                        
                    }
                    
                    NSLog(@"===is_attribute====%@==total_stock===%@==stock==%@===id==%@",dict2[@"is_attribute"],dict2[@"total_stock"],dict2[@"stock"],dict2[@"id"]);
                    
                    
                    //                    self.stock=dict2[@"stock"];
                    
                    self.Good_status=dict2[@"status"];
                    
                    Goods_Type=dict2[@"good_type"];
                    Goods_Status=dict2[@"status"];
                    
//                    NSNull *null=[[NSNull alloc] init];
                    
                    if (![dict2[@"current_time_stamp"] isEqual:null] && ![dict2[@"end_time_str"] isEqual:null]) {
                        
                        self.startString=dict2[@"current_time_stamp"];
                        self.endString=dict2[@"end_time_str"];
                        model.start_time_str=dict2[@"current_time_stamp"];
                        model.end_time_str=dict2[@"end_time_str"];
                        
                    }
                    
                    
                    //
                    //                    NSLog(@"model.id=====%@",dict2[@"id"]);
                    //                    NSLog(@"self.gid=====%@",self.gid);
                    
                    self.SendWayType=dict2[@"type"];//配送方式
                    self.exchange2 = dict2[@"exchange"];
                    NSString *picpath=[NSString stringWithFormat:@"%@",dict2[@"picpath"]];
                    NSString *picpath2=[NSString stringWithFormat:@"%@",dict2[@"picpath2"]];
                    NSString *picpath3=[NSString stringWithFormat:@"%@",dict2[@"picpath3"]];
                    NSString *picpath4=[NSString stringWithFormat:@"%@",dict2[@"picpath4"]];
                    NSString *scop=[NSString stringWithFormat:@"%@",dict2[@"scopeimg"]];

                    YLog(@"scop=%@,pic1=%@,pic2=%@,pic3=%@,pic4=%@,",scop,picpath,picpath2,picpath3,picpath4);

                    [_datasArrM addObject:model];
                    
                    
                    NSNull *null2=[[NSNull alloc] init];
                    NSLog(@"syadate=%@",[dict2[@"syadate"] substringToIndex:10]);
                    [_ImageArrM removeAllObjects];
                    if ([XLDateTools compareDate:[dict2[@"syadate"] substringToIndex:10] AndDate:@"2017-09-20"]!=XLComparedResult_Ascending) {
                        if (!([scop isEqualToString:@""]||[scop isEqualToString:@"/cglib/goods/img/img-plus.png"])) {
                            if (![_ImageArrM containsObject:scop]) {
                                [_ImageArrM addObject:scop];
                            }
                        }
                    }
                    
                    if ([picpath isEqualToString:@""]||[picpath isEqualToString:@"/cglib/goods/img/img-plus.png"]) {
                        
                    }else{

                            
                            [_ImageArrM addObject:picpath];

                    }
                    
                    if ([picpath2 isEqualToString:@""]||[picpath2 isEqualToString:@"/cglib/goods/img/img-plus.png"]) {
                        
                        
                    }else{
                        

                            
                            [_ImageArrM addObject:picpath2];

                        
                    }
                    
                    if ([picpath3 isEqualToString:@""]||[picpath3 isEqualToString:@"/cglib/goods/img/img-plus.png"]) {
                        
                    }else{
                        

                            
                            [_ImageArrM addObject:picpath3];

                        
                    }
                    
                    if ([picpath4 isEqualToString:@""] || picpath4.length==0||[picpath4 isEqualToString:@"/cglib/goods/img/img-plus.png"]) {
                        
                    }else{
                        

                            
                            [_ImageArrM addObject:picpath4];

                        
                    }
                    
                    
                }
                
                NSLog(@"======Count===%ld",_ImageArrM.count);
                
                GoodsDetailModel *model=[[GoodsDetailModel alloc] init];
                
                
                
                
                model.city=dict1[@"merchants_map"][@"city"];
                model.coordinates=dict1[@"merchants_map"][@"coordinates"];
                model.county=dict1[@"merchants_map"][@"county"];
                model.logo=dict1[@"merchants_map"][@"logo"];
                model.mobile=dict1[@"merchants_map"][@"mobile"];
                model.province=dict1[@"merchants_map"][@"province"];
                model.storename=dict1[@"merchants_map"][@"storename"];
                
                self.logo=[NSString stringWithFormat:@"%@",dict1[@"merchants_map"][@"logo"]];
                self.storename=[NSString stringWithFormat:@"%@",dict1[@"merchants_map"][@"storename"]];
                
                model.start_time_str=self.startString;
                model.end_time_str=self.endString;
                
                [_ArrM addObject:model];
            }
            
            
            
            if ([self.good_type isEqualToString:@"1"]) {
                
                _header.YTTimeLabel.hidden=NO;
                
                //倒计时
//                [self DaoJiTime];
            }
            
            //只有等数据加载完毕，才能点击
            if ([self.String isEqualToString:@"10000"]) {
                
                [rightButton addTarget:self action:@selector(ImageDetailBtnClick) forControlEvents:UIControlEventTouchUpInside];
                
                
            }
            if([_attribute intValue]==2){
                [self getGoodsAttributeDatas];
            }
            
            
            
            
        }
        
        
        
        
        if ([self.YTStatus isEqualToString:@"7"]) {
            
            
            NSLog(@"====&&&&&&&&====");
            
//            NoGoodsDetailViewController *vc=[[NoGoodsDetailViewController alloc] init];
//            
//            
//            [self.navigationController pushViewController:VC animated:NO];
//            
//            self.navigationController.navigationBar.hidden=YES;
            
            
            _header.YTTimeLabel.hidden=YES;
            
            button1.enabled=NO;
            
            button1.backgroundColor=[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];
            
            [self initNoGoodsUI];
            
            
        }else if([self.YTStatus isEqualToString:@"6"]){
            
            _header.YTTimeLabel.hidden=NO;
            
            button1.enabled=NO;
            
//            [hud dismiss:YES];
            button1.backgroundColor=[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];
            
            [hud dismiss:YES];
            
            [_tableView reloadData];
            
        }else{
            
            
            NSLog(@"kkkkkkkkkkkk=%@",self.exchange2);
            
            
            _header.YTTimeLabel.hidden=YES;
            
            button1.enabled=YES;
            
            [hud dismiss:YES];
            
            
            [_tableView reloadData];
            
            
        }
        
        
        NSLog(@"===库存为0，设置遮罩层===%@",self.TTTTTT);
        
        NSLog(@"===库存为0，设置遮罩层==self.StockString==%@",self.StockString);
        
        
        [NoGoods removeFromSuperview];
        
        [bgImgView removeFromSuperview];
        
        
        NSLog(@"====self.CartString=====%@==self.NewHomeString==%@==self.status=%@",self.CartString,self.NewHomeString,self.status);
        
        
        
        
        
        //库存为0，设置遮罩层
        if ([self.StockString isEqualToString:@"0"]) {
            
            NSLog(@"11111(((((((((((((((((((((((((((((");
            
            [self GoodsByNone];
            
//            [self GoodsDownToStore];
            
        }else{
            
            
            if ([self.TTTTTT isEqualToString:@"0"]) {
                
                [self GoodsByNone];
                NSLog(@"22222(((((((((((((((((((((((((((((");
                NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
                
                if ([userDefaultes stringForKey:@"backshow"].length>0) {

                    cell10.GoodsAttribute.text=[userDefaultes stringForKey:@"backshow"];

                    [_tableView reloadData];

                }

            }else{
                
                NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];

                if ([userDefaultes stringForKey:@"backshow"].length>0) {

                    cell10.GoodsAttribute.text=[userDefaultes stringForKey:@"backshow"];

                    [_tableView reloadData];
                }

            }
            
            
//            [hud dismiss:YES];
            
        }
        
        NSLog(@"*******88888*****%@===%@==%@",self.NewHomeString,self.StockString,self.YTStatus);
        
        if ([self.NewHomeString isEqualToString:@"1"]) {
            
            if ([self.YTStatus isEqualToString:@"1"] && [self.StockString isEqualToString:@"0"]) {
                NSLog(@"333333(((((((((((((((((((((((((((((");
                [self GoodsByNone];
                
            }else if([self.YTStatus isEqualToString:@"1"] && ![self.StockString isEqualToString:@"0"]){
                
                
                [self GoodsDownToStore];
                
            }else{
                
//                [self GoodsByNone];
                
            }
            
        }else if([self.NewHomeString isEqualToString:@"2"]){
            
            if ([self.YTStatus isEqualToString:@"1"]) {
                NSLog(@"44444(((((((((((((((((((((((((((((");
                [self GoodsDownToStore];
            }
            
        }else{
            
            if ([self.YTStatus isEqualToString:@"1"]) {
                NSLog(@"44444(((((((((((((((((((((((((((((");
                [self GoodsDownToStore];
            }
        }

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
//        [WKProgressHUD popMessage:@"网络请求失败，请检查您的网络设置" inView:self.view duration:1.5 animated:YES];
        
        [hud dismiss:YES];
        
        [self NoWebSeveice];
        
        self.webString=@"100";
        
        NSLog(@"%@",error);
    }];
    
}
-(void)loadData
{
    view.hidden=YES;
    
    WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
    
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        [hud dismiss:YES];
    });
    
    [self getDatas];
    
    
}

-(void)loadData1
{
    view.hidden=YES;
    
    
    WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
    
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        [hud dismiss:YES];
    });
    
    [self getDatasyt];
    [self getDatas];
    
}

//获取属性数据
-(void)getGoodsAttributeDatas
{
    
    
//    WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
//    
//    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
//    dispatch_after(time, dispatch_get_main_queue(), ^{
//        
//    });
    
    [TitleArrM1 removeAllObjects];
    [ColorArrM2 removeAllObjects];
    [SizeArrM3 removeAllObjects];
    [BuLiaoArrM4 removeAllObjects];
    [StyleArrM5 removeAllObjects];
    
    //    创建菊花
//    WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@getGoodAttributeInfo_mob.shtml",URL_Str];
    //saveUserExchange_mob.shtml
    
    
    NSDictionary *dic = @{@"gid":self.gid};
    
    
    [manager POST:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
        NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];
        
        
        
        if (codeKey && content) {
            NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
            
                        NSLog(@"===6666=xmlStr%@",xmlStr);
            
            //菊花消失
//            [hud dismiss:YES];
            
            NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];
            
            
            NSDictionary *dic2 = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            
            NSLog(@"=//获取属性数据==%@",dic2);
            
            NSLog(@"#########==%@",dic2[@"totalStock"]);
            
            StockString =dic2[@"totalStock"];
            
            view.hidden=YES;
            if ([dic2[@"status"] isEqualToString:@"10000"]) {
                
                for (NSDictionary *dict in dic2[@"list"]) {
                    
                    
                    NSLog(@"=====bigName===%@",dict[@"bigName"]);
                    
                    //添加标题
                    [TitleArrM1 addObject:dict[@"bigName"]];
                    
                    if ([dict[@"bigKey"] isEqualToString:@"a"]) {
                        
                        
                        for (NSDictionary *dict1 in dict[@"smallClassList"]) {
                            
                            NSLog(@"==1====smallName==%@",dict1[@"smallName"]);
                            
                            GoodsAttributeModel *model=[[GoodsAttributeModel alloc] init];
                            
                            model.smallName=dict1[@"smallName"];
                            model.mallId=dict1[@"smallId"];
                            
                            [ColorArrM2 addObject:model];
                            
                            
                        }
                    }else if([dict[@"bigKey"] isEqualToString:@"b"]){
                        
                        
                        for (NSDictionary *dict1 in dict[@"smallClassList"]) {
                            
                            NSLog(@">>>2>>>>smallName>>%@",dict1[@"smallName"]);
                            
                            GoodsAttributeModel *model=[[GoodsAttributeModel alloc] init];
                            
                            model.smallName=dict1[@"smallName"];
                            model.mallId=dict1[@"smallId"];
                            
                            [SizeArrM3 addObject:model];
                        }
                    }else if([dict[@"bigKey"] isEqualToString:@"c"]){
                        
                        
                        for (NSDictionary *dict1 in dict[@"smallClassList"]) {
                            
                            NSLog(@">>>>3>>>smallName>>%@",dict1[@"smallName"]);
                            
                            GoodsAttributeModel *model=[[GoodsAttributeModel alloc] init];
                            
                            model.smallName=dict1[@"smallName"];
                            model.mallId=dict1[@"smallId"];
                            
                            [BuLiaoArrM4 addObject:model];
                            
                        }
                    }else if([dict[@"bigKey"] isEqualToString:@"d"]){
                        
                        
                        for (NSDictionary *dict1 in dict[@"smallClassList"]) {
                            
                            NSLog(@">>>>>4>>smallName>>%@",dict1[@"smallName"]);
                            
                            GoodsAttributeModel *model=[[GoodsAttributeModel alloc] init];
                            
                            model.smallName=dict1[@"smallName"];
                            model.mallId=dict1[@"smallId"];
                            
                            [StyleArrM5 addObject:model];
                            
                        }
                    }
                }
                
                
                if (SizeArrM3.count==1) {
                    //缓存尺码
                    
                    for (GoodsAttributeModel *model in SizeArrM3) {
                        
                        [UserMessageManager GoodsSize:[NSString stringWithFormat:@"%@",model.mallId]];
                        [UserMessageManager GoodsSize1:[NSString stringWithFormat:@"%@",model.mallId]];
                    }
                    
                    
                }
                
                if (ColorArrM2.count==1) {
                    //缓存颜色
                    for (GoodsAttributeModel *model in ColorArrM2) {
                        
                        [UserMessageManager GoodsColor:[NSString stringWithFormat:@"%@",model.mallId]];
                        [UserMessageManager GoodsColor1:[NSString stringWithFormat:@"%@",model.mallId]];
                    }
                    
                    
                }
                
                
                if (BuLiaoArrM4.count==1) {
                    
                    //缓存布料
                    
                    for (GoodsAttributeModel *model in BuLiaoArrM4) {
                        
                        [UserMessageManager GoodsStyle:[NSString stringWithFormat:@"%@",model.mallId]];
                        [UserMessageManager GoodsStyle1:[NSString stringWithFormat:@"%@",model.mallId]];
                        
                    }
                    
                }
                
                if (StyleArrM5.count==1) {
                    
                    //缓存风格
                    
                    for (GoodsAttributeModel *model in StyleArrM5) {
                        
                        
                        [UserMessageManager GoodsMianLiao:[NSString stringWithFormat:@"%@",model.mallId]];
                        [UserMessageManager GoodsMianLiao1:[NSString stringWithFormat:@"%@",model.mallId]];
                    }
                    
                }
                
                
                
                Titlearr5=TitleArrM1;
                colorarr=SizeArrM3;
                sizearr=ColorArrM2;
                BuLiaoarr3=BuLiaoArrM4;
                Stylearr4=StyleArrM5;
                
                
                NSLog(@"===BuLiaoArrM4.count====%ld",BuLiaoArrM4.count);
                NSLog(@"===ColorArrM2====%ld",ColorArrM2.count);
                NSLog(@"==SizeArrM3====%ld",SizeArrM3.count);
                NSLog(@"===StyleArrM5====%ld",StyleArrM5.count);
                
            }else if ([dic2[@"status"] isEqualToString:@"10005"]){
                
                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:dic2[@"message"] message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                
                [alert show];
                
            }else if ([dic2[@"status"] isEqualToString:@"10010"]){
                
                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:dic2[@"message"] message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                
                [alert show];
            }
            
            
//            [hud dismiss:YES];
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
 //       [WKProgressHUD popMessage:@"网络请求失败，请检查您的网络设置" inView:self.view duration:1.5 animated:YES];
        
        [self NoWebSeveice];
        
        NSLog(@"%@",error);
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==1) {
        return 40;
    }else if ([_attribute integerValue] == 2 && indexPath.row==0) {
        return 50;
    }else{
        return 0;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 20;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return [UIScreen mainScreen].bounds.size.height*4/5;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *YTstring;
    
     NSLog(@"=====%@===++++==%ld",self.YXZattribute,self.YXZattribute.length);
    
    if(indexPath.row == 0){
        
        if ([_attribute integerValue] == 2) {
            
            cell10=[tableView dequeueReusableCellWithIdentifier:@"cell3"];
            cell10.selectionStyle = UITableViewCellSelectionStyleNone;
            //    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            NSLog(@"*******11111111");
            
            if ([self.Panduan integerValue]== 2) {
                
                
               
                NSLog(@"*******222222222");
                
                if (self.YXZattribute.length==0) {
                    
                    NSLog(@"*******33333333");
                    
                   NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
                    //读取数组NSArray类型的数据
                    if([userDefaultes stringForKey:@"tuwen"].length==0)
                    {
                        
                        YTstring = [userDefaultes stringForKey:@"text"];
                        
                    }else{
                        
                        YTstring = [userDefaultes stringForKey:@"tuwen"];
                    }
                   
                    
                    cell10.GoodsAttribute.text=YTstring;

                }else{
                    
                    NSLog(@"*******444444444");
                    
                     self.xuanze=@"10000";
                    
                    YTstring = self.YXZattribute;
                    
                    cell10.GoodsAttribute.text=YTstring;
                    
                }
                NSLog(@"*******555555555");
                return cell10;
                
            }else{
                
                NSLog(@"*******666666666====%@",self.MoRenString);
                
                if (self.MoRenString.length==0) {
                    
                    NSLog(@"*******7777777777");
                    return cell10;
                    
                }else{
                    
                    NSLog(@"*******88888888888");
                 //   cell10.GoodsAttribute.text=self.MoRenString;
                    
                    return cell10;
                }
                
            }
    
        }else{
            
            GoodsAttributeCell2 *cell=[tableView dequeueReusableCellWithIdentifier:@"cell2"];
            return cell;
        }
        
        
    }

    
    //上拉查看图文详情
    UpLookCell *Upcell = [tableView dequeueReusableCellWithIdentifier:@"UpLook"];
    
    Upcell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return Upcell;
    
    
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    _header=[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
    
    for (GoodsDetailModel *model in _ArrM) {
        
        _header.StoreNameLabel.text = model.storename;
        
    }
    
    
    for (GoodsDetailModel *model in _datasArrM) {
        _header.GoodsDetailNameLabel.text=model.name;
        
        
        if ([self.Panduan integerValue] == 2) {
            
            _header.AmountLabel.text=[NSString stringWithFormat:@"总销量%@件",self.amount];
            //判断如果最高价和最低价相同，显示一个价格
            if ([model.min_price floatValue] == [model.max_price floatValue]) {
                
                NSString *oldPrice = [NSString stringWithFormat:@"   %.02f ",[model.min_price floatValue]];
                
//                _header.Pricenum.text = [NSString stringWithFormat:@"   %.02f ",[model.min_price floatValue]];
                
                NSUInteger length = [oldPrice length];
                
                NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:oldPrice];
                [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, length)];
                [attri addAttribute:NSStrikethroughColorAttributeName value:[UIColor colorWithRed:170/255.0 green:170/255.0 blue:170/255.0 alpha:1.0] range:NSMakeRange(0, length)];
                [_header.Pricenum setAttributedText:attri];
                
                
            }else{
//                _header.Pricenum.text = [NSString stringWithFormat:@"%.02f   %.02f",[model.min_price floatValue] ,[model.max_price floatValue]];
                
                
                NSString *oldPrice = [NSString stringWithFormat:@"%.02f   %.02f",[model.min_price floatValue] ,[model.max_price floatValue]];
                
                
                
                NSUInteger length = [oldPrice length];
                
                NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:oldPrice];
                [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, length)];
                [attri addAttribute:NSStrikethroughColorAttributeName value:[UIColor colorWithRed:170/255.0 green:170/255.0 blue:170/255.0 alpha:1.0] range:NSMakeRange(0, length)];
                [_header.Pricenum setAttributedText:attri];
                
            }
            
            
            
        }else{
            
            _header.AmountLabel.text=[NSString stringWithFormat:@"总销量%@件",model.amount];
            
            if ([self.attribute integerValue] == 2) {
                
                //判断如果最高价和最低价相同，显示一个价格
                if ([model.min_price floatValue] == [model.max_price floatValue]) {
//                    _header.Pricenum.text = [NSString stringWithFormat:@"   %.02f ",[model.min_price floatValue]];
                    
                    NSString *oldPrice = [NSString stringWithFormat:@"   %.02f ",[model.min_price floatValue]];
                    
                    
                    
                    NSUInteger length = [oldPrice length];
                    
                    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:oldPrice];
                    [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, length)];
                    [attri addAttribute:NSStrikethroughColorAttributeName value:[UIColor colorWithRed:170/255.0 green:170/255.0 blue:170/255.0 alpha:1.0] range:NSMakeRange(0, length)];
                    [_header.Pricenum setAttributedText:attri];
                    
                }else{
//                    _header.Pricenum.text = [NSString stringWithFormat:@"%.02f   %.02f",[model.min_price floatValue] ,[model.max_price floatValue]];
                    
                    
                    NSString *oldPrice = [NSString stringWithFormat:@"%.02f   %.02f",[model.min_price floatValue] ,[model.max_price floatValue]];
                    
                    
                    
                    NSUInteger length = [oldPrice length];
                    
                    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:oldPrice];
                    [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, length)];
                    [attri addAttribute:NSStrikethroughColorAttributeName value:[UIColor colorWithRed:170/255.0 green:170/255.0 blue:170/255.0 alpha:1.0] range:NSMakeRange(0, length)];
                    [_header.Pricenum setAttributedText:attri];
                    
                    
                }
                
                
            }else{
                
                
//                _header.Pricenum.text = [NSString stringWithFormat:@"  %.02f元",[model.pice floatValue]];
                
                NSString *oldPrice = [NSString stringWithFormat:@"  %.02f元",[model.pice floatValue]];
                
                
                
                NSUInteger length = [oldPrice length];
                
                NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:oldPrice];
                [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, length)];
                [attri addAttribute:NSStrikethroughColorAttributeName value:[UIColor colorWithRed:170/255.0 green:170/255.0 blue:170/255.0 alpha:1.0] range:NSMakeRange(0, length)];
                [_header.Pricenum setAttributedText:attri];
                
                
            }
            
        }
        
        

        

            
            if ([self.Panduan integerValue] == 2) {

                _header.NowPriceLabel.text=[NSString stringWithPrice:self.pay_money andInterger:self.pay_integral];

            }else{

                _header.NowPriceLabel.text=[NSString stringWithPrice:model.pay_maney andInterger:model.pay_integer];


            }
            
            NSString *stringForColor = @"积分";
            
            // 创建对象.
            NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:_header.NowPriceLabel.text];
            //
            NSRange range = [_header.NowPriceLabel.text rangeOfString:stringForColor];
            
            [mAttStri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10] range:range];
            
            _header.NowPriceLabel.attributedText=mAttStri;
            

        
        //进行配送方式的选择
        
        if ([self.exchange integerValue] == 1|| [self.exchange integerValue] == 2) {

            sendWayString=@"快递邮寄";
            
            float number=[model.pay_maney floatValue] + [model.freight floatValue];
            
            NSString *string=[NSString stringWithFormat:@"%.02f",(float)number];
            

                if ([self.Panduan integerValue] == 2) {
                    
                    
                    number=[self.pay_money floatValue] + [self.yunfei floatValue];
                    string=[NSString stringWithFormat:@"%.02f",(float)number];
                    self.PayMoneyLabel.text=[NSString stringWithFormat:@"￥%.02f+%.02f积分",[string floatValue]*[self.num integerValue],[self.pay_integral floatValue]*[self.num integerValue]];
                    
                    Newprice.text=[NSString stringWithFormat:@"￥%.02f+%.02f积分",[string floatValue]*[self.num integerValue],[self.pay_integral floatValue]*[self.num integerValue]];
                    
                    NSLog(@"===33333###=====self.num=%@=self.pay_money=%@",self.num,self.pay_money);
                    
                    NSLog(@"==1919119191119111911====%@",self.PayMoneyLabel.text);
                    if (_delegate && [_delegate respondsToSelector:@selector(setGoodsPrice:setGid:setSigen:setStorename:setLogo:setSendWayType:setGoodsType:setMoneyType:setmid:setYunFei:setPanduan:setNum:setexchange:setdetailId:setexchange2:setYTString:)]) {
                        
                        [_delegate setGoodsPrice:self.PayMoneyLabel.text setGid:self.gid setSigen:self.sigen setStorename:self.storename setLogo:self.logo setSendWayType:self.SendWayType setGoodsType:self.good_type setMoneyType:self.MoneyType setmid:self.mid setYunFei:self.yunfei setPanduan:self.Panduan setNum:self.num setexchange:self.exchange setdetailId:self.detailId setexchange2:self.exchange2 setYTString:self.ytString];
                    }
                    
                }else{
                    
                    self.PayMoneyLabel.text=[NSString stringWithFormat:@"￥%.02f+%.02f积分",[string floatValue],[model.pay_integer floatValue]];
                    
                    Newprice.text=[NSString stringWithFormat:@"￥%.02f+%.02f积分",[string floatValue],[model.pay_integer floatValue]];
                    
                    NSLog(@"==11818181181181181181====%@",self.PayMoneyLabel.text);
                    if (_delegate && [_delegate respondsToSelector:@selector(setGoodsPrice:setGid:setSigen:setStorename:setLogo:setSendWayType:setGoodsType:setMoneyType:setmid:setYunFei:setPanduan:setNum:setexchange:setdetailId:setexchange2:setYTString:)]) {
                        
                        [_delegate setGoodsPrice:self.PayMoneyLabel.text setGid:self.gid setSigen:self.sigen setStorename:self.storename setLogo:self.logo setSendWayType:self.SendWayType setGoodsType:self.good_type setMoneyType:self.MoneyType setmid:self.mid setYunFei:self.yunfei setPanduan:self.Panduan setNum:self.num setexchange:self.exchange setdetailId:self.detailId setexchange2:self.exchange2 setYTString:self.ytString];
                    }
                    
                }

            
        }else{

                //
                //3
                if ([sendWayString isEqualToString:@"快递邮寄"]) {
                    
                    float number=[model.pay_maney floatValue] + [model.freight floatValue];
                    
                    NSString *string=[NSString stringWithFormat:@"%.02f",(float)number];
                    
                    NSLog(@"==string===%@",string);
                    NSLog(@"===model.pay_integer==%@",model.pay_integer);
                    
                    self.MoneyType=@"0";
                    
                    if ([string isEqualToString:@"0.00"]) {
                        if ([self.Panduan integerValue] == 2  ) {
                            self.PayMoneyLabel.text=[NSString stringWithFormat:@"%.02f积分",[self.pay_integral floatValue]*[self.num integerValue]];
                            
                            Newprice.text=[NSString stringWithFormat:@"%.02f积分",[self.pay_integral floatValue]*[self.num integerValue]];
                            
                            NSLog(@"==1313133113113113131131====%@",self.PayMoneyLabel.text);
                            if (_delegate && [_delegate respondsToSelector:@selector(setGoodsPrice:setGid:setSigen:setStorename:setLogo:setSendWayType:setGoodsType:setMoneyType:setmid:setYunFei:setPanduan:setNum:setexchange:setdetailId:setexchange2:setYTString:)]) {
                                
                                [_delegate setGoodsPrice:self.PayMoneyLabel.text setGid:self.gid setSigen:self.sigen setStorename:self.storename setLogo:self.logo setSendWayType:self.SendWayType setGoodsType:self.good_type setMoneyType:self.MoneyType setmid:self.mid setYunFei:self.yunfei setPanduan:self.Panduan setNum:self.num setexchange:self.exchange setdetailId:self.detailId setexchange2:self.exchange2 setYTString:self.ytString];
                            }
                            
                        }else{
                            self.PayMoneyLabel.text=[NSString stringWithFormat:@"%.02f积分",[model.pay_integer floatValue]];
                            
                            Newprice.text=[NSString stringWithFormat:@"%.02f积分",[model.pay_integer floatValue]];
                            
                            NSLog(@"==12121212121212121212121212====%@",self.PayMoneyLabel.text);
                            if (_delegate && [_delegate respondsToSelector:@selector(setGoodsPrice:setGid:setSigen:setStorename:setLogo:setSendWayType:setGoodsType:setMoneyType:setmid:setYunFei:setPanduan:setNum:setexchange:setdetailId:setexchange2:setYTString:)]) {
                                
                                [_delegate setGoodsPrice:self.PayMoneyLabel.text setGid:self.gid setSigen:self.sigen setStorename:self.storename setLogo:self.logo setSendWayType:self.SendWayType setGoodsType:self.good_type setMoneyType:self.MoneyType setmid:self.mid setYunFei:self.yunfei setPanduan:self.Panduan setNum:self.num setexchange:self.exchange setdetailId:self.detailId setexchange2:self.exchange2 setYTString:self.ytString];
                            }
                            
                        }
                        
                        
                    }else if ([model.pay_integer isEqualToString:@"0"] || [model.pay_integer isEqualToString:@"0.00"]){
                        if ([self.Panduan integerValue] == 2  ) {
                            number=[self.pay_money floatValue] + [self.yunfei floatValue];
                            string=[NSString stringWithFormat:@"%.02f",(float)number];
                            self.PayMoneyLabel.text=[NSString stringWithFormat:@"￥%.02f",[string floatValue]*[self.num integerValue]];
                            
                            Newprice.text=[NSString stringWithFormat:@"￥%.02f",[string floatValue]*[self.num integerValue]];
                            
                            NSLog(@"==10101010101010101010101010====%@",self.PayMoneyLabel.text);
                            if (_delegate && [_delegate respondsToSelector:@selector(setGoodsPrice:setGid:setSigen:setStorename:setLogo:setSendWayType:setGoodsType:setMoneyType:setmid:setYunFei:setPanduan:setNum:setexchange:setdetailId:setexchange2:setYTString:)]) {
                                
                                [_delegate setGoodsPrice:self.PayMoneyLabel.text setGid:self.gid setSigen:self.sigen setStorename:self.storename setLogo:self.logo setSendWayType:self.SendWayType setGoodsType:self.good_type setMoneyType:self.MoneyType setmid:self.mid setYunFei:self.yunfei setPanduan:self.Panduan setNum:self.num setexchange:self.exchange setdetailId:self.detailId setexchange2:self.exchange2 setYTString:self.ytString];
                            }
                            
                        }else{
                            
                            self.PayMoneyLabel.text=[NSString stringWithFormat:@"￥%.02f",[string floatValue]];
                            
                            Newprice.text=[NSString stringWithFormat:@"￥%.02f",[string floatValue]];
                            
                            NSLog(@"==99999999999999====%@",self.PayMoneyLabel.text);
                            
                            if (_delegate && [_delegate respondsToSelector:@selector(setGoodsPrice:setGid:setSigen:setStorename:setLogo:setSendWayType:setGoodsType:setMoneyType:setmid:setYunFei:setPanduan:setNum:setexchange:setdetailId:setexchange2:setYTString:)]) {
                                
                                [_delegate setGoodsPrice:self.PayMoneyLabel.text setGid:self.gid setSigen:self.sigen setStorename:self.storename setLogo:self.logo setSendWayType:self.SendWayType setGoodsType:self.good_type setMoneyType:self.MoneyType setmid:self.mid setYunFei:self.yunfei setPanduan:self.Panduan setNum:self.num setexchange:self.exchange setdetailId:self.detailId setexchange2:self.exchange2 setYTString:self.ytString];
                            }
                        }
                        
                        //4
                    }else{
                        if ([self.Panduan integerValue] == 2  ) {
                            
                            number=[self.pay_money floatValue] + [self.yunfei floatValue];
                            string=[NSString stringWithFormat:@"%.02f",(float)number];
                            self.PayMoneyLabel.text=[NSString stringWithFormat:@"￥%.02f+%.02f积分",[string floatValue]*[self.num integerValue],[self.pay_integral floatValue]*[self.num integerValue]];
                            
                            Newprice.text=[NSString stringWithFormat:@"￥%.02f+%.02f积分",[string floatValue]*[self.num integerValue],[self.pay_integral floatValue]*[self.num integerValue]];
                            
                            NSLog(@"==888888888888888====%@",self.PayMoneyLabel.text);
                            if (_delegate && [_delegate respondsToSelector:@selector(setGoodsPrice:setGid:setSigen:setStorename:setLogo:setSendWayType:setGoodsType:setMoneyType:setmid:setYunFei:setPanduan:setNum:setexchange:setdetailId:setexchange2:setYTString:)]) {
                                
                                [_delegate setGoodsPrice:self.PayMoneyLabel.text setGid:self.gid setSigen:self.sigen setStorename:self.storename setLogo:self.logo setSendWayType:self.SendWayType setGoodsType:self.good_type setMoneyType:self.MoneyType setmid:self.mid setYunFei:self.yunfei setPanduan:self.Panduan setNum:self.num setexchange:self.exchange setdetailId:self.detailId setexchange2:self.exchange2 setYTString:self.ytString];
                            }
                            
                        }else{
                            
                            NSLog(@"===string****%@===model.pay_integer=%@=====",string,model.pay_integer);
                            
                            self.PayMoneyLabel.text=[NSString stringWithFormat:@"￥%.02f+%.02f积分",[string floatValue],[model.pay_integer floatValue]];
                            
                            Newprice.text=[NSString stringWithFormat:@"￥%.02f+%.02f积分",[string floatValue],[model.pay_integer floatValue]];
                            
                            NSLog(@"==777777777777777====%@",self.PayMoneyLabel.text);
                            
                            //                            [_tableView reloadData];
                            
                            if (_delegate && [_delegate respondsToSelector:@selector(setGoodsPrice:setGid:setSigen:setStorename:setLogo:setSendWayType:setGoodsType:setMoneyType:setmid:setYunFei:setPanduan:setNum:setexchange:setdetailId:setexchange2:setYTString:)]) {
                                
                                [_delegate setGoodsPrice:self.PayMoneyLabel.text setGid:self.gid setSigen:self.sigen setStorename:self.storename setLogo:self.logo setSendWayType:self.SendWayType setGoodsType:self.good_type setMoneyType:self.MoneyType setmid:self.mid setYunFei:self.yunfei setPanduan:self.Panduan setNum:self.num setexchange:self.exchange setdetailId:self.detailId setexchange2:self.exchange2 setYTString:self.ytString];
                            }
                            
                        }
                        
                    }
                    
                }else{
                    float number=[model.pay_maney floatValue] + [model.freight floatValue];
                    
                    NSString *string=[NSString stringWithFormat:@"%.02f",(float)number];
                    
                    self.MoneyType=@"1";
                    
                    if ([model.pay_maney isEqualToString:@"0"] || [model.pay_maney isEqualToString:@"0.00"]) {
                        if ([self.Panduan integerValue] == 2  ) {
                            number=[self.pay_money floatValue];// + [self.yunfei floatValue];
                            string=[NSString stringWithFormat:@"%.02f",(float)number];
                            self.PayMoneyLabel.text=[NSString stringWithFormat:@"%.02f积分",[self.pay_integral floatValue]*[self.num integerValue]];
                            
                            Newprice.text=[NSString stringWithFormat:@"%.02f积分",[self.pay_integral floatValue]*[self.num integerValue]];
                            
                            NSLog(@"==66666666666666====%@",self.PayMoneyLabel.text);
                            if (_delegate && [_delegate respondsToSelector:@selector(setGoodsPrice:setGid:setSigen:setStorename:setLogo:setSendWayType:setGoodsType:setMoneyType:setmid:setYunFei:setPanduan:setNum:setexchange:setdetailId:setexchange2:setYTString:)]) {
                                
                                [_delegate setGoodsPrice:self.PayMoneyLabel.text setGid:self.gid setSigen:self.sigen setStorename:self.storename setLogo:self.logo setSendWayType:self.SendWayType setGoodsType:self.good_type setMoneyType:self.MoneyType setmid:self.mid setYunFei:self.yunfei setPanduan:self.Panduan setNum:self.num setexchange:self.exchange setdetailId:self.detailId setexchange2:self.exchange2 setYTString:self.ytString];
                            }
                        }else{
                            
                            self.PayMoneyLabel.text=[NSString stringWithFormat:@"%.02f积分",[model.pay_integer floatValue]];
                            
                            Newprice.text=[NSString stringWithFormat:@"%.02f积分",[model.pay_integer floatValue]];
                            
                            NSLog(@"==55555555555555====%@",self.PayMoneyLabel.text);
                            if (_delegate && [_delegate respondsToSelector:@selector(setGoodsPrice:setGid:setSigen:setStorename:setLogo:setSendWayType:setGoodsType:setMoneyType:setmid:setYunFei:setPanduan:setNum:setexchange:setdetailId:setexchange2:setYTString:)]) {
                                
                                [_delegate setGoodsPrice:self.PayMoneyLabel.text setGid:self.gid setSigen:self.sigen setStorename:self.storename setLogo:self.logo setSendWayType:self.SendWayType setGoodsType:self.good_type setMoneyType:self.MoneyType setmid:self.mid setYunFei:self.yunfei setPanduan:self.Panduan setNum:self.num setexchange:self.exchange setdetailId:self.detailId setexchange2:self.exchange2 setYTString:self.ytString];
                            }
                        }
                        
                        
                    }else if ([model.pay_integer isEqualToString:@"0"] || [model.pay_integer isEqualToString:@"0.00"]){
                        if ([self.Panduan integerValue] == 2  ) {
                            
                            number=[self.pay_money floatValue];// + [self.yunfei floatValue];
                            string=[NSString stringWithFormat:@"%.02f",(float)number];
                            self.PayMoneyLabel.text=[NSString stringWithFormat:@"￥%.02f+",[string floatValue]*[self.num integerValue]];
                            
                            Newprice.text=[NSString stringWithFormat:@"￥%.02f+",[string floatValue]*[self.num integerValue]];
                            
                            NSLog(@"==44444444444444====%@",self.PayMoneyLabel.text);
                            if (_delegate && [_delegate respondsToSelector:@selector(setGoodsPrice:setGid:setSigen:setStorename:setLogo:setSendWayType:setGoodsType:setMoneyType:setmid:setYunFei:setPanduan:setNum:setexchange:setdetailId:setexchange2:setYTString:)]) {
                                
                                [_delegate setGoodsPrice:self.PayMoneyLabel.text setGid:self.gid setSigen:self.sigen setStorename:self.storename setLogo:self.logo setSendWayType:self.SendWayType setGoodsType:self.good_type setMoneyType:self.MoneyType setmid:self.mid setYunFei:self.yunfei setPanduan:self.Panduan setNum:self.num setexchange:self.exchange setdetailId:self.detailId setexchange2:self.exchange2 setYTString:self.ytString];
                            }
                        }else{
                            
                            self.PayMoneyLabel.text=[NSString stringWithFormat:@"￥%.02f+",[string floatValue]];
                            
                            Newprice.text=[NSString stringWithFormat:@"￥%.02f+",[string floatValue]];
                            
                            NSLog(@"==33333333333333====%@",self.PayMoneyLabel.text);
                            if (_delegate && [_delegate respondsToSelector:@selector(setGoodsPrice:setGid:setSigen:setStorename:setLogo:setSendWayType:setGoodsType:setMoneyType:setmid:setYunFei:setPanduan:setNum:setexchange:setdetailId:setexchange2: setYTString:)]) {
                                
                                [_delegate setGoodsPrice:self.PayMoneyLabel.text setGid:self.gid setSigen:self.sigen setStorename:self.storename setLogo:self.logo setSendWayType:self.SendWayType setGoodsType:self.good_type setMoneyType:self.MoneyType setmid:self.mid setYunFei:self.yunfei setPanduan:self.Panduan setNum:self.num setexchange:self.exchange setdetailId:self.detailId setexchange2:self.exchange2 setYTString:self.ytString];
                            }
                        }
                        
                        
                    }else{
                        if ([self.Panduan integerValue] == 2  ) {
                            number=[self.pay_money floatValue];// + [self.yunfei floatValue];
                            string=[NSString stringWithFormat:@"%.02f",(float)number];
                            self.PayMoneyLabel.text=[NSString stringWithFormat:@"￥%.02f+%.02f积分",[string floatValue]*[self.num integerValue],[self.pay_integral floatValue]*[self.num integerValue]];
                            
                            Newprice.text=[NSString stringWithFormat:@"￥%.02f+%.02f积分",[string floatValue]*[self.num integerValue],[self.pay_integral floatValue]*[self.num integerValue]];
                            
                            
                            NSLog(@"==22222222222222====%@",self.PayMoneyLabel.text);
                            if (_delegate && [_delegate respondsToSelector:@selector(setGoodsPrice:setGid:setSigen:setStorename:setLogo:setSendWayType:setGoodsType:setMoneyType:setmid:setYunFei:setPanduan:setNum:setexchange:setdetailId:setexchange2: setYTString:)]) {
                                
                                [_delegate setGoodsPrice:self.PayMoneyLabel.text setGid:self.gid setSigen:self.sigen setStorename:self.storename setLogo:self.logo setSendWayType:self.SendWayType setGoodsType:self.good_type setMoneyType:self.MoneyType setmid:self.mid setYunFei:self.yunfei setPanduan:self.Panduan setNum:self.num setexchange:self.exchange setdetailId:self.detailId setexchange2:self.exchange2 setYTString:self.ytString];
                            }
                        }else{
                            
                            NSLog(@"===%@====%@",string ,model.freight);
                            self.PayMoneyLabel.text=[NSString stringWithFormat:@"￥%.02f+%.02f积分",[string floatValue]-[model.freight floatValue],[model.pay_integer floatValue]];
                            
                            Newprice.text=[NSString stringWithFormat:@"￥%.02f+%.02f积分",[string floatValue]-[model.freight floatValue],[model.pay_integer floatValue]];
                            
                            NSLog(@"==1111111111111====%@",self.PayMoneyLabel.text);
                            
                            //                            [_tableView reloadData];
                            if (_delegate && [_delegate respondsToSelector:@selector(setGoodsPrice:setGid:setSigen:setStorename:setLogo:setSendWayType:setGoodsType:setMoneyType:setmid:setYunFei:setPanduan:setNum:setexchange:setdetailId:setexchange2: setYTString:)]) {
                                
                                [_delegate setGoodsPrice:self.PayMoneyLabel.text setGid:self.gid setSigen:self.sigen setStorename:self.storename setLogo:self.logo setSendWayType:self.SendWayType setGoodsType:self.good_type setMoneyType:self.MoneyType setmid:self.mid setYunFei:self.yunfei setPanduan:self.Panduan setNum:self.num setexchange:self.exchange setdetailId:self.detailId setexchange2:self.exchange2 setYTString:self.ytString];
                            }
                            
                        }
                    }

            }
        }
    }
    
    
    //    [_header.SendWayButton setTitle:sendWayString forState:0];
    //返回
    
    [_header.SendWayButton addTarget:self action:@selector(SendWayBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    //传入数组数据
    _header.headerDatas = _ImageArrM;
    
    
    if ([self.YTGood_type isEqualToString:@"1"]) {
        
        
        _header.start_time_str=self.startString;
        
        _header.end_time_str=self.endString;
        
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.0"];
        
        //当前时间
        //    NSDate *date3 = [NSDate dateWithTimeIntervalSinceNow:0];
        
        NSDate *date3 = [dateFormatter dateFromString:self.startString];
        
        //    NSDate *date1 = [dateFormatter dateFromString:@"2016-02-02 16:00:00.0"];
        NSDate *date2 = [dateFormatter dateFromString:self.endString];
        
        
        
        
        NSDate *num1 = [self getNowDateFromatAnDate:date3];
        NSDate *num2=[self getNowDateFromatAnDate:date2];
        
        
        NSLog(@"=====66666====当前日期为:%@",num1);
        NSLog(@"=====66666====结束日期为:%@",num2);
        
        NSTimeInterval hh1= [num1 timeIntervalSince1970];
        
        NSTimeInterval hh2 = [num2 timeIntervalSince1970];
        
        
        NSInteger times;
        
        
        times=hh2-hh1;
        
        
        if ([_YTStatus isEqualToString:@"7"]) {
            
            _header.YTTimeLabel.hidden=YES;
            
            button1.enabled=NO;
            
            button1.backgroundColor=[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];
            
//            NoGoodsDetailViewController *vc=[[NoGoodsDetailViewController alloc] init];
//            
//            
//            [self.navigationController pushViewController:VC animated:NO];
//            
//            self.navigationController.navigationBar.hidden=YES;
            
            [self initNoGoodsUI];
            
            
        }else{
            
            _header.time=times;
            
            _header.goods_type=self.good_type;
            
        }

    }
    
    
    NSLog(@"=======_header.end_time_str======%@",self.endString);
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    
    
    NSLog(@"==YTTY==%@===",[userDefaultes stringForKey:@"gouxuan"]);
    
    
    
    if ([[userDefaultes stringForKey:@"gouxuan"] isEqualToString:@"1"]) {
        
        sendWayString=@"快递邮寄";
//        [_header.SendWayButton setTitle:[NSString stringWithFormat:@"%@ >",sendWayString] forState:0];
        [_header.SendWayButton setTitle:[NSString stringWithFormat:@"%@",sendWayString] forState:0];
        
    }else if ([[userDefaultes stringForKey:@"gouxuan"] isEqualToString:@"2"]){
        
        sendWayString=@"线下自取";
//        [_header.SendWayButton setTitle:[NSString stringWithFormat:@"%@ >",sendWayString] forState:0];
        [_header.SendWayButton setTitle:[NSString stringWithFormat:@"%@",sendWayString] forState:0];
        
    }else{
        
//        [_header.SendWayButton setTitle:[NSString stringWithFormat:@"%@ >",sendWayString] forState:0];
        [_header.SendWayButton setTitle:[NSString stringWithFormat:@"%@",sendWayString] forState:0];
        
    }
    
    
    
    
    NSLog(@"===%@",sendWayString);
    
    
    
    
    return _header;
}

- (void)refresh:(DJRefresh *)refresh didEngageRefreshDirection:(DJRefreshDirection)direction{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self addDataWithDirection:direction];
    });
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数组NSArray类型的数据
    self.sigen=[userDefaultes stringForKey:@"sigen"];
    
    //        NSLog(@">>>>>>%@",self.sigen);
    
    
        
    
}

- (void)addDataWithDirection:(DJRefreshDirection)direction{
    
    if (direction==DJRefreshDirectionTop) {
        
        
        
        WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
        
        dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
        dispatch_after(time, dispatch_get_main_queue(), ^{
            [hud dismiss:YES];
        });
        
    }
    
//    else if (direction==DJRefreshDirectionBottom){
//        
//        NSLog(@"11111");
//        
//    }
    
    
    
    [_refresh finishRefreshingDirection:direction animation:YES];
    
    
}

#pragma  mark - MJRefreshBaseViewDelegate
//开始刷新
-(void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    //刷新头部, 下拉刷新
    if (refreshView == refreshFooterView) {

        
            TuWenViewController *vc=[[TuWenViewController alloc] init];
            vc.NewHomeString = self.NewHomeString;
            vc.ID=self.gid;
            vc.NewHomeString = self.NewHomeString;
            vc.pay_xiaoji=self.PayMoneyLabel.text;
            vc.Panduan=self.Panduan;
            vc.detailId=self.detailId;
            vc.MoneyType=self.MoneyType;
            vc.num=self.num;
            vc.exchange=self.exchange;
            vc.exchange = self.exchange2;
            vc.ytString=self.xuanze;
            vc.is_attribute=self.YTAttribute;
            vc.YTStatus=self.status;
            vc.YTBackString=self.Attribute_back;
            vc.TTTTTTT = self.TTTTTT;

            [self.navigationController pushViewController:vc animated:NO];
            
            self.navigationController.navigationBar.hidden=YES;
            
//        }
       
    }
    
    
}


-(void)NoShowView
{
    
    
    NSLog(@"登陆成功！");
    
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0) {
        
        _YTView.view1.hidden=YES;
        self.YYYYYYY = @"0";
        
        NSLog(@"点击了商品属性");
        
        //已下架、已售完，商品属性不可点击
        if ([self.YTStatus isEqualToString:@"1"]) {
            return;
        }
        if ([self.ShuXingUnable isEqualToString:@"100"]) {
            if ([_attribute isEqualToString:@"2"]) {
                [self initview];
                [goodsMainview show];
            }
            
        }else{
            
            [self initview];
            [goodsMainview show];
        }
    }else{

    }
}

//配送方式
-(void)SendWayBtnClick
{
    
    if ([self.Panduan integerValue] == 2) {
        
        if ([self.exchange integerValue] == 1|| [self.exchange integerValue] == 2) {
            //            CustomActionSheet * mySheet = [[CustomActionSheet alloc] initWithTitle:@"配送方式" otherButtonTitles:@[@"快递邮寄"]];
            self.MoneyType = @"0";
            //            mySheet.cancelTitle=@"关闭";
            //            mySheet.delegate = self;
            //            [mySheet show];
        }else if([self.exchange integerValue] == 3|| [self.exchange integerValue] == 4){
            
            CustomActionSheet * mySheet = [[CustomActionSheet alloc] initWithTitle:@"配送方式" otherButtonTitles:@[@"快递邮寄",@"线下自取"]];
            
            //            mySheet.cancelTitle=@"关闭";
            
            mySheet.delegate = self;
            
            
            [mySheet show];
            
        }
    }else{
        if ([self.exchange2 integerValue] == 1|| [self.exchange2 integerValue] == 2) {
            //            CustomActionSheet * mySheet = [[CustomActionSheet alloc] initWithTitle:@"配送方式" otherButtonTitles:@[@"快递邮寄"]];
            self.MoneyType = @"0";
            //            mySheet.cancelTitle=@"关闭";
            //
            //            mySheet.delegate = self;
            //            [mySheet show];
        }else if([self.exchange2 integerValue] == 3|| [self.exchange2 integerValue] == 4){
            
            CustomActionSheet * mySheet = [[CustomActionSheet alloc] initWithTitle:@"配送方式" otherButtonTitles:@[@"快递邮寄",@"线下自取"]];
            self.MoneyType = @"0";
            //            mySheet.cancelTitle=@"关闭";
            
            mySheet.delegate = self;
            [mySheet show];
            
        }
        
        
        
        
    }
    //    if ([self.SendWayType isEqualToString:@"0"]) {
    //      CustomActionSheet * mySheet = [[CustomActionSheet alloc] initWithTitle:@"配送方式" otherButtonTitles:@[@"快递邮寄"]];
    //
    //        mySheet.cancelTitle=@"关闭";
    //
    //        mySheet.delegate = self;
    //        [mySheet show];
    //    }
    
    
    //    CustomActionSheet * mySheet = [[CustomActionSheet alloc] initWithTitle:@"配送方式" otherButtonTitles:@[@"快递邮寄",@"包邮",@"线下自取"]];
    
    //    mySheet.cancelTitle=@"关闭";
    //
    //    mySheet.delegate = self;
    //    [mySheet show];
}

#pragma mark - delegate
// 在代理方法中写你需要处理的点击事件逻辑即可
- (void)sheet:(CustomActionSheet *)sheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //    NSLog(@"you has clicked button ======= %ld",(long)buttonIndex);
    
    
    for (GoodsDetailModel *model in _datasArrM) {
        
        //        NSInteger number=[model.pay_maney integerValue] + 10;
        //       NSString *string=[NSString stringWithFormat:@"%ld",(long)number];
        
        if ((long)buttonIndex==0) {
            sendWayString=@"快递邮寄";
            
            //            self.PayMoneyLabel.text=[NSString stringWithFormat:@"￥%@ + %@积分",string,model.pay_integer];
            
//            NSLog(@"%@",self.PayMoneyLabel.text);
            
            NSLog(@"选择了快递邮寄");
            
            
            _header.SendMoneyLabel.text=[NSString stringWithFormat:@"配送 "];
            
            self.MoneyType=@"0";
            
            
            //缓存勾选状态
            [UserMessageManager GoodsImageSecect:@"1"];
            
            [UserMessageManager SelectSendWay:@"0"];
            
            [_tableView reloadData];
            
        }else if ((long)buttonIndex==1){
            sendWayString=@"线下自取";
            _header.SendMoneyLabel.text=[NSString stringWithFormat:@"配送 "];
            
            NSLog(@"选择了线下自取");
            
            self.MoneyType=@"1";
            
            //缓存勾选状态
            [UserMessageManager GoodsImageSecect:@"2"];
            
            [UserMessageManager SelectSendWay:@"1"];
            
            
        }
        
        [_tableView reloadData];
    }
    
}


-(void)initview{

    [self.view removeGestureRecognizer:self.leftSwipeGestureRecognizer];
    [self.view removeGestureRecognizer:self.rightSwipeGestureRecognizer];
    
    
    goodsMainview = [[GoodsDetailMainView alloc] initWithFrame:self.view.bounds];
    
    goodsMainview.vc = self;
    
    [self.view addSubview:goodsMainview];
    goodsMainview.goodsDetail.delegate = self;
    
    NSLog(@"====11====>>>>>>==%@",Goods_Type);
    
    goodsMainview.choseView.Goods_type=Goods_Type;
    
    NSLog(@"===22=====>>>>>>==%@===StockString===%@",goodsMainview.choseView.Goods_type,self.StockString);
    
    [goodsMainview initChoseViewSizeArr:sizearr andColorArr:colorarr andArr3:BuLiaoarr3 andArr4:Stylearr4 andArr5:Titlearr5 andStockDic:stockdic andGoodsImageView:ImageString andMoney:MoneyString andJIFen:IntergelString andKuCun:StockString andGid:self.gid andcount:self.count andGoods_type:Goods_Type andGoods_status:Goods_Status andback:self.Attribute_back andYTBack:@"100" andMid:self.mid andYYYY:self.YYYYYYY andSmallIds:@"" andStorename:self.storename andLogo:self.logo andSendWayType:self.SendWayType andMoneyType:self.MoneyType andSid:@"" andTf:@"" andCut:@"" andJinDu:self.jindu andWeiDu:self.weidu andAddressString:self.MapStartAddress andNewHomeString:self.NewHomeString];

}

-(void)dealloc
{
    //释放资源(移除kvo)
    
    [refreshFooterView free];
    [_header.timer invalidate];
    _header.timer=nil;
    [_header.timer1 invalidate];
    _header.timer1=nil;
}

//时间转换
- (NSDate *)getNowDateFromatAnDate:(NSDate *)anyDate
{
    //设置源日期时区#
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];//或GMT
    //设置转换后的目标日期时区
    NSTimeZone* destinationTimeZone = [NSTimeZone localTimeZone];
    //得到源日期与世界标准时间的偏移量
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:anyDate];
    //目标日期与本地时区的偏移量
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:anyDate];
    //得到时间偏移量的差值
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    //转为现在时间
    NSDate* destinationDateNow = [[NSDate alloc] initWithTimeInterval:interval sinceDate:anyDate];
    
    return destinationDateNow;
}

-(void)DaoJiTime
{
    //日期转换为时间戳 (日期转换为秒数)
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.0"];
    
    //当前时间
    NSDate *date3 = [NSDate dateWithTimeIntervalSinceNow:0];
    
    //    NSDate *date1 = [dateFormatter dateFromString:@"2016-02-02 16:00:00.0"];
    NSDate *date2 = [dateFormatter dateFromString:self.endString];
    
    NSDate *date4 = [dateFormatter dateFromString:self.startString];
    
    
    NSLog(@">>>>>>>>>%@",self.endString);
    NSLog(@">>>>>>>>>%@",self.startString);
    
    NSDate *num1 = [self getNowDateFromatAnDate:date3];
    
    NSDate *num2=[self getNowDateFromatAnDate:date2];
    
    NSDate *num3=[self getNowDateFromatAnDate:date4];
    
    NSLog(@"=========当前日期为:%@",num1);
    NSLog(@"=========结束日期为:%@",num2);
    
    NSTimeInterval hh1= [num1 timeIntervalSince1970];
    
    NSTimeInterval hh2 = [num2 timeIntervalSince1970];
    
    NSTimeInterval hh3 = [num3 timeIntervalSince1970];
    
    
    
    NSInteger times;
    
    
    
    if ([self.good_type isEqualToString:@"1"]) {
        
        if ([self.status isEqualToString:@"4"]) {
            
            _header.YTTimeLabel.hidden=NO;
            
            times=(NSInteger)(hh2 - hh1);
            NSLog(@"--------->%ld",times);
            
        }else if ([self.status isEqualToString:@"0"]){
            _header.YTTimeLabel.hidden=NO;
            times=(NSInteger)(hh3 - hh1);
            NSLog(@"--------->%ld",times);
        }
    }
    
    if (times<=0) {
        
        if ([self.status isEqualToString:@"4"]) {
            
            label2.hidden=YES;
            self.timeLabel.hidden=YES;
            
            UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(fwidth/4, 25, fwidth-fwidth/2-fwidth/25, 30)];
            
            label.text=@"已停止抢购";
            label.textColor=[UIColor whiteColor];
            label.textAlignment=NSTextAlignmentCenter;
            
            [topView insertSubview:label aboveSubview:self.view];
        }else if ([self.status isEqualToString:@"0"]){
            
            self.timeLabel.hidden=YES;
            label2.hidden=YES;
            
            UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(fwidth/4, 25, fwidth-fwidth/2-fwidth/25, 30)];
            label.text=@"已开始抢购";
            label.textColor=[UIColor whiteColor];
            label.textAlignment=NSTextAlignmentCenter;
            
            [topView insertSubview:label aboveSubview:self.view];
        }
        
    }else{
        
        GGClockView *clockView = [[GGClockView alloc] init];
        clockView.frame = self.timeLabel.frame;
        
//        clockView.frame =_header.ShiJianLabel.frame;
        
        [clockView setTimeBackgroundColor:[UIColor blackColor] timeTextColor:[UIColor whiteColor] colonColor:[UIColor blackColor] font:[UIFont systemFontOfSize:10]];
        clockView.time = times;
        [self.view addSubview:clockView];
        self.clockView = clockView;
    }
    
}


//创建商品失效页面

-(void)initNoGoodsUI
{
    
    
    [NoGoods removeFromSuperview];
    
    [bgImgView removeFromSuperview];
    
    UIView *bgView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];

    bgView.backgroundColor=[UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
    
    [self.view addSubview:bgView];

    UIImageView *bgImage=[[UIImageView alloc] initWithFrame:CGRectMake((self.view.frame.size.width-120)/2, 100, 120, 120)];
    
    bgImage.image=[UIImage imageNamed:@"商品过期"];

    [bgView addSubview:bgImage];

    UILabel *bgLabel=[[UILabel alloc] initWithFrame:CGRectMake(20, 240, self.view.frame.size.width-40, 23)];
    
    bgLabel.text=@"商品过期不存在";
    
    bgLabel.textAlignment=NSTextAlignmentCenter;
    
    bgLabel.textColor=[UIColor colorWithRed:170/255.0 green:170/255.0 blue:170/255.0 alpha:1.0];
    
    bgLabel.font=[UIFont systemFontOfSize:19];
    
    [bgView addSubview:bgLabel];
    

    
    [self.view removeGestureRecognizer:self.leftSwipeGestureRecognizer];
    [self.view removeGestureRecognizer:self.rightSwipeGestureRecognizer];

    
}

-(void)MakeSelfMessage
{
    //创建地图View
    _mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-KSafeAreaTopNaviHeight)];
    
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
    
    
    NSLog(@"个人中心定位成功!");
    
    //获取到定位的位置信息
    CLLocation *location = [locations firstObject];
    
    //定位到的当前坐标
    CLLocationCoordinate2D coordinate = location.coordinate;
    
    NSLog(@"(%f, %f)", coordinate.latitude, coordinate.longitude);
    
    self.jindu=[NSString stringWithFormat:@"%f",coordinate.longitude];
    
    self.weidu=[NSString stringWithFormat:@"%f",coordinate.latitude];
    
    
    _mapView.centerCoordinate = CLLocationCoordinate2DMake(coordinate.latitude, coordinate.longitude);
    
    
    //反地理编码(逆地理编码): 将位置信息转换成地址信息
    //地理编码: 把地址信息转换成位置信息
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    
    //反地理编码
    //尽量不要一次性调用很多次
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        
        if (error) {
            NSLog(@"反地理编码失败!%@",error);
            return ;
        }
        
        //地址信息
        CLPlacemark *placemark = [placemarks firstObject];
        NSString *country = placemark.country;
        NSString *administrativeArea = placemark.administrativeArea;
        NSString *subLocality = placemark.subLocality;
        NSString *name = placemark.name;
        
        NSLog(@"%@ %@ %@ %@", country, administrativeArea, subLocality, name);
        
        self.MapStartAddress = [NSString stringWithFormat:@"%@%@%@",administrativeArea, subLocality, name];
        
    }];
    
    
    //停止定位
    [_locationManager stopUpdatingLocation];
    
    
}

//定位失败
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"定位失败:%@", error);
}

-(void)setShouCangStr:(NSString *)shouCangStr
{
    _shouCangStr=shouCangStr;
    if (_delegate&&[_delegate respondsToSelector:@selector(setShouCangString:)]) {
        [_delegate setShouCangString:shouCangStr];
    }
}

@end
