//
//  NewHomeViewController.m
//  aTaohMall
//
//  Created by JMSHT on 16/5/10.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import "NewHomeViewController.h"

#import "TableViewCell.h"
#import "NewHomeHeaderView.h"
#import "PeccantViewController.h"
#import "MessageListVC.h"
#import "NineAndNineViewController.h"//九块九包邮
#import "ChunJiFenShopViewController.h"//纯积分商城
#import "ClassifyControllectionCell.h"

#import "TelephoneBillViewController.h"//话费
#import "PhoneFlowViewController.h"//流量
#import "GameViewController.h"//游戏
#import "TrainViewController.h"
#import "AeroplaneViewController.h"
#import "PeccantViewController.h"
#import "LookAllViewController.h"//查看全部

#import "GoodsDetailViewController.h"//商品详情

#import "NewGoodsDetailViewController.h"//新商品详情

#import "AFNetworking.h"
#import "TrainToast.h"
#import "NewGameViewController.h"
//加密
#import "ConverUtil.h"
#import "DESUtil.h"
#import "SecretCodeTool.h"

#import "HomeModel.h"
#import "HomeModel1.h"
#import "HomeModel2.h"

#import "ClassifySearchViewController.h"//搜索

#import "UIImageView+WebCache.h"

#import "QueDingDingDanViewController.h"


#import "HomeLookAllCell1.h"
#import "HomeLookAllCell2.h"
#import "HomeLookAllCell3.h"
#import "HomeLookAllCell4.h"
#import "HomeLookAllCell5.h"
#import "AirNoticeView.h"
#import "UserMessageManager.h"//缓存用户名

#import "NewLoginViewController.h"//登录

#import "AppDelegate.h"

#import "HomeCell1.h"
#import "HomeCell2.h"
#import "HomeCell3.h"
#import "HomeCell4.h"
#import "HomeCell5.h"

//刷新
#import "DJRefresh.h"
#import "DJRefreshProgressView.h"

#import "WKProgressHUD.h"//加载小时图

#import "XSInfoView.h"

#import "JRToast.h"

#import "NoCollectionViewCell.h"
#import "MerchantDetailViewController.h"

#import "YTGoodsDetailViewController.h"

#import "ATHLoginViewController.h"

#import "YTScoreViewController.h"

#import "SSPopup.h"

#import "NewHomeCell.h"
#import "NewHomeCell1.h"
#import "NewHomeCell2.h"
#import "NewHomeCell3.h"
#import "NewHomeCell4.h"
#import "FristHomeCell.h"
#import "NewSaoYiSaoViewController.h"

#import "RecetHomeHeaderView.h"
//MapKit是原生地图框架
#import <MapKit/MapKit.h>

//CoreLocation是定位框架
#import <CoreLocation/CoreLocation.h>
#import "BMNewGameAndPhoneViewController.h"
#import "BMPlaneAndTrainViewController.h"
#import "ForYouSelectViewController.h"
#import "DPCommandViewController.h"
#import "ZTSelectViewController.h"
#import "JXSelectViewController.h"
#import "JXSelectDetailViewController.h"


#import "PersonalAllDanVC.h"
#import "HomeLittleAppliancesVC.h"
#import "HomeBigHealthyVC.h"


#import "HomeAbroadShoppingVC.h"
#import "HomeHaveGoodShoppingVC.h"
#import "HomeHotSaleVC.h"
#import "HomeGoodGoodsHotSaleVC.h"
#import "HomeGeekGoodsListVC.h"
#import "HomeLatestGoodsListVC.h"
#import "HomeDaiPaiSuggestListVC.h"

#import "NewLookAllViewController.h"

#import "AllSingleShoppingModel.h"
#import "HomeDPModel.h"
#import "XLHomeRemenModel.h"

#define HHH ([UIScreen mainScreen].bounds.size.width)*310.0/750

@interface NewHomeViewController ()<UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UISearchBarDelegate,UIApplicationDelegate,LoginMessageDelegate,DJRefreshDelegate,UIAlertViewDelegate,SSPopupDelegate,RecetHomeHeaderDelegate,MKMapViewDelegate, CLLocationManagerDelegate,UITabBarControllerDelegate>
{
    UITableView *_tableView;
    //    NewHomeHeaderView *_headerView;
    RecetHomeHeaderView *_headerView;
    UICollectionView *_collectionView;
    UICollectionView *_collectionView1;
    UICollectionView *_collectionView2;
    UICollectionView *_collectionView3;
    UICollectionView *_collectionView4;
    UICollectionView *_collectionView5;
    UICollectionView *_collectionView6;

    NSMutableArray *_datasArrM1;
    NSMutableArray *_datasArrM2;
    NSMutableArray *_datasArrM3;
    NSMutableArray *_datasArrM4;
    NSMutableArray *_datasArrM5;
    NSMutableArray *_datasArrM6;
    NSMutableArray *_datasArrM7;

    NSArray *array;

    UIView *view;

    //   UIView *view1;
    //   UIImageView *ColorImg;

    CGFloat  cellHeight;//cell的高度；

    //    HomeLookAllCell5 *cell5;

    NSString *ShenJi;

    //地图View
    MKMapView *_mapView;

    //定位管理器
    CLLocationManager *_locationManager;

    UIButton *_zhiding;

    NSMutableArray *_ImageViewArrM;
    NSMutableArray *_list1;
    NSMutableArray *_list2;
    NSMutableArray *_list4;//潮流好货
    NSMutableArray *_DPArrM;
    NSMutableArray *_HaoHuoArrM;
    NSMutableArray *_JXArrM;
    NSMutableArray *_HDArrM;
    NSMutableArray *_TopBangArrM;
    NSMutableArray *_ReMenSCArrM;
    NSMutableArray *_RMIDArrM;

    NSMutableArray *_RemenSMArr;
    NSMutableArray *_new_product_list;

    UIImageView *IVYuan;

    NSString *JKSTR;
    NSString *JKSTR2;
    NSString *postPic;

    WKProgressHUD *hud;
}

@property (nonatomic,strong)DJRefresh *refresh;

@property (nonatomic,strong)NSString *isShowHuiQiangGou;
@property (nonatomic,strong)NSString *isShowHongKong;

@property (nonatomic)BOOL isShowHomeLittle;

@property(nonatomic,strong) NSString *totalNum;

@property (nonatomic,assign)NSInteger datacount;


@end

@implementation NewHomeViewController

/*******************************************************      控制器生命周期       ******************************************************/

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    self.navigationController.navigationBar.hidden=YES;
    self.tabBarController.tabBar.hidden = NO;

    [self.navigationController popToRootViewControllerAnimated:NO];
    NSString *sigen=[NSString stringWithFormat:@"%@",[kUserDefaults  objectForKey:@"sigen"]];
    if ([sigen containsString:@"null"]||[sigen isEqualToString:@""]) {
        self.totalNum=[JMSHTDBDao getUnreadMessageNumFromMessageList];
    }else
    {
        [ATHRequestManager requestForGetUnreadMessageNumWithParams:@{@"sigen":sigen} successBlock:^(NSDictionary *responseObj) {
            if ([responseObj[@"status"] isEqualToString:@"10000"]) {
                self.totalNum=[NSString stringWithFormat:@"%@",responseObj[@"total_number"]];
            }

        } faildBlock:^(NSError *error) {

        }];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置代理
    self.tabBarController.delegate=self;
    [self initProperty];
    [self SetUI];

    [self SetData];
    [KNotificationCenter addObserver:self selector:@selector(receivePushNoti:) name:JMSHTReceivePushNoti object:nil];

}



//设置获取数据
-(void)SetData
{
    [self getCacheData];
    hud=[WKProgressHUD showInView:self.view withText:@"" animated:YES];
    //获取数据
    [self getDatas];

    [self getdata1];

    [self getDatas1];


    [self getDatas4];

    [self getDatas5];
    [self getdatas6];
    [self getAPP];
}
//设置初始化视图
-(void)SetUI
{
    [self initTableView];
    /*
     顶部红色导航
     */
    UIView  *view1=[[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, KSafeAreaTopNaviHeight)];

    view1.backgroundColor=[UIColor clearColor];

    UIImageView *ColorImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, KSafeAreaTopNaviHeight)];
    ColorImg.image = [UIImage imageNamed:@"top"];
    [view1 addSubview:ColorImg];

    [self.view addSubview:view1];

    UIView *searchView = [[UIView alloc] initWithFrame:CGRectMake(52, 25+KSafeTopHeight, [UIScreen mainScreen].bounds.size.width-52-50, 28)];
    searchView.backgroundColor =[UIColor whiteColor];
    searchView.layer.cornerRadius  = 3;
    searchView.layer.masksToBounds = YES;
    [view1 addSubview:searchView];

    //搜索添加手势
    searchView.userInteractionEnabled = YES;
    UITapGestureRecognizer *imgRecongnizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headSearchClick:)];
    [searchView addGestureRecognizer:imgRecongnizer];

    UIButton *messageBut=[UIButton buttonWithType:UIButtonTypeCustom];
    messageBut.frame=CGRectMake(kScreen_Width-30, 31+KSafeTopHeight, 20, 20);
    [messageBut setImage:KImage(@"xlhome-消息") forState:UIControlStateNormal];
    [messageBut setTitleColor:[UIColor whiteColor] forState:0];
    [messageBut addTarget:self action:@selector(CheckMessages:) forControlEvents:UIControlEventTouchUpInside];
    messageBut.adjustsImageWhenHighlighted=NO;
    [view1 addSubview:messageBut];

    if (!IVYuan) {
        IVYuan=[[UIImageView alloc]initWithFrame:CGRectMake(kScreen_Width-18, 31+KSafeTopHeight, 8, 8)];
        IVYuan.image=[UIImage imageNamed:@"icon_news-yuan"];
        [view1 addSubview:IVYuan];
        IVYuan.hidden=YES;
    }
    UIImageView *imgView=[[UIImageView alloc] initWithFrame:CGRectMake(10, 7, 14, 14)];
    imgView.image=[UIImage imageNamed:@"搜索"];
    [searchView addSubview:imgView];


    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(10, 28+KSafeTopHeight, 22, 22);
    [button setBackgroundImage:[UIImage imageNamed:@"xlhome-扫码"] forState:0];
    [button setTitleColor:[UIColor whiteColor] forState:0];

    [button addTarget:self action:@selector(saoyisaoBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [view1 addSubview:button];

    /*
     置顶按钮
     */
    _zhiding=[UIButton buttonWithType:UIButtonTypeCustom];
    _zhiding.hidden=YES;

    _zhiding.frame=CGRectMake(self.view.frame.size.width-44, self.view.frame.size.height-120+KSafeAreaBottomHeight, 44, 44);
    //        _zhiding.backgroundColor=[UIColor orangeColor];
    [_zhiding setBackgroundImage:[UIImage imageNamed:@"置顶"] forState:0];
    _zhiding.layer.masksToBounds = YES;
    _zhiding.layer.cornerRadius = _zhiding.bounds.size.width*0.5;

    [_zhiding addTarget:self action:@selector(gotoYT) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:_zhiding];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.hidden=YES;
    //自动偏移
    self.automaticallyAdjustsScrollViewInsets=NO;
}
//设置初始化一些属性
-(void)initProperty
{
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数组NSArray类型的数据
    self.userid=[userDefaultes stringForKey:@"userid"];
    [UserMessageManager FenLeiRemove];
    ShenJi=@"100";
    self.datacount=0;
    JKSTR=@"";
    JKSTR2=@"";
    postPic=@"";
    _list1 = [NSMutableArray new];

    _list2 = [NSMutableArray new];

    _list4 = [NSMutableArray new];

    _DPArrM = [NSMutableArray new];

    _HaoHuoArrM = [NSMutableArray new];

    _JXArrM = [NSMutableArray new];

    _HDArrM = [NSMutableArray new];

    _TopBangArrM= [NSMutableArray new];
    _ReMenSCArrM = [NSMutableArray new];
    _RMIDArrM=[NSMutableArray new];

    _RemenSMArr = [NSMutableArray new];
    _new_product_list=[NSMutableArray new];

    _headerArrM=[NSMutableArray new];
    _attibuteArm = [NSMutableArray new];

    _datasArrM1=[NSMutableArray new];
    _datasArrM2=[NSMutableArray new];
    _datasArrM3=[NSMutableArray new];
    _datasArrM4=[NSMutableArray new];
    _datasArrM5=[NSMutableArray new];
    _datasArrM6=[NSMutableArray new];
    _datasArrM7=[NSMutableArray new];

    self.view.frame=[UIScreen mainScreen].bounds;
    _ImageViewArrM=[NSMutableArray new];
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

/*******************************************************      数据请求       ******************************************************/
//获取好店
-(void)getDatas1
{
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数组NSArray类型的数据
    self.sigen=[NSString stringWithFormat:@"%@",[userDefaultes stringForKey:@"sigen"]];

    if (self.sigen||([self.sigen isEqual:[[NSNull alloc] init]])||([self.sigen isEqualToString:@""])) {

        self.sigen = @"";

    }

    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];

    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    NSDictionary *dict=@{@"sigen":self.sigen};

    NSString *url=[NSString stringWithFormat:@"%@getHomePageData_mob.shtml",URL_Str];

    [manager POST:url parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {


    } success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
        NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];

        if (codeKey && content) {
            NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];

            NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];

            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];

            NSLog(@"xmlStr==新首页数据=22222=%@",xmlStr);


            if ([dic[@"status"] isEqualToString:@"10000"]) {

                [_HDArrM removeAllObjects];
                for (NSDictionary *dict1 in dic[@"list_store_all"]) {

                    HomeModel *model=[[HomeModel alloc] init];

                    NSLog(@"===logo===%@",dict1[@"logo"]);

                    model.logo = [NSString stringWithFormat:@"%@",dict1[@"logo"]];
                    model.click_volume = [NSString stringWithFormat:@"%@",dict1[@"click_volume"]];
                    model.storename = [NSString stringWithFormat:@"%@",dict1[@"storename"]];
                    model.mid = [NSString stringWithFormat:@"%@",dict1[@"mid"]];
                    model.array = dict1[@"list_pic"];
                    [_HDArrM addObject:model];

                }

            }

        }
        self.datacount=_datacount+1;
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        self.datacount=_datacount+1;

    }];
}
//top榜单
-(void)getDatas4
{



    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];

    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *url=[NSString stringWithFormat:@"%@getPageTOPData_mob.shtml",URL_Str];

    [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {


    } success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
        NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];

        if (codeKey && content) {
            NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];

            NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];

            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];

            NSLog(@"xmlStr==新首页数据=22222=%@",xmlStr);


            if ([dic[@"status"] isEqualToString:@"10000"]) {

                [_TopBangArrM removeAllObjects];

                for (NSDictionary *dict1 in dic[@"good_list"]) {

                    XLHomeTopBangModel *topmodel=[[XLHomeTopBangModel alloc] init];
                    topmodel.scope=[NSString stringWithFormat:@"%@",dict1[@"scope"]];
                    for (NSDictionary *dict2 in dict1[@"good_list"]) {

                        AllSingleShoppingModel *model=[[AllSingleShoppingModel alloc] init];
                        model.gid=[NSString stringWithFormat:@"%@",dict2[@"id"]];
                        model.mid=[NSString stringWithFormat:@"%@",dict2[@"mid"]];
                        model.name=[NSString stringWithFormat:@"%@",dict2[@"name"]];
                        model.scopeimg=[NSString stringWithFormat:@"%@",dict2[@"scopeimg"]];
                        model.pay_integer=[NSString stringWithFormat:@"%@",dict2[@"pay_integer"]];
                        model.pay_maney=[NSString stringWithFormat:@"%@",dict2[@"pay_maney"]];
                        model.amount=[NSString stringWithFormat:@"%@",dict2[@"amount"]];
                        model.is_attribute=[NSString stringWithFormat:@"%@",dict2[@"is_attribute"]];
                        model.storename=[NSString stringWithFormat:@"%@",dict2[@"storename"]];
                        model.hot_index=[NSString stringWithFormat:@"%@",dict2[@"hot_index"]];
                        model.statu=[NSString stringWithFormat:@"%@",dict2[@"status"]];
                        [topmodel.good_list addObject:model];
                    }
                    [_TopBangArrM addObject:topmodel];
                }
            }
        }
        self.datacount=_datacount+1;
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        self.datacount=_datacount+1;

    }];

}
//
-(void)getDatas5
{

    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];

    manager.responseSerializer = [AFHTTPResponseSerializer serializer];


    NSString *url=[NSString stringWithFormat:@"%@getHotMarketAndSmallClassGoods_mob.shtml",URL_Str];

    [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {


    } success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
        NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];

        if (codeKey && content) {
            NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];

            NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];

            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];

            NSLog(@"xmlStr==新首页数据=22222=%@",xmlStr);
            NSLog(@"%@",dic);

            if ([dic[@"status"] isEqualToString:@"10000"]) {
                [_ReMenSCArrM removeAllObjects];
                [_RMIDArrM removeAllObjects];
                [_RemenSMArr removeAllObjects];
                [_new_product_list removeAllObjects];

                for (NSDictionary *dict1 in dic[@"list_big"]) {
                    [_ReMenSCArrM addObject:[NSString stringWithFormat:@"%@",dict1[@"name"]]];
                    [_RMIDArrM addObject:[NSString stringWithFormat:@"%@",dict1[@"id"]]];
                }


                for (NSDictionary *dict2 in dic[@"list_small"]) {
                    XLHomeRemenModel *model=[[XLHomeRemenModel alloc] init];
                    model.pid=[NSString stringWithFormat:@"%@",dict2[@"pid"]];
                    model.Name=[NSString stringWithFormat:@"%@",dict2[@"name"]];
                    model.list=dict2[@"list"];
                    [_RemenSMArr addObject:model];
                }

                for (NSDictionary *dict3 in dic[@"new_product_list"]) {
                    AllSingleShoppingModel *model=[[AllSingleShoppingModel alloc] init];
                    model.gid=[NSString stringWithFormat:@"%@",dict3[@"gid"]];
                    model.mid=[NSString stringWithFormat:@"%@",dict3[@"mid"]];
                    model.name=[NSString stringWithFormat:@"%@",dict3[@"name"]];
                    model.scopeimg=[NSString stringWithFormat:@"%@",dict3[@"scopeimg"]];
                    model.pay_integer=[NSString stringWithFormat:@"%@",dict3[@"pay_integer"]];
                    model.pay_maney=[NSString stringWithFormat:@"%@",dict3[@"pay_maney"]];
                    model.amount=[NSString stringWithFormat:@"%@",dict3[@"amount"]];
                    model.is_attribute=[NSString stringWithFormat:@"%@",dict3[@"is_attribute"]];
                    model.storename=[NSString stringWithFormat:@"%@",dict3[@"storename"]];
                    model.statu=[NSString stringWithFormat:@"%@",dict3[@"status"]];
                    [_new_product_list addObject:model];
                }
            }
            for (int i=0; i<_RemenSMArr.count; i++) {
                XLHomeRemenModel *model=_RemenSMArr[i];
                if (i==0) {
                    _datasArrM4=[model.list mutableCopy];
                }else if (i==1)
                {
                    _datasArrM3=[model.list mutableCopy];
                }else if (i==2)
                {
                    _datasArrM5=[model.list mutableCopy];
                }else if (i==3)
                {
                    _datasArrM6=[model.list mutableCopy];
                }
            }
            _datasArrM7=[_new_product_list copy];
        }
        self.datacount=_datacount+1;
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        self.datacount=_datacount+1;
    }];

}

//
-(void)getdatas6
{

    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];

    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    NSString *url=[NSString stringWithFormat:@"%@getYouLikeGoodsList_mob.shtml",URL_Str];

    [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {


    } success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
        NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];
        //  [_tableView.mj_footer endRefreshing];
        if (codeKey && content) {
            NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];

            NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];

            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];

            NSLog(@"xmlStr==新首页数据=22222=%@",xmlStr);


            if ([dic[@"status"] isEqualToString:@"10000"]) {


                for (NSDictionary *dict1 in dic[@"list_goods"]) {

                    AllSingleShoppingModel *model=[[AllSingleShoppingModel alloc] init];
                    model.gid=[NSString stringWithFormat:@"%@",dict1[@"gid"]];
                    model.mid=[NSString stringWithFormat:@"%@",dict1[@"mid"]];
                    model.name=[NSString stringWithFormat:@"%@",dict1[@"name"]];
                    model.scopeimg=[NSString stringWithFormat:@"%@",dict1[@"scopeimg"]];
                    model.pay_integer=[NSString stringWithFormat:@"%@",dict1[@"pay_integer"]];
                    model.pay_maney=[NSString stringWithFormat:@"%@",dict1[@"pay_maney"]];
                    model.amount=[NSString stringWithFormat:@"%@",dict1[@"amount"]];
                    model.is_attribute=[NSString stringWithFormat:@"%@",dict1[@"is_attribute"]];
                    model.storename=[NSString stringWithFormat:@"%@",dict1[@"storename"]];
                    model.hot_index=[NSString stringWithFormat:@"%@",dict1[@"hot_index"]];
                    model.statu=[NSString stringWithFormat:@"%@",dict1[@"status"]];
                    [_datasArrM1 addObject:model];
                }
            }
        }
        self.datacount=self.datacount+1;
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        self.datacount=self.datacount+1;
    }];

}
//获取banner/热销家电、特色必逛、潮流好货数据
-(void)getDatas
{



    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{

    });


    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];

    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    NSDictionary *dict=@{@"sigen":[kUserDefaults objectForKey:@"sigen"]?[kUserDefaults objectForKey:@"sigen"]:@""};

    NSString *url=[NSString stringWithFormat:@"%@newHomePage_mob.shtml",URL_Str];

    [manager POST:url parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {


    } success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
        NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];

        if (codeKey && content) {
            NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];

            NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];

            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];

            NSLog(@"xmlStrnewHomePage_mob.shtml==新首页数据=11111=%@",xmlStr);
            YLog(@"dic=%@",dic);
            view.hidden=YES;

            if ([dic[@"status"] isEqualToString:@"10000"]) {
                [_ImageViewArrM removeAllObjects];

                [_list1 removeAllObjects];

                [_list2 removeAllObjects];

                [_list4 removeAllObjects];
                NSLog(@"%@",dic[@"integral_control"]);
                self.totalNum=[NSString stringWithFormat:@"%@",dic[@"total_number"]];
                NSLog(@"%@",self.totalNum);
                /*积分：dic[@"integral_control"]  小家电 dic[@"home_appliances"]  0展示、1不展示*/
                //  self.isShowHuiQiangGou=dic[@"integral_control"];
                self.isShowHuiQiangGou=@"1";
                self.isShowHomeLittle=[[NSString stringWithFormat:@"%@",dic[@"home_appliances"]] isEqualToString:@"0"];

                _headerView.isShowHQG=self.isShowHuiQiangGou;
                /*大健康 0不展示、1展示*/
                self.isShowHongKong=dic[@"health_goods_control"];
                //   self.isShowHongKong=@"0";
                _headerView.isShowBigHeathy=self.isShowHongKong;
                self.time = [NSString stringWithFormat:@"%@",dic[@"actual_time"]];

                for (NSDictionary *dict1 in dic[@"carousel_list"]) {

                    HomeModel *model=[[HomeModel alloc] init];

                    NSString *carousel_figure = [NSString stringWithFormat:@"%@",dict1[@"carousel_figure"]];

                    model.attribute = [NSString stringWithFormat:@"%@",dict1[@"is_attribute"]];
                    model.gid = [NSString stringWithFormat:@"%@",dict1[@"gid"]];

                    NSString *gid = [NSString stringWithFormat:@"%@",dict1[@"gid"]];
                    [_ImageViewArrM addObject:carousel_figure];//轮番图片

                    model.carousel_figure=carousel_figure;

                    [_headerArrM addObject:gid];

                    [_attibuteArm addObject:model.attribute];

                }


                for (NSDictionary *dict1 in dic[@"list1"]) {
                    YLog(@"%@",dict1);
                    HomeModel *model=[[HomeModel alloc] init];

                    model.ID = [NSString stringWithFormat:@"%@",dict1[@"id"]];
                    model.pay_integer = [NSString stringWithFormat:@"%@",dict1[@"pay_integer"]];
                    model.pay_maney = [NSString stringWithFormat:@"%@",dict1[@"pay_maney"]];
                    model.integral_type = [NSString stringWithFormat:@"%@",dict1[@"integral_type"]];
                    model.scopeimg = [NSString stringWithFormat:@"%@",dict1[@"scopeimg"]];
                    model.stock = [NSString stringWithFormat:@"%@",dict1[@"stock"]];
                    model.status = [NSString stringWithFormat:@"%@",dict1[@"status"]];

                    model.good_type=[NSString stringWithFormat:@"%@",dict1[@"good_type"]];
                    model.start_time=[NSString stringWithFormat:@"%@",dict1[@"start_time"]];
                    model.end_time=[NSString stringWithFormat:@"%@",dict1[@"end_time"]];
                    model.is_attribute=[NSString stringWithFormat:@"%@",dict1[@"is_attribute"]];

                    [_list1 addObject:model];

                }


                for (NSDictionary *dict1 in dic[@"list2"]) {

                    HomeModel *model=[[HomeModel alloc] init];

                    model.ID = [NSString stringWithFormat:@"%@",dict1[@"id"]];
                    model.special_name = [NSString stringWithFormat:@"%@",dict1[@"special_name"]];
                    model.subtitle = [NSString stringWithFormat:@"%@",dict1[@"subtitle"]];
                    model.picpath = [NSString stringWithFormat:@"%@",dict1[@"picpath"]];
                    [_list2 addObject:model];


                }
                for (NSDictionary *dict1 in dic[@"list4"]) {

                    AllSingleShoppingModel  *model=[[AllSingleShoppingModel alloc] init];

                    model.ID = [NSString stringWithFormat:@"%@",dict1[@"id"]];
                    model.main_title = [NSString stringWithFormat:@"%@",dict1[@"main_title"]];
                    model.subtitle = [NSString stringWithFormat:@"%@",dict1[@"subtitle"]];
                    model.path = [NSString stringWithFormat:@"%@",dict1[@"path"]];
                    model.mid= [NSString stringWithFormat:@"%@",dict1[@"mid"]];
                    model.gid= [NSString stringWithFormat:@"%@",dict1[@"gid"]];
                    [_list4 addObject:model];

                }

                [_headerView setIsShowHQG:self.isShowHuiQiangGou isShowBigHeathy:self.isShowHongKong isShowHomeLittile:self.isShowHomeLittle];
            }
            self.datacount=_datacount+1;


        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        self.datacount=_datacount+1;
        [JRToast showWithText:@"网络请求失败，请检查你的网络设置" duration:3.0f];

    }];
}
//大牌推荐、优选清单、好货特卖数据
-(void)getdata1
{




    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{

    });


    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];

    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    NSDictionary *dict=@{@"sigen":[kUserDefaults objectForKey:@"sigen"]?[kUserDefaults objectForKey:@"sigen"]:@""};

    NSString *url=[NSString stringWithFormat:@"%@getListingAndGoodGoods_mob.shtml",URL_Str];

    [manager POST:url parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {


    } success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
        NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];

        if (codeKey && content) {
            NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];

            NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];

            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];

            NSLog(@"大牌==新首页数据=11111=%@",xmlStr);
            YLog(@"dic=%@",dic);
            view.hidden=YES;

            if ([dic[@"status"] isEqualToString:@"10000"]) {
                [_DPArrM removeAllObjects];
                [_HaoHuoArrM removeAllObjects];
                [_JXArrM removeAllObjects];

                for (NSDictionary *dict1 in dic[@"list_big"]) {

                    HomeDPModel *model=[[HomeDPModel alloc] init];

                    model.ID = [NSString stringWithFormat:@"%@",dict1[@"id"]];
                    model.cream_name = [NSString stringWithFormat:@"%@",dict1[@"cream_name"]];
                    model.picpath = [NSString stringWithFormat:@"%@",dict1[@"home_path"]];
                    model.represent = [NSString stringWithFormat:@"%@",dict1[@"represent"]];
                    [_DPArrM addObject:model];
                    _headerView.DPArrM=_DPArrM;

                }


                for (NSDictionary *dict1 in dic[@"list1"]) {
                    YLog(@"%@",dict1);
                    HomeModel *model=[[HomeModel alloc] init];

                    model.title = [NSString stringWithFormat:@"%@",dict1[@"title"]];
                    model.ID = [NSString stringWithFormat:@"%@",dict1[@"id"]];
                    model.picpath = [NSString stringWithFormat:@"%@",dict1[@"picpath"]];
                    [_JXArrM addObject:model];
                    _headerView.JXlist=_JXArrM;

                }

                for (NSDictionary *dict1 in dic[@"list2"]) {

                    AllSingleShoppingModel  *model=[[AllSingleShoppingModel alloc] init];

                    model.ID = [NSString stringWithFormat:@"%@",dict1[@"id"]];
                    model.main_title = [NSString stringWithFormat:@"%@",dict1[@"main_title"]];
                    model.subtitle = [NSString stringWithFormat:@"%@",dict1[@"subtitle"]];
                    model.path = [NSString stringWithFormat:@"%@",dict1[@"path"]];
                    model.mid= [NSString stringWithFormat:@"%@",dict1[@"mid"]];
                    model.gid= [NSString stringWithFormat:@"%@",dict1[@"gid"]];
                    [_HaoHuoArrM addObject:model];
                    _headerView.HaoHuoArrM=_HaoHuoArrM;

                }

                JKSTR=[NSString stringWithFormat:@"%@",dic[@"main_title"]];
                JKSTR2=[NSString stringWithFormat:@"%@",dic[@"subtitle"]];
                postPic=[NSString stringWithFormat:@"%@",dic[@"post_picture"]];

                [_headerView setjikeStr:JKSTR andJikeSubStr:JKSTR2 andPostPic:postPic];

            }


            self.datacount=_datacount+1;

        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {


        self.datacount=_datacount+1;
        [JRToast showWithText:@"网络请求失败，请检查你的网络设置" duration:3.0f];


    }];


}



//获取下一次启动页的广告图片、避免下次加载太慢
-(void)getCacheData
{
    [ATHRequestManager requestforAppdelegateWithParams:nil successBlock:^(NSDictionary *responseObj) {
        NSLog(@"%@",responseObj);
        [kUserDefaults removeObjectForKey:@"AppStart-carousel_figure"];
        [kUserDefaults removeObjectForKey:@"APPStart-gid"];
        [kUserDefaults removeObjectForKey:@"APPStart-mid"];
        [kUserDefaults removeObjectForKey:@"APPStart-type"];
        [kUserDefaults removeObjectForKey:@"APPStart-id"];
        NSArray *list1=responseObj[@"list1"];
        for (NSDictionary *dic1 in list1) {

            NSString * carousel_figure=[NSString stringWithFormat:@"%@",dic1[@"carousel_figure"]];
            NSLog(@"self.carcousel=%@",carousel_figure);
            NSString *gid=[NSString stringWithFormat:@"%@",dic1[@"gid"]];
            NSString *mid=[NSString stringWithFormat:@"%@",dic1[@"mid"]];
            NSString *type=[NSString stringWithFormat:@"%@",dic1[@"type"]];
            NSString *ID=[NSString stringWithFormat:@"%@",dic1[@"id"]];

            UIImageView *IV=[[UIImageView alloc]initWithFrame:kScreen_Bounds];
            IV.hidden=YES;
            [self.view addSubview:IV];
            [IV sd_setImageWithURL:KNSURL(carousel_figure) completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                NSLog(@"huancunchenggongle");
                [kUserDefaults removeObjectForKey:@"AppStart-carousel_figure"];
                [kUserDefaults removeObjectForKey:@"APPStart-gid"];
                [kUserDefaults removeObjectForKey:@"APPStart-mid"];
                [kUserDefaults removeObjectForKey:@"APPStart-type"];
                [kUserDefaults removeObjectForKey:@"APPStart-id"];
                [kUserDefaults setObject:carousel_figure forKey:@"AppStart-carousel_figure"];
                [kUserDefaults setObject:gid  forKey:@"APPStart-gid"];
                [kUserDefaults setObject:mid forKey:@"APPStart-mid"];
                [kUserDefaults setObject:type forKey:@"APPStart-type"];
                [kUserDefaults setObject:ID forKey:@"APPStart-id"];
                [IV removeFromSuperview];

            }];

        }
    } faildBlock:^(NSError *error) {

    }];

}

//获取服务器版本数据、判断是否显示升级弹窗
-(void)getAPP
{

    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];

    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    //    NSDictionary *dict=@{@"exchange_id":@""};
    NSDictionary *dict=nil;

    //    NSString *url=[NSString stringWithFormat:@"%@getMoreMerchants_mob.shtml",URL_Str];
    NSString *url=[NSString stringWithFormat:@"%@getVersionNum_mob.shtml",URL_Str];
    //    NSLog(@"%@",url);

    [manager POST:url parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {


    } success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
        NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];

        if (codeKey && content) {
            NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];

            NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];

            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];

            //   NSLog(@"=========88888888====%@",xmlStr);

            NSString *executableFile = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleExecutableKey];    //获取项目名称

            NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey];      //获取项目版本号

            NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
            CFShow(CFBridgingRetain(infoDictionary));
            // app名称
            NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
            // app版本
            NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
            // app build版本
            NSString *app_build = [infoDictionary objectForKey:@"CFBundleVersion"];

            NSLog(@"====executableFile==%@",executableFile);
            NSLog(@"====version==%@",version);
            NSLog(@"====app_Name==%@",app_Name);
            NSLog(@"====app_Version==%@",app_Version);
            NSLog(@"====app_build==%@",app_build);

            NSLog(@"dict==getAPP=%@",dic);

            for (NSDictionary *dict1 in dic) {

                if ([dict1[@"version_num"] isEqualToString:app_Version]) {

                }else{

                    if([dict1[@"is_mandatory_update"] isEqualToString:@"1"]) {

                    }else{

                        SSPopup* selection=[[SSPopup alloc]init];
                        selection.backgroundColor=[UIColor colorWithWhite:0.00 alpha:0.4];
                        selection.frame = CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height);
                        selection.SSPopupDelegate=self;
                        selection.content = [NSString stringWithFormat:@"%@",dict1[@"content"]];//升级内容

                        [self.view  addSubview:selection];

                        [selection CreateYTView:nil withSender:nil withTitle:[NSString stringWithFormat:@"%@",dict1[@"content"]] setCompletionBlock:^(int tag) {

                        }];

                    }
                }
            }
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {

    }];


}

/*******************************************************      初始化视图       ******************************************************/
//创建表视图
-(void)initTableView
{
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-50-KSafeAreaBottomHeight-KSafeAreaTopNaviHeight) style:UITableViewStyleGrouped];
    if (@available(iOS 11.0, *)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;//UIScrollView也适用
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    //_tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, -20, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-29) style:UITableViewStyleGrouped];

    _tableView.backgroundColor = [UIColor whiteColor];

    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    _tableView.delegate=self;

    _tableView.dataSource=self;

    _tableView.estimatedRowHeight=0;
    _tableView.estimatedSectionFooterHeight=0;
    _tableView.estimatedSectionHeaderHeight=0;

    [self.view addSubview:_tableView];

    //    _tableView.tableHeaderView=_headerView;


    _headerView.userInteractionEnabled=YES;

    _tableView.showsVerticalScrollIndicator = NO;
    //    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getdatas6)];
    //    [footer setTitle:@"" forState:MJRefreshStateIdle];
    //    [footer setTitle:@"正在加载..." forState:MJRefreshStateRefreshing];
    //    [footer setTitle:@"暂无更多数据" forState:MJRefreshStateNoMoreData];
    //    _tableView.tableFooterView=footer;

    //注册Cell

    [_tableView registerNib:[UINib nibWithNibName:@"TableViewCell" bundle:nil] forCellReuseIdentifier:@"newHomeCell"];

    [_tableView registerNib:[UINib nibWithNibName:@"HomeCell1" bundle:nil] forCellReuseIdentifier:@"homeCell1"];

    [_tableView registerNib:[UINib nibWithNibName:@"HomeCell2" bundle:nil] forCellReuseIdentifier:@"homeCell2"];

    [_tableView registerNib:[UINib nibWithNibName:@"HomeCell3" bundle:nil] forCellReuseIdentifier:@"homeCell3"];

    [_tableView registerNib:[UINib nibWithNibName:@"HomeCell4" bundle:nil] forCellReuseIdentifier:@"homeCell4"];

    [_tableView registerNib:[UINib nibWithNibName:@"HomeCell5" bundle:nil] forCellReuseIdentifier:@"homeCell5"];

    [_tableView registerClass:[NewHomeCell class] forCellReuseIdentifier:@"NewHomeCell"];
    [_tableView registerClass:[NewHomeCell1 class] forCellReuseIdentifier:@"NewHomeCell1"];
    [_tableView registerClass:[NewHomeCell2 class] forCellReuseIdentifier:@"NewHomeCell2"];
    [_tableView registerClass:[NewHomeCell3 class] forCellReuseIdentifier:@"NewHomeCell3"];
    [_tableView registerClass:[NewHomeCell4 class] forCellReuseIdentifier:@"NewHomeCell4"];
    [_tableView registerClass:[NewHomeCell4 class] forCellReuseIdentifier:@"NewHomeCell5"];

    [_tableView registerNib:[UINib nibWithNibName:@"NewHomeHeaderView" bundle:nil] forHeaderFooterViewReuseIdentifier:@"headerCell"];
    [_tableView registerClass:[RecetHomeHeaderView class] forHeaderFooterViewReuseIdentifier:@"RecetHomeHeaderView"];

    _refresh=[[DJRefresh alloc] initWithScrollView:_tableView delegate:self];
    _refresh.topEnabled=YES;//下拉刷新
    _refresh.bottomEnabled=YES;//上拉加载

    [_collectionView5 registerNib:[UINib nibWithNibName:@"NoCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"nocell"];
    [_collectionView4 registerNib:[UINib nibWithNibName:@"NoCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"nocell"];
    [_collectionView3 registerNib:[UINib nibWithNibName:@"NoCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"nocell"];
    [_collectionView2 registerNib:[UINib nibWithNibName:@"NoCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"nocell"];
    [_collectionView1 registerNib:[UINib nibWithNibName:@"NoCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"nocell"];
    [_collectionView registerNib:[UINib nibWithNibName:@"NoCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"nocell"];
}

//热门商品
-(void)initCollection1
{

    cellHeight = ([UIScreen mainScreen].bounds.size.width-2)/2.0+110+2;
    float fWidth = [UIScreen mainScreen].bounds.size.width;

    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];

    if (_datasArrM4.count%2==0) {

        _collectionView1=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 40, fWidth, (_datasArrM4.count/2)*cellHeight-2) collectionViewLayout:flowLayout];

    }else{

        _collectionView1=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 40, fWidth, ((_datasArrM4.count+1)/2)*cellHeight-2) collectionViewLayout:flowLayout];
    }

    _collectionView1.backgroundColor=[UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1.0];

    _collectionView1.delegate=self;
    _collectionView1.dataSource=self;
    _collectionView1.scrollEnabled=NO;
    [_collectionView1 registerNib:[UINib nibWithNibName:@"HomeLookAllCell1" bundle:nil] forCellWithReuseIdentifier:@"cell1"];
    [_collectionView1 registerClass:[FristHomeCell class] forCellWithReuseIdentifier:@"Home"];
    [_collectionView1 registerNib:[UINib nibWithNibName:@"NoCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"nocell"];

}
//显示兑换
-(void)initCollection2
{
    cellHeight =([UIScreen mainScreen].bounds.size.width-2)/2.0+110+2;
    float fWidth = [UIScreen mainScreen].bounds.size.width;
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];

    if (_datasArrM3.count%2==0) {

        _collectionView2=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 40, fWidth, (_datasArrM3.count/2)*cellHeight-2) collectionViewLayout:flowLayout];

    }else{

        _collectionView2=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 40, fWidth, ((_datasArrM3.count+1)/2)*cellHeight-2) collectionViewLayout:flowLayout];
    }

    //        _collectionView2=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 40, cell.bounds.size.width, (_datasArrM3.count/2)*250) collectionViewLayout:flowLayout];

    _collectionView2.backgroundColor=[UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1.0];

    _collectionView2.delegate=self;

    _collectionView2.dataSource=self;

    _collectionView2.scrollEnabled=NO;

    [_collectionView2 registerNib:[UINib nibWithNibName:@"HomeLookAllCell2" bundle:nil] forCellWithReuseIdentifier:@"cell2"];
    [_collectionView2 registerNib:[UINib nibWithNibName:@"NoCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"nocell"];
    [_collectionView2 registerClass:[FristHomeCell class] forCellWithReuseIdentifier:@"Home"];

}
//特价商品
-(void)initCollection3
{
    cellHeight = ([UIScreen mainScreen].bounds.size.width-2)/2.0+110+2;
    float fWidth = [UIScreen mainScreen].bounds.size.width;
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];

    if (_datasArrM5.count%2==0) {

        _collectionView3=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 40, fWidth, (_datasArrM5.count/2)*cellHeight-2) collectionViewLayout:flowLayout];

    }else{

        _collectionView3=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 40, fWidth, ((_datasArrM5.count+1)/2)*cellHeight-2) collectionViewLayout:flowLayout];
    }

    //        _collectionView3=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 40, cell.bounds.size.width, (_datasArrM5.count/2)*250) collectionViewLayout:flowLayout];

    _collectionView3.backgroundColor=[UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1.0];

    _collectionView3.delegate=self;

    _collectionView3.dataSource=self;

    _collectionView3.scrollEnabled=NO;

    [_collectionView3 registerNib:[UINib nibWithNibName:@"HomeLookAllCell3" bundle:nil] forCellWithReuseIdentifier:@"cell3"];
    [_collectionView3 registerNib:[UINib nibWithNibName:@"NoCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"nocell"];
    [_collectionView3 registerClass:[FristHomeCell class] forCellWithReuseIdentifier:@"Home"];
}
//活动商品
-(void)initCollection4
{
    cellHeight =([UIScreen mainScreen].bounds.size.width-2)/2.0+110+2;
    float fWidth = [UIScreen mainScreen].bounds.size.width;
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];

    if (_datasArrM6.count%2==0) {

        _collectionView4=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 40,fWidth, (_datasArrM6.count/2)*cellHeight-2) collectionViewLayout:flowLayout];

    }else{

        _collectionView4=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 40, fWidth, ((_datasArrM6.count+1)/2)*cellHeight-2) collectionViewLayout:flowLayout];
    }



    //        _collectionView4=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 40, cell.bounds.size.width, (_datasArrM6.count/2)*250) collectionViewLayout:flowLayout];

    _collectionView4.backgroundColor=[UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1.0];

    _collectionView4.delegate=self;

    _collectionView4.dataSource=self;

    _collectionView4.scrollEnabled=NO;

    [_collectionView4 registerNib:[UINib nibWithNibName:@"HomeLookAllCell4" bundle:nil] forCellWithReuseIdentifier:@"cell4"];
    [_collectionView4 registerNib:[UINib nibWithNibName:@"NoCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"nocell"];
    [_collectionView4 registerClass:[FristHomeCell class] forCellWithReuseIdentifier:@"Home"];
}
//猜你喜欢
-(void)initCollection5
{
    cellHeight = ([UIScreen mainScreen].bounds.size.width-2)/2.0+110+2;
    float fWidth = [UIScreen mainScreen].bounds.size.width;
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];


    if (_datasArrM7.count%2==0) {

        _collectionView5=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 40+10, fWidth, (_datasArrM7.count/2)*cellHeight-2) collectionViewLayout:flowLayout];

    }else{

        _collectionView5=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 40+10,fWidth, ((_datasArrM7.count+1)/2)*cellHeight-2) collectionViewLayout:flowLayout];
    }

    _collectionView5.backgroundColor=[UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1.0];

    _collectionView5.delegate=self;

    _collectionView5.dataSource=self;

    _collectionView5.scrollEnabled=NO;

    [_collectionView5 registerNib:[UINib nibWithNibName:@"HomeLookAllCell5" bundle:nil] forCellWithReuseIdentifier:@"cell5"];
    [_collectionView5 registerNib:[UINib nibWithNibName:@"NoCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"nocell"];
    [_collectionView5 registerClass:[FristHomeCell class] forCellWithReuseIdentifier:@"Home"];
}

//猜你喜欢
-(void)initCollection6
{
    cellHeight = ([UIScreen mainScreen].bounds.size.width-2)/2.0+110+2;
    float fWidth = [UIScreen mainScreen].bounds.size.width;
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];


    if (_datasArrM1.count%2==0) {

        _collectionView6=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 40+10, fWidth, (_datasArrM1.count/2)*cellHeight-2) collectionViewLayout:flowLayout];

    }else{

        _collectionView6=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 40+10,fWidth, ((_datasArrM1.count+1)/2)*cellHeight-2) collectionViewLayout:flowLayout];
    }

    _collectionView6.backgroundColor=[UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1.0];

    _collectionView6.delegate=self;

    _collectionView6.dataSource=self;

    _collectionView6.scrollEnabled=NO;

    [_collectionView6 registerNib:[UINib nibWithNibName:@"HomeLookAllCell5" bundle:nil] forCellWithReuseIdentifier:@"cell6"];
    [_collectionView6 registerNib:[UINib nibWithNibName:@"NoCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"nocell"];
    [_collectionView6 registerClass:[FristHomeCell class] forCellWithReuseIdentifier:@"Home"];
}

//无数据视图
-(void)NoWebSeveice
{

    view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-49)];

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

-(void)loadData
{

    [self getDatas];

}

/*******************************************************      各种button执行方法、页面间的跳转       ******************************************************/

//扫一扫
-(void)saoyisaoBtnClick
{
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数组NSArray类型的数据
    self.userid=[userDefaultes stringForKey:@"userid"];

    self.sigen=[userDefaultes stringForKey:@"sigen"];

    //    NSLog(@">>>>>>%@",self.userid);
    //    NSLog(@">>>>>>%@",self.sigen);

    if (self.userid==NULL) {

        ATHLoginViewController *vc=[[ATHLoginViewController alloc] init];
        vc.delegate=self;

        [self.navigationController pushViewController:vc animated:NO];

        self.navigationController.navigationBar.hidden=YES;

        self.tabBarController.tabBar.hidden=YES;
    }else{


        NewSaoYiSaoViewController *vc = [[NewSaoYiSaoViewController alloc] init];

        vc.userid=self.userid;

        vc.sigen=self.sigen;


        [self.navigationController pushViewController:vc animated:NO];

        self.navigationController.navigationBar.hidden=YES;

        self.tabBarController.tabBar.hidden=YES;

    }
}
//首页搜索添加手势
-(void)headSearchClick:(UIImageView *)image
{


    ClassifySearchViewController *vc=[[ClassifySearchViewController alloc] init];

    [self.navigationController pushViewController:vc animated:NO];

    self.navigationController.navigationBar.hidden=YES;

    self.tabBarController.tabBar.hidden=YES;
}
//跳转至消息列表页
-(void)CheckMessages:(id)sender
{
    /*

     */
    MessageListVC *VC=[[MessageListVC alloc]init];
    VC.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:VC animated:NO];
}

//香港购物佳(海外购物佳)大健康专区
-(void)HongKongBtnClick
{

    if (self.isShowHongKong&&[self.isShowHongKong isEqualToString:@"0"]) {
        HomeBigHealthyVC *vc=[[HomeBigHealthyVC alloc] init];
        [self.navigationController pushViewController:vc animated:NO];
        //隐藏
        self.navigationController.navigationBar.hidden=YES;
        self.tabBarController.tabBar.hidden=YES;

    }else
    {
        [TrainToast showWithText:@"即将开放，敬请期待" duration:1.0f];
    }


}
//九块九包邮
-(void)NineNineBtnClick
{
    /*

     */
    NineAndNineViewController *nineVC=[[NineAndNineViewController alloc] init];

    [self.navigationController pushViewController:nineVC animated:YES];
    //隐藏
    self.navigationController.navigationBar.hidden=YES;
    self.tabBarController.tabBar.hidden=YES;

}
//纯积分(小家电)专场
-(void)ChunJiFenBtnClick
{
    HomeAbroadShoppingVC *VC=[[HomeAbroadShoppingVC alloc] init];

    VC.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:VC animated:NO];

}

//小家电
-(void)XiaoJiaDianBtnClick
{
    if (self.isShowHomeLittle) {

        HomeLittleAppliancesVC *vc=[[HomeLittleAppliancesVC alloc] init];
        [self.navigationController pushViewController:vc animated:NO];
        //隐藏
        self.navigationController.navigationBar.hidden=YES;
        self.tabBarController.tabBar.hidden=YES;

    }else if([self.isShowHuiQiangGou isEqualToString:@"0"])
    {

        YTScoreViewController *vc=[[YTScoreViewController alloc] init];

        vc.TypeString = @"100";

        //隐藏
        self.navigationController.navigationBar.hidden=YES;
        [self.navigationController pushViewController:vc animated:NO];
        self.tabBarController.tabBar.hidden=YES;

    }else {
        [TrainToast showWithText:@"即将开放，敬请期待!" duration:3.0];
    }

}

//热销排行
-(void)reXiaoPaiHangBtnClick
{
    HomeHotSaleVC *VC=[[HomeHotSaleVC alloc] init];

    VC.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:VC animated:NO];

}


//交通出行
-(void)PhoneButtonBtnClick
{
    /*

     */

    //    TelephoneBillViewController *vc=[[TelephoneBillViewController alloc] init];

    BMPlaneAndTrainViewController *vc=[[BMPlaneAndTrainViewController alloc] init];
    vc.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:vc animated:NO];



}
//充值中心
-(void)FlowButtonBtnClick
{
    /*

     */

    BMNewGameAndPhoneViewController *vc=[[BMNewGameAndPhoneViewController alloc] init];
    vc.hidesBottomBarWhenPushed=YES;
    //  self.tabBarController.tabBar.hidden=YES;
    [self.navigationController pushViewController:vc animated:NO];
    //    self.navigationController.navigationBar.hidden=YES;


}
//违章缴费
-(void)GameButtonBtnClick
{

    /*

     */


    if (![[[NSUserDefaults standardUserDefaults] objectForKey:@"status"] isEqualToString:@"YES"]) {
        ATHLoginViewController *vc=[[ATHLoginViewController alloc]init];
        self.tabBarController.tabBar.hidden=YES;
        [self.navigationController pushViewController:vc animated:NO];
        vc.backString=@"1234";
    }else
    {
        PeccantViewController *vc=[[PeccantViewController alloc]init];
        self.tabBarController.tabBar.hidden=YES;
        [self.navigationController pushViewController:vc animated:NO];

    }



}

//更多(积分商品、热销家电)
-(void)MiaoQiangBtnClick
{
    if (self.isShowHomeLittle) {
        HomeLittleAppliancesVC *vc=[[HomeLittleAppliancesVC alloc] init];
        [self.navigationController pushViewController:vc animated:NO];
        //隐藏
        self.navigationController.navigationBar.hidden=YES;
        self.tabBarController.tabBar.hidden=YES;
    }else if([self.isShowHuiQiangGou isEqualToString:@"0"])
    {
        YTScoreViewController *vc=[[YTScoreViewController alloc] init];

        vc.TypeString = @"100";

        //隐藏
        self.navigationController.navigationBar.hidden=YES;
        self.tabBarController.tabBar.hidden=YES;

    }

}


//好店推荐
-(void)HDButtonBtnClick
{

    self.tabBarController.selectedIndex = 2;

}
//为你甄选
-(void)ZXButtonBtnClick:(UIButton *)sender
{
    ForYouSelectViewController *vc=[[ForYouSelectViewController alloc] init];

    for (HomeModel *model in _list2) {

        if ([model.ID integerValue] == sender.tag) {

            vc.TitleString = model.special_name;

        }
    }

    [self.navigationController pushViewController:vc animated:NO];
    self.navigationController.navigationBar.hidden=YES;
    self.tabBarController.tabBar.hidden=YES;

}
//大牌推荐
-(void)DPButtonBtnClick:(UIButton *)sender
{

    HomeHaveGoodShoppingVC *VC=[[HomeHaveGoodShoppingVC alloc] init];
    for (HomeModel *model in _list2) {

        if ([model.ID integerValue] == sender.tag) {

            VC.naviTitle = model.special_name;

        }
    }

    VC.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:VC animated:NO];

}
//家电馆
-(void)JDButtonBtnClick:(UIButton *)sender
{
    ZTSelectViewController *vc=[[ZTSelectViewController alloc] init];

    for (HomeModel *model in _list2) {

        if ([model.ID integerValue] == sender.tag) {

            vc.Title = model.special_name;

        }
    }
    vc.TypeString = @"1";
    [self.navigationController pushViewController:vc animated:NO];
    self.navigationController.navigationBar.hidden=YES;
    self.tabBarController.tabBar.hidden=YES;

}
//美味惠吃
-(void)MWButtonBtnClick:(UIButton *)sender
{
    ZTSelectViewController *vc=[[ZTSelectViewController alloc] init];

    for (HomeModel *model in _list2) {

        if ([model.ID integerValue] == sender.tag) {

            vc.Title = model.special_name;

        }
    }
    vc.Type = @"1";
    vc.TypeString = @"2";
    [self.navigationController pushViewController:vc animated:NO];
    self.navigationController.navigationBar.hidden=YES;
    self.tabBarController.tabBar.hidden=YES;

}

//护肤美妆
-(void)HFButtonBtnClick:(UIButton *)sender
{
    ZTSelectViewController *vc=[[ZTSelectViewController alloc] init];

    for (HomeModel *model in _list2) {

        if ([model.ID integerValue] == sender.tag) {

            vc.Title = model.special_name;

        }
    }
    vc.TypeString = @"3";
    vc.Type = @"2";
    [self.navigationController pushViewController:vc animated:NO];
    self.navigationController.navigationBar.hidden=YES;
    self.tabBarController.tabBar.hidden=YES;

}
//服装箱包
-(void)FZButtonBtnClick:(UIButton *)sender
{
    ZTSelectViewController *vc=[[ZTSelectViewController alloc] init];

    for (HomeModel *model in _list2) {

        if ([model.ID integerValue] == sender.tag) {

            vc.Title = model.special_name;

        }
    }
    vc.TypeString = @"4";
    vc.Type = @"4";
    [self.navigationController pushViewController:vc animated:NO];
    self.navigationController.navigationBar.hidden=YES;
    self.tabBarController.tabBar.hidden=YES;
}
//居家生活
-(void)JJButtonBtnClick:(UIButton *)sender
{
    ZTSelectViewController *vc=[[ZTSelectViewController alloc] init];

    for (HomeModel *model in _list2) {

        if ([model.ID integerValue] == sender.tag) {

            vc.Title = model.special_name;

        }
    }
    vc.TypeString = @"5";
    vc.Type = @"5";
    [self.navigationController pushViewController:vc animated:NO];
    self.navigationController.navigationBar.hidden=YES;
    self.tabBarController.tabBar.hidden=YES;

}
//搞机派
-(void)GJButtonBtnClick:(UIButton *)sender
{
    ZTSelectViewController *vc=[[ZTSelectViewController alloc] init];

    for (HomeModel *model in _list2) {

        if ([model.ID integerValue] == sender.tag) {

            vc.Title = model.special_name;

        }
    }
    vc.TypeString = @"6";
    vc.Type = @"6";
    [self.navigationController pushViewController:vc animated:NO];
    self.navigationController.navigationBar.hidden=YES;
    self.tabBarController.tabBar.hidden=YES;

}
//亲宝贝
-(void)BBButtonBtnClick:(UIButton *)sender
{

    ZTSelectViewController *vc=[[ZTSelectViewController alloc] init];

    for (HomeModel *model in _list2) {

        if ([model.ID integerValue] == sender.tag) {

            vc.Title = model.special_name;

        }
    }
    vc.TypeString = @"7";
    vc.Type = @"7";
    [self.navigationController pushViewController:vc animated:NO];
    self.navigationController.navigationBar.hidden=YES;
    self.tabBarController.tabBar.hidden=YES;
}
//户外生活
-(void)HWButtonBtnClick:(UIButton *)sender
{
    ZTSelectViewController *vc=[[ZTSelectViewController alloc] init];

    for (HomeModel *model in _list2) {

        if ([model.ID integerValue] == sender.tag) {

            vc.Title = model.special_name;

        }
    }
    vc.TypeString = @"8";
    vc.Type = @"3";
    [self.navigationController pushViewController:vc animated:NO];
    self.navigationController.navigationBar.hidden=YES;
    self.tabBarController.tabBar.hidden=YES;

}

//优选清单1
-(void)KCButtonBtnClick:(UIButton *)sender
{

    NSLog(@"快充===%ld",(long)sender.tag);

    JXSelectDetailViewController *vc = [[JXSelectDetailViewController alloc] init];

    vc.ID = [NSString stringWithFormat:@"%ld",(long)sender.tag];
    vc.Back = @"100";
    [self.navigationController pushViewController:vc animated:NO];
    self.tabBarController.tabBar.hidden=YES;
}
//优选清单2
-(void)GGButtonBtnClick:(UIButton *)sender
{

    NSLog(@"高贵===%ld",(long)sender.tag);

    JXSelectDetailViewController *vc = [[JXSelectDetailViewController alloc] init];
    vc.Back = @"100";
    vc.ID = [NSString stringWithFormat:@"%ld",(long)sender.tag];

    [self.navigationController pushViewController:vc animated:NO];
    self.tabBarController.tabBar.hidden=YES;
}
//更多清单
-(void)QDButtonBtnClick
{
    JXSelectViewController *vc=[[JXSelectViewController alloc] init];

    [self.navigationController pushViewController:vc animated:NO];
    self.navigationController.navigationBar.hidden=YES;
    self.tabBarController.tabBar.hidden=YES;

}

//发现好店1
-(void)OneButtonBtnClick:(UIButton *)sender
{

    NSLog(@"One===%ld",(long)sender.tag);


    MerchantDetailViewController *vc = [[MerchantDetailViewController alloc] init];


    for (HomeModel *model in _HDArrM) {

        if ([model.mid intValue] == (int)sender.tag) {

            vc.Logo = model.logo;
            NSLog(@"==1=%@",model.logo);
        }
    }

    vc.mid = [NSString stringWithFormat:@"%ld",(long)sender.tag];

    vc.jindu=self.jindu;

    vc.weidu=self.weidu;

    vc.coordinates = @"";

    vc.MapStartAddress = self.MapStartAddress;

    vc.GetString=@"1";

    self.navigationController.navigationBar.hidden=YES;

    self.tabBarController.tabBar.hidden=YES;

    [self.navigationController pushViewController:vc animated:NO];

}
//发现好店2
-(void)TwoButtonBtnClick:(UIButton *)sender
{
    NSLog(@"Two===%ld",(long)sender.tag);

    MerchantDetailViewController *vc = [[MerchantDetailViewController alloc] init];

    for (HomeModel *model in _HDArrM) {

        if ([model.mid intValue] == (int)sender.tag) {

            vc.Logo = model.logo;

            NSLog(@"==2=%@",model.logo);

        }
    }

    vc.mid = [NSString stringWithFormat:@"%ld",(long)sender.tag];

    vc.jindu=self.jindu;

    vc.weidu=self.weidu;

    vc.coordinates = @"";

    vc.MapStartAddress = self.MapStartAddress;

    //    vc.delegate=self;

    vc.GetString=@"1";

    self.navigationController.navigationBar.hidden=YES;

    self.tabBarController.tabBar.hidden=YES;

    [self.navigationController pushViewController:vc animated:NO];

}
//发现好店3
-(void)ThreeButtonBtnClick:(UIButton *)sender
{

    NSLog(@"Three===%ld",(long)sender.tag);

    MerchantDetailViewController *vc = [[MerchantDetailViewController alloc] init];


    for (HomeModel *model in _HDArrM) {

        if ([model.mid intValue] == (int)sender.tag) {

            vc.Logo = model.logo;
            NSLog(@"==3=%@",model.logo);
        }
    }

    vc.mid = [NSString stringWithFormat:@"%ld",(long)sender.tag];

    vc.jindu=self.jindu;

    vc.weidu=self.weidu;

    vc.coordinates = @"";

    vc.MapStartAddress = self.MapStartAddress;

    //    vc.delegate=self;

    vc.GetString=@"1";

    self.navigationController.navigationBar.hidden=YES;

    self.tabBarController.tabBar.hidden=YES;

    [self.navigationController pushViewController:vc animated:NO];

}
//发现好店4
-(void)FourButtonBtnClick:(UIButton *)sender
{
    NSLog(@"Four===%ld",(long)sender.tag);

    MerchantDetailViewController *vc = [[MerchantDetailViewController alloc] init];

    for (HomeModel *model in _HDArrM) {

        if ([model.mid intValue] == (int)sender.tag) {

            vc.Logo = model.logo;
            NSLog(@"==4=%@",model.logo);
        }
    }

    vc.mid = [NSString stringWithFormat:@"%ld",(long)sender.tag];

    vc.jindu=self.jindu;

    vc.weidu=self.weidu;

    vc.coordinates = @"";

    vc.MapStartAddress = self.MapStartAddress;

    //    vc.delegate=self;

    vc.GetString=@"1";

    self.navigationController.navigationBar.hidden=YES;

    self.tabBarController.tabBar.hidden=YES;

    [self.navigationController pushViewController:vc animated:NO];


}

//查看更多
-(void)checkMore:(UIButton *)sender
{

    if (sender.tag-700<4) {
        XLHomeRemenModel *model=_RemenSMArr[sender.tag-700];
        NewLookAllViewController *vc=[[NewLookAllViewController alloc] init];
        vc.gid = model.pid;
        vc.titleName = model.Name;
        NSLog(@"kkkkkkkk=%@",vc.titleName);
        vc.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:vc animated:NO];


    }else
    {
        HomeLatestGoodsListVC *VC=[[HomeLatestGoodsListVC alloc] init];

        VC.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:VC animated:NO];

    }

}
/*******************************************************      协议方法       ******************************************************/
#pragma-mark  tableView协议

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return 1;
}

//组数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    NSInteger count=0;
    if (_new_product_list.count>0&&_datasArrM1.count>0&&_RemenSMArr.count>0) {
        count=_RemenSMArr.count+2;
    }
    YLog(@"%ld",count);
    return count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{


    if (indexPath.section==0) {

        NewHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewHomeCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        XLHomeRemenModel *model=_RemenSMArr[0];
        cell.NameLabel.text=model.Name;
        [self initCollection1];

        [cell addSubview:_collectionView1];
        //首页查看全部
        //        [cell.TypeLookAllButton addTarget:self action:@selector(homeLookMoreBtnClick1) forControlEvents:UIControlEventTouchUpInside];

        return cell;
    }else if (indexPath.section==1){

        //        HomeCell2 *cell = [tableView dequeueReusableCellWithIdentifier:@"homeCell2"];

        NewHomeCell1 *cell = [tableView dequeueReusableCellWithIdentifier:@"NewHomeCell1"];

        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //        if ([model1.goodsname isEqualToString:@"首页-限时兑换1"]){
        //            cell.NameLabel.text=@"限时兑换";
        //            cell.TypeImgView.image=[UIImage imageNamed:@"限时兑换"];
        //        }

        //        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        XLHomeRemenModel *model=_RemenSMArr[1];
        cell.NameLabel.text=model.Name;

        [self initCollection2];

        [cell addSubview:_collectionView2];

        //首页查看全部
        //        [cell.TypeLookAllButton addTarget:self action:@selector(homeLookMoreBtnClick2) forControlEvents:UIControlEventTouchUpInside];

        return cell;
    }else if (indexPath.section==2){

        //        HomeCell3 *cell = [tableView dequeueReusableCellWithIdentifier:@"homeCell3"];
        NewHomeCell2 *cell = [tableView dequeueReusableCellWithIdentifier:@"NewHomeCell2"];

        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //        if ([model1.goodsname isEqualToString:@"首页-特价商品1"]){
        //            cell.NameLabel.text=@"特价商品";
        //            cell.TypeImgView.image=[UIImage imageNamed:@"特价商品"];
        //        }

        //        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        XLHomeRemenModel *model=_RemenSMArr[2];
        cell.NameLabel.text=model.Name;

        [self initCollection3];

        [cell addSubview:_collectionView3];

        //首页查看全部
        //        [cell.TypeLookAllButton addTarget:self action:@selector(homeLookMoreBtnClick3) forControlEvents:UIControlEventTouchUpInside];

        return cell;
    }else if (indexPath.section==3){

        //        HomeCell4 *cell = [tableView dequeueReusableCellWithIdentifier:@"homeCell4"];

        NewHomeCell3 *cell = [tableView dequeueReusableCellWithIdentifier:@"NewHomeCell3"];

        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //        if ([model1.goodsname isEqualToString:@"首页-活动商品1"]){
        //            cell.NameLabel.text=@"活动商品";
        //            cell.TypeImgView.image=[UIImage imageNamed:@"活动商品"];
        //        }

        //        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        XLHomeRemenModel *model=_RemenSMArr[3];
        cell.NameLabel.text=model.Name;

        [self initCollection4];

        [cell addSubview:_collectionView4];

        //首页查看全部
        //        [cell.TypeLookAllButton addTarget:self action:@selector(homeLookMoreBtnClick4) forControlEvents:UIControlEventTouchUpInside];

        return cell;

    }else  if (indexPath.section==4){

        //        HomeCell5 *cell = [tableView dequeueReusableCellWithIdentifier:@"homeCell5"];

        NewHomeCell4 *cell = [tableView dequeueReusableCellWithIdentifier:@"NewHomeCell4"];

        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //        if ([model1.goodsname isEqualToString:@"首页-猜你喜欢1"]){
        //            cell.NameLabel.text=@"猜你喜欢";
        //            cell.TypeImgView.image=[UIImage imageNamed:@"猜你喜欢"];
        //        }

        //    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];

        if (_new_product_list.count>0) {
            cell.NameLabel.text=@"最近新品";
        }

        [self initCollection5];

        [cell addSubview:_collectionView5];
        return cell;
    }else
    {
        NewHomeCell4 *cell = [tableView dequeueReusableCellWithIdentifier:@"NewHomeCell5"];

        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //        if ([model1.goodsname isEqualToString:@"首页-猜你喜欢1"]){
        //            cell.NameLabel.text=@"猜你喜欢";
        //            cell.TypeImgView.image=[UIImage imageNamed:@"猜你喜欢"];
        //        }

        //    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];


        cell.NameLabel.text=@"猜你喜欢";


        [self initCollection6];
        //   [_collectionView6 reloadData];

        [cell addSubview:_collectionView6];
        return cell;

    }

}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    cellHeight =([UIScreen mainScreen].bounds.size.width-2)/2.0+110+2;

    if (indexPath.section<4) {
        if (_RemenSMArr.count<indexPath.section+1) {
            return 40;
        }
        XLHomeRemenModel *model=_RemenSMArr[indexPath.section];

        if (model.list.count==0) {
            return 40;
        }else
        {
            if (model.list.count%2==0) {

                return (model.list.count/2)* cellHeight+40;

            }else{

                return ((model.list.count+1)/2)*cellHeight+40;
            }
        }


    }else if(indexPath.section==4){

        if (_new_product_list.count == 0) {
            return 40+10;

        }else{
            if (_new_product_list.count%2==0) {

                return (_new_product_list.count/2)* cellHeight+40+10;
            }else{

                return ((_new_product_list.count+1)/2)* cellHeight+40+10;
            }
        }
    }
    else
    {
        if (_datasArrM1.count == 0) {
            return 40+10;

        }else{
            if (_datasArrM1.count%2==0) {

                return (_datasArrM1.count/2)* cellHeight+40+10;
            }else{

                return ((_datasArrM1.count+1)/2)* cellHeight+40+10;
            }
        }
    }
}

//表头
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section!=0) {
        return [[UIView alloc] init];
    }
    _headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"RecetHomeHeaderView"];

    _headerView.delegate = self;

    //香港购物佳
    [_headerView.hkButton addTarget:self action:@selector(HongKongBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //九块九包邮
    [_headerView.ninenineButton addTarget:self action:@selector(NineNineBtnClick) forControlEvents:UIControlEventTouchUpInside];

    //纯积分商城
    [_headerView.scoreStoreButton addTarget:self action:@selector(ChunJiFenBtnClick) forControlEvents:UIControlEventTouchUpInside];

    [_headerView.TrainButton addTarget:self action:@selector(XiaoJiaDianBtnClick) forControlEvents:UIControlEventTouchUpInside];

    [_headerView.PhoneButton addTarget:self action:@selector(PhoneButtonBtnClick) forControlEvents:UIControlEventTouchUpInside];

    [_headerView.FlowButton addTarget:self action:@selector(FlowButtonBtnClick) forControlEvents:UIControlEventTouchUpInside];

    [_headerView.GameButton addTarget:self action:@selector(GameButtonBtnClick) forControlEvents:UIControlEventTouchUpInside];

    [_headerView.AeroplaneButton addTarget:self action:@selector(reXiaoPaiHangBtnClick) forControlEvents:UIControlEventTouchUpInside];

    [_headerView.MiaoQiangButton addTarget:self action:@selector(MiaoQiangBtnClick) forControlEvents:UIControlEventTouchUpInside];

    [_headerView.ZXButton addTarget:self action:@selector(ZXButtonBtnClick:) forControlEvents:UIControlEventTouchUpInside];

    [_headerView.DPButton addTarget:self action:@selector(DPButtonBtnClick:) forControlEvents:UIControlEventTouchUpInside];

    [_headerView.JDButton addTarget:self action:@selector(JDButtonBtnClick:) forControlEvents:UIControlEventTouchUpInside];

    [_headerView.MWButton addTarget:self action:@selector(MWButtonBtnClick:) forControlEvents:UIControlEventTouchUpInside];

    [_headerView.HFButton addTarget:self action:@selector(HFButtonBtnClick:) forControlEvents:UIControlEventTouchUpInside];

    [_headerView.FZButton addTarget:self action:@selector(FZButtonBtnClick:) forControlEvents:UIControlEventTouchUpInside];

    [_headerView.JJButton addTarget:self action:@selector(JJButtonBtnClick:) forControlEvents:UIControlEventTouchUpInside];

    [_headerView.GJButton addTarget:self action:@selector(GJButtonBtnClick:) forControlEvents:UIControlEventTouchUpInside];

    [_headerView.BBButton addTarget:self action:@selector(BBButtonBtnClick:) forControlEvents:UIControlEventTouchUpInside];

    [_headerView.HWButton addTarget:self action:@selector(HWButtonBtnClick:) forControlEvents:UIControlEventTouchUpInside];

    [_headerView.KCButton addTarget:self action:@selector(KCButtonBtnClick:) forControlEvents:UIControlEventTouchUpInside];

    [_headerView.GGButton addTarget:self action:@selector(GGButtonBtnClick:) forControlEvents:UIControlEventTouchUpInside];

    [_headerView.QDButton addTarget:self action:@selector(QDButtonBtnClick) forControlEvents:UIControlEventTouchUpInside];

    [_headerView.OneButton addTarget:self action:@selector(OneButtonBtnClick:) forControlEvents:UIControlEventTouchUpInside];

    [_headerView.TwoButton addTarget:self action:@selector(TwoButtonBtnClick:) forControlEvents:UIControlEventTouchUpInside];

    [_headerView.ThreeButton addTarget:self action:@selector(ThreeButtonBtnClick:) forControlEvents:UIControlEventTouchUpInside];

    [_headerView.FourButton addTarget:self action:@selector(FourButtonBtnClick:) forControlEvents:UIControlEventTouchUpInside];

    //传入数组数据
    _headerView.headerDatas = _ImageViewArrM;

    //传入id

    _headerView.dataArrM=_headerArrM;

    _headerView.dataArrM2 = _attibuteArm;

    _headerView.time = [self.time intValue]/1000;

    //    _headerView.time = 30;

    _headerView.list1 = _list1;

    _headerView.list2 = _list2;

    _headerView.list4=_list4;

    _headerView.JXlist = _JXArrM;

    _headerView.HDlist = _HDArrM;

    _headerView.ReMenSCArrM=_ReMenSCArrM;

    _headerView.DPArrM=_DPArrM;

    _headerView.HaoHuoArrM=_HaoHuoArrM;
    _headerView.xl=@"1";
    _headerView.TopBangArrM=_TopBangArrM;

    [_headerView setjikeStr:JKSTR andJikeSubStr:JKSTR2 andPostPic:postPic];


    return _headerView;
}

//表头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    //    return  ([UIScreen mainScreen].bounds.size.height)*6/11;
    //    return  ([UIScreen mainScreen].bounds.size.height)*27/11;

    if (section!=0) {
        return 0.01;
    }

    NSInteger i=0;
    if (self.isShowHomeLittle) {
        NSLog(@"%@",self.isShowHuiQiangGou);
    }

    if (![self.isShowHuiQiangGou isEqualToString:@"0"]&&!self.isShowHomeLittle) {
        i=-214;
    }

    return i+kScreenWidth*310/750+(Height(13)+Height(5)+12+50)*2+Height(10)+Height(10)+Height(10)+204+10+Width(200)+Width(265)+Width(394)+Width(134)+Height(30)+Width(124)+40+Height(30)+Width(124)+40+Height(30)+Width(124)+40+Height(30)+Width(342)+Width(362)+Width(242);

}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section==5) {
        return 0.01;
    }else
    {
        return 40;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{

    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    [view setBackgroundColor:[UIColor whiteColor]];

    UIView *line1=[[UIView alloc] initWithFrame:CGRectMake(0, 39, kScreenWidth, 1)];
    [line1 setBackgroundColor:RGB(242, 242, 242)];
    [view addSubview:line1];
    UIView *line2=[[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 1)];
    [line2 setBackgroundColor:RGB(242, 242, 242)];
    [view addSubview:line2];

    NSString *str=@"查看更多";





    UIButton *but=[UIButton buttonWithType:UIButtonTypeCustom];
    [but setFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    [but setTitle:str forState:UIControlStateNormal];
    but.titleLabel.font=KNSFONT(15);
    but.tag=700+section;
    [but addTarget:self action:@selector(checkMore:) forControlEvents:UIControlEventTouchUpInside];
    [but setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
    [view addSubview:but];

    UIImageView *IV=[[UIImageView alloc] init];
    CGSize size=[str sizeWithFont:KNSFONT(15) maxSize:kScreenSize];
    [IV setFrame:CGRectMake((kScreenWidth-size.width)/2+size.width+5, (40-13.5)/2, 8, 13)];
    [IV setImage:KImage(@"icon_more_jiadian")];
    [but addSubview:IV];
    if (section==5) {
        return [[UIView alloc] init];
    }else
    {
        return view;
    }
}



- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    NSLog(@"12345566");
    if ((tabBarController.selectedIndex==0)&&(viewController==self)) {
        _tableView.contentOffset=CGPointZero;
    }



}
#pragma mark - collectionView的代理方法
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView==_collectionView1) {

        if (_datasArrM4.count==0) {

            return 1;

        }else{

            return _datasArrM4.count;
        }

    }else if (collectionView==_collectionView2){

        if (_datasArrM3.count==0) {

            return 1;

        }else{

            return _datasArrM3.count;
        }
        //        return _datasArrM3.count;
    }else if (collectionView==_collectionView3){

        if (_datasArrM5.count==0) {

            return 1;

        }else{

            return _datasArrM5.count;
        }

        //        return _datasArrM5.count;
    }else if (collectionView==_collectionView4){

        if (_datasArrM6.count==0) {

            return 1;

        }else{

            return _datasArrM6.count;
        }

        //        return _datasArrM6.count;

    }else if (collectionView==_collectionView5){

        if (_datasArrM7.count==0) {

            return 1;

        }else{

            return _datasArrM7.count;
        }

        //        return _datasArrM7.count;
    }else
    {
        if (_datasArrM1.count==0) {

            return 1;

        }else{

            return _datasArrM1.count;
        }
    }
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{

    return CGSizeMake(([UIScreen mainScreen].bounds.size.width-2)/2.0, ([UIScreen mainScreen].bounds.size.width-2)/2.0+110);

}

//最小行间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 2;
}
//最小行内部cell的间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 2;
}

//section的边距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    //上,左,下,右
    return UIEdgeInsetsMake(0, 0, 2, 0);
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    if (collectionView==_collectionView1) {

        FristHomeCell *cell1=[collectionView dequeueReusableCellWithReuseIdentifier:@"Home" forIndexPath:indexPath];

        if (!(_datasArrM4.count==0)) {

            AllSingleShoppingModel *model=_datasArrM4[indexPath.row];
            //            [cell1.GoodsImageView sd_setImageWithURL:[NSURL URLWithString:model.scopeimg]];
            cell1.status = model.statu;//判断是否售完
            //  cell1.stock = model.sto;
            cell1.StrorenameLabel.text = model.storename;
            [cell1.GoodsImageView sd_setImageWithURL:[NSURL URLWithString:model.scopeimg] placeholderImage:[UIImage imageNamed:@"default_image"] options:SDWebImageProgressiveDownload];
            cell1.GoodsNameLabel.text=model.name;
            cell1.GoodsAmountLabel.text=[NSString stringWithFormat:@"%@人付款",model.amount];
            cell1.GoodsPriceLabel.text=[NSString stringWithPrice:model.pay_maney andInterger:model.pay_integer];
        }

        return cell1;

    }else if (collectionView==_collectionView2){

        FristHomeCell *cell2=[collectionView dequeueReusableCellWithReuseIdentifier:@"Home" forIndexPath:indexPath];

        if (!(_datasArrM3.count==0)) {

            AllSingleShoppingModel *model=_datasArrM3[indexPath.row];

            //            [cell2.GoodsImageView sd_setImageWithURL:[NSURL URLWithString:model.scopeimg]];
            cell2.status = model.statu;//判断是否售完
            //  cell2.stock = model.stock;
            cell2.StrorenameLabel.text = model.storename;
            [cell2.GoodsImageView sd_setImageWithURL:[NSURL URLWithString:model.scopeimg] placeholderImage:[UIImage imageNamed:@"default_image"] options:SDWebImageProgressiveDownload];
            cell2.GoodsNameLabel.text=model.name;
            cell2.GoodsAmountLabel.text=[NSString stringWithFormat:@"%@人付款",model.amount];
            cell2.GoodsPriceLabel.text=[NSString stringWithPrice:model.pay_maney andInterger:model.pay_integer];

        }

        return cell2;

    }else if (collectionView==_collectionView3){

        FristHomeCell *cell3=[collectionView dequeueReusableCellWithReuseIdentifier:@"Home" forIndexPath:indexPath];

        if (!(_datasArrM5.count==0)) {

            AllSingleShoppingModel *model=_datasArrM5[indexPath.row];

            //            [cell3.GoodsImageView sd_setImageWithURL:[NSURL URLWithString:model.scopeimg]];
            cell3.status = model.statu;//判断是否售完
            // cell3.stock = model.stock;
            cell3.StrorenameLabel.text = model.storename;
            [cell3.GoodsImageView sd_setImageWithURL:[NSURL URLWithString:model.scopeimg] placeholderImage:[UIImage imageNamed:@"default_image"] options:SDWebImageProgressiveDownload];
            cell3.GoodsNameLabel.text=model.name;
            cell3.GoodsAmountLabel.text=[NSString stringWithFormat:@"%@人付款",model.amount];
            cell3.GoodsPriceLabel.text=[NSString stringWithPrice:model.pay_maney andInterger:model.pay_integer];

        }

        return cell3;

    }else if (collectionView==_collectionView4){

        FristHomeCell *cell4=[collectionView dequeueReusableCellWithReuseIdentifier:@"Home" forIndexPath:indexPath];


        if (!(_datasArrM6.count==0)) {


            AllSingleShoppingModel *model=_datasArrM6[indexPath.row];

            //            [cell4.GoodsImageView sd_setImageWithURL:[NSURL URLWithString:model.scopeimg]];
            cell4.status = model.statu;//判断是否售完
            //  cell4.stock = model.stock;
            cell4.StrorenameLabel.text = model.storename;
            [cell4.GoodsImageView sd_setImageWithURL:[NSURL URLWithString:model.scopeimg] placeholderImage:[UIImage imageNamed:@"default_image"] options:SDWebImageProgressiveDownload];
            cell4.GoodsNameLabel.text=model.name;
            cell4.GoodsAmountLabel.text=[NSString stringWithFormat:@"%@人付款",model.amount];
            cell4.GoodsPriceLabel.text=[NSString stringWithPrice:model.pay_maney andInterger:model.pay_integer];


        }

        return cell4;

    }else if (collectionView==_collectionView5){

        if (_datasArrM7.count==0) {

            NoCollectionViewCell  *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"nocell" forIndexPath:indexPath];


            return cell;

        }else{


            //            NSLog(@"==_datasArrM7.count=====%ld",_datasArrM7.count);

            FristHomeCell *cell5=[collectionView dequeueReusableCellWithReuseIdentifier:@"Home" forIndexPath:indexPath];

            if (!(_datasArrM7.count==0)) {

                //                cell5=[collectionView dequeueReusableCellWithReuseIdentifier:@"cell5" forIndexPath:indexPath];

                AllSingleShoppingModel *model=_datasArrM7[indexPath.row];

                //            [cell5.GoodsImageView sd_setImageWithURL:[NSURL URLWithString:model.scopeimg]];
                cell5.status = model.statu;//判断是否售完
                //  cell5.stock = model.stock;
                cell5.StrorenameLabel.text = model.storename;
                [cell5.GoodsImageView sd_setImageWithURL:[NSURL URLWithString:model.scopeimg] placeholderImage:[UIImage imageNamed:@"default_image"] options:SDWebImageProgressiveDownload];
                cell5.GoodsNameLabel.text=model.name;
                cell5.GoodsAmountLabel.text=[NSString stringWithFormat:@"%@人付款",model.amount];
                cell5.GoodsPriceLabel.text=[NSString stringWithPrice:model.pay_maney andInterger:model.pay_integer];

            }

            return cell5;
        }

    }else
    {
        if (_datasArrM7.count==0) {

            NoCollectionViewCell  *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"nocell" forIndexPath:indexPath];


            return cell;

        }else{


            //            NSLog(@"==_datasArrM7.count=====%ld",_datasArrM7.count);

            FristHomeCell *cell5=[collectionView dequeueReusableCellWithReuseIdentifier:@"Home" forIndexPath:indexPath];

            if (!(_datasArrM1.count==0)) {

                //                cell5=[collectionView dequeueReusableCellWithReuseIdentifier:@"cell5" forIndexPath:indexPath];

                AllSingleShoppingModel *model=_datasArrM1[indexPath.row];

                //            [cell5.GoodsImageView sd_setImageWithURL:[NSURL URLWithString:model.scopeimg]];
                cell5.status = model.statu;//判断是否售完
                //  cell5.stock = model.stock;
                cell5.StrorenameLabel.text = model.storename;
                [cell5.GoodsImageView sd_setImageWithURL:[NSURL URLWithString:model.scopeimg] placeholderImage:[UIImage imageNamed:@"default_image"] options:SDWebImageProgressiveDownload];
                cell5.GoodsNameLabel.text=model.name;
                cell5.GoodsAmountLabel.text=[NSString stringWithFormat:@"%@人付款",model.amount];
                cell5.GoodsPriceLabel.text=[NSString stringWithPrice:model.pay_maney andInterger:model.pay_integer];

            }

            return cell5;
        }

    }
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    if (collectionView==_collectionView1) {
        AllSingleShoppingModel *model=_datasArrM4[indexPath.row];

        YTGoodsDetailViewController *vc=[[YTGoodsDetailViewController alloc] init];

        vc.type=@"1";//判断返回界面
        vc.NewHomeString = @"1";
        vc.ID=model.gid;
        vc.gid=model.gid;
        //  vc.good_type=model.good_type;
        vc.status=model.statu;
        vc.attribute = model.is_attribute;
        //        NSLog(@"====%@",vc.gid);

        [self.navigationController pushViewController:vc animated:NO];

        self.navigationController.navigationBar.hidden=YES;

        self.tabBarController.tabBar.hidden=YES;
    }else if (collectionView==_collectionView2){
        AllSingleShoppingModel *model=_datasArrM3[indexPath.row];

        //        NewGoodsDetailViewController *vc=[[NewGoodsDetailViewController alloc] init];

        YTGoodsDetailViewController *vc=[[YTGoodsDetailViewController alloc] init];
        vc.type=@"1";//判断返回界面
        vc.NewHomeString = @"1";
        vc.gid=model.gid;
        vc.ID=model.gid;
        //  vc.good_type=model.good_type;
        vc.status=model.statu;
        vc.attribute = model.is_attribute;
        //        NSLog(@"====%@",vc.gid);

        [self.navigationController pushViewController:vc animated:NO];

        self.navigationController.navigationBar.hidden=YES;

        self.tabBarController.tabBar.hidden=YES;
    }else if (collectionView==_collectionView3){
        AllSingleShoppingModel *model=_datasArrM5[indexPath.row];

        //        NewGoodsDetailViewController *vc=[[NewGoodsDetailViewController alloc] init];
        YTGoodsDetailViewController *vc=[[YTGoodsDetailViewController alloc] init];

        vc.type=@"1";//判断返回界面
        vc.NewHomeString = @"1";
        vc.gid=model.gid;
        vc.ID=model.gid;
        //    vc.good_type=model.good_type;
        vc.status=model.statu;
        vc.attribute = model.is_attribute;
        //        NSLog(@"====%@",vc.gid);

        [self.navigationController pushViewController:vc animated:NO];

        self.navigationController.navigationBar.hidden=YES;

        self.tabBarController.tabBar.hidden=YES;
    }else if (collectionView==_collectionView4){
        AllSingleShoppingModel *model=_datasArrM6[indexPath.row];

        //        NewGoodsDetailViewController *vc=[[NewGoodsDetailViewController alloc] init];

        YTGoodsDetailViewController *vc=[[YTGoodsDetailViewController alloc] init];
        vc.type=@"1";//判断返回界面
        vc.NewHomeString = @"1";
        vc.gid=model.gid;
        vc.ID=model.gid;
        //    vc.good_type=model.good_type;
        vc.status=model.statu;
        vc.attribute = model.is_attribute;

        //        NSLog(@"====%@",vc.gid);

        [self.navigationController pushViewController:vc animated:NO];

        self.navigationController.navigationBar.hidden=YES;

        self.tabBarController.tabBar.hidden=YES;
    }else if (collectionView==_collectionView5){
        AllSingleShoppingModel *model=_datasArrM7[indexPath.row];

        //        NewGoodsDetailViewController *vc=[[NewGoodsDetailViewController alloc] init];

        YTGoodsDetailViewController *vc=[[YTGoodsDetailViewController alloc] init];
        vc.type=@"1";//判断返回界面
        vc.NewHomeString = @"1";
        vc.gid=model.gid;
        vc.ID=model.gid;
        //  vc.good_type=model.good_type;
        vc.status=model.statu;
        vc.attribute = model.is_attribute;

        //        NSLog(@"====%@",vc.gid);

        [self.navigationController pushViewController:vc animated:NO];

        self.navigationController.navigationBar.hidden=YES;

        self.tabBarController.tabBar.hidden=YES;
    }else if (collectionView==_collectionView6){
        AllSingleShoppingModel *model=_datasArrM1[indexPath.row];

        //        NewGoodsDetailViewController *vc=[[NewGoodsDetailViewController alloc] init];

        YTGoodsDetailViewController *vc=[[YTGoodsDetailViewController alloc] init];
        vc.type=@"1";//判断返回界面
        vc.NewHomeString = @"1";
        vc.gid=model.gid;
        vc.ID=model.gid;
        //  vc.good_type=model.good_type;
        vc.status=model.statu;
        vc.attribute = model.is_attribute;

        //        NSLog(@"====%@",vc.gid);

        [self.navigationController pushViewController:vc animated:NO];

        self.navigationController.navigationBar.hidden=YES;

        self.tabBarController.tabBar.hidden=YES;
    }

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


    NSLog(@"商户首页定位成功!");

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
        if (city) {
            NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
            [defaults setObject:city forKey:@"city"];
        }
        self.MapStartAddress = [NSString stringWithFormat:@"%@%@%@",administrativeArea, subLocality, name];
        [kUserDefaults setObject:self.jindu forKey:@"jindu"];
        [kUserDefaults setObject:self.weidu forKey:@"weidu"];
        [kUserDefaults setObject:self.MapStartAddress forKey:@"mapStartAddress"];
        YLog(@"%@,%@,%@",self.jindu,self.weidu,self.MapStartAddress);
    }];




    //停止定位
    [_locationManager stopUpdatingLocation];


}
//定位失败
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"定位失败:%@", error);

    self.jindu = @"113.951289";

    self.weidu = @"22.541624";

    self.MapStartAddress = @"广东省深圳市南山区科技南十二路";
    [kUserDefaults setObject:self.jindu forKey:@"jindu"];
    [kUserDefaults setObject:self.weidu forKey:@"weidu"];
    [kUserDefaults setObject:self.MapStartAddress forKey:@"mapStartAddress"];
}


//下拉刷新方法
- (void)refresh:(DJRefresh *)refresh didEngageRefreshDirection:(DJRefreshDirection)direction{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self addDataWithDirection:direction];
    });
}
//下拉刷新
- (void)addDataWithDirection:(DJRefreshDirection)direction{

    if (direction==DJRefreshDirectionTop) {

        self.datacount=0;
        hud=[WKProgressHUD showInView:self.view withText:@"" animated:YES];
        [_datasArrM1 removeAllObjects];

        [_headerArrM removeAllObjects];

        [_ImageViewArrM removeAllObjects];


        [self getDatas];

        [self getdata1];

        [self getDatas1];


        [self getDatas4];
        [self getdatas6];
        [self getDatas5];

        [_refresh finishRefreshingDirection:direction animation:YES];

    }else
    {
        hud=[WKProgressHUD showInView:self.view withText:@"" animated:YES];
        [self getdatas6];
        [_refresh finishRefreshingDirection:direction animation:YES];

    }


}

//登录协议方法
-(void)setSigenWithString:(NSString *)string1 andStatusWithString:(NSString *)string2 andIntegralWithString:(NSString *)string3 andPhoneWithString:(NSString *)string4 andHeaderImageWithString:(NSString *)string5 andUserId:(NSString *)string6
{

    self.status=string2;
    self.sigen=string1;
    self.phone=string4;
    self.integral=string3;
    self.portrait=string5;
    self.userid=string6;

}

//监测滚动的事件、判断顶部视图颜色和回到顶部按钮是否显示
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //    //根据位移量显示顶部图片的颜色和透明度
    //    if (_tableView.contentOffset.y / 100 >=1.00000) {
    //
    //        ColorImg.image = [UIImage imageNamed:@"top"];
    //
    //    }else{
    //
    //        ColorImg.image = [UIImage imageNamed:@""];
    //        ColorImg.image=[UIImage imageWithBgColor:RGBA(255, 91, 94, _tableView.contentOffset.y/100)];
    //        //    ColorImg.image = [self imageWithBgColor:[UIColor colorWithRed:255/255.0 green:91/255.0 blue:94/255.0 alpha:_tableView.contentOffset.y / 100]];
    //    }

    //========//
    //使用偏移量获取当前的页
    NSInteger currentPage = scrollView.contentOffset.y / [UIScreen mainScreen].bounds.size.height;

    //划过一页也就是在第三页开始显示的时候显示置顶按钮
    if (currentPage >= 1) {

        _zhiding.hidden=NO;

    }else{

        _zhiding.hidden=YES;

    }

}

//回到顶部
-(void)gotoYT
{
    [_tableView setContentOffset:CGPointZero animated:YES];
}

/*******************************************************      代码提取(多是复用代码)       ******************************************************/
//倒计时为0反向代理
-(void)RecetHomeHeaderReloadData
{
    [self getDatas];
}
//跳到appstore
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{

    if (buttonIndex==0) {

        NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"https://itunes.apple.com/cn/app/tao-hui-o2o-dian-shang-ping/id1097442593?mt=8"];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }
}

-(void)setDatacount:(NSInteger)datacount
{
    _datacount=datacount;
    if (datacount==6) {
        [hud dismiss:YES];
        [_tableView reloadData];
        [_collectionView reloadData];
        [_collectionView1 reloadData];
        [_collectionView2 reloadData];
        [_collectionView3 reloadData];
        [_collectionView4 reloadData];
        [_collectionView5 reloadData];
        [_collectionView6 reloadData];
    }
    else if (datacount>6)
    {
        [hud dismiss:YES];
        if (_tableView.numberOfSections>=5) {
            [_tableView reloadSection:5 withRowAnimation:UITableViewRowAnimationNone];
        }
        [_collectionView6 reloadData];
    }
}
/*****
 *
 *  Description 收到推送消息
 *
 ******/
/*
 -(void)receivePushNoti:(NSNotification *)userinfo
 {
 NSLog(@"userinfo=%@",userinfo);
 NSLog(@"debug");
 NSDictionary *dic2= userinfo.userInfo;
 NSLog(@"userinfo=%@",dic2);
 NSLog(@"debug");
 NSDictionary *dic = dic2[@"parm"];
 NSLog(@"========推送消息==%@",dic);
 self.sigen=[NSString stringWithFormat:@"%@",[kUserDefaults objectForKey:@"sigen"]];
 NSString *pid=[NSString stringWithFormat:@"%@",dic[@"pid"]];

 if ([dic[@"type"] isEqualToString:@"1"]) {
 [self SystemMessageGoToVCWithPid:pid];

 }else if ([dic[@"type"] isEqualToString:@"2"])
 {

 NSDictionary *params=@{@"is_push":@0,@"id":pid,@"type":@2};
 [ATHRequestManager requestforAppUpdatePushTriggerInfoWithParams:params successBlock:^(NSDictionary *responseObj) {
 NSString *sysType=@"";

 AllDanModel *model=[[AllDanModel alloc]init];
 for (NSDictionary *dic in responseObj[@"list"]) {
 sysType=[NSString stringWithFormat:@"%@",dic[@"sys_type"]];
 model.orderno=[NSString stringWithFormat:@"%@",dic[@"orderno"]];
 model.order_type=[NSString stringWithFormat:@"%@",dic[@"order_type"]];
 }
 if ([sysType isEqualToString:@"0"]) {
 [self SystemMessageGoToVCWithPid:pid];
 }else
 {

 model.storename=@"";
 model.logo=@"";
 model.type=@"1";
 model.take_off_type=@"";

 NSDictionary *params=@{@"sigen":self.sigen,@"id":pid,@"sys_type":@"1"};

 [ATHRequestManager requestForMessageChangePushIsReadWithParams:params successBlock:^(NSDictionary *responseObj) {

 } faildBlock:^(NSError *error) {

 }];
 [self AccountMessageGoToWithModel:model];

 }
 } faildBlock:^(NSError *error) {

 }];


 }



 }
 //判断推送为系统通知跳转
 -(void)SystemMessageGoToVCWithPid:(NSString *)pid
 {
 MessageListModel *model=[MessageListModel new];
 model=[JMSHTDBDao getMessageInfoFromMessageListWith:pid];
 model.ID=pid;
 if ([self.sigen isEqualToString:@""]||[self.sigen containsString:@"null"]) {

 [JMSHTDBDao updateMessageInfoInMessageListwith:model];
 }else
 {
 NSDictionary *params=@{@"sigen":self.sigen,@"id":model.ID,@"sys_type":@"0"};

 [ATHRequestManager requestForMessageChangePushIsReadWithParams:params successBlock:^(NSDictionary *responseObj) {

 } faildBlock:^(NSError *error) {

 }];
 }

 if ([model.gid containsString:@"null"]||[model.gid isEqualToString:@""]) {
 return;
 }
 NSLog(@"需要些跳转====gid==%@",model.gid);

 YTGoodsDetailViewController *vc=[[YTGoodsDetailViewController alloc]init];
 vc.gid=model.gid;
 UINavigationController *navi1=self.tabBarController.viewControllers.firstObject;
 navi1.viewControllers=@[navi1.viewControllers.firstObject,vc];
 self.tabBarController.viewControllers=@[navi1,self.tabBarController.viewControllers[1],self.tabBarController.viewControllers[2],self.tabBarController.viewControllers[3]];
 self.tabBarController.selectedIndex=0;
 self.tabBarController.tabBar.hidden=YES;
 }
 //判断推送的消息为用户消息跳转
 -(void)AccountMessageGoToWithModel:(AllDanModel *)model
 {
 NSDictionary *param2=@{@"sigen":_sigen,@"orderno":model.orderno};
 [ATHRequestManager requestForGetOrderStatusWithParams:param2 successBlock:^(NSDictionary *responseObj) {
 } faildBlock:^(NSError *error) {

 }];


 }
 */

//重写属性set方法、判断显示右上角消息小红点
-(void)setTotalNum:(NSString *)totalNum
{
    _totalNum=totalNum;
    if ([totalNum isEqualToString: @"0"]||[totalNum containsString:@"null"]||[totalNum isEqualToString:@""]) {
        IVYuan.hidden=YES;
    }else
    {
        IVYuan.hidden=NO;
    }

}

@end


