//
//  ChunJiFenShopViewController.m
//  aTaohMall
//
//  Created by 阳涛 on 16/5/14.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import "ChunJiFenShopViewController.h"

#import "ChunJiFenCell.h"

#import "LimitTimeCell.h"

#import "NowGoingViewController.h"//限时抢购
#import "NowBuyingViewController.h"//即将开枪

#import "AFNetworking.h"

#import "ChunJiFenModel.h"

#import "ConverUtil.h"
#import "DESUtil.h"
#import "SecretCodeTool.h"

#import "UIImageView+WebCache.h"

#import "WKProgressHUD.h"

#import "NewGoodsDetailViewController.h"//商品详情

#import "GGClockView.h"


#import "HomeLookFooter.h"

#import "TimeModel.h"

//刷新
#import "DJRefresh.h"
#import "DJRefreshProgressView.h"

#import "NoGoodsDetailViewController.h"
#define fwidth [UIScreen mainScreen].bounds.size.width
#define fheight [UIScreen mainScreen].bounds.size.height
#import "YTGoodsDetailViewController.h"
@interface ChunJiFenShopViewController ()<UITableViewDataSource,UITableViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate,DJRefreshDelegate,FooterViewDelegate>
{
    UITableView *_tableView;
    
    UICollectionView *_collectionView;
    UICollectionView *_collectionView1;
    
    NSMutableArray *_datasArrM;
    
    NSMutableArray *_datasSource;
    
    ChunJiFenCell *cell;
    
    NSString *str1;
    
    NSString *str2;
    
    NSMutableArray *_StopArrM;
    NSMutableArray *_StartArrM;
    
    UIView *view;
    
}

@property (nonatomic,strong)DJRefresh *refresh;
@property (nonatomic, strong) NSTimer        *m_timer; //定时器

@end

@implementation ChunJiFenShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.frame=[UIScreen mainScreen].bounds;
    _datasArrM=[NSMutableArray new];
    
    _datasSource=[NSMutableArray new];
    
    _StopArrM=[NSMutableArray new];
    
    _StartArrM=[NSMutableArray new];
    
    
    [self initTableView];
    
    //获取数据
    [self getDatas];
    
    WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
    
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{

        [hud dismiss:YES];
    });
    
    [self createTimer];
    
}

-(void)getDatas
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@getIntegralGoods_mob.shtml",URL_Str];
    
    NSDictionary *dic=nil;
    
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
            
            view.hidden=YES;
            
            for (NSDictionary *dict1 in dic) {
                for (NSDictionary *dict2 in dict1[@"integralGoodsList"]) {
                    ChunJiFenModel *model=[[ChunJiFenModel alloc] init];
                    
                    NSString *amount=dict2[@"amount"];
                    NSString *end_time_str=dict2[@"end_time_str"];
                    NSString *good_type=dict2[@"good_type"];
                    NSString *id=dict2[@"id"];
                    NSString *name=dict2[@"name"];
                    NSString *pay_integer=dict2[@"pay_integer"];
                    NSString *pay_maney=dict2[@"pay_maney"];
                    NSString *scopeimg=dict2[@"scopeimg"];
                    NSString *start_time_str=dict2[@"start_time_str"];
                    NSString *type =dict2[@"type"];
                    NSString *status =dict2[@"status"];
                   NSString *attribute = dict2[@"is_attribute"];//商品属性；
                    
                    model.attribute = attribute;
                    model.amount=amount;
                    model.end_time_str=end_time_str;
                    model.good_type=good_type;
                    model.id=id;
                    model.name=name;
                    model.pay_integer=pay_integer;
                    model.pay_maney=pay_maney;
                    model.scopeimg=scopeimg;
                    model.start_time_str=start_time_str;
                    model.type=type;
                    model.status=status;
                    
                    [_datasArrM addObject:model];
                    NSLog(@"_datasArrM=====>%ld",_datasArrM.count);
                }
                
                for (NSDictionary *dict3 in dict1[@"integralGoodsList1"]) {
                    ChunJiFenModel *model=[[ChunJiFenModel alloc] init];
                    
                    NSString *amount=dict3[@"amount"];
                    NSString *end_time_str=dict3[@"end_time_str"];
                    NSString *good_type=dict3[@"good_type"];
                    NSString *id=dict3[@"id"];
                    NSString *name=dict3[@"name"];
                    NSString *pay_integer=dict3[@"pay_integer"];
                    NSString *pay_maney=dict3[@"pay_maney"];
                    NSString *scopeimg=dict3[@"scopeimg"];
                    NSString *start_time_str=dict3[@"start_time_str"];
                    NSString *type =dict3[@"type"];
                    NSString *status =dict3[@"status"];
                    NSString *attribute = dict3[@"is_attribute"];//商品属性；
                    
                    model.attribute = attribute;
                    model.amount=amount;
                    model.end_time_str=end_time_str;
                    model.good_type=good_type;
                    model.id=id;
                    
                    
                    
                    model.name=name;
                    model.pay_integer=pay_integer;
                    model.pay_maney=pay_maney;
                    model.scopeimg=scopeimg;
                    model.start_time_str=start_time_str;
                    model.type=type;
                    model.status=status;
                    
                    [_datasSource addObject:model];
                    
                    NSLog(@"_datasSource=====>%ld",_datasSource.count);
                }
            }
            
            
            
            [_tableView reloadData];
            [_collectionView reloadData];
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
//        [WKProgressHUD popMessage:@"网络请求失败，请检查您的网络设置" inView:self.view duration:1.5 animated:YES];
        
        [self NoWebSeveice];
        
        NSLog(@"%@",error);
    }];
}



-(void)YTgetDatas
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@getIntegralGoods_mob.shtml",URL_Str];
    
    NSDictionary *dic=nil;
    
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
            
            view.hidden=YES;
            
            for (NSDictionary *dict1 in dic) {
                for (NSDictionary *dict2 in dict1[@"integralGoodsList"]) {
                    ChunJiFenModel *model=[[ChunJiFenModel alloc] init];
                    
                    NSString *amount=dict2[@"amount"];
                    NSString *end_time_str=dict2[@"end_time_str"];
                    NSString *good_type=dict2[@"good_type"];
                    NSString *id=dict2[@"id"];
                    NSString *name=dict2[@"name"];
                    NSString *pay_integer=dict2[@"pay_integer"];
                    NSString *pay_maney=dict2[@"pay_maney"];
                    NSString *scopeimg=dict2[@"scopeimg"];
                    NSString *start_time_str=dict2[@"start_time_str"];
                    NSString *type =dict2[@"type"];
                    NSString *status =dict2[@"status"];
                    NSString *attribute = dict2[@"is_attribute"];//商品属性；
                    
                    model.attribute = attribute;
                    model.amount=amount;
                    model.end_time_str=end_time_str;
                    model.good_type=good_type;
                    model.id=id;
                    model.name=name;
                    model.pay_integer=pay_integer;
                    model.pay_maney=pay_maney;
                    model.scopeimg=scopeimg;
                    model.start_time_str=start_time_str;
                    model.type=type;
                    model.status=status;
                    
                    [_datasArrM addObject:model];
                    NSLog(@"_datasArrM=====>%ld",_datasArrM.count);
                }
                
                for (NSDictionary *dict3 in dict1[@"integralGoodsList1"]) {
                    ChunJiFenModel *model=[[ChunJiFenModel alloc] init];
                    
                    NSString *amount=dict3[@"amount"];
                    NSString *end_time_str=dict3[@"end_time_str"];
                    NSString *good_type=dict3[@"good_type"];
                    NSString *id=dict3[@"id"];
                    NSString *name=dict3[@"name"];
                    NSString *pay_integer=dict3[@"pay_integer"];
                    NSString *pay_maney=dict3[@"pay_maney"];
                    NSString *scopeimg=dict3[@"scopeimg"];
                    NSString *start_time_str=dict3[@"start_time_str"];
                    NSString *type =dict3[@"type"];
                    NSString *status =dict3[@"status"];
                    NSString *attribute = dict3[@"is_attribute"];//商品属性；
                    
                    model.attribute = attribute;
                    model.amount=amount;
                    model.end_time_str=end_time_str;
                    model.good_type=good_type;
                    model.id=id;
                    
                    
                    
                    model.name=name;
                    model.pay_integer=pay_integer;
                    model.pay_maney=pay_maney;
                    model.scopeimg=scopeimg;
                    model.start_time_str=start_time_str;
                    model.type=type;
                    model.status=status;
                    
                    [_datasSource addObject:model];
                    
                    NSLog(@"_datasSource=====>%ld",_datasSource.count);
                }
            }
            
            [self initCollection1];
            [self initCollection2];
            
            
            [_tableView reloadData];
            [_collectionView reloadData];
            [_collectionView1 reloadData];
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //        [WKProgressHUD popMessage:@"网络请求失败，请检查您的网络设置" inView:self.view duration:1.5 animated:YES];
        
        [self NoWebSeveice];
        
        NSLog(@"%@",error);
    }];
}

-(void)NoWebSeveice
{
    
    view=[[UIView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    
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
//获取商品详情
-(void)getDetailDatas
{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@getMerchantsGoodsDetails_mob.shtml",URL_Str];
    
    NSDictionary *dic = @{@"id":self.gid};
    
    
    [manager POST:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
        NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];
        
        
        if (codeKey && content) {
            NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
            
//            NSLog(@"xmlStr%@",xmlStr);
            
            
            NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];
            
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            NSLog(@"=====商品详情：%@",dic);
            
            view.hidden=YES;
            
            for (NSDictionary *dict1 in dic) {
                
                
                self.String=dict1[@"status"];
                
                for (NSDictionary *dict2 in dict1[@"list_goods"]) {
                    
                    
                    self.status=dict2[@"status"];
                 
                }
                
                
            }
            
            
            if ([self.String isEqualToString:@"10000"]) {
                
                if ([self.status isEqualToString:@"7"] || [self.status isEqualToString:@"6"]) {
                    
                    NoGoodsDetailViewController *vc=[[NoGoodsDetailViewController alloc] init];
                    
                    [self.navigationController pushViewController:vc animated:NO];
                    
                    self.navigationController.navigationBar.hidden=YES;
                    
                }else if ([self.status isEqualToString:@"0"]) {
                    
//                    NewGoodsDetailViewController *vc=[[NewGoodsDetailViewController alloc] init];
                    
                    YTGoodsDetailViewController *vc=[[YTGoodsDetailViewController alloc] init];
                    
                    vc.ID=self.gid;
                    vc.gid=self.gid;
                    vc.good_type=self.good_type;
                    vc.status=self.status;
                    vc.attribute = self.attribute;
                    
                    vc.Attribute_back=@"2";
                    [self.navigationController pushViewController:vc animated:NO];
                    
                    self.navigationController.navigationBar.hidden=YES;
                }else{
                    
                    
//                    NewGoodsDetailViewController *vc=[[NewGoodsDetailViewController alloc] init];
                    
                    YTGoodsDetailViewController *vc=[[YTGoodsDetailViewController alloc] init];
                    
                    vc.gid=self.gid;
                    vc.good_type=self.good_type;
                    vc.status=self.good_status;
                    vc.attribute = self.attribute;
                    vc.Attribute_back=@"2";
                    
                    [self.navigationController pushViewController:vc animated:NO];
                    
                    self.navigationController.navigationBar.hidden=YES;
                }
                
            }
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
//        [WKProgressHUD popMessage:@"网络请求失败，请检查您的网络设置" inView:self.view duration:1.5 animated:YES];
        
        [self NoWebSeveice];
        
        NSLog(@"%@",error);
    }];
    
}


- (void)createTimer {
    
    self.m_timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(timerEvent) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_m_timer forMode:NSRunLoopCommonModes];
}

- (void)timerEvent {
    
    [_collectionView reloadData];
    [_collectionView1 reloadData];
}

-(void)initTableView
{
    
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 65, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-65) style:UITableViewStylePlain];
    
    _tableView.delegate=self;
    
    _tableView.dataSource=self;
    
    [self.view addSubview:_tableView];
    
    [_tableView registerNib:[UINib nibWithNibName:@"ChunJiFenCell" bundle:nil] forCellReuseIdentifier:@"cell1"];
    
    [_tableView registerNib:[UINib nibWithNibName:@"HomeLookFooter" bundle:nil] forHeaderFooterViewReuseIdentifier:@"header"];
    //点击加载更多
    
    
    _refresh=[[DJRefresh alloc] initWithScrollView:_tableView delegate:self];
    _refresh.topEnabled=YES;//下拉刷新
    _refresh.bottomEnabled=NO;//上拉加载
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        if (_datasArrM.count%2==0) {
            
            return (_datasArrM.count/2)*fheight*4/10+70;
            
        }else{
            
            return ((_datasArrM.count+1)/2)*fheight*4/10+70;
        }
        
    }else{
        
        if (_datasSource.count%2==0) {
        
            return (_datasSource.count/2)*fheight*4/10+70;
            
        }else{
            
            return ((_datasSource.count+1)/2)*fheight*4/10+70;
        }
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 0.00000000000001;
        
    }else if (section==1){
        
        return 0.00000000000001;
    }else{
        return 1;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[UIView alloc]init];
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section==0) {
        return 0.00000000000001;
        
    }else if (section==1){
        
        return 0.00000000000001;
    }else{
        return 1;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [[UIView alloc]init];
}
-(void)initCollection1
{
    CGFloat fWidth=[UIScreen mainScreen].bounds.size.width;
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    //            _collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 40, cell.bounds.size.width, (_datasArrM.count/2)*225+30) collectionViewLayout:flowLayout];
    if (_datasArrM.count%2==0) {
        
        _collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 40, fWidth, (_datasArrM.count/2)*fheight*4/10+30) collectionViewLayout:flowLayout];
        
        
        NSLog(@"=1==height=%f",_collectionView.frame.size.height);
        
//        _collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 40, fWidth, (_datasArrM.count/2)*fheight*4/10) collectionViewLayout:flowLayout];
        
    }else{
        
        _collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 40, fWidth, ((_datasArrM.count+1)/2)*fheight*4/10+30) collectionViewLayout:flowLayout];
        
        NSLog(@"==2=height=%f",_collectionView.frame.size.height);
        
//        _collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 40, fWidth, ((_datasArrM.count+1)/2)*fheight*4/10) collectionViewLayout:flowLayout];
    }
    _collectionView.backgroundColor=[UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1.0];
    
//    _collectionView.backgroundColor=[UIColor orangeColor];
    
    _collectionView.delegate=self;
    
    _collectionView.dataSource=self;
    
    _collectionView.scrollEnabled=NO;
    
    [_collectionView registerNib:[UINib nibWithNibName:@"LimitTimeCell" bundle:nil] forCellWithReuseIdentifier:@"cell2"];
    
}

-(void)initCollection2
{
    
    CGFloat fWidth=[UIScreen mainScreen].bounds.size.width;
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    if (_datasSource.count%2==0) {
        
//        _collectionView1=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 40, fWidth, (_datasSource.count/2)*fheight*4/10+100) collectionViewLayout:flowLayout];
        
    _collectionView1=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 40, fWidth, (_datasSource.count/2)*fheight*4/10+100) collectionViewLayout:flowLayout];
        
        NSLog(@"==3=height=%f",_collectionView1.frame.size.height);
    }else{
        
        _collectionView1=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 40, fWidth, ((_datasSource.count+1)/2)*fheight*4/10+100) collectionViewLayout:flowLayout];
        
        NSLog(@"==4=height=%f",_collectionView1.frame.size.height);
        
    }
    //        _collectionView1=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 40, cell.bounds.size.width, (_datasSource.count/2)*225) collectionViewLayout:flowLayout];
    
    _collectionView1.backgroundColor=[UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1.0];
    
    _collectionView1.delegate=self;
    
    _collectionView1.dataSource=self;
    
    _collectionView1.scrollEnabled=NO;
    
    [_collectionView1 registerNib:[UINib nibWithNibName:@"LimitTimeCell" bundle:nil] forCellWithReuseIdentifier:@"cell2"];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat fWidth=[UIScreen mainScreen].bounds.size.width;
    
    
    if (indexPath.row==0) {
        cell=[tableView dequeueReusableCellWithIdentifier:@"cell1"];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.TypeLabel.text=@"限时抢购";
        str1=@"1";
        cell.TypeImageView.image=[UIImage imageNamed:@"限时抢购@2x"];
        
        
        [self initCollection1];
        
            
        [cell addSubview:_collectionView];
        [cell.ChunJiFenMoreButton addTarget:self action:@selector(ChunJiFenBtnClick) forControlEvents:UIControlEventTouchUpInside];
        return cell;
        
    }else{
        cell=[tableView dequeueReusableCellWithIdentifier:@"cell1"];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.TypeLabel.text=@"即将开抢";
        
        cell.TypeImageView.image=[UIImage imageNamed:@"即将开抢@2x"];
        str2=@"2";
        
        [self initCollection2];
        
        
        [cell addSubview:_collectionView1];
        [cell.ChunJiFenMoreButton addTarget:self action:@selector(ChunJiFenBtnClick1) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
    }
    
}

//更多
-(void)ChunJiFenBtnClick
{
    NowGoingViewController *vc=[[NowGoingViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:NO];
}

-(void)ChunJiFenBtnClick1
{
    NowBuyingViewController *vc=[[NowBuyingViewController alloc] init];
    [self.navigationController pushViewController:vc animated:NO];
}

#pragma mark - collectionView的代理方法
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView==_collectionView) {
        return _datasArrM.count;
    }else{
       return _datasSource.count;
    }
}



-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((fwidth-10)/2, fheight*4/10);
}

//最小行间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}
//最小行内部cell的间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

//section的边距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    //上,左,下,右
    return UIEdgeInsetsMake(0, 0, 5, 0);
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LimitTimeCell *cell1=[collectionView dequeueReusableCellWithReuseIdentifier:@"cell2" forIndexPath:indexPath];
    
//    if ([str1 isEqualToString:@"1"]) {
    
    if (collectionView==_collectionView) {
        
        ChunJiFenModel *model=_datasArrM[indexPath.row];
        
//        [cell1.GoosImageView sd_setImageWithURL:[NSURL URLWithString:model.scopeimg]];
        
        [cell1.GoosImageView sd_setImageWithURL:[NSURL URLWithString:model.scopeimg] placeholderImage:[UIImage imageNamed:@"default_image"] options:SDWebImageProgressiveDownload];
        
        cell1.NameLabel.text=model.name;
        
        cell1.start_time_str=model.start_time_str;
        cell1.end_time_str=model.end_time_str;
        NSLog(@"^^^^^^^^^^^%@==%@",cell1.start_time_str,cell1.end_time_str);
        
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.0"];
        NSDate *end=[dateFormatter dateFromString:cell1.end_time_str];
        NSDate *timedata = [NSDate date];
        //        NSDate *start=[dateFormatter dateFromString:];
        
        
        NSLog(@"=========end_time_str:%@",end);
        //            NSLog(@"=========start_time_str:%@",start);
        
        
        NSTimeInterval _end=[end timeIntervalSince1970];
        
        NSTimeInterval _start=[timedata timeIntervalSince1970];
        
        NSInteger time=(NSInteger)(_end - _start);
        NSLog(@"*****%ld",time);
        
        TimeModel *model2 = [[TimeModel alloc]init];
        model2.m_countNum = (int)time;
        [cell1 loadData:model2 indexPath:indexPath type:@"2"];
        
        
//        cell1.ShiJianLabel.text=@"后停止";
        
        
//        UILabel *label1=[[UILabel alloc] initWithFrame:CGRectMake((fwidth)*4/13, 45, 50, 20)];
//        label1.text=@"后停止";
//        label1.textColor=[UIColor whiteColor];
//        label1.font=[UIFont systemFontOfSize:13];
//        [cell1 addSubview:label1];
        
        if (time <= 0) {
            
//            clockView.hidden=YES;
            cell1.ShiJianLabel.hidden=YES;
//            cell1.TimeLabel.hidden=YES;
            
            cell1.TimeLabel.text=@"已停止抢购";
            
            
            UILabel *newLabel1=[[UILabel alloc] initWithFrame:CGRectMake(cell1.frame.size.width-20, 45, cell1.frame.size.width-40, 20)];
            newLabel1.text=@"已停止抢购";
            newLabel1.textAlignment=NSTextAlignmentCenter;
            newLabel1.textColor=[UIColor whiteColor];
            newLabel1.font=[UIFont systemFontOfSize:16];
//            [cell1 addSubview:newLabel1];
            
            NSLog(@"==1===indexPath.row===%ld",(long)indexPath.row);
            
            [_StopArrM addObject:[NSString stringWithFormat:@"%ld",indexPath.row]];
            

           
            
         }

        
        cell1.AmountLabel.text=[NSString stringWithFormat:@"%@人付款",model.amount];
        if ([model.pay_integer isEqualToString:@"0.00"]) {
            cell1.PriceLabel.text=[NSString stringWithFormat:@"￥%.02f",[model.pay_maney floatValue]];
        }else if ([model.pay_maney isEqualToString:@"0.00"]){
            cell1.PriceLabel.text=[NSString stringWithFormat:@"%.02f积分",[model.pay_integer floatValue]];
        }else{
            cell1.PriceLabel.text=[NSString stringWithFormat:@"￥%.02f+%.02f积分",[model.pay_maney floatValue],[model.pay_integer floatValue]];
        }
    }else{
        
        ChunJiFenModel *model=_datasSource[indexPath.row];
        
 //       [cell1.GoosImageView sd_setImageWithURL:[NSURL URLWithString:model.scopeimg]];
        
        [cell1.GoosImageView sd_setImageWithURL:[NSURL URLWithString:model.scopeimg] placeholderImage:[UIImage imageNamed:@"default_image"] options:SDWebImageProgressiveDownload];
        cell1.NameLabel.text=model.name;
        
        cell1.start_time_str=model.start_time_str;
        cell1.end_time_str=model.end_time_str;
        NSLog(@"^^^^^^^^^^^%@==%@",cell1.start_time_str,cell1.end_time_str);
        
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.0"];
        NSDate *end=[dateFormatter dateFromString:cell1.start_time_str];
        NSDate *timedata = [NSDate date];
        //        NSDate *start=[dateFormatter dateFromString:];
        
        
        NSLog(@"=========end_time_str:%@",end);
        //            NSLog(@"=========start_time_str:%@",start);
        
        
        NSTimeInterval _end=[end timeIntervalSince1970];
        
        NSTimeInterval _start=[timedata timeIntervalSince1970];
        
        NSInteger time=(NSInteger)(_end - _start);
        NSLog(@"*****%ld",time);
        TimeModel *model2 = [[TimeModel alloc]init];
        model2.m_countNum = (int)time;
        [cell1 loadData:model2 indexPath:indexPath type:@"1"];
        
//        cell1.ShiJianLabel.text=@"后开始";
//        UILabel *label2=[[UILabel alloc] initWithFrame:CGRectMake((fwidth)*4/13, 45, 50, 20)];
//        label2.text=@"后开始";
//        label2.textColor=[UIColor whiteColor];
//        label2.font=[UIFont systemFontOfSize:13];
//        [cell1 addSubview:label2];
        
        if (time <= 0) {
            
//            clockView.hidden=YES;
//            label2.hidden=YES;
            
            cell1.ShiJianLabel.hidden=YES;
//            cell1.TimeLabel.hidden=YES;
            
            cell1.TimeLabel.text=@"已开始抢购";
            
            UILabel *newLabel2=[[UILabel alloc] initWithFrame:CGRectMake(cell1.frame.size.width-20, 45, cell1.frame.size.width-40, 20)];
            newLabel2.text=@"已开始抢购";
            newLabel2.textAlignment=NSTextAlignmentCenter;
            newLabel2.textColor=[UIColor whiteColor];
            newLabel2.font=[UIFont systemFontOfSize:16];
//            [cell1 addSubview:newLabel2];
            
            NSLog(@"==2===indexPath.row===%ld",indexPath.row);
            
            [_StartArrM addObject:[NSString stringWithFormat:@"%ld",indexPath.row]];

            
            
            
        }
        cell1.AmountLabel.text=[NSString stringWithFormat:@"%@人付款",model.amount];
        if ([model.pay_integer isEqualToString:@"0.00"]) {
            cell1.PriceLabel.text=[NSString stringWithFormat:@"￥%.02f",[model.pay_maney floatValue]];
        }else if ([model.pay_maney isEqualToString:@"0.00"]){
            cell1.PriceLabel.text=[NSString stringWithFormat:@"%.02f积分",[model.pay_integer floatValue]];
        }else{
            cell1.PriceLabel.text=[NSString stringWithFormat:@"￥%.02f+%.02f积分",[model.pay_maney floatValue],[model.pay_integer floatValue]];
        }
        //    }
        
    }
    
    return cell1;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld",indexPath.row);
    
//    NSString *str=[NSString stringWithFormat:@"%ld",indexPath.row];
//    NSString *str2;
    if (collectionView==_collectionView) {
        ChunJiFenModel *model=_datasArrM[indexPath.row];
        
        
        self.gid=model.id;
        
//        self.gid=model.id;
        self.good_type=model.good_type;
        self.good_status=model.status;
        self.attribute = model.attribute;
        [self getDetailDatas];
    }else if (collectionView==_collectionView1){
        ChunJiFenModel *model=_datasSource[indexPath.row];
        
        
        self.gid=model.id;
        self.good_type=model.good_type;
        self.good_status=model.status;
        self.attribute = model.attribute;
        [self getDetailDatas];
        
//        if ([self.String isEqualToString:@"10000"]) {
//            
//            if ([self.status isEqualToString:@"0"]) {
//                
//                NewGoodsDetailViewController *vc=[[NewGoodsDetailViewController alloc] init];
//                
//                vc.gid=model.id;
//                vc.good_type=model.good_type;
//                vc.status=self.status;
//                
//                [self.navigationController pushViewController:VC animated:NO];
//                
//                self.navigationController.navigationBar.hidden=YES;
//            }else{
//                
//                
//                NewGoodsDetailViewController *vc=[[NewGoodsDetailViewController alloc] init];
//                
//                vc.gid=model.id;
//                vc.good_type=model.good_type;
//                vc.status=model.status;
//                
//                [self.navigationController pushViewController:VC animated:NO];
//                
//                self.navigationController.navigationBar.hidden=YES;
//            }
//        }
    }
}
- (IBAction)backBtnClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
    self.tabBarController.tabBar.hidden=NO;
}


-(void)timeGo
{
    //日期转换为时间戳 (日期转换为秒数)
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.0"];
    
    NSDate *date3 = [NSDate dateWithTimeIntervalSinceNow:0];
    
    //    NSDate *date1 = [dateFormatter dateFromString:@"2016-02-02 16:00:00.0"];
    NSDate *date2 = [dateFormatter dateFromString:@"2016-06-18 21:30:00.0"];
    
    NSDate *num1 = [self getNowDateFromatAnDate:date3];
    
    NSDate *num2=[self getNowDateFromatAnDate:date2];
    
    //    NSLog(@"=========当前日期为:%@",num1);
    //    NSLog(@"=========结束日期为:%@",num2);
    
    NSTimeInterval hh1= [num1 timeIntervalSince1970];
    
    NSTimeInterval hh2 = [num2 timeIntervalSince1970];
    
    NSInteger times=(NSInteger)(hh2 - hh1);
    
    
    
    NSDate *end=[dateFormatter dateFromString:self.end_time_str];
    NSDate *start=[dateFormatter dateFromString:self.start_time_str];
    
    
    NSLog(@"=========end_time_str:%@",end);
    NSLog(@"=========start_time_str:%@",start);
    
    
    NSTimeInterval _end=[end timeIntervalSince1970];
    
    NSTimeInterval _start=[start timeIntervalSince1970];
    
    NSInteger time=(NSInteger)(_end - _start);
    NSLog(@"--------->%ld",time);
    
//    GGClockView *clockView = [[GGClockView alloc] init];
//    clockView.frame = CGRectMake(10, 25, 125, 40);
//    
//    clockView.time = time;
//    [self addSubview:clockView];
//    self.clockView = clockView;
//    
//    
//    UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(90, 35, 45, 20)];
//    label.text=@"后开始";
//    label.textColor=[UIColor whiteColor];
//    
//    label.font=[UIFont systemFontOfSize:13];
//    
//    [self addSubview:label];
}
- (NSDate *)getNowDateFromatAnDate:(NSDate *)anyDate
{
    //设置源日期时区
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

//刷新

- (void)refresh:(DJRefresh *)refresh didEngageRefreshDirection:(DJRefreshDirection)direction{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self addDataWithDirection:direction];
    });
    
}

- (void)addDataWithDirection:(DJRefreshDirection)direction{
    
    if (direction==DJRefreshDirectionTop) {
        
        
        //清空数据源
        [_datasArrM removeAllObjects];
        
        [_datasSource removeAllObjects];
        
        //获取数据
//        [self YTgetDatas];
        
        [self getDatas];
        
        
        
        
//        WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
//        
//        dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
//        dispatch_after(time, dispatch_get_main_queue(), ^{
//            
//            [hud dismiss:YES];
//        });
    }
    
    
    
    [_refresh finishRefreshingDirection:direction animation:YES];
    
//    [_tableView reloadData];
    
}

//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    return 44;
//}
//
//
//-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//    HomeLookFooter *footer=[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
//    
//    footer.delegate=self;
//    
//    return footer;
//}
////加载更多数据代理方法
//- (void)FooterViewClickedloadMoreData
//{
//    
//    NSLog(@"点击加载更多");
//    
//}
@end
