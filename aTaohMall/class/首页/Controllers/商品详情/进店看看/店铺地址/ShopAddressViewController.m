//
//  ShopAddressViewController.m
//  aTaohMall
//
//  Created by JMSHT on 16/5/16.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import "ShopAddressViewController.h"

#import "AFNetworking.h"

#import "ConverUtil.h"
#import "DESUtil.h"
#import "SecretCodeTool.h"
#import "WKProgressHUD.h"
//设备物理尺寸
#define screen_width [UIScreen mainScreen].bounds.size.width
#define screen_height [UIScreen mainScreen].bounds.size.height
#define Myuser [NSUserDefaults standardUserDefaults]

//使用原生地图

//导入高德地图的地图框架

//导入高德搜索框架的头文件


//MapKit是原生地图框架
#import <MapKit/MapKit.h>

//CoreLocation是定位框架
#import <CoreLocation/CoreLocation.h>

@interface ShopAddressViewController ()<MKMapViewDelegate, CLLocationManagerDelegate>
{
    //地图View
    MKMapView *_mapView;
    UIView *view;
    //定位管理器
    CLLocationManager *_locationManager;
    
    CLLocationDegrees latitude;
    
    CLLocationDegrees longitude;
}
@end

@implementation ShopAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.frame=[UIScreen mainScreen].bounds;
    
       //获取数据
        [self getDatas];
    
        WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
    
        dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
        dispatch_after(time, dispatch_get_main_queue(), ^{
    
  
            [hud dismiss:YES];
        });
    
    
    
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

-(void)getDatas
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@getMerchantsAddress_mob.shtml",URL_Str];
    
    NSDictionary *dic = @{@"mid":self.mid};
    
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
            
//            NSLog(@"%@",dic);
            view.hidden=YES;
            for (NSDictionary *dict1 in dic) {
                
                self.city=dict1[@"merchants_map"][@"city"];
                self.coordinates=dict1[@"merchants_map"][@"coordinates"];
                self.county=dict1[@"merchants_map"][@"county"];
                self.province=dict1[@"merchants_map"][@"province"];
                
                self.AddressLabel.text=[NSString stringWithFormat:@"店铺地址：%@%@%@",self.province,self.city,self.county];
            }
            
            
            NSString *str=self.coordinates;
            NSArray *str1=[str componentsSeparatedByString:@","];
            
            self.JinDu=str1[0];
            self.WeiDu=str1[1];
            
            latitude = [self.JinDu doubleValue];
            
            longitude = [self.WeiDu doubleValue];
            
            NSLog(@"%f %f",latitude,longitude);
            
            //显示地图数据
            [self initMap];
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
//        [WKProgressHUD popMessage:@"网络请求失败，请检查您的网络设置" inView:self.view duration:1.5 animated:YES];
        
        [self NoWebSeveice];
        
        NSLog(@"%@",error);
    }];
}
-(void)loadData
{
    
    [self getDatas];
}
-(void)initMap
{
    //创建地图View
    _mapView = [[MKMapView alloc] initWithFrame:CGRectMake(10, 120, [UIScreen mainScreen].bounds.size.width-20, 400)];
    [self.view addSubview:_mapView];
    
    // 大学城坐标: 经度113.968855, 纬度22.586261
    //22.5435660000,113.9631460000
    //中心坐标点
    //CL开头:CoreLocation框架中的
    CLLocationCoordinate2D centerCoordinate = CLLocationCoordinate2DMake(longitude, latitude);
    
    
    
    //缩放系数,参数越小,放得越大
    MKCoordinateSpan span = MKCoordinateSpanMake(0.05, 0.05);
    
    //区域
    MKCoordinateRegion region = MKCoordinateRegionMake(centerCoordinate, span);
    
    //设置地图的显示区域
    [_mapView setRegion:region animated:YES];
    
    
    
//    //设置中心坐标(缩放系数不变)
//    _mapView.centerCoordinate = CLLocationCoordinate2DMake(22.541476, 113.951361);
//    
//    
//    //设置代理
//    _mapView.delegate = self;
//    
//    /*
//     MKMapTypeStandard = 0, //标准地图
//     MKMapTypeSatellite,  //卫星地图
//     MKMapTypeHybrid      //混合地图
//     */
//    _mapView.mapType = MKMapTypeStandard;
//    
//    //是否能缩放
//    _mapView.zoomEnabled = YES;
//    
//    //是否能移动
//    _mapView.scrollEnabled = YES;
//    
//    //是否能旋转
//    _mapView.rotateEnabled = NO;
//    
//    //是否显示自己的位置
//    _mapView.showsUserLocation = YES;
    
    
//    //定位
//    _locationManager = [[CLLocationManager alloc] init];
//    
//    //设置代理,通过代理方法接收自己的位置
//    _locationManager.delegate = self;
//    
//    //iOS8.0的定位
//    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0 ) {
//        [_locationManager requestAlwaysAuthorization];
//        [_locationManager requestWhenInUseAuthorization];
//    }
//    
//    //启动定位
//    [_locationManager startUpdatingLocation];
    
    
    //定位管理器
    _locationManager=[[CLLocationManager alloc]init];
    
    if (![CLLocationManager locationServicesEnabled]) {
        NSLog(@"定位服务当前可能尚未打开，请设置打开！");
        return;
    }
    
    //如果没有授权则请求用户授权
    if ([CLLocationManager authorizationStatus]==kCLAuthorizationStatusNotDetermined){
        [_locationManager requestWhenInUseAuthorization];
    }else if([CLLocationManager authorizationStatus]==kCLAuthorizationStatusAuthorizedWhenInUse){
        //设置代理
        _locationManager.delegate=self;
        //设置定位精度
        _locationManager.desiredAccuracy=kCLLocationAccuracyBest;
        //定位频率,每隔多少米定位一次
        CLLocationDistance distance=10.0;//十米定位一次
        _locationManager.distanceFilter=distance;
        //启动跟踪定位
        [_locationManager startUpdatingLocation];
    }
    
    
    
    //添加长按手势
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    [_mapView addGestureRecognizer:longPress];
    
    
}
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    CLLocation *location=[locations firstObject];//取出第一个位置
    CLLocationCoordinate2D coordinate=location.coordinate;//位置坐标
    NSLog(@"经度：%f,纬度：%f,海拔：%f,航向：%f,行走速度：%f",coordinate.longitude,coordinate.latitude,location.altitude,location.course,location.speed);
    //如果不需要实时定位，使用完即使关闭定位服务
    [_locationManager stopUpdatingLocation];
}
#pragma  mark - CLLocationManagerDelegate
//定位成功
//-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
//{
//    [_locationManager requestWhenInUseAuthorization];
//    
//    CLLocation *location1 = [locations lastObject];
//    CLLocationDegrees latitude1 = location1.coordinate.latitude;
//    CLLocationDegrees longitude1 = location1.coordinate.longitude;
//    NSLog(@"定位成功!");
//    
//    //获取到定位的位置信息
//    CLLocation *location = [locations firstObject];
//    
//    //定位到的当前坐标
//    CLLocationCoordinate2D coordinate = location.coordinate;
//    
//    NSLog(@"(%f, %f)", coordinate.latitude, coordinate.longitude);
//    
////    self.jindu=[NSString stringWithFormat:@"%f",coordinate.longitude];
//    
////    self.weidu=[NSString stringWithFormat:@"%f",coordinate.latitude];
//    
//    //反地理编码(逆地理编码): 将位置信息转换成地址信息
//    //地理编码: 把地址信息转换成位置信息
//    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
//    
//    //反地理编码
//    //尽量不要一次性调用很多次
//    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
//        
//        if (error) {
//            NSLog(@"反地理编码失败!%@",error);
//            return ;
//        }
//        
//        //地址信息
//        CLPlacemark *placemark = [placemarks firstObject];
//        NSString *country = placemark.country;
//        NSString *administrativeArea = placemark.administrativeArea;
//        NSString *subLocality = placemark.subLocality;
//        NSString *name = placemark.name;
//        
//        NSLog(@"%@ %@ %@ %@", country, administrativeArea, subLocality, name);
//        
//        
//    }];
//    
//    //停止定位
//    [_locationManager stopUpdatingLocation];
//}




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


//返回
- (IBAction)backBtnClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}



@end
