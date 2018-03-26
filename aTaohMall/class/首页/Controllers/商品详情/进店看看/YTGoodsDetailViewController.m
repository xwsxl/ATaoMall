//
//  YTGoodsDetailViewController.m
//  aTaohMall
//
//  Created by JMSHT on 2016/10/9.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import "YTGoodsDetailViewController.h"

#import "YTTuWenViewController.h"
#import "YTDetailViewController.h"
#import "YTGoodsViewController.h"

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

#import "GoodsAttributeModel.h"//属性

#import "ATHLoginViewController.h"

#import "MerchantViewController.h"
#define kScreenBounds ([[UIScreen mainScreen] bounds])
#define kScreenWidth (kScreenBounds.size.width)
#define kScreenHeight (kScreenBounds.size.height)
@interface YTGoodsDetailViewController ()<UIScrollViewDelegate,YTDetailViewControllerDelegate,LoginMessageDelegate,UIGestureRecognizerDelegate>
{
    
    UIView *view;
    
    UIAlertController *alertCon;
    
    YTTuWenViewController *vc2;
    UIView *slider1;
    UIView *slider2;

    UIButton *ShouCangBut;
    
}
@property (nonatomic, strong) UIScrollView *contentScrollView; //!< 作为容器的ScrollView
@property (nonatomic, strong) UIScrollView *titleScrollView; //!< 标题的ScrollView
@property (nonatomic, strong) UIView *allView;

@property (nonatomic, strong) UILabel *label;//标题；
@property (nonatomic, strong) UIView *slider;//选择时的红线；

@property (nonatomic,strong)NSString *ShouCangStr;

@property (nonatomic, strong) UILabel *currentTitleLabel;//当前标题
@property (nonatomic, strong) UILabel *nextTitleLabel;//滑动下一个标题

@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, assign) CGPoint beginOffset; //!<拖拽开始的偏移量

@end

@implementation YTGoodsDetailViewController

-(void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden=YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.view.backgroundColor=[UIColor whiteColor];
    
    //
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    
    //自动偏移
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    _allView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, KSafeAreaTopNaviHeight)];
    
    [self.view addSubview:_allView];

    
    UILabel *label1=[[UILabel alloc] initWithFrame:CGRectMake(80, 25+KSafeTopHeight, ([UIScreen mainScreen].bounds.size.width-160)/2, 30)];
    label1.textAlignment = NSTextAlignmentCenter;
    label1.font=[UIFont systemFontOfSize:20];
//    label1.backgroundColor=[UIColor orangeColor];
    label1.text=@"商品";
    [_allView addSubview:label1];
    
    
    UITapGestureRecognizer *tap1=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shangpinGr:)];
    tap1.delegate=self;
    tap1.numberOfTapsRequired=1;
    
    label1.userInteractionEnabled=YES;
    
    [label1 addGestureRecognizer:tap1];
    
    
    slider1 = [[UIView alloc] initWithFrame:CGRectMake(80+label1.frame.size.width/2-20, KSafeAreaTopNaviHeight-3, 40, 2)];
    slider1.backgroundColor = [UIColor redColor];
    [_allView addSubview:slider1];
    
    
    UILabel *label2=[[UILabel alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-160)/2+80, 25+KSafeTopHeight, ([UIScreen mainScreen].bounds.size.width-160)/2, 30)];
    label2.textAlignment = NSTextAlignmentCenter;
//    label2.backgroundColor=[UIColor greenColor];
    label2.font=[UIFont systemFontOfSize:20];
    label2.text=@"详情";
    [_allView addSubview:label2];
    
    
    UITapGestureRecognizer *tap2=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(xiangqingGr:)];
    tap2.delegate=self;
    tap2.numberOfTapsRequired=1;
    
    label2.userInteractionEnabled=YES;
    
    [label2 addGestureRecognizer:tap2];
    
    
    slider2 = [[UIView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-160)/2+80+label2.frame.size.width/2-20, KSafeAreaTopNaviHeight-3, 40, 2)];
    slider2.backgroundColor = [UIColor whiteColor];
    [_allView addSubview:slider2];
    
    
    UIImageView *fenge=[[UIImageView alloc] initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight-1, [UIScreen mainScreen].bounds.size.width, 1)];
    fenge.image=[UIImage imageNamed:@"分割线-拷贝"];
    
    [self.view addSubview:fenge];
    self.backButton = [UIButton buttonWithType:UIButtonTypeCustom];

    _backButton.frame = CGRectMake(10, 25+KSafeTopHeight, 30, 30);

    //    [Qurt setBackgroundImage:[UIImage imageNamed:@"iconfont-fanhui2yt"] forState:0];

    [_backButton setImage:[UIImage imageNamed:@"iconfont-fanhui2yt"] forState:0];

    [_backButton addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];


    [_allView addSubview:self.backButton];
    ShouCangBut=[UIButton buttonWithType:UIButtonTypeCustom];
    ShouCangBut.frame=CGRectMake(kScreen_Width-15-18-11, 20+KSafeTopHeight, 40, 40);

    [ShouCangBut addTarget:self action:@selector(shouCangBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_allView addSubview:ShouCangBut];
    
    vc2=[[YTTuWenViewController alloc] init];
    vc2.ID=self.gid;
    
    YLog(@"goodtype=%@",self.good_type);
    YTDetailViewController *vc1=[[YTDetailViewController alloc] init];
    vc1.delegate=self;
    vc1.NewHomeString = self.NewHomeString;
    vc1.YXZattribute=self.YXZattribute;
    vc1.delegate=self;
    vc1.gid=self.gid;
    vc1.type=@"2";//判断返回界面
    vc1.attribute = self.attribute ;
    vc1.good_type=self.good_type;
    vc1.TTTTTT = self.TTTTTT;
    vc1.num=self.num;
    vc1.status=self.status;
    vc1.Attribute_back=@"2";
    vc1.JuHuaShow = self.JuHuaShow;
    
//    vc1.CartString = self.CartString;
    
    if ([self.caonima isEqualToString:@"100"]) {
        
        vc1.Panduan = @"2";//判断是否点击确定；
    }
//    vc1.Panduan = @"2";//判断是否点击确定；
    vc1.YXZattribute = self.YXZattribute;
    vc1.exchange =self.exchange;
    
    vc1.detailId = self.detailId;
    vc1.amount = self.amount;
    vc1.good_type=self.good_type;
    vc1.status=self.status;
    vc1.yunfei=self.yunfei;
    vc1.pay_money = self.pay_money;
    vc1.pay_integral = self.pay_integral;
    vc1.Attribute_back = self.Attribute_back;
    //设置背景颜色
    
    [self.view addSubview:self.contentScrollView];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self addChildViewController:vc1];
    [self.contentScrollView addSubview:vc1.view];
 //   [vc1 didMoveToParentViewController:self];
    
    //===================修改处======================
    
//    [self addChildViewController:vc2];
//    [self.contentScrollView addSubview:vc2.view];
//    [vc2 didMoveToParentViewController:self];
    
    //===================修改处======================
    
    CGSize size = self.contentScrollView.bounds.size;
    NSLog(@"%f",size.width);
    vc1.view.frame = CGRectMake(0, 0, size.width, size.height);
    
    //===================修改处======================
//    vc2.view.frame = CGRectMake(size.width, 0, size.width, size.height);
    //===================修改处======================
    
    
    self.contentScrollView.contentSize = CGSizeMake(size.width, size.height);
    
    //===================修改处======================
    
    self.contentScrollView.pagingEnabled = YES;
    self.contentScrollView.bounces=NO;
    
    self.contentScrollView.showsVerticalScrollIndicator=NO;
    
    self.contentScrollView.showsHorizontalScrollIndicator = FALSE;
    

    
    
    
    //===========修改处=====================
    
    /*
    _view1=[[UIView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-49, [UIScreen mainScreen].bounds.size.width, 49)];
    
    _view1.backgroundColor=[UIColor whiteColor];
    
    [self.view addSubview:_view1];
    
    UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(20, 15, 35, 20)];
    label.text=@"小计:";
    label.font=[UIFont systemFontOfSize:14];
    [_view1 addSubview:label];
    
    
//    _view1.hidden=YES;
    
    
    _price=[[UILabel alloc] initWithFrame:CGRectMake(55, 15, _view1.frame.size.width-100-55, 20)];
    _price.textColor=[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
    _price.font=[UIFont systemFontOfSize:15];
    [_view1 addSubview:_price];
    
    
    _button=[UIButton buttonWithType:UIButtonTypeCustom];
    _button.frame=CGRectMake(_view1.frame.size.width-100, 0, 100, 49);
    
    [_button setTitle:@"立即购买" forState:0];
    _button.titleLabel.font=[UIFont systemFontOfSize:16];
    //    button.titleLabel.font=[UIFont fontWithName:@"" size:<#(CGFloat)#>]
    _button.backgroundColor=[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
    [_button setTitleColor:[UIColor whiteColor] forState:0];
    
    [_view1 addSubview:_button];
    
    _price.text=@"￥100.00";
    
    */
    //===========修改处=====================
    
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(xiangzuo) name:@"xiangzuo" object:nil];
    
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(xiangyou) name:@"xiangyou" object:nil];
    
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(BackNotificationEnd) name:@"BackNotificationEnd" object:nil];
    
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(BackNotificationBegin) name:@"BackNotificationBegin" object:nil];
    
    
    //注册通知
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(yingcangNav) name:@"yingcangNav" object:nil];
    
}


-(void)shouCangBtnClick:(UIButton *)sender
{
    ShouCangBut.userInteractionEnabled=NO;
    sender.selected=!sender.selected;
    if (![[kUserDefaults stringForKey:@"sigen"] containsString:@"null"]&&[kUserDefaults stringForKey:@"sigen"].length>0) {

        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];

        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        NSString *url=[NSString stringWithFormat:@"%@updateCollectionGoodsOrShop_mob.shtml",URL_Str];
        YLog(@"self.gid=%@",self.gid);
/*收藏商品参数：sigen：
        is_status：收藏状态：1收藏2取消收藏（这里传1）
        gid：商品ID
        type：类型：1商品2商铺（这里传1）

        取消收藏商品参数：sigen：
        is_status：收藏状态：1收藏2取消收藏（这里传2）
        gid：商品ID
        type：类型：1商品2商铺（这里传1）*/
        if (![_ShouCangStr isEqualToString:@"1"]) {
            NSDictionary *params=@{@"sigen":[kUserDefaults stringForKey:@"sigen"],@"is_status":@"1",@"type":@"1",@"gid":self.gid};
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
            NSDictionary *params=@{@"sigen":[kUserDefaults stringForKey:@"sigen"],@"is_status":@"2",@"type":@"1",@"gid":self.gid};
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

-(void)BackNotificationBegin
{
    
    self.backButton.enabled=NO;
    
}


-(void)BackNotificationEnd
{
    
    self.backButton.enabled=YES;
    
}

//通知商品详情商品失效
-(void)yingcangNav
{
    
    NSLog(@"====77777=====");
    
    UILabel *titleLabe=[[UILabel alloc] initWithFrame:CGRectMake(80, 25, kScreenWidth-160, 40)];
    
    titleLabe.textColor=[UIColor blueColor];
    
    titleLabe.textAlignment=NSTextAlignmentCenter;
    
    titleLabe.font=[UIFont systemFontOfSize:20];
    
    titleLabe.text=@"商品过期不存在";
    
    [_allView addSubview:titleLabe];

}

-(void)shangpinGr:(UITapGestureRecognizer *)Gr
{
    
    NSLog(@"====111=====");
    
    slider1.backgroundColor = [UIColor redColor];
    slider2.backgroundColor = [UIColor whiteColor];
    
    //创建通知
    NSNotification *notification =[NSNotification notificationWithName:@"shangpinGr" object:nil userInfo:nil];
    //通过通知中心发送通知
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    
    
}

-(void)setShouCangString:(NSString *)str
{
    self.ShouCangStr=str;
}

-(void)xiangqingGr:(UITapGestureRecognizer *)Gr
{
    
    NSLog(@"====222=====");
    
    slider2.backgroundColor = [UIColor redColor];
    slider1.backgroundColor = [UIColor whiteColor];
    
    //创建通知
    NSNotification *notification =[NSNotification notificationWithName:@"xiangqingGr" object:nil userInfo:nil];
    //通过通知中心发送通知
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    
}

-(void)xiangzuo
{
    
    slider2.backgroundColor = [UIColor redColor];
    slider1.backgroundColor = [UIColor whiteColor];
}

-(void)xiangyou
{
    
    slider1.backgroundColor = [UIColor redColor];
    slider2.backgroundColor = [UIColor whiteColor];
}

-(void)setGoodsPrice:(NSString *)price setGid:(NSString *)gid setSigen:(NSString *)sigen setStorename:(NSString *)storename setLogo:(NSString *)logo setSendWayType:(NSString *)SendWayType setGoodsType:(NSString *)good_type setMoneyType:(NSString *)MoneyType setmid:(NSString *)mid setYunFei:(NSString *)yunfei setPanduan:(NSString *)panduan setNum:(NSString *)num setexchange:(NSString *)exchange setdetailId:(NSString *)detailId setexchange2:(NSString *)exchange2 setYTString:(NSString *)yt
{
    NSLog(@"======^^^^^^^^^=yunfei=%@=price==%@=",yunfei,price);
    
    vc2.NewPrice=price;
    
    _price.text=price;
    
    self.gid=gid;
    self.sigen=sigen;
    self.storename=storename;
    self.logo=logo;
    self.SendWayType=SendWayType;
    self.good_type=good_type;
    self.MoneyType=MoneyType;
    self.mid=mid;
//    self.yunfei=yunfei;
    self.Panduan=panduan;
    self.num=num;
    self.exchange2=exchange2;
    self.exchange=exchange;
    self.detailId=detailId;
    
    self.ytString=yt;
    
//    [_button addTarget:self action:@selector(YTBuyGoods) forControlEvents:UIControlEventTouchUpInside];
    
    
    
}

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
                
                
                
                if ([self.NotBuy isEqualToString:@"10001"]) {
                    
                    [JRToast showWithText:self.NotBuyMessage duration:3.0f];
                    
                    
                }else if([self.NotBuy isEqualToString:@"10000"]){
                    
                    if ([self.good_type isEqualToString:@"1"] && [self.Good_status isEqualToString:@"0"]) {
                        
                        [JRToast showWithText:@"请等待，限购商品暂未开抢" duration:3.0f];
                        
                        
                    }else if([self.good_type isEqualToString:@"1"] && [self.Good_status isEqualToString:@"7"]) {
                        
                        [JRToast showWithText:@"该商品已结束抢购！" duration:3.0f];
                        
                        
                    }else if([self.good_type isEqualToString:@"1"] && [self.Good_status isEqualToString:@"6"]) {
                        
                        [JRToast showWithText:@"该商品已售完！" duration:3.0f];
                        
                        
                    }else if([self.good_type isEqualToString:@"1"] && [self.Good_status isEqualToString:@"1"]) {
                        
                        [JRToast showWithText:@"该商品已下架！" duration:3.0f];
                        
                        
                    }else if([self.good_type isEqualToString:@"1"] && [self.Good_status isEqualToString:@"5"]) {
                        
                        [JRToast showWithText:@"该商品已删除！" duration:3.0f];
                        
                        
                    }else{
                        
                        if ([self.stock isEqualToString:@"0"]) {
                            
                            [JRToast showWithText:@"库存为0，无法购买" duration:3.0f];
                            
                            
                        }else{
                            
                            QueDingDingDanViewController *vc=[[QueDingDingDanViewController alloc] init];
                            
                            //    NewAddAddressViewController *vc=[[NewAddAddressViewController alloc] init];
                            
                            NSLog(@"yyyyyyyyy==%@",self.yunfei);
                            
                            vc.gid=self.gid;
                            
                            vc.ID=self.ID;
                            
                            vc.sigen=self.sigen;
                            
                            vc.storename=self.storename;
                            
                            vc.logo=self.logo;
                            
                            vc.GoodsDetailType=self.SendWayType;
                            
                            vc.Goods_Type_Switch=self.good_type;
                            
                            
                            YLog(@"%@",self.good_type);
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

-(void)loadData
{
    
    WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
    
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        [hud dismiss:YES];
    });
    
    [self getDatas1];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    self.beginOffset = scrollView.contentOffset;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 求得移动的距离
    CGFloat d = ABS(scrollView.contentOffset.x - self.beginOffset.x);
    
    NSInteger currentIndex = self.beginOffset.x / self.titleScrollView.bounds.size.width;
    
    UILabel *currentTitleLabel = (UILabel *)[self.titleScrollView viewWithTag:currentIndex+100];
    
    UILabel *nextTitleLabel = nil;
    // 往右滚动
    if (scrollView.contentOffset.x > self.beginOffset.x) {
        nextTitleLabel = (UILabel *)[self.titleScrollView viewWithTag:currentIndex+1+100];
    }
    
    // 往左滚动
    if (scrollView.contentOffset.x < self.beginOffset.x) {
        nextTitleLabel = (UILabel *)[self.titleScrollView viewWithTag:currentIndex-1+100];
    }
    
//    CGFloat scale = d / kScreenWidth;
    
//    currentTitleLabel.textColor = [UIColor colorWithRed:1-scale green:0 blue:0 alpha:1.0f];
//    nextTitleLabel.textColor = [UIColor colorWithRed:scale green:0 blue:0 alpha:1.0f];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger currentIndex = scrollView.contentOffset.x / self.titleScrollView.bounds.size.width;
    UILabel *label = (UILabel *)[self.titleScrollView viewWithTag:currentIndex+100];
    
    // 滚动到让指定的rect可见
    [self.titleScrollView scrollRectToVisible:label.frame animated:YES];
    
    UIView *slider = [self.titleScrollView viewWithTag:10001];
    [UIView animateWithDuration:0.25 animations:^{
        slider.center = CGPointMake(label.center.x, slider.center.y);
    } completion:nil];
}


#pragma mark - Event Handlers

- (void)titleDidTap:(UITapGestureRecognizer *)tap
{
    NSInteger index = tap.view.tag - 100;
    
    [self.titleScrollView scrollRectToVisible:tap.view.frame animated:YES];
    [self.contentScrollView setContentOffset:CGPointMake(kScreenWidth, 0) animated:YES];
    
    UIView *slider = [self.titleScrollView viewWithTag:10001];
    [UIView animateWithDuration:0.25 animations:^{
        slider.center = CGPointMake(tap.view.center.x, slider.center.y);
    } completion:nil];
    
    
}

#pragma mark - Getter

- (UIScrollView *)contentScrollView
{
    if (_contentScrollView == nil) {
        _contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight, kScreenWidth, kScreenHeight-KSafeAreaTopNaviHeight)];

//        _contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight)];
        _contentScrollView.delegate = self;
    }
    
    return _contentScrollView;
}
/**
 *  <#Description#>
 *
 *  @return <#return value description#>
 */
- (UIScrollView *)titleScrollView
{
    if (_titleScrollView == nil) {
        
        [_allView addSubview:_titleScrollView];
        
        _titleScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(80, 25, kScreenWidth-120, 40)];
        _titleScrollView.backgroundColor = [UIColor clearColor];
        _titleScrollView.bounces=NO;
        NSArray *titles = @[@"商品", @"详情"];
        CGFloat itemWidth = 100;
        for (int i=0; i<2; i++) {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(itemWidth*i, 0, itemWidth, 40)];
            label.textAlignment = NSTextAlignmentCenter;
            label.font=[UIFont systemFontOfSize:20];
            
            label.text = titles[i];
            label.tag = 100 + i;
            
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleDidTap:)];
            [label addGestureRecognizer:tapGesture];
            label.userInteractionEnabled = YES;
            
            [_titleScrollView addSubview:label];
        }
        
        UIView *slider = [[UIView alloc] initWithFrame:CGRectMake(30, 40-3, 40, 2)];
        slider.backgroundColor = [UIColor redColor];
        slider.tag = 10001;
        [_titleScrollView addSubview:slider];
        
        _titleScrollView.contentSize = CGSizeMake(itemWidth, 40);
    }
    
    return _titleScrollView;
}

-(void)backBtnClick
{
    
    NSLog(@"===self.type===%@",self.type);

    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数组NSArray类型的数据

    if ([[userDefaultes stringForKey:@"cartback"] isEqualToString:@"100"]) {


        self.navigationController.navigationBar.hidden=YES;

        self.tabBarController.tabBar.hidden=NO;

        [self.navigationController popToRootViewControllerAnimated:NO];

    }else{



        if (self.sigen.length > 0) {

            //发送通知，购物修改数据

            NSNotification *notification = [[NSNotification alloc] initWithName:@"CartBdeagChange" object:nil userInfo:nil];

            [[NSNotificationCenter defaultCenter] postNotification:notification];


            //发送通知给购物车刷新数据

            NSNotification *notification1 = [[NSNotification alloc] initWithName:@"CartReloadData" object:nil userInfo:nil];

            [[NSNotificationCenter defaultCenter] postNotification:notification1];

        }


        if ([_ytBack isEqualToString:@"100"]) {

            [UserMessageManager removeAllGoodsAttribute];
            [UserMessageManager removeAllImageSecect];

            NSArray *vcArray = self.navigationController.viewControllers;


            for(UIViewController *vc in vcArray)
            {
                if ([vc isKindOfClass:[BusinessQurtViewController class]]){


                    self.navigationController.navigationBar.hidden=NO;
                    self.tabBarController.tabBar.hidden=NO;

                    [self.navigationController popToViewController:vc animated:NO];

                }else{

                    //                [self.navigationController popToRootViewControllerAnimated:NO];

                    [self.navigationController popToViewController:self.navigationController.viewControllers[0] animated:YES];
                }
            }

            //        [self.navigationController popToViewController:self.navigationController.viewControllers[0] animated:YES];
        }else{

            if ([self.type isEqualToString:@"1"]) {

                //        [self.navigationController popViewControllerAnimated:YES];
                [UserMessageManager removeAllGoodsAttribute];
                [UserMessageManager removeAllImageSecect];
                self.tabBarController.tabBar.hidden=NO;

                if ([self.attribute integerValue] == 2) {


                    if ([self.Attribute_back isEqualToString:@"2"]) {


                        self.navigationController.navigationBar.hidden=YES;

                        [self.navigationController popToViewController:self.navigationController.viewControllers[1] animated:YES];

                    }else if([self.Attribute_back isEqualToString:@"3"]){

                        self.navigationController.navigationBar.hidden=YES;

                        [self.navigationController popToViewController:self.navigationController.viewControllers[2] animated:YES];

                    }else if([self.Attribute_back isEqualToString:@"4"]){

                        self.navigationController.navigationBar.hidden=YES;

                        [self.navigationController popToViewController:self.navigationController.viewControllers[3] animated:YES];

                    }else if([self.Attribute_back isEqualToString:@"5"]){

                        self.navigationController.navigationBar.hidden=YES;

                        [self.navigationController popToViewController:self.navigationController.viewControllers[4] animated:YES];

                    }else if([self.Attribute_back isEqualToString:@"6"]){

                        self.navigationController.navigationBar.hidden=YES;
                        self.tabBarController.tabBar.hidden=YES;

                        [self.navigationController popViewControllerAnimated:NO];

                    }else{


                        //                    NSArray *vcArray = self.navigationController.viewControllers;
                        //
                        //
                        //                    for(UIViewController *vc in vcArray)
                        //                    {
                        //                        if ([vc isKindOfClass:[MerchantViewController class]]){
                        //
                        //
                        //                            self.navigationController.navigationBar.hidden=NO;
                        //                            self.tabBarController.tabBar.hidden=NO;
                        //
                        //                            [self.navigationController popToViewController:vc animated:NO];
                        //
                        //                        }else{
                        //
                        //                            [self.navigationController popToRootViewControllerAnimated:NO];
                        //                        }
                        //                    }
                        self.tabBarController.tabBar.hidden=YES;
                        [self.navigationController popViewControllerAnimated:NO];
                    }


                }else{
                    NSLog(@"KKKKKKKK");

                    if ([self.HoldOn isEqualToString:@"100"]) {

                        self.tabBarController.tabBar.hidden=YES;
                    }

self.tabBarController.tabBar.hidden=YES;
                    [self.navigationController popViewControllerAnimated:YES];
                }



            }else{
                [UserMessageManager removeAllGoodsAttribute];
                [UserMessageManager removeAllImageSecect];
                self.tabBarController.tabBar.hidden=YES;

                if ([self.attribute integerValue] == 2) {

                    if ([self.Attribute_back isEqualToString:@"2"]) {


                        self.navigationController.navigationBar.hidden=YES;

                        [self.navigationController popToViewController:self.navigationController.viewControllers[1] animated:YES];

                    }else if([self.Attribute_back isEqualToString:@"3"]){

                        self.navigationController.navigationBar.hidden=YES;

                        [self.navigationController popToViewController:self.navigationController.viewControllers[2] animated:YES];

                    }else if([self.Attribute_back isEqualToString:@"4"]){

                        self.navigationController.navigationBar.hidden=YES;

                        [self.navigationController popToViewController:self.navigationController.viewControllers[3] animated:YES];

                    }else if([self.Attribute_back isEqualToString:@"5"]){

                        self.navigationController.navigationBar.hidden=YES;

                        [self.navigationController popToViewController:self.navigationController.viewControllers[4] animated:YES];

                    }else{


                        //                    NSArray *vcArray = self.navigationController.viewControllers;
                        //
                        //
                        //                    for(UIViewController *vc in vcArray)
                        //                    {
                        //                        if ([vc isKindOfClass:[BusinessQurtViewController class]]){
                        //
                        //
                        //                            self.navigationController.navigationBar.hidden=NO;
                        //                            self.tabBarController.tabBar.hidden=NO;
                        //
                        //                            [self.navigationController popToViewController:vc animated:NO];
                        //
                        //                        }else{
                        //
                        //                            [self.navigationController popToRootViewControllerAnimated:NO];
                        //                        }
                        //                    }
                        self.tabBarController.tabBar.hidden=YES;
                        [self.navigationController popViewControllerAnimated:NO];

                    }
                }else{
                    self.tabBarController.tabBar.hidden=YES;
                    [self.navigationController popViewControllerAnimated:YES];
                }
            }
        }
    }

    [UserMessageManager RemoveCartBack];

}

@end
