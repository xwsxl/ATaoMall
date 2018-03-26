//
//  MerchantDetailViewController.m
//  aTaohMall
//
//  Created by JMSHT on 2017/3/7.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "MerchantDetailViewController.h"

#import "MerchantDetailHeader.h"

#import "MerchantNoDataCell.h"

#import "MerchantDetailCell.h"

#import "HTTPRequestManager.h"

#import "WKProgressHUD.h"

#import "UIImageView+WebCache.h"

#import "AFNetworking.h"//网络请求
//加密
#import "ConverUtil.h"
#import "DESUtil.h"
#import "SecretCodeTool.h"

#import "MerchantModel.h"

//刷新
#import "DJRefresh.h"
#import "DJRefreshProgressView.h"
#import "GotoShopLimitCell.h"
#import "NineFooterView.h"
#import "TimeModel.h"

//商品详情
#import "YTGoodsDetailViewController.h"

#import "MerchantMapViewController.h"
#import "ATHLoginViewController.h"
@interface MerchantDetailViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,DJRefreshDelegate,FooterViewDelegate>
{
    
  //  NineFooterView *footer;
    
    UICollectionView *_collectionView;
    
    UIButton *HotButton;
    
    UIButton *ScoreButton;
    
    UIButton *AllButton;
    
    NSMutableArray *_dataArrM;//存放商品
    
    NSMutableArray *_headerArrM;//存放头部信息
    
    int page;
    int currentPageNo;
    NSString *string10;
    //NSString *ShouCangStr;
    MerchantNoDataCell *cell1;

    UIButton *ShouCangBut;
    
}

@property (nonatomic,strong)DJRefresh *refresh;

@property(nonatomic,strong) UILabel *NoDataLabel;

@property (nonatomic,strong)NSString *ShouCangStr;

@property (nonatomic, strong) NSTimer        *m_timer; //定时器

@end

@implementation MerchantDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //去除滑动返回
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    
    _dataArrM = [NSMutableArray new];
    
    _headerArrM = [NSMutableArray new];
    
    page=0;
    currentPageNo=1;
    
    
    self.Type = @"";
    
    [self initNav];
    
    [self initCollectionView];
    
    
    [self initTabbar];
    
    
    [self GetDatas];
    
    [self createTimer];
    
//    [self AddressData];
    
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(TimeStop3:) name:@"TimeStop666" object:nil];
    /*****  登录成功需要刷新数据获取收藏状态 *****/
    [KNotificationCenter addObserver:self selector:@selector(login) name:JMSHTLoginSuccessNoti object:nil];

}

-(void)login
{
    [self addDataWithDirection:DJRefreshDirectionTop];
}

- (void)createTimer {
    
    self.m_timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(timerEvent) userInfo:nil repeats:NO];
    [[NSRunLoop currentRunLoop] addTimer:_m_timer forMode:NSRunLoopCommonModes];
}

- (void)timerEvent {
    
   // [_collectionView reloadData];
}

- (void)TimeStop3:(NSNotification *)text{
    
    
    [_dataArrM removeAllObjects];
    [_headerArrM removeAllObjects];
    
    [self GetDatas];
    
}

//暂无数据
-(void)initNoDataLabel
{
    
    self.NoDataLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 350, [UIScreen mainScreen].bounds.size.width, 20)];
    
    self.NoDataLabel.text = @"暂无相关商品";
    
    self.NoDataLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    self.NoDataLabel.textAlignment = NSTextAlignmentCenter;
    
    self.NoDataLabel.font  =[UIFont fontWithName:@"PingFang-SC-Regular" size:13];
    
    [self.view addSubview:self.NoDataLabel];
    
}


-(void)initTabbar
{
    
    UIImageView *fenge = [[UIImageView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-50-KSafeAreaBottomHeight, [UIScreen mainScreen].bounds.size.width, 1)];
    fenge.image = [UIImage imageNamed:@"分割线-拷贝"];
    
    [self.view addSubview:fenge];
    
    UIView *tab = [[UIView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-49, [UIScreen mainScreen].bounds.size.width, 49)];
    
    [self.view addSubview:tab];
    
    HotButton = [UIButton buttonWithType:UIButtonTypeCustom];
    HotButton.frame = CGRectMake(0, 0, ([UIScreen mainScreen].bounds.size.width-2)/3, 49);
    [HotButton setTitle:@"热销" forState:0];
    [HotButton setTitleColor:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0] forState:0];
//    [HotButton setTitleColor:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0] forState:1];
    HotButton.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    
    [HotButton addTarget:self action:@selector(HotBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [tab addSubview:HotButton];
    
    UIImageView *fenge1 = [[UIImageView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-2)/3, 2, 1, 45)];
    fenge1.image = [UIImage imageNamed:@"分割线YT"];
    
    [tab addSubview:fenge1];
    
    
    ScoreButton = [UIButton buttonWithType:UIButtonTypeCustom];
    ScoreButton.frame = CGRectMake((([UIScreen mainScreen].bounds.size.width-2)/3)+1, 0, ([UIScreen mainScreen].bounds.size.width-2)/3, 49);
    [ScoreButton setTitle:@"积分商品" forState:0];
    [ScoreButton setTitleColor:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0] forState:0];
//    [ScoreButton setTitleColor:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0] forState:1];
    ScoreButton.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    [ScoreButton addTarget:self action:@selector(ScoreBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [tab addSubview:ScoreButton];
    
    UIImageView *fenge2 = [[UIImageView alloc] initWithFrame:CGRectMake((([UIScreen mainScreen].bounds.size.width-2)/3)*2+1, 2, 1, 45)];
    fenge2.image = [UIImage imageNamed:@"分割线YT"];
    
    [tab addSubview:fenge2];
    
    
    AllButton = [UIButton buttonWithType:UIButtonTypeCustom];
    AllButton.frame = CGRectMake((([UIScreen mainScreen].bounds.size.width-2)/3)*2+2, 0, ([UIScreen mainScreen].bounds.size.width-2)/3, 49);
    [AllButton setTitle:@"全部商品" forState:0];
    [AllButton setTitleColor:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0] forState:0];
//    [AllButton setTitleColor:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0] forState:1];
    AllButton.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    [AllButton addTarget:self action:@selector(AllBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [tab addSubview:AllButton];
    
    
}
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
    
    Qurt.frame = CGRectMake(15, 25+KSafeTopHeight, 30, 30);
    
    [Qurt setImage:[UIImage imageNamed:@"iconfont-fanhui2yt"] forState:0];
    
    
    [Qurt addTarget:self action:@selector(QurtBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [titleView addSubview:Qurt];
    
    //创建搜索
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 25+KSafeTopHeight, [UIScreen mainScreen].bounds.size.width-200, 30)];
    
    label.text = @"店铺详情";
    
    label.textColor = [UIColor blackColor];
    
    label.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:19];
    
    label.textAlignment = NSTextAlignmentCenter;
    
    [titleView addSubview:label];


    ShouCangBut=[UIButton buttonWithType:UIButtonTypeCustom];
    ShouCangBut.frame=CGRectMake(kScreen_Width-15-18-11, 20+KSafeTopHeight, 40, 40);

    [ShouCangBut addTarget:self action:@selector(shouCangBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:ShouCangBut];

}

-(void)shouCangBtnClick:(UIButton *)sender
{
    ShouCangBut.userInteractionEnabled=NO;
    if (![[kUserDefaults stringForKey:@"sigen"] containsString:@"null"]&&[kUserDefaults stringForKey:@"sigen"].length>0) {


    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];

    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *url=[NSString stringWithFormat:@"%@updateCollectionGoodsOrShop_mob.shtml",URL_Str];
   /* 收藏店铺参数：sigen：
    is_status：收藏状态：1收藏2取消收藏（这里传1）
    type：类型：1商品2商铺（这里传2）
    mid：商户ID
    取消收藏店铺参数：sigen：
    is_status：收藏状态：1收藏2取消收藏（这里传2）
    type：类型：1商品2商铺（这里传2）
    mid：商户ID */
    if (!sender.selected) {
        NSDictionary *params=@{@"sigen":[kUserDefaults stringForKey:@"sigen"],@"is_status":@"1",@"type":@"2",@"mid":self.mid};
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
        NSDictionary *params=@{@"sigen":[kUserDefaults stringForKey:@"sigen"],@"is_status":@"2",@"type":@"2",@"mid":self.mid};
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

//获取数据源
-(void)GetDatas
{
  //  WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];

    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@getShopDetails_mob.shtml",URL_Str];
    
    NSDictionary *dic = @{@"mid":self.mid,@"flag":[NSString stringWithFormat:@"%d",page],@"type":self.Type,@"sigen":[kUserDefaults stringForKey:@"sigen"]};
    YLog(@"%@",dic);
    [manager POST:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
        NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];
        
        if (codeKey && content) {
            NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
            

            
            
            NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];
            
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            NSLog(@"xmlStr==店铺详情===%@",dic);
            if (page == 0) {
                
                [_dataArrM removeAllObjects];
                
                [_headerArrM removeAllObjects];
                
            }
            
            
            for (NSDictionary *dict1 in dic) {
               
                string10 = dict1[@"totalCount"];
                self.ShouCangStr=dict1[@"is_status"];
                for (NSDictionary *dict2 in dict1[@"goodList"]) {
                    
                    MerchantModel *model=[[MerchantModel alloc] init];
                    
                    model.Goods_amount=dict2[@"amount"];
                    model.Goods_type=dict2[@"good_type"];
                    model.GoodsName=dict2[@"name"];
                    model.GoodsPay_integer=dict2[@"pay_integer"];
                    model.GoodsPay_maney=dict2[@"pay_maney"];
                    model.GoodsImg=dict2[@"scopeimg"];
                    model.Goods_status=dict2[@"status"];
                    model.GoodsId=dict2[@"id"];
                    model.Goods_is_attribute = dict2[@"is_attribute"];
                    
                    if ([model.Goods_type isEqualToString:@"1"]) {
                        
                        model.Goods_end=dict2[@"end_time"];
                        
                        model.Goods_start=dict2[@"start_time"];
                        
                    }
                    
                    
                    [_dataArrM addObject:model];
                    
                }
                
                NSLog(@"$$$$$$$$$=%@",dict1[@"merchantsList"]);
                
                for (NSDictionary *dict3 in dict1[@"merchantsList"]) {
                    
                    MerchantModel *model1=[[MerchantModel alloc] init];
                    
                    NSLog(@"&&&&&&&&&&=%@",dict3[@"logo"]);
                    
                    model1.HeaderLogo=dict3[@"logo"];
                    model1.HeaderName=dict3[@"storename"];
                    model1.note=dict3[@"note"];
                    model1.HeaderId = [NSString stringWithFormat:@"%@",dict3[@"id"]];
                    model1.HeaderString = [NSString stringWithFormat:@"%@",dict3[@"coordinates"]];
                    
                    self.coordinates = [NSString stringWithFormat:@"%@",dict3[@"coordinates"]];
                    
                    [_headerArrM addObject:model1];
                }
                
            }
            
            
            if (_dataArrM.count == 0) {
                
                [self initNoDataLabel];
//                _refresh.topEnabled=NO;//下拉刷新
                self.NoDataLabel.hidden = NO;
                
            }else{
                
                self.NoDataLabel.hidden = YES;
                
            }
            
            
            if (_dataArrM.count%12==0&&_dataArrM.count !=[string10 integerValue]) {
                _refresh.bottomEnabled=YES;
//                footer.hidden=NO;
                cell1.hidden=YES;
//                [footer.loadMoreBtn setTitle:@"点击加载更多" forState:0];
//                footer.loadMoreBtn.enabled=YES;

            }else if (_dataArrM.count == [string10 integerValue]){
//                footer.hidden = NO;
               cell1.hidden=YES;
                 _refresh.bottomEnabled=NO;
//                footer.moreView.hidden=YES;
//                [footer.loadMoreBtn setTitle:@"暂无更多数据" forState:0];
//                [footer.loadMoreBtn setTitleColor:[UIColor colorWithRed:154/255.0 green:154/255.0 blue:154/255.0 alpha:1.0] forState:0];
//                footer.loadMoreBtn.enabled=NO;

                
            }else{
                
                //隐藏点击加载更多
            //    footer.hidden=YES;
                 _refresh.bottomEnabled=NO;
                cell1.hidden=NO;
            }
            
            
       //     [hud dismiss:YES];
            [_refresh finishRefreshing];
            [_collectionView reloadData];
            
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
    //    [hud dismiss:YES];
        
        [_refresh finishRefreshing];
        NSLog(@"%@",error);
    }];
    
}

//地址资料
-(void)AddressData
{
    
    if (self.jindu.length==0) {
        
        self.jindu = @"113.9565795358";
    }
    
    if (self.weidu.length==0) {
        
        self.weidu = @"22.5379648670";
    }
    
    NSString *string=[NSString stringWithFormat:@"%@,%@",self.jindu,self.weidu];
    
    NSLog(@"===地址资料=string=%@=self.coordinates=%@=self.mid=%@",string,self.coordinates,self.mid);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@getNearbyMerchants_mob.shtml",URL_Str];
    
    NSDictionary *dic = @{@"coordinates":string,@"merchants_coordinates":self.coordinates,@"mid":self.mid};
    
    [manager POST:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
        NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];
        
        if (codeKey && content) {
            NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
            
            NSLog(@"xmlStr==地址详情===%@",xmlStr);
            
            
            NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];
            
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            NSNull *null = [[NSNull alloc] init];
            
            for (NSDictionary *dict in dic) {
                
                if (![dict[@"merchants_map"] isEqual:null]) {
                    
                    
                    if ([dict[@"merchants_map"][@"logo"] isEqual:null]) {
                        
                        
                        self.LogoString = @"0";
                        
                    }else{
                        
                        
                        self.LogoString = dict[@"merchants_map"][@"logo"];
                    }
                    
                    
                    self.NameString = dict[@"merchants_map"][@"storename"];
                    
                    self.LongString = dict[@"merchants_map"][@"distanceStr"];
                    
                    self.TypeString = [NSString stringWithFormat:@"行业类别：%@",dict[@"merchants_map"][@"tid"]];
                    
                    self.AddressString = [NSString stringWithFormat:@"地址：%@",dict[@"merchants_map"][@"address"]];
                }
            
            
            MerchantMapViewController *vc = [[MerchantMapViewController alloc] init];
            
            vc.jindu=self.jindu;
            
            vc.weidu=self.weidu;
            
            vc.BackString = @"200";
            vc.MapStartAddress = self.MapStartAddress;
            
            vc.MMMMid = self.mid;
            vc.coordinates = self.coordinates;
            vc.NameString = self.NameString;
            vc.LongString = self.LongString;
            vc.LogoString = self.LogoString;
            vc.TypeString = self.TypeString;
            vc.NewAddressString = self.AddressString;
            
            [self.navigationController pushViewController:vc animated:NO];
            }
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
       
        NSLog(@"%@",error);
    }];
    
}
-(void)initCollectionView
{
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    _collectionView =[[UICollectionView alloc] initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-KSafeAreaTopNaviHeight-50-KSafeAreaBottomHeight) collectionViewLayout:flowLayout];
    
    _collectionView.delegate=self;
    
    _collectionView.dataSource=self;
    
    _collectionView.backgroundColor= [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];
    
    [self.view addSubview:_collectionView];
    
    [_collectionView registerClass:[MerchantDetailCell class] forCellWithReuseIdentifier:@"cell"];
    
    [_collectionView registerClass:[MerchantDetailHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header"];
    
    [_collectionView registerClass:[MerchantNoDataCell class] forCellWithReuseIdentifier:@"nocell"];
    
    [_collectionView registerNib:[UINib nibWithNibName:@"NineFooterView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
    
    _refresh=[[DJRefresh alloc] initWithScrollView:_collectionView delegate:self];
    _refresh.topEnabled=YES;//下拉刷新
    _refresh.bottomEnabled=NO;//上拉加载
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (_dataArrM.count==0) {
        
        return 1;
        
    }else{
        
        return _dataArrM.count;
    }
    
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
   
    if (_dataArrM.count==0) {
        
        return CGSizeMake([UIScreen mainScreen].bounds.size.width, 200);
    }else{
        
        if ([UIScreen mainScreen].bounds.size.height <= 568.000000) {
            
            
            return CGSizeMake(([UIScreen mainScreen].bounds.size.width-15)/2, ([UIScreen mainScreen].bounds.size.height)/1.9);
            
        }else if(kScreen_Height<=1334/2)
        {
            return CGSizeMake(([UIScreen mainScreen].bounds.size.width-15)/2, ([UIScreen mainScreen].bounds.size.height)/2.3);
        }
        else{
            
            return CGSizeMake(([UIScreen mainScreen].bounds.size.width-15)/2, ([UIScreen mainScreen].bounds.size.height)/2.5);
            
        }
    }
}

//最小行间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 5;
}
//最小行内部cell的间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 5;
}

//section的边距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    //上,左,下,右
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (_dataArrM.count==0) {
        
        cell1 = [collectionView dequeueReusableCellWithReuseIdentifier:@"nocell" forIndexPath:indexPath];
        
        cell1.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];
        
//        if([string10 integerValue]==0){
//            
//            cell1.hidden=NO;
//            
//        }else{
        
            cell1.hidden=YES;
//        }
        
        return cell1;
        
        
    }else{
        
        MerchantDetailCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
        
        MerchantModel *model = _dataArrM[indexPath.row];
        
        cell.backgroundColor=[UIColor whiteColor];
        
        [cell.GoodsImgView sd_setImageWithURL:[NSURL URLWithString:model.GoodsImg] placeholderImage:[UIImage imageNamed:@"default_image"] options:SDWebImageProgressiveDownload];
        
        cell.GoodsNameLabel.text = model.GoodsName;

        cell.GoodsPriceLabel.text = [NSString stringWithFormat:@"￥%.02f+%.02f积分",[model.GoodsPay_maney floatValue],[model.GoodsPay_integer floatValue]];
        
        cell.GoodsNumberLabel.text = [NSString stringWithFormat:@"%@人付款",model.Goods_amount];
        
        if ([model.Goods_type isEqualToString:@"1"]) {
            
            cell.GoodsTimeLabel.hidden=NO;
            
            //显示倒计时
            cell.start_time_str=model.Goods_start;
            cell.end_time_str=model.Goods_end;
            
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.0"];
            NSDate *end=[dateFormatter dateFromString:model.Goods_end];
    
            NSDate *timedata = [NSDate date];
            
            NSTimeInterval _end=[end timeIntervalSince1970];
            
            NSTimeInterval _start=[timedata timeIntervalSince1970];
            
            NSInteger time=(NSInteger)(_end - _start);
            
            TimeModel *model2 = [[TimeModel alloc]init];
            model2.m_countNum = (int)time+3;
            
            [cell loadData:model2 indexPath:indexPath type:@"1"];
            
        }else{
            
            cell.GoodsTimeLabel.hidden=YES;
        }
        
        return cell;
        
    }
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    YTGoodsDetailViewController *vc=[[YTGoodsDetailViewController alloc] init];
   // vc.type=@"1";
    MerchantModel *model = _dataArrM[indexPath.row];
    
    vc.gid=model.GoodsId;
    vc.ID=model.GoodsId;
    vc.status=model.Goods_status;
    vc.good_type=model.Goods_type;
    vc.attribute = model.Goods_is_attribute;

    if ([self.GetString isEqualToString:@"1"]) {
        
        vc.Attribute_back=@"2";
        
    }else if ([self.GetString isEqualToString:@"2"]){
        
        vc.Attribute_back=@"3";
        
    }else if ([self.GetString isEqualToString:@"3"]){
        
        vc.Attribute_back=@"4";
    }else if ([self.GetString isEqualToString:@"4"]){
        
        vc.Attribute_back=@"5";
    }
    
    [self.navigationController pushViewController:vc animated:NO];
    
    self.navigationController.navigationBar.hidden=YES;
    
}
//返回header的高度
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    return CGSizeMake(0, 245);
}

//footer

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    
     if(kind==UICollectionElementKindSectionHeader){
        
        MerchantDetailHeader *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header" forIndexPath:indexPath];
        
        NSNull *null = [[NSNull alloc] init];
        
        for (MerchantModel *model in _headerArrM) {
            
            //        [header.logoImgView sd_setImageWithURL:[NSURL URLWithString:model.HeaderLogo] placeholderImage:[UIImage imageNamed:@"default_image"] options:SDWebImageProgressiveDownload];
            
            header.logoString = model.HeaderLogo;
            
            if ([model.HeaderLogo isEqual:null]) {
                
                
                header.logoImgView.image = [UIImage imageNamed:@"图片占位or加载2"];
                
            }else{
                
                [header.logoImgView sd_setImageWithURL:[NSURL URLWithString:model.HeaderLogo] placeholderImage:[UIImage imageNamed:@"图片占位or加载2"]];
                
            }
            
            header.ShopNameLabel.text = model.HeaderName;
            header.ShopIntroduceLabel.text = [NSString stringWithFormat:@"店铺简介：%@",model.note];
            
            UITapGestureRecognizer *Tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Tap:)];
            
            header.logoImgView.userInteractionEnabled = YES;
            
            [header.logoImgView addGestureRecognizer:Tap];
            
        }
        
        return header;
        
    }else{
        
        return nil;
    }
    
}

//加载更多数据代理方法
- (void)FooterViewClickedloadMoreData
{
    
    NSLog(@"点击加载更多");
    if (_dataArrM.count%12==0) {
        
        currentPageNo=currentPageNo+1;
        
        page=page+1;
        
        //获取数据
        [self GetDatas];
        
        
        [_collectionView reloadData];
        
    }else{
        [_refresh finishRefreshing];

    }
    
}

-(void)QurtBtnClick
{
    
    if ([self.BackString isEqualToString:@"100"]) {
        
        
        NSNotification *notification = [[NSNotification alloc] initWithName:@"notification" object:nil userInfo:nil];
        
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        
        
        self.navigationController.navigationBar.hidden=YES;
        
        self.tabBarController.tabBar.hidden=YES;
        
        [self.navigationController popViewControllerAnimated:NO];
        
    }else if([self.BackString isEqualToString:@"333"]){
        
        self.navigationController.navigationBar.hidden=YES;
        
        self.tabBarController.tabBar.hidden=YES;
        
        [self.navigationController popViewControllerAnimated:NO];
        
        
    }else{
        
        if (_delegate && [_delegate respondsToSelector:@selector(BackReloadData)]) {
            
            [_delegate BackReloadData];
            
        }
        
        self.navigationController.navigationBar.hidden=YES;
        
        self.tabBarController.tabBar.hidden=YES;
        
        [self.navigationController popViewControllerAnimated:NO];
        
    }
    
    
}

#pragma 下拉刷新

- (void)refresh:(DJRefresh *)refresh didEngageRefreshDirection:(DJRefreshDirection)direction{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self addDataWithDirection:direction];
    });
    
}

- (void)addDataWithDirection:(DJRefreshDirection)direction{
    
    if (direction==DJRefreshDirectionTop) {
        
        page=0;
        currentPageNo=1;

        //获取数据
        [self GetDatas];
        
    }else
    {
        [self FooterViewClickedloadMoreData];
    }

}

-(void)HotBtnClick
{

    [HotButton setTitleColor:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0] forState:0];
    [ScoreButton setTitleColor:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0] forState:0];
    [AllButton setTitleColor:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0] forState:0];
    
    self.Type = @"0";
    page=0;
    currentPageNo=1;
    
    [_dataArrM removeAllObjects];
    
    [_headerArrM removeAllObjects];
    
    //获取数据
    [self GetDatas];
    
}

-(void)ScoreBtnClick
{
    
    [HotButton setTitleColor:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0] forState:0];
    [ScoreButton setTitleColor:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0] forState:0];
    [AllButton setTitleColor:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0] forState:0];
    
    self.Type = @"1";
    
    page=0;
    currentPageNo=1;
    
    [_dataArrM removeAllObjects];
    
    [_headerArrM removeAllObjects];
    
    //获取数据
    [self GetDatas];
    
}

-(void)AllBtnClick
{
    
    [HotButton setTitleColor:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0] forState:0];
    [ScoreButton setTitleColor:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0] forState:0];
    [AllButton setTitleColor:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0] forState:0];
    self.Type = @"";
    
    page=0;
    currentPageNo=1;
    
    [_dataArrM removeAllObjects];
    [_headerArrM removeAllObjects];
    
    //获取数据
    [self GetDatas];
    
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

-(void)Tap:(UITapGestureRecognizer *)Gr
{
    
    NSLog(@"=====店铺详情===self.AddressString=====%@",self.AddressString);
    
    
    [self AddressData];
    
//    MerchantMapViewController *vc = [[MerchantMapViewController alloc] init];
//    
//    vc.jindu=self.jindu;
//    
//    vc.weidu=self.weidu;
//    
//    vc.BackString = @"200";
//    vc.MapStartAddress = self.MapStartAddress;
//    vc.MMMMid = self.mid;
//    vc.coordinates = self.coordinates;
//    vc.NameString = self.NameString;
//    vc.LongString = self.LongString;
//    vc.LogoString = self.LogoString;
//    vc.TypeString = self.TypeString;
//    vc.NewAddressString = self.AddressString;
//    
//    [self.navigationController pushViewController:vc animated:NO];
    
}
@end
