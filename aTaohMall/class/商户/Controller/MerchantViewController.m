//
//  MerchantViewController.m
//  aTaohMall
//
//  Created by JMSHT on 2017/3/7.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "MerchantViewController.h"

#import "MerchantCell.h"

#import "MerchantModel.h"

#import "HTTPRequestManager.h"

#import "WKProgressHUD.h"

#import "UIImageView+WebCache.h"

#import "AFNetworking.h"//网络请求
//加密
#import "ConverUtil.h"
#import "DESUtil.h"
#import "SecretCodeTool.h"

//刷新
#import "DJRefresh.h"
#import "DJRefreshProgressView.h"

#import "HomeLookFooter.h"//点击加载更多

#import "MerchantSearchViewController.h"

#import "MerchantDetailViewController.h"

#import "MerchantMapViewController.h"//商圈地图


//MapKit是原生地图框架
#import <MapKit/MapKit.h>

//CoreLocation是定位框架
#import <CoreLocation/CoreLocation.h>

@interface MerchantViewController ()<UITableViewDelegate,UITableViewDataSource,DJRefreshDelegate,FooterViewDelegate,MerchantDetailDelegate,MKMapViewDelegate, CLLocationManagerDelegate>
{
    
    UITableView *_tableView;
    
    int _num;
    
    int gogo;
    
    NSMutableArray *_dataArrM;
    
    HomeLookFooter *footer;
    
    NSString *string10;
    
    //地图View
    MKMapView *_mapView;
    
    //定位管理器
    CLLocationManager *_locationManager;
    
}

@property (nonatomic,strong)DJRefresh *refresh;


@end

@implementation MerchantViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.hidden=YES;
    
    
    _num =0;
    
    
    _dataArrM = [NSMutableArray new];
    
    //创建自定义导航栏
    
    [self initNav];
    
    
    [self initTableView];
    
    [self GetDatas];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notification) name:@"notification" object:nil];
    
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

-(void)notification
{
    _num=0;
    
    [_dataArrM removeAllObjects];
    //获取数据
    [self GetDatas];
    
}
-(void)initNav
{
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, KSafeAreaTopNaviHeight)];
    
    titleView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:titleView];
    
    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight, [UIScreen mainScreen].bounds.size.width, 1)];
    
    line.image = [UIImage imageNamed:@"分割线-拷贝"];
    
    [self.view addSubview:line];
    
    
    //商圈按钮
    
    UIButton *Qurt = [UIButton buttonWithType:UIButtonTypeCustom];
    
    Qurt.frame = CGRectMake([UIScreen mainScreen].bounds.size.width*0.8266+20, 25+KSafeTopHeight, 30, 30);
    
    [Qurt setTitle:@"商圈" forState:0];
    
    [Qurt setTitleColor:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0] forState:0];
    
    Qurt.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
    
    
    [Qurt addTarget:self action:@selector(QurtBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [titleView addSubview:Qurt];
    
    //创建搜索
    
    UIImageView *searchImgView=[[UIImageView alloc] initWithFrame:CGRectMake(15, 25+KSafeTopHeight, [UIScreen mainScreen].bounds.size.width*0.8266-10, 28)];
    searchImgView.image=[UIImage imageNamed:@"搜索框New"];
    [titleView addSubview:searchImgView];
    
    //搜索添加手势
    searchImgView.userInteractionEnabled = YES;
    UITapGestureRecognizer *imgRecongnizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headSearchClick:)];
    
    [searchImgView addGestureRecognizer:imgRecongnizer];
    
    UIImageView *imgView=[[UIImageView alloc] initWithFrame:CGRectMake(15+10, 25+8+KSafeTopHeight, 12, 12)];
    imgView.image=[UIImage imageNamed:@"搜索New"];
    [titleView addSubview:imgView];
    
    UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(50, 30+KSafeTopHeight, 240, 20)];
    label.text=@"请输入您要搜索的商户名";
    label.textColor=[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    label.textAlignment=NSTextAlignmentLeft;
    label.font=[UIFont fontWithName:@"PingFang-SC-Regular" size:12];
    [titleView addSubview:label];
    

}

-(void)initTableView
{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-49-KSafeAreaTopNaviHeight-KSafeAreaBottomHeight) style:UITableViewStyleGrouped];
    
    _tableView.delegate=self;
    
    _tableView.dataSource=self;
    
    _tableView.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];
    
    //去掉系统分割线
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:_tableView];
    
    [_tableView registerClass:[MerchantCell class] forCellReuseIdentifier:@"cell"];
    
    [_tableView registerNib:[UINib nibWithNibName:@"HomeLookFooter" bundle:nil] forHeaderFooterViewReuseIdentifier:@"header"];
    
    _refresh=[[DJRefresh alloc] initWithScrollView:_tableView delegate:self];
    _refresh.topEnabled=YES;//下拉刷新
    _refresh.bottomEnabled=NO;//上拉加载
    
}


-(void)GetDatas
{
    
    WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
    
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        
    });
    
    
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSDictionary *dict=@{@"flag":[NSString stringWithFormat:@"%d",_num],@"tradingArea":@""};
    
    //    NSString *url=[NSString stringWithFormat:@"%@getMoreMerchants_mob.shtml",URL_Str];
    NSString *url=[NSString stringWithFormat:@"%@getTradingArea_mob.shtml",URL_Str];
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
            
            NSLog(@"dict==商户数据==%@",xmlStr);
            
            if (_num == 0) {
                
                
                [_dataArrM removeAllObjects];
                
            }
            
            for (NSDictionary *dict in dic) {
                NSLog(@"状态码 == %@",dict[@"status"]);
                NSDictionary *dict1=dict[@"tradingAreaList"];
                
                
                string10 = [NSString stringWithFormat:@"%@",dict[@"totalCount"]];
                
                for (NSDictionary *dict in dict1) {
                    
                    MerchantModel *model=[[MerchantModel alloc] init];
                    
                    model.click_volume = [NSString stringWithFormat:@"%@",dict[@"click_volume"]];
                    model.mid = [NSString stringWithFormat:@"%@",dict[@"id"]];
                    model.logo = [NSString stringWithFormat:@"%@",dict[@"logo"]];
                    model.storename = [NSString stringWithFormat:@"%@",dict[@"storename"]];
                    model.scope = [NSString stringWithFormat:@"%@",dict[@"scope"]];
                    model.OneCoordinates = [NSString stringWithFormat:@"%@",dict[@"coordinates"]];
                    
                    NSLog(@"====storename===%@",model.storename);
                    
                    [_dataArrM addObject:model];
                    
                    
                }
                
                
                [hud dismiss:YES];
                
                
                NSLog(@"====_dataArrM.count====%ld",_dataArrM.count);
                
                if (_dataArrM.count%12==0&&_dataArrM.count !=[string10 integerValue]) {
                    
                    footer.hidden=NO;
                    [footer.loadMoreBtn setTitle:@"点击加载更多" forState:0];
                    footer.loadMoreBtn.enabled=YES;
                    
                }else if (_dataArrM.count == [string10 integerValue]){
                    footer.hidden = NO;
                    footer.moreView.hidden=YES;
                    [footer.loadMoreBtn setTitle:@"暂无更多数据" forState:0];
                    [footer.loadMoreBtn setTitleColor:[UIColor colorWithRed:154/255.0 green:154/255.0 blue:154/255.0 alpha:1.0] forState:0];
                    footer.loadMoreBtn.enabled=NO;
                    
                    
                }else{
                    
                    //隐藏点击加载更多
                    footer.hidden=YES;
                    
                }
                
                
                if (gogo==100) {
                    
                     [_tableView setContentOffset:CGPointZero animated:NO];
                    
                }
                //刷新数据
                [_tableView reloadData];
                
            }
            
            
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
    
        [hud dismiss:YES];
        
//        [self NoWebSeveice];
        
        
        NSLog(@"errpr = %@",error);
    }];
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 0.00000000001;
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[UIView alloc]init];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _dataArrM.count;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 105;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSNull *null = [[NSNull alloc] init];
    
    MerchantCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    MerchantModel *model = _dataArrM[indexPath.row];
    
    
    if ([model.logo isEqual:null]) {
        
        cell.ShopImgView.image = [UIImage imageNamed:@"default_image"];
        
    }else{
        
        [cell.ShopImgView sd_setImageWithURL:[NSURL URLWithString:model.logo] placeholderImage:[UIImage imageNamed:@"default_image"] options:SDWebImageProgressiveDownload];
        
    }
    
    
    cell.ShopNameLabel.text = model.storename;
    
    cell.NumberLabel.text = model.click_volume;
    
    cell.ShopTypeLabel.text = model.scope;
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MerchantDetailViewController *vc = [[MerchantDetailViewController alloc] init];
    
    MerchantModel *model = _dataArrM[indexPath.row];
    
    vc.mid = model.mid;
    vc.Logo = model.logo;
    
    vc.jindu=self.jindu;
    
    vc.weidu=self.weidu;
    
    vc.coordinates = model.OneCoordinates;
    
    vc.MapStartAddress = self.MapStartAddress;
    
    vc.delegate=self;
    
    vc.GetString=@"1";
    
    self.navigationController.navigationBar.hidden=YES;
    
    self.tabBarController.tabBar.hidden=YES;
    
    [self.navigationController pushViewController:vc animated:NO];
    
    
}
- (void)refresh:(DJRefresh *)refresh didEngageRefreshDirection:(DJRefreshDirection)direction{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self addDataWithDirection:direction];
    });
    
}

//返回刷新数据
-(void)BackReloadData
{
    
    gogo=100;
    
    _num=0;
    
    [_dataArrM removeAllObjects];

    //获取数据
    [self GetDatas];
    
    
    
    
}
- (void)addDataWithDirection:(DJRefreshDirection)direction{
    
    if (direction==DJRefreshDirectionTop) {
        
        
        _num=0;
        
        
//        [_dataArrM removeAllObjects];
        //获取数据
        [self GetDatas];
    }
    
    [_tableView reloadData];
    
    [_refresh finishRefreshingDirection:direction animation:YES];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 44;
}


-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    footer=[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
    
    
    footer.DataCount=[NSString stringWithFormat:@"%ld",(unsigned long)_dataArrM.count];
    footer.totalCount=string10;
    
//    footer.BgView.backgroundColor = [UIColor whiteColor];
    
    footer.delegate=self;
    if (_dataArrM.count == 0) {
        footer.hidden = YES;
    }
    return footer;
}
//加载更多数据代理方法
- (void)FooterViewClickedloadMoreData
{
    
    if (_dataArrM.count%12==0) {
        
        gogo=200;
        _num=_num+1;
        
        //获取数据
        [self GetDatas];
        
    }else{
        
        
        
    }
}

//商圈
-(void)QurtBtnClick
{
    NSLog(@"商圈");
    
    self.navigationController.navigationBar.hidden=YES;
    
    self.tabBarController.tabBar.hidden=YES;
    
    NSLog(@"%@-%@-%@",self.jindu,self.weidu,self.MapStartAddress);
    
    MerchantMapViewController *vc = [[MerchantMapViewController alloc] init];
    
    vc.jindu=self.jindu;
    
    vc.weidu=self.weidu;
    
    vc.MapStartAddress = self.MapStartAddress;
    
    [self.navigationController pushViewController:vc animated:NO];
    
}

//搜索
-(void)headSearchClick:(UIImageView *)image
{
    
    NSLog(@"搜索");
    
    MerchantSearchViewController *vc = [[MerchantSearchViewController alloc] init];
    
    self.navigationController.navigationBar.hidden=YES;
    
    self.tabBarController.tabBar.hidden=YES;
    
    [self.navigationController pushViewController:vc animated:NO];
    
    
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
