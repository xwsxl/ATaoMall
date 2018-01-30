//
//  NewLookAllViewController.m
//  aTaohMall
//
//  Created by JMSHT on 2017/4/11.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "NewLookAllViewController.h"

#import "loadMoreCell.h"

#import "LookAllCell.h"

#import "AFNetworking.h"

#import "ConverUtil.h"
#import "DESUtil.h"
#import "SecretCodeTool.h"

#import "WKProgressHUD.h"

#import "goodListModel.h"

#import "UIImageView+WebCache.h"

#import "NewGoodsDetailViewController.h"//商品详情

#import "NoDataCell.h"

//刷新
#import "DJRefresh.h"
#import "DJRefreshProgressView.h"

#import "HomeLookFooter.h"//点击加载更多

#import "UserMessageManager.h"//缓存数据

#import "NewLookAllCell.h"

#import "YTGoodsDetailViewController.h"

#import "MGMineMenuVc.h"

#import "NoMoreDataCell.h"
#import "JDSelectAnctionViewController.h"//筛选动画

#import "XLShoppingCollectionCell.h"
#import "AllSingleShoppingModel.h"
#import "XLLookAllCollectionCell.h"

#define Weight [UIScreen mainScreen].bounds.size.width/4

#define kMGLeftSpace 100



//是否ios7以上系统



#define kIsIOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >=7.0)

//ios7以上视图中包含状态栏预留的高度
#define kHeightInViewForStatus (kIsIOS7?20:0)
//状态条占的高度
#define kHeightForStatus (kIsIOS7?0:20)
//导航栏高度
#define kNavBarHeight (kIsIOS7?64:44)

@interface NewLookAllViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
{

    UIImageView *soldImgView;
    UILabel *soldLabel;
    UILabel *newLabel;
    UIImageView *newImgView;
    UILabel *priceLabel;
    UIImageView *priceLabelImgView;
    UIImageView *priceselectImgView;
    UILabel *selectLabel;
    UIImageView *selectLabelImgView;
    UIImageView *selectImgView;
    UIButton *priceButton;

    UICollectionView *_collectionView;

    NSMutableArray *_datas;

    HomeLookFooter *footer;

    
    int page;
    int currentPageNo;

    NSMutableArray *_typeArrM;



    NSString *string10;

    UIView *view;

    UIImageView *imgView;
    UILabel *NoLabel;

    UIView *titleView;
    UIView *selectView;
    UIImageView *line;

    NSInteger totalCount;

    BOOL IsShowGongGe;

}

@property (nonatomic,strong)DJRefresh *refresh;
@property(nonatomic,strong)UILabel *lable;//暂无数据

@property (nonatomic, strong) UIWindow *window;
@property (nonatomic, weak) UIView *upView;

@end

@implementation NewLookAllViewController
static NSString * const reuseIdentifier = @"XLShoppingCollectionCell";
static NSString * const reuseIdentifier1 = @"XLLookAllCollectionCell";

/*******************************************************      控制器生命周期       ******************************************************/

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;

    self.automaticallyAdjustsScrollViewInsets=NO;

    _datas=[NSMutableArray new];

    [self initNav];

    [self initSelectView];

    [self initCollectionView];


    //缓存用户sigen
    [UserMessageManager ClassifyId:self.gid];

    self.type=@"1";

    self.PanDuan=@"0";

    self.minimumPrice = @"";

    self.maximumPrice = @"";

    self.storeType = @"";

    _typeArrM=[NSMutableArray new];
    [_typeArrM addObject:self.type];


    page=0;
    currentPageNo=1;


    //获取数据
    [self getDatas];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(MGMine:) name:@"MGMine" object:nil];


}

/*******************************************************      数据请求       ******************************************************/


//上拉加载更多
-(void)loadMoreData
{
    if (totalCount==_datas.count) {
        [_collectionView.mj_footer endRefreshingWithNoMoreData];
    }else
    {
        page+=1;
        [self getDatas];
    }
}
//下拉刷新数据
-(void)refreshData
{
    page=0;
    [self getDatas];
}



-(void)getDatas
{
    //先清空数据源
    WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];

    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    NSString *url = [NSString stringWithFormat:@"%@getClassificationWhole_mob.shtml",URL_Str];

    NSDictionary *dic = @{@"classId":self.gid,@"type":self.type,@"page":[NSString stringWithFormat:@"%d",page],@"minimumPrice":self.minimumPrice,@"maximumPrice":self.maximumPrice,@"storeType":self.storeType};


    [manager POST:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
        NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];

        if (page==0) {
            [_datas removeAllObjects];
        }
        [_collectionView.mj_header endRefreshing];
        [_collectionView.mj_footer endRefreshing];

        if (codeKey && content) {
            NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];

            //            NSLog(@"xmlStr%@",xmlStr);


            NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];

            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];



            view.hidden=YES;

            for (NSDictionary *dict in dic) {
                totalCount=[dict[@"totalCount"] integerValue];

                for (NSDictionary *dict1 in dict[@"resultList"]) {



                    AllSingleShoppingModel *model=[[AllSingleShoppingModel alloc] init];

                    model.ID=[NSString stringWithFormat:@"%@",dict1[@"id"]];

                    model.mid=[NSString stringWithFormat:@"%@",dict1[@"mid"]];
                    model.amount=[NSString stringWithFormat:@"%@",dict1[@"amount"]];

                    model.syadate=[NSString stringWithFormat:@"%@",dict1[@"syadate"]];

                    model.is_attribute=[NSString stringWithFormat:@"%@",dict1[@"is_attribute"]];

                    model.storename=[NSString stringWithFormat:@"%@",dict1[@"storename"]];



                    model.gid=[NSString stringWithFormat:@"%@",dict1[@"id"]];

                    model.pay_integer=[NSString stringWithFormat:@"%@",dict1[@"pay_integer"]];

                    model.pay_maney=[NSString stringWithFormat:@"%@",dict1[@"pay_maney"]];

                    model.scopeimg=[NSString stringWithFormat:@"%@",dict1[@"scopeimg"]];



                    model.name=[NSString stringWithFormat:@"%@",dict1[@"name"]];


                    [_datas addObject:model];

                }
            }
            [hud dismiss:YES];

            [_collectionView reloadData];

        }


    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [hud dismiss:YES];
        [_collectionView.mj_header endRefreshing];
        [_collectionView.mj_footer endRefreshing];
        [self NoWebSeveice];
        NSLog(@"%@",error);
    }];
}

/*******************************************************      初始化视图       ******************************************************/
//创建导航栏
-(void)initNav
{
    titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, KSafeAreaTopNaviHeight)];

    titleView.backgroundColor = [UIColor whiteColor];

    [self.view addSubview:titleView];

    line = [[UIImageView alloc] initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight-1, [UIScreen mainScreen].bounds.size.width, 1)];

    line.image = [UIImage imageNamed:@"分割线-拷贝"];

    [titleView addSubview:line];


    //返回按钮

    UIButton *Qurt = [UIButton buttonWithType:UIButtonTypeCustom];

    Qurt.frame = CGRectMake(10, 25+KSafeTopHeight, 30, 30);

    [Qurt setImage:[UIImage imageNamed:@"iconfont-fanhui2yt"] forState:0];


    [Qurt addTarget:self action:@selector(QurtBtnClick) forControlEvents:UIControlEventTouchUpInside];

    [titleView addSubview:Qurt];

    //创建搜索

    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 25+KSafeTopHeight, [UIScreen mainScreen].bounds.size.width-200, 30)];

    label.text = self.titleName;

    label.textColor = [UIColor blackColor];

    label.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:19];

    label.textAlignment = NSTextAlignmentCenter;

    [titleView addSubview:label];

    UIButton *rightBut=[UIButton buttonWithType:UIButtonTypeCustom];
    rightBut.frame=CGRectMake(kScreenWidth-15-17, KSafeAreaTopNaviHeight-10-17, 17, 17);
    [rightBut setImage:KImage(@"xl-btn-change2") forState:UIControlStateNormal];
    [rightBut addTarget:self action:@selector(rightButClick:) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:rightBut];

}

-(void)initview{

//
//    imgView = [[UIImageView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-188/2)/2, 100+65+44, 188/2, 197/2)];
//    imgView.image = [UIImage imageNamed:@"没有找到相关商品"];
//
//    [self.view addSubview:imgView];
//
//
//    NoLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 100+65+44+197/2+39, [UIScreen mainScreen].bounds.size.width-60, 20)];
//    NoLabel.text = @"抱歉，没有找到相关商品~";
//    NoLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
//    NoLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:18];
//    NoLabel.textAlignment = NSTextAlignmentCenter;
//    [self.view addSubview:NoLabel];
}

-(void)QurtBtnClick
{
    [UserMessageManager FenLeiRemove];

    [self.navigationController popViewControllerAnimated:YES];


    self.tabBarController.tabBar.hidden=NO;

}
//热销
-(void)soldBtnClick
{
    priceButton.selected=NO;
    soldImgView.image = [UIImage imageNamed:@"下划线new"];
    newImgView.image = [UIImage imageNamed:@""];
    priceLabelImgView.image = [UIImage imageNamed:@""];
    priceselectImgView.image = [UIImage imageNamed:@"升降序"];
    //    selectLabelImgView.image = [UIImage imageNamed:@""];
    //    selectImgView.image = [UIImage imageNamed:@"筛选"];
    soldLabel.textColor=[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
    newLabel.textColor=[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    priceLabel.textColor=[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    //    selectLabel.textColor=[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];


    self.type=@"1";
    self.PanDuan=@"0";
    //    self.minimumPrice = @"";
    //    self.maximumPrice = @"";
    //    self.storeType = @"";

    page=0;
    currentPageNo=1;


    //    [_datas removeAllObjects];

    _collectionView.frame =CGRectMake(0, KSafeAreaTopNaviHeight+44, self.view.bounds.size.width, self.view.bounds.size.height-KSafeAreaTopNaviHeight-44);

    //获取数据
    [self getDatas];


}
//最新
-(void)newBtnClick
{
    //    [_datas removeAllObjects];




    priceButton.selected=NO;
    soldImgView.image = [UIImage imageNamed:@""];
    newImgView.image = [UIImage imageNamed:@"下划线new"];
    priceLabelImgView.image = [UIImage imageNamed:@""];
    priceselectImgView.image = [UIImage imageNamed:@"升降序"];
    //    selectLabelImgView.image = [UIImage imageNamed:@""];
    //    selectImgView.image = [UIImage imageNamed:@"筛选"];
    soldLabel.textColor=[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    newLabel.textColor=[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
    priceLabel.textColor=[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    //    selectLabel.textColor=[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];

    self.type=@"5";
    self.PanDuan=@"0";
    //    self.minimumPrice = @"";
    //    self.maximumPrice = @"";
    //    self.storeType = @"";

    page=0;
    currentPageNo=1;

    //    [_datas removeAllObjects];
    _collectionView.frame =CGRectMake(0, KSafeAreaTopNaviHeight+44, self.view.bounds.size.width, self.view.bounds.size.height-KSafeAreaTopNaviHeight-44);

    //获取数据
    [self getDatas];

}
//价格
-(void)priceBtnClick:(UIButton *)sender
{
    sender.selected=!sender.selected;

    soldImgView.image = [UIImage imageNamed:@""];
    newImgView.image = [UIImage imageNamed:@""];
    priceLabelImgView.image = [UIImage imageNamed:@"下划线new"];

    if (sender.selected) {

        priceselectImgView.image = [UIImage imageNamed:@"xl-icon-price"];

        self.type=@"4";
        self.PanDuan=@"0";
        //        self.minimumPrice = @"";
        //        self.maximumPrice = @"";
        //        self.storeType = @"";

        page=0;
        currentPageNo=1;

        //        [_datas removeAllObjects];

        _collectionView.frame =CGRectMake(0, KSafeAreaTopNaviHeight+44, self.view.bounds.size.width, self.view.bounds.size.height-KSafeAreaTopNaviHeight-44);

        //获取数据
        [self getDatas];


    }else{

        priceselectImgView.image = [UIImage imageNamed:@"xl-icon-price down"];


        self.type=@"3";
        self.PanDuan=@"0";
        //        self.minimumPrice = @"";
        //        self.maximumPrice = @"";
        //        self.storeType = @"";

        page=0;
        currentPageNo=1;

        //        [_datas removeAllObjects];

        _collectionView.frame =CGRectMake(0, KSafeAreaTopNaviHeight+44, self.view.bounds.size.width, self.view.bounds.size.height-KSafeAreaTopNaviHeight-44);

        //获取数据
        [self getDatas];

    }


    //    selectLabelImgView.image = [UIImage imageNamed:@""];
    //    selectImgView.image = [UIImage imageNamed:@"筛选"];
    soldLabel.textColor=[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    newLabel.textColor=[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    priceLabel.textColor=[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
    //    selectLabel.textColor=[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];

}
//刷选
-(void)selectBtnClick
{
    //    priceButton.selected=NO;
    //    soldImgView.image = [UIImage imageNamed:@""];
    //    newImgView.image = [UIImage imageNamed:@""];
    //    priceLabelImgView.image = [UIImage imageNamed:@""];
    //    priceselectImgView.image = [UIImage imageNamed:@"升降序"];
    selectLabelImgView.image = [UIImage imageNamed:@""];
    selectImgView.image = [UIImage imageNamed:@"xl-icon-choose"];
    //    soldLabel.textColor=[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    //    newLabel.textColor=[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    //    priceLabel.textColor=[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    selectLabel.textColor=[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];


    //    UIWindow *window = [[UIWindow alloc] initWithFrame:CGRectMake(50, 0, kScreenWidth-50, kScreenHeight)];


    JDSelectAnctionViewController * testVC = [[JDSelectAnctionViewController alloc] init];
    //这两句必须有
    self.definesPresentationContext = YES; //self is presenting view controller
    testVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    /** 设置半透明度 */
    testVC.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.74];

    [self presentViewController:testVC animated:NO completion:nil];





}

//创建选择框
-(void)initSelectView
{
    selectView = [[UIView alloc] initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight, [UIScreen mainScreen].bounds.size.width, 44)];

    [self.view addSubview:selectView];

    UIImageView *line1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 43, [UIScreen mainScreen].bounds.size.width, 1)];

    line1.image = [UIImage imageNamed:@"分割线-拷贝"];

    [selectView addSubview:line1];

    UIView *sold =[[UIView alloc] initWithFrame:CGRectMake(0, 0, Weight, 44)];
    //    sold.backgroundColor = [UIColor redColor];
    soldLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 12, Weight, 20)];
    soldLabel.text =@"销量";
    soldLabel.textAlignment=NSTextAlignmentCenter;
    soldLabel.textColor=[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
    soldLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:14];
    [sold addSubview:soldLabel];

    soldImgView = [[UIImageView alloc] initWithFrame:CGRectMake((Weight-50)/2, 42, 50, 2)];
    soldImgView.image = [UIImage imageNamed:@"下划线new"];
    [sold addSubview:soldImgView];

    UIButton *soldButton = [UIButton buttonWithType:UIButtonTypeCustom];
    soldButton.frame = CGRectMake(0, 0, Weight, 44);
    [soldButton addTarget:self action:@selector(soldBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [sold addSubview:soldButton];

    [selectView addSubview:sold];

    UIView *new =[[UIView alloc] initWithFrame:CGRectMake(Weight, 0, Weight, 44)];
    //    new.backgroundColor = [UIColor orangeColor];
    newLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 12, Weight, 20)];
    newLabel.text =@"最新";
    newLabel.textAlignment=NSTextAlignmentCenter;
    newLabel.textColor=[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    newLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:14];
    [new addSubview:newLabel];

    newImgView = [[UIImageView alloc] initWithFrame:CGRectMake((Weight-50)/2, 42, 50, 2)];
    newImgView.image = [UIImage imageNamed:@""];
    [new addSubview:newImgView];

    UIButton *newButton = [UIButton buttonWithType:UIButtonTypeCustom];
    newButton.frame = CGRectMake(0, 0, Weight, 44);
    [newButton addTarget:self action:@selector(newBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [new addSubview:newButton];

    [selectView addSubview:new];

    UIView *price =[[UIView alloc] initWithFrame:CGRectMake(Weight*2, 0, Weight, 44)];

    //    price.backgroundColor = [UIColor yellowColor];

    priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 12, Weight, 20)];
    priceLabel.text =@"价格";
    priceLabel.textAlignment=NSTextAlignmentCenter;
    priceLabel.textColor=[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    priceLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:14];
    [price addSubview:priceLabel];

    priceLabelImgView = [[UIImageView alloc] initWithFrame:CGRectMake((Weight-50)/2+5, 42, 50, 2)];
    priceLabelImgView.image = [UIImage imageNamed:@""];
    [price addSubview:priceLabelImgView];

    priceselectImgView = [[UIImageView alloc] initWithFrame:CGRectMake((Weight-50)/2+45, 18.5, 7, 10)];
    priceselectImgView.image = [UIImage imageNamed:@"升降序"];
    [price addSubview:priceselectImgView];

    priceButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //    priceButton.selected=NO;
    priceButton.frame = CGRectMake(0, 0, Weight, 44);
    [priceButton addTarget:self action:@selector(priceBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [price addSubview:priceButton];


    [selectView addSubview:price];

    UIView *select =[[UIView alloc] initWithFrame:CGRectMake(Weight*3, 0, Weight, 44)];
    //    select.backgroundColor = [UIColor blueColor];

    selectLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 12, Weight, 20)];
    selectLabel.text =@"筛选";
    selectLabel.textAlignment=NSTextAlignmentCenter;
    selectLabel.textColor=[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    selectLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:14];
    [select addSubview:selectLabel];

    selectLabelImgView = [[UIImageView alloc] initWithFrame:CGRectMake((Weight-50)/2+5, 42, 50, 2)];
    selectLabelImgView.image = [UIImage imageNamed:@""];
    [select addSubview:selectLabelImgView];

    selectImgView = [[UIImageView alloc] initWithFrame:CGRectMake((Weight-50)/2+45, (44-14)/2+2, 28/2, 28/2)];
    selectImgView.image = [UIImage imageNamed:@"筛选"];
    [select addSubview:selectImgView];


    UIButton *selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
    selectButton.frame = CGRectMake(0, 0, Weight, 44);
    [selectButton addTarget:self action:@selector(selectBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [select addSubview:selectButton];

    [selectView addSubview:select];

}


//
-(void)initCollectionView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight+44, kScreen_Width, kScreen_Height-KSafeAreaTopNaviHeight-44) collectionViewLayout:flowLayout];
    _collectionView.backgroundColor=[UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1.0];
    //去掉右侧滚动条
    _collectionView.showsVerticalScrollIndicator=NO;
    _collectionView.delegate=self;
    _collectionView.dataSource=self;
    [_collectionView registerClass:[XLShoppingCollectionCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [_collectionView registerClass:[XLLookAllCollectionCell class] forCellWithReuseIdentifier:reuseIdentifier1];
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    [footer setTitle:@"" forState:MJRefreshStateIdle];
    [footer setTitle:@"正在加载..." forState:MJRefreshStateRefreshing];
    [footer setTitle:@"暂无更多数据" forState:MJRefreshStateNoMoreData];
    _collectionView.mj_footer = footer;

    MJRefreshGifHeader *header=[MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    NSMutableArray *idleImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=60; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_anim__000%zd", i]];
        [idleImages addObject:image];
    }
    [header setImages:idleImages forState:MJRefreshStateIdle];

    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=3; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_loading_0%zd", i]];
        [refreshingImages addObject:image];
    }
    [header setImages:refreshingImages forState:MJRefreshStatePulling];

    // 设置正在刷新状态的动画图片
    [header setImages:refreshingImages forState:MJRefreshStateRefreshing];

    _collectionView.mj_header=header;
    [self.view addSubview:_collectionView];
    
}
/*******************************************************      各种button执行方法、页面间的跳转       ******************************************************/
//切换顶部
-(void)rightButClick:(UIButton *)sender
{
    IsShowGongGe=!IsShowGongGe;
    [_collectionView reloadData];
}

/*******************************************************      协议方法       ******************************************************/
#pragma mark - collectionView的代理方法
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _datas.count;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (!IsShowGongGe) {
        return CGSizeMake(kScreenWidth, Width(145));
    }else
    {
    CGFloat WWW=([UIScreen mainScreen].bounds.size.width-Width(18))/2;
    CGFloat HHH=WWW+5*Height(7)+39+26+1+10;
    return CGSizeMake(WWW, HHH);
    }

}

//最小行间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    if (!IsShowGongGe) {
        return 0;
    }else
    {
    return Width(6);
    }
}
//最小行内部cell的间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    if (!IsShowGongGe) {
        return 0;
    }else
    {
    return Width(3);
    }
}

//section的边距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{

    if (!IsShowGongGe) {
        return UIEdgeInsetsMake(Width(10), 0, 0, 0  );
    }
    //上,左,下,右
    else{
    return UIEdgeInsetsMake(Width(10), Width(6), Width(6), Width(6));
}
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (!IsShowGongGe) {
        XLLookAllCollectionCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier1 forIndexPath:indexPath];
        cell.model=_datas[indexPath.row];
        return cell;
    }else
    {
    XLShoppingCollectionCell *cell1=[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    AllSingleShoppingModel *model=_datas[indexPath.row];

    [cell1 SetDataWithImgUrl:model.scopeimg GoodsName:model.name StoreName:model.storename priceStr:model.pay_maney Interger:model.pay_integer stock:@"1"];
    return cell1;
    }
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    AllSingleShoppingModel *model=_datas[indexPath.row];

    YTGoodsDetailViewController *vc=[[YTGoodsDetailViewController alloc] init];
    vc.good_type=model.type_name;
    vc.gid=model.gid;
    vc.type=@"1";
    vc.attribute = model.is_attribute;
    vc.ID=model.ID;
    [self.navigationController pushViewController:vc animated:NO];

}





#pragma -mark
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //scrollView已经有拖拽手势，直接拿到scrollView的拖拽手势
    UIPanGestureRecognizer *pan = scrollView.panGestureRecognizer;
    //获取到拖拽的速度 >0 向下拖动 <0 向上拖动
    CGFloat velocity = [pan velocityInView:scrollView].y;

    if (velocity <- 50) {
        //向上拖动，隐藏导航栏


        titleView.hidden=YES;
        selectView.hidden=NO;
        line.hidden=YES;
        selectView.frame=CGRectMake(0, 20+KSafeTopHeight, kScreenWidth, 44);

        _collectionView.frame =CGRectMake(0, KSafeAreaTopNaviHeight, self.view.bounds.size.width, self.view.bounds.size.height-KSafeAreaTopNaviHeight);



    }else if (velocity > 50) {
        //向下拖动，显示导航栏
        //        [self.navigationController setNavigationBarHidden:NO animated:YES];

        titleView.hidden=NO;
        selectView.hidden=NO;
        line.hidden=NO;

        selectView.frame=CGRectMake(0, KSafeAreaTopNaviHeight, kScreenWidth, 44);
        _collectionView.frame =CGRectMake(0, KSafeAreaTopNaviHeight+44, self.view.bounds.size.width, self.view.bounds.size.height-KSafeAreaTopNaviHeight-44);



    }else if(velocity == 0){
        //停止拖拽
    }
}

//回显通知
-(void)MGMine:(NSNotification *)text
{
    NSLog(@"==666==store====%@",text.userInfo[@"textFour"]);

    self.PanDuan=@"0";

    self.minimumPrice = text.userInfo[@"textOne"];

    self.maximumPrice = text.userInfo[@"textTwo"];

    self.storeType = text.userInfo[@"textThree"];

    if ([text.userInfo[@"textFour"] isEqualToString:@"111"]) {

        selectLabelImgView.image = [UIImage imageNamed:@""];
        selectImgView.image = [UIImage imageNamed:@"筛选"];
        selectLabel.textColor=[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];


    }else{


        selectLabelImgView.image = [UIImage imageNamed:@""];
        selectImgView.image = [UIImage imageNamed:@"筛选选中"];
        selectLabel.textColor=[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];

    }

    if ([self.storeType isEqualToString:@"2"] || self.storeType.length==0 || [self.storeType isEqualToString:@"3"]) {

        self.storeType = @"";

    }else{

        self.storeType = text.userInfo[@"textThree"];
    }

    if (self.minimumPrice.length==0) {

        self.minimumPrice = @"";

    }else{

        self.minimumPrice = text.userInfo[@"textOne"];
    }


    if (self.maximumPrice.length==0) {

        self.maximumPrice = @"";

    }else{

        self.maximumPrice = text.userInfo[@"textTwo"];
    }
    page=0;
    currentPageNo=1;
    //获取数据
    [self getDatas];

}

/*******************************************************      代码提取(多是复用代码)       ******************************************************/

-(void)NoWebSeveice
{

    view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];

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

@end
