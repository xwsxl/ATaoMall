//
//  TuWenViewController.m
//  aTaohMall
//
//  Created by JMSHT on 16/5/16.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import "TuWenViewController.h"

#import "ConverUtil.h"
#import "DESUtil.h"
#import "SecretCodeTool.h"

#import "AFNetworking.h"

#import "UIImageView+WebCache.h"

#import "GoodsDetailMainView.h"

#import "GoToShopModel.h"

#import "QueDingPayViewController.h"//确定支付

#import "QueDingDingDanViewController.h"//确定订单

//刷新
#import "DJRefresh.h"
#import "DJRefreshProgressView.h"

#import "NewLoginViewController.h"

#import "UserMessageManager.h"

#import "JRToast.h"

#import "WKProgressHUD.h"//加载小时图

#import "SVProgressHUD.h"
#import "MJRefresh.h"

#import "YTGoodsDetailViewController.h"

#import "UserMessageManager.h"

#import "ATHLoginViewController.h"

#import "AVRefreshExtension.h"

#import "ChoseView.h"

#import "BusinessQurtViewController.h"

#import "ClassifyViewController.h"

#import "GoodsAttributeModel.h"//属性

#import "YTScoreViewController.h"//积分专题

#import "SearchResultViewController.h"

#import "HomeLookAllViewController.h"

#import "HomeLookAllViewController1.h"

#import "HomeLookAllViewController2.h"

#import "HomeLookAllViewController3.h"

#import "HomeLookAllViewController4.h"

#import "NineAndNineViewController.h"

#import "LookAllViewController.h"

#import "GotoShopLookViewController.h"



#import "UpLookCell.h"
#import "BackCartViewController.h"

#import "LZCartViewController.h"

#import "ThrowLineTool.h"

#import "SMProgressHUD.h"
#import "SMProgressHUDActionSheet.h"

#import "BackCartViewController.h"

#import "MerchantDetailViewController.h"

//MapKit是原生地图框架
#import <MapKit/MapKit.h>

//CoreLocation是定位框架
#import <CoreLocation/CoreLocation.h>

#import "HomeLittleAppliancesVC.h"
#define AddButtonWidth [UIScreen mainScreen].bounds.size.width*0.32
#define BuyButtonWidth [UIScreen mainScreen].bounds.size.width*0.266
@interface TuWenViewController ()<DJRefreshDelegate,UIWebViewDelegate,LoginMessageDelegate,UIScrollViewDelegate,MJRefreshBaseViewDelegate,ThrowLineToolDelegate,SMProgressHUDAlertViewDelegate, SMProgressHUDActionSheetDelegate,CartNumberDelegate,ChangeAttributeDelegate,MKMapViewDelegate, CLLocationManagerDelegate>
{
//    UIWebView *_webView;
    
    NSMutableArray *_datas;
    
    UILabel *label2;
    UIButton *_zhiding;
     BOOL isFirstLoadWeb;
    UIView *view;
    //刷新头
    MJRefreshHeaderView *refreshHeaderView;
    
    GoodsDetailMainView *goodsMainview;
    ChoseView *choseView;
    
    
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
    
    
    NSDictionary *stockdic;//商品库存量
    
    UIButton *CartButton;//加入购物车
    UIButton *  NowBuyButton;
    UIView *CartView;
    
    UILabel *countLabel;//购物车件数
    
    NSString *CartString;//购物车数量
    
    UIImageView *RedImgView;
    
    UIAlertController *alertCon;
    
    UIView *NoGoods;
    
    UIImageView *bgImgView;
    
    //地图View
    MKMapView *_mapView;
    
    //定位管理器
    CLLocationManager *_locationManager;
    
    UIButton *ShouCangBut;

}

@property (strong, nonatomic) UIView *redView;//加入购物车红点

@property (strong, nonatomic) UIImageView *redImg;//加入购物车红点

@property (nonatomic,strong)UIWebView *webView;

@property (nonatomic,strong)DJRefresh *refresh;

@property (nonatomic,strong)NSString *ShouCangStr;

@end

@implementation TuWenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ShuXingNoKuCun:) name:@"ShuXingNoKuCun" object:nil];
    
    
    [self MakeSelfMessage];
    
    [ThrowLineTool sharedTool].delegate = self;//加入购物车动画
    
    
    self.gid=self.ID;
    
    TitleArrM1=[NSMutableArray new];
    
    ColorArrM2=[NSMutableArray new];
    
    SizeArrM3=[NSMutableArray new];
    
    BuLiaoArrM4=[NSMutableArray new];
    
    StyleArrM5=[NSMutableArray new];
    
    self.view.frame=[UIScreen mainScreen].bounds;
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    [refreshHeaderView  endRefreshing];
    
    NSLog(@"===self.NewHomeStringself.NewHomeString=%@",self.NewHomeString);
    
    NSLog(@"kkkkkkkkkkkk=%@==self.pay_xiaoji=%@==%@===%@==%@==self.MoneyType=%@",self.exchange,self.pay_xiaoji,self.ytString,self.pay_money,self.pay_integral,self.MoneyType);
    
    
    NSLog(@"=%@==属性商品返回库存===%@==%ld",self.YTBackString,self.YTStock,self.YTStock.length);
    
    if (self.MoneyType.length==0) {
        
        self.MoneyType=@"0";
        
    }
    //读取数组NSArray类型的数据
    self.sigen=[userDefaultes stringForKey:@"sigen"];
    
    NSLog(@">>>>>>%@",self.sigen);
    
    self.sigen=@"";
    
    _datas=[NSMutableArray new];
    
    //================购物车======================

  UIImageView *Newfenge=[[UIImageView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-50-KSafeAreaTopNaviHeight-KSafeAreaBottomHeight, [UIScreen mainScreen].bounds.size.width, 1)];
    Newfenge.image=[UIImage imageNamed:@"分割线-拷贝"];

    [self.view addSubview:Newfenge];

    //店铺
    
    UIView *ShopView = [[UIView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-49-KSafeAreaBottomHeight,([UIScreen mainScreen].bounds.size.width-AddButtonWidth-100-1)/2 , 49+KSafeAreaBottomHeight)];
    //    ShopView.backgroundColor=[UIColor redColor];
    
    
    [self.view addSubview:ShopView];


    ShouCangBut=[UIButton buttonWithType:UIButtonTypeCustom];
    ShouCangBut.frame=CGRectMake(kScreen_Width-15-18-11, 20+KSafeTopHeight, 40, 40);

    [ShouCangBut addTarget:self action:@selector(shouCangBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:ShouCangBut];

    UIImageView *Shop = [[UIImageView alloc] initWithFrame:CGRectMake((49-20)/2, 5, 20, 20)];
    
    Shop.image = [UIImage imageNamed:@"店铺"];
    
    [ShopView addSubview:Shop];
    
    UILabel *shopName = [[UILabel alloc] initWithFrame:CGRectMake((49-30)/2, 30, 30, 10)];
    
    shopName.text = @"店铺";
    shopName.textAlignment = NSTextAlignmentCenter;
    shopName.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
    shopName.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
    
    [ShopView addSubview:shopName];
    
    UIImageView *ShopLine = [[UIImageView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-AddButtonWidth-100-1)/2, [UIScreen mainScreen].bounds.size.height-49+5-KSafeAreaBottomHeight, 1, 39)];
    
    ShopLine.image =[UIImage imageNamed:@"分割线"];
    
    [self.view addSubview:ShopLine];
    
    
    UIButton *ShopButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    ShopButton.frame = CGRectMake(0, 0, ShopView.frame.size.width, 49);
    
    [ShopButton addTarget:self action:@selector(GoToShopBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [ShopView addSubview:ShopButton];
    
    
    
    
    //购物车
    
    CartView = [[UIView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-AddButtonWidth-100-1)/2+1, [UIScreen mainScreen].bounds.size.height-49-KSafeAreaBottomHeight, ([UIScreen mainScreen].bounds.size.width-AddButtonWidth-100-1)/2, 49+KSafeAreaBottomHeight)];
    //    CartView.backgroundColor=[UIColor yellowColor];
    
    [self.view addSubview:CartView];
    
    UIImageView *Cart = [[UIImageView alloc] initWithFrame:CGRectMake((ShopView.frame.size.width-20)/2, 5, 20, 20)];
    
    Cart.image = [UIImage imageNamed:@"购物车888"];
    
    
    [CartView addSubview:Cart];
    
    
    
    
    
    
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
    if (!CartButton) {
CartButton=[UIButton buttonWithType:UIButtonTypeCustom];
    }

    CartButton.frame=CGRectMake([UIScreen mainScreen].bounds.size.width-AddButtonWidth-100, [UIScreen mainScreen].bounds.size.height-49-KSafeAreaBottomHeight, AddButtonWidth, 49);
    [CartButton setTitle:@"加入购物车" forState:0];
    CartButton.titleLabel.font=[UIFont fontWithName:@"PingFangSC-Medium" size:16];
    CartButton.backgroundColor=[UIColor colorWithRed:255/255.0 green:169/255.0 blue:93/255.0 alpha:1.0];
    [CartButton setTitleColor:[UIColor whiteColor] forState:0];
    
    CartButton.userInteractionEnabled=YES;
    
    [CartButton addTarget:self action:@selector(AddCartbtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:CartButton];


   

    NowBuyButton=[UIButton buttonWithType:UIButtonTypeCustom];
    NowBuyButton.frame=CGRectMake([UIScreen mainScreen].bounds.size.width-100, [UIScreen mainScreen].bounds.size.height-49-KSafeAreaBottomHeight, 100, 49);
    [NowBuyButton addTarget:self action:@selector(BuyBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [NowBuyButton setTitle:@"立即购买" forState:0];
    NowBuyButton.titleLabel.font=[UIFont fontWithName:@"PingFangSC-Medium" size:16];
    NowBuyButton.backgroundColor=[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
    [NowBuyButton setTitleColor:[UIColor whiteColor] forState:0];

    NowBuyButton.userInteractionEnabled=YES;

    [self.view addSubview:NowBuyButton];

    self.XiaoJiLabel.hidden=YES;
    
    
    //======================================
    
    
    NSNull *null=[[NSNull alloc] init];
    
    if ([self.pay_money isEqual:null] || [self.pay_integral isEqual:null] || self.pay_money.length==0 || self.pay_integral.length==0) {
        
        
        NSString *string = [NSString stringWithFormat:@"小计:%@",self.pay_xiaoji];
        
        NSString *stringForColor = @"小计:";
        // 创建对象.
        NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:string];
        //
        NSRange range = [string rangeOfString:stringForColor];
        
        [mAttStri addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range];
        
        self.XiaoJiLabel.attributedText=mAttStri;
        
        
//        self.XiaoJiLabel.text = [NSString stringWithFormat:@"小计:%@",self.pay_xiaoji];
        
    }else{
        
        if ([self.pay_money isEqualToString:@"0"] || [self.pay_money isEqualToString:@"0.00"] || [self.pay_money isEqualToString:@""]) {
            
            
            NSString *string = [NSString stringWithFormat:@"小计:%.02f积分",[self.pay_integral floatValue]];
            
            NSString *stringForColor = @"小计:";
            // 创建对象.
            NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:string];
            //
            NSRange range = [string rangeOfString:stringForColor];
            
            [mAttStri addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range];
            
            self.XiaoJiLabel.attributedText=mAttStri;
            
//            self.XiaoJiLabel.text = [NSString stringWithFormat:@"小计:%.02f积分",[self.pay_integral floatValue]];
            
        }else if ([self.pay_integral isEqualToString:@"0"] || [self.pay_integral isEqualToString:@"0.00"] || [self.pay_integral isEqualToString:@""]){
            
            
            NSString *string = [NSString stringWithFormat:@"小计:￥%.02f",[self.pay_money floatValue]];
            
            NSString *stringForColor = @"小计:";
            // 创建对象.
            NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:string];
            //
            NSRange range = [string rangeOfString:stringForColor];
            
            [mAttStri addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range];
            
            self.XiaoJiLabel.attributedText=mAttStri;
            
//            self.XiaoJiLabel.text = [NSString stringWithFormat:@"小计:￥%.02f",[self.pay_money floatValue]];
            
        }else{
            
            
            NSString *string = [NSString stringWithFormat:@"小计:￥%.02f+%.02f积分",[self.pay_money floatValue],[self.pay_integral floatValue]];
            
            NSString *stringForColor = @"小计:";
            // 创建对象.
            NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:string];
            //
            NSRange range = [string rangeOfString:stringForColor];
            
            [mAttStri addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range];
            
            self.XiaoJiLabel.attributedText=mAttStri;
            
            
//            self.XiaoJiLabel.text = [NSString stringWithFormat:@"小计:￥%.02f+%.02f积分",[self.pay_money floatValue],[self.pay_integral floatValue]];
        }
    }
    
    
    
    NSLog(@"====^^^^^^^===%@",self.is_attribute);
    
//    if ([self.is_attribute isEqualToString:@"2"]) {
    
//    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数组NSArray类型的数据
    self.sigen=[userDefaultes stringForKey:@"sigen"];
    
    
//    if (self.sigen.length==0) {
//        
//        ATHLoginViewController *vc=[[ATHLoginViewController alloc] init];
//        
//        vc.delegate=self;
//        
//        vc.backString=@"205";
//        
//        vc.gid = self.ID;
//        
//        [self.navigationController pushViewController:vc animated:NO];
//        
//        self.navigationController.navigationBar.hidden=YES;
//        
//        
//    }else{
    
        [self getDatas];
        
        [self getGoodsAttributeDatas];
        
//    }
    
//    }
    
    
    //纯积分不能加入购物车
    if ([self.good_type isEqualToString:@"1"]||[self.good_type isEqualToString:@"8"]) {
        
        CartButton.enabled=NO;//纯积分不能加入购物车
        CartButton.backgroundColor=[UIColor colorWithRed:226/255.0 green:226/255.0 blue:226/255.0 alpha:1.0];
        
        //创建遮罩层
        UIImageView *bgImgView1 = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-AddButtonWidth-100, [UIScreen mainScreen].bounds.size.height-49-KSafeAreaBottomHeight-KSafeAreaTopNaviHeight, AddButtonWidth,KSafeAreaBottomHeight+49)];
        bgImgView1.image = [UIImage imageNamed:@"遮造层"];
        
       // [self.view addSubview:bgImgView1];
        
        
    }
    
    
    if ([self.YTStatus isEqualToString:@"6"]) {
        
        
        NowBuyButton.enabled=NO;
        
        NowBuyButton.backgroundColor=[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];
        
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ShuXingNoKuCun:) name:@"ShuXingNoKuCun" object:nil];
    
    //确认订单返回，显示购物车件数
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(GoodsDetailAndTuWenCartNumber) name:@"GoodsDetailAndTuWenCartNumber" object:nil];
    
}

-(void)shouCangBtnClick:(UIButton *)sender
{
    sender.selected=!sender.selected;

    if (![[kUserDefaults stringForKey:@"sigen"] containsString:@"null"]&&[kUserDefaults stringForKey:@"sigen"].length>0) {
        ShouCangBut.userInteractionEnabled=NO;

        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];

        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        NSString *url=[NSString stringWithFormat:@"%@updateCollectionGoodsOrShop_mob.shtml",URL_Str];
        YLog(@"self.id=%@",self.ID);
        /* 收藏店铺参数：sigen：
         is_status：收藏状态：1收藏2取消收藏（这里传1）
         type：类型：1商品2商铺（这里传2）
         mid：商户ID
         取消收藏店铺参数：sigen：
         is_status：收藏状态：1收藏2取消收藏（这里传2）
         type：类型：1商品2商铺（这里传2）
         mid：商户ID */
        if (![_ShouCangStr isEqualToString:@"1"]) {
            NSDictionary *params=@{@"sigen":[kUserDefaults stringForKey:@"sigen"],@"is_status":@"1",@"type":@"1",@"gid":self.ID};
            [ATHRequestManager POST:url parameters:params successBlock:^(NSDictionary *responseObj) {
                if ([responseObj[@"status"] isEqualToString:@"10000"]) {
                    self.ShouCangStr=@"1";

                }

                [TrainToast showWithText:responseObj[@"message"] duration:2.0];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    ShouCangBut.userInteractionEnabled=YES;
                });
            } faildBlock:^(NSError *error) {
                [TrainToast showWithText:error.localizedDescription duration:2.0];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    ShouCangBut.userInteractionEnabled=YES;
                });
            }];


        }else
        {
            NSDictionary *params=@{@"sigen":[kUserDefaults stringForKey:@"sigen"],@"is_status":@"2",@"type":@"1",@"gid":self.ID};
            [ATHRequestManager POST:url parameters:params successBlock:^(NSDictionary *responseObj) {
                if ([responseObj[@"status"] isEqualToString:@"10000"]) {
                    self.ShouCangStr=@"2";

                }
                [TrainToast showWithText:responseObj[@"message"] duration:2.0];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    ShouCangBut.userInteractionEnabled=YES;
                });
            } faildBlock:^(NSError *error) {
                [TrainToast showWithText:error.localizedDescription duration:2.0];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    ShouCangBut.userInteractionEnabled=YES;
                });
            }];

        }
    }else
    {
        ATHLoginViewController *VC=[[ATHLoginViewController alloc] init];
        [self.navigationController pushViewController:VC animated:NO];
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

-(void)LoginToTuWen:(NSString *)sigen ID:(NSString *)gid
{
    
    self.sigen = sigen;
    
    [self getDatas];
    
//    [self getGoodsAttributeDatas];
    
}


//修改属性时，库存为0，出现红色框
//回显通知
-(void)ShuXingNoKuCun:(NSNotification *)text
{
    
    if([text.userInfo[@"textOne"] isEqualToString:@"0"]){
        
        [self GoodsByNone];
        
    }else{
        
        NoGoods.hidden=YES;
        
        bgImgView.hidden=YES;
        
        CartButton.enabled = YES;
        NowBuyButton.enabled =YES;
        
    }
    
}

-(void)gotoYT
{
    
    NSLog(@"gotoYT");
    
//    [self getDatas];
    
    //回到头部
    [_webView.scrollView setContentOffset:CGPointZero animated:YES];
    
}


//创建商品已售完
-(void)GoodsByNone
{
    
    NoGoods = [[UIView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-49-25-KSafeAreaBottomHeight, [UIScreen mainScreen].bounds.size.width, 25)];
    
    NoGoods.backgroundColor = [UIColor colorWithRed:255/255.0 green:52/255.0 blue:53/255.0 alpha:1.0];
    
    [self.view addSubview:NoGoods];
    
    UILabel *NoLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, NoGoods.frame.size.width-100, 25)];

    if ([_attribute isEqualToString:@"1"]||[self.stock isEqualToString:@"0"]) {

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
    
    //创建遮罩层
    bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-AddButtonWidth-100, [UIScreen mainScreen].bounds.size.height-49-KSafeAreaBottomHeight, AddButtonWidth+100,49+KSafeAreaBottomHeight)];
    bgImgView.image = [UIImage imageNamed:@"遮造层"];
    
    CartButton.enabled = NO;
    NowBuyButton.enabled =NO;
    
    [self.view addSubview:bgImgView];
    
    
}

//进店看看
-(void)GoToShopBtnClick
{

    NSLog(@"进店看看");
    
    MerchantDetailViewController *vc=[[MerchantDetailViewController alloc] init];
    
//    vc.delegate=self;
//    
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
//    
//    
//    vc.type=@"1";//判断返回界面
    
    vc.mid=self.mid;
    
    vc.BackString = @"333";
    
    
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


//查看购物车
-(void)GoToCartBtnClick
{
    NSLog(@"查看购物车");
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数组NSArray类型的数据
    self.sigen=[userDefaultes stringForKey:@"sigen"];
    
    //        NSLog(@">>>>>>%@",self.sigen);
    
    
    if (self.sigen.length==0 || [self.sigen isEqualToString:@""]) {
        
        
//        ATHLoginViewController *vc=[[ATHLoginViewController alloc] init];
//        
//        vc.delegate=self;
//        
//        vc.backString=@"205";
//        
//        vc.gid = self.ID;
//        
//        [self.navigationController pushViewController:vc animated:NO];
//        
//        self.navigationController.navigationBar.hidden=YES;
        
        ATHLoginViewController *vc=[[ATHLoginViewController alloc] init];
        vc.delegate=self;
        
        vc.backString=@"123";
        
        vc.jindu =self.jindu;
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

-(void)GoodsDetailReloadData:(NSString *)sigen
{
    
    self.sigen = sigen;
    
    [self JoinCartReauest];
    
    
}


-(void)ChangeAttributeDelegateClick:(NSString *)detailId
{
    
    self.detailId = detailId;
    
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
        
        
        if (self.sigen.length==0) {
            
//            ATHLoginViewController *vc=[[ATHLoginViewController alloc] init];
//            
//            vc.delegate=self;
//            
//            vc.backString=@"205";
//            
//            vc.gid = self.ID;
//            
//            [self.navigationController pushViewController:vc animated:NO];
//            
//            self.navigationController.navigationBar.hidden=YES;
            
            
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

//购物车结束动画
- (void)animationDidFinish
{
    
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
            
            
            
            
        }];
        
    }];
}

//加入购物车
-(void)JoinCartReauest
{
    if (self.detailId.length==0) {
        
        self.detailId = @"";
        
    }
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
                
                if ([dict[@"status"] isEqualToString:@"10000"]) {
                    
                    
                    [hud dismiss:YES];
                    
                    [self.view addSubview:self.redImg];
                    
                    //[JRToast showWithText:dict[@"message"] duration:1.0f];
                    
                    
                    [[SMProgressHUD shareInstancetype] showTip:@"加入购物车成功"];
                    
                    
//                    [[ThrowLineTool sharedTool] throwObject:self.redImg from:CartButton.center to:CartView.center height:-450 duration:1.4];
                    
                    [[ThrowLineTool sharedTool] throwObject:self.redImg from:CartButton.center to:CartView.center height:-300 duration:1.4];
                    
                    
                    CartString = dict[@"goods_sum"];
                    
                    
                }else if([dict[@"status"] isEqualToString:@"10002"]){
                    
                    [hud dismiss:YES];
                    
                    CartString = dict[@"goods_sum"];
                    
                    countLabel.text = CartString;
                    
                    countLabel.hidden = NO;
                    RedImgView.hidden = NO;
                    
                    
                    alertCon = [UIAlertController alertControllerWithTitle:dict[@"message"] message:nil preferredStyle:UIAlertControllerStyleAlert];
                    [alertCon addAction: [UIAlertAction actionWithTitle: @"确认" style: UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                        
                        
                        
                        BackCartViewController *vc = [[BackCartViewController alloc] init];
                        
                        vc.sigen=self.sigen;
                        
                        vc.delegate=self;
                        
                        vc.jindu = self.jindu;
                        vc.weidu = self.weidu;
                        vc.MapStartAddress = self.MapStartAddress;
                        
                        [self.navigationController pushViewController:vc animated:NO];
                        
                        
                        
                    }]];
                    
                    [self presentViewController: alertCon animated: YES completion: nil];
                    
                    
//                    [JRToast showWithText:dict[@"message"] duration:1.0f];
                    
                }else{
                    
                    [hud dismiss:YES];
                    
                    [JRToast showWithText:dict[@"message"] duration:1.0f];
                    
                    CartString = dict[@"goods_sum"];
                    countLabel.text = CartString;
                    
                    countLabel.hidden = NO;
                    RedImgView.hidden = NO;
                }
                
                
            }
            
        }else{
            
            
            NSLog(@"error");
            
        }
        
        
    }];
    
}


-(void)setSigenWithString:(NSString *)string1 andStatusWithString:(NSString *)string2 andIntegralWithString:(NSString *)string3 andPhoneWithString:(NSString *)string4 andHeaderImageWithString:(NSString *)string5 andUserId:(NSString *)string6
{
    self.sigen=string1;
    
    //    QueDingDingDanViewController *vc=[[QueDingDingDanViewController alloc] init];
    //
    //    vc.gid=self.gid;
    //    vc.sigen=self.sigen;
    //    vc.storename=self.storename;
    //    vc.logo=self.logo;
    //    vc.GoodsDetailType=self.SendWayType;
    //
    //
    //   [self.navigationController pushViewController:VC animated:NO];
    //
    //    self.navigationController.navigationBar.hidden=YES;
    
    
}

//刷新
- (IBAction)WebReloadData:(UIButton *)sender {
    
    
    [_datas removeAllObjects];
    
    
    NSLog(@"======%@==",self.ID);
    
    [self getDatas];
        
}

-(void)getDatas
{
    
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数组NSArray类型的数据
    self.sigen=[userDefaultes stringForKey:@"sigen"];
    
    
    self.note=@"";
    
    
    if (self.sigen.length==0) {
        
        self.sigen =@"";
        
    }
    
    WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@getMerchantsGoodsDetails_mob.shtml",URL_Str];
    
    NSDictionary *dic = @{@"sigen":self.sigen,@"id":self.ID};//,@"page":@"0",@"currentPageNo":@"1"};
    
    //    NSDictionary *dic=nil;
    YLog(@"canshu=%@",dic);
    [manager POST:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
        NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];
        
        
        
        
        if (codeKey && content) {
            NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
            
//            NSLog(@"xmlStr%@",xmlStr);
            
              [hud dismiss:YES];
            NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];
            
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            NSLog(@"tuwen  = %@",dic);
            view.hidden=YES;
            for (NSDictionary *dict in dic) {
                self.ShouCangStr=[NSString stringWithFormat:@"%@",dict[@"is_status"]];
                if ([dict[@"status"] isEqualToString:@"10000"]) {
                    
                    
                    
                    //进入商品详情显示购物车数量
                    if ([dict[@"goods_sum"] isEqualToString:@""]) {
                        
                        countLabel.hidden =YES;
                        RedImgView.hidden = YES;
                        
                    }else{
                        
                        RedImgView.hidden = NO;
                        countLabel.hidden =NO;
                        
                        if ([dict[@"goods_sum"] isEqualToString:@"0"]) {
                            
                            
                            countLabel.hidden=YES;
                            RedImgView.hidden = YES;
                            
                        }else{
                            
                            
                            countLabel.text = dict[@"goods_sum"];
                        }
                        
//                        countLabel.text = dict[@"goods_sum"];
                        
                    }
                    
                    
                    for (NSDictionary *dict1 in dict[@"list_goods"]) {
                        GoToShopModel *model=[[GoToShopModel alloc] init];
                        model.pay_integer=dict1[@"pay_integer"];
                        model.pay_maney=dict1[@"pay_maney"];
                        model.scopeimg=dict1[@"scopeimg"];
                        model.type=dict1[@"type"];
                        model.detailId=dict1[@"detailId"];
                        
                        
                        ImageString = dict1[@"scopeimg"];
                        MoneyString = dict1[@"pay_maney"];
                        IntergelString = dict1[@"pay_integer"];
                        
                        
                        self.note=dict1[@"note"];
                        
                        self.gid=dict1[@"id"];
                        
                        self.name=dict1[@"name"];
                        self.scopeimg=dict1[@"scopeimg"];
                        
                        [_redImg sd_setImageWithURL:[NSURL URLWithString:dict1[@"scopeimg"]] placeholderImage:[UIImage imageNamed:@"default_image"] options:SDWebImageProgressiveDownload];
                        
                        self.mid=dict1[@"mid"];
                        
                        if ([dict1[@"is_attribute"] isEqualToString:@"2"]) {
                            
                            self.stock = dict1[@"total_stock"];//判断库存为0，设置遮罩层
                            
//                            if (self.stock.length==0 || [self.stock isEqualToString:@"0"]) {
//                                
//                                self.stock = dict1[@"stock"];
//                            }
                        }else{
                            
                            self.stock = dict1[@"stock"];//判断库存为0，设置遮罩层
                            
                        }
                        
                        
                        self.Good_status=dict1[@"status"];
                        
                        self.good_type=dict1[@"good_type"];
                        
                        self.NewGoods_Type = dict1[@"good_type"];
                        
                        self.detailId2=dict1[@"detailId"];
                        
                        self.is_attribute=dict1[@"is_attribute"];
                        
                        self.attribute =dict1[@"is_attribute"];
                        
                        self.exchange=dict1[@"exchange"];
                        
                       
                        
                        [_datas addObject:model];
                    }
                    
                    self.logo=dict[@"merchants_map"][@"logo"];
                    
                    self.storename=dict[@"merchants_map"][@"storename"];
                    
                }else{
                    
                    
 //                   self.gid=[NSString stringWithFormat:@"1"];
                }
                
                
            }
          
        }
        
        
        
        
        
        
//        UIScrollView *webScrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 65, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 49-65)];
//        
//        webScrollView.delegate=self;
//        
//        webScrollView.pagingEnabled=YES;
//        
//        webScrollView.bounces=NO;
//        
//        webScrollView.showsVerticalScrollIndicator=YES;
//        
//        webScrollView.indicatorStyle=UIScrollViewIndicatorStyleWhite;
//        
//        webScrollView.contentSize = CGSizeMake(0, 2*[UIScreen mainScreen].bounds.size.height);
//        
//        [self.view addSubview:webScrollView];
//        
        
//
        
        UIImageView *imgView=[[UIImageView alloc] initWithFrame:CGRectMake(0, -[UIScreen mainScreen].bounds.size.height/2, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height/2-50)];
        
        [imgView sd_setImageWithURL:[NSURL URLWithString:self.scopeimg]];
        
        
//        [webScrollView addSubview:imgView];
        
        UILabel *nameLabel=[[UILabel alloc] initWithFrame:CGRectMake(10, -40, [UIScreen mainScreen].bounds.size.width-20, 40)];
        
        nameLabel.font=[UIFont systemFontOfSize:16];
        nameLabel.numberOfLines=0;
        nameLabel.text=self.name;
//
//        [webScrollView addSubview:nameLabel];
        
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-KSafeAreaTopNaviHeight-50-KSafeAreaBottomHeight)];
        
        //滑动
//        _webView.scrollView.scrollEnabled=YES;
        
        
 //       _webView.scrollView.contentInset=UIEdgeInsetsMake([UIScreen mainScreen].bounds.size.height/2, 0, 0, 0);
        
//        [_webView.scrollView addSubview:imgView];
//        [_webView.scrollView addSubview:nameLabel];
        
        //缩放到屏幕大小0
        _webView.scalesPageToFit=YES;
//
//        [_webView setScalesPageToFit:YES];
        _webView.delegate = self;
        
        //创建刷新头 和 刷新尾
//        refreshHeaderView = [[MJRefreshHeaderView alloc] initWithScrollView:_webView.scrollView];
        
        _webView.scrollView.delegate=self;
        //设置代理
//        refreshHeaderView.delegate = self;
        
        //NSLog(@"%@",self.imgUrlstr)
        
        
        NSString *bb = self.note;
//        NSLog(@"888888888==%@",bb);
        [_webView loadHTMLString:bb baseURL:nil];
//        [_webView loadHTMLString:self.note baseURL:nil];
        
        
        [self.view addSubview:_webView];
        
        
        _zhiding=[UIButton buttonWithType:UIButtonTypeCustom];
        _zhiding.hidden=YES;
        
        _zhiding.frame=CGRectMake(_webView.frame.size.width-44, _webView.frame.size.height-80, 44, 44);
        //        _zhiding.backgroundColor=[UIColor orangeColor];
        [_zhiding setBackgroundImage:[UIImage imageNamed:@"置顶"] forState:0];
        _zhiding.layer.masksToBounds = YES;
        _zhiding.layer.cornerRadius = _zhiding.bounds.size.width*0.5;
        
        [_zhiding addTarget:self action:@selector(gotoYT) forControlEvents:UIControlEventTouchUpInside];
        
        [_webView addSubview:_zhiding];
        
//        
//        _refresh=[[DJRefresh alloc] initWithScrollView:_webView.scrollView delegate:self];
//        _refresh.topEnabled=YES;//下拉刷新
//        _refresh.bottomEnabled=NO;//上拉加载
        
        self.webView.scrollView.av_footer = [AVHeaderRefresh headerRefreshWithScrollView:self.webView.scrollView headerRefreshingBlock:^{
            [self loadNewData];
        }];
        
        
        //纯积分不能加入购物车
        if ([self.good_type isEqualToString:@"1"]||[self.good_type isEqualToString:@"8"]) {
            
            CartButton.enabled=NO;//纯积分不能加入购物车
            CartButton.backgroundColor=[UIColor colorWithRed:226/255.0 green:226/255.0 blue:226/255.0 alpha:1.0];
            
            //创建遮罩层
            UIImageView *bgImgView1 = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-AddButtonWidth-100, [UIScreen mainScreen].bounds.size.height-49, AddButtonWidth,49)];
            bgImgView1.image = [UIImage imageNamed:@"遮造层"];
            
         //   [self.view addSubview:bgImgView1];
        }
        
        
        //库存为0，设置遮罩层
        if ([self.stock isEqualToString:@"0"]) {
            
            [self GoodsByNone];
            
            
        }else{
            
            
            if ([self.TTTTTTT isEqualToString:@"0"]) {
                
                
                [self GoodsByNone];
            }
        }
        
        
        if ([self.NewHomeString isEqualToString:@"1"]) {
            
            if ([self.Good_status isEqualToString:@"1"] && [self.stock isEqualToString:@"0"]) {
                
                
                [self GoodsByNone];
            }else if([self.Good_status isEqualToString:@"1"] && ![self.stock isEqualToString:@"0"]){
                
                [self GoodsDownToStore];
            }else{
                
                
            }
            
        }else{
            
            if ([self.Good_status isEqualToString:@"1"]) {
                
                [self GoodsDownToStore];
            }
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        
        [self NoWebSeveice];
        
    }];
}

//创建商品已下架
-(void)GoodsDownToStore
{
    
    NoGoods = [[UIView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-49-25-KSafeAreaBottomHeight, [UIScreen mainScreen].bounds.size.width, 25)];
    
    NoGoods.backgroundColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0];
    
    [self.view addSubview:NoGoods];
    
    UILabel *NoLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, NoGoods.frame.size.width-100, 25)];
    
    NoLabel.text = @"商品已下架啦~";
    
    NoLabel.textColor = [UIColor whiteColor];
    
    NoLabel.textAlignment= NSTextAlignmentCenter;
    
    NoLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:10];
    
    [NoGoods addSubview:NoLabel];
    
    //创建遮罩层
    bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-AddButtonWidth-100, [UIScreen mainScreen].bounds.size.height-49-KSafeAreaBottomHeight, AddButtonWidth+100,49+KSafeAreaBottomHeight)];
    bgImgView.image = [UIImage imageNamed:@"遮造层"];
    
    CartButton.enabled = NO;
    NowBuyButton.enabled =NO;
    
    [self.view addSubview:bgImgView];
    
}

-(void)loadData
{
    
    
    WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
    
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        [hud dismiss:YES];
    });
    
//    [self getDatas];
    
    [_webView reload];
    
    
}


//返回
- (IBAction)backBtnClick:(UIButton *)sender {

    [UserMessageManager removeAllGoodsAttribute];
    [UserMessageManager removeAllImageSecect];
    
    //发送通知，购物修改数据
    
    NSNotification *notification = [[NSNotification alloc] initWithName:@"CartBdeagChange" object:nil userInfo:nil];
    
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    
    
    //发送通知给购物车刷新数据
    
    NSNotification *notification1 = [[NSNotification alloc] initWithName:@"CartReloadData" object:nil userInfo:nil];
    
    [[NSNotificationCenter defaultCenter] postNotification:notification1];
    
    
    NSArray *vcArray = self.navigationController.viewControllers;
    
    NSLog(@"==viewControllers===%@",vcArray);
    
    
    for(UIViewController *vc in vcArray)
    {
        
        if (vcArray.count==3) {
            
            self.tabBarController.tabBar.hidden=NO;
            
            [self.navigationController popToRootViewControllerAnimated:NO];
            
            break;
            
        }
        if ([vc isKindOfClass:[HomeLittleAppliancesVC class]]) {


            self.navigationController.navigationBar.hidden=YES;
            self.tabBarController.tabBar.hidden=YES;
            [self.navigationController popViewControllerAnimated:YES];
            break;
        }

         else if ([vc isKindOfClass:[SearchResultViewController class]]){
            
            //            NSLog(@"==SearchResultViewController===");
            self.navigationController.navigationBar.hidden=YES;
            self.tabBarController.tabBar.hidden=YES;
            
            [self.navigationController popToViewController:vc animated:NO];
            
            break;
            
        }

        else if ([vc isKindOfClass:[YTScoreViewController class]]){
            
//            NSLog(@"==YTScoreViewController===");
            self.navigationController.navigationBar.hidden=YES;
            self.tabBarController.tabBar.hidden=YES;
            
            [self.navigationController popToViewController:vc animated:NO];
            
        }else if ([vc isKindOfClass:[HomeLookAllViewController class]]){
            
            self.navigationController.navigationBar.hidden=YES;
            self.tabBarController.tabBar.hidden=YES;
            
            [self.navigationController popToViewController:vc animated:NO];
            
            break;
            
        }else if ([vc isKindOfClass:[HomeLookAllViewController1 class]]){
            
            self.navigationController.navigationBar.hidden=YES;
            self.tabBarController.tabBar.hidden=YES;
            
            [self.navigationController popToViewController:vc animated:NO];
            
            break;
            
        }else if ([vc isKindOfClass:[HomeLookAllViewController2 class]]){
            
            self.navigationController.navigationBar.hidden=YES;
            self.tabBarController.tabBar.hidden=YES;
            
            [self.navigationController popToViewController:vc animated:NO];
            
            break;
            
        }else if ([vc isKindOfClass:[HomeLookAllViewController3 class]]){
            
            self.navigationController.navigationBar.hidden=YES;
            self.tabBarController.tabBar.hidden=YES;
            
            [self.navigationController popToViewController:vc animated:NO];
            
            break;
            
        }else if ([vc isKindOfClass:[HomeLookAllViewController4 class]]){
            
            self.navigationController.navigationBar.hidden=YES;
            self.tabBarController.tabBar.hidden=YES;
            
            [self.navigationController popToViewController:vc animated:NO];
            
            break;
            
        }else if ([vc isKindOfClass:[NineAndNineViewController class]]){
            
            self.navigationController.navigationBar.hidden=YES;
            self.tabBarController.tabBar.hidden=YES;
            
            [self.navigationController popToViewController:vc animated:NO];
            
            break;
            
        }else if ([vc isKindOfClass:[LookAllViewController class]]){
            
            self.navigationController.navigationBar.hidden=YES;
            self.tabBarController.tabBar.hidden=YES;
            
            [self.navigationController popToViewController:vc animated:NO];
            
            break;
            
        }else if ([vc isKindOfClass:[GotoShopLookViewController class]]){
            
            self.navigationController.navigationBar.hidden=YES;
            self.tabBarController.tabBar.hidden=YES;
            
            [self.navigationController popToViewController:vc animated:NO];
            
            break;
            
        }else if ([vc isKindOfClass:[BackCartViewController class]]){
            
            self.navigationController.navigationBar.hidden=YES;
            self.tabBarController.tabBar.hidden=YES;
            
            [self.navigationController popToViewController:vc animated:NO];
            
            break;
            
        }else if ([vc isKindOfClass:[YTGoodsDetailViewController class]]){
            
            self.navigationController.navigationBar.hidden=YES;
            self.tabBarController.tabBar.hidden=YES;
            
            [self.navigationController popViewControllerAnimated:NO];
            
        }

    }
}



//立即购买
-(void)NoWebSeveice
{
    
    view=[[UIView alloc] initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    
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


//同店铺的不能购买
-(void)getDatas1
{
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeCustom];
    [SVProgressHUD showWithStatus:@"请耐心等待..."];
    NSNull *null=[[NSNull alloc] init];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@getConfirmOrderInfo_mob.shtml",URL_Str];
   
    //读取数组NSArray类型的数据
   self.sigen=[userDefaultes stringForKey:@"sigen"];
    
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
                    
                    
                }else if([self.NotBuy isEqualToString:@"10003"]) {
                    
                    [JRToast showWithText:self.NotBuyMessage duration:3.0f];
                    
                    
                }else if([self.NotBuy isEqualToString:@"10002"]) {
                    
                    [JRToast showWithText:self.NotBuyMessage duration:3.0f];
                    
                    
                }else if([self.NotBuy isEqualToString:@"10005"]) {
                    
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
                        
                        
                        if (self.YTStock.length==0) {
                            
                            if ([self.stock isEqualToString:@"0"]) {
                                
                                [JRToast showWithText:@"库存为0，无法购买" duration:3.0f];
                                
                                
                            }else{
                                
                                QueDingDingDanViewController *vc=[[QueDingDingDanViewController alloc] init];
                                
                                //    NewAddAddressViewController *vc=[[NewAddAddressViewController alloc] init];
                                
                                vc.gid=self.gid;
                                
                                vc.sigen=self.sigen;
                                
                                vc.midddd=self.mid;
                                
                                vc.storename=self.storename;
                                
                                vc.logo=self.logo;
                                
                                vc.GoodsDetailType=self.SendWayType;
                                
                                vc.Goods_Type_Switch=self.good_type;
                                
                                vc.SendWayType=self.SendWayType;
                                
                                vc.yunfei=self.yunfei;
                                
                                vc.attributenum = self.num;
                                vc.detailId = self.detailId;
                                vc.MoneyType = self.MoneyType;
                                
                                if ([self.is_attribute integerValue]==2){
                                    
                                    vc.num = 1;
                                    vc.detailId=self.detailId2;
                                    vc.MoneyType=@"0";
                                    vc.attributenum = @"1";
                                    vc.exchange = self.exchange;
                                    
                                    if ([self.Panduan integerValue]==2) {
                                        
                                        vc.attributenum = self.num;
                                        vc.detailId = self.detailId;
                                        vc.MoneyType = self.MoneyType;
                                        
                                    }
                                    
                                    if (vc.detailId.length != 0) {
                                        
                                        [self.navigationController pushViewController:vc animated:NO];
                                        
                                        self.navigationController.navigationBar.hidden=YES;
                                        
                                    }
                                    
                                }else{
                                    
                                    NSLog(@"^^^^^^^^^^^==%@",self.exchange);
                                    
                                    vc.exchange = self.exchange;
                                    
                                    if ([userDefaultes stringForKey:@"gouxuan"].length==0) {
                                        
                                        vc.MoneyType=@"0";
                                        
                                        
                                    }else{
                                        
                                        if ([[userDefaultes stringForKey:@"gouxuan"] isEqualToString:@"1"]) {
                                            
                                            vc.MoneyType=@"0";
                                            
                                        }else{
                                            
                                            vc.MoneyType=@"1";
                                        }
                                        
                                    }
                                    
                                    
                                    vc.detailId=@"";
                                    vc.SendWayType=self.SendWayType;
                                    [self.navigationController pushViewController:vc animated:NO];
                                    self.navigationController.navigationBar.hidden=YES;
                                }
                            }
                            
                        }else{
                            
                            QueDingDingDanViewController *vc=[[QueDingDingDanViewController alloc] init];
                            
                            //    NewAddAddressViewController *vc=[[NewAddAddressViewController alloc] init];
                            
                            vc.gid=self.gid;
                            
                            vc.sigen=self.sigen;
                            
                            vc.midddd=self.mid;
                            
                            vc.storename=self.storename;
                            
                            vc.logo=self.logo;
                            
                            vc.GoodsDetailType=self.SendWayType;
                            
                            vc.Goods_Type_Switch=self.good_type;
                            
                            vc.SendWayType=self.SendWayType;
                            
                            vc.yunfei=self.yunfei;
                            
                            vc.attributenum = self.num;
                            vc.detailId = self.detailId;
                            vc.MoneyType = self.MoneyType;
                            
                            if ([self.is_attribute integerValue]==2){
                                
                                vc.num = 1;
                                vc.detailId=self.detailId2;
                                vc.MoneyType=@"0";
                                vc.attributenum = @"1";
                                vc.exchange = self.exchange;
                                
                                if ([self.Panduan integerValue]==2) {
                                    
                                    vc.attributenum = self.num;
                                    vc.detailId = self.detailId;
                                    vc.MoneyType = self.MoneyType;
                                    
                                }
                                
                                if (vc.detailId.length != 0) {
                                    
                                    [self.navigationController pushViewController:vc animated:NO];
                                    
                                    self.navigationController.navigationBar.hidden=YES;
                                    
                                }
                                
                            }else{
                                
                                NSLog(@"^^^^^^^^^^^==%@",self.exchange);
                                
                                vc.exchange = self.exchange;
                                
                                if ([userDefaultes stringForKey:@"gouxuan"].length==0) {
                                    
                                    vc.MoneyType=@"0";
                                    
                                    
                                }else{
                                    
                                    if ([[userDefaultes stringForKey:@"gouxuan"] isEqualToString:@"1"]) {
                                        
                                        vc.MoneyType=@"0";
                                        
                                    }else{
                                        
                                        vc.MoneyType=@"1";
                                    }
                                    
                                }
                                
                                
                                vc.detailId=@"";
                                vc.SendWayType=self.SendWayType;
                                [self.navigationController pushViewController:vc animated:NO];
                                self.navigationController.navigationBar.hidden=YES;
                            }
                        }
                    }
                }
            }
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
 //       [WKProgressHUD popMessage:@"网络请求失败，请检查您的网络设置" inView:self.view duration:1.5 animated:YES];
        
        [self NoWebSeveice];
        
        NSLog(@"%@",error);
    }];
}


//获取属性数据
-(void)getGoodsAttributeDatas
{
    //    创建菊花
    WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
    
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
            
            //            NSLog(@"xmlStr%@",xmlStr);
            
            //菊花消失
            [hud dismiss:YES];
            
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
                
//                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:dic2[@"message"] message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//                
//                [alert show];
            }
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //       [WKProgressHUD popMessage:@"网络请求失败，请检查您的网络设置" inView:self.view duration:1.5 animated:YES];
        
        [self NoWebSeveice];
        
        NSLog(@"%@",error);
    }];
}


-(void)initview{
    
    self.view.backgroundColor = [UIColor blackColor];
    
    //    NSLog(@"ppppppppppppp==%@",self.gid);
    goodsMainview = [[GoodsDetailMainView alloc] initWithFrame:self.view.bounds];
    
    goodsMainview.vc = self;
    goodsMainview.delegate=self;
    
    [self.view addSubview:goodsMainview];
    goodsMainview.goodsDetail.delegate = self;
    
    NSLog(@"====sizearr.count===%ld",sizearr.count);
    NSLog(@"====colorarr.count===%ld",colorarr.count);
    NSLog(@"====BuLiaoarr3.count===%ld",BuLiaoarr3.count);
    NSLog(@"====Stylearr4.count===%ld",Stylearr4.count);
    NSLog(@"====Titlearr5.count===%ld",Titlearr5.count);
    
    
    [goodsMainview initChoseViewSizeArr:sizearr andColorArr:colorarr andArr3:BuLiaoarr3 andArr4:Stylearr4 andArr5:Titlearr5 andStockDic:stockdic andGoodsImageView:ImageString andMoney:MoneyString andJIFen:IntergelString andKuCun:StockString andGid:self.gid andcount:self.count andGoods_type:self.good_type andGoods_status:Goods_Status andback:self.Attribute_back andYTBack:@"200" andMid:self.mid andYYYY:self.YYYYYYY andSmallIds:@"" andStorename:self.storename andLogo:self.logo andSendWayType:self.SendWayType andMoneyType:self.MoneyType andSid:@"" andTf:@"" andCut:@"" andJinDu:self.jindu andWeiDu:self.weidu andAddressString:self.MapStartAddress andNewHomeString:self.NewHomeString];
    
    
}


- (IBAction)BuyBtnClick:(UIButton *)sender {
    
    
//    if (self.sigen.length==0) {
//        
//        ATHLoginViewController *vc=[[ATHLoginViewController alloc] init];
//        
//        vc.delegate=self;
//        
//        vc.backString=@"205";
//        
//        vc.gid = self.ID;
//        
//        [self.navigationController pushViewController:vc animated:NO];
//        
//        self.navigationController.navigationBar.hidden=YES;
//        
//        
//    }else{
    
    NSNull *null=[[NSNull alloc] init];
    if ([self.gid isEqual:null] ) {
        
        
    }else{
//    
//    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
//    //读取数组NSArray类型的数据
//    self.sigen=[userDefaultes stringForKey:@"sigen"];
//    
//    NSLog(@">>>>>>%@",self.sigen);
//    
//    
//    if (self.sigen.length==0 || [self.sigen isEqualToString:@""]) {
//        
////        NewLoginViewController *vc=[[NewLoginViewController alloc] init];
//        ATHLoginViewController *vc=[[ATHLoginViewController alloc] init];
//        vc.delegate=self;
//        
//        vc.backString=@"300";
//        
//        
//        [self.navigationController pushViewController:vc animated:NO];
//        
//        self.navigationController.navigationBar.hidden=YES;
//        
//    }else{
        
//        if ([self.ytString isEqualToString:@"20"]) {
//            
//            [self initview];
//            [goodsMainview show];
//            
//            
//        }
        
        if ([self.attribute isEqualToString:@"2"]) {
            
            self.YYYYYYY = @"2";
            
            [self initview];
            [goodsMainview show];
            
            
        }
        else{
            
            if (self.sigen.length==0) {
                
                
                ATHLoginViewController *vc=[[ATHLoginViewController alloc] init];
                vc.delegate=self;
                
                vc.backString=@"300";
                
                vc.OOOOOOOOO = @"333";
                
                vc.BackBack = @"100";
                
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
                
                vc.exchange =self.exchange;
                
                vc.Good_status = self.Good_status;
                
                vc.YTStatus = self.YTStatus;
                
                vc.stock = self.stock;
                
                NSLog(@"===登录====self.good_type===%@",self.good_type);
                
                
                [self.navigationController pushViewController:vc animated:NO];
                
                self.navigationController.navigationBar.hidden=YES;
                
            }else{
                
            if ([self.good_type isEqualToString:@"1"] && [self.Good_status isEqualToString:@"0"]) {
                
                [JRToast showWithText:@"请等待，限购商品暂未开抢" duration:3.0f];
                
                //            XSInfoViewStyle *style = [[XSInfoViewStyle alloc] init];
                //            style.info = @"请等待，限购商品暂未开抢";
                //
                //            style.layoutStyle = XSInfoViewLayoutStyleHorizontal;
                //
                //            [XSInfoView showInfoWithStyle:style onView:self.view];
                
            }else{
                
                
                if (self.YTStock.length==0) {
                    
                    if ([self.stock isEqualToString:@"0"]) {
                        
                        [JRToast showWithText:@"库存为0，无法购买" duration:3.0f];
                        
                        
                        
                    }else{
                        
                        NSLog(@"6666666");
                        
                        if (self.gid.length==0) {
                            
                            
                            [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeCustom];
                            [SVProgressHUD showWithStatus:@"请点击刷新按钮,耐心等待..."];
                            
                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                
                                [SVProgressHUD dismiss];
                                
                            });
                            
                        }else{
                            
                            [self getDatas1];
                        }
                    }
                    
                }else{
                    
                    NSLog(@"777777");
                    
                    if (self.gid.length==0) {
                        
                        
                        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeCustom];
                        [SVProgressHUD showWithStatus:@"请点击刷新按钮,耐心等待..."];
                        
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            
                            [SVProgressHUD dismiss];
                            
                        });
                        
                    }else{
                        
                        [self getDatas1];
                    }
                }
            }
        }
    }
  }
//  }
}

-(void)NowBuyBtnClick
{
    NSLog(@"===mvkmvkfmvkmvfkmv====");
    
    QueDingDingDanViewController *vc=[[QueDingDingDanViewController alloc] init];
    
    
    vc.logo=self.logo;
    vc.storename=self.storename;
    vc.gid=self.gid;
    
    [self.navigationController pushViewController:vc animated:NO];
    
    self.navigationController.navigationBar.hidden=YES;
}


- (void)refresh:(DJRefresh *)refresh didEngageRefreshDirection:(DJRefreshDirection)direction{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self addDataWithDirection:direction];
    });
    
}

- (void)loadNewData{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.00001 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        
        //发送通知，默认选中
        
        NSNotification *notionfication1 = [[NSNotification alloc] initWithName:@"tuwenmoren" object:nil userInfo:nil];
        
        [[NSNotificationCenter defaultCenter] postNotification:notionfication1];
        
        
        YTGoodsDetailViewController *vc=[[YTGoodsDetailViewController alloc] init];
        
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        //读取数组NSArray类型的数据
        if ([userDefaultes stringForKey:@"text"].length>0) {
            
            vc.YXZattribute=[userDefaultes stringForKey:@"text"];
            
        }
        
        NSLog(@"$$$$$$$$$$$$===%@",[userDefaultes stringForKey:@"text"]);
        
        NSLog(@"$$$$$$$$$$$$==self.TTTTTTT==%@",self.TTTTTTT);
        
        vc.gid=self.gid;
        vc.ID=self.gid;
        vc.ytBack=@"100";
        vc.NewHomeString = self.NewHomeString;
        vc.good_type=self.good_type;
        vc.status=self.Good_status;
        vc.attribute = self.is_attribute;
        vc.YXZattribute=@"";
        vc.Attribute_back=@"2";
        vc.TTTTTT = self.TTTTTTT;
        
        [self.navigationController pushViewController:vc animated:NO];
        
        self.navigationController.navigationBar.hidden=YES;
        
        [self.webView.scrollView.av_footer endHeaderRefreshing];
        
    });
    
}

- (void)addDataWithDirection:(DJRefreshDirection)direction{
    
    if (direction==DJRefreshDirectionTop) {
        
        YTGoodsDetailViewController *vc=[[YTGoodsDetailViewController alloc] init];
        vc.gid=self.gid;
        vc.ID=self.gid;
        vc.ytBack=@"100";
//        vc.type=@"1";
        vc.good_type=self.good_type;
        vc.status=self.Good_status;
        vc.attribute = self.is_attribute;
        vc.NewHomeString = self.NewHomeString;
        vc.Attribute_back=@"2";
        
        vc.YXZattribute=@"";
        
        NSLog(@"图文详情上拉==%@===%@",self.TTTTTTT,self.NewHomeString);
        
        
        
        [self.navigationController pushViewController:vc animated:NO];
        
        self.navigationController.navigationBar.hidden=YES;
        
        

    }
    
    
    
    [_refresh finishRefreshingDirection:direction animation:YES];
    
    
}

#pragma  mark - MJRefreshBaseViewDelegate
//开始刷新
-(void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    //刷新头部, 下拉刷新
    if (refreshView == refreshHeaderView) {
        
        
        //发送通知，商品详情修改已选
        
        NSNotification *notionfication = [[NSNotification alloc] initWithName:@"TuWenXiangQingChangeAttribute" object:nil userInfo:nil];
        
        [[NSNotificationCenter defaultCenter] postNotification:notionfication];
        
        
        
        
        
        
        YTGoodsDetailViewController *vc=[[YTGoodsDetailViewController alloc] init];
        vc.gid=self.gid;
        vc.ID=self.gid;
        vc.ytBack=@"100";
        vc.NewHomeString = self.NewHomeString;
        vc.good_type=self.good_type;
        vc.status=self.Good_status;
        vc.attribute = self.is_attribute;
        
        vc.Attribute_back=@"2";
        
        NSLog(@"+++++++++===%@===self.NewHomeString==%@",self.TTTTTTT,self.NewHomeString);
        
        [self.navigationController pushViewController:vc animated:NO];
        
        self.navigationController.navigationBar.hidden=YES;
        
    }
//
//    
}
//
//-(void)dealloc
//{
//    //释放资源(移除kvo)
//    [refreshHeaderView endRefreshing];
//}

- (void)webViewDidFinishLoad:(UIWebView *)webView{

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

-(void)MakeSelfMessage
{
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
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0 ) {
//        [_locationManager requestAlwaysAuthorization];
        [_locationManager requestWhenInUseAuthorization];
    }
    
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

-(void)setShouCangStr:(NSString *)ShouCangStr
{
    _ShouCangStr=ShouCangStr;
    if ([ShouCangStr isEqualToString:@"1"]) {
        ShouCangBut.selected=YES;
        [ShouCangBut setImage:KImage(@"13btn_collection") forState:0];
    }else
    {
        ShouCangBut.selected=NO;
        [ShouCangBut setImage:KImage(@"13btn_notcollected") forState:0];
    }
}
@end
