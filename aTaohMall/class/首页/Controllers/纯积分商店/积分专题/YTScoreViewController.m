//
//  YTScoreViewController.m
//  aTaohMall
//
//  Created by JMSHT on 2016/11/14.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import "YTScoreViewController.h"

#import "LimitTimeCell.h"

#import "CollectionFooterView.h"


#import "WKProgressHUD.h"

#import "NineFooterView.h"

//刷新
#import "DJRefresh.h"
#import "DJRefreshProgressView.h"

#import "XSInfoView.h"

#import "NoCollectionViewCell.h"

#import "AFNetworking.h"

#import "NineModel.h"

#import "UIImageView+WebCache.h"

#import "TimeModel.h"

//加密
#import "DESUtil.h"
#import "ConverUtil.h"
#import "SecretCodeTool.h"
#import "YTGoodsDetailViewController.h"
#import "YTScoreModel.h"
#import "NoGoodsDetailViewController.h"
#define fwidth [UIScreen mainScreen].bounds.size.width
#define fheight [UIScreen mainScreen].bounds.size.height

#import "ZQCountDownView.h"
#import "CountDown.h"

#import "YTScoreCell.h"

#import "YTJIFenCell.h"
@interface YTScoreViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,FooterViewDelegate,DJRefreshDelegate>
{
    
    UICollectionView *_collectionView1;
    UICollectionView *_collectionView2;
    
    NSMutableArray *_datasArray;
    
    NSMutableArray *_dataSource1;
    
     NSMutableArray *_dataSource2;
    NSString *str;
    
    UIView *view;
    
    NineFooterView *footer1;
    
    NineFooterView *footer2;
    
    int page;
    
    int currentPageNo;
    
    NSString *string10;//数据的总条数
    
    
    NSMutableArray *_StopArrM;
    NSMutableArray *_StartArrM;
    
    UIView *mainView;
    UIView *titleView;
    UILabel *YTLabel1;
    UIButton *YTButton1;
    UILabel *YTLabel2;
    UIButton *YTButton2;
    UILabel *YTLabel3;
    UIView *timeView;
    
    UILabel *_lable;
    
    
}

@property (nonatomic, weak)   id           m_data;
@property (nonatomic, weak)   NSIndexPath *m_tmpIndexPath;

@property (strong, nonatomic)  CountDown *countDownForBtn;

@property (strong, nonatomic)  CountDown *countDownForLabel;

@property (nonatomic,strong)DJRefresh *refresh;

@property (nonatomic, strong) NSTimer        *m_timer; //定时器

@end

@implementation YTScoreViewController


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden=YES;
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.frame=kScreen_Bounds;
    
    
    
    _countDownForLabel = [[CountDown alloc] init];
    _countDownForBtn = [[CountDown alloc] init];
    
    

    
    self.BoolString=@"1";
    
    page=0;
    
    _dataSource1=[NSMutableArray new];
    
    _dataSource2=[NSMutableArray new];
    
    
//    self.ChunJiFenLabel.textColor=[UIColor redColor];
    if (self.navigationController) {
        self.title=@"积分专题";
    }
    [self initUI];
    
    
    
    if ([self.TypeString isEqualToString:@"100"]) {
        
        self.BoolString=@"2";
        [self initCollectionView2];
        
        [self getDatas1];
        
    }else{
        
        self.BoolString=@"1";
        [self initCollectionView1];
        
        [self getDatas2];
    }
    
    
    
    [self createTimer];
    
    [self defaultConfig];
    
   
    
}

-(void)initUI
{
    
    mainView=[[UIView alloc] initWithFrame:CGRectMake(0, 65, [UIScreen mainScreen].bounds.size.width, 78)];
    
    mainView.backgroundColor=[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];
    
    [self.view addSubview:mainView];
    
    
    titleView=[[UIView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-200)/2, 9, 200, 30)];
    
    
    titleView.layer.cornerRadius  = 2;
    titleView.layer.masksToBounds = YES;
    
    [mainView addSubview:titleView];
    
    YTLabel1=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    YTLabel1.text=@"纯积分商品";
    
//    YTLabel1.layer.cornerRadius  = 2;
//    YTLabel1.layer.masksToBounds = YES;
    
    YTLabel1.textAlignment=NSTextAlignmentCenter;
    YTLabel1.font=[UIFont fontWithName:@"PingFangSC-Regular" size:13];
    if ([self.TypeString isEqualToString:@"100"]) {
        
        YTLabel1.backgroundColor=[UIColor colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1.0];
        YTLabel1.textColor=[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
        
    }else{
        
        YTLabel1.backgroundColor=[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
        YTLabel1.textColor=[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    }
    [titleView addSubview:YTLabel1];
    
    
    YTButton1=[UIButton buttonWithType:UIButtonTypeCustom];
    YTButton1.frame=CGRectMake(0, 0, 100, 20);
    YTButton1.userInteractionEnabled=YES;
    [YTButton1 addTarget:self action:@selector(YTJiFenBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:YTButton1];
    
    YTLabel2=[[UILabel alloc] initWithFrame:CGRectMake(100, 0, 100, 30)];
    YTLabel2.text=@"专题积分商品";
    
//    YTLabel2.layer.cornerRadius  = 2;
//    YTLabel2.layer.masksToBounds = YES;
    
    YTLabel2.textAlignment=NSTextAlignmentCenter;
    YTLabel2.font=[UIFont fontWithName:@"PingFangSC-Regular" size:13];
    if ([self.TypeString isEqualToString:@"100"]) {
        
        YTLabel2.backgroundColor=[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
        YTLabel2.textColor=[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
        
    }else{
        
        YTLabel2.backgroundColor=[UIColor colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1.0];
        YTLabel2.textColor=[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
    }
    [titleView addSubview:YTLabel2];
    
    YTButton2=[UIButton buttonWithType:UIButtonTypeCustom];
    YTButton2.frame=CGRectMake(100, 0, 100, 20);
    YTButton2.userInteractionEnabled=YES;
    [YTButton2 addTarget:self action:@selector(YTBaBiErBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:YTButton2];
    
    
    UIView *Other=[[UIView alloc] initWithFrame:CGRectMake(15, 48, ([UIScreen mainScreen].bounds.size.width-30), 30)];
    
    Other.backgroundColor=[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];
    
    [mainView addSubview:Other];
    
    UIImageView *baImage=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ([UIScreen mainScreen].bounds.size.width-30), 30)];
    
     
    baImage.image=[UIImage imageNamed:@"YT框"];
    
    [Other addSubview:baImage];
    
    
    YTLabel3=[[UILabel alloc] initWithFrame:CGRectMake(15, 5, 80, 20)];
    YTLabel3.text=@"剩余抢购时间:";
    YTLabel3.textAlignment=NSTextAlignmentLeft;
    YTLabel3.font=[UIFont fontWithName:@"PingFangSC-Semibold" size:12];
    YTLabel3.backgroundColor=[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];
    YTLabel3.textColor=[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    [Other addSubview:YTLabel3];
    
    timeView=[[UIView alloc] initWithFrame:CGRectMake(YTLabel3.frame.size.width+15, 1, ([UIScreen mainScreen].bounds.size.width-30)/2, 28)];
    timeView.backgroundColor=[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];
    
    [Other addSubview:timeView];
    
    
    UIImageView *img1=[[UIImageView alloc] initWithFrame:CGRectMake(5, 4, 20, 20)];
    
    img1.image=[UIImage imageNamed:@"YT小框"];
    
    
    [timeView addSubview:img1];
    
    self.YTHourLabel=[[UILabel alloc] initWithFrame:CGRectMake(5, 4, 20, 20)];
    self.YTHourLabel.text=@"";
    self.YTHourLabel.textAlignment=NSTextAlignmentCenter;
    self.YTHourLabel.font=[UIFont fontWithName:@"PingFangSC-Regular" size:12];
//    self.YTHourLabel.backgroundColor=[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];
    self.YTHourLabel.textColor=[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    [timeView addSubview:self.YTHourLabel];
    
    
    UILabel *YTLine1Label=[[UILabel alloc] initWithFrame:CGRectMake(25, 4, 15, 20)];
    YTLine1Label.text=@":";
    YTLine1Label.textAlignment=NSTextAlignmentCenter;
    YTLine1Label.font=[UIFont fontWithName:@"PingFangSC-Regular" size:12];
    YTLine1Label.textColor=[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    [timeView addSubview:YTLine1Label];
    
    
    
    UIImageView *img2=[[UIImageView alloc] initWithFrame:CGRectMake(40, 4, 20, 20)];
    
    img2.image=[UIImage imageNamed:@"YT小框"];
    
    
    [timeView addSubview:img2];
    
    
    self.YTMinLabel=[[UILabel alloc] initWithFrame:CGRectMake(40, 4, 20, 20)];
    self.YTMinLabel.text=@"";
    self.YTMinLabel.textAlignment=NSTextAlignmentCenter;
    self.YTMinLabel.font=[UIFont fontWithName:@"PingFangSC-Regular" size:12];
//    self.YTMinLabel.backgroundColor=[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];
    self.YTMinLabel.textColor=[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    [timeView addSubview:self.YTMinLabel];
    
    
    UILabel *YTLine2Label=[[UILabel alloc] initWithFrame:CGRectMake(60, 4, 15, 20)];
    YTLine2Label.text=@":";
    YTLine2Label.textAlignment=NSTextAlignmentCenter;
    YTLine2Label.font=[UIFont fontWithName:@"PingFangSC-Regular" size:12];
    YTLine2Label.textColor=[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    [timeView addSubview:YTLine2Label];
    
    
    UIImageView *img3=[[UIImageView alloc] initWithFrame:CGRectMake(75, 4, 20, 20)];
    
    img3.image=[UIImage imageNamed:@"YT小框"];
    
    
    [timeView addSubview:img3];
    
    
    self.YTSecLabel=[[UILabel alloc] initWithFrame:CGRectMake(75, 4, 20, 20)];
    self.YTSecLabel.text=@"";
    self.YTSecLabel.textAlignment=NSTextAlignmentCenter;
    self.YTSecLabel.font=[UIFont fontWithName:@"PingFangSC-Regular" size:12];
//    self.YTSecLabel.backgroundColor=[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];
    self.YTSecLabel.textColor=[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    [timeView addSubview:self.YTSecLabel];
    
    
}

-(void)YTJiFenBtnClick
{
    
    self.BoolString=@"1";
    YTLabel1.backgroundColor=[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
    YTLabel2.backgroundColor=[UIColor colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1.0];
    
    YTLabel2.textColor=[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
    YTLabel1.textColor=[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    
    [self initCollectionView1];
    [_dataSource1 removeAllObjects];
    
    [self getDatas2];
}

-(void)YTBaBiErBtnClick
{
    
    [_dataSource2 removeAllObjects];
    
    self.BoolString=@"2";
    
    YTLabel1.textColor=[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
    YTLabel2.textColor=[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    
    
    YTLabel2.backgroundColor=[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
    YTLabel1.backgroundColor=[UIColor colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1.0];
    
    [self initCollectionView2];
    
    
    page=0;
    
    [self getDatas1];
    
}

-(void)initview{
    
    [_lable removeFromSuperview];
    
    _lable = [[UILabel alloc]initWithFrame:CGRectMake(0,([UIScreen mainScreen].bounds.size.height-80)/2 , [UIScreen mainScreen].bounds.size.width, 80)];
    _lable.text = @"暂无相关数据";
    _lable.textColor = [UIColor lightGrayColor];
    _lable.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_lable];
    
}


- (IBAction)backBanClick:(UIButton *)sender {
    
    
    self.time=0;
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
    [_countDownForLabel destoryTimer];
    [_countDownForBtn destoryTimer];
}


-(void)getDatas2
{
    //如果数据源空，则隐藏按钮
    
    
    WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
    
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        
        
    });
    
    //清空数据源
    //    [_datasArray removeAllObjects];
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    
    NSDictionary *dict=nil;
    
    NSString *url=[NSString stringWithFormat:@"%@getPureIntegralGoods_mob.shtml",URL_Str];
    
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
            
            NSLog(@"nine2=%@",xmlStr);
            
                        view.hidden=YES;
            
            
//            [_dataSource1 removeAllObjects];
            
            
                        for (NSDictionary *dict in dic) {
                            
                            self.start_time2=dict[@"current_time_stamp"];
                            self.end_time2=dict[@"end_time"];
                            
                            
                            NSDictionary *dict1=dict[@"integralGoodsList"];
                            
                            for (NSDictionary *dict2 in dict1) {
                                
                                YTScoreModel *model=[[YTScoreModel alloc] init];
                                model.amount=dict2[@"amount"];
                                model.id=dict2[@"id"];
                                model.name=dict2[@"name"];
                                model.attribute = dict2[@"is_attribute"];
                                model.end_time_str=dict2[@"end_time"];
                                model.current_time_stamp=dict2[@"current_time_stamp"];
                                
                                model.good_type=dict2[@"good_type"];
                                model.pay_integer=dict2[@"pay_integer"];
                                model.scopeimg=dict2[@"scopeimg"];
                                model.start_time_str=dict2[@"start_time"];
                                model.status=dict2[@"status"];
                                model.storename = dict2[@"storename"];
                                
                                
                                
                                [_dataSource1 addObject:model];
            
            
                            }
                        }

            
            
            if (_dataSource1.count == 0) {
                
                [self initview];
                //                _refresh.topEnabled=NO;//下拉刷新
                _lable.hidden = NO;
            }else{
                
                _lable.hidden = YES;
                
            }
            
            
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.0"];
            
            //当前时间
//            NSDate *date3 = [NSDate dateWithTimeIntervalSinceNow:0];
            
            
            //    NSDate *date1 = [dateFormatter dateFromString:@"2016-02-02 16:00:00.0"];
            NSDate *date2 = [dateFormatter dateFromString:self.end_time2];
            
            NSDate *date3 = [dateFormatter dateFromString:self.start_time2];
            
            
            NSDate *num1 = [self getNowDateFromatAnDate:date3];
            NSDate *num2=[self getNowDateFromatAnDate:date2];
            
            
            NSLog(@"=====66666====当前日期为:%@",num1);
            NSLog(@"=====66666====结束日期为:%@",num2);
            
            NSTimeInterval hh1= [num1 timeIntervalSince1970];
            
            NSTimeInterval hh2 = [num2 timeIntervalSince1970];
            
            
            NSInteger times;
            
            
            times=hh2-hh1;
            
            self.time=times;
            
            
            
            //刷新数据
            [hud dismiss:YES];
            
            [_collectionView1 reloadData];
            
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
        [hud dismiss:YES];
        
        self.WebString=@"1";
        
        [self NoWebSeveice];
        
        //       [WKProgressHUD popMessage:@"网络请求失败，请检查您的网络设置" inView:self.view duration:1.5 animated:YES];
        
        NSLog(@"errpr = %@",error);
    }];
}


-(void)getDatas1
{
    //如果数据源空，则隐藏按钮
    
    
    WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
    
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        
        
    });
    
    //清空数据源
    //    [_datasArray removeAllObjects];
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSDictionary *dict=@{@"page":[NSString stringWithFormat:@"%d",page]};
    
    NSLog(@"===str==%@",str);
    //    NSDictionary *dict=nil;
    
    NSString *url=[NSString stringWithFormat:@"%@getSpecialIntegralGoods_mob.shtml",URL_Str];
    
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
            
            NSLog(@"nine=%@",xmlStr);
            
            view.hidden=YES;
            
            
//            [_dataSource2 removeAllObjects];
            
            for (NSDictionary *dict in dic) {
                NSDictionary *dict1=dict[@"integralGoodsList"];
                string10=dict[@"totalCount"];
                
                self.start_time1=dict[@"current_time_stamp"];
                self.end_time1=dict[@"end_time"];
                
                for (NSDictionary *dict2 in dict1) {
                    
                    YTScoreModel *model=[[YTScoreModel alloc] init];
                    model.amount=dict2[@"amount"];
                    model.id=dict2[@"id"];
                    model.name=dict2[@"name"];
                    model.attribute = dict2[@"is_attribute"];
                    model.end_time_str=dict2[@"end_time"];
                    model.current_time_stamp=dict2[@"current_time_stamp"];
                    model.good_type=dict2[@"good_type"];
                    model.pay_integer=dict2[@"pay_integer"];
                    model.pay_maney=dict2[@"pay_maney"];
                    model.scopeimg=dict2[@"scopeimg"];
                    model.start_time_str=dict2[@"start_time"];
                    model.status=dict2[@"status"];
                    model.storename = dict2[@"storename"];
                    
                    
                    [_dataSource2 addObject:model];
                    
                    
                }
            }
            
            if (_dataSource2.count == 0) {
                
                [self initview];
                //                _refresh.topEnabled=NO;//下拉刷新
                _lable.hidden = NO;
            }else{
                
                _lable.hidden = YES;
                
            }
            
            if (_dataSource2.count%12==0&&_dataSource2.count !=[string10 integerValue]) {
                
                NSLog(@"111111");
                
                footer2.hidden=NO;
                [footer2.loadMoreBtn setTitle:@"点击加载更多" forState:0];
//                [footer2.loadMoreBtn setTitleColor:[UIColor colorWithRed:91/255.0 green:150/255.0 blue:255/255.0 alpha:1.0] forState:0];
                footer2.loadMoreBtn.enabled=YES;
                
            }else if (_dataSource2.count == [string10 integerValue]){
                
                NSLog(@"22222");
                
                
                footer2.hidden=NO;
                footer2.moreView.hidden=YES;
                [footer2.loadMoreBtn setTitle:@"暂无更多数据" forState:0];
                [footer2.loadMoreBtn setTitleColor:[UIColor colorWithRed:154/255.0 green:154/255.0 blue:154/255.0 alpha:1.0] forState:0];
                footer2.loadMoreBtn.enabled=NO;
                
                
            }else{
                
                
                NSLog(@"333333");
                
                //隐藏点击加载更多
                footer2.hidden=YES;
                
            }
            
            
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.0"];
            
            //当前时间
            //            NSDate *date3 = [NSDate dateWithTimeIntervalSinceNow:0];
            
            
            //    NSDate *date1 = [dateFormatter dateFromString:@"2016-02-02 16:00:00.0"];
            NSDate *date2 = [dateFormatter dateFromString:self.end_time1];
            
            NSDate *date3 = [dateFormatter dateFromString:self.start_time1];
            
            
            NSDate *num1 = [self getNowDateFromatAnDate:date3];
            NSDate *num2=[self getNowDateFromatAnDate:date2];
            
            
            NSLog(@"=====66666====当前日期为:%@",num1);
            NSLog(@"=====66666====结束日期为:%@",num2);
            
            NSTimeInterval hh1= [num1 timeIntervalSince1970];
            
            NSTimeInterval hh2 = [num2 timeIntervalSince1970];
            
            
            NSInteger times;
            
            
            times=hh2-hh1;
            
            self.time=times;
            
            
            [hud dismiss:YES];
            
           // 刷新数据
            [_collectionView2 reloadData];
            
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
        [hud dismiss:YES];
        
        self.WebString=@"2";
        
        [self NoWebSeveice];
        
        //       [WKProgressHUD popMessage:@"网络请求失败，请检查您的网络设置" inView:self.view duration:1.5 animated:YES];
        
        NSLog(@"errpr = %@",error);
    }];
}



-(void)initCollectionView1
{
    
    UICollectionViewFlowLayout *flow=[[UICollectionViewFlowLayout alloc] init];
    
    _collectionView1=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 153, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-143) collectionViewLayout:flow];
    
    _collectionView1.delegate=self;
    _collectionView1.dataSource=self;
    
    _collectionView1.backgroundColor=[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];
    
    [self.view addSubview:_collectionView1];
    
    
    _refresh=[[DJRefresh alloc] initWithScrollView:_collectionView1 delegate:self];
    _refresh.topEnabled=YES;//下拉刷新
    _refresh.bottomEnabled=NO;//上拉加载
    
    
    [_collectionView1 registerNib:[UINib nibWithNibName:@"YTJIFenCell" bundle:nil] forCellWithReuseIdentifier:@"cell10"];
    
    [_collectionView1 registerNib:[UINib nibWithNibName:@"NoCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell11"];
    
    [_collectionView1 registerNib:[UINib nibWithNibName:@"NineFooterView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer10"];
}

-(void)initCollectionView2
{
    
    UICollectionViewFlowLayout *flow=[[UICollectionViewFlowLayout alloc] init];
    
    _collectionView2=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 153, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-143) collectionViewLayout:flow];
    
    _collectionView2.delegate=self;
    _collectionView2.dataSource=self;
    
    _collectionView2.backgroundColor=[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];
    
    [self.view addSubview:_collectionView2];
    
    
    
    _refresh=[[DJRefresh alloc] initWithScrollView:_collectionView2 delegate:self];
    _refresh.topEnabled=YES;//下拉刷新
    _refresh.bottomEnabled=NO;//上拉加载
    
    [_collectionView2 registerNib:[UINib nibWithNibName:@"YTJIFenCell" bundle:nil] forCellWithReuseIdentifier:@"cell20"];
    
    [_collectionView2 registerNib:[UINib nibWithNibName:@"NoCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell21"];
    
    [_collectionView2 registerNib:[UINib nibWithNibName:@"NineFooterView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
    
    
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView==_collectionView1) {
        
        return _dataSource1.count;
    }else{
        
        return _dataSource2.count;
    }
    
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    return CGSizeMake((fwidth-35)/2, fheight*4/10);
    return CGSizeMake((fwidth-35)/2, 225);
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

////section的边距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    //上,左,下,右
    return UIEdgeInsetsMake(0, 15, 7, 15);
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView==_collectionView1) {
        
        
        if (_dataSource1.count==0) {
            
            NoCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cell1" forIndexPath:indexPath];
            
            return cell;
        }else{
            
            YTJIFenCell *cell1=[collectionView dequeueReusableCellWithReuseIdentifier:@"cell10" forIndexPath:indexPath];
            
            
            YTScoreModel *model=_dataSource1[indexPath.row];
            
            //        [cell1.GoosImageView sd_setImageWithURL:[NSURL URLWithString:model.scopeimg]];
            
            cell1.StorenameLabel.text = model.storename;
            [cell1.GoosImageView sd_setImageWithURL:[NSURL URLWithString:model.scopeimg] placeholderImage:[UIImage imageNamed:@"default_image"] options:SDWebImageProgressiveDownload];
            
            cell1.NameLabel.text=model.name;
            
            cell1.AmountLabel.text=[NSString stringWithFormat:@"%@人付款",model.amount];
            
            cell1.PriceLabel.text=[NSString stringWithFormat:@"%.02f积分",[model.pay_integer floatValue]];
            
//            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.0"];
//            NSDate *end=[dateFormatter dateFromString:model.end_time_str];
//            NSDate *NewStart=[dateFormatter dateFromString:model.current_time_stamp];
//            
//            NSLog(@"===%@===%@===",model.end_time_str,model.current_time_stamp);
//            
//            NSDate *timedata = [NSDate date];
//            //        NSDate *start=[dateFormatter dateFromString:];
//            
//            
//            
//            //            NSLog(@"=========start_time_str:%@",start);
//            
//            
//            NSTimeInterval _end=[end timeIntervalSince1970];
//            
//            NSTimeInterval _start=[timedata timeIntervalSince1970];
//            
//            NSInteger time=(NSInteger)(_end - _start);
//            
//            NSLog(@"*****%ld",time);
//            
//            TimeModel *model2 = [[TimeModel alloc]init];
//            model2.m_countNum = (int)time;
//            
//            [self  loadData:model2 type:@"2"];
//            
//            NSLog(@"======1111111===end_time_str:%@",[NSString stringWithFormat:@"%@ 后结束",[model2 currentTimeString]]);
            
            
            if ([model.status isEqualToString:@"6"]) {
                
                cell1.NoBuyImageView.hidden=NO;
                
            }else{
                
                cell1.NoBuyImageView.hidden=YES;
            }
            
            
            return cell1;
            
            
        }
        
    }else{
        
        
        if (_dataSource2.count==0) {
            
            NoCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cell1" forIndexPath:indexPath];
            
            return cell;
            
        }else{
            
            
            YTJIFenCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cell20" forIndexPath:indexPath];
            
            YTScoreModel *model=_dataSource2[indexPath.row];
            
            //        [cell1.GoosImageView sd_setImageWithURL:[NSURL URLWithString:model.scopeimg]];
            
            cell.StorenameLabel.text = model.storename;
            [cell.GoosImageView sd_setImageWithURL:[NSURL URLWithString:model.scopeimg] placeholderImage:[UIImage imageNamed:@"default_image"] options:SDWebImageProgressiveDownload];
            
            cell.NameLabel.text=model.name;
            
           
            cell.AmountLabel.text=[NSString stringWithFormat:@"%@人付款",model.amount];
            
            cell.PriceLabel.text=[NSString stringWithFormat:@"%.02f积分+￥%.02f",[model.pay_integer floatValue],[model.pay_maney floatValue]];
            
            
//            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.0"];
//            NSDate *end=[dateFormatter dateFromString:model.end_time_str];
//            NSDate *NewStart=[dateFormatter dateFromString:model.current_time_stamp];
//            
//            NSDate *timedata = [NSDate date];
//            //        NSDate *start=[dateFormatter dateFromString:];
//            
//            
//            
//            //            NSLog(@"=========start_time_str:%@",start);
//            
//            
//            NSTimeInterval _end=[end timeIntervalSince1970];
//            
//            NSTimeInterval _start=[timedata timeIntervalSince1970];
//            
//            NSInteger time=(NSInteger)(_end - _start);
//            NSLog(@"*****%ld",time);
//            
//            TimeModel *model2 = [[TimeModel alloc]init];
//            model2.m_countNum = (int)time;
//            
//            [self  loadData:model2 type:@"2"];
//            
//            NSLog(@"===222222======end_time_str:%@",[NSString stringWithFormat:@"%@ 后结束",[model2 currentTimeString]]);
            
            if ([model.status isEqualToString:@"6"]) {
                
                cell.NoBuyImageView.hidden=NO;
                
            }else{
                
                cell.NoBuyImageView.hidden=YES;
            }
            
            return cell;
            
        }
        
    }
}

//footer
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView==_collectionView1) {
        
        footer1=[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer10" forIndexPath:indexPath];
        
        footer1.delegate=self;
//        if (_dataSource.count == 0) {
//            footer.hidden = YES;
//        }
        footer1.hidden=YES;
        
        return footer1;
        
    }else{
        
        footer2=[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer" forIndexPath:indexPath];
        
        footer2.delegate=self;
        if (_dataSource2.count == 0) {
            footer2.hidden = YES;
        }
        return footer2;
        
    }
    
    
}



//返回footer的高度
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeMake([UIScreen mainScreen].bounds.size.width-20, 44);
}

- (void)refresh:(DJRefresh *)refresh didEngageRefreshDirection:(DJRefreshDirection)direction{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self addDataWithDirection:direction];
    });
    
}

- (void)addDataWithDirection:(DJRefreshDirection)direction{
    
    if (direction==DJRefreshDirectionTop) {
        
        
        if ([self.BoolString isEqualToString:@"1"]) {
            
            [_dataSource1 removeAllObjects];
            
            [self getDatas2];
            
        }else{
            
            [_dataSource2 removeAllObjects];
            
            page=0;
            
            [self getDatas1];
        }
//        page=0;
//        
//        currentPageNo=1;
//        
//        [_dataSource removeAllObjects];
//        //获取数据
//        [self getDatas];
//        //        WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
//        //
//        //        dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
//        //        dispatch_after(time, dispatch_get_main_queue(), ^{
//        //            [hud dismiss:YES];
//        //        });
    }
//    
//    
//    
    [_refresh finishRefreshingDirection:direction animation:YES];
//    
//    [_collectionView reloadData];
    
}


//加载更多数据代理方法
- (void)FooterViewClickedloadMoreData
{
    
    NSLog(@"点击加载更多");
    
    if (_dataSource2.count%12==0) {
        
//        str=self.NineId;
        
        page=page+1;
        
//        currentPageNo=currentPageNo+1;
        
        //获取数据
        [self getDatas1];
        
        
    }else{
        
        
    }
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld",indexPath.row);
    
    //    NSString *str=[NSString stringWithFormat:@"%ld",indexPath.row];
    //    NSString *str2;
    
    
    if (collectionView==_collectionView1) {
        YTScoreModel *model=_dataSource1[indexPath.row];
        
        
        self.gid=model.id;
        
        //        self.gid=model.id;
        self.good_type=model.good_type;
        self.good_status=model.status;
        self.attribute = model.attribute;
//        [self getDetailDatas];
        
        //        if ([self.String isEqualToString:@"10000"]) {
        //
        //            if ([self.status isEqualToString:@"7"] || [self.status isEqualToString:@"6"]) {
        //
        //                NoGoodsDetailViewController *vc=[[NoGoodsDetailViewController alloc] init];
        //
        //                [self.navigationController pushViewController:VC animated:NO];
        //
        //                self.navigationController.navigationBar.hidden=YES;
        //            }else{
        //
        YTGoodsDetailViewController *vc=[[YTGoodsDetailViewController alloc] init];
        
        vc.ID=model.id;
        vc.gid=model.id;
        vc.good_type=model.good_type;
        vc.status=model.status;
        vc.attribute = model.attribute;
        
        vc.Attribute_back=@"2";
        [self.navigationController pushViewController:vc animated:NO];
        
        self.navigationController.navigationBar.hidden=YES;

    }else if (collectionView==_collectionView2){
        
        YTScoreModel *model=_dataSource2[indexPath.row];
        
        
        self.gid=model.id;
        self.good_type=model.good_type;
        self.good_status=model.status;
        self.attribute = model.attribute;
//        [self getDetailDatas];
        
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
        YTGoodsDetailViewController *vc=[[YTGoodsDetailViewController alloc] init];
        
        vc.ID=model.id;
        vc.gid=model.id;
        vc.good_type=model.good_type;
        vc.status=model.status;
        vc.attribute = model.attribute;
        
        vc.Attribute_back=@"2";
        [self.navigationController pushViewController:vc animated:NO];
        
        self.navigationController.navigationBar.hidden=YES;
        //            }
        //        }
    }
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
    
//    WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
//    
//    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
//    dispatch_after(time, dispatch_get_main_queue(), ^{
//        [hud dismiss:YES];
//    });
//    
////    [self getDatas];
    
    if ([self.WebString isEqualToString:@"1"]) {
        
        [self getDatas2];
        
    }else{
        
        [self getDatas1];
        
    }
    
}

- (void)createTimer {
    
    self.m_timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(timerEvent) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_m_timer forMode:NSRunLoopCommonModes];
}
- (void)timerEvent {
    
    [_collectionView2 reloadData];
    [_collectionView1 reloadData];
}

//倒计时

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


- (void)defaultConfig {
    
    [self registerNSNotificationCenter];
    
    
}

- (void)loadData:(id)data type:(NSString *)string{
    
    if ([data isMemberOfClass:[TimeModel class]]) {
        
        [self storeWeakValueWithData:data];
        
        TimeModel *model = (TimeModel*)data;
        
        if ([string isEqualToString:@"1"]) {
            
            NSString *string  = [NSString stringWithFormat:@"%@",[model currentTimeString]];
            
            NSArray *b = [string componentsSeparatedByString:@":"];
            
            
            self.YTHourLabel.text=[b objectAtIndex:0];
            self.YTMinLabel.text=[b objectAtIndex:1];
            self.YTSecLabel.text=[b objectAtIndex:2];
            
            self.YTHourLabel.layer.cornerRadius  = 2;
            self.YTHourLabel.layer.masksToBounds = YES;
            
            self.YTMinLabel.layer.cornerRadius  = 2;
            self.YTMinLabel.layer.masksToBounds = YES;
            
            self.YTSecLabel.layer.cornerRadius  = 2;
            self.YTSecLabel.layer.masksToBounds = YES;
            
            NSLog(@"==%@==%@==%@",[b objectAtIndex:0],[b objectAtIndex:1],[b objectAtIndex:2]);
            
            if ([[b objectAtIndex:0] isEqualToString:@"00"] && [[b objectAtIndex:1] isEqualToString:@"00"] && [[b objectAtIndex:2] isEqualToString:@"00"]) {
                
                if ([self.BoolString isEqualToString:@"1"]) {
                    
                    [_dataSource1 removeAllObjects];
                    
                    [self getDatas2];
                    
                }else{
                    
                    [_dataSource2 removeAllObjects];
                    
                    page=0;
                    
                    [self getDatas1];
                }
                
            }
            
            
        }else{
            
            NSString *string  = [NSString stringWithFormat:@"%@",[model currentTimeString]];
            
            
            NSArray *b = [string componentsSeparatedByString:@":"];
            
            
            self.YTHourLabel.text=[b objectAtIndex:0];
            self.YTMinLabel.text=[b objectAtIndex:1];
            self.YTSecLabel.text=[b objectAtIndex:2];
            
            self.YTHourLabel.layer.cornerRadius  = 2;
            self.YTHourLabel.layer.masksToBounds = YES;
            
            self.YTMinLabel.layer.cornerRadius  = 2;
            self.YTMinLabel.layer.masksToBounds = YES;
            
            self.YTSecLabel.layer.cornerRadius  = 2;
            self.YTSecLabel.layer.masksToBounds = YES;
            
            
            NSLog(@"==%@==%@==%@",[b objectAtIndex:0],[b objectAtIndex:1],[b objectAtIndex:2]);
            
            
            if ([[b objectAtIndex:0] isEqualToString:@"00"] && [[b objectAtIndex:1] isEqualToString:@"00"] && [[b objectAtIndex:2] isEqualToString:@"00"]) {
                
                
                if ([self.BoolString isEqualToString:@"1"]) {
                    
                    [_dataSource1 removeAllObjects];
                    
                    [self getDatas2];
                    
                }else{
                    
                    [_dataSource2 removeAllObjects];
                    
                    page=0;
                    
                    [self getDatas1];
                }
            }
        }
    }
}

- (void)storeWeakValueWithData:(id)data {
    
    self.m_data         = data;
//    self.m_tmpIndexPath = indexPath;
}

- (void)dealloc {
    
    [self removeNSNotificationCenter];
    [self.m_timer invalidate];
    self.m_timer=nil;
    self.timer = nil;
}

#pragma mark - 通知中心
- (void)registerNSNotificationCenter {
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(notificationCenterEvent:)
                                                 name:NOTIFICATION_TIME_CELL
                                               object:nil];
}

- (void)removeNSNotificationCenter {
    
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NOTIFICATION_TIME_CELL object:nil];
    
    
}

- (void)notificationCenterEvent:(id)sender {
    
    if (self.m_isDisplayed) {
      //  [self loadData:self.m_data type:@""];
    }
}

#pragma mark - setter
- (void)setTime:(NSTimeInterval)time {
    
    _time = time;
    
    [self setViewWith:_time];
    
    [self.timer invalidate];
    self.timer = nil;
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeRun) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    [self.timer fire];
    
}

-(void)setEnd_time_str:(NSString *)end_time_str
{
    
    _end_time_str=end_time_str;
    
    
}

#pragma mark - personal
- (void)timeRun {
    
    if (_time <= 0) {
        [self.timer invalidate];
        self.timer = nil;
        _time = 0;
    } else {
        _time --;
    }
    
    [self setViewWith:_time];
}

- (void)setViewWith:(NSTimeInterval)time {
    
    NSInteger hour = time/3600.0;
    NSInteger min  = (time - hour*3600)/60;
    NSInteger sec  = time - hour*3600 - min*60;
    
    self.YTHourLabel.text   = [NSString stringWithFormat:@"%02tu",hour];
    self.YTMinLabel.text = [NSString stringWithFormat:@"%02tu",min];
    self.YTSecLabel.text = [NSString stringWithFormat:@"%02tu",sec];
    
    self.YTHourLabel.layer.cornerRadius  = 2;
    self.YTHourLabel.layer.masksToBounds = YES;
    
    self.YTMinLabel.layer.cornerRadius  = 2;
    self.YTMinLabel.layer.masksToBounds = YES;
    
    self.YTSecLabel.layer.cornerRadius  = 2;
    self.YTSecLabel.layer.masksToBounds = YES;
    
    
    if ([self.YTHourLabel.text isEqualToString:@"00"] && [self.YTMinLabel.text isEqualToString:@"00"] && [self.YTSecLabel.text isEqualToString:@"00"]) {
        
        
//        if ([self.BoolString isEqualToString:@"1"]) {
//            
//            [_dataSource1 removeAllObjects];
//            
//            [self getDatas2];
//            
//        }else{
//            
//            [_dataSource2 removeAllObjects];
//            
//            page=0;
//            
//            [self getDatas1];
//        }
    }
    
    
//    NSLog(@"====%ld===%ld===%ld==",hour,min,sec);
    
    
}


@end
