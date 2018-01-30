//
//  MerchantSearchResultViewController.m
//  aTaohMall
//
//  Created by JMSHT on 2017/3/7.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "MerchantSearchResultViewController.h"


#import "MerchantModel.h"
#import "MerchantCell.h"

#import "MerchantSearchNoCell.h"

#import "ConverUtil.h"
#import "DESUtil.h"
#import "SecretCodeTool.h"

#import "AFNetworking.h"
#import "UIImageView+WebCache.h"

#import "SearchResultModel.h"

#import "NewGoodsDetailViewController.h"//商品详情

//刷新
#import "DJRefresh.h"
#import "DJRefreshProgressView.h"

#import "HomeLookFooter.h"//点击加载更多

#import "NoDataCell.h"

#import "WKProgressHUD.h"

#import "TimeModel.h"//倒计时model

#import "SearchManager.h"

#import "JRToast.h"

#import "YTSearchCell.h"

#import "YTGoodsDetailViewController.h"

#import "YTSearchOtherCell.h"

#import "MerchantManager.h"

#import "MerchantDetailViewController.h"

//MapKit是原生地图框架
#import <MapKit/MapKit.h>

//CoreLocation是定位框架
#import <CoreLocation/CoreLocation.h>

@interface MerchantSearchResultViewController ()<UITableViewDelegate,UITableViewDataSource,DJRefreshDelegate,FooterViewDelegate,UITextFieldDelegate,MKMapViewDelegate, CLLocationManagerDelegate>
{
    
    UITextField *searchTextField;
    
    UITableView *_tableView;
    
    NSMutableArray *_dataArrM;
    
    NSString *_searchKeyWord;
    
    HomeLookFooter *footer;
    UIView *view;
    int flag;
    NSString *string10;
    
    MerchantSearchNoCell *cell1;
    
    //地图View
    MKMapView *_mapView;
    
    //定位管理器
    CLLocationManager *_locationManager;
    
    
}

@property (nonatomic,strong)DJRefresh *refresh;

@property (nonatomic,strong)NSArray *myArray;//搜索记录的数组
@property(nonatomic,strong)NSMutableArray *myArrM;

@property(nonatomic,strong)NSMutableArray *deleteArrM;

@property(nonatomic,strong) UILabel *NoDataLabel;

@end

@implementation MerchantSearchResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _dataArrM = [NSMutableArray new];
    
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    NSArray * myArray = [userDefaultes arrayForKey:@"NewmyArray"];
    NSLog(@"我要的myArry==%@",myArray);
    
    flag=0;
    
    
    [self initNav];
    
    [self initTableView];
    
    [self GetData];
    
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

//暂无数据
-(void)initNoDataLabel
{
    self.NoDataLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 150, [UIScreen mainScreen].bounds.size.width, 20)];
    
    self.NoDataLabel.text = @"暂无相关店铺";
    
    self.NoDataLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    self.NoDataLabel.textAlignment = NSTextAlignmentCenter;
    
    self.NoDataLabel.font  =[UIFont fontWithName:@"PingFang-SC-Regular" size:13];
    
    [self.view addSubview:self.NoDataLabel];
    
}

-(void)GetData
{
    WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
    
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        
    });
    
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@getTradingArea_mob.shtml",URL_Str];
    
    NSDictionary *dic = @{@"tradingArea":_searchKeyWord,@"flag":[NSString stringWithFormat:@"%d",flag]};
    
    [manager POST:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
        NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];
        
        
        if (codeKey && content) {
            NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
            
//            NSLog(@"xmlStr=%@",xmlStr);
            
            
            NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];
            
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            
            if (flag == 0) {
                
                [_dataArrM removeAllObjects];
                
            }
            
            NSLog(@"=====搜索结果===%@",dic);
            
            view.hidden=YES;
            for (NSDictionary *dict1 in dic) {
                
                string10 = dict1[@"totalCount"];
                
                for (NSDictionary *dict2 in dict1[@"tradingAreaList"]) {
                    
                    MerchantModel *model = [[MerchantModel alloc] init];
                    
                    model.click_volume = dict2[@"click_volume"];
                    model.mid = dict2[@"id"];
                    model.logo = dict2[@"logo"];
                    model.scope = dict2[@"scope"];
                    model.storename = dict2[@"storename"];
                    model.coordinates = dict2[@"coordinates"];
                    [_dataArrM addObject:model];
                    
                }
            }
            
            
            if (_dataArrM.count == 0) {
                
                [self initNoDataLabel];
                _refresh.topEnabled=NO;//下拉刷新
                self.NoDataLabel.hidden = NO;
                
            }else{
                
                self.NoDataLabel.hidden = YES;
                
            }
            
            
            if (_dataArrM.count%12==0&&_dataArrM.count !=[string10 integerValue]) {
                cell1.hidden=YES;
                footer.hidden=NO;
                [footer.loadMoreBtn setTitle:@"点击加载更多" forState:0];
                footer.loadMoreBtn.enabled=YES;
                
            }else if (_dataArrM.count == [string10 integerValue]){
                footer.hidden = NO;
                cell1.hidden=YES;
                footer.moreView.hidden=YES;
                [footer.loadMoreBtn setTitle:@"暂无更多数据" forState:0];
                [footer.loadMoreBtn setTitleColor:[UIColor colorWithRed:154/255.0 green:154/255.0 blue:154/255.0 alpha:1.0] forState:0];
                footer.loadMoreBtn.enabled=NO;
                
                
            }else{
                
                //隐藏点击加载更多
                footer.hidden=YES;
                cell1.hidden=NO;
            }
            
            [hud dismiss:YES];
            
            //刷新数据
            [_tableView reloadData];
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        
        [hud dismiss:YES];
        
    }];
    
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
    
    UIImageView *searchImgView=[[UIImageView alloc] initWithFrame:CGRectMake(55, 26+KSafeTopHeight, [UIScreen mainScreen].bounds.size.width-100, 28)];
    searchImgView.image=[UIImage imageNamed:@"搜索框New"];
    [titleView addSubview:searchImgView];
    
    
    UIImageView *imgView=[[UIImageView alloc] initWithFrame:CGRectMake(55+10, 26+8+KSafeTopHeight, 12, 12)];
    imgView.image=[UIImage imageNamed:@"搜索New"];
    [titleView addSubview:imgView];
    
    searchTextField=[[UITextField alloc] initWithFrame:CGRectMake(90, 30, 240, 20)];
//    searchTextField.placeholder=self.searchString;
    searchTextField.text=self.searchString;
    searchTextField.textColor=[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    searchTextField.textAlignment=NSTextAlignmentLeft;
    searchTextField.font=[UIFont fontWithName:@"PingFang-SC-Regular" size:12];
    
    searchTextField.returnKeyType = UIReturnKeySearch;//更改键盘的return
    searchTextField.delegate = self;
    
    NSLog(@"===_resultArrM===%@",_resultArrM);
    
    //标题数据
    for (NSString *str in _resultArrM) {
        
//        searchTextField.placeholder=str;
        searchTextField.text=str;
        _searchKeyWord=str;
    }
    
    [titleView addSubview:searchTextField];
    
}

-(void)initTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-KSafeAreaTopNaviHeight) style:UITableViewStyleGrouped];
    
    _tableView.delegate=self;
    
    _tableView.dataSource=self;
    
    _tableView.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];
    
    //去掉系统分割线
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:_tableView];
    
    [_tableView registerClass:[MerchantCell class] forCellReuseIdentifier:@"cell"];
    
    [_tableView registerClass:[MerchantSearchNoCell class] forCellReuseIdentifier:@"nocell"];
    
    [_tableView registerNib:[UINib nibWithNibName:@"HomeLookFooter" bundle:nil] forHeaderFooterViewReuseIdentifier:@"header"];
    
    _refresh=[[DJRefresh alloc] initWithScrollView:_tableView delegate:self];
    _refresh.topEnabled=YES;//下拉刷新
    _refresh.bottomEnabled=NO;//上拉加载
    
}
-(void)QurtBtnClick
{
    
    self.tabBarController.tabBar.hidden=NO;
    
    self.navigationController.navigationBar.hidden=YES;
    
    [self.navigationController popToRootViewControllerAnimated:NO];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 105;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (_dataArrM.count==0) {
        
        return 1;
        
    }else{
        
        return _dataArrM.count;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 0.000000001;
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[UIView alloc]init];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (_dataArrM.count==0) {
        
        cell1 = [tableView dequeueReusableCellWithIdentifier:@"nocell"];
        
        cell1.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell1.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];
        
//        if ([string10 integerValue] == 0) {
//            
//            cell1.hidden=NO;
//            
//        }else{
        
            cell1.hidden=YES;
//        }
        
        return cell1;
        
    }else{
        
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
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MerchantDetailViewController *vc = [[MerchantDetailViewController alloc] init];
    
    MerchantModel *model = _dataArrM[indexPath.row];
    
    vc.mid = model.mid;
    
    vc.jindu=self.jindu;
    
    vc.weidu=self.weidu;
    
//    vc.coordinates = model.OneCoordinates;
    
    vc.MapStartAddress = self.MapStartAddress;
    
    vc.coordinates = model.coordinates;
    vc.BackString = @"100";
    
    self.navigationController.navigationBar.hidden=YES;
    
    [self.navigationController pushViewController:vc animated:NO];
    
}
- (void)refresh:(DJRefresh *)refresh didEngageRefreshDirection:(DJRefreshDirection)direction{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self addDataWithDirection:direction];
    });
    
}

- (void)addDataWithDirection:(DJRefreshDirection)direction{
    
    if (direction==DJRefreshDirectionTop) {
        
        flag=0;
        
//        [_dataArrM removeAllObjects];
        
        //获取数据
        [self GetData];
        
        
    }
    
    
    
    [_refresh finishRefreshingDirection:direction animation:YES];
    
    [_tableView reloadData];
    
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
    
    NSLog(@"点击加载更多");
    
    if (_dataArrM.count%12==0) {
        
        flag=flag+1;
        
        //获取数据
        [self GetData];
        
        [_tableView reloadData];
        
    }else{
        
        
    }
}



-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.text.length == 0) {
        
        [JRToast showWithText:@"输入的搜索内容不能为空!" duration:0.5f];
        
        
    }else{
        flag=0;
        textField.returnKeyType=UIReturnKeySearch;
        
        textField.delegate=self;
        
        _searchKeyWord=searchTextField.text;
        
        [_dataArrM removeAllObjects];
        
        
        [self GetData];
        
        
        WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
        
        dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
        dispatch_after(time, dispatch_get_main_queue(), ^{
            
            
            [hud dismiss:YES];
            
        });
        
        [_tableView reloadData];
        
        [textField resignFirstResponder];
        
    }
    
    return YES;
    
}
//搜索

//- (IBAction)searchBtnClick:(UIButton *)sender {
//
//
//
//
//
//}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    
    [searchTextField resignFirstResponder];
    
}

//-(void)textFieldDidEndEditing:(UITextField *)textField
//{
//    [textField resignFirstResponder];
//}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (textField.text.length==0) {
        
//        [JRToast showWithText:@"输入的搜索内容不能为空!" duration:0.5f];
        
    }else{
        
        
        //        [SearchManager SearchText:textField.text];//缓存搜索记录
        //        [self readNSUserDefaults];
        //
        //
        //        [_myArrM addObject:textField.text];
        
        //---------------------------
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        NSArray * myArray = [userDefaultes arrayForKey:@"NewmyArray"];
        
        if (myArray.count==0) {
            
            [MerchantManager SearchText:textField.text];//缓存搜索记录
            [self readNSUserDefaults];
            
            
            [_myArrM addObject:textField.text];
            
        }else{
            
            
            
            if ([myArray containsObject:textField.text]) {
                
                NSLog(@"****相等*****");
            }else{
                NSLog(@"*****不相等****");
                
                [MerchantManager SearchText:textField.text];//缓存搜索记录
                [self readNSUserDefaults];
                
                
                [_myArrM addObject:textField.text];
                
            }
            
        }
        //----------------------------
        
        [_tableView reloadData];
        
        NSLog(@"搜索被点击了");
        
    }
    
}

-(void)readNSUserDefaults{//取出缓存的数据
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数组NSArray类型的数据
    NSArray * myArray = [userDefaultes arrayForKey:@"NewmyArray"];
    self.myArray = myArray;
    
    for (NSString *str in self.myArray) {
        [_deleteArrM addObject:str];
    }
    
    [_tableView reloadData];
    NSLog(@"myArray======%@",myArray);
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
