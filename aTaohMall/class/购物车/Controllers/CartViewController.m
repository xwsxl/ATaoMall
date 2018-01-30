//
//  CartViewController.m
//  aTaohMall
//
//  Created by JMSHT on 2016/12/27.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import "CartViewController.h"

#import "XNQShopTrolleyHeaderTableViewCell.h"
#import "XNQShoppingTrolleyCenterTableViewCell.h"

#import "LZCartViewController.h"

#import "CartHeaderView.h"
#import "CartAttributeCell.h"

#import "ATHLoginViewController.h"

#import "StoreModel.h"
#import "ShopModel.h"
#import "FailureModel.h"//失效

#import "ThrowLineTool.h"//加入购物车动画

#import "WKProgressHUD.h"

#import "FailureHeaderView.h"

#import "UIImageView+WebCache.h"

#import "CartAddressModel.h"

#import "CartGoodsModel.h"

#import "CartStoreModel.h"

//刷新
#import "DJRefresh.h"
#import "DJRefreshProgressView.h"

#import "StockNoMuchModel.h"//库存不足

#import "GoodsAttributeCell.h"//商品属性的cell
#import "GoodsAttributeCell2.h"
#import "GoodsDetailMainView.h"

#import "ChoseView.h"

#import "GoodsAttributeModel.h"//属性

#import "UserMessageManager.h"

#import "GotoShopLookViewController.h"

#import "YTGoodsDetailViewController.h"

#import "CartGoToDingDanViewController.h"//新的确认订单

#import "FailureAttributeCell.h"

#import "MerchantDetailViewController.h"

//MapKit是原生地图框架
#import <MapKit/MapKit.h>

//CoreLocation是定位框架
#import <CoreLocation/CoreLocation.h>

#define XNQ_WIDTH [[UIScreen mainScreen] bounds].size.width
#define XNQ_HEITHT [[UIScreen mainScreen] bounds].size.height

#define JieSuanButtonWidth [[UIScreen mainScreen] bounds].size.width*0.266

#define HeaderHeight [[UIScreen mainScreen] bounds].size.height*0.1049

#define CellHeight [[UIScreen mainScreen] bounds].size.height*0.1799

#define HEADERCELLTAG 10000

@interface CartViewController ()<UITableViewDataSource,UITableViewDelegate,ThrowLineToolDelegate,ShopCarTableViewHeaderViewDelegate,ShopTableViewCellSelectDelegate,FailureHeaderViewDelegate,UIAlertViewDelegate,DJRefreshDelegate,ChangeAttributeDelegate,LoginMessageDelegate,UITabBarDelegate,UITabBarControllerDelegate,CartGoToDingDanDelegate,MKMapViewDelegate, CLLocationManagerDelegate>
{
    
    //地图View
    MKMapView *_mapView;
    
    //定位管理器
    CLLocationManager *_locationManager;
    
    UIView *view;
    
    UIView *tabView;
    
    UIButton *editButton;
    
    
    UIButton *dibuDelete;//底部删除
    
    UILabel *yunfeiLabel;//不含运费
    
    UIButton *quanSelect;
    
    CartHeaderView *header;
    
    NSMutableArray *_StoreArrM;
    
    NSMutableArray *_QueRenArrM;
    
    NSMutableArray *_GoodsArrM;
    
    NSMutableArray *_FailureArrM;
    
    UILabel *priceLabel;
    
    UIButton *JieSuan;
    
    NSMutableArray *_AddressArrM;//地址
    
    NSMutableArray *_DeleteFailureArrM;//存储失效商品sid
    
    NSMutableArray *_DeleteGoodsSidArrM;//存储要未删除商品；
    
    NSMutableArray *_ShiXiaoArrM;//添加失效商品单条数据
    
    NSMutableArray *_SubmitArrM;//编辑完成提交
    
    NSMutableArray *_EditChangeArrM;//记录编辑完成提交
    
    NSMutableArray *_KeyBordArrM;//编辑完成提交
    
    NSMutableArray *_SubmieAlldArrM;//编辑完成提交
    
    NSMutableArray *_SubmieDict;//提交
    
    NSMutableArray *_JISuanDict;//提交
    
    NSMutableArray *_ChangeNumberArrM;//购物车数量加减
    
    NSMutableArray *_CartDeleteCountArrM;//编辑状态下需要删除商品sid
    
    NSMutableArray *_StockNoMuchArrM;//库存不足商品
    NSString *DeleteGoodsNone;//失效商品sid
    
    NSIndexPath *_deletePath;
    
    UIAlertController *alertCon;
    
    int _keyboardHeight;
    //记录所改规格的数量
    NSString *_goodNumber;
    //记录所改规格的购物车id
    NSString *_shopCarId;
    //记录所改规格的商品id
    NSString *_goodId;
    //记录所改规格的商品的indexPath
    NSIndexPath *_speIndexPath;
    
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
    
    
    NSDictionary *nameDict;
    
    NSString *RemberStoreName;//判断店铺名是否相等
    
    NSString *_TitleString;//修改属性标题
    
    
    NSMutableArray *_QueRenGoodsArrM;//商品
    
    NSMutableArray *_LabelArrM;//合计
    
    NSMutableArray *_RedArrM;//金钱
    
    NSMutableArray *_WordTextViewTag;
    
    //    CartDingDanFooter *footer;
    
    //    CartAddressCell *cell1;//收货地址
    
    NSInteger _GoodsCount;//商品数量
    
    float _GoodsAllPrice;//商品总价
    
    float _MaxInteger;//用户能兑换的最大积分
    
    //    UILabel *priceLabel;//商品总价
    
    NSMutableArray *_NewAddressArrM;
    
    
    UIView *view5;
    UIImageView *line5;
    
    UIView *CartNoGoodsView5;
    
    UIView *bgView5;
    
}

@property (nonatomic, strong) UIView *keyBoardTopView;

@property (nonatomic,strong)DJRefresh *refresh;//下拉双薪

@property (nonatomic,strong) UITableView *myTableView;

@property (nonatomic,strong)NSString *goods_num;

@property (nonatomic, strong) NSMutableArray *shopCarGoodsArray;
//存储要删除商品的购物车id
@property (nonatomic, strong) NSMutableArray *shopCarDeleteIdArray;
//当前商品规格model数组
@property (nonatomic, strong) NSMutableArray *currentSpecificationsArray;
//当前商品所有规格model数组
@property (nonatomic, strong) NSMutableArray *allSpecificationsArray;
//当前商品所选规格model数组
@property (nonatomic, strong) NSMutableArray *selectSpecificationsArray;


#define HEADERCELLTAG 10000
#define HEADEREDITTTAG 10100

@end

@implementation CartViewController



/*******************************************************      控制器生命周期       ******************************************************/

-(void)viewWillAppear:(BOOL)animated
{
  self.tabBarController.tabBar.hidden=NO;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    //初始化数组
    [self initProperty];
    //初始化位置信息
    [self MakeSelfMessage];
    //初始化数据
    [self LookCartNumber];

    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(CartReloadData:) name:@"CartReloadData" object:nil];

    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(CartBdeagChange:) name:@"CartBdeagChange" object:nil];

    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(CartTabbarShow:) name:@"CartTabbarShow" object:nil];

    //登录成功，通知修改购物车件数
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(LoginSuccessShowCartNumber:) name:@"LoginSuccessShowCartNumber" object:nil];

    //退出登录，购物车件数为0

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(QuitLoginCartShowNoNumber:) name:@"QuitLoginCartShowNoNumber" object:nil];

    //登录，点击返回，跳到首页
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(LoginBackHome:) name:@"LoginBackHome" object:nil];

    //注册成功，清空购物车原先数据
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ZhuCeSuccessCartReloadData:) name:@"ZhuCeSuccessCartReloadData" object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(HomeShowCartNumber:) name:@"HomeShowCartNumber" object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(TongZhiCartLoginSuccess:) name:@"TongZhiCartLoginSuccess" object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(PaySuccessBackCart:) name:@"PaySuccessBackCart" object:nil];

    //监听键盘出现和消失
  //  [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];

   // [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];


}
//初始化属性、数组等等
-(void)initProperty
{
    nameDict = @{};


    RemberStoreName = @"";

    _CartDeleteCountArrM = [NSMutableArray new];

    _StoreArrM = [NSMutableArray new];

    _GoodsArrM = [NSMutableArray new];

    _FailureArrM = [NSMutableArray new];

    _DeleteFailureArrM = [NSMutableArray new];

    _ShiXiaoArrM = [NSMutableArray new];

    _DeleteGoodsSidArrM = [NSMutableArray new];

    _SubmitArrM = [NSMutableArray new];

    _KeyBordArrM = [NSMutableArray new];

    _SubmieDict = [NSMutableArray new];

    _SubmieAlldArrM = [NSMutableArray new];

    _JISuanDict = [NSMutableArray new];

    TitleArrM1=[NSMutableArray new];

    _QueRenArrM =[NSMutableArray new];

    ColorArrM2=[NSMutableArray new];

    SizeArrM3=[NSMutableArray new];

    BuLiaoArrM4=[NSMutableArray new];

    StyleArrM5=[NSMutableArray new];

    _NewAddressArrM = [NSMutableArray new];

    _StockNoMuchArrM = [NSMutableArray new];

    _ChangeNumberArrM = [NSMutableArray new];

    _EditChangeArrM = [NSMutableArray new];

    _AddressArrM = [NSMutableArray new];


    //==================================
    UILabel *NumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];

    NumberLabel.backgroundColor = [UIColor redColor];

    //==================================
}

//初始化视图
-(void)SetUI
{
    self.navigationController.navigationBar.hidden=YES;

    self.view.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];

    //创建导航栏
    [self initNav];

    //创建底部结算视图
    [self initTabbar];

    [self initTableView];


}

/*******************************************************      数据请求       ******************************************************/

//查看购物车件数
-(void)LookCartNumber
{

    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];

    if ([userDefaultes stringForKey:@"sigen"].length==0) {

        NSLog(@"====请去登录=====");
        ATHLoginViewController *login=[[ATHLoginViewController alloc] init];
        login.delegate=self;
        login.backString=@"333";
        login.CartBack = @"100";
        login.HeindBack = @"100";
        [self.navigationController pushViewController:login animated:NO];
        self.navigationController.navigationBar.hidden=YES;
        self.tabBarController.tabBar.hidden=YES;
    }else{

        self.sigen = [userDefaultes stringForKey:@"sigen"];

        [HTTPRequestManager POST:@"getShoppingSum_mob.shtml" NSDictWithString:@{@"sigen":self.sigen} parameters:nil result:^(id responseObj, NSError *error) {

            //        NSLog(@"====%@===",responseObj);

                if ([responseObj[@"status"] isEqualToString:@"10000"]) {

                    self.goods_num=responseObj[@"goods_num"];

                    if ([responseObj[@"goods_sum"] isEqualToString:@"0"]) {

                        view.hidden=YES;
                        tabView.hidden=YES;
                        [self CartNoGoods];

                    }else{

                        [_FailureArrM removeAllObjects];
                        [_StoreArrM removeAllObjects];

                        [self SetUI];

                        [self getDatas];

                    }

                }

        }];

    }



}

//获取数据源
-(void)getDatas
{


    //    status=10004  未登录
    //    status=10000  查询成功，有数据
    //    status=10001  查询成功，没有数据
    //    status=10005  系统异常

    //清楚再次缓存
    [UserMessageManager RemoveAgain];

    [UserMessageManager RemoveShuXingString];

    [_CartDeleteCountArrM removeAllObjects];

    [_JISuanDict removeAllObjects];

    [_FailureArrM removeAllObjects];

    [_StoreArrM removeAllObjects];


    WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];

    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{

    });

    [HTTPRequestManager POST:@"getShoppingCartGoodsIOS_mob.shtml" NSDictWithString:@{@"sigen":self.sigen} parameters:nil result:^(id responseObj, NSError *error) {


        NSLog(@"==购物车数据==%@===",responseObj);

        self.Failure = responseObj[@"type"];

        if ([responseObj[@"goods_sum"] isEqualToString:@"0"]) {

            view.hidden=YES;
            tabView.hidden=YES;

            self.myTableView.backgroundColor = [UIColor whiteColor];

            self.tabBarItem.badgeValue = nil;

        }else{

            self.tabBarItem.badgeValue = responseObj[@"goods_sum"];

            [UserMessageManager AppDelegateCartNumber:responseObj[@"goods_sum"]];

        }


        if (responseObj) {

            for (NSDictionary *dict in responseObj[@"list"]) {

                StoreModel *model1 = [[StoreModel alloc] init];

                NSLog(@"=111=失效店铺名==%@===%@",dict[@"storename"],dict[@"mid"]);

                model1.storename = dict[@"storename"];

                model1.mid = dict[@"mid"];

                [model1 configGoodsArrayWithArray:[dict objectForKey:@"list"]];

                [_StoreArrM addObject:model1];


            }

            for (NSDictionary *dict in responseObj[@"list_failure"]) {

                FailureModel *fail = [[FailureModel alloc] init];

                fail.attribute_failure = dict[@"attribute_failure"];
                fail.attribute_str = dict[@"attribute_str"];
                fail.count = dict[@"count"];
                fail.detailId = dict[@"detailId"];
                fail.exchange_type = dict[@"exchange_type"];
                fail.freight = dict[@"freight"];
                fail.gid = dict[@"gid"];
                fail.good_type = dict[@"good_type"];
                fail.mid = dict[@"mid"];
                fail.name = dict[@"name"];
                fail.number = dict[@"number"];
                fail.pay_integer = dict[@"pay_integer"];
                fail.pay_maney = dict[@"pay_maney"];
                fail.reason = dict[@"reason"];
                fail.scopeimg = dict[@"scopeimg"];
                fail.sid = dict[@"sid"];
                fail.status = dict[@"status"];
                fail.stock = dict[@"stock"];
                fail.storename = dict[@"storename"];
                fail.uid = dict[@"uid"];


                NSLog(@"=222=失效店铺名==%@",dict[@"storename"]);


                [_FailureArrM addObject:fail];


            }


            [_StoreArrM addObject:_FailureArrM];

            [hud dismiss:YES];


            NSNotification *notification = [[NSNotification alloc] initWithName:@"KeyBordReturnToCell" object:nil userInfo:nil];

            [[NSNotificationCenter defaultCenter] postNotification:notification];


            //发送通知给个人中心，购物车数据加载完成

            NSNotification *CartDataFinish = [[NSNotification alloc] initWithName:@"CartDataFinish" object:nil userInfo:nil];
            [[NSNotificationCenter defaultCenter] postNotification:CartDataFinish];

            [self.myTableView reloadData];


            self.tabBarController.tabBar.userInteractionEnabled=YES;


        }else{

            [hud dismiss:YES];

            NSLog(@"error");

        }

    }];

}

/*******************************************************      初始化视图       ******************************************************/

-(void)initTableView
{

    self.myTableView.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];

    self.myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight, XNQ_WIDTH, XNQ_HEITHT-50-KSafeAreaTopNaviHeight-KSafeAreaBottomHeight-40) style:UITableViewStyleGrouped];
    //    self.myTableView.frame = CGRectMake(0, 64, XNQ_WIDTH, XNQ_HEITHT-50-64);
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    [self.view addSubview:self.myTableView];

    //去除系统分割线
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    [self.myTableView registerClass:[CartHeaderView class] forHeaderFooterViewReuseIdentifier:@"header"];
    [self.myTableView registerClass:[FailureHeaderView class] forHeaderFooterViewReuseIdentifier:@"header1"];

    [self.myTableView registerClass:[CartAttributeCell class] forCellReuseIdentifier:@"cell1"];

    [self.myTableView registerClass:[CartAttributeCell class] forCellReuseIdentifier:@"cell2"];

    [self.myTableView registerClass:[FailureAttributeCell class] forCellReuseIdentifier:@"cell3"];

    _refresh=[[DJRefresh alloc] initWithScrollView:_myTableView delegate:self];
    _refresh.topEnabled=YES;//下拉刷新
    _refresh.bottomEnabled=NO;//上拉加载
    self.myTableView.estimatedRowHeight=0;
    self.myTableView.estimatedSectionFooterHeight=0;
    self.myTableView.estimatedSectionHeaderHeight=0;
    // code1
    if ([self.myTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.myTableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }

    // code2
    if ([self.myTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.myTableView setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
    }

}

-(void)initNav
{

    view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, KSafeAreaTopNaviHeight)];
    view.backgroundColor = [UIColor whiteColor];

    [self.view addSubview:view];

    UIImageView *fenge2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight-1, [UIScreen mainScreen].bounds.size.width, 1)];

    fenge2.image = [UIImage imageNamed:@"分割线e2"];

    [view addSubview:fenge2];

    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 25+KSafeTopHeight, [UIScreen mainScreen].bounds.size.width-200, 30)];
    titleLabel.text = @"购物车";
    titleLabel.textAlignment=NSTextAlignmentCenter;
    titleLabel.font=[UIFont systemFontOfSize:20];
    [view addSubview:titleLabel];

    editButton = [UIButton buttonWithType:UIButtonTypeCustom];
    editButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-80, 25+KSafeTopHeight, 60, 30);
    [editButton setTitle:@"编辑全部" forState:UIControlStateNormal];
    [editButton setTitle:@"完成" forState:UIControlStateSelected];

    [editButton setTitleColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0] forState:0];
    editButton.titleLabel.font=[UIFont fontWithName:@"PingFangSC-Regular" size:12];

    [editButton addTarget:self action:@selector(editBtnClick:) forControlEvents:UIControlEventTouchUpInside];

    [view addSubview:editButton];

}

-(void)initTabbar
{

    tabView = [[UIView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-50-40-KSafeAreaBottomHeight, [UIScreen mainScreen].bounds.size.width, 40)];
    tabView.backgroundColor=[UIColor whiteColor];

    [self.view addSubview:tabView];


    UIImageView *line1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 1)];
    line1.image = [UIImage imageNamed:@"分割线e2"];

    [tabView addSubview:line1];


    quanSelect = [UIButton buttonWithType:UIButtonTypeCustom];
    quanSelect.frame = CGRectMake(20, 10, 20, 20);
    //    [quanSelect setBackgroundImage:[UIImage imageNamed:@"为勾选"] forState:0];

    [quanSelect setBackgroundImage:[UIImage imageNamed:@"为勾选"] forState:UIControlStateNormal];
    [quanSelect setBackgroundImage:[UIImage imageNamed:@"勾"] forState:UIControlStateSelected];

    //    quanSelect.selected=YES;

    [quanSelect addTarget:self action:@selector(quanSelectBtnClick:) forControlEvents:UIControlEventTouchUpInside];

    [tabView addSubview:quanSelect];

    UILabel *selectLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 10, 40, 20)];
    selectLabel.text = @"全选";
    selectLabel.font =[UIFont systemFontOfSize:12];
    [tabView addSubview:selectLabel];

    //删除

    dibuDelete = [UIButton buttonWithType:UIButtonTypeCustom];

    dibuDelete.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-JieSuanButtonWidth, 0, JieSuanButtonWidth, 40);

    dibuDelete.backgroundColor = [UIColor colorWithRed:215/255.0 green:215/255.0 blue:215/255.0 alpha:1.0];

    [dibuDelete setTitle:@"删除" forState:0];
    [dibuDelete addTarget:self action:@selector(dibuDeleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    dibuDelete.enabled=NO;
    [dibuDelete setTitleColor:[UIColor whiteColor] forState:0];

    dibuDelete.hidden=YES;
    [tabView addSubview:dibuDelete];


    JieSuan = [UIButton buttonWithType:UIButtonTypeCustom];

    JieSuan.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-JieSuanButtonWidth, 0, JieSuanButtonWidth, 40);

    JieSuan.backgroundColor = [UIColor colorWithRed:215/255.0 green:215/255.0 blue:215/255.0 alpha:1.0];
    JieSuan.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:16];
    JieSuan.enabled=NO;

    [JieSuan setTitle:[NSString stringWithFormat:@"结算(%d)",0] forState:0];
    [JieSuan addTarget:self action:@selector(jiesuanBtnClick) forControlEvents:UIControlEventTouchUpInside];

    [JieSuan setTitleColor:[UIColor whiteColor] forState:0];

    [tabView addSubview:JieSuan];

    priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 5, [UIScreen mainScreen].bounds.size.width-JieSuanButtonWidth-100, 20)];

    priceLabel.font=[UIFont systemFontOfSize:12];

    priceLabel.textAlignment = NSTextAlignmentRight;

    NSString *string = @"合计:￥0.00+0.00积分";

    NSString *stringForColor = @"￥0.00+0.00积分";
    // 创建对象.
    NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:string];
    //
    NSRange range = [string rangeOfString:stringForColor];

    [mAttStri addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];

    priceLabel.attributedText=mAttStri;

    [tabView addSubview:priceLabel];


    yunfeiLabel = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-JieSuanButtonWidth-110, 25, 100, 15)];
    yunfeiLabel.textAlignment=NSTextAlignmentRight;
    yunfeiLabel.text=@"(不含运费)";
    yunfeiLabel.font=[UIFont fontWithName:@"PingFang-SC-Medium" size:12];
    yunfeiLabel.textColor = [UIColor blackColor];
    [tabView addSubview:yunfeiLabel];


}

/*******************************************************      各种button执行方法、页面间的跳转       ******************************************************/


/*******************************************************      协议方法       ******************************************************/
#pragma-mark -tableView
//分区
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _StoreArrM.count;
}
//
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==_StoreArrM.count-1) {

        NSArray *array = _StoreArrM[section];

        return array.count;

    }else{

        StoreModel *model = _StoreArrM[section];

        NSLog(@"===model.shop.count====%ld",(unsigned long)model.shop.count);

        //数组越界
        return model.shop.count;

    }


}
//
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return CellHeight;

}
//
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{

    return 0.00000000001;
}
//
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [[UIView alloc]init];
}
//
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    //    NSLog(@"==indexPath.section==%ld==",indexPath.section);

    if (indexPath.section == _StoreArrM.count-1) {

        FailureAttributeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell3"];

        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        NSArray *array = _StoreArrM[indexPath.section];

        FailureModel *model = array[indexPath.row];

        //每组最后一个商品影藏分割线
        if (indexPath.row == array.count-1) {


            cell.line.hidden=YES;

        }else{

            cell.line.hidden=NO;

        }


        //添加失效商品id
        [_DeleteFailureArrM addObject:model.sid];

        cell.GoodsNameLabel.text=model.name;

        [cell.LogoImgView sd_setImageWithURL:[NSURL URLWithString:model.scopeimg] placeholderImage:[UIImage imageNamed:@"default_image"] options:SDWebImageProgressiveDownload];

        cell.NumberLabel.text = [NSString stringWithFormat:@"x%@",model.number];
        cell.NewNumberLabel.text = [NSString stringWithFormat:@"x%@",model.number];

        NSNull *null = [[NSNull alloc] init];

        if ([model.detailId isEqual:null]) {

            cell.AttributeLabel.text = @"";
            cell.PriceLabel.hidden=YES;
            cell.NumberLabel.hidden=YES;
            cell.NewPriceLabel.hidden=NO;
            cell.NewNumberLabel.hidden=NO;
            cell.NewPriceLabel.text =  [NSString stringWithFormat:@"￥%.02f+%.02f积分",[model.pay_maney floatValue],[model.pay_integer floatValue]];

        }else{

            cell.PriceLabel.hidden=NO;
            cell.NumberLabel.hidden=NO;
            cell.NewPriceLabel.hidden=YES;
            cell.NewNumberLabel.hidden=YES;
            cell.AttributeLabel.text = [NSString stringWithFormat:@"%@",model.attribute_str];
            cell.PriceLabel.text = [NSString stringWithFormat:@"￥%.02f+%.02f积分",[model.pay_maney floatValue],[model.pay_integer floatValue]];

        }


        if ([_Failure isEqualToString:@"0"]) {

            cell.hidden=YES;

        }else{

            cell.hidden =NO;

        }

        return cell;

    }else{

        CartAttributeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];

        //        cell.editing = NO;

        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        StoreModel *model = _StoreArrM[indexPath.section];


        ShopModel *goods = model.shop[indexPath.row];

        //        NSLog(@"===model===%@",goods.number);

        cell.model = goods;

        if ([goods.number intValue] > [goods.stock intValue]) {

            NSLog(@"====6666====%@",goods.stock);
            //            cell.RedImgViewKuang.hidden=NO;
            cell.StockNoMuchLabel.hidden=NO;
            cell.StockNoMuchLabel.text= [NSString stringWithFormat:@"(库存只有%@件)",goods.stock];

        }else{

            //            cell.RedImgViewKuang.hidden=YES;
            cell.StockNoMuchLabel.hidden=YES;
        }

        cell.delegate = self;
        cell.shopCellEditState = goods.cellEditState;
        cell.shopCellSelectBtnState = goods.selectState;
        cell.shopCellDeleteBtnState = goods.deleteBtnState;


        cell.GoodsNameLabel.text=goods.name;

        cell.numberTF.text = [NSString stringWithFormat:@"%@",goods.number];
        cell.NewnumberTF.text = [NSString stringWithFormat:@"%@",goods.number];

        [cell.LogoImgView sd_setImageWithURL:[NSURL URLWithString:goods.scopeimg] placeholderImage:[UIImage imageNamed:@"default_image"] options:SDWebImageProgressiveDownload];

        cell.NumberLabel.text = [NSString stringWithFormat:@"x%@",goods.number];
        cell.NewNumberLabel.text = [NSString stringWithFormat:@"x%@",goods.number];

        NSNull *null = [[NSNull alloc] init];

        if ([goods.detailId isEqual:null]) {

            cell.AttributeLabel.text = @"";
            cell.ChangeAttributeLabel.text = @"";
            cell.YTString = @"100";
            cell.AttributeView.hidden=YES;
            cell.PriceLabel.hidden=YES;
            cell.NumberLabel.hidden=YES;

            //            cell.NewPriceLabel.hidden=NO;

            cell.NewPriceLabel.text = [NSString stringWithFormat:@"￥%.02f+%.02f积分",[goods.pay_maney floatValue],[goods.pay_integer floatValue]];

        }else{

            cell.YTString = @"200";
            //            cell.PriceLabel.hidden=NO;
            cell.NewPriceLabel.hidden=YES;
            cell.NewNumberLabel.hidden=YES;

            cell.AttributeLabel.text = [NSString stringWithFormat:@"%@",goods.attribute_str];
            cell.ChangeAttributeLabel.text = [NSString stringWithFormat:@"%@",goods.attribute_str];
            cell.PriceLabel.text = [NSString stringWithFormat:@"￥%.02f+%.02f积分",[goods.pay_maney floatValue],[goods.pay_integer floatValue]];


        }

        NSLog(@"==model.shop.count==%ld==indexPath.row==%ld",(long)model.shop.count,(long)indexPath.row);

        //每组最后一个商品影藏分割线
        if (indexPath.row == model.shop.count-1) {


            cell.line.hidden=YES;

        }else{

            cell.line.hidden=NO;

        }


        return cell;

    }


}
//
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    NSLog(@"===didSelectRowAtIndexPath====");

    if (indexPath.section == _StoreArrM.count-1) {


    }else{

        StoreModel *model1 = _StoreArrM[indexPath.section];


        if (model1.editState==1 || editButton.selected) {


        }else{

            StoreModel *model = _StoreArrM[indexPath.section];

            ShopModel *goods = model.shop[indexPath.row];

            YTGoodsDetailViewController *vc=[[YTGoodsDetailViewController alloc] init];

            vc.type=@"1";//判断返回界面

            vc.ID=goods.gid;
            vc.gid=goods.gid;
            vc.good_type=goods.good_type;
            vc.attribute = goods.attribute;

            //        vc.Attribute_back=@"6";


            [UserMessageManager CartBack:@"100"];

            self.tabBarController.tabBar.hidden=YES;
            [self.navigationController pushViewController:vc animated:NO];

        }

    }

}
//
- (void)setHeaderViewSelectState:(StoreModel *)bigModel{
    BOOL currentState = YES;
    //表头选中状态
    for (int i = 0 ; i < bigModel.shop.count; i++) {
        ShopModel *detailModel = bigModel.shop[i];
        if (detailModel.selectState != YES) {
            currentState = NO;
            break;
        }
    }
    bigModel.selectState = currentState;
}

#pragma mark - 编辑的方法
//能够编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==_StoreArrM.count-1) {

        NSLog(@"OtherOtherOtherOtherOther");

        return YES;

    }else{

        CartHeaderView *headerView = (CartHeaderView *)[tableView headerViewForSection:indexPath.section];

        StoreModel *model = _StoreArrM[indexPath.section];

        //        NSLog(@"======headerView.headerViewEditBtnState===%d",model.editState);



        if (model.editState==1 || editButton.selected) {

            NSLog(@"NONONONONONONONONONO");

            return NO;

        }else{

            NSLog(@"YESYESYESYESYESYESYES");

            return YES;
        }

    }

}

//返回某一个Cell的编辑样式(增加，删除)
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.isEditing == YES) {

        return UITableViewCellEditingStyleDelete;

    }

    return UITableViewCellEditingStyleDelete;
}
//
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.section==_StoreArrM.count-1) {

        return @"删除";

    }else{

        CartHeaderView *headerView = (CartHeaderView *)[tableView headerViewForSection:indexPath.section];
        if (headerView.headerViewEditBtnState || editButton.selected) {

            return @"";

        }else{
            return @"删除";
        }


    }

    //    return @"删除";
}

//怎么删除， 怎么添加
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //首先获取， 某一组里面的所有的元素

    //    NSLog(@"+++++++%@==",indexPath);

    if (editingStyle == UITableViewCellEditingStyleDelete) {


        //清空失效商品
        if (indexPath.section == _StoreArrM.count-1) {

            NSLog(@"删除");


            NSArray *array = _StoreArrM[indexPath.section];

            _ShiXiaoArrM = _StoreArrM[indexPath.section];

            FailureModel *model = array[indexPath.row];

            //添加失效商品id
            NSLog(@"===sid====%@",model.sid);

            DeleteGoodsNone = model.sid;


            //           [_ShiXiaoArrM removeObjectAtIndex:indexPath.row];

            //删除失效商品

            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"确认要删除这个商品吗？" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];

            alert.tag=100;

            [alert show];


        }else{

            StoreModel *model = _StoreArrM[indexPath.section];


            ShopModel *goods = model.shop[indexPath.row];


            DeleteGoodsNone = goods.sid;


            _deletePath = indexPath;

            NSLog(@"==滑动删除==sid====%@",goods.sid);


            NSMutableArray *detailArray = [NSMutableArray arrayWithArray:model.shop];


            alertCon = [UIAlertController alertControllerWithTitle:@"确认要删除这个商品吗？" message:nil preferredStyle:UIAlertControllerStyleAlert];


            [alertCon addAction: [UIAlertAction actionWithTitle: @"取消" style: UIAlertActionStyleCancel handler:nil]];

            [alertCon addAction: [UIAlertAction actionWithTitle: @"确定" style: UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {


                WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];

                dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 1ull * NSEC_PER_SEC);
                dispatch_after(time, dispatch_get_main_queue(), ^{

                });


                [HTTPRequestManager POST:@"deleteShoppingCartGoods_mob.shtml" NSDictWithString:@{@"sigen":self.sigen,@"sid":DeleteGoodsNone} parameters:nil result:^(id responseObj, NSError *error) {


                    //                    NSLog(@"====%@===",responseObj);


                    if (responseObj) {

                        for (NSDictionary *dict in responseObj) {


                            if ([dict[@"status"] isEqualToString:@"10000"]) {

                                [hud dismiss:YES];

                                [detailArray removeObjectAtIndex:indexPath.row];

                                model.shop = detailArray;

                                if (detailArray.count == 0) {

                                    [_StoreArrM removeObjectAtIndex:indexPath.section];

                                }


                                if ([dict[@"goods_sum"] isEqualToString:@"0"]) {


                                    self.tabBarItem.badgeValue = nil;

                                    [UserMessageManager AppDelegateCartNumber:dict[@"goods_sum"]];


                                }else{


                                    self.tabBarItem.badgeValue = dict[@"goods_sum"];

                                    [UserMessageManager AppDelegateCartNumber:dict[@"goods_sum"]];


                                }

                                priceLabel.text = @"合计:￥0.00+0.00积分";

                                for (int i =0; i<_StoreArrM.count-1; i++) {

                                    StoreModel *buyer = _StoreArrM[i];

                                    for (int j=0; j<buyer.shop.count; j++) {

                                        ShopModel *product = buyer.shop[j];

                                        if (product.selectState) {

                                            NSLog(@"===product.name===%@",product.name);

                                            NSString *price;//金钱
                                            NSString *integer;//积分

                                            NSLog(@"======priceLabel.text======%@",priceLabel.text);

                                            NSString * string = priceLabel.text;

                                            NSString *string1 = [string substringFromIndex:4];

                                            NSString *string2 = [string1 substringToIndex:string1.length-2];

                                            NSArray *arrtay = [string2 componentsSeparatedByString:@"+"];

                                            price = arrtay[0];

                                            integer = arrtay[1];


                                            NSString *string3 = [NSString stringWithFormat:@"合计:¥%.02f+%.02f积分",[price floatValue] + [product.pay_maney floatValue]*[product.number intValue],[integer floatValue] + [product.pay_integer floatValue]*[product.number intValue]];

                                            NSString *stringForColor = [NSString stringWithFormat:@"¥%.02f+%.02f积分",[price floatValue] + [product.pay_maney floatValue]*[product.number intValue],[integer floatValue] + [product.pay_integer floatValue]*[product.number intValue]];
                                            // 创建对象.
                                            NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:string3];
                                            //
                                            NSRange range = [string3 rangeOfString:stringForColor];

                                            [mAttStri addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];

                                            priceLabel.attributedText=mAttStri;



                                        }
                                    }
                                }

                                //计算价格
                                //                                [self calculateTotalMoney:[NSMutableArray arrayWithObject:product] addOrReduc:0];
                                //
                                [self setBottomBtnSelectState];

                                if ([self countTotalSelectedNumber]==0) {

                                    [JieSuan setBackgroundColor:[UIColor colorWithRed:215/255.0 green:215/255.0 blue:215/255.0 alpha:1.0]];
                                    JieSuan.enabled=NO;
                                    [dibuDelete setBackgroundColor:[UIColor colorWithRed:215/255.0 green:215/255.0 blue:215/255.0 alpha:1.0]];

                                }else{


                                    [JieSuan setBackgroundColor:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0]];
                                    JieSuan.enabled=YES;
                                    [dibuDelete setBackgroundColor:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0]];

                                }

                                [JieSuan setTitle:[NSString stringWithFormat:@"结算(%ld)",[self countTotalSelectedNumber]] forState:0];



                                //调用计算价格

                                [_myTableView reloadData];


                            }


                        }


                    }else{


                        NSLog(@"error");

                    }


                }];



            }]];


            [self presentViewController: alertCon animated: YES completion: nil];


            //            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"确认要删除这个商品吗？" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            //
            //            alert.tag=200;
            //
            //            [alert show];



        }


    }

}

//
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)])
    {
        [cell setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
    {
        [cell setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
}
//
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

    return HeaderHeight;
}
//
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section==_StoreArrM.count-1) {


        FailureHeaderView *header1 = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header1"];

        if ([self.Failure isEqualToString:@"0"]) {

            if (_StoreArrM.count==1 && _FailureArrM.count==0) {

                NSLog(@"=====>>>.=====3333333====%ld===%ld",(long)_StoreArrM.count,(long)_FailureArrM.count);

                view.hidden=YES;
                tabView.hidden=YES;
                header1.hidden = YES;
                [self CartNoGoods];

            }else{

                header1.hidden = YES;
            }


        }else{

            if (_StoreArrM.count==1 && _FailureArrM.count==0) {

                NSLog(@"=====>>>.=====44444444====%ld===%ld",(long)_StoreArrM.count,(long)_FailureArrM.count);


                view.hidden=YES;
                tabView.hidden=YES;
                header1.hidden = YES;
                [self CartNoGoods];

            }else{

                header1.hidden = NO;
                header1.selectBtnTag = section;
                header1.delegate = self;
                [header1.deleteButton addTarget:self action:@selector(deleteBtnClick) forControlEvents:UIControlEventTouchUpInside];
            }


        }


        return header1;


    }else{

        header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];

        StoreModel *model = _StoreArrM[section];
        if([model.storename isEqual:[[NSNull alloc]init]]) {
            model.storename=@"null";
        }
        header.text = model.storename;

        header.selectBtnTag = section;
        header.editBtnTag = section;
        header.delegate = self;

        header.carModel = model;

        if (editButton.selected) {

            header.hiddenEidtBtn = YES;

        }else{

            header.hiddenEidtBtn = NO;

        }

        //第一组影藏分割线
        if (section == 0) {


            header.line1.hidden=YES;

        }else{

            header.line1.hidden=NO;

        }


        //        NSLog(@"===model.editState====%d",model.editState);


        header.headerViewAllSelectBtnState = model.selectState;
        header.headerViewEditBtnState = model.editState;
        return header;
    }

}


/*******************************************************      代码提取(多是复用代码)       ******************************************************/

/*******************************************************      通知(KVO)      ******************************************************/
#pragma mark 键盘出现
-(void)keyboardWillShow:(NSNotification *)note
{
    CGRect keyBoardRect=[note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    _myTableView.contentInset = UIEdgeInsetsMake(0, 0, keyBoardRect.size.height, 0);
}
#pragma mark 键盘消失
-(void)keyboardWillHide:(NSNotification *)note
{
    _myTableView.contentInset = UIEdgeInsetsZero;
}


#pragma mark 我也不知道为什么有这么多通知 

- (void)LoginBackHome:(NSNotification *)text{

    self.tabBarController.selectedIndex=0;

}
- (void)QuitLoginCartShowNoNumber:(NSNotification *)text{


    NSLog(@"====购物车件数为空====");

    self.tabBarItem.badgeValue = nil;


    //    [self LookCartNumber];

}


- (void)PaySuccessBackCart:(NSNotification *)text{


    [_refresh finishRefreshing];

    _refresh.topEnabled=NO;


    NSLog(@"*****************9999999999999999*********************");


    [_myTableView removeFromSuperview];

    [view5 removeFromSuperview];
    [line5 removeFromSuperview];

    [CartNoGoodsView5 removeFromSuperview];

    [bgView5 removeFromSuperview];


    self.tabBarController.tabBar.userInteractionEnabled=NO;

    [self LookCartNumber];


}
- (void)CartReloadData:(NSNotification *)text{


    //    NSLog(@"=====购物车刷新数据======");
    self.navigationController.navigationBar.hidden=YES;
    self.tabBarController.tabBar.hidden=NO;
    [self.navigationController popToRootViewControllerAnimated:NO];



    [_FailureArrM removeAllObjects];

    [_StoreArrM removeAllObjects];


    [_refresh finishRefreshing];

    _refresh.topEnabled=NO;

    [dibuDelete removeFromSuperview];
    [tabView removeFromSuperview];
    [priceLabel removeFromSuperview];
    [yunfeiLabel removeFromSuperview];
    [JieSuan removeFromSuperview];


    dibuDelete.hidden=YES;
    editButton.hidden = YES;
    tabView.hidden=YES;
    priceLabel.hidden = YES;
    yunfeiLabel.hidden = YES;
    dibuDelete.hidden=YES;
    JieSuan.hidden=YES;


    NSLog(@"*******222233334444**********9999999999999999*********************");


    [_myTableView removeFromSuperview];

    [view5 removeFromSuperview];
    [line5 removeFromSuperview];

    //    [tabView removeFromSuperview];
    //
    //    tabView.hidden=YES;

    [CartNoGoodsView5 removeFromSuperview];

    [bgView5 removeFromSuperview];

    self.tabBarController.tabBar.userInteractionEnabled=NO;

    [self LookCartNumber];

    //    ATHLoginViewController *login=[[ATHLoginViewController alloc] init];
    //    login.delegate=self;
    //    login.backString=@"333";
    //    login.CartBack = @"100";
    //    login.HeindBack = @"100";
    //
    //    [self.navigationController pushViewController:login animated:NO];
    //
    //    self.navigationController.navigationBar.hidden=YES;
    //    self.tabBarController.tabBar.hidden=YES;


}

-(void)TongZhiCartLoginSuccess:(NSNotification *)text
{

    [self LookCartNumber];

}
//初始显示购物车件数
- (void)HomeShowCartNumber:(NSNotification *)text{


    NSLog(@"&&&&&&&&&&&&&&&&&&&&");

    //    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //
    //
    //    self.sigen = [userDefaultes stringForKey:@"sigen"];
    //
    //
    //    if (self.sigen.length > 0) {
    //
    //
    //        [HTTPRequestManager POST:@"getShoppingSum_mob.shtml" NSDictWithString:@{@"sigen":self.sigen} parameters:nil result:^(id responseObj, NSError *error) {
    //
    //
    //            //        NSLog(@"====%@===",responseObj);
    //
    //
    //            if (responseObj) {
    //
    //
    //                if ([responseObj[@"status"] isEqualToString:@"10000"]) {
    //
    //
    //                    if ([responseObj[@"goods_sum"] isEqualToString:@"0"]) {
    //
    //                        self.tabBarItem.badgeValue = nil;
    //
    //                    }else{
    //
    //                        self.tabBarItem.badgeValue = responseObj[@"goods_sum"];
    //
    //                    }
    //
    //
    //
    //
    //                }
    //
    //
    //
    //            }else{
    //
    //
    //                NSLog(@"error");
    //
    //            }
    //
    //
    //        }];
    //
    //    }
}

- (void)ZhuCeSuccessCartReloadData:(NSNotification *)text{

    [_FailureArrM removeAllObjects];

    [_StoreArrM removeAllObjects];


    [_myTableView reloadData];


    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];


    self.sigen = [userDefaultes stringForKey:@"sigen"];


    [HTTPRequestManager POST:@"getShoppingSum_mob.shtml" NSDictWithString:@{@"sigen":self.sigen} parameters:nil result:^(id responseObj, NSError *error) {


        //        NSLog(@"====%@===",responseObj);


        if (responseObj) {


            if ([responseObj[@"status"] isEqualToString:@"10000"]) {


                if ([responseObj[@"goods_sum"] isEqualToString:@"0"]) {

                    self.tabBarItem.badgeValue = nil;

                }else{

                    self.tabBarItem.badgeValue = responseObj[@"goods_sum"];

                }




            }



        }else{


            NSLog(@"error");

        }


    }];

}

- (void)QuitLoginCartReloadData:(NSNotification *)text{


    NSLog(@"退出登陆了");

    [self LookCartNumber];

}

- (void)LoginSuccessShowCartNumber:(NSNotification *)text{

    [_FailureArrM removeAllObjects];

    [_StoreArrM removeAllObjects];


    [_myTableView reloadData];


    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];


    self.sigen = [userDefaultes stringForKey:@"sigen"];


    [HTTPRequestManager POST:@"getShoppingSum_mob.shtml" NSDictWithString:@{@"sigen":self.sigen} parameters:nil result:^(id responseObj, NSError *error) {


        //        NSLog(@"====%@===",responseObj);


        if (responseObj) {


            if ([responseObj[@"status"] isEqualToString:@"10000"]) {


                if ([responseObj[@"goods_sum"] isEqualToString:@"0"]) {

                    self.tabBarItem.badgeValue = nil;

                }else{

                    self.tabBarItem.badgeValue = responseObj[@"goods_sum"];

                }



            }



        }else{


            NSLog(@"error");

        }


    }];

}

- (void)CartBdeagChange:(NSNotification *)text{


    NSLog(@"=====修改购物车数据======");

    //属性框下落
    [goodsMainview dismiss];

    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];

    self.sigen = [userDefaultes stringForKey:@"sigen"];

    //    NSLog(@"===222==self.sigen====%@",[userDefaultes stringForKey:@"sigen"]);

    [HTTPRequestManager POST:@"getShoppingSum_mob.shtml" NSDictWithString:@{@"sigen":self.sigen} parameters:nil result:^(id responseObj, NSError *error) {


        //        NSLog(@"====%@===",responseObj);


        if (responseObj) {


            if ([responseObj[@"status"] isEqualToString:@"10000"]) {



                if ([responseObj[@"goods_sum"] isEqualToString:@"0"]) {

                    self.tabBarItem.badgeValue = nil;

                }else{

                    self.tabBarItem.badgeValue = responseObj[@"goods_sum"];

                }

            }



        }else{


            NSLog(@"error");

        }


    }];

}


- (void)CartTabbarShow:(NSNotification *)text{


    self.tabBarController.tabBar.hidden=NO;
}

#pragma mark cell的协议监听方法
/**** 修改属性之后刷新数据 *****/
-(void)ChangAttributeLaterReloadData
{
    [_myTableView reloadData];
}

-(void)CartGoToDingDanReloadData
{

    [_FailureArrM removeAllObjects];

    [_StoreArrM removeAllObjects];

    [_myTableView removeFromSuperview];


    [view5 removeFromSuperview];
    [line5 removeFromSuperview];

    [CartNoGoodsView5 removeFromSuperview];

    [bgView5 removeFromSuperview];

    //创建导航栏
    [self initNav];

    //创建底部结算视图
    [self initTabbar];


    [self initTableView];


    [self getDatas];

}

-(void)ReloadCartNumber
{



}
//登录代理
-(void)setSigenWithString:(NSString *)string1 andStatusWithString:(NSString *)string2 andIntegralWithString:(NSString *)string3 andPhoneWithString:(NSString *)string4 andHeaderImageWithString:(NSString *)string5 andUserId:(NSString *)string6 andUserName:(NSString *)name
{

    NSLog(@"LLLLLLLLLLLL");

    self.sigen = string1;

    //获取购物车件数
    //    [self LookCartNumber];


    [HTTPRequestManager POST:@"getShoppingSum_mob.shtml" NSDictWithString:@{@"sigen":self.sigen} parameters:nil result:^(id responseObj, NSError *error) {



        if (responseObj) {


            if ([responseObj[@"status"] isEqualToString:@"10000"]) {

                if ([responseObj[@"goods_sum"] isEqualToString:@"0"]) {

                    self.tabBarItem.badgeValue = nil;

                }else{

                    self.tabBarItem.badgeValue = responseObj[@"goods_sum"];

                }


                if ([responseObj[@"goods_sum"] isEqualToString:@"0"]) {

                    NSLog(@"=====>>>.=====222222");

                    view.hidden=YES;
                    tabView.hidden=YES;
                    [self CartNoGoods];

                }else{


                    [_FailureArrM removeAllObjects];

                    [_StoreArrM removeAllObjects];


                    //创建导航栏
                    [self initNav];

                    //创建底部结算视图
                    [self initTabbar];



                    [self initTableView];

                    [self getDatas];

                }

            }

        }else{


            NSLog(@"error");

        }


    }];


}


//购物车为空
-(void)CartNoGoods
{
    
    self.tabBarController.tabBar.userInteractionEnabled=YES;
    
    _myTableView.backgroundColor = [UIColor whiteColor];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    view.hidden=YES;
    
    
    view5 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64)];
    view5.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:view5];
    
    line5 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 65, [UIScreen mainScreen].bounds.size.width, 1)];
    
    line5.image = [UIImage imageNamed:@"分割线-拷贝"];
    
    [self.view addSubview:line5];
    
    
    UILabel *titleLabel5 = [[UILabel alloc] initWithFrame:CGRectMake(100, 25, [UIScreen mainScreen].bounds.size.width-200, 30)];
    titleLabel5.text = @"购物车";
    titleLabel5.textAlignment=NSTextAlignmentCenter;
    titleLabel5.font=[UIFont systemFontOfSize:20];
    [view5 addSubview:titleLabel5];
    
    
    CartNoGoodsView5 = [[UIView alloc] initWithFrame:CGRectMake(0, ([UIScreen mainScreen].bounds.size.height-120)/2, [UIScreen mainScreen].bounds.size.width, 120)];
    
    //    CartNoGoodsView.backgroundColor = [UIColor orangeColor];
    
    [self.view addSubview:CartNoGoodsView5];
    
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-75/2)/2, 10, 75/2, 75/2)];
    imgView.image=[UIImage imageNamed:@"购物车为空"];
    [CartNoGoodsView5 addSubview:imgView];
    
    
    UILabel *imgLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 60, [UIScreen mainScreen].bounds.size.width, 20)];
    
    imgLabel.text=@"您的购物车是空的，快去挑选商品吧！";
    
    imgLabel.textAlignment = NSTextAlignmentCenter;
    
    imgLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:13];
    
    imgLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
    
    [CartNoGoodsView5 addSubview:imgLabel];
    
    UIButton *imgButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    imgButton.backgroundColor=[UIColor whiteColor];
    
    imgButton.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width-100)/2, 90, 100, 30);
    
    [imgButton setTitle:@"逛一逛" forState:0];
    
    imgButton.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:13];
    
    [imgButton setTitleColor:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]forState:0];
    
    [imgButton setBackgroundImage:[UIImage imageNamed:@"积分框"] forState:0];
    
    [imgButton addTarget:self action:@selector(GoToLookGoods) forControlEvents:UIControlEventTouchUpInside];
    
    [CartNoGoodsView5 addSubview:imgButton];
    
    bgView5 = [[UIView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-50-40, [UIScreen mainScreen].bounds.size.width, 40)];
    bgView5.backgroundColor=[UIColor whiteColor];
    
    [self.view addSubview:bgView5];
    
}

//逛一逛
-(void)GoToLookGoods
{
    self.tabBarController.selectedIndex = 0;
    
}
//编辑购物车

//结算
-(void)jiesuanBtnClick
{
    
    NSLog(@"====点击了结算====");
    
    
    WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
    
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        
    });
    
    
    
    for (int i = 0; i < _StoreArrM.count-1; i++) {
        StoreModel *shopModel = _StoreArrM[i];
        //取消段头编辑按钮的选中状态
        for (int j = 0; j < shopModel.shop.count; j++) {
            ShopModel *detailModel = shopModel.shop[j];
            
            if (detailModel.selectState==1) {
                
                shopModel.selectShop=1;
                
            }
        }
    }
    
    
    
    
    NSMutableArray *_YYYYYArrM;
    
    NSMutableArray *_WWWWWArrM;
    
    NSDictionary *dict1;
    
    
    
    _YYYYYArrM = [NSMutableArray new];
    
    _WWWWWArrM = [NSMutableArray new];
    
    for (int i = 0; i < _StoreArrM.count-1; i++) {
        StoreModel *shopModel = _StoreArrM[i];
        //取消段头编辑按钮的选中状态
        
        NSLog(@"===shopModel.selectShop====%d",shopModel.selectShop);
        
        for (int j = 0; j < shopModel.shop.count; j++) {
            ShopModel *detailModel = shopModel.shop[j];
            
            NSLog(@"===detailModel.selectState====%d",detailModel.selectState);
            
            if (shopModel.selectShop==1 && detailModel.selectState==1) {
                
                
                dict1 = @{@"sid":detailModel.sid,@"gid":detailModel.gid,@"number":detailModel.number,@"detailId":detailModel.detailId,@"exchange_type":detailModel.exchange_type};
                
                [_YYYYYArrM addObject:dict1];
                
                
            }
            
        }
        
        if (shopModel.selectShop==1) {
            
            NSLog(@"==数据源个数===%ld==",_YYYYYArrM.count);
            
            _WWWWWArrM = [[NSMutableArray alloc] initWithArray:_YYYYYArrM];
            ;
            
            NSLog(@"==_WWWWWArrM===%@==",_WWWWWArrM);
            
            [_YYYYYArrM removeAllObjects];
            
            
            nameDict= @{@"mid":shopModel.mid,@"storename":shopModel.storename,@"goodslist":_WWWWWArrM};
            
            [_JISuanDict addObject:nameDict];
            
        }
        
    }
    
    
    
    NSDictionary *dict = @{@"goods":_JISuanDict};
    
    
    NSString *str = [self dictionaryToJson:dict];
    
    NSLog(@"===%@",str);
    
    
    //    999999
    
    [HTTPRequestManager POST:@"getSettlementGoods_mob.shtml" NSDictWithString:@{@"sigen":self.sigen,@"json":str} parameters:nil result:^(id responseObj, NSError *error) {
        
        
        NSLog(@"====%@===",responseObj);
        
        
        if (responseObj) {
            
            for (NSDictionary *dict in responseObj) {
                
                
                if ([dict[@"status"] isEqualToString:@"10000"]) {
                    
                    
                    
                    //地址信息
                    
                    //                    for (NSDictionary *dict1 in dict[@"addresslist"]) {
                    //
                    //
                    //                        CartAddressModel *model = [[CartAddressModel alloc] init];
                    //
                    //                        model.name = dict1[@"name"];
                    //                        model.phone = dict1[@"phone"];
                    //                        model.defaultstate = dict1[@"defaultstate"];
                    //                        model.province = dict1[@"province"];
                    //                        model.city = dict1[@"city"];
                    //                        model.county = dict1[@"county"];
                    //                        model.address = dict1[@"address"];
                    //                        model.addressId = dict1[@"id"];
                    //
                    //
                    //                        [_NewAddressArrM addObject:model];
                    //
                    //
                    //                    }
                    
                    
                    CartGoToDingDanViewController *vc = [[CartGoToDingDanViewController alloc] init];
                    
                    vc.PanDuan = @"100";
                    
                    vc.sigen = self.sigen;
                    
                    vc.json = str;
                    
                    vc.responseObj = responseObj;
                    
                    vc.delegate=self;
                    
                    [hud dismiss:YES];
                    
                    self.navigationController.navigationBar.hidden=YES;
                    self.tabBarController.tabBar.hidden=YES;
                    [self.navigationController pushViewController:vc animated:NO];
                    
                    
                    
                }else if ([dict[@"status"] isEqualToString:@"10001"]){
                    
                    
                    //                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:dict[@"message"] message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    //
                    //                    [alert show];
                    
                    
                    alertCon = [UIAlertController alertControllerWithTitle:dict[@"message"] message:nil preferredStyle:UIAlertControllerStyleAlert];
                    
                    [alertCon addAction: [UIAlertAction actionWithTitle: @"确定" style: UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        
                        
                        for (NSDictionary *dict1 in dict[@"notBuyGoodsList"]) {
                            
                            StockNoMuchModel *model = [[StockNoMuchModel alloc] init];
                            
                            model.sid = [NSString stringWithFormat:@"%@",dict1[@"sid"]];
                            
                            model.stock = dict1[@"stock"];
                            
                            [_StockNoMuchArrM addObject:model];
                            
                        }
                        
                        
                        
                        for (int i = 0; i < _StoreArrM.count-1; i++) {
                            
                            StoreModel *shopModel = _StoreArrM[i];
                            //取消段头编辑按钮的选中状态
                            for (int j = 0; j < shopModel.shop.count; j++) {
                                ShopModel *detailModel = shopModel.shop[j];
                                
                                for (int k = 0; k < _StockNoMuchArrM.count; k++) {
                                    
                                    StockNoMuchModel *stockModel = _StockNoMuchArrM[k];
                                    
                                    if ([[NSString stringWithFormat:@"%@",detailModel.sid]  isEqualToString:stockModel.sid]) {
                                        
                                        
                                        detailModel.YYYYYYYYY = @"666";
                                        detailModel.TTTTTTTTT = stockModel.stock;
                                        
                                        //                                    NSLog(@"====88877777&&&&==%@===%@",detailModel.YYYYYYYYY,detailModel.TTTTTTTTT);
                                        
                                    }
                                    
                                }
                            }
                        }
                        
                        [hud dismiss:YES];
                        
                        [_myTableView reloadData];
                        
                    }]];
                    
                    [self presentViewController: alertCon animated: YES completion: nil];
                    
                }
                
            }
            
            
        }else{
            
            [hud dismiss:YES];
            
            NSLog(@"error");
            
        }
    }];
    
}

- (NSString*)dictionaryToJson:(NSDictionary *)dic

{
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}


//编辑购物车
-(void)editBtnClick:(UIButton *)sender
{
    CartAttributeCell *cell = (CartAttributeCell *)[sender superview];
    
    //    if (sender.selected) {
    //
    //        cell.selected=NO;
    //    }
    editButton.selected     =  !editButton.selected;
    //    _collectionBtn.hidden =  !_collectionBtn.hidden;
    //    _moneyLabel.hidden    =  !_moneyLabel.hidden;
    //    _settleBtn.selected   =  !_settleBtn.selected;
    
    for (int i = 0; i < _StoreArrM.count-1; i++) {
        StoreModel *shopModel = _StoreArrM[i];
        //取消段头编辑按钮的选中状态
        //        shopModel.editState = NO;
        shopModel.editState = sender.selected;
        for (int j = 0; j < shopModel.shop.count; j++) {
            ShopModel *detailModel = shopModel.shop[j];
            detailModel.deleteBtnState = sender.selected;
            detailModel.cellEditState = editButton.selected;
        }
    }
    
    if (sender.selected) {
        
        priceLabel.hidden = YES;
        yunfeiLabel.hidden =YES;
        dibuDelete.hidden=NO;
        JieSuan.hidden=YES;
        dibuDelete.enabled=YES;
        
        
        [_SubmieAlldArrM removeAllObjects];
        
        
    }else{
        
        priceLabel.hidden = NO;
        yunfeiLabel.hidden = NO;
        dibuDelete.hidden=YES;
        JieSuan.hidden=NO;
        dibuDelete.enabled=NO;
        
        [self EditAllGoods];
        
    }
    
    
    [_myTableView reloadData];
    
}

//全选
-(void)quanSelectBtnClick:(UIButton *)sender
{
    
    quanSelect.selected = !quanSelect.selected;
    [self.shopCarDeleteIdArray removeAllObjects];
    [_CartDeleteCountArrM removeAllObjects];
    
    NSMutableArray *detailArray = [NSMutableArray array];
    for (int i = 0; i < _StoreArrM.count-1; i++) {
        StoreModel *model = _StoreArrM[i];
        model.selectState = quanSelect.selected;
        
        for (int j = 0; j < model.shop.count; j++) {
            ShopModel *detailModel = model.shop[j];
            if (quanSelect.selected) {
                
                [self.shopCarDeleteIdArray addObject:detailModel.sid];
                
                [_CartDeleteCountArrM addObject:detailModel.sid];
                
                
            }else{
                
                
                [_CartDeleteCountArrM removeAllObjects];
                
            }
            //将cell中和全选按钮状态不一样的选中按钮 设置为和全选按钮的状态一样
            if (detailModel.selectState != quanSelect.selected) {
                detailModel.selectState  = quanSelect.selected;
                [detailArray addObject:detailModel];
            }
        }
    }
    
    //计算金额
    [self calculateTotalMoney:detailArray addOrReduc:quanSelect.selected];
    
    if ([self countTotalSelectedNumber]==0) {
        
        [JieSuan setBackgroundColor:[UIColor colorWithRed:215/255.0 green:215/255.0 blue:215/255.0 alpha:1.0]];
        JieSuan.enabled=NO;
        [dibuDelete setBackgroundColor:[UIColor colorWithRed:215/255.0 green:215/255.0 blue:215/255.0 alpha:1.0]];
        
    }else{
        
        
        [JieSuan setBackgroundColor:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0]];
        JieSuan.enabled=YES;
        [dibuDelete setBackgroundColor:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0]];
        
    }
    
    
    [JieSuan setTitle:[NSString stringWithFormat:@"结算(%ld)",[self countTotalSelectedNumber]] forState:0];
    
    [_myTableView reloadData];
    
}


#pragma -- mark FailureHeaderViewDelegate

-(void)deleteBtnClick
{

    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"确认要清空失效商品吗？" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
    [alert show];
    
}

#pragma -- mark ShopCarTableViewHeaderViewDelegate
/**
 *  表头按钮代理
 *
 *  @param sender 编辑或选中商品
 */
- (void)selectOrEditGoods:(UIButton *)sender{
    
    [self.shopCarDeleteIdArray removeAllObjects];
    
    
    //    NSLog(@"===组被选中==");
    
    StoreModel *model = _StoreArrM[sender.tag];
    NSMutableArray *detailModelArray = [NSMutableArray array];
    if (sender.titleLabel.text.length == 0) {//点击的是表头的全选按钮 设置cell的选中状态
        model.selectState = sender.selected;
        model.selectShop = sender.selected;
        
        for (int i = 0; i < model.shop.count; i++) {
            ShopModel *detailModel = model.shop[i];
            
            [self.shopCarDeleteIdArray addObject:detailModel.sid];
            
            
            //==================================================================
            if (sender.selected) {
                
                [_CartDeleteCountArrM addObject:detailModel.sid];
                
            }else{
                
                if ([_CartDeleteCountArrM containsObject:detailModel.sid]) {
                    
                    [_CartDeleteCountArrM removeObject:detailModel.sid];
                    
                }
            }
            
            //===================================================================
            
            
            if (detailModel.selectState != model.selectState) {
                detailModel.selectState = model.selectState;
                [detailModelArray addObject:detailModel];
            }
        }
        
        //计算价格
        [self calculateTotalMoney:detailModelArray addOrReduc:sender.selected];
        //
        [self setBottomBtnSelectState];
        
        if ([self countTotalSelectedNumber]==0) {
            
            [JieSuan setBackgroundColor:[UIColor colorWithRed:215/255.0 green:215/255.0 blue:215/255.0 alpha:1.0]];
            JieSuan.enabled=NO;
            [dibuDelete setBackgroundColor:[UIColor colorWithRed:215/255.0 green:215/255.0 blue:215/255.0 alpha:1.0]];
            
        }else{
            
            
            [JieSuan setBackgroundColor:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0]];
            JieSuan.enabled=YES;
            [dibuDelete setBackgroundColor:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0]];
            
        }
        
        [JieSuan setTitle:[NSString stringWithFormat:@"结算(%ld)",[self countTotalSelectedNumber]] forState:0];
        
        [_myTableView reloadData];
        
    }
    //    else{//点击的是表头的编辑按钮 设置cell的状态为可编辑
    //        model.editState = sender.selected;
    //        for (int i = 0; i < model.goodsDetails.count; i++) {
    //            CarDetailModel *detailModel = model.goodsDetails[i];
    //            detailModel.deleteBtnState = sender.selected;
    //            detailModel.cellEditState = sender.selected;
    //        }
    //
    //        [_tableView reloadData];
    //
    //    }
}


-(void)enterShopStore:(NSString *)mid
{
    
    MerchantDetailViewController *look=[[MerchantDetailViewController alloc] init];
    
    //    look.BackString = @"100";
    
    look.mid=mid;
    
    look.jindu=self.jindu;
    
    look.weidu = self.weidu;
    
    look.MapStartAddress = self.MapStartAddress;
    
    self.tabBarController.tabBar.hidden=YES;
    [self.navigationController pushViewController:look animated:NO];
    
}
//组头编辑

-(void)EditGoods:(UIButton *)sender
{
    
    NSLog(@"======sender.tag====%ld",(long)sender.tag);
    
    StoreModel *model = _StoreArrM[sender.tag];
    
    model.editState = sender.selected;
    for (int i = 0; i < model.shop.count; i++) {
        ShopModel *detailModel = model.shop[i];
        detailModel.deleteBtnState = sender.selected;
        detailModel.cellEditState = sender.selected;
    }
    
    if(sender.selected)
    {
        NSLog(@"正在编辑");
        
        [_SubmitArrM removeAllObjects];
        
        
    }else{
        
        NSLog(@"编辑完成");
        
        [UserMessageManager RemoveAgain];
        
        for (int i = 0; i < model.shop.count; i++) {
            
            ShopModel *detailModel = model.shop[i];
            
            NSLog(@"===EditChangeString===%@",detailModel.EditChangeString);
            
            NSLog(@"===EditChangeAttribute===%@",detailModel.EditChangeAttribute);
            
            
            
            if (detailModel.EditChangeAttribute.length!=0) {
                
                [_EditChangeArrM addObject:detailModel.EditChangeAttribute];
                
            }
            
            if (detailModel.EditChangeString.length!=0) {
                
                [_EditChangeArrM addObject:detailModel.EditChangeString];
                
            }
            
            
        }
        
        
        //        NSLog(@"===_EditChangeArrM===%@",_EditChangeArrM);
        
        [self EditChangeData];
        
        
    }
    
    [_myTableView reloadData];
}

/**
 *  设置下方全选按钮选中状态
 */
- (void)setBottomBtnSelectState{
    BOOL currentState = YES;
    //下方全选按钮选中状态
    for (int i = 0; i < _StoreArrM.count-1; i++) {
        StoreModel *model = _StoreArrM[i];
        if (model.selectState != YES) {
            currentState = NO;
            break;
        }
    }
    //最下方的全选按钮的状态
    quanSelect.selected =currentState;
    
}


#pragma mark -- ShopTableViewCellSelectDelegate
/**
 *  cell的选择代理
 *
 *  @param sender 选中按钮
 */
- (void)cellSelectBtnClick:(UIButton *)sender{
    
    
    [self.shopCarDeleteIdArray removeAllObjects];
    
    //先清空数据源
    
    //    [_SubmieDict removeAllObjects];
    
    [_JISuanDict removeAllObjects];
    
    
    CartAttributeCell *cell = (CartAttributeCell *)[sender superview];
    NSIndexPath *indexPath;
    indexPath = [_myTableView indexPathForCell:cell];
    
    if (indexPath.section == _StoreArrM.count-1) {
        
        
    }else{
        
        
        NSLog(@"=======选择的是====%ld===%ld===",(long)indexPath.section,indexPath.row);
        
        StoreModel *bigModel = _StoreArrM[indexPath.section];
        ShopModel *cellModel = bigModel.shop[indexPath.row];
        cellModel.selectState = sender.selected;
        
        bigModel.selectShop = sender.selected;
        
        
        
        if (sender.selected) {
            
            
            NSLog(@"被选中");
            
            NSLog(@"=bigModel.mid==%@",bigModel.mid);
            NSLog(@"=bigModel.storename==%@",bigModel.storename);
            NSLog(@"=sid==%@",cellModel.sid);
            NSLog(@"=gid==%@",cellModel.gid);
            NSLog(@"=detailId==%@",cellModel.detailId);
            NSLog(@"=number==%@",cellModel.number);
            NSLog(@"=exchange_type==%@",cellModel.exchange_type);
            
            
            
            //            dict = @{@"sid":cellModel.sid,@"gid":cellModel.gid,@"number":cellModel.number,@"detailId":cellModel.detailId,@"exchange_type":cellModel.exchange_type};
            //
            //            [_SubmieDict addObject:dict];
            //
            //            if ([RemberStoreName isEqualToString:bigModel.storename]) {
            //
            //                nameDict= @{@"mid":bigModel.mid,@"storename":bigModel.storename,@"goodslist":_SubmieDict};
            //
            //
            //            }else{
            //
            //                NSDictionary *dict1 = @{@"mid":bigModel.mid,@"storename":bigModel.storename,@"goodslist":_SubmieDict};
            //
            //                nameDict = dict1;
            //
            //
            //            }
            //
            //            RemberStoreName = bigModel.storename;
            //
            //
            //
            //
            //        }else{
            //
            //            NSLog(@"已取消");
            //
            ////            if ([RemberStoreName isEqualToString:bigModel.storename]) {
            //
            //                [_SubmieDict removeObject:dict];
            //
            //
            ////            }else{
            ////
            ////                [_SubmieDict removeObject:<#(nonnull id)#>]
            ////            }
            //
            //
        }
        
        
        
        if (sender.selected) {
            
            
            NSLog(@"被选中");
            
            [_CartDeleteCountArrM addObject:cellModel.sid];
            
            
            
        }else{
            
            if ([_CartDeleteCountArrM containsObject:cellModel.sid]) {
                
                [_CartDeleteCountArrM removeObject:cellModel.sid];
                
            }
            NSLog(@"被取消");
            
            
        }
        
        
        
        [self.shopCarDeleteIdArray addObject:cellModel.sid];
        
        //设置段头的选择按钮选中状态
        [self setHeaderViewSelectState:bigModel];
        //设置底部选择按钮的选中状态
        [self setBottomBtnSelectState];
        //计算价格
        
        [self calculateTotalMoney:[NSMutableArray arrayWithObject:cellModel] addOrReduc:sender.selected];
        
//        NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:indexPath.section];
//        [_myTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
        [_myTableView reloadData];
        
    }
    
    if ([self countTotalSelectedNumber]==0) {
        
        [JieSuan setBackgroundColor:[UIColor colorWithRed:215/255.0 green:215/255.0 blue:215/255.0 alpha:1.0]];
        JieSuan.enabled=NO;
        [dibuDelete setBackgroundColor:[UIColor colorWithRed:215/255.0 green:215/255.0 blue:215/255.0 alpha:1.0]];
        
    }else{
        
        
        [JieSuan setBackgroundColor:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0]];
        JieSuan.enabled=YES;
        [dibuDelete setBackgroundColor:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0]];
        
    }
    [JieSuan setTitle:[NSString stringWithFormat:@"结算(%ld)",[self countTotalSelectedNumber]] forState:0];
    
}

#pragma mark -- 计算总价
/**
 *  计算总价
 *
 *  @param detailModelArray 商品集合
 *  @param operation        YES 加  NO 减
 */
- (void)calculateTotalMoney:(NSMutableArray *)detailModelArray addOrReduc:(BOOL)operation{
    
    //    NSLog(@"===detailModelArray.count===%ld",(unsigned long)detailModelArray.count);
    
    //    [JieSuan setTitle:[NSString stringWithFormat:@"结算(%ld)",[self countTotalSelectedNumber]] forState:0];
    NSString *price;//金钱
    NSString *integer;//积分
    
    for (ShopModel *detailModel in detailModelArray) {
        
        //        price = [priceLabel.text substringFromIndex:4];
        
        
        //        priceLabel.text = @"合计:￥0.00+0.00积分";
        
        NSString * string = priceLabel.text;
        
        NSString *string1 = [string substringFromIndex:4];
        
        NSString *string2 = [string1 substringToIndex:string1.length-2];
        
        NSArray *arrtay = [string2 componentsSeparatedByString:@"+"];
        
        price = arrtay[0];
        
        integer = arrtay[1];
        
        //        NSLog(@"=======333333==%@==%@",price,integer);
        
        
        if (operation) {
            
            NSString *string = [NSString stringWithFormat:@"合计:¥%.02f+%.02f积分",[price floatValue] + [detailModel.pay_maney floatValue]*[detailModel.number intValue],[integer floatValue] + [detailModel.pay_integer floatValue]*[detailModel.number intValue]];
            
            NSString *stringForColor = [NSString stringWithFormat:@"¥%.02f+%.02f积分",[price floatValue] + [detailModel.pay_maney floatValue]*[detailModel.number intValue],[integer floatValue] + [detailModel.pay_integer floatValue]*[detailModel.number intValue]];
            // 创建对象.
            NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:string];
            //
            NSRange range = [string rangeOfString:stringForColor];
            
            [mAttStri addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
            
            priceLabel.attributedText=mAttStri;
            
            
        }else{
            
            
            NSString *string = [NSString stringWithFormat:@"合计:¥%.02f+%.02f积分",[price floatValue] - [detailModel.pay_maney floatValue]*[detailModel.number intValue],[integer floatValue] - [detailModel.pay_integer floatValue]*[detailModel.number intValue]];
            
            NSString *stringForColor = [NSString stringWithFormat:@"¥%.02f+%.02f积分",[price floatValue] - [detailModel.pay_maney floatValue]*[detailModel.number intValue],[integer floatValue] - [detailModel.pay_integer floatValue]*[detailModel.number intValue]];
            // 创建对象.
            NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:string];
            //
            NSRange range = [string rangeOfString:stringForColor];
            
            [mAttStri addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
            
            priceLabel.attributedText=mAttStri;
            
            
        }
        
    }
    
}

#pragma mark - 计算商品被选择了数量
- (NSInteger)countTotalSelectedNumber
{
    NSInteger count = 0;
    
    for (int i =0; i<_StoreArrM.count-1; i++) {
        
        StoreModel *buyer = _StoreArrM[i];
        
        for (int j=0; j<buyer.shop.count; j++) {
            
            ShopModel *product = buyer.shop[j];
            
            if (product.selectState) {
                count ++;
            }
            
        }
    }
    
    return count;
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    //删除单条失效商品
    if (alertView.tag==100) {
        
        
        if (buttonIndex==1) {
            
            
            [self DeleteGoodsNone];
            
        }
        
        
        
    }else if (alertView.tag==200) {
        
        
        if (buttonIndex==1) {
            
            
            WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
            
            dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
            dispatch_after(time, dispatch_get_main_queue(), ^{
                
                
                
            });
            
            [HTTPRequestManager POST:@"deleteShoppingCartGoods_mob.shtml" NSDictWithString:@{@"sigen":self.sigen,@"sid":DeleteGoodsNone} parameters:nil result:^(id responseObj, NSError *error) {
                
                
                NSLog(@"====%@===",responseObj);
                
                
                if (responseObj) {
                    
                    for (NSDictionary *dict in responseObj) {
                        
                        
                        if ([dict[@"status"] isEqualToString:@"10000"]) {
                            
                            
                            
                            [hud dismiss:YES];
                            
                            //清空数据源
                            [_StoreArrM removeAllObjects];
                            [_FailureArrM removeAllObjects];
                            
                            //创建导航栏
                            [self initNav];
                            
                            //创建底部结算视图
                            [self initTabbar];
                            
                            
                            editButton.selected = NO;
                            priceLabel.hidden = NO;
                            yunfeiLabel.hidden = NO;
                            dibuDelete.hidden=YES;
                            JieSuan.hidden=NO;
                            dibuDelete.enabled=NO;
                            
                            
                            //重新加载数据
                            
                            [self getDatas];
                            
                            
                        }
                        
                        
                    }
                    
                    
                }else{
                    
                    
                    NSLog(@"error");
                    
                }
                
                
            }];
            
            
        }
        
        
        
    }else{
        
        
        //清空失效商品
        if (buttonIndex==1) {
            
            
            //        for (NSString *sid in _DeleteFailureArrM) {
            //
            //
            //            NSLog(@"===sid==%@",sid);
            //
            //
            //        }
            
            
            NSString *str = [_DeleteFailureArrM componentsJoinedByString:@","];
            
            
            
            WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
            
            dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
            dispatch_after(time, dispatch_get_main_queue(), ^{
                
                
                
            });
            
            
            [HTTPRequestManager POST:@"deleteShoppingCartGoods_mob.shtml" NSDictWithString:@{@"sigen":self.sigen,@"sid":str} parameters:nil result:^(id responseObj, NSError *error) {
                
                
                NSLog(@"====%@===",responseObj);
                
                
                if (responseObj) {
                    
                    for (NSDictionary *dict in responseObj) {
                        
                        
                        
                        if ([dict[@"status"] isEqualToString:@"10000"]) {
                            
                            
                            [hud dismiss:YES];
                            
                            self.Failure = @"0";
                            
                            
                            //回到头部
                            //                            [_myTableView setContentOffset:CGPointZero animated:YES];
                            
                            [_myTableView reloadData];
                            
                        }
                        
                        
                    }
                    
                    
                    
                }else{
                    
                    
                    NSLog(@"error");
                    
                }
                
                
            }];
            
            
        }
        
    }
    
}

//滑动删除



-(void)DeleteGoodsNone
{
    
    NSLog(@"KKKKKKKKK====要删除的失效商品的sid==%@",DeleteGoodsNone);
    
    
    WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
    
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        
        
        
    });
    
    
    [HTTPRequestManager POST:@"deleteShoppingCartGoods_mob.shtml" NSDictWithString:@{@"sigen":self.sigen,@"sid":DeleteGoodsNone} parameters:nil result:^(id responseObj, NSError *error) {
        
        
        NSLog(@"====%@===",responseObj);
        
        
        if (responseObj) {
            
            for (NSDictionary *dict in responseObj) {
                
                
                
                if ([dict[@"status"] isEqualToString:@"10000"]) {
                    
                    
                    [hud dismiss:YES];
                    
                    
                    //                    if (_ShiXiaoArrM.count==0) {
                    //
                    //                        self.Failure = @"0";
                    //
                    //                    }
                    //                    //回到头部
                    //
                    //                    [_StoreArrM replaceObjectAtIndex:_StoreArrM.count-1 withObject:_ShiXiaoArrM];
                    //
                    //
                    //                    [_myTableView reloadData];
                    
                    [self getDatas];
                    
                }
                
                
            }
            
            
            
        }else{
            
            
            NSLog(@"error");
            
        }
        
        
    }];
    
}


//下拉刷新
- (void)refresh:(DJRefresh *)refresh didEngageRefreshDirection:(DJRefreshDirection)direction{
    
    //    view1.hidden=YES;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self addDataWithDirection:direction];
        
        //        view1.hidden=NO;
        
    });
    
    self.tabBarController.tabBar.userInteractionEnabled=NO;
    
    WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
    
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        
        [hud dismiss:YES];
        
    });
    
    
}

- (void)addDataWithDirection:(DJRefreshDirection)direction{
    
    if (direction==DJRefreshDirectionTop) {
        
        
        //        [_StoreArrM removeAllObjects];
        
        //        [_FailureArrM removeAllObjects];
        
        
        //创建导航栏
        [self initNav];
        
        //创建底部结算视图
        [self initTabbar];
        
        editButton.selected = NO;
        
        
        priceLabel.hidden = NO;
        yunfeiLabel.hidden = NO;
        dibuDelete.hidden=YES;
        JieSuan.hidden=NO;
        dibuDelete.enabled=NO;
        
        [self initTableView];
        
        
        
        [self getDatas];
        
        //回到头部
        //        [_myTableView setContentOffset:CGPointZero animated:YES];
        
    }
    
    [_refresh finishRefreshingDirection:direction animation:YES];
    
    
}

/**
 *  修改商品数量
 *
 *  @param sender 1 减少  2 增加
 */
- (void)changeShopCount:(NSString *)sender SidWithString:(NSString *)sid DetailWithString:(NSString *)detailId Type:(NSString *)type Goods_Type:(NSString *)goods_type{
    
    
    NSLog(@"====修改数量的detailId=====%@===self.BackBack===%@===goods_type==%@",detailId,self.BackBack,goods_type);
    
    [_ChangeNumberArrM removeAllObjects];
    
    NSNull *null = [[NSNull alloc] init];
    
    if ([detailId isEqual:null]) {
        
        detailId = @"0";
        
    }
    
    if ([self.BackBack isEqual:null]) {
        
        self.BackBack = @"0";
        
    }
    
    //无属性商品detailId直接给0
    
    if ([goods_type isEqualToString:@"2"]) {
        
        
        if (![self.BackBack isEqualToString:detailId]){
            
            if (self.BackBack.length==0) {
                
                detailId = detailId;
                
            }else{
                
                detailId = self.BackBack;
            }
            
        }
        
    }else{
        
        
        detailId = @"0";
        
    }
    
    
    
    NSLog(@"===修改商品数量===%@====%@===%@",sender,sid,detailId);
    
    
    //    self.YTSid = sid;
    //
    //    self.YTNumber = sender;
    //
    //    self.YTDetailId = detailId;
    
    
    self.YTSid = [NSString stringWithFormat:@"%@,%@,%@",sid,sender,detailId];
    
    
    NSLog(@"===self.YTSid===%@",self.YTSid);
    
    [_SubmitArrM addObject:self.YTSid];
    
    [_SubmieAlldArrM addObject:self.YTSid];
    
    //每次修改商品数量，就修改数据源商品件数
    for (int i = 0; i < _StoreArrM.count-1; i++) {
        
        StoreModel *shopModel = _StoreArrM[i];
        //取消段头编辑按钮的选中状态
        for (int j = 0; j < shopModel.shop.count; j++) {
            ShopModel *detailModel = shopModel.shop[j];
            
            if (detailModel.sid ==sid) {
                
                detailModel.number=sender;
                
                detailModel.EditChangeString =self.YTSid;
                
                if ([type isEqualToString:@"0"]) {
                    
                    NSLog(@"==商品数量减==");
                    
                    
                }else{
                    
                    
                    NSLog(@"==商品数量加==");
                    
                    
                }
                
            }
        }
    }
    
}




/**
 *  删除商品
 *
 *  @param sender 删除按钮
 */
- (void)deleteShopGoodTouch:(UIButton *)sender{
    
    CartAttributeCell *cell = (CartAttributeCell *)[sender superview];
    NSIndexPath *indexPath;
    indexPath = [_myTableView indexPathForCell:cell];
    [self deleteShopCarGood:indexPath];
    
}

//单个删除商品
- (void)deleteShopCarGood:(NSIndexPath *)indexPath{
    
    //失效商品
    if (indexPath.section==_StoreArrM.count-1) {
        
        
    }else{
        
        StoreModel *bigModel = _StoreArrM[indexPath.section];
        ShopModel *detailModel = bigModel.shop[indexPath.row];
        
        NSLog(@"====detailModel.sid=====%@",detailModel.sid);
        
        DeleteGoodsNone = detailModel.sid;
        
        
        [self.shopCarDeleteIdArray addObject:detailModel.sid];
        
        NSMutableArray *detailArray = [NSMutableArray arrayWithArray:bigModel.shop];
        
        alertCon = [UIAlertController alertControllerWithTitle:@"确认要删除这个商品吗？" message:nil preferredStyle:UIAlertControllerStyleAlert];
        
        
        [alertCon addAction: [UIAlertAction actionWithTitle: @"取消" style: UIAlertActionStyleCancel handler:nil]];
        
        [alertCon addAction: [UIAlertAction actionWithTitle: @"确定" style: UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            
            WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
            
            dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 1ull * NSEC_PER_SEC);
            dispatch_after(time, dispatch_get_main_queue(), ^{
                
                
                
                
            });
            
            
            
            [HTTPRequestManager POST:@"deleteShoppingCartGoods_mob.shtml" NSDictWithString:@{@"sigen":self.sigen,@"sid":DeleteGoodsNone} parameters:nil result:^(id responseObj, NSError *error) {
                
                
                NSLog(@"====%@===",responseObj);
                
                
                if (responseObj) {
                    
                    for (NSDictionary *dict in responseObj) {
                        
                        
                        if ([dict[@"status"] isEqualToString:@"10000"]) {
                            
                            [hud dismiss:YES];
                            
                            [detailArray removeObjectAtIndex:indexPath.row];
                            
                            bigModel.shop = detailArray;
                            
                            if (detailArray.count == 0) {
                                
                                [_StoreArrM removeObjectAtIndex:indexPath.section];
                                
                            }
                            
                            
                            if ([dict[@"goods_sum"] isEqualToString:@"0"]) {
                                
                                
                                self.tabBarItem.badgeValue = nil;
                                
                                [UserMessageManager AppDelegateCartNumber:dict[@"goods_sum"]];
                                
                                
                            }else{
                                
                                
                                self.tabBarItem.badgeValue = dict[@"goods_sum"];
                                
                                [UserMessageManager AppDelegateCartNumber:dict[@"goods_sum"]];
                                
                                
                            }
                            
                            
                            priceLabel.text = @"合计:￥0.00+0.00积分";
                            
                            for (int i =0; i<_StoreArrM.count-1; i++) {
                                
                                StoreModel *buyer = _StoreArrM[i];
                                
                                for (int j=0; j<buyer.shop.count; j++) {
                                    
                                    ShopModel *product = buyer.shop[j];
                                    
                                    if (product.selectState) {
                                        
                                        NSLog(@"===product.name===%@",product.name);
                                        
                                        NSString *price;//金钱
                                        NSString *integer;//积分
                                        
                                        NSLog(@"======priceLabel.text======%@",priceLabel.text);
                                        
                                        NSString * string = priceLabel.text;
                                        
                                        NSString *string1 = [string substringFromIndex:4];
                                        
                                        NSString *string2 = [string1 substringToIndex:string1.length-2];
                                        
                                        NSArray *arrtay = [string2 componentsSeparatedByString:@"+"];
                                        
                                        price = arrtay[0];
                                        
                                        integer = arrtay[1];
                                        
                                        
                                        NSString *string3 = [NSString stringWithFormat:@"合计:¥%.02f+%.02f积分",[price floatValue] + [product.pay_maney floatValue]*[product.number intValue],[integer floatValue] + [product.pay_integer floatValue]*[product.number intValue]];
                                        
                                        NSString *stringForColor = [NSString stringWithFormat:@"¥%.02f+%.02f积分",[price floatValue] + [product.pay_maney floatValue]*[product.number intValue],[integer floatValue] + [product.pay_integer floatValue]*[product.number intValue]];
                                        // 创建对象.
                                        NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:string3];
                                        //
                                        NSRange range = [string3 rangeOfString:stringForColor];
                                        
                                        [mAttStri addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
                                        
                                        priceLabel.attributedText=mAttStri;
                                        
                                        
                                        
                                    }
                                }
                            }
                            
                            //计算价格
                            //                                [self calculateTotalMoney:[NSMutableArray arrayWithObject:product] addOrReduc:0];
                            //
                            [self setBottomBtnSelectState];
                            
                            if ([self countTotalSelectedNumber]==0) {
                                
                                [JieSuan setBackgroundColor:[UIColor colorWithRed:215/255.0 green:215/255.0 blue:215/255.0 alpha:1.0]];
                                JieSuan.enabled=NO;
                                [dibuDelete setBackgroundColor:[UIColor colorWithRed:215/255.0 green:215/255.0 blue:215/255.0 alpha:1.0]];
                                
                            }else{
                                
                                
                                [JieSuan setBackgroundColor:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0]];
                                JieSuan.enabled=YES;
                                [dibuDelete setBackgroundColor:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0]];
                                
                            }
                            
                            [JieSuan setTitle:[NSString stringWithFormat:@"结算(%ld)",[self countTotalSelectedNumber]] forState:0];
                            
                            //调用计算价格
                            
                            [_myTableView reloadData];
                            
                            
                            
                            //
                            //
                            //                                [_FailureArrM removeAllObjects];
                            //
                            //                                [_StoreArrM removeAllObjects];
                            //
                            //
                            //                                //创建导航栏
                            //                                [self initNav];
                            //
                            //                                //创建底部结算视图
                            //                                [self initTabbar];
                            //
                            //                                [self initTableView];
                            //
                            //                                [self getDatas];
                            //                            }
                            
                        }
                        
                        
                    }
                    
                    
                }else{
                    
                    
                    NSLog(@"error");
                    
                }
                
                
            }];
            
            
            
        }]];
        
        
        [self presentViewController: alertCon animated: YES completion: nil];
        
        
        //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"确认要删除这个商品吗？" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        //
        //        alert.tag=200;
        //
        //        [alert show];
        
        
    }
    
}

#pragma mark -- 懒加载

- (NSMutableArray *)shopCarGoodsArray{
    if (_shopCarGoodsArray == nil) {
        _shopCarGoodsArray = [NSMutableArray array];
    }
    return _shopCarGoodsArray;
}

- (NSMutableArray *)shopCarDeleteIdArray{
    if (_shopCarDeleteIdArray == nil) {
        _shopCarDeleteIdArray = [NSMutableArray array];
    }
    return _shopCarDeleteIdArray;
}

- (NSMutableArray *)currentSpecificationsArray{
    if (_currentSpecificationsArray == nil) {
        _currentSpecificationsArray = [NSMutableArray array];
    }
    return _currentSpecificationsArray;
}
- (NSMutableArray *)allSpecificationsArray{
    if (_allSpecificationsArray == nil) {
        _allSpecificationsArray = [NSMutableArray array];
    }
    return _allSpecificationsArray;
}

- (NSMutableArray *)selectSpecificationsArray{
    if (_selectSpecificationsArray == nil) {
        _selectSpecificationsArray = [NSMutableArray array];
    }
    return _selectSpecificationsArray;
}

-(void)setGoods_num:(NSString *)goods_num
{
    _goods_num=goods_num;
    if ([_goods_num isEqualToString:@"0"]) {
        self.tabBarItem.badgeValue=nil;
    }else
    {
        self.tabBarItem.badgeValue=_goods_num;
    }

}

//底部删除
-(void)dibuDeleteBtnClick:(UIButton *)sender
{
    
    NSLog(@"====底部删除====");
    
    
    //    NSString *yyyyyy = [self.shopCarDeleteIdArray componentsJoinedByString:@","];
    
    NSString *yyyyyy = [_CartDeleteCountArrM componentsJoinedByString:@","];
    
    //    for (NSString *sid in self.shopCarDeleteIdArray) {
    
    NSLog(@"===sid==%@",yyyyyy);
    
    //    }
    
    if (_CartDeleteCountArrM.count==0) {
        
        
    }else{
        
        alertCon = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"确认要删除这%ld个商品吗？",(unsigned long)_CartDeleteCountArrM.count] message:nil preferredStyle:UIAlertControllerStyleAlert];
        
        
        [alertCon addAction: [UIAlertAction actionWithTitle: @"取消" style: UIAlertActionStyleCancel handler:nil]];
        
        [alertCon addAction: [UIAlertAction actionWithTitle: @"确定" style: UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            
            WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
            
            dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
            dispatch_after(time, dispatch_get_main_queue(), ^{
                
                
                
            });
            
            [HTTPRequestManager POST:@"deleteShoppingCartGoods_mob.shtml" NSDictWithString:@{@"sigen":self.sigen,@"sid":yyyyyy} parameters:nil result:^(id responseObj, NSError *error) {
                
                
                NSLog(@"====%@===",responseObj);
                
                
                if (responseObj) {
                    
                    for (NSDictionary *dict in responseObj) {
                        
                        
                        if ([dict[@"status"] isEqualToString:@"10000"]) {
                            
                            
                            [hud dismiss:YES];
                            
                            [_StoreArrM removeAllObjects];
                            [_FailureArrM removeAllObjects];
                            
                            
                            [tabView removeFromSuperview];
                            
                            //创建导航栏
                            [self initNav];
                            
                            //创建底部结算视图
                            [self initTabbar];
                            
                            
                            //                            editButton.selected = NO;
                            //                            priceLabel.hidden = NO;
                            //                            yunfeiLabel.hidden = NO;
                            //                            dibuDelete.hidden=YES;
                            //                            JieSuan.hidden=NO;
                            //                            dibuDelete.enabled=NO;
                            
                            
                            [self getDatas];
                            
                            
                            //                        editButton.selected=YES;
                            //
                            //                        [self editBtnClick:editButton];
                            
                            
                            //                        [_myTableView reloadData];
                            
                            
                        }
                        
                        
                    }
                    
                    
                }else{
                    
                    
                    NSLog(@"error");
                    
                }
                
                
            }];
            
            
            
        }]];
        
        [self presentViewController: alertCon animated: YES completion: nil];
        
    }
    
}

//全部编辑
-(void)EditAllGoods
{
    
    
    NSString *all = [_SubmieAlldArrM componentsJoinedByString:@"_"];
    
    
    
    NSLog(@"==self.YTDetailId===%@",all);
    
    [HTTPRequestManager POST:@"submitShoppingCartGoods_mob.shtml" NSDictWithString:@{@"sigen":self.sigen,@"json":all} parameters:nil result:^(id responseObj, NSError *error) {
        
        
        NSLog(@"==全部编辑==%@===",responseObj);
        
        
        if (responseObj) {
            
            for (NSDictionary *dict in responseObj) {
                
                
                if ([dict[@"status"] isEqualToString:@"10000"]) {
                    
                    
                    //                    [_StoreArrM removeAllObjects];
                    //                    [_FailureArrM removeAllObjects];
                    
                    
                    
                    //清除属性
                    
                    [UserMessageManager removeAllGoodsAttribute];
                    [UserMessageManager removeAllImageSecect];
                    
                    //创建导航栏
                    [self initNav];
                    
                    //创建底部结算视图
                    [self initTabbar];
                    
                    editButton.selected = NO;
                    
                    
                    priceLabel.hidden = NO;
                    yunfeiLabel.hidden = NO;
                    dibuDelete.hidden=YES;
                    JieSuan.hidden=NO;
                    dibuDelete.enabled=NO;
                    
                    //                    [self initTableView];
                    //
                    //                    [self getDatas];
                    
                    
                    for (int i =0; i<_StoreArrM.count-1; i++) {
                        
                        StoreModel *buyer = _StoreArrM[i];
                        
                        if (buyer.selectState) {
                            
                            buyer.selectState=NO;
                            
                        }
                        
                        for (int j=0; j<buyer.shop.count; j++) {
                            
                            ShopModel *product = buyer.shop[j];
                            
                            if (product.selectState) {
                                
                                //修改处
                                product.selectState=NO;
                                
                                NSLog(@"===product.name===%@",product.name);
                                
                            }
                            
                        }
                    }
                    
                    
                    //刷新数据源
                  //  [_myTableView reloadData];
                     [self getDatas];
                    
                }else if ([dict[@"status"] isEqualToString:@"10002"]){
                    
                    
                    //                    [_StoreArrM removeAllObjects];
                    //                    [_FailureArrM removeAllObjects];
                    
                    
                    
                    //清除属性
                    
                    [UserMessageManager removeAllGoodsAttribute];
                    [UserMessageManager removeAllImageSecect];
                    
                    
                    //创建导航栏
                    [self initNav];
                    
                    //创建底部结算视图
                    [self initTabbar];
                    
                    editButton.selected = NO;
                    
                    
                    priceLabel.hidden = NO;
                    yunfeiLabel.hidden = NO;
                    dibuDelete.hidden=YES;
                    JieSuan.hidden=NO;
                    dibuDelete.enabled=NO;
                    
                    //                    [self initTableView];
                    //
                    //                    [self getDatas];
                    
                    
                    for (int i =0; i<_StoreArrM.count-1; i++) {
                        
                        StoreModel *buyer = _StoreArrM[i];
                        
                        if (buyer.selectState) {
                            
                            buyer.selectState=NO;
                            
                        }
                        for (int j=0; j<buyer.shop.count; j++) {
                            
                            ShopModel *product = buyer.shop[j];
                            
                            if (product.selectState) {
                                
                                //修改处
                                product.selectState=NO;
                                
                                NSLog(@"===product.name===%@",product.name);
                                
                            }
                            
                        }
                    }
                    
                    
                    //刷新数据源
                   // [_myTableView reloadData];
                     [self getDatas];
                    
                }
                
                
            }
            
            
        }else{
            
            
            NSLog(@"error");
            
        }
        
        
    }];

}

//编辑修改数据
-(void)EditChangeData
{
    
    
    //编辑完成，需要修改的字段
    //    self.YTDetailId = [_SubmitArrM componentsJoinedByString:@"_"];
    
    self.YTDetailId = [_EditChangeArrM componentsJoinedByString:@"_"];
    
    NSLog(@"==self.YTDetailId===%@",self.YTDetailId);
    
    [HTTPRequestManager POST:@"submitShoppingCartGoods_mob.shtml" NSDictWithString:@{@"sigen":self.sigen,@"json":self.YTDetailId} parameters:nil result:^(id responseObj, NSError *error) {
        
        
        NSLog(@"==编辑修改数据==%@===",responseObj);
        
        
        if (responseObj) {
            
            for (NSDictionary *dict in responseObj) {
                
                
                if ([dict[@"status"] isEqualToString:@"10000"]) {
                    
                    
                    //                    [_StoreArrM removeAllObjects];
                    //                    [_FailureArrM removeAllObjects];
                    //
                    //
                    //
                    //                    //清除属性
                    //
                    [UserMessageManager removeAllGoodsAttribute];
                    [UserMessageManager removeAllImageSecect];
                    //
                    //创建导航栏
                    [self initNav];
                    
                    //创建底部结算视图
                    [self initTabbar];
                    
                    editButton.selected = NO;
                    
                    
                    priceLabel.hidden = NO;
                    yunfeiLabel.hidden = NO;
                    dibuDelete.hidden=YES;
                    JieSuan.hidden=NO;
                    dibuDelete.enabled=NO;
                    //
                    //                    [self initTableView];
                    //
                    //                    [self getDatas];
                    
                    
                    
                    for (int i =0; i<_StoreArrM.count-1; i++) {
                        
                        StoreModel *buyer = _StoreArrM[i];
                        
                        if (buyer.selectState) {
                            
                            buyer.selectState=NO;
                            
                        }
                        
                        for (int j=0; j<buyer.shop.count; j++) {
                            
                            ShopModel *product = buyer.shop[j];
                            
                            if (product.selectState) {
                                
                                //修改处
                                product.selectState=NO;
                                
                                NSLog(@"===product.name===%@",product.name);
                                
                            }
                            
                        }
                    }
                    
                    //刷新数据源
                   // [_myTableView reloadData];
                     [self getDatas];
                    
                }else if ([dict[@"status"] isEqualToString:@"10002"]){
                    
                    
                    //                    [_StoreArrM removeAllObjects];
                    //                    [_FailureArrM removeAllObjects];
                    //
                    //
                    //
                    //清除属性
                    
                    [UserMessageManager removeAllGoodsAttribute];
                    [UserMessageManager removeAllImageSecect];
                    //
                    //
                    //创建导航栏
                    [self initNav];
                    
                    //创建底部结算视图
                    [self initTabbar];
                    
                    editButton.selected = NO;
                    
                    
                    priceLabel.hidden = NO;
                    yunfeiLabel.hidden = NO;
                    dibuDelete.hidden=YES;
                    JieSuan.hidden=NO;
                    dibuDelete.enabled=NO;
                    //
                    //                    [self initTableView];
                    //
                    //
                    //
                    //                    [self getDatas];
                    
                    
                    for (int i =0; i<_StoreArrM.count-1; i++) {
                        
                        StoreModel *buyer = _StoreArrM[i];
                        
                        if (buyer.selectState) {
                            
                            buyer.selectState=NO;
                            
                        }
                        
                        for (int j=0; j<buyer.shop.count; j++) {
                            
                            ShopModel *product = buyer.shop[j];
                            
                            if (product.selectState) {
                                
                                //修改处
                                product.selectState=NO;
                                
                                NSLog(@"===product.name===%@==%@",product.name,product.number);
                                
                            }
                            
                        }
                    }
                    
                     [self getDatas];
                   // [_myTableView reloadData];
                    
                }
                
                
            }
            
            
        }else{
            
            
            NSLog(@"error");
            
        }
        
        
    }];



}


/**
 *  当键盘出现时滑动tableView
 *
 *  @param textField 当前编辑的field
 */
- (void)tableViewScroll:(UITextField *)textField SidWithString:(NSString *)sid DetailWithString:(NSString *)detailId Goods_Type:(NSString *)goods_type{
    
    //处于编辑状态cell不可点击
    CartAttributeCell *cell = (CartAttributeCell *)[textField superview];
    
    //   cell.selected=NO;
    
    NSNull *null = [[NSNull alloc] init];
    
    
    NSLog(@"==111==detailId===%@===self.BackBack===%@===goods_type==%@",detailId,self.BackBack,goods_type);
    
    if ([detailId isEqual:null]) {
        
        detailId = @"0";
        
    }
    
    
    if ([self.BackBack isEqual:null]) {
        
        self.BackBack = @"0";
        
    }
    
    //无属性商品detailId直接给0
    
    if ([goods_type isEqualToString:@"2"]) {
        
        
        if ([detailId integerValue] != [self.BackBack integerValue]){
            
            if (self.BackBack.length==0) {
                
                detailId = detailId;
                
            }else{
                
                detailId = self.BackBack;
            }
            
        }
        
    }else{
        
        detailId = @"0";
        
    }
    
    
    
    NSLog(@"==textField.text===%@=",textField.text);
    
    
    self.YTNumber = [NSString stringWithFormat:@"%@,%@,%@",sid,textField.text,detailId];
    
    
    NSLog(@"===self.YTNumber===%@",self.YTNumber);
    
    [_SubmitArrM addObject:self.YTNumber];
    
    
    [_SubmieAlldArrM addObject:self.YTNumber];
    
    //每次修改商品数量，就修改数据源商品件数
    for (int i = 0; i < _StoreArrM.count-1; i++) {
        
        StoreModel *shopModel = _StoreArrM[i];
        //取消段头编辑按钮的选中状态
        for (int j = 0; j < shopModel.shop.count; j++) {
            ShopModel *detailModel = shopModel.shop[j];
            
            if (detailModel.sid ==sid) {
                
                detailModel.number=textField.text;
                
                detailModel.EditChangeString = self.YTNumber;
                
            }
        }
    }
    
}

//键盘不掉直接点击完成
-(void)tableViewChangeNumber:(UITextField *)textField Sid:(NSString *)sid Number:(NSString *)number DetailId:(NSString *)detailId Goods_Type:(NSString *)goods_type
{
    
    //处于编辑状态cell不可点击
    CartAttributeCell *cell = (CartAttributeCell *)[textField superview];
    
    //   cell.selected=NO;
    
    NSNull *null = [[NSNull alloc] init];
    
    
    NSLog(@"==222==detailId===%@===self.BackBack===%@===goods_type==%@",detailId,self.BackBack,goods_type);
    
    if ([detailId isEqual:null]) {
        
        detailId = @"0";
        
    }
    
    if ([self.BackBack isEqual:null]) {
        
        self.BackBack = @"0";
        
    }
    
    //无属性商品detailId直接给0
    
    if ([goods_type isEqualToString:@"2"]) {
        
        
        if ([detailId integerValue] != [self.BackBack integerValue]){
            
            if (self.BackBack.length==0) {
                
                detailId = detailId;
                
            }else{
                
                detailId = self.BackBack;
            }
            
        }
        
    }else{
        
        detailId = @"0";
        
    }
    
    
    NSLog(@"==number===%@=",number);
    
    
    self.YTNumber = [NSString stringWithFormat:@"%@,%@,%@",sid,number,detailId];
    
    
    NSLog(@"===键盘不掉self.YTNumber===%@",self.YTNumber);
    
    [_SubmitArrM addObject:self.YTNumber];
    
    
    [_SubmieAlldArrM addObject:self.YTNumber];
    
    //每次修改商品数量，就修改数据源商品件数
    for (int i = 0; i < _StoreArrM.count-1; i++) {
        
        StoreModel *shopModel = _StoreArrM[i];
        //取消段头编辑按钮的选中状态
        for (int j = 0; j < shopModel.shop.count; j++) {
            ShopModel *detailModel = shopModel.shop[j];
            
            if (detailModel.sid ==sid) {
                
                detailModel.number=number;
                
                detailModel.EditChangeString = self.YTNumber;
                
            }
        }
    }
}


//获取属性数据
-(void)getGoodsAttributeDatas
{
    
    
    [TitleArrM1 removeAllObjects];
    [ColorArrM2 removeAllObjects];
    [SizeArrM3 removeAllObjects];
    [BuLiaoArrM4 removeAllObjects];
    [StyleArrM5 removeAllObjects];
    
    
    
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
            
            
            
            NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];
            
            
            NSDictionary *dic2 = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            
            //            NSLog(@"=//获取属性数据==%@",dic2);
            //
            //            NSLog(@"#########==%@",dic2[@"totalStock"]);
            
            
            if ([dic2[@"status"] isEqualToString:@"10000"]) {
                
                for (NSDictionary *dict in dic2[@"list"]) {
                    
                    
                    //                    NSLog(@"=====bigName===%@",dict[@"bigName"]);
                    
                    //添加标题
                    [TitleArrM1 addObject:dict[@"bigName"]];
                    
                    if ([dict[@"bigKey"] isEqualToString:@"a"]) {
                        
                        
                        for (NSDictionary *dict1 in dict[@"smallClassList"]) {
                            
                            ///                            NSLog(@"==1====smallName==%@",dict1[@"smallName"]);
                            
                            GoodsAttributeModel *model=[[GoodsAttributeModel alloc] init];
                            
                            model.smallName=dict1[@"smallName"];
                            model.mallId=dict1[@"smallId"];
                            
                            [ColorArrM2 addObject:model];
                            
                            
                        }
                    }else if([dict[@"bigKey"] isEqualToString:@"b"]){
                        
                        
                        for (NSDictionary *dict1 in dict[@"smallClassList"]) {
                            
                            //                            NSLog(@">>>2>>>>smallName>>%@",dict1[@"smallName"]);
                            
                            GoodsAttributeModel *model=[[GoodsAttributeModel alloc] init];
                            
                            model.smallName=dict1[@"smallName"];
                            model.mallId=dict1[@"smallId"];
                            
                            [SizeArrM3 addObject:model];
                        }
                    }else if([dict[@"bigKey"] isEqualToString:@"c"]){
                        
                        
                        for (NSDictionary *dict1 in dict[@"smallClassList"]) {
                            
                            //                            NSLog(@">>>>3>>>smallName>>%@",dict1[@"smallName"]);
                            
                            GoodsAttributeModel *model=[[GoodsAttributeModel alloc] init];
                            
                            model.smallName=dict1[@"smallName"];
                            model.mallId=dict1[@"smallId"];
                            
                            [BuLiaoArrM4 addObject:model];
                            
                        }
                    }else if([dict[@"bigKey"] isEqualToString:@"d"]){
                        
                        
                        for (NSDictionary *dict1 in dict[@"smallClassList"]) {
                            
                            //                            NSLog(@">>>>>4>>smallName>>%@",dict1[@"smallName"]);
                            
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
                
                
                //弹出属性框
                [self initview];
                [goodsMainview show];
                
            }
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        
        NSLog(@"%@",error);
    }];
}


//反向代理
-(void)ChangeAttributeDelegateClick:(NSString *)detailId andSid:(NSString *)sid andTf:(NSString *)tf andStock:(NSString *)stock andTitle:(NSString *)title andYYYYY:(NSString *)yyyyy andSmallId:(NSString *)smalls
{
    
    NSLog(@"1111反向代理==%@====%@===%@==title==%@==smalls==%@",detailId,sid,tf,title,smalls);
    
    self.BackBack = detailId;
    
    if ([stock intValue] < [tf intValue]) {
        
        tf = stock;
    }
    
    self.AttributeString = [NSString stringWithFormat:@"%@,%@,%@",sid,tf,detailId];
    
    
    NSLog(@"===self.AttributeString===%@",self.AttributeString);
    
    
    [_SubmitArrM addObject:self.AttributeString];
    
    [_SubmieAlldArrM addObject:self.AttributeString];
    
    
    NSArray *array = [title componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"''+ "]];
    
    
    NSMutableArray *arrM = [NSMutableArray new];
    
    for (NSString *str in array) {
        
        
        if (![str isEqualToString:@""]) {
            
            [arrM addObject:str];
            
        }
    }
    
    NSString *str = [arrM componentsJoinedByString:@","];
    
    NSArray *array1 = [str componentsSeparatedByString:@","];
    
    
    NSArray *array3 = [yyyyy componentsSeparatedByString:@" "];
    
    
    //判断回显修改的属性值
    
    if (array3.count==1) {
        
        
        _TitleString = [NSString stringWithFormat:@"%@：%@",array3[0],array1[1]];
        
    }else if (array3.count==2){
        
        
        
        _TitleString = [NSString stringWithFormat:@"%@：%@ %@：%@",array3[0],array1[1],array3[1],array1[2]];
        
    }else if (array3.count==3){
        
        
        _TitleString = [NSString stringWithFormat:@"%@：%@ %@：%@ %@：%@",array3[0],array1[1],array3[1],array1[2],array3[2],array1[3]];
        
        
    }else if (array3.count==4){
        
        
        _TitleString = [NSString stringWithFormat:@"%@：%@ %@：%@ %@：%@ %@：%@",array3[0],array1[1],array3[1],array1[2],array3[2],array1[3],array3[3],array1[4]];
        
    }
    
    
    //每次修改商品数量，就修改数据源商品件数
    for (int i = 0; i < _StoreArrM.count-1; i++) {
        
        StoreModel *shopModel = _StoreArrM[i];
        //取消段头编辑按钮的选中状态
        for (int j = 0; j < shopModel.shop.count; j++) {
            ShopModel *detailModel = shopModel.shop[j];
            
            if (detailModel.sid ==sid) {
                
                detailModel.number=tf;
                detailModel.detailId=detailId;
                detailModel.attribute_str = _TitleString;
                detailModel.smallIds = smalls;
                detailModel.EditChangeAttribute = self.AttributeString;
                
            }
        }
    }

    
}
-(void)initview{
    
    //    self.view.backgroundColor = [UIColor blackColor];
    
    //    NSLog(@"ppppppppppppp==%@",self.gid);
    //清空先前缓存
    [UserMessageManager removeAllGoodsAttribute];
    
    
    goodsMainview = [[GoodsDetailMainView alloc] initWithFrame:self.view.bounds];
    
    goodsMainview.vc = self;
    [self.view addSubview:goodsMainview];
    goodsMainview.goodsDetail.delegate = self;
    goodsMainview.delegate=self;
    
    [goodsMainview initChoseViewSizeArr:sizearr andColorArr:colorarr andArr3:BuLiaoarr3 andArr4:Stylearr4 andArr5:Titlearr5 andStockDic:@{} andGoodsImageView:self.ImageString andMoney:self.MoneyString andJIFen:self.IntergelString andKuCun:self.StockString andGid:self.gid andcount:self.count andGoods_type:self.good_type andGoods_status:self.status andback:@"" andYTBack:@"300" andMid:@"" andYYYY:@"666" andSmallIds:self.smallIds andStorename:@"" andLogo:@"" andSendWayType:@"" andMoneyType:@"" andSid:self.sid andTf:self.tf andCut:@"100" andJinDu:self.jindu andWeiDu:self.weidu andAddressString:self.MapStartAddress andNewHomeString:@""];
    
    
    self.tabBarController.tabBar.hidden=YES;
    
}

/**
 *  选择商品规格点击事件
 *
 *  @param detailView 响应View
 */
- (void)changeShopDetail:(UIView *)detailView Img:(NSString *)img Gid:(NSString *)gid Count:(NSString *)count Stock:(NSString *)stock Money:(NSString *)money Integer:(NSString *)integer GoodType:(NSString *)goods_type Status:(NSString *)status SmallIds:(NSString *)smallIds Sid:(NSString *)sid TF:(NSString *)tf{
    
    self.sid = sid;
    self.tf = tf;
    self.ImageString = img;//商品图片
    self.gid = gid;
    self.count = count;
    self.StockString = stock;
    self.MoneyString = money;
    self.IntergelString = integer;
    self.good_type = goods_type;
    self.status = status;
    self.smallIds = smallIds;
    
    
    CartAttributeCell *cell = (CartAttributeCell *)[detailView superview];
    NSIndexPath *indexPath = [_myTableView indexPathForCell:cell];
    StoreModel *bigModel = _StoreArrM[indexPath.section];
    ShopModel *detailModel = bigModel.shop[indexPath.row];
    _speIndexPath = indexPath;
    
    
    NSLog(@"=====选择商品规格点击事件====%@===",self.smallIds);
    
    [self getGoodsAttributeDatas];
    
    
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

@end




