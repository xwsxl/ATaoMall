//
//  NearByViewController.m
//  aTaohMall
//
//  Created by JMSHT on 16/5/12.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import "NearByViewController.h"

#import "NearShopViewController.h"//附近商店

#import "AFNetworking.h"

#import "ConverUtil.h"
#import "DESUtil.h"
#import "SecretCodeTool.h"

#import "MallModel.h"

#import "CityModel.h"//地址模型

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



//设备物理尺寸
#define screen_width [UIScreen mainScreen].bounds.size.width
#define screen_height [UIScreen mainScreen].bounds.size.height
#define Myuser [NSUserDefaults standardUserDefaults]

//使用原生地图

//MapKit是原生地图框架
#import <MapKit/MapKit.h>

//CoreLocation是定位框架
#import <CoreLocation/CoreLocation.h>


@interface NearByViewController ()<MKMapViewDelegate, CLLocationManagerDelegate>
{
    //地图View
    MKMapView *_mapView;
    
    //定位管理器
    CLLocationManager *_locationManager;
}

@property(nonatomic,strong)NSMutableArray *cityDataArr;//存储地址

@end

@implementation NearByViewController
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
    // Do any additional setup after loading the view from its nib.
    
    self.navigationController.navigationBar.hidden=YES;
    self.tabBarController.tabBar.hidden=YES;
    
    //创建地图View
    _mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 128, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-200)];
    [self.view addSubview:_mapView];
    
    // 大学城坐标: 经度113.968855, 纬度22.586261
    //22.5435660000,113.9631460000
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
    _mapView.centerCoordinate = CLLocationCoordinate2DMake(22.541476, 113.951361);
    
    
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
    
    
    

    
    
    //添加长按手势
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    [_mapView addGestureRecognizer:longPress];
    
    
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
    
    
    NSLog(@"定位成功!");
    
    //获取到定位的位置信息
    CLLocation *location = [locations firstObject];
    
    //定位到的当前坐标
    CLLocationCoordinate2D coordinate = location.coordinate;
    
    NSLog(@"(%f, %f)", coordinate.latitude, coordinate.longitude);
    
    self.jindu=[NSString stringWithFormat:@"%f",coordinate.longitude];
    
    self.weidu=[NSString stringWithFormat:@"%f",coordinate.latitude];
    
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
        NSLog(@"是我当前的位置, 不定制! ");
        return nil;
    }
    
    
#if 1
    //MKPinAnnotationView: 自带大头针标注,可以设置标注颜色,可以设置掉落动画; 不可以设置标注图片
    //MKAnnotationView: 可以设置标注图片;
    
    //从复用队列中获取标注视图
    MKPinAnnotationView *pinView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"id"];
    if ( !pinView ) {
        pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"id"];
    }
    
    //可以弹出气泡
    pinView.canShowCallout = YES;
    
    //设置标注颜色
    pinView.pinColor = MKPinAnnotationColorPurple;
    
    //设置掉落动画
    pinView.animatesDrop = YES;
    
    //设置左视图
    pinView.leftCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeContactAdd];
    
    //设置右视图
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    rightView.backgroundColor = [UIColor orangeColor];
    pinView.rightCalloutAccessoryView = rightView;
    
    //设置标注图片(无效)
    pinView.image = [UIImage imageNamed:@"serach_Map"];
    
    return pinView;
    
#else
    
    MKAnnotationView *annView = [mapView dequeueReusableAnnotationViewWithIdentifier:@"id2"];
    if ( !annView ) {
        annView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"id2"];
    }
    
    //可以弹出气泡
    annView.canShowCallout = YES;
    
    //设置标注图片
    annView.image = [UIImage imageNamed:@"serach_Map"];
    
    //设置左视图
    annView.leftCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeContactAdd];
    
    //设置右视图
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    rightView.backgroundColor = [UIColor orangeColor];
    annView.rightCalloutAccessoryView = rightView;
    
    return annView;
    
#endif
    
}


#pragma  mark - 长按手势
-(void)longPress:(UILongPressGestureRecognizer *)gesture
{
    if (gesture.state != UIGestureRecognizerStateBegan) {
        return;
    }
    
    NSLog(@"长按了");
    
    //长按的点
    CGPoint point = [gesture locationInView:_mapView];
    
    //将点转换成经纬度坐标
    CLLocationCoordinate2D coordinate = [_mapView convertPoint:point toCoordinateFromView:_mapView];
    
    //添加标注
    MKPointAnnotation *ann = [[MKPointAnnotation alloc] init];
    ann.coordinate = coordinate;
    ann.title = @"长按的点";
    ann.subtitle = @"副标题";
    [_mapView addAnnotation:ann];
    
}
//自动退出
- (void)applicationDidTimeout:(NSNotification *)notif{
    
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    app.mySigen = nil;
    app.myIntegral = nil;
    app.myPhone = nil;
    app.myKey = nil;
    app.myPassword = nil;
    app.myPhoto = nil;
    app.myUserid = nil;
    
    
}





- (IBAction)goNearShopBtnClick:(UIButton *)sender {
    NearShopViewController *shopVC=[[NearShopViewController alloc] init];
    
    shopVC.jindu=self.jindu;
    shopVC.weidu=self.weidu;
    [self.navigationController pushViewController:shopVC animated:YES];
}

- (IBAction)backBtnClick:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
    self.navigationController.navigationBar.hidden=NO;
    self.tabBarController.tabBar.hidden=NO;
}



@end
