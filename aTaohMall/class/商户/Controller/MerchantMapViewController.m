//
//  MerchantMapViewController.m
//  aTaohMall
//
//  Created by JMSHT on 2017/3/8.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "MerchantMapViewController.h"


#import "NearShopViewController.h"//附近商店

#import "AFNetworking.h"

#import "ConverUtil.h"
#import "DESUtil.h"
#import "SecretCodeTool.h"

#import "MallModel.h"

#import "CityModel.h"//地址模型

#import "UIImageView+WebCache.h"
/**
 *  百度api
 */
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件

#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件

#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件

#import <BaiduMapAPI_Cloud/BMKCloudSearchComponent.h>//引入云检索功能所有的头文件

#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件

#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>//引入计算工具所有的头文件

#import <BaiduMapAPI_Radar/BMKRadarComponent.h>//引入周边雷达功能所有的头文件

#import <BaiduMapAPI_Map/BMKMapView.h>//只引入所需的单个头文件

#import "MerchantModel.h"

//设备物理尺寸
#define screen_width [UIScreen mainScreen].bounds.size.width
#define screen_height [UIScreen mainScreen].bounds.size.height
#define Myuser [NSUserDefaults standardUserDefaults]

//使用原生地图

//MapKit是原生地图框架
#import <MapKit/MapKit.h>

//CoreLocation是定位框架
#import <CoreLocation/CoreLocation.h>

#import "MerchantView.h"

#import "MerchantDetailViewController.h"//店铺详情

@interface MerchantMapViewController ()<MKMapViewDelegate, CLLocationManagerDelegate,BMKLocationServiceDelegate>
{
    //地图View
    MKMapView *_mapView;
    
    //定位管理器
    CLLocationManager *_locationManager;
    
    NSMutableArray *_addressArrM;
    
    NSMutableArray *_otherArrM;
    
    MKAnnotationView *annView;
    
    UIView *singleTapView;
    
    
}

@property(nonatomic,strong)NSMutableArray *cityDataArr;//存储地址

@property(strong,nonatomic)MKMapItem *mapItem;

//编码工具
@property(strong,nonatomic)CLGeocoder *geocoder;

//@property(weak,nonatomic)MKMapView *mapView;

//用于发送请求给服务器
@property(strong,nonatomic)MKDirections *direct;

@end

@implementation MerchantMapViewController

//初始化数组
-(NSMutableArray *)cityDataArr
{
    if (_cityDataArr==nil)
    {
        _cityDataArr=[NSMutableArray arrayWithCapacity:0];
    }
    
    return _cityDataArr;
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.ImgString = @"1";
    
    _addressArrM = [NSMutableArray new];
    
    _otherArrM = [NSMutableArray new];
    
    self.mid = @"";
    
    self.merchants_coordinates = @"";
    
    [self initNav];
    
    
    //创建地图View
    _mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-KSafeAreaTopNaviHeight)];
    
    [self.view addSubview:_mapView];
    
    //中心坐标点
    //CL开头:CoreLocation框架中的
//    CLLocationCoordinate2D centerCoordinate = CLLocationCoordinate2DMake([self.weidu doubleValue], [self.jindu doubleValue]);
//    
//    
//    [_mapView setCenterCoordinate:centerCoordinate animated:YES];
    
    
    CLLocationCoordinate2D centerCoordinate;
    
    if (self.weidu.length==0) {
        
        centerCoordinate = CLLocationCoordinate2DMake(39.9110130000,116.4135540000);
        
        [_mapView setCenterCoordinate:centerCoordinate animated:YES];
        
    }else{
        
        
        centerCoordinate = CLLocationCoordinate2DMake([self.weidu doubleValue], [self.jindu doubleValue]);
        
        [_mapView setCenterCoordinate:centerCoordinate animated:YES];
    }
    
    
//     _mapView.centerCoordinate = _mapView.userLocation.location.coordinate;
    
    //在指定经纬度插上大头针
    
    //    //将点转换成经纬度坐标
    //    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(22.541476, 113.951361);
    //    //添加标注
    //    MKPointAnnotation *ann = [[MKPointAnnotation alloc] init];
    //    ann.coordinate = coordinate;
    //    ann.title = @"大学城";
    //    ann.subtitle = @"高新园";
    //    [_mapView addAnnotation:ann];
    
    
    
    //缩放系数,参数越小,放得越大
    MKCoordinateSpan span = MKCoordinateSpanMake(0.03, 0.03);
    
    //区域
    MKCoordinateRegion region = MKCoordinateRegionMake(centerCoordinate, span);
    
    //设置地图的显示区域
    [_mapView setRegion:region animated:YES];
    
    
    
    
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
    _mapView.showsUserLocation = NO;
    
    //设置代理,通过代理方法接收自己的位置
    _locationManager.delegate = self;
    
    //设置代理
    _mapView.delegate = self;
    
    //定位
    _locationManager = [[CLLocationManager alloc] init];
    
   
    if (self.weidu.length==0) {
        
        _mapView.zoomEnabled = YES;
        
        //是否能移动
        _mapView.scrollEnabled = YES;
        
        
    }else{
        
        MKPointAnnotation *ann = [[MKPointAnnotation alloc] init];
        ann.coordinate = centerCoordinate;
        ann.title=@"abc";
        [_mapView addAnnotation:ann];
        
    }
    
    
    //iOS8.0的定位
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0 ) {
//        [_locationManager requestAlwaysAuthorization];
        [_locationManager requestWhenInUseAuthorization];
    }
    
    //启动定位
    [_locationManager startUpdatingLocation];
    
    
    self.LeftImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, [UIScreen mainScreen].bounds.size.height-160, 40, 40)];
    
    self.LeftImgView.image = [UIImage imageNamed:@"组-4"];
    
    [self.view addSubview:self.LeftImgView];
    //获取周边数据
    [self getData];
    
    if ([self.BackString isEqualToString:@"200"]) {
        
        
        NSLog(@"==1==%@",self.LongString);
        NSLog(@"==2==%@",self.NameString);
        NSLog(@"==3==%@",self.LogoString);
        NSLog(@"==4==%@",self.TypeString);
        NSLog(@"==5==%@",self.NewAddressString);
        
        [self.TabView removeFromSuperview];
        
        self.TabView = [[UIView alloc] initWithFrame:CGRectMake(10, [UIScreen mainScreen].bounds.size.height-85, [UIScreen mainScreen].bounds.size.width-20, 80)];
        
        self.TabView.backgroundColor=[UIColor whiteColor];
        
        
        
        
        self.LogoImgView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 60, 60)];
        if ([self.LogoString isEqualToString:@"0"]) {
            
            self.LogoImgView.image = [UIImage imageNamed:@"图片占位or加载2"];
            
        }else{
            
            [self.LogoImgView sd_setImageWithURL:[NSURL URLWithString:self.LogoString]];
        }
        
        self.LogoImgView.layer.cornerRadius = 30.0;//（该值到一定的程度，就为圆形了。）
        self.LogoImgView.layer.borderWidth = 0.5;
        self.LogoImgView.layer.borderColor =[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0].CGColor;
        self.LogoImgView.clipsToBounds = TRUE;//去除边界
        [self.TabView addSubview:self.LogoImgView];
        
        //店铺头像添加手势，点击进入店铺详情
        
        self.LogoImgView.userInteractionEnabled=YES;
        
        UITapGestureRecognizer *Tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(GoToDetail:)];
        
        [self.LogoImgView addGestureRecognizer:Tap];
        
        
        NSString *text = self.NameString;
        
        CGRect tempRect = [text boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-200,20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil];
        
        self.NameLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 12, tempRect.size.width, 20)];
        self.NameLabel.text = text;
        self.NameLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
        self.NameLabel.textColor =[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        [self.TabView addSubview:self.NameLabel];
        
        
        self.RedImgView = [[UIImageView alloc] initWithFrame:CGRectMake(100+tempRect.size.width, 12, 20, 20)];
        self.RedImgView.image = [UIImage imageNamed:@"坐标"];
        [self.TabView addSubview:self.RedImgView];
        
        
        self.LongLabel = [[UILabel alloc] initWithFrame:CGRectMake(100+tempRect.size.width+20, 22, 100, 10)];
        self.LongLabel.text = self.LongString;
        self.LongLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:10];
        self.LongLabel.textColor =[UIColor colorWithRed:255/255.0 green:87/255.0 blue:48/255.0 alpha:1.0];
        [self.TabView addSubview:self.LongLabel];
        
        [self.view insertSubview:self.TabView aboveSubview:_mapView];
        
        
        self.TypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 32, [UIScreen mainScreen].bounds.size.width-120, 20)];
        self.TypeLabel.text = self.TypeString;
        self.TypeLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
        self.TypeLabel.textColor =[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        [self.TabView addSubview:self.TypeLabel];
        
        
        self.AddressLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 52, [UIScreen mainScreen].bounds.size.width-120, 20)];
        self.AddressLabel.text = self.NewAddressString;
        self.AddressLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
        self.AddressLabel.textColor =[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        [self.TabView addSubview:self.AddressLabel];
        
        self.MapEndAddress = self.NewAddressString;
        
        self.merchants_coordinates = self.coordinates;
        
        //   提供两个点，自动规划线路
        _geocoder = [[CLGeocoder alloc]init];

        if (!self.MapStartAddress||[self.MapStartAddress isEqualToString:@""]||[self.MapStartAddress containsString:@"null"]||[self.MapStartAddress isEqual:[[NSNull alloc] init]]) {
            self.MapStartAddress=[kUserDefaults objectForKey:@"mapStartAddress"];

        }

        NSLog(@"self.mapStartAddress=%@",self.MapStartAddress);
        [_geocoder geocodeAddressString:self.MapStartAddress completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            
            MKPlacemark *placemark = [[MKPlacemark alloc]initWithPlacemark:placemarks.lastObject];
            //intrItem可以理解为地图上的一个点
            MKMapItem *intrItem = [[MKMapItem alloc]initWithPlacemark:placemark];
            
            
            // 让地图跳转到起点所在的区域
            MKCoordinateRegion region = MKCoordinateRegionMake(intrItem.placemark.location.coordinate, MKCoordinateSpanMake(0.1, 0.1));
            
            [_mapView setRegion:region];
            
            //创建终点
            [_geocoder geocodeAddressString:self.MapEndAddress completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
                
                //destItem可以理解为地图上的一个点
                MKMapItem *destItem = [[MKMapItem alloc]initWithPlacemark:[[MKPlacemark alloc]initWithPlacemark:[placemarks lastObject]]];
                
                //调用下面方法发送请求
                [self moveWith:intrItem toDestination:destItem];
            }];
        }];
        
        
    }
    
}

//移动地图
- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    
    MKCoordinateRegion region;
    CLLocationCoordinate2D centerCoordinate = mapView.region.center;
    region.center= centerCoordinate;
    
    NSLog(@" regionDidChangeAnimated %f,%f",centerCoordinate.latitude, centerCoordinate.longitude);
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
    
    [Qurt setBackgroundImage:[UIImage imageNamed:@"iconfont-fanhui2yt"] forState:0];
    
    
    [Qurt addTarget:self action:@selector(QurtBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [titleView addSubview:Qurt];
    
    //创建搜索
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 25+KSafeTopHeight, [UIScreen mainScreen].bounds.size.width-200, 30)];
    
    label.text = @"商圈";
    
    label.textColor = [UIColor blackColor];
    
    label.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:19];
    
    label.textAlignment = NSTextAlignmentCenter;
    
    [titleView addSubview:label];
    
    
}

-(void)QurtBtnClick
{
    
    if ([self.BackString isEqualToString:@"200"]) {
        
        self.navigationController.navigationBar.hidden=YES;
        
        self.tabBarController.tabBar.hidden=YES;
        
    }else{
        
        self.navigationController.navigationBar.hidden=YES;
        
        self.tabBarController.tabBar.hidden=NO;
        
    }
    
    
    [self.navigationController popViewControllerAnimated:NO];
    
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
    
    
    NSLog(@">>>>%f",latitude1);
    NSLog(@">>>>%f",longitude1);
    
    
    NSLog(@"商圈定位成功!");
    
    //获取到定位的位置信息
    CLLocation *location = [locations firstObject];
    
    //定位到的当前坐标
    CLLocationCoordinate2D coordinate = location.coordinate;
    
    NSLog(@"(%f, %f)", coordinate.latitude, coordinate.longitude);
    
//    self.jindu=[NSString stringWithFormat:@"%f",coordinate.longitude];
    
//    self.weidu=[NSString stringWithFormat:@"%f",coordinate.latitude];
    
    
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
        
        
    }];
    
    
    //停止定位
    [_locationManager stopUpdatingLocation];
    
    
}

//定位失败
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"定位失败:%@", error);
}


#pragma  mark - MKMapViewDelegate
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    
    //判断annotation如果是自己定位的标注,不应该定制标注视图
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        NSLog(@"商圈是我当前的位置, 不定制! ");
        return nil;
    }
    
    
    
    annView = [mapView dequeueReusableAnnotationViewWithIdentifier:@"id2"];
    if ( !annView ) {
        annView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"id2"];
    }
    
    
//    NSLog(@"地图上显示大头针===%@",self.TagString);
    
    
    //可以弹出气泡
    annView.canShowCallout = NO;
    
    //设置标注图片
    if ([annotation.title  isEqualToString:@"abc"]) {
        
        annView.image = [UIImage imageNamed:@"我的位置点"];
        
    }else{
        
        //设置标注图片
        annView.image = [UIImage imageNamed:@"店铺new"];
    }
    
//    NSLog(@"*********==%@",annotation.title);

    
    UITapGestureRecognizer *longPress = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    
    [annView addGestureRecognizer:longPress];
    
    singleTapView = [longPress view];
    
    singleTapView.tag = [annotation.title integerValue];
    
    return annView;
    
}


#pragma  mark - 长按手势
-(void)longPress:(UITapGestureRecognizer *)gesture
{
    
    
    UITapGestureRecognizer *singleTap = (UITapGestureRecognizer *)gesture;
    
    NSInteger index = singleTap.view.tag;
    
    NSLog(@"====index====%ld",(long)index);
    
    if (_otherArrM.count==0) {
        
        for (MerchantModel *model in _addressArrM) {
            
            
            if ([model.mid integerValue] == index) {
                
                
//                NSLog(@"====model.coordinates====%@",model.coordinates);
                
                self.merchants_coordinates = model.coordinates;
                
                self.mid = model.mid;
                
                
                
            }
            
            
        }
    }else{
        
        for (MerchantModel *model in _otherArrM) {
            
            
            if ([model.mid integerValue] == index) {
                
                
//                NSLog(@"====model.coordinates====%@",model.coordinates);
                
                self.merchants_coordinates = model.coordinates;
                
                self.mid = model.mid;
                
                
                
            }
            
            
        }
    }
    
    
    
//    self.merchants_coordinates = @"114.0340300000,22.5517250000";
//    
//    self.mid = @"1889";
    
    
    
    
    [self.TabView removeFromSuperview];
    [self.LogoImgView removeFromSuperview];
    [self.TypeLabel removeFromSuperview];
    [self.AddressLabel removeFromSuperview];
    [self.RedImgView removeFromSuperview];
    [self.LongLabel removeFromSuperview];
    [self.NameLabel removeFromSuperview];
    
    
    self.TabView = [[UIView alloc] initWithFrame:CGRectMake(10, [UIScreen mainScreen].bounds.size.height-85, [UIScreen mainScreen].bounds.size.width-20, 80)];
    
    self.TabView.backgroundColor=[UIColor whiteColor];
    
    [self GetOtherData];
    
//    self.LogoImgView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 60, 60)];
////    self.LogoImgView.image = [UIImage imageNamed:@"QQ"];
//    self.LogoImgView.layer.cornerRadius = 30.0;//（该值到一定的程度，就为圆形了。）
//    self.LogoImgView.layer.borderWidth = 0.5;
//    self.LogoImgView.layer.borderColor =[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0].CGColor;
//    self.LogoImgView.clipsToBounds = TRUE;//去除边界
//    [self.TabView addSubview:self.LogoImgView];
//    
//    
//    //店铺头像添加手势，点击进入店铺详情
//    
//    self.LogoImgView.userInteractionEnabled=YES;
//    
//    UITapGestureRecognizer *Tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(GoToDetailOther:)];
//    
//    [self.LogoImgView addGestureRecognizer:Tap];
//    
//    UIView *singleTapView1 = [Tap view];
//    
//    singleTapView1.tag = singleTap.view.tag;
//    
//    
//    self.TypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 32, [UIScreen mainScreen].bounds.size.width-120, 20)];
//    self.TypeLabel.text = @"";
//    self.TypeLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
//    self.TypeLabel.textColor =[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
//    [self.TabView addSubview:self.TypeLabel];
//    
//    
//    self.AddressLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 52, [UIScreen mainScreen].bounds.size.width-120, 20)];
//    self.AddressLabel.text = @"";
//    self.AddressLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
//    self.AddressLabel.textColor =[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
//    [self.TabView addSubview:self.AddressLabel];

}

-(void)getData
{
    
//    [_addressArrM removeAllObjects];
    
    
    if (self.jindu.length==0) {
        
        self.jindu = @"113.9565795358";
    }
    
    if (self.weidu.length==0) {
        
        self.weidu = @"22.5379648670";
    }
    
    NSNull *null = [[NSNull alloc] init];
    
    NSString *string=[NSString stringWithFormat:@"%@,%@",self.jindu,self.weidu];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@getNearbyMerchants_mob.shtml",URL_Str];
    
    NSDictionary *dic = @{@"coordinates":string,@"merchants_coordinates":@"",@"mid":@""};
    
    [manager POST:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
        NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];
        
        if (codeKey && content) {
            NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
            
//            NSLog(@"xmlStr=====%@",xmlStr);
            
            
            NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];
            
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            for (NSDictionary *dict1 in dic) {
                
                if (![dict1[@"nearbyMerchantsList"] isEqual:null]) {
                    
                    for (NSDictionary *dict2 in dict1[@"nearbyMerchantsList"]) {
                        
                        MerchantModel *model = [[MerchantModel alloc] init];
                        
                        model.coordinates = dict2[@"coordinates"];
                        model.mid = dict2[@"mid"];
                        
                        [_addressArrM addObject:model];
                        
                    }
                }
                
            }
            
            
            NSLog(@"===***====%ld",(unsigned long)_addressArrM.count);
            
            
            for (MerchantModel *model in _addressArrM) {
                
                self.TagString = model.mid;
                

//                NSLog(@"-------^^^^==%@=====$$$=%@",model.mid,model.coordinates);
                
                NSArray *array = [model.coordinates componentsSeparatedByString:@","];
                
                //将点转换成经纬度坐标
                CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake([array[1] doubleValue], [array[0] doubleValue]);
                
                //添加标注
                MKPointAnnotation *ann = [[MKPointAnnotation alloc] init];
                ann.coordinate = coordinate;
                
                ann.title = model.mid;
                ann.subtitle = model.coordinates;
                [_mapView addAnnotation:ann];
            }
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        
        NSLog(@"%@",error);
    }];
    
}

-(void)GetOtherData
{
    
    if (self.jindu.length==0) {
        
        self.jindu = @"113.9565795358";
    }
    
    if (self.weidu.length==0) {
        
        self.weidu = @"22.5379648670";
    }
    
    NSString *string=[NSString stringWithFormat:@"%@,%@",self.jindu,self.weidu];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@getNearbyMerchants_mob.shtml",URL_Str];
    
    NSDictionary *dic = @{@"coordinates":string,@"merchants_coordinates":self.merchants_coordinates,@"mid":self.mid};
    
    [manager POST:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
        NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];
        
        if (codeKey && content) {
            NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
            
//            NSLog(@"xmlStr=====%@",xmlStr);
            
            
            NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];
            
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            for (NSDictionary *dict in dic) {
                
                for (NSDictionary *dict1 in dict[@"nearbyMerchantsList"]) {
                    
                    MerchantModel *model = [[MerchantModel alloc] init];
                    
                    model.coordinates = dict1[@"coordinates"];
                    model.mid = dict1[@"mid"];
                    
                    
                    [_otherArrM addObject:model];
                    
                }
                
                
                NSLog(@"==商圈点击地图==%@",dict[@"merchants_map"][@"distanceStr"]);
                
                self.string1 =dict[@"merchants_map"][@"logo"];
                
                
                self.Name = dict[@"merchants_map"][@"storename"];
                
                self.Distance = dict[@"merchants_map"][@"distanceStr"];
                
                self.string2 =dict[@"merchants_map"][@"tid"];
                
                
                self.string3 =dict[@"merchants_map"][@"address"];
                
                
                self.MapEndAddress = [NSString stringWithFormat:@"%@",dict[@"merchants_map"][@"address"]];
            }
            
            
            [self.LogoImgView removeFromSuperview];
            [self.TypeLabel removeFromSuperview];
            [self.AddressLabel removeFromSuperview];
            [self.RedImgView removeFromSuperview];
            [self.LongLabel removeFromSuperview];
            [self.NameLabel removeFromSuperview];
            
            
            NSString *text = self.Name;
            
            CGRect tempRect = [text boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-200,20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil];
            
            self.NameLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 12, tempRect.size.width, 20)];
            self.NameLabel.text = text;
            self.NameLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
            self.NameLabel.textColor =[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
            [self.TabView addSubview:self.NameLabel];
            
            
            self.RedImgView = [[UIImageView alloc] initWithFrame:CGRectMake(100+tempRect.size.width, 12, 20, 20)];
            self.RedImgView.image = [UIImage imageNamed:@"坐标"];
            [self.TabView addSubview:self.RedImgView];
            
            
            self.LongLabel = [[UILabel alloc] initWithFrame:CGRectMake(100+tempRect.size.width+20, 22, 100, 10)];
            self.LongLabel.text = self.Distance;
            self.LongLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:10];
            self.LongLabel.textColor =[UIColor colorWithRed:255/255.0 green:87/255.0 blue:48/255.0 alpha:1.0];
            [self.TabView addSubview:self.LongLabel];
            
            
            self.LogoImgView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 60, 60)];
            //    self.LogoImgView.image = [UIImage imageNamed:@"QQ"];
            self.LogoImgView.layer.cornerRadius = 30.0;//（该值到一定的程度，就为圆形了。）
            self.LogoImgView.layer.borderWidth = 0.5;
            [self.LogoImgView sd_setImageWithURL:[NSURL URLWithString:self.string1]];
            self.LogoImgView.layer.borderColor =[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0].CGColor;
            self.LogoImgView.clipsToBounds = TRUE;//去除边界
            [self.TabView addSubview:self.LogoImgView];
            
            
            //店铺头像添加手势，点击进入店铺详情
            
            self.LogoImgView.userInteractionEnabled=YES;
            
            UITapGestureRecognizer *Tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(GoToDetailOther:)];
            
            [self.LogoImgView addGestureRecognizer:Tap];
            
            //            UIView *singleTapView1 = [Tap view];
            //
            //            singleTapView1.tag = singleTap.view.tag;
            
            
            self.TypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 32, [UIScreen mainScreen].bounds.size.width-120, 20)];
            self.TypeLabel.text = [NSString stringWithFormat:@"行业类别：%@",self.string2];
            self.TypeLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
            self.TypeLabel.textColor =[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
            [self.TabView addSubview:self.TypeLabel];
            
            
            self.AddressLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 52, [UIScreen mainScreen].bounds.size.width-120, 20)];
            self.AddressLabel.text = [NSString stringWithFormat:@"地址：%@",self.string3];
            self.AddressLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
            self.AddressLabel.textColor =[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
            [self.TabView addSubview:self.AddressLabel];
            
            
            [self.view insertSubview:self.TabView aboveSubview:_mapView];
            
            
            for (int i=0; i<_addressArrM.count; i++) {
                
                MerchantModel *model1 = _addressArrM[i];
                
                for (int j=0; j<_otherArrM.count; j++) {
                    
                    MerchantModel *model2 = _otherArrM[j];
                    
                    if ([model1.mid integerValue] == [model2.mid integerValue]) {
                        
//                        NSLog(@"&&&&&=%@",model2.mid);
                        
                    }else{
                        
                        NSArray *array = [model2.coordinates componentsSeparatedByString:@","];
                        
                        //将点转换成经纬度坐标
                        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake([array[1] doubleValue], [array[0] doubleValue]);
                        
                        //添加标注
                        MKPointAnnotation *ann = [[MKPointAnnotation alloc] init];
                        ann.coordinate = coordinate;
                        
                        ann.title = model2.mid;
                        ann.subtitle = model2.coordinates;
                        [_mapView addAnnotation:ann];
                        
//                        [_addressArrM addObject:model2];
                    }
                }
            }
            
            NSLog(@"====(()()()==%lu",(unsigned long)_otherArrM.count);
            
            NSLog(@"==11==%@===%@==%@",self.MapStartAddress,self.MapEndAddress,self.merchants_coordinates);
            
            //    添加一个视图
            
            //   提供两个点，自动规划线路
            _geocoder = [[CLGeocoder alloc]init];
            
            
            //绘制地图
            [_mapView removeOverlays:_mapView.overlays];
            
            [self moveWith:nil toDestination:nil];
            
            
//            NSArray *Arr = [self.merchants_coordinates componentsSeparatedByString:@","];
//            
//            double latitude = [Arr[0] doubleValue];
//            double longitude = [Arr[1] doubleValue];
//            
//            NSLog(@"==22==%@===%@==%@",self.MapStartAddress,self.MapEndAddress,self.merchants_coordinates);
//            
//            CLLocation *location = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
//            
//            [self.geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
//                CLPlacemark *pl = [placemarks firstObject];
//                
//                if(error == nil)
//                {
//                    NSLog(@"%f----%f", pl.location.coordinate.latitude, pl.location.coordinate.longitude);
//                    
//                    NSLog(@"%@", pl.name);
//                    self.MapEndAddress = pl.name;
//                }
//            }];
            
            
            
            
            
//            
//            [_geocoder geocodeAddressString:self.MapStartAddress completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
//                
//                
//                MKPlacemark *placemark = [[MKPlacemark alloc]initWithPlacemark:placemarks.lastObject];
//                //intrItem可以理解为地图上的一个点
//                MKMapItem *intrItem = [[MKMapItem alloc]initWithPlacemark:placemark];
//                
//                
//                // 让地图跳转到起点所在的区域
//                MKCoordinateRegion region = MKCoordinateRegionMake(intrItem.placemark.location.coordinate, MKCoordinateSpanMake(0.1, 0.1));
//                [_mapView setRegion:region];
//                
//                //创建终点
//                [_geocoder geocodeAddressString:self.MapEndAddress completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
//                    
//                    //destItem可以理解为地图上的一个点
//                    MKMapItem *destItem = [[MKMapItem alloc]initWithPlacemark:[[MKPlacemark alloc]initWithPlacemark:[placemarks lastObject]]];
//                    
//                    //在终点添加大头针
////                    MKPointAnnotation *ann = [[MKPointAnnotation alloc] init];
////                    ann.coordinate = destItem.placemark.location.coordinate;
////                    [_mapView addAnnotation:ann];
//                    
//                    
//                    //调用下面方法发送请求
//                    [self moveWith:intrItem toDestination:destItem];
//                }];
//            }];
            
            
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        
        NSLog(@"%@",error);
    }];
    
}

//提供两个点，在地图上进行规划的方法
-(void)moveWith:(MKMapItem *)formPlce toDestination:(MKMapItem *)endPlace{
    
    
    NSArray *array = [self.merchants_coordinates componentsSeparatedByString:@","];
    
    NSLog(@"=====%f==%f",[array[0] doubleValue],[array[1] doubleValue]);
    
    //起点和终点的经纬度
//    CLLocationCoordinate2D start = {22.5379648670,113.9565795358};
    CLLocationCoordinate2D start = {[self.weidu doubleValue],[self.jindu doubleValue]};
    CLLocationCoordinate2D end = {[array[1] doubleValue],[array[0] doubleValue]};
    
    //起点终点的详细信息
    MKPlacemark *startPlace = [[MKPlacemark alloc]initWithCoordinate:start addressDictionary:nil];
    MKPlacemark *endPlace1 = [[MKPlacemark alloc]initWithCoordinate:end addressDictionary:nil];
    //起点 终点的 节点
    MKMapItem *startItem = [[MKMapItem alloc]initWithPlacemark:startPlace];
    MKMapItem *endItem = [[MKMapItem alloc]initWithPlacemark:endPlace1];
    
    //路线请求
    MKDirectionsRequest *request = [[MKDirectionsRequest alloc]init];
    request.source = startItem;
    request.destination = endItem;
    
    //发送请求
    MKDirections *directions = [[MKDirections alloc]initWithRequest:request];
    
//    __block NSInteger sumDistance = 0;
//    
//    //计算
//    [directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error) {
//        if (!error) {
//            //取出一条路线
//            MKRoute *route = response.routes[0];
//            
//            //关键节点
//            for(MKRouteStep *step in route.steps)
//            {
//                
//                //添加路线
//                [_mapView addOverlay:step.polyline];
//                
//                //距离
//                sumDistance += step.distance;
//            }
//            
//        }
//    }];
    
    
    //    创建请求体
    // 创建请求体 (起点与终点)
//    MKDirectionsRequest *request = [[MKDirectionsRequest alloc] init];
    
//    request.source = formPlce;
//    request.destination = endPlace;
    
    self.direct = [[MKDirections alloc]initWithRequest:request];
    
    // 计算路线规划信息 (向服务器发请求)
    [self.direct calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse * _Nullable response, NSError * _Nullable error) {
        
        
        //获取到所有路线
        NSArray <MKRoute *> *routesArray = response.routes;
        //取出最后一条路线
        MKRoute *rute = routesArray.lastObject;
        
        //路线中的每一步
        NSArray <MKRouteStep *>*stepsArray = rute.steps;
        
        
        NSLog(@"=====routesArray====%ld",routesArray.count);
        
        //遍历
        for (MKRouteStep *step in stepsArray) {
            
            [_mapView addOverlay:step.polyline];
        }
        // 收响应结果 MKDirectionsResponse
        // MKRoute 表示的一条完整的路线信息 (从起点到终点) (包含多个步骤)
    }];
    
}

// 返回指定的遮盖模型所对应的遮盖视图, renderer-渲染
- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay
{
    
    // 判断类型
    if ([overlay isKindOfClass:[MKPolyline class]]) {
        // 针对线段, 系统有提供好的遮盖视图
        MKPolylineRenderer *render = [[MKPolylineRenderer alloc] initWithPolyline:overlay];
        
        
        // 配置，遮盖线的颜色
        render.lineWidth = 2;
        //        render.strokeColor =  [UIColor colorWithRed:arc4random_uniform(256) / 255.0 green:arc4random_uniform(256) / 255.0 blue:arc4random_uniform(256) / 255.0 alpha:1.0];
        
        render.strokeColor =  [UIColor blueColor];
        
        return render;
    }
    // 返回nil, 是没有默认效果
    return nil;
}

//一进入
-(void)GoToDetail:(UITapGestureRecognizer *)tap
{
    
    NSLog(@"一进入");
    
    MerchantDetailViewController *vc = [[MerchantDetailViewController alloc] init];
    
    vc.mid = self.MMMMid;
    
    vc.jindu=self.jindu;
    
    vc.weidu=self.weidu;
    
    vc.coordinates = self.coordinates;
    
    vc.BackString = @"333";
    
    [self.navigationController pushViewController:vc animated:NO];
    
    
}

//点击地图
-(void)GoToDetailOther:(UITapGestureRecognizer *)tap
{
    
    NSLog(@"点击地图");
    
    UITapGestureRecognizer *singleTap = (UITapGestureRecognizer *)tap;
    
    NSInteger index = singleTap.view.tag;
    
    NSLog(@"==点击地图==index====%ld",(long)index);
    
    MerchantDetailViewController *vc = [[MerchantDetailViewController alloc] init];
    
    vc.mid = [NSString stringWithFormat:@"%ld",(long)index];
    
    vc.jindu=self.jindu;
    
    vc.weidu=self.weidu;
    
    vc.coordinates = self.merchants_coordinates;
    
    vc.BackString = @"333";
    
    [self.navigationController pushViewController:vc animated:NO];
    
    
}
@end
