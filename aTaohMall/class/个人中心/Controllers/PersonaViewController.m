//
//  PersonaViewController.m
//  ATAoHuiMall
//
//  Created by JMSHT on 16/5/10.
//  Copyright © 2016年 yt. All rights reserved.
//

#import "PersonaViewController.h"
#import "personHeaderView.h"
#import "PersonCell.h"
#import "MessageCell.h"
#import "FristHomeCell.h"


#import "MyScoreViewController.h"//我的积分

#import "MyPayCardViewController.h"//我的银行卡

#import "FanLiViewController.h"//推广返利

#import "CountMessageViewController.h"//账户信息

#import "NewLoginViewController.h"//新登录

#import "AFNetworking.h"

#import "UserMessageManager.h"//缓存用户名

#import "SettingPassWordViewController.h"//设置

//我的订单
#import "PersonalAllDanVC.h"//全部订单

#import "PersonalAllDanVC.h"
//刷新
#import "DJRefresh.h"
#import "DJRefreshProgressView.h"

#import "XSInfoView.h"

#import "JRToast.h"

#import "UIImageView+WebCache.h"

#import "NewHomeViewController.h"

#import "YTOtherLoginViewController.h"

#import "YTLoginViewController.h"

#import "ATHLoginViewController.h"

#import "NewScoreViewController.h"//我的积分

#import "RecomdViewController.h"//推荐奖励

#import "MerchantMapViewController.h"//商圈


#import "PersonAllScoreVC.h"
#import "PersonalAllDanVC.h"
#import "PersonalRefundDanVC.h"

//MapKit是原生地图框架
#import <MapKit/MapKit.h>

//CoreLocation是定位框架
#import <CoreLocation/CoreLocation.h>


#import "HomeModel2.h"
#import "YTGoodsDetailViewController.h"
#import "WKProgressHUD.h"

@interface PersonaViewController ()<UITableViewDataSource,UITableViewDelegate,OutMessageDelegate,DJRefreshDelegate,ChangHeaderImageDelegate,MKMapViewDelegate, CLLocationManagerDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
{
    UITableView *_tableView;
    
    UICollectionView *_collectionView;
    
    CGFloat  cellHeight;
    
    NSMutableArray *_datasArrM;
    
    personHeaderView *_headerView;//表头
    
    
    UIView *view;
    AFHTTPRequestOperationManager *manager;
    
    NSTimer *timer;
    
    int YT;
    
    //地图View
    MKMapView *_mapView;
    
    //定位管理器
    CLLocationManager *_locationManager;
    
    NSString *wait_delivery_sum;
    NSString *wait_payment_sum;
    NSString *wait_receive_goods_sum;
    
    UIButton *_zhiding;
    UITapGestureRecognizer *tap;
    BOOL CannotRefresh;
}

@property (nonatomic,strong)DJRefresh *refresh;
@property (nonatomic,strong)NSString *hahahahahah;
/** 上次选中的索引(或者控制器) */
@property (nonatomic, assign) NSInteger lastSelectedIndex;

@end

@implementation PersonaViewController
/*******************************************************      控制器生命周期       ******************************************************/
- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];

    //读取数组NSArray类型的数据
    NSLog(@"===>>>>%@==%@=",[userDefaultes stringForKey:@"status"],[userDefaultes stringForKey:@"sigen"]);

    if ([[userDefaultes stringForKey:@"status"] isEqualToString:@"YES"]) {
        
        self.sigen=[userDefaultes stringForKey:@"sigen"];
        
        self.UserName=[userDefaultes stringForKey:@"new"];
        //头像
        self.portrait=[userDefaultes stringForKey:@"header"];
        
        self.integral=[userDefaultes stringForKey:@"integer"];
        
        self.status=[userDefaultes stringForKey:@"number"];
        
        
        _refresh=[[DJRefresh alloc] initWithScrollView:_tableView delegate:self];
        _refresh.topEnabled=YES;//下拉刷新
        _refresh.bottomEnabled=NO;//上拉加载
        
    }else{
        self.sigen=@"";
        _refresh=[[DJRefresh alloc] initWithScrollView:_tableView delegate:self];
        _refresh.topEnabled=NO;//下拉刷新
        _refresh.bottomEnabled=NO;//上拉加载
    }
    [self getUserAccountData];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBar.hidden=YES;
    self.navigationController.interactivePopGestureRecognizer.enabled=NO;
    self.view.frame=[UIScreen mainScreen].bounds;

    
    [self initData];//初始化数据
    //登录通知
    [KNotificationCenter addObserver:self selector:@selector(login) name:JMSHTLoginSuccessNoti object:nil];
    //退出登录通知
    [KNotificationCenter addObserver:self selector:@selector(outStatus) name:JMSHTLogOutSuccessNoti object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(BMNotification:) name:@"BMNotification" object:nil];
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(CartDataFinish:) name:@"CartDataFinish" object:nil];
    static NSString *tabBarDidSelectedNotification = @"tabBarDidSelectedNotification";
    //注册接收通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarSeleted) name:tabBarDidSelectedNotification object:nil];

    
    
   
    [self createTableView];
    
    
    _zhiding=[UIButton buttonWithType:UIButtonTypeCustom];
    _zhiding.hidden=YES;
    
    _zhiding.frame=CGRectMake(self.view.frame.size.width-44, self.view.frame.size.height-120, 44, 44);
    //        _zhiding.backgroundColor=[UIColor orangeColor];
    [_zhiding setBackgroundImage:[UIImage imageNamed:@"置顶"] forState:0];
    _zhiding.layer.masksToBounds = YES;
    _zhiding.layer.cornerRadius = _zhiding.bounds.size.width*0.5;
    
    [_zhiding addTarget:self action:@selector(gotoYT) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_zhiding];
    
    
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
    //    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0 ) {
    //        [_locationManager requestAlwaysAuthorization];
    //        [_locationManager requestWhenInUseAuthorization];
    //    }
    
    //启动定位
    [_locationManager startUpdatingLocation];

}

// 接收到通知实现方法
- (void)tabBarSeleted {

    // 如果是连续选中2次, 直接刷新
    if (self.lastSelectedIndex == self.tabBarController.selectedIndex && [self isShowingOnKeyWindow]&&!CannotRefresh) {
        CannotRefresh=YES;
        _tableView.contentOffset=CGPointZero;
        //直接写刷新代码
        [_refresh startRefreshingDirection:DJRefreshDirectionTop animation:YES];
    }

    // 记录这一次选中的索引
    self.lastSelectedIndex = self.tabBarController.selectedIndex;

}

/**
 * 判断一个控件是否真正显示在主窗口
 */
- (BOOL)isShowingOnKeyWindow
{
    // 主窗口
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;

    // 以主窗口左上角为坐标原点, 计算self的矩形框
    CGRect newFrame = [keyWindow convertRect:self.view.frame fromView:self.view.superview];
    CGRect winBounds = keyWindow.bounds;

    // 主窗口的bounds 和 self的矩形框 是否有重叠
    BOOL intersects = CGRectIntersectsRect(newFrame, winBounds);

    return !self.view.isHidden && self.view.alpha > 0.01 && self.view.window == keyWindow && intersects;
}

-(void)gotoYT
{
    [_tableView setContentOffset:CGPointZero animated:YES];
}

-(void)initData
{
    self.CartString = @"100";//判断购物车是否加载完成
    [self GetDatas];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*******************************************************      数据请求       ******************************************************/
//获取用户信息
-(void)getUserAccountData
{

    NSNull *null=[[NSNull alloc] init];

    if (self.sigen.length==0) {
        self.sigen=@"";
    }
        
        manager = [AFHTTPRequestOperationManager manager];
        
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        NSString *url = [NSString stringWithFormat:@"%@getAccountInfo_mob.shtml",URL_Str];
        
        NSLog(@"''''''''''''''''%@",self.sigen);
        NSDictionary *dic = @{@"sigen":self.sigen};
        
        //    NSLog(@"-------------------------------------------%@",self.sigens);
        [manager POST:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
            NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];
            if (codeKey && content) {
                NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
                xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
                xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
                
                NSLog(@"xmlStr%@",xmlStr);
                
                
                NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];
                
                
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                
                NSLog(@"=====个人中心账户中心==%@",dic);
                view.hidden=YES;
                for (NSDictionary *dict in dic) {
                    
                    NSLog(@"+++%@",dict[@"integer"]);
                    
                    self.integral=dict[@"integer"];
                    self.healthyInteger=[NSString stringWithFormat:@"%@",dict[@"healthy_integral"]];
                    if ([self.healthyInteger containsString:@"null"]) {
                        self.healthyInteger=@"0.00";
                    }
                    wait_payment_sum=[NSString stringWithFormat:@"%@",dict[@"wait_payment_sum"]];
                    wait_delivery_sum=[NSString stringWithFormat:@"%@",dict[@"wait_delivery_sum"]];
                    wait_receive_goods_sum=[NSString stringWithFormat:@"%@",dict[@"wait_receive_goods_sum"]];
                    if ([wait_payment_sum isEqualToString:@"(null)"]) {
                        wait_payment_sum=@"0";
                    }
                    if ([wait_delivery_sum isEqualToString:@"(null)"]) {
                        wait_delivery_sum=@"0";
                    }if ([wait_receive_goods_sum isEqualToString:@"(null)"]) {
                        wait_receive_goods_sum=@"0";
                    }
                    //缓存用户名
                    [UserMessageManager UserInteger:dict[@"integer"]];
                    
                    for (NSDictionary *dict1 in dict[@"list"]) {
                        
                        NSLog(@"+++%@",dict1[@"portrait"]);
                        NSLog(@"+++%@",dict1[@"username"]);
                        
                        self.UserName=dict1[@"username"];
                        
                        [UserMessageManager UserNewName:dict1[@"username"]];
                        
                        
                        
                        if ([dict1[@"portrait"] isEqual:null] || [dict1[@"portrait"] isEqualToString:@""]) {
                            
                            //头像
                            self.portrait=@"头像";
                            
                            //缓存头像
                            [UserMessageManager UserHeaderImage:@"头像"];
                            
                        }else{
                            
                            //头像
                            self.portrait=dict1[@"portrait"];
                            //缓存头像
                            [UserMessageManager UserHeaderImage:dict1[@"portrait"]];
                        }
                        
                        
                    }
                    
                }
                [_tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@",error);
            
            //            [self NoWebSeveice];
            
            [JRToast showWithText:@"网络请求失败，请检查你的网络设置" duration:3.0f];

        }];

}
//获取热门商品数据
-(void)GetDatas
{
    WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];

    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数组NSArray类型的数据
    self.sigen=[userDefaultes stringForKey:@"sigen"];

    if (self.sigen.length==0) {
        self.sigen = @"";
    }
    if (!_datasArrM) {
        _datasArrM=[NSMutableArray new];
    }

    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];

    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    NSDictionary *dict=@{@"sigen":self.sigen};

    NSString *url=[NSString stringWithFormat:@"%@selectForyouToData_mob.shtml",URL_Str];

    [manager POST:url parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {

    } success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
        NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];
        [_datasArrM removeAllObjects];

        if (codeKey && content) {
            NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];

            NSLog(@"=======xmlStr%@",xmlStr);


            NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];


            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];

            if ([dic[@"status"] isEqualToString:@"10000"]) {

                for (NSDictionary *dict in dic[@"list_goods"]) {

                   //  *model = [[DPModel alloc] init];
                                        HomeModel2 *model2=[[HomeModel2 alloc]init];
                                        model2.name = [NSString stringWithFormat:@"%@",dict[@"name"]];
                                        model2.amount=[NSString stringWithFormat:@"%@",dict[@"amount"]];
                                        model2.gid=[NSString stringWithFormat:@"%@",dict[@"id"]];
                                        model2.pay_integer=[NSString stringWithFormat:@"%@",dict[@"pay_integer"]];
                                        model2.pay_maney=[NSString stringWithFormat:@"%@",dict[@"pay_maney"]];
                                        model2.scopeimg=[NSString stringWithFormat:@"%@",dict[@"scopeimg"]];
                                        model2.status=[NSString stringWithFormat:@"%@",dict[@"status"]];
                                        model2.good_type=[NSString stringWithFormat:@"%@",dict[@"good_type"]];
                                        model2.attribute = [NSString stringWithFormat:@"%@",dict[@"is_attribute"]];
                                        model2.storename = [NSString stringWithFormat:@"%@",dict[@"storename"]];
                                        model2.stock = [NSString stringWithFormat:@"%@",dict[@"stock"]];
                                        [_datasArrM addObject:model2];
//                    model.DP_id = [NSString stringWithFormat:@"%@",dict[@"id"]];
//                    model.mid = [NSString stringWithFormat:@"%@",dict[@"mid"]];
//                    model.name = [NSString stringWithFormat:@"%@",dict[@"name"]];
//                    model.status = [NSString stringWithFormat:@"%@",dict[@"status"]];
//                    model.scopeimg = [NSString stringWithFormat:@"%@",dict[@"scopeimg"]];
//                    model.pay_maney = [NSString stringWithFormat:@"%@",dict[@"pay_maney"]];
//                    model.pay_integer = [NSString stringWithFormat:@"%@",dict[@"pay_integer"]];
//                    model.storename = [NSString stringWithFormat:@"%@",dict[@"storename"]];
//                    model.tid = [NSString stringWithFormat:@"%@",dict[@"tid"]];
//                    model.good_type = [NSString stringWithFormat:@"%@",dict[@"good_type"]];
//                    model.amount = [NSString stringWithFormat:@"%@",dict[@"amount"]];
//                    model.stock = [NSString stringWithFormat:@"%@",dict[@"stock"]];

            //        [_data addObject:model];
                }


            }else{

                [TrainToast showWithText:dic[@"message"] duration:2.0f];

            }
            [hud dismiss:YES];
            CannotRefresh=NO;
            [_tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];

        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {

        [hud dismiss:YES];
        CannotRefresh=NO;
        NSLog(@"errpr = %@",error);
    }];
}
//没有网络点击重新获取
-(void)loadData
{
    
    [self getUserAccountData];
    [self GetDatas];
}
/*******************************************************      初始化视图       ******************************************************/
-(void)createTableView
{
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, -20-KSafeTopHeight, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-29) style:UITableViewStyleGrouped];
    //去掉cell分割线
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    //去掉右侧滚动条
    _tableView.showsVerticalScrollIndicator=NO;
    _tableView.delegate=self;
    _tableView.estimatedRowHeight=0;
    _tableView.estimatedSectionFooterHeight=0;
    _tableView.estimatedSectionHeaderHeight=0;
    _tableView.dataSource=self;
    
    //注册Cell
    
    [_tableView registerNib:[UINib nibWithNibName:@"PersonCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    
  //  [_tableView registerNib:[UINib nibWithNibName:@"MessageCell" bundle:nil] forCellReuseIdentifier:@"Cell1"];
    
    //header
    [_tableView registerNib:[UINib nibWithNibName:@"personHeaderView" bundle:nil] forHeaderFooterViewReuseIdentifier:@"HeaderCell"];
  //  [_tableView registerClass:[personHeaderView class] forCellReuseIdentifier:@"HeaderCell"];
    [self.view addSubview:_tableView];
    [_tableView setBackgroundColor:RGB(244, 244, 244)];

}
-(void)initCollection1
{

    cellHeight = ([UIScreen mainScreen].bounds.size.width-2)/2.0+110;
    float fWidth = [UIScreen mainScreen].bounds.size.width;
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    if (_datasArrM.count%2==0) {
        
        _collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 40, fWidth, (_datasArrM.count/2)*cellHeight+2+20) collectionViewLayout:flowLayout];
        
    }else{
        
        _collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 40, fWidth, ((_datasArrM.count+1)/2)*cellHeight+2+20) collectionViewLayout:flowLayout];
    }
    
    _collectionView.backgroundColor=[UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1.0];
    
    _collectionView.delegate=self;
    _collectionView.dataSource=self;
    _collectionView.scrollEnabled=NO;
    [_collectionView registerClass:[FristHomeCell class] forCellWithReuseIdentifier:@"Home"];
  
    
}
#pragma mark - UITableView的代理方法

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    cellHeight = ([UIScreen mainScreen].bounds.size.width-2)/2.0+110;
    if (indexPath.section==0) {
        return 131;
    }else
    {
        if (_datasArrM.count==0) {
            return 0;
        }else
        {
            if (_datasArrM.count%2==0) {
                
                return  (_datasArrM.count/2)*(cellHeight+2)+40+2;
                
            }else{
                
                return  ((_datasArrM.count+1)/2)*(cellHeight+2)+40+2;
            }

        }
        
    }
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 335;
    }else
    {
        return 0.01;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section==0) {
    
    _headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"HeaderCell"];
    //图片切成圆形
    _headerView.headerImageView.layer.masksToBounds=YES;
    _headerView.headerImageView.layer.cornerRadius=35;
    NSLog(@"======%@",self.portrait);
    //显示账户名与积分
    if ([[kUserDefaults objectForKey:@"status"] isEqualToString:@"YES"]) {
        _headerView.loginButton.hidden=YES;
        _headerView.DengLuLAbel.hidden=YES;
        _headerView.UserMessageBut.hidden=NO;
        _headerView.SettingButton.hidden=NO;
        _headerView.UserNameLabel.hidden=NO;
        _headerView.UserScoreLabel.hidden=NO;
        _headerView.UserHeathyLab.hidden=NO;

        _headerView.headerImageView.image=[UIImage imageNamed:@"头像"];
        NSNull *null=[[NSNull alloc] init];
        if ([self.portrait isEqual:null] || [self.portrait isEqualToString:@""]||[self.portrait isEqualToString:@"(null)"]) {
            
            _headerView.headerImageView.image=[UIImage imageNamed:@"头像"];
            
        }else{
            
            if ([self.portrait isEqualToString:@"头像"]) {
                
                _headerView.headerImageView.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@",self.portrait]];
            }else{
                
                [_headerView.headerImageView sd_setImageWithURL:[NSURL URLWithString:self.portrait]];
            }
            
        }
        
       
        
        _headerView.UserScoreLabel.text=[NSString stringWithFormat:@"购物积分：%.02f",[self.integral doubleValue]];
        _headerView.UserHeathyLab.text=[NSString stringWithFormat:@"健康积分：%.02f",[self.healthyInteger doubleValue]];
        //用户名
        _headerView.UserNameLabel.text=self.UserName;
        
        [_headerView.UserMessageBut addTarget:self action:@selector(UserMessageBtnClick) forControlEvents:UIControlEventTouchUpInside];
        //设置
        [_headerView.SettingButton addTarget:self action:@selector(SettingBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }else{

        //登录按钮点击事件
        [_headerView.loginButton addTarget:nil action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _headerView.UserMessageBut.hidden=YES;
        _headerView.loginButton.hidden=NO;
        _headerView.DengLuLAbel.hidden=NO;
        //隐藏信息
        _headerView.SettingButton.hidden=YES;
        _headerView.UserNameLabel.hidden=YES;
        _headerView.UserScoreLabel.hidden=YES;
        _headerView.UserHeathyLab.hidden=YES;
    }
    //全部订单点击事件
    [_headerView.GoAllDingDanButton addTarget:self action:@selector(goAllDingDanBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //待付款
    [_headerView.DaiFuKuanButton addTarget:self action:@selector(DaiFuKuanBtnClick) forControlEvents:UIControlEventTouchUpInside];

        if (wait_payment_sum&&wait_delivery_sum&&wait_receive_goods_sum) {
        if (!([wait_payment_sum isEqualToString:@""]||[wait_payment_sum isEqualToString:@"(null)"]||[wait_payment_sum isEqualToString:@"0"])) {
          NSString *str =[wait_payment_sum integerValue]>99?@"99+":[NSString stringWithFormat:@"%@",wait_payment_sum];
            
            _headerView.DaiFuKuanButton.badgeValue=str;
        }else
        {
            _headerView.DaiFuKuanButton.badgeValue=@"";
        }
        if (!([wait_receive_goods_sum isEqualToString:@""]||[wait_receive_goods_sum isEqualToString:@"(null)"]||[wait_receive_goods_sum isEqualToString:@"0"])) {
            NSString *str =[wait_receive_goods_sum integerValue]>99?@"99+":[NSString stringWithFormat:@"%@",wait_receive_goods_sum];
            _headerView.DaiShouHuoButton.badgeValue=str;
        }else
        {
            _headerView.DaiShouHuoButton.badgeValue=@"";
        }
        if (!([wait_delivery_sum isEqualToString:@""]||[wait_delivery_sum isEqualToString:@"(null)"]||[wait_delivery_sum isEqualToString:@"0"])) {
            NSString *str =[wait_delivery_sum integerValue]>99?@"99+":[NSString stringWithFormat:@"%@",wait_delivery_sum];
            _headerView.DaiFaHuoButton.badgeValue=str;
        }else
        {
            _headerView.DaiFaHuoButton.badgeValue=@"";
        }
        }
        
        
        
    //待发货
    [_headerView.DaiFaHuoButton addTarget:self action:@selector(DaiFaHuoBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    //待收货
    [_headerView.DaiShouHuoButton addTarget:self action:@selector(DaiShouHuoBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    //交易完成
    [_headerView.JiaoYiWanChengButton addTarget:self action:@selector(JiaoYiWanChengBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    //退款单
    [_headerView.TuiHuoDanButton addTarget:self action:@selector(TuiHuoDanBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    _tableView.backgroundColor =[UIColor whiteColor];
    return _headerView;
    }
    else
    {
        UIView *view1=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 0.01)];
        
        return view1;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [[UIView alloc]init];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        
    PersonCell *cell=[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    //我的积分
    [cell.myScoreButton addTarget:self action:@selector(myScoreBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    //我的银行卡
    [cell.myPayCard addTarget:self action:@selector(myPayCardBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    //我的商圈
    [cell.myBusinessQurtButton addTarget:self action:@selector(myBusinessQurtBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    //推广返利
    [cell.TuiGuangfanliButton addTarget:self action:@selector(TuiGuangfanliBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
    }
    else
    {
        UITableViewCell *cell=[[UITableViewCell alloc]init];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        UIView *view1=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 50)];
        NSString *str=@"热门商品";
        CGSize size=[str sizeWithFont:KNSFONTM(15) maxSize:CGSizeMake(200, 40)];
        UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMake((kScreen_Width-size.width)/2, (40-size.height)/2, size.width, size.height)];
        lab.font=KNSFONTM(15);
        lab.textColor=RGB(51, 51, 51);
        lab.text=str;
        
        [view1 addSubview:lab];
        UIImageView *IV=[[UIImageView alloc]initWithFrame:CGRectMake((kScreen_Width-size.width)/2-36-5, (40-7)/2, 36, 7)];
        IV.image=[UIImage imageNamed:@"left"];
        [view1 addSubview:IV];
        UIImageView *IV1=[[UIImageView alloc]initWithFrame:CGRectMake((kScreen_Width-size.width)/2+size.width+5, (40-7)/2, 36, 7)];
        IV1.image=[UIImage imageNamed:@"right"];
        [view1 addSubview:IV1];
        view1.backgroundColor=RGB(244, 244, 244);
        [cell addSubview:view1];
        [self initCollection1];
        [cell addSubview:_collectionView];
        return cell;
    }
}

#pragma mark - collectionView的代理方法
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _datasArrM.count;
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
    
    
        
    
        FristHomeCell *cell1=[collectionView dequeueReusableCellWithReuseIdentifier:@"Home" forIndexPath:indexPath];
        
        if (!(_datasArrM.count==0)) {
            
            HomeModel2 *model=_datasArrM[indexPath.row];
            cell1.status = model.status;//判断是否售完
            cell1.stock = model.stock;
            cell1.StrorenameLabel.text = model.storename;
            [cell1.GoodsImageView sd_setImageWithURL:[NSURL URLWithString:model.scopeimg] placeholderImage:[UIImage imageNamed:@"default_image"] options:SDWebImageProgressiveDownload];
            cell1.GoodsNameLabel.text=model.name;
            cell1.GoodsAmountLabel.text=[NSString stringWithFormat:@"%@人付款",model.amount];
            if ([model.pay_integer isEqualToString:@"0"] || [model.pay_integer isEqualToString:@""]) {
                cell1.GoodsPriceLabel.text=[NSString stringWithFormat:@"￥%.02f",[model.pay_maney floatValue]];
            }else if ([model.pay_maney isEqualToString:@"0"] || [model.pay_maney isEqualToString:@""]){
                cell1.GoodsPriceLabel.text=[NSString stringWithFormat:@"%.02f积分",[model.pay_integer floatValue]];
            }else{
                cell1.GoodsPriceLabel.text=[NSString stringWithFormat:@"￥%.02f+%.02f积分",[model.pay_maney floatValue],[model.pay_integer floatValue]];
            }
            
        }
        
        return cell1;
        
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
        HomeModel2 *model=_datasArrM[indexPath.row];
        
    
        
        YTGoodsDetailViewController *vc=[[YTGoodsDetailViewController alloc] init];
        
        vc.type=@"1";//判断返回界面
        vc.NewHomeString = @"1";
        vc.ID=model.gid;
        vc.gid=model.gid;
        vc.good_type=model.good_type;
        vc.status=model.status;
        vc.attribute = model.attribute;
        
        
        [self.navigationController pushViewController:vc animated:NO];
        
        self.navigationController.navigationBar.hidden=YES;
        
        self.tabBarController.tabBar.hidden=YES;
        
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //========//
    //使用偏移量获取当前的页
    NSInteger currentPage = scrollView.contentOffset.y / [UIScreen mainScreen].bounds.size.height;
    
    
    if (currentPage >= 1) {
        
        
        _zhiding.hidden=NO;
        
    }else{
        
        _zhiding.hidden=YES;
        
    }

}
/*******************************************************      各种button执行方法、页面间的跳转       ******************************************************/
//我的积分
-(void)myScoreBtnClick
{
    
  //  [kUserDefaults removeObjectForKey:VERSION_INFO_CURRENT];
    
    if (self.sigen.length==0) {
        //        NewLoginViewController *login=[[NewLoginViewController alloc] init];
        ATHLoginViewController *login=[[ATHLoginViewController alloc] init];
    //    login.delegate=self;
        
        [self.navigationController pushViewController:login animated:NO];
        
        self.navigationController.navigationBar.hidden=YES;
        self.tabBarController.tabBar.hidden=YES;
        
    }else{
        

        
        
        PersonAllScoreVC *mcVC=[[PersonAllScoreVC alloc] init];
    //    PersonalAllDanVC *mcVC=[[PersonalAllDanVC alloc] init];

        
        [self.navigationController pushViewController:mcVC animated:YES];
        
        //隐藏
        self.navigationController.navigationBar.hidden=YES;
        self.tabBarController.tabBar.hidden=YES;
    }
    
}

//我的银行卡
-(void)myPayCardBtnClick
{
    if (self.sigen.length==0) {
        
        //        NewLoginViewController *login=[[NewLoginViewController alloc] init];
        //
        //        login.delegate=self;
        
        //        YTLoginViewController *login=[[YTLoginViewController alloc] init];
        ATHLoginViewController *login=[[ATHLoginViewController alloc] init];
        
    //    login.delegate=self;
        
        [self.navigationController pushViewController:login animated:NO];
        
        self.navigationController.navigationBar.hidden=YES;
        self.tabBarController.tabBar.hidden=YES;
    }else{
        
        MyPayCardViewController *mpVC=[[MyPayCardViewController alloc] init];
        
        
        NSLog(@"===我的银行卡=%@==",mpVC.sigen);
        
        mpVC.sigen=self.sigen;
        
        [self.navigationController pushViewController:mpVC animated:YES];
        
        
        //隐藏
        self.navigationController.navigationBar.hidden=YES;
        self.tabBarController.tabBar.hidden=YES;
    }
    
}

//我的商圈
-(void)myBusinessQurtBtnClick
{
    
    //    [JRToast showWithText:@"即将开放，敬请期待!" duration:3.0f];
    
    MerchantMapViewController *vc = [[MerchantMapViewController alloc] init];
    
    self.navigationController.navigationBar.hidden=YES;
    
    self.tabBarController.tabBar.hidden=YES;
    
    vc.jindu = self.jindu;
    
    vc.weidu = self.weidu;
    
    vc.MapStartAddress = self.MapStartAddress;
    
    [self.navigationController pushViewController:vc animated:NO];
    
    
}

//推广返利
-(void)TuiGuangfanliBtnClick
{
    
    if (self.sigen.length==0) {
        
        //        NewLoginViewController *login=[[NewLoginViewController alloc] init];
        ATHLoginViewController *login=[[ATHLoginViewController alloc] init];
     //   login.delegate=self;
        
        [self.navigationController pushViewController:login animated:NO];
        
        self.navigationController.navigationBar.hidden=YES;
        self.tabBarController.tabBar.hidden=YES;
        
    }else{
        
        //        FanLiViewController *flVC=[[FanLiViewController alloc] init];
        //
        //
        
        RecomdViewController *flVC=[[RecomdViewController alloc] init];
        
        flVC.sigen=self.sigen;
        
        [self.navigationController pushViewController:flVC animated:YES];
        
        //隐藏
        self.navigationController.navigationBar.hidden=YES;
        self.tabBarController.tabBar.hidden=YES;
    }
    
}

//待付款
-(void)DaiFuKuanBtnClick
{
    if (self.sigen.length==0) {
        
        //        NewLoginViewController *login=[[NewLoginViewController alloc] init];
        //
        //        login.delegate=self;
        //
        //        [self.navigationController pushViewController:login animated:YES];
        
        
        //        YTOtherLoginViewController *vc =[[YTOtherLoginViewController alloc] init];
        
        ATHLoginViewController *login=[[ATHLoginViewController alloc] init];
     //   login.delegate=self;
        [self.navigationController pushViewController:login animated:NO];
        
        self.navigationController.navigationBar.hidden=YES;
        self.tabBarController.tabBar.hidden=YES;
        
    }else{
        
        PersonalAllDanVC *mcVC=[[PersonalAllDanVC alloc] init];

        [mcVC selectedDingDanType:@"0" AndIndexType:1];

        [self.navigationController pushViewController:mcVC animated:YES];

        //隐藏
        self.navigationController.navigationBar.hidden=YES;
        self.tabBarController.tabBar.hidden=YES;
    }
    
}
//待发货
-(void)DaiFaHuoBtnClick
{
    
    if (self.sigen.length==0) {
        
        //        NewLoginViewController *login=[[NewLoginViewController alloc] init];
        
        ATHLoginViewController *login=[[ATHLoginViewController alloc] init];
        
     //   login.delegate=self;
        
        [self.navigationController pushViewController:login animated:NO];
        
        self.navigationController.navigationBar.hidden=YES;
        self.tabBarController.tabBar.hidden=YES;
        
    }else{
        
        //        AllDingDanViewController *vc=[[AllDingDanViewController alloc] init];
        
        PersonalAllDanVC *mcVC=[[PersonalAllDanVC alloc] init];

        [mcVC selectedDingDanType:@"0" AndIndexType:2];
        [self.navigationController pushViewController:mcVC animated:YES];

        //隐藏
        self.navigationController.navigationBar.hidden=YES;
        self.tabBarController.tabBar.hidden=YES;
        
    }
    
    
}
//待收货
-(void)DaiShouHuoBtnClick
{
    
    if (self.sigen.length==0) {
        
        //        NewLoginViewController *login=[[NewLoginViewController alloc] init];
        
        ATHLoginViewController *login=[[ATHLoginViewController alloc] init];
        
   //     login.delegate=self;
        
        [self.navigationController pushViewController:login animated:NO];
        
        self.navigationController.navigationBar.hidden=YES;
        self.tabBarController.tabBar.hidden=YES;
        
    }else{
        
        //        AllDingDanViewController *vc=[[AllDingDanViewController alloc] init];
        PersonalAllDanVC *mcVC=[[PersonalAllDanVC alloc] init];

        [mcVC selectedDingDanType:@"0" AndIndexType:3];
        [self.navigationController pushViewController:mcVC animated:YES];

        //隐藏
        self.navigationController.navigationBar.hidden=YES;
        self.tabBarController.tabBar.hidden=YES;
    }
    
    
}
//交易完成
-(void)JiaoYiWanChengBtnClick
{
    
    if (self.sigen.length==0) {
        
        //        NewLoginViewController *login=[[NewLoginViewController alloc] init];
        
        ATHLoginViewController *login=[[ATHLoginViewController alloc] init];
        
     //   login.delegate=self;
        
        [self.navigationController pushViewController:login animated:NO];
        
        self.navigationController.navigationBar.hidden=YES;
        self.tabBarController.tabBar.hidden=YES;
        
    }else{
        
        //        AllDingDanViewController *vc=[[AllDingDanViewController alloc] init];
        
        PersonalAllDanVC *mcVC=[[PersonalAllDanVC alloc] init];

        [mcVC selectedDingDanType:@"0" AndIndexType:4];
        [self.navigationController pushViewController:mcVC animated:YES];

        //隐藏
        self.navigationController.navigationBar.hidden=YES;
        self.tabBarController.tabBar.hidden=YES;
    }
    
    
}

//退款单
-(void)TuiHuoDanBtnClick
{
    
    if (self.sigen.length==0) {
        
        //        NewLoginViewController *login=[[NewLoginViewController alloc] init];
        
        ATHLoginViewController *login=[[ATHLoginViewController alloc] init];
        
     //   login.delegate=self;
        
        [self.navigationController pushViewController:login animated:NO];
        
        self.navigationController.navigationBar.hidden=YES;
        self.tabBarController.tabBar.hidden=YES;
        
    }else{
        
//        NewRetRefundViewController *vc=[[NewRetRefundViewController alloc] init];
//
//        vc.sigen=self.sigen;
//
//        vc.jindu = self.jindu;
//        vc.weidu = self.weidu;
//        vc.MapStartAddress = self.MapStartAddress;

        PersonalRefundDanVC *vc=[[PersonalRefundDanVC alloc] init];

        [self.navigationController pushViewController:vc animated:NO];

        self.navigationController.navigationBar.hidden=YES;
        self.tabBarController.tabBar.hidden=YES;
    }
    
    
}
//账户中心事件
-(void)UserMessageBtnClick
{
    CountMessageViewController *countVC=[[CountMessageViewController alloc] init];
    countVC.userID=self.userID;
    [self.navigationController pushViewController:countVC animated:YES];
    countVC.delegate=self;
    
    //隐藏
    self.navigationController.navigationBar.hidden=YES;
    self.tabBarController.tabBar.hidden=YES;
}

//设置
-(void)SettingBtnClick
{
    SettingPassWordViewController *VC=[[SettingPassWordViewController alloc] init];
    
    VC.delegate=self;
    
    [self.navigationController pushViewController:VC animated:NO];
    
    //隐藏
    self.navigationController.navigationBar.hidden=YES;
    self.tabBarController.tabBar.hidden=YES;
}

//登录事件
-(void)loginBtnClick
{
    
    ATHLoginViewController *login=[[ATHLoginViewController alloc] init];
   // login.delegate=self;
    
    [self.navigationController pushViewController:login animated:NO];
    
    self.navigationController.navigationBar.hidden=YES;
    self.tabBarController.tabBar.hidden=YES;
}

//全部订单事件
-(void)goAllDingDanBtnClick
{
    
    if (self.sigen.length==0) {
        
        //        NewLoginViewController *login=[[NewLoginViewController alloc] init];
        
        ATHLoginViewController *login=[[ATHLoginViewController alloc] init];
        
     //   login.delegate=self;
        
        [self.navigationController pushViewController:login animated:NO];
        
        self.navigationController.navigationBar.hidden=YES;
        self.tabBarController.tabBar.hidden=YES;
        
    }else{
        
        PersonalAllDanVC *mcVC=[[PersonalAllDanVC alloc] init];

        [self.navigationController pushViewController:mcVC animated:YES];
        [mcVC selectedDingDanType:@"0" AndIndexType:0];

        //隐藏
        self.navigationController.navigationBar.hidden=YES;
        self.tabBarController.tabBar.hidden=YES;
    }
    
    
}

/*******************************************************      协议方法       ******************************************************/

//购物车加载数据完成
-(void)CartDataFinish:(NSNotification *)text
{
    NSLog(@"购物车加载数据完咯!");
    
    self.CartString = @"200";
    
}

-(void)BMNotification:(NSNotification *)text{
    
    
    NSLog(@"便民服务");
    
    
    NSLog(@"====sigen====%@",text.userInfo[@"textOne"]);
    NSLog(@"====mid====%@",text.userInfo[@"textThree"]);
    NSLog(@"====num====%@",text.userInfo[@"textFour"]);
    NSLog(@"====type====%@",text.userInfo[@"textFive"]);
    NSLog(@"====exchange====%@",text.userInfo[@"textSix"]);
    NSLog(@"====detailId====%@",text.userInfo[@"textSeven"]);
    NSLog(@"====NewGoods_Type====%@",text.userInfo[@"textEight"]);
    
    
    self.status=text.userInfo[@"textThree"];
    self.sigen=text.userInfo[@"textOne"];
    self.phone=text.userInfo[@"textFive"];
    self.integral=text.userInfo[@"textFour"];
    self.portrait=text.userInfo[@"textSix"];
    
    self.userID=text.userInfo[@"textSeven"];
    
    self.UserName=text.userInfo[@"textEight"];
    
    
    //刷新数据
    
    //头像
    
    
    NSNull *null=[[NSNull alloc] init];
    //   NSLog(@"----->%lu",(unsigned long)string5.length);
    if ([self.portrait isEqual:null] || [self.portrait isEqualToString:@""]) {
        
        _headerView.headerImageView.image=[UIImage imageNamed:@"头像"];
        
    }else{
        
        if ([self.portrait isEqualToString:@"头像"]) {
            
            _headerView.headerImageView.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@",self.portrait]];
        }else{
            
            [_headerView.headerImageView sd_setImageWithURL:[NSURL URLWithString:self.portrait]];
        }
    }
    
    
    
    _refresh=[[DJRefresh alloc] initWithScrollView:_tableView delegate:self];
    _refresh.topEnabled=YES;//下拉刷新
    _refresh.bottomEnabled=NO;//上拉加载
    
    [_tableView reloadData];
    
    
    
}

//登陆成功刷新视图
-(void)login
{
    
    self.sigen=[kUserDefaults objectForKey:@"sigen"];
    [self getUserAccountData];

    if (!_refresh) {
    _refresh=[[DJRefresh alloc] initWithScrollView:_tableView delegate:self];
    _refresh.topEnabled=YES;//下拉刷新
    _refresh.bottomEnabled=NO;//上拉加载
    }
}

//退出登录
-(void)outStatus
{
    
    self.status=nil;
    self.sigen=nil;
    self.phone=nil;
    self.integral=nil;
    self.portrait=nil;
    self.healthyInteger=nil;
    wait_payment_sum=@"0";
    wait_delivery_sum=@"0";
    wait_receive_goods_sum=@"0";
    
    [UserMessageManager removeAllArray];
    
    _headerView.headerImageView.image=[UIImage imageNamed:@"个人中心-(2)"];
    
    _headerView.loginButton.hidden=NO;
    _headerView.DengLuLAbel.hidden=NO;
    
    [_tableView reloadData];
}


//全部订单点击返回刷新用户积分
-(void)personScoreReloasData
{
    
    NSLog(@"全部订单点击返回刷新用户积分");
    NSNull *null=[[NSNull alloc] init];
    if (!_datasArrM) {
        _datasArrM=[[NSMutableArray alloc] init];
    }
  //  [self getUserAccountData];
    if (self.sigen.length==0) {
        self.sigen=@"";
    }
    
    manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@getAccountInfo_mob.shtml",URL_Str];
    
    NSLog(@"''''''''''''''''%@",self.sigen);
    NSDictionary *dic = @{@"sigen":self.sigen};
    
    //    NSLog(@"-------------------------------------------%@",self.sigens);
    [manager POST:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
        NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];
        
        
        
        
        if (codeKey && content) {
            NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
            
            NSLog(@"xmlStr%@",xmlStr);
            
            
            NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];
            
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            NSLog(@"=====个人中心账户中心==%@",dic);
            view.hidden=YES;
            for (NSDictionary *dict in dic) {
                
                NSLog(@"+++%@",dict[@"integer"]);
                
                self.integral=dict[@"integer"];
                
                wait_payment_sum=[NSString stringWithFormat:@"%@",dict[@"wait_payment_sum"]];
                wait_delivery_sum=[NSString stringWithFormat:@"%@",dict[@"wait_delivery_sum"]];
                wait_receive_goods_sum=[NSString stringWithFormat:@"%@",dict[@"wait_receive_goods_sum"]];
                if ([wait_payment_sum isEqualToString:@"(null)"]) {
                    wait_payment_sum=@"0";
                }
                if ([wait_delivery_sum isEqualToString:@"(null)"]) {
                    wait_delivery_sum=@"0";
                }if ([wait_receive_goods_sum isEqualToString:@"(null)"]) {
                    wait_receive_goods_sum=@"0";
                }
                //缓存用户名
                [UserMessageManager UserInteger:dict[@"integer"]];
                
                for (NSDictionary *dict1 in dict[@"list"]) {
                    
                    NSLog(@"+++%@",dict1[@"portrait"]);
                    NSLog(@"+++%@",dict1[@"username"]);
                    
                    self.UserName=dict1[@"username"];
                    
                    [UserMessageManager UserNewName:dict1[@"username"]];
                    
                    
                    
                    if ([dict1[@"portrait"] isEqual:null] || [dict1[@"portrait"] isEqualToString:@""]) {
                        
                        //头像
                        self.portrait=@"头像";
                        
                        //缓存头像
                        [UserMessageManager UserHeaderImage:@"头像"];
                        
                    }else{
                        
                        //头像
                        self.portrait=dict1[@"portrait"];
                        //缓存头像
                        [UserMessageManager UserHeaderImage:dict1[@"portrait"]];
                    }
                    
                    
                }


                    //显示账户名与积分
                    if ([[kUserDefaults objectForKey:@"status"] isEqualToString:@"YES"]) {
                        _headerView.loginButton.hidden=YES;
                        _headerView.DengLuLAbel.hidden=YES;
                        _headerView.UserMessageBut.hidden=NO;
                        _headerView.SettingButton.hidden=NO;
                        _headerView.UserNameLabel.hidden=NO;
                        _headerView.UserScoreLabel.hidden=NO;
                        _headerView.UserHeathyLab.hidden=NO;
                        _headerView.headerImageView.image=[UIImage imageNamed:@"头像"];
                        NSNull *null=[[NSNull alloc] init];
                        if ([self.portrait isEqual:null] || [self.portrait isEqualToString:@""]||[self.portrait isEqualToString:@"(null)"]) {
                            
                            _headerView.headerImageView.image=[UIImage imageNamed:@"头像"];
                            
                        }else{
                            
                            if ([self.portrait isEqualToString:@"头像"]) {
                                
                                _headerView.headerImageView.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@",self.portrait]];
                            }else{
                                
                                [_headerView.headerImageView sd_setImageWithURL:[NSURL URLWithString:self.portrait]];
                            }
                            
                        }
                        
                        
                        
                        _headerView.UserScoreLabel.text=[NSString stringWithFormat:@"购物积分：%.02f",[self.integral doubleValue]];
                        _headerView.UserHeathyLab.text=[NSString stringWithFormat:@"健康积分：%.02f",[self.healthyInteger doubleValue]];
                        //用户名
                        _headerView.UserNameLabel.text=self.UserName;
                        
                    }else{
                        
                        //登录按钮点击事件
                        [_headerView.loginButton addTarget:nil action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
                        _headerView.UserMessageBut.hidden=YES;
                        _headerView.loginButton.hidden=NO;
                        _headerView.DengLuLAbel.hidden=NO;
                        //隐藏信息
                        _headerView.SettingButton.hidden=YES;
                        _headerView.UserNameLabel.hidden=YES;
                        _headerView.UserScoreLabel.hidden=YES;
                        _headerView.UserHeathyLab.hidden=YES;
                    }
                    if (!([wait_payment_sum isEqualToString:@""]||[wait_payment_sum isEqualToString:@"(null)"]||[wait_payment_sum isEqualToString:@"0"])) {
                        NSString *str =[wait_payment_sum integerValue]>99?@"99+":[NSString stringWithFormat:@"%@",wait_payment_sum];
                        
                        _headerView.DaiFuKuanButton.badgeValue=str;
                    }else
                    {
                        _headerView.DaiFuKuanButton.badgeValue=@"";
                    }
                    if (!([wait_receive_goods_sum isEqualToString:@""]||[wait_receive_goods_sum isEqualToString:@"(null)"]||[wait_receive_goods_sum isEqualToString:@"0"])) {
                        NSString *str =[wait_receive_goods_sum integerValue]>99?@"99+":[NSString stringWithFormat:@"%@",wait_receive_goods_sum];
                        _headerView.DaiShouHuoButton.badgeValue=str;
                    }else
                    {
                        _headerView.DaiShouHuoButton.badgeValue=@"";
                    }
                    if (!([wait_delivery_sum isEqualToString:@""]||[wait_delivery_sum isEqualToString:@"(null)"]||[wait_delivery_sum isEqualToString:@"0"])) {
                        NSString *str =[wait_delivery_sum integerValue]>99?@"99+":[NSString stringWithFormat:@"%@",wait_delivery_sum];
                        _headerView.DaiFaHuoButton.badgeValue=str;
                    }else
                    {
                        _headerView.DaiFaHuoButton.badgeValue=@"";
                    }
                    
                    
                    [_tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
                }

        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);

        
        [JRToast showWithText:@"网络请求失败，请检查你的网络设置" duration:3.0f];
        
        
    }];
    
}

//修改头像反向传值
-(void)changeImageWithHeader:(NSString *)img
{
    
    NSLog(@"=====%@",img);
    
    self.portrait=img;
    
    [_headerView.headerImageView sd_setImageWithURL:[NSURL URLWithString:img]];
    
    [_tableView reloadData];
    
}
/*******************************************************      代码提取(多是复用代码)       ******************************************************/

-(void)readNSUserDefaults{//取出缓存的数据
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数组NSArray类型的数据
    self.UserName=[userDefaultes stringForKey:@"myArray"];
    self.portrait=[userDefaultes stringForKey:@"header"];
    
    self.again=[userDefaultes stringForKey:@"time"];
    [_tableView reloadData];
    
}

/*****
 *
 *  Description 下拉刷新数据
 *
 ******/
- (void)refresh:(DJRefresh *)refresh didEngageRefreshDirection:(DJRefreshDirection)direction{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self addDataWithDirection:direction];
    });
    
}
/*****
 *
 *  Description 下拉刷新数据
 *
 ******/
- (void)addDataWithDirection:(DJRefreshDirection)direction{
    
    if (direction==DJRefreshDirectionTop) {
        
        [self getUserAccountData];
        [self GetDatas];
    }
    
    
    
    [_refresh finishRefreshingDirection:direction animation:YES];
    
   // [_tableView reloadData];
    
}

-(void)getLoginMessage
{
    
}

-(void)NoWebSeveice
{
    
    view=[[UIView alloc] initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-200)];
    
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


#pragma  mark - CLLocationManagerDelegate
//定位成功
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    [_locationManager requestWhenInUseAuthorization];
    
    CLLocation *location1 = [locations lastObject];
    CLLocationDegrees latitude1 = location1.coordinate.latitude;
    CLLocationDegrees longitude1 = location1.coordinate.longitude;
    
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

@end
