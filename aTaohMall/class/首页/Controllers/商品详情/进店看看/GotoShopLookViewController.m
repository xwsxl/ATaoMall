//
//  GotoShopLookViewController.m
//  aTaohMall
//
//  Created by JMSHT on 16/5/16.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import "GotoShopLookViewController.h"

#import "GotoShopLookHeaderView.h"//头部

#import "LimitTimeCell.h"

#import "ClassifyControllectionCell.h"


#import "HomeLookAllCell1.h"
#import "GoToShopModel.h"

#import "AFNetworking.h"

#import "ConverUtil.h"
#import "DESUtil.h"
#import "SecretCodeTool.h"

#import "UIImageView+WebCache.h"

#import "ShopAddressViewController.h"
#import "NewGoodsDetailViewController.h"//商品详情

#import "WKProgressHUD.h"

#import "GGClockView.h"//倒计时（计算器）
//刷新
#import "DJRefresh.h"
#import "DJRefreshProgressView.h"
#import "GotoShopLimitCell.h"
#import "NineFooterView.h"
#import "TimeModel.h"

#import "YTGoodsDetailViewController.h"

#import "NoCollectionViewCell.h"
#import "AoiroSoraLayout.h"
@interface GotoShopLookViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UITableViewDataSource,UITableViewDelegate,DJRefreshDelegate,FooterViewDelegate,AoiroSoraLayoutDelegate>
{
    UICollectionView *_collectionView;
    NSMutableArray *_ArrM1;
    NSMutableArray *_ArrM2;
    
    NineFooterView *footer;
    GotoShopLookHeaderView * _headerView;
    int page;
    int currentPageNo;
    NSString *string10;
    
    UIView *view;
    
    GotoShopLimitCell *cell1;
    
}

//@property (nonatomic,strong)DJRefresh *refresh;

@property (nonatomic,strong)DJRefresh *refresh;
@property (nonatomic, strong) NSTimer        *m_timer; //定时器
@end

@implementation GotoShopLookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.frame=[UIScreen mainScreen].bounds;
//    [self initCollectionView];
    
    
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    
    _ArrM1=[NSMutableArray new];
    _ArrM2=[NSMutableArray new];
    
    page=0;
    currentPageNo=1;
    
   [self  initCollectionView];
    
    
       //获取数据
    [self getDatas];
    
//        WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
//        dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
//        dispatch_after(time, dispatch_get_main_queue(), ^{
//            [hud dismiss:YES];
//        });
    
    [self createTimer];
    
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(TimeStop3:) name:@"TimeStop3" object:nil];
    
    
}

- (void)TimeStop3:(NSNotification *)text{
    
    
    [_ArrM1 removeAllObjects];
    [_ArrM2 removeAllObjects];
    
    [self getDatas];
    
}

-(void)getDatas
{
//    [_ArrM1 removeAllObjects];
//    [_ArrM2 removeAllObjects];
    
    
    WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        
    });
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@getMerchantsDetails_mob.shtml",URL_Str];
    
//    NSLog(@"====%@",self.mid);
    
    NSDictionary *dic = @{@"mid":self.mid,@"page":[NSString stringWithFormat:@"%d",page],@"currentPageNo":[NSString stringWithFormat:@"%d",currentPageNo]};
    
    //    NSDictionary *dic=nil;
    
    [manager POST:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
        NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];
        
        
        
        
        if (codeKey && content) {
            NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
            
            NSLog(@"xmlStr=====%@",xmlStr);
            
            
            NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];
            
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            NSLog(@"%@",dic);
            
            view.hidden=YES;
            
            for (NSDictionary *dict1 in dic) {
                string10 = dict1[@"totalCount"];
                for (NSDictionary *dict2 in dict1[@"goods_list"]) {
                    GoToShopModel *model=[[GoToShopModel alloc] init];
                    
                    model.amount=dict2[@"amount"];
                    
                    model.good_type=dict2[@"good_type"];
                    model.name=dict2[@"name"];
                    model.pay_integer=dict2[@"pay_integer"];
                    model.pay_maney=dict2[@"pay_maney"];
                    model.scopeimg=dict2[@"scopeimg"];
                    
                    model.status=dict2[@"status"];
                    model.good_type=dict2[@"good_type"];
                    model.id=dict2[@"id"];
                    model.type=dict2[@"type"];
                    model.attribute = dict2[@"is_attribute"];
                    
                    
                    if ([model.good_type isEqualToString:@"1"]) {
                        
                        model.end_time_str=dict2[@"end_time_str"];
                        
                        model.start_time_str=dict2[@"start_time_str"];
                        
                        model.current_time_stamp = dict2[@"current_time_stamp"];
                    }
                    
                    
//                    NSNull *null=[[NSNull alloc] init];
//                    
//                    if ([dict2[@"integral_type"] isEqual:null]) {
//                    
//                        model.integral_type=@"0";
//                    
//                    }else{
//                    
//                        model.integral_type=dict2[@"integral_type"];
//                    }
                    
                    
                    [_ArrM1 addObject:model];
                    
//                    NSLog(@"======%ld",_ArrM1.count);
//                    if (_ArrM1.count%12==0) {
//                        
//                        footer.hidden=NO;
//                        
//                    }else{
//                        
//                        //隐藏点击加载更多
//                        footer.hidden=YES;
//                        
//                    }
                }
                
                for (NSDictionary *dict3 in dict1[@"list_merchant"]) {
                    
                    GoToShopModel *model1=[[GoToShopModel alloc] init];
                    
                    model1.city=dict3[@"city"];
                    model1.coordinates=dict3[@"coordinates"];
                    model1.county=dict3[@"county"];
                    model1.logo=dict3[@"logo"];
                    model1.mobile=dict3[@"mobile"];
                    model1.province=dict3[@"province"];
                    model1.storename=dict3[@"storename"];
                    model1.scope=dict3[@"scope"];
                    model1.storephone=dict3[@"storephone"];
                    model1.tid=dict3[@"tid"];
                    model1.note=dict3[@"note"];
                    [_ArrM2 addObject:model1];
                }
                
            }
            
            if (_ArrM1.count%12==0&&_ArrM1.count !=[string10 integerValue]) {
                
                footer.hidden=NO;
                [footer.loadMoreBtn setTitle:@"点击加载更多" forState:0];
//                [footer.loadMoreBtn setTitleColor:[UIColor colorWithRed:91/255.0 green:150/255.0 blue:255/255.0 alpha:1.0] forState:0];
                footer.loadMoreBtn.enabled=YES;
                
            }else if (_ArrM1.count == [string10 integerValue]){
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
            
            [_collectionView reloadData];
            

            
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
//        [WKProgressHUD popMessage:@"网络请求失败，请检查您的网络设置" inView:self.view duration:1.5 animated:YES];
        
        [hud dismiss:YES];
        
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
- (void)createTimer {
    
    self.m_timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(timerEvent) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_m_timer forMode:NSRunLoopCommonModes];
}

- (void)timerEvent {
    
    [_collectionView reloadData];
}

-(void)initCollectionView
{
    
    AoiroSoraLayout * layout = [[AoiroSoraLayout alloc]init];
    layout.interSpace = 5; // 每个item 的间隔
    layout.edgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    layout.colNum = 2; // 列数;
    layout.delegate = self;
    
    
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    
    
    _collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 66, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-66) collectionViewLayout:flowLayout];
    
    
    [_collectionView registerNib:[UINib nibWithNibName:@"NineFooterView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
    [_collectionView registerNib:[UINib nibWithNibName:@"GotoShopLookHeaderView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    [_collectionView registerNib:[UINib nibWithNibName:@"HomeLookAllCell1" bundle:nil] forCellWithReuseIdentifier:@"cell2"];
    [_collectionView registerNib:[UINib nibWithNibName:@"GotoShopLimitCell" bundle:nil] forCellWithReuseIdentifier:@"cell6"];
    
    [_collectionView registerNib:[UINib nibWithNibName:@"NoCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"YTCell"];
    
    _collectionView
        .backgroundColor=[UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1.0];
    _collectionView.delegate=self;
    
    _collectionView.dataSource=self;
    
//    点击加载更多
    
    
        _refresh=[[DJRefresh alloc] initWithScrollView:_collectionView delegate:self];
        _refresh.topEnabled=YES;//下拉刷新
        _refresh.bottomEnabled=NO;//上拉加载

    
    [self.view addSubview:_collectionView];
    
    
}


-(void)LookAddressBtnClick
{
    ShopAddressViewController *vc=[[ShopAddressViewController alloc] init];
    vc.mid=self.mid;
    
    [self.navigationController pushViewController:vc animated:NO];
    
    self.navigationController .navigationBar.hidden=YES;
}
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 200;
//}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _ArrM1.count;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    GoToShopModel *model=_ArrM1[indexPath.row];
//    
//    if ([model.good_type isEqualToString:@"1"]) {
//        
//        return CGSizeMake(([UIScreen mainScreen].bounds.size.width-35)/2, 265/*([UIScreen mainScreen].bounds.size.height)/2.5*/);
//    }else{
    
        return CGSizeMake(([UIScreen mainScreen].bounds.size.width-35)/2, ([UIScreen mainScreen].bounds.size.height)/2.5);
//    }
    
}

//最小行间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 2.5;
}
//最小行内部cell的间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 2.5;
}

//section的边距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    //上,左,下,右
    return UIEdgeInsetsMake(0, 15, 5, 15);
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (_ArrM1.count==0) {
        
        NoCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"YTCell" forIndexPath:indexPath];
        
        return cell;
        
    }else{
        
        GoToShopModel *model=_ArrM1[indexPath.row];
        
        NSNull *null=[[NSNull alloc] init];
        
        if ([model.good_type isEqualToString:@"1"] && [model.status isEqualToString:@"4"]) {
            
            cell1=[collectionView dequeueReusableCellWithReuseIdentifier:@"cell6" forIndexPath:indexPath];
            
            //        [cell.GoosImageView sd_setImageWithURL:[NSURL URLWithString:model.scopeimg]];
            if (![model.scopeimg isEqual:null]) {
                //            [cell.GoosImageView sd_setImageWithURL:[NSURL URLWithString:model.scopeimg]];
                
                [cell1.GoosImageView sd_setImageWithURL:[NSURL URLWithString:model.scopeimg] placeholderImage:[UIImage imageNamed:@"default_image"] options:SDWebImageProgressiveDownload];
            }
            
            cell1.start_time_str=model.start_time_str;
            cell1.end_time_str=model.end_time_str;
            
            cell1.current_time_stamp=model.current_time_stamp;
            
//            NSLog(@"^^^^^^^^^^^%@==%@",cell.start_time_str,cell.end_time_str);
            
            
//            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.0"];
//            
//            //当前时间
//            //    NSDate *date3 = [NSDate dateWithTimeIntervalSinceNow:0];
//            
//            NSDate *date3 = [dateFormatter dateFromString:model.current_time_stamp];
//            
//            //    NSDate *date1 = [dateFormatter dateFromString:@"2016-02-02 16:00:00.0"];
//            NSDate *date2 = [dateFormatter dateFromString:model.end_time_str];
//            
//            
//            
//            
//            NSDate *num1 = [self getNowDateFromatAnDate:date3];
//            NSDate *num2=[self getNowDateFromatAnDate:date2];
//            
////            
////            NSLog(@"=====66666====当前日期为:%@",num1);
////            NSLog(@"=====66666====结束日期为:%@",num2);
//            
//            NSTimeInterval hh1= [num1 timeIntervalSince1970];
//            
//            NSTimeInterval hh2 = [num2 timeIntervalSince1970];
//            
//            
//            NSInteger times;
//            
//            
//            times=hh2-hh1;
//            
//            cell1.time=times;
            
            
            
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.0"];
            NSDate *end=[dateFormatter dateFromString:cell1.end_time_str];
            
            NSDate *startdata=[dateFormatter dateFromString:cell1.current_time_stamp];
        
            NSDate *timedata = [NSDate date];
            //        NSDate *start=[dateFormatter dateFromString:];
            
            
            NSLog(@"====))))))(((((=====end_time_str:%@=======%@==startdata==%@==",end,timedata,startdata);
            //            NSLog(@"=========start_time_str:%@",start);
            
            
            NSTimeInterval _end=[end timeIntervalSince1970];
            
            NSTimeInterval _start=[timedata timeIntervalSince1970];
            
            NSTimeInterval start=[startdata timeIntervalSince1970];
            
            
            NSInteger time=(NSInteger)(_end - _start);
            
            
            NSInteger time1=(NSInteger)(_end - start);
            
            NSLog(@"*****%ld=====%ld",time,time1);
            
            TimeModel *model2 = [[TimeModel alloc]init];
            model2.m_countNum = (int)time+3;
            
//            [model2 countDown];
            
            [cell1 loadData:model2 indexPath:indexPath type:@"1"];
            
            
            
            
            cell1.GoodsNameLabel.text=model.name;
            cell1.GoodsAmountLabel.text=[NSString stringWithFormat:@"%@人付款",model.amount];
                cell1.GoodsPriceLabel.text=[NSString stringWithPrice:model.pay_maney andInterger:model.pay_integer];


            return cell1;
            
            
        }
        
        else{
            
            HomeLookAllCell1 *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cell2" forIndexPath:indexPath];
            if (![model.scopeimg isEqual:null]) {
                //            [cell.GoodsImageView sd_setImageWithURL:[NSURL URLWithString:model.scopeimg]];
                
                [cell.GoodsImageView sd_setImageWithURL:[NSURL URLWithString:model.scopeimg] placeholderImage:[UIImage imageNamed:@"default_image"] options:SDWebImageProgressiveDownload];
            }
            
            
            cell.GoodsNameLabel.text=model.name;
            cell.GoodsAmountLabel.text=[NSString stringWithFormat:@"%@人付款",model.amount];
            cell.GoodsPriceLabel.text=[NSString stringWithPrice:model.pay_maney andInterger:model.pay_integer];

            return cell;
        }
    }
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"%ld",indexPath.row);
    GoToShopModel *model=_ArrM1[indexPath.row];
    
//    NewGoodsDetailViewController *vc=[[NewGoodsDetailViewController alloc] init];
    
    YTGoodsDetailViewController *vc=[[YTGoodsDetailViewController alloc] init];
    
    vc.gid=model.id;
    vc.ID=model.id;
    vc.status=model.status;
    vc.good_type=model.good_type;
    vc.attribute = model.attribute;
    
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


//返回
- (IBAction)backBtnClick:(UIButton *)sender {
    
    
//    cell1.timer = nil;
//    cell1.time=0;
//    [_collectionView reloadData];
    
    NSLog(@"00000000000");
    
//    
//    if (_delegate && [_delegate respondsToSelector:@selector(reloadData)]) {
//        
//        [_delegate reloadData];
//        
//    }
    
    
    if ([self.type isEqualToString:@"1"]) {
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }else if([self.type isEqualToString:@"2"]){
        
        if (_delegate && [_delegate respondsToSelector:@selector(reloadData)]) {
            
            [_delegate reloadData];
            
        }
        [self.navigationController popViewControllerAnimated:YES];
        
        self.navigationController.navigationBar.hidden=NO;
        self.tabBarController.tabBar.hidden=NO;
        
        
    }else if ([self.type isEqualToString:@"3"]){
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }else if ([self.type isEqualToString:@"10"]){
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }else{
        
        
        if ([self.BackString isEqualToString:@"100"]) {
            
            self.tabBarController.tabBar.hidden=NO;
            
        }
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    
    
}


- (void)refresh:(DJRefresh *)refresh didEngageRefreshDirection:(DJRefreshDirection)direction{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self addDataWithDirection:direction];
    });
    
}

- (void)addDataWithDirection:(DJRefreshDirection)direction{
    
    if (direction==DJRefreshDirectionTop) {
        
        page=0;
        currentPageNo=1;
        
        
        
        [_ArrM1 removeAllObjects];
        
        [_ArrM2 removeAllObjects];
        
        //获取数据
        [self getDatas];

    }
    
    
    
    [_refresh finishRefreshingDirection:direction animation:YES];
    
    [_collectionView reloadData];
    
}

//返回header的高度
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{

    return CGSizeMake(0, 250);
}

//footer

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind==UICollectionElementKindSectionFooter) {
        
        footer=[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer" forIndexPath:indexPath];
        
        footer.delegate=self;
        if (_ArrM1.count == 0) {
            footer.hidden = YES;
        }
        return footer;
    }else if(kind==UICollectionElementKindSectionHeader){
        
        _headerView=[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
        
//        _headerView.backgroundColor=[UIColor whiteColor];
        _headerView
        .backgroundColor=[UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1.0];
            for (GoToShopModel *model in _ArrM2) {
//                [_headerView.ShopImageView sd_setImageWithURL:[NSURL URLWithString:model.logo]];
                
                [_headerView.ShopImageView sd_setImageWithURL:[NSURL URLWithString:model.logo] placeholderImage:[UIImage imageNamed:@"default_image"] options:SDWebImageProgressiveDownload];
                _headerView.ShopNameLabel.text=model.storename;
        
                _headerView.ShopTypeLabel.text=[NSString stringWithFormat:@"行业类别：%@",model.tid];
        
                _headerView.ShopReduceLabel.text=[NSString stringWithFormat:@"店铺介绍：%@",model.note];
        
        
            }
            NSLog(@"button======%@",_headerView.ShopAddressButton);
            [_headerView.ShopAddressButton addTarget:self action:@selector(LookAddressBtnClick) forControlEvents:UIControlEventTouchUpInside];
//        header.delegate=self;
        
        return _headerView;
    }else{
        
        return nil;
    }
    
    
}
//返回footer的高度
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeMake([UIScreen mainScreen].bounds.size.width-20, 44);
}
//加载更多数据代理方法
- (void)FooterViewClickedloadMoreData
{
    
    NSLog(@"点击加载更多");
    if (_ArrM1.count%12==0) {
        
        currentPageNo=currentPageNo+1;
        
        page=page+12;
        
        //获取数据
        [self getDatas];
        
        
        [_collectionView reloadData];
        
    }else{
        
        //        footer
    }

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
@end
