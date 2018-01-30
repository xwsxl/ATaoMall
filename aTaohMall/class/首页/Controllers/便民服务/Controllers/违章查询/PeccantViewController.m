//
//  PeccantViewController.m
//  aTaohMall
//
//  Created by JMSHT on 2017/5/11.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "PeccantViewController.h"
#import "ATHBreakRulesViewController.h"//违章交费
#import "ATHBreakRulesUpImgViewController.h"

#import "NewPagedFlowView.h"
#import "PGIndexBannerSubiew.h"
#import "AddCarVC.h"
#import "PeccancecyInfoCell.h"
#import "CarInfoModel.h"
#import "PeccancecyInfoModel.h"
#import "ServiceVC.h"
#import "DJRefresh.h"
@interface PeccantViewController ()<NewPagedFlowViewDelegate,NewPagedFlowViewDataSource,UITableViewDelegate,UITableViewDataSource,AddCarRefreshDelegate,DJRefreshDelegate>{
    
    UITableView *pecTableView;
    UIView *NoPeccView;
    UIView *NoCarView;
    NSArray *peccArr;
    UIButton *payBut;
    NSMutableArray *refreshArray;
    NSTimer *timer;
    UIWebView *webView;
    UIView *loadView;
}
@property(nonatomic,strong)NewPagedFlowView *pageFlowView;
@property(nonatomic,strong)NSMutableArray *CarDataListArr;
@property (nonatomic,strong)DJRefresh *refresh;

@end

@implementation PeccantViewController
/*******************************************************      控制器生命周期       ******************************************************/
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getDatas];
    [self initNav];
    [self setupUI];
    
    
}
/*****
 *
 *  Description 在视图消失的时候关闭定时器，在视图出现的时候开启定时器
 *
 ******/
-(void)viewWillAppear:(BOOL)animated
{
    if (timer) {
        [timer setFireDate:[NSDate distantPast]];//开启
    }
}
-(void)viewWillDisappear:(BOOL)animated
{
    
    if (timer) {
        [timer setFireDate:[NSDate distantFuture]];//关闭
    }
}

/*******************************************************      获取数据       ******************************************************/
/*****
 *
 *  Description 获取车辆数据
 *
 ******/
-(void)getDatas
{
    
    
    NSDictionary *param=@{@"sigen":[[NSUserDefaults standardUserDefaults] stringForKey:@"sigen"]};
    [ATHRequestManager requestForCarDataWithParams:param successBlock:^(NSDictionary *responseObj) {
        [self.CarDataListArr removeAllObjects];
        if ([responseObj[@"status"] isEqualToString:@"10001"]) {//返回10001表示尚未添加车辆
            //显示没有添加车辆视图
            pecTableView.hidden=YES;
            payBut.hidden=YES;
            NoPeccView.hidden=YES;
            NoCarView.hidden=NO;
            
        }else if([responseObj[@"status"] isEqualToString:@"10000"])
        {
            
            NSMutableArray *tempArr=responseObj[@"list_head"];
            //初始化定时器和刷新次数数组
            if (!refreshArray) {
                refreshArray=[[NSMutableArray alloc]init];
            }
            [refreshArray removeAllObjects];
            if (timer) {
                [timer invalidate];
                timer=nil;
            }
            
            for (NSDictionary *carDic in tempArr) {
                CarInfoModel *model=[[CarInfoModel alloc]init];
                
                model.carID=carDic[@"id"];
                model.PlateNumberStr=[NSString stringWithFormat:@"%@",carDic[@"carNo"]];
                model.RemarkNameStr=[NSString stringWithFormat:@"%@",carDic[@"remark_name"]];
                model.PendingPeccancecyStr=[NSString stringWithFormat:@"%@",carDic[@"wait_deal_with"]];
                model.TotalDeductMarkStr=[NSString stringWithFormat:@"%@",carDic[@"deduct_score"]];
                model.TotalFineStr=[NSString stringWithFormat:@"%@",carDic[@"fine_money"]];
                model.UpdateTimeStr=[NSString stringWithFormat:@"%@",carDic[@"update_date"]];
                model.FrameNumberStr=[NSString stringWithFormat:@"%@",carDic[@"frameNo"]];
                model.EngineNumberStr=[NSString stringWithFormat:@"%@",carDic[@"enginNo"]];
                
                model.CityListArr=[[[NSString stringWithFormat:@"%@",carDic[@"city_name"]] componentsSeparatedByString:@","] mutableCopy];
                [self.CarDataListArr addObject:model];
            }
            //初始化刷新次数数组、当数组长度大于0的时候开启定时器
            for (int i=0; i<_CarDataListArr.count; i++) {
                [refreshArray addObject:@"0"];
            }
            if (refreshArray.count>0) {
                if(!timer){
                    timer=[NSTimer scheduledTimerWithTimeInterval:60 repeats:YES block:^(NSTimer * _Nonnull timer) {
                        [refreshArray removeAllObjects];
                        for (int i=0; i<_CarDataListArr.count; i++) {
                            [refreshArray addObject:@"0"];
                        }
                    }];
                }
                [timer setFireDate:[NSDate distantPast]];
            }
            
        }
        else{
            [TrainToast showWithText:[NSString stringWithFormat:@"%@",responseObj[@"message"]] duration:1.0];
        }
        //重新加载数据需要刷新轮播图
        [self.pageFlowView reloadData];
        [webView removeFromSuperview];
        [loadView removeFromSuperview];
        
        if (_CarDataListArr.count>0) {
            [self getCarPeccDataWithPage:0];
        }

    } faildBlock:^(NSError *error) {
        [TrainToast showWithText:[error localizedDescription] duration:1.0];
    }];    
    
    
}

/*****
 *
 *  Description 根据车辆号码获取违章数据
 *
 ******/
-(void)getCarPeccDataWithPage:(NSInteger)index
{
    
    NoCarView.hidden=YES;
    NoPeccView.hidden=YES;
    pecTableView.hidden=YES;
    payBut.hidden=YES;
/* 以下创建网络请求等待状态视图 */
    
    CGRect frame = CGRectMake(0, 65+60, 80, 80);
    frame.size = [UIImage imageNamed:@"ring-alt(1).gif"].size;
    // 读取gif图片数据
    NSData *gif = [NSData dataWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"ring-alt(1)" ofType:@"gif"]];
    // view生成
    webView = [[UIWebView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-frame.size.width)/2, ([UIScreen mainScreen].bounds.size.height-frame.size.height)/2, frame.size.width, frame.size.height)];
    
    webView.backgroundColor = [UIColor clearColor];
    [webView setOpaque:NO];
    webView.userInteractionEnabled = NO;//用户不可交互
    [webView loadData:gif MIMEType:@"image/gif" textEncodingName:nil baseURL:nil];
    [self.view addSubview:webView];
    
    loadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    loadView.backgroundColor = [UIColor blackColor];
    
    loadView.alpha = 0.2;
    
    [self.view addSubview:loadView];
/* 以上创建网络请求等待状态视图 */
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@getIllegalRecord_mob.shtml",URL_Str];
    //saveUserExchange_mob.shtml
    CarInfoModel *model1=[_CarDataListArr objectAtIndex:index];
    NSDictionary *param=@{@"sigen":[[NSUserDefaults standardUserDefaults] stringForKey:@"sigen"],@"carNo":model1.PlateNumberStr};
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [ATHRequestManager requestForCarPeccDataWithParams:param successBlock:^(NSDictionary *responseObj) {
            if ([responseObj[@"status"] isEqualToString:@"10000"]) {
                [self performSelector:@selector(delayMethod) withObject:nil afterDelay:1.0f];
                model1.TotalDeductMarkStr=responseObj[@"deduct_score"];
                model1.TotalFineStr=responseObj[@"fine_money"];
                NSMutableArray *tempArr=responseObj[@"list_all1"];
                [model1.PendingPeccancecyArr removeAllObjects];
                for (NSDictionary *peccDic in tempArr) {
                    PeccancecyInfoModel *model=[[PeccancecyInfoModel alloc]init];
                    model.PeccancecyTimeStr=[NSString stringWithFormat:@"%@",peccDic[@"time"]];
                    model.PeccancecyFineStr=[NSString stringWithFormat:@"%@",peccDic[@"fine"]];
                    model.PeccancecyTypeStr=[NSString stringWithFormat:@"%@",peccDic[@"code"]];
                    model.PeccancecyPlaceStr=[NSString stringWithFormat:@"%@",peccDic[@"address"]];
                    model.PlateNumberStr=[NSString stringWithFormat:@"%@",peccDic[@"carNo"]];
                    model.city=[NSString stringWithFormat:@"%@",peccDic[@"cityName"]];
                    model.behavior=[NSString stringWithFormat:@"%@",peccDic[@"behavior"]];
                    model.canHandle=[NSString stringWithFormat:@"%@",peccDic[@"canHandle"]];
                    model.serviceFee=[NSString stringWithFormat:@"%@",peccDic[@"serviceFee"]];
                    model.deductPointType=[NSString stringWithFormat:@"%@",peccDic[@"deductPointType"]];
                    model.PeccancecyDecuteMarksStr=[NSString stringWithFormat:@"%@",peccDic[@"deductPoint"]];
                    model.zhiNaJin=[NSString stringWithFormat:@"%@",peccDic[@"zhinajin"]];
                    model.note=[NSString stringWithFormat:@"%@",peccDic[@"note"]];
                    model.type=[NSString stringWithFormat:@"%@",peccDic[@"type"]];
                    model.peccID=[NSString stringWithFormat:@"%@",peccDic[@"recordId"]];
                    [model1.PendingPeccancecyArr addObject:model];
                }
                CarInfoModel *carModel=_CarDataListArr[index];
                carModel.TotalDeductMarkStr=[NSString stringWithFormat:@"%@",responseObj[@"deduct_score"]];
                carModel.PendingPeccancecyStr=[NSString stringWithFormat:@"%@",responseObj[@"wait_deal_with"]];
                carModel.UpdateTimeStr=[NSString stringWithFormat:@"%@",responseObj[@"update_date"]];
                carModel.TotalFineStr=[NSString stringWithFormat:@"%@",responseObj[@"fine_money"]];
                
                PGIndexBannerSubiew *bannerView=[_pageFlowView.cells objectAtIndex:index];
                bannerView.pendingPeccantLab.text=[NSString stringWithFormat:@"待处理 %@",carModel.PendingPeccancecyStr];
                
                bannerView.deductMarkLab.text=[NSString stringWithFormat:@"扣分 %@",carModel.TotalDeductMarkStr];
                bannerView.fineLab.text=[NSString stringWithFormat:@"罚款 %@",carModel.TotalFineStr];
                bannerView.updateTimeLab.text=[NSString stringWithFormat:@"更新时间:  %@",carModel.UpdateTimeStr];
                
                NoCarView.hidden=YES;
                NoPeccView.hidden=YES;
                pecTableView.hidden=NO;
                payBut.hidden=NO;
                dispatch_async(dispatch_get_main_queue(), ^{
                    peccArr=[model1.PendingPeccancecyArr copy];
                    [pecTableView reloadData];
                });
                [self performSelector:@selector(delayMethod) withObject:nil afterDelay:1.0];
                
            }
            else{
                
                CarInfoModel *carModel=_CarDataListArr[index];
                carModel.UpdateTimeStr=[NSString stringWithFormat:@"%@",responseObj[@"update_date"]];
                PGIndexBannerSubiew *bannerView=[_pageFlowView.cells objectAtIndex:index];
                bannerView.updateTimeLab.text=[NSString stringWithFormat:@"更新时间:  %@",carModel.UpdateTimeStr];
                NoCarView.hidden=YES;
                NoPeccView.hidden=NO;
                pecTableView.hidden=YES;
                payBut.hidden=YES;
                [self performSelector:@selector(delayMethod) withObject:nil afterDelay:0.5];
            }

        } faildBlock:^(NSError *error) {
            [self performSelector:@selector(delayMethod) withObject:nil afterDelay:0.5];
        }];
        
        
        
        
    });
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [manager POST:url parameters:param success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
//            NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
//            NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];
//            
//            if (codeKey && content) {
//                NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
//                xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
//                xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
//                
//                NSLog(@"xmlStr==%@",xmlStr);
//                
//                
//                NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];
//                
//                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//                //  NSLog(@"dic=%@",dic);
//                
//                if ([dic[@"status"] isEqualToString:@"10000"]) {
//                    [self performSelector:@selector(delayMethod) withObject:nil afterDelay:1.0f];
//                    model1.TotalDeductMarkStr=dic[@"deduct_score"];
//                    model1.TotalFineStr=dic[@"fine_money"];
//                    NSMutableArray *tempArr=dic[@"list_all1"];
//                    [model1.PendingPeccancecyArr removeAllObjects];
//                    for (NSDictionary *peccDic in tempArr) {
//                        PeccancecyInfoModel *model=[[PeccancecyInfoModel alloc]init];
//                        model.PeccancecyTimeStr=peccDic[@"time"];
//                        model.PeccancecyFineStr=peccDic[@"fine"];
//                        model.PeccancecyTypeStr=peccDic[@"code"];
//                        model.PeccancecyPlaceStr=peccDic[@"address"];
//                        model.PlateNumberStr=peccDic[@"carNo"];
//                        model.city=peccDic[@"cityName"];
//                        model.behavior=peccDic[@"behavior"];
//                        model.canHandle=peccDic[@"canHandle"];
//                        model.serviceFee=peccDic[@"serviceFee"];
//                        model.deductPointType=peccDic[@"deductPointType"];
//                        model.PeccancecyDecuteMarksStr=peccDic[@"deductPoint"];
//                        model.zhiNaJin=peccDic[@"zhinajin"];
//                        model.note=peccDic[@"note"];
//                        model.type=peccDic[@"type"];
//                        model.peccID=peccDic[@"recordId"];
//                        [model1.PendingPeccancecyArr addObject:model];
//                    }
//                    CarInfoModel *carModel=_CarDataListArr[index];
//                    carModel.TotalDeductMarkStr=[NSString stringWithFormat:@"%@",dic[@"deduct_score"]];
//                    carModel.PendingPeccancecyStr=[NSString stringWithFormat:@"%@",dic[@"wait_deal_with"]];
//                    carModel.UpdateTimeStr=[NSString stringWithFormat:@"%@",dic[@"update_date"]];
//                    carModel.TotalFineStr=[NSString stringWithFormat:@"%@",dic[@"fine_money"]];
//                    
//                    PGIndexBannerSubiew *bannerView=[_pageFlowView.cells objectAtIndex:index];
//                    bannerView.pendingPeccantLab.text=[NSString stringWithFormat:@"待处理 %@",carModel.PendingPeccancecyStr];
//                    
//                    bannerView.deductMarkLab.text=[NSString stringWithFormat:@"扣分 %@",carModel.TotalDeductMarkStr];
//                    bannerView.fineLab.text=[NSString stringWithFormat:@"罚款 %@",carModel.TotalFineStr];
//                    bannerView.updateTimeLab.text=[NSString stringWithFormat:@"更新时间:  %@",carModel.UpdateTimeStr];
//                    
//                    NoCarView.hidden=YES;
//                    NoPeccView.hidden=YES;
//                    pecTableView.hidden=NO;
//                    payBut.hidden=NO;
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                        peccArr=[model1.PendingPeccancecyArr copy];
//                        [pecTableView reloadData];
//                    });
//                   [self performSelector:@selector(delayMethod) withObject:nil afterDelay:1.0];
//                    
//                }
//                else{
//                    
//                    CarInfoModel *carModel=_CarDataListArr[index];
//                    carModel.UpdateTimeStr=[NSString stringWithFormat:@"%@",dic[@"update_date"]];
//                    PGIndexBannerSubiew *bannerView=[_pageFlowView.cells objectAtIndex:index];
//                    bannerView.updateTimeLab.text=[NSString stringWithFormat:@"更新时间:  %@",carModel.UpdateTimeStr];
//                    NoCarView.hidden=YES;
//                    NoPeccView.hidden=NO;
//                    pecTableView.hidden=YES;
//                    payBut.hidden=YES;
//                    [self performSelector:@selector(delayMethod) withObject:nil afterDelay:0.5];
//                }
//                
//            }
//            else
//            {
//                [self performSelector:@selector(delayMethod) withObject:nil afterDelay:0.5];
//            }
//            
//            
//            
//        } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
//            [self performSelector:@selector(delayMethod) withObject:nil afterDelay:0.5];
//            
//        }];
//        
//    });
    
    
}
/*****
 *
 *  Description 移除等待请求数据转圈圈的gif和遮罩层
 *
 ******/
-(void)delayMethod
{
    if (webView.superview!=nil) {
        [webView removeFromSuperview];
    }
    if (loadView.superview!=nil) {
        [loadView removeFromSuperview];
    }
}

/*******************************************************      初始化视图       ******************************************************/
/*****
 *
 *  Description 初始化轮播图
 *
 ******/
- (void)setupUI
{
   // [self.view setBackgroundColor:RGB(222, 222, 222)];
    
    NewPagedFlowView *pageFlowView = [[NewPagedFlowView alloc] initWithFrame:CGRectMake(0, 1, kScreen_Width, 180)];
    pageFlowView.backgroundColor = [UIColor whiteColor];
    pageFlowView.delegate = self;
    pageFlowView.dataSource = self;
    pageFlowView.minimumPageAlpha = 0.4;
    pageFlowView.orginPageCount = self.CarDataListArr.count;
    pageFlowView.isOpenAutoScroll = YES;
   
    //初始化pageControl
    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, pageFlowView.frame.size.height - 29, kScreen_Width, 8)];
    pageFlowView.pageControl = pageControl;
    pageFlowView.pageControl.hidden=YES;
    [pageFlowView addSubview:pageControl];
    
    //    [self.view addSubview:pageFlowView];
    
    /****************************
     使用导航控制器(UINavigationController)
     如果控制器中不存在UIScrollView或者继承自UIScrollView的UI控件
     请使用UIScrollView作为NewPagedFlowView的容器View,才会显示正常,如下
     *****************************/
    UIScrollView *bottomScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight, kScreen_Width, 180)];
   // [pageFlowView reloadData];
    [bottomScrollView addSubview:pageFlowView];
    [self.view addSubview:bottomScrollView];
    
    [bottomScrollView addSubview:pageFlowView];

    self.pageFlowView = pageFlowView;
    
    [self setNoPeccView];
    [self setPecTableView];
    [self setNoCarView];
}
/*****
 *
 *  Description 初始化没有查询到违章的视图
 *
 ******/
-(void)setNoPeccView
{
    if (!NoPeccView) {
        NoPeccView=[[UIView alloc]initWithFrame:CGRectMake(0, 180+KSafeAreaTopNaviHeight, kScreen_Width, kScreen_Height-180-KSafeAreaTopNaviHeight)];
        
        UIImageView *IV=[[UIImageView alloc]initWithFrame:CGRectMake((kScreen_Width-60)/2,90, 60, 64)];
        IV.image=[UIImage imageNamed:@"icon_empty"];
        [NoPeccView addSubview:IV];
        
        UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(15, 169, kScreen_Width-30, 40)];
        lab.font=KNSFONT(16);
        lab.textColor=RGB(153, 153, 153);
        lab.numberOfLines=0;
        lab.textAlignment=NSTextAlignmentCenter;
        lab.text=@"未查询到违章或交管局还未录入相关违章。";
        [NoPeccView addSubview:lab];
        
        UIButton *but=[UIButton buttonWithType:UIButtonTypeCustom];
        but.frame=CGRectMake(0, kScreen_Height-180-64-84, kScreen_Width, 20);
        [but setTitleColor:RGB(63, 139, 253) forState:UIControlStateNormal];
        [but setTitle:@"确定有违章，但未查询到?" forState:UIControlStateNormal];
        [but addTarget:self action:@selector(GoServiceVC) forControlEvents:UIControlEventTouchUpInside];
        [NoPeccView addSubview:but];
        [self.view addSubview:NoPeccView];
    }
    NoPeccView.hidden=YES;
}

/*****
 *
 *  Description 初始化有违章时候的表视图
 *
 ******/
-(void)setPecTableView
{
    if (!pecTableView) {
        pecTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 180+KSafeAreaTopNaviHeight, kScreen_Width, kScreen_Height-KSafeAreaBottomHeight-180-50-KSafeAreaBottomHeight) style:UITableViewStylePlain];
        [pecTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        pecTableView.backgroundColor=RGB(244, 244, 244);
        pecTableView.delegate=self;
        pecTableView.dataSource=self;
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 5)];
        view.backgroundColor=RGB(244, 244, 244);
        payBut=[UIButton buttonWithType:UIButtonTypeCustom];
        payBut.frame=CGRectMake(0, kScreen_Height-50, kScreen_Width, 50);
        payBut.backgroundColor=RGB(253, 93, 94);
        [payBut setTitle:@"去缴费" forState:UIControlStateNormal];
        [payBut addTarget:self action:@selector(goToFineVC) forControlEvents:UIControlEventTouchUpInside];
        [payBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.view addSubview:payBut];
       // pecTableView.tableFooterView=view;
        [self.view addSubview:pecTableView];
    }
    _refresh=[[DJRefresh alloc] initWithScrollView:pecTableView delegate:self];
    _refresh.topEnabled=YES;//下拉刷新
    _refresh.bottomEnabled=NO;//上拉加载
    payBut.hidden=YES;
    pecTableView.hidden=YES;
    
}
/*****
 *
 *  Description 初始化没有添加车时的视图
 *
 ******/
-(void)setNoCarView
{
    
    if (!NoCarView) {
        NoCarView=[[UIView alloc]initWithFrame:CGRectMake(0, 180+KSafeAreaTopNaviHeight, kScreen_Width, kScreen_Height-180-KSafeAreaTopNaviHeight)];
        
        UIImageView *IV=[[UIImageView alloc]initWithFrame:CGRectMake((kScreen_Width-42)/2,90, 42, 53)];
        IV.image=[UIImage imageNamed:@"icon_news"];
        [NoCarView addSubview:IV];
        
        UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(15, 154, kScreen_Width-30, 50)];
        
        lab.font=KNSFONT(16);
        lab.textColor=RGB(153, 153, 153);
        lab.textAlignment=NSTextAlignmentCenter;
        lab.text=@"请根据《机动车行驶证》\n添加相关信息,开启违章查询";
        lab.textAlignment=NSTextAlignmentCenter;
        lab.numberOfLines=0;
        [NoCarView addSubview:lab];
        
        UIButton *but=[UIButton buttonWithType:UIButtonTypeCustom];
        but.frame=CGRectMake(0, kScreen_Height-180-KSafeAreaTopNaviHeight-40-KSafeAreaBottomHeight, kScreen_Width, 40);
        but.backgroundColor=RGB(253, 93, 94);
        [but setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [but setTitle:@"立即添加" forState:UIControlStateNormal];
        [but addTarget:self action:@selector(AddCarClick:) forControlEvents:UIControlEventTouchUpInside];
        [NoCarView addSubview:but];
        [self.view addSubview:NoCarView];
    }
    NoCarView.hidden=YES;
    
}
/*****
 *
 *  Description 导航栏创建
 *
 ******/
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
    
    Qurt.frame = CGRectMake(10, 25+KSafeTopHeight, 30, 30);
    
    //    [Qurt setBackgroundImage:[UIImage imageNamed:@"iconfont-fanhui2yt"] forState:0];
    
    [Qurt setImage:[UIImage imageNamed:@"iconfont-fanhui2yt"] forState:0];
    
    [Qurt addTarget:self action:@selector(QurtBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [titleView addSubview:Qurt];
    
    //创建搜索
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 25+KSafeTopHeight, [UIScreen mainScreen].bounds.size.width-200, 30)];
    
    label.text = @"违章查询";
    
    label.textColor = [UIColor blackColor];
    
    label.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:19];
    
    label.textAlignment = NSTextAlignmentCenter;
    
    [titleView addSubview:label];
    //设置不自动调整导航栏布局和左滑退出手势不可用
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;

}
-(void)setcarInfoAndBottomView
{
    if (self.CarDataListArr.count==0) {
        pecTableView.hidden=YES;
        payBut.hidden=YES;
        NoPeccView.hidden=YES;
        NoCarView.hidden=NO;
    }
    else
    {
        CarInfoModel *model=[self.CarDataListArr objectAtIndex:_pageFlowView.currentPageIndex];
        if (model.PendingPeccancecyArr.count==0) {
            pecTableView.hidden=YES;
            payBut.hidden=YES;
            NoPeccView.hidden=NO;
            NoCarView.hidden=YES;
        }else
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                peccArr=[model.PendingPeccancecyArr copy];
                [pecTableView reloadData];
            });
            pecTableView.hidden=NO;
            payBut.hidden=NO;
            NoPeccView.hidden=YES;
            NoCarView.hidden=YES;
        }
    }
    [self performSelector:@selector(delayMethod) withObject:nil afterDelay:0.5];
}

-(void)QurtBtnClick
{
    
    [self.navigationController popViewControllerAnimated:YES];

}

/*******************************************************      跳转页面       ******************************************************/
//前往缴费
-(void)goToFineVC
{
    ATHBreakRulesViewController *VC=[[ATHBreakRulesViewController alloc]init];
    VC.dataArr=peccArr;
    [self.navigationController pushViewController:VC animated:NO];
}
//确定有违章没有查询到，点击前往服务说明页
-(void)GoServiceVC
{
    [self.navigationController pushViewController:[[ServiceVC alloc] init] animated:NO];
    
}
/*****
 *
 *  Description 添加车辆
 *
 ******/
-(void)AddCarClick:(id)sender
{
    //判断数组长度，大于等于6时不可再添加
    if (_CarDataListArr.count>=6) {
        [TrainToast showWithText:@"土豪,最多可添加6辆车" duration:2.0];
        return;
    }
    
    AddCarVC *vc=[[AddCarVC alloc]init];
    
    vc.delegate=self;
    [self.navigationController pushViewController:vc animated:NO];
}
/*****
 *
 *  Description 编辑车辆
 *
 ******/
-(void)editCar:(UIButton *)sender
{
    //获取车辆下标、也可以使用 [_pageFlowView currentPageIndex]获取
    int index=sender.tag%3000;
    
    AddCarVC *VC=[[AddCarVC alloc]init];
    VC.delegate=self;
    //根据下标获取车辆信息
    [VC setViewWithModel:[_CarDataListArr objectAtIndex:index]];
    [self.navigationController pushViewController:VC animated:NO];
    
}

/*******************************************************      协议的方法       ******************************************************/
#pragma mark-UITableViewDelegate,UITableViewDataSource-车辆违章表视图协议
//行数(违章数目)
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return peccArr.count;
}
//单元格内容(违章的内容)
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    PeccancecyInfoCell *cell=[[PeccancecyInfoCell alloc] init];
    PeccancecyInfoModel *model=peccArr[indexPath.row];
    cell.typeLab.text=model.behavior;
    
    cell.placeLab.text=model.PeccancecyPlaceStr;
    if (![model.city isEqualToString:@""]) {
        cell.placeLab.text=[NSString stringWithFormat:@"%@%@",model.city,model.PeccancecyPlaceStr];
    }
    
    cell.updateTimeLab.text=model.PeccancecyTimeStr;
    cell.markAndFineLab.text=[NSString stringWithFormat:@"扣%@分  罚%@元",model.PeccancecyDecuteMarksStr,model.PeccancecyFineStr];
    cell.markAndFineLab.textColor = [UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
    NSString *ShiFuPriceForColor = @"分  罚";
    // 创建对象.
    NSMutableAttributedString *mAttStri1 = [[NSMutableAttributedString alloc] initWithString:cell.markAndFineLab.text];
    //
    NSRange range1 = [cell.markAndFineLab.text rangeOfString:ShiFuPriceForColor];
    NSRange range3 = NSMakeRange(0, 1);
    NSRange range4=NSMakeRange(cell.markAndFineLab.text.length-1, 1);
    [mAttStri1 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0] range:range1];
    [mAttStri1 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0] range:range3];
    [mAttStri1 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0] range:range4];
    cell.markAndFineLab.attributedText=mAttStri1;
    
    [cell changeFrame];
    [cell setStatesWithCanHandle:model.canHandle andType:model.type];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}
//分区头高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[UIView alloc]init];
}
//分区尾高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [[UIView alloc]init];
}
//单元格高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 145;
}

#pragma mark-NewPagedFlowViewDelegate,NewPagedFlowViewDataSource-车辆轮播图协议
//设置选中某一辆车
-(void)didSelectCell:(UIView *)subView withSubViewIndex:(NSInteger)subIndex
{
  //  ATHBreakRulesUpImgViewController *VC=[[ATHBreakRulesUpImgViewController alloc]init];
    if (subIndex==(_pageFlowView.cells.count-1)) {
        return;
    }
    
    AddCarVC *VC=[[AddCarVC alloc]init];
    VC.delegate=self;
    //根据下标获取车辆信息
    [VC setViewWithModel:[_CarDataListArr objectAtIndex:subIndex]];
    [self.navigationController pushViewController:VC animated:NO];
    NSLog(@"TestViewController 选择了第%ld页",subIndex);
}
//设置分页数(车辆数目)
-(NSInteger)numberOfPagesInFlowView:(NewPagedFlowView *)flowView
{
    return self.CarDataListArr.count+1;
}
//设置单页的内容(车辆数据)
-(UIView *)flowView:(NewPagedFlowView *)flowView cellForPageAtIndex:(NSInteger)index
{
    
    PGIndexBannerSubiew *BannerView=[[PGIndexBannerSubiew alloc]initWithFrame:CGRectMake(0,10, kScreen_Width-80, 160)];
    BannerView.layer.cornerRadius=4;
    BannerView.layer.masksToBounds=YES;
    if (self.CarDataListArr.count==0) {
        _pageFlowView.pageControl.hidden=YES;
    }
    if (index==(self.CarDataListArr.count+1-1)) {
        [BannerView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        UIImageView *IV=[[UIImageView alloc]initWithFrame:BannerView.bounds];
       // [IV setContentMode:UIViewContentModeScaleAspectFill];
        IV.image=[UIImage imageNamed:@"icon_car"];
        [BannerView addSubview:IV];
        
        UIButton *addBut=[UIButton buttonWithType:UIButtonTypeCustom];
        addBut.frame=CGRectMake((BannerView.bounds.size.width-33)/2, (160-33)/2, 33, 33);
        [addBut setBackgroundImage:[UIImage imageNamed:@"btn_add"] forState:UIControlStateNormal];
        [addBut addTarget:self action:@selector(AddCarClick:) forControlEvents:UIControlEventTouchUpInside];
        [BannerView addSubview:addBut];
        
        UILabel *addLab=[[UILabel alloc]initWithFrame:CGRectMake(0, (160-33)/2+43, BannerView.bounds.size.width, 20)];
        addLab.font=KNSFONT(16);
        addLab.textColor=[UIColor whiteColor];
        addLab.text=@"请添加你的爱车";
        addLab.textAlignment=NSTextAlignmentCenter;
        [BannerView addSubview:addLab];
        
        // BannerView.backgroundColor=RandomColor;
    }
    else
    {
        CarInfoModel *model=[_CarDataListArr objectAtIndex:index];
        BannerView.pendingPeccantLab.text=[NSString stringWithFormat:@"待处理 %@",model.PendingPeccancecyStr];
        BannerView.plateNumLab.text=model.PlateNumberStr;
        
        [BannerView.plateNumLab KSetLabelText:model.PlateNumberStr withFont:KNSFONT(16) MaxSize:CGSizeMake(200, 200)];
        
        BannerView.deductMarkLab.text=[NSString stringWithFormat:@"扣分 %@",model.TotalDeductMarkStr];
        BannerView.fineLab.text=[NSString stringWithFormat:@"罚款 %@",model.TotalFineStr];
        BannerView.editBut.tag=3000+index;
        CGSize size=[model.RemarkNameStr sizeWithFont:KNSFONT(15) maxSize:CGSizeMake(120, 15) ];
        BannerView.remarkLab.frame=CGRectMake(148, 28, size.width+6,size.height);
        BannerView.remarkLab.text=model.RemarkNameStr;
        if (![BannerView.remarkLab.text isEqualToString:@""]) {
            BannerView.remarkLab.layer.borderWidth=1;
            BannerView.remarkLab.layer.cornerRadius=2;
        }
        
        BannerView.remarkLab.layer.borderColor=[[UIColor whiteColor] CGColor];
        [BannerView.editBut addTarget:self action:@selector(editCar:) forControlEvents:UIControlEventTouchUpInside];
        BannerView.tag=5000+index;
    }
    
    return BannerView;
}
//设置每一页的尺寸
-(CGSize)sizeForPageInFlowView:(NewPagedFlowView *)flowView
{
    return CGSizeMake(kScreen_Width-80, 160);
}
//滚动到某一页执行的方法
-(void)didScrollToPage:(NSInteger)pageNumber inFlowView:(NewPagedFlowView *)flowView
{
    
    if (_CarDataListArr.count>pageNumber) {
        [self getCarPeccDataWithPage:pageNumber];
    }
    else
    {
        NoCarView.hidden=NO;
        NoPeccView.hidden=YES;
        pecTableView.hidden=YES;
        payBut.hidden=YES;
    }
}

#pragma mark-AddCarRefreshDelegate-编辑车辆和删除车辆返回时候刷新数据
-(void)refreshData
{
    [self getDatas];
}

#pragma mark-DJRefreshDelegate-表视图下拉刷新数据
- (void)refresh:(DJRefresh *)refresh didEngageRefreshDirection:(DJRefreshDirection) direction
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [refreshArray replaceObjectAtIndex:[_pageFlowView currentPageIndex] withObject: [NSString stringWithFormat:@"%ld", (long)[[refreshArray objectAtIndex:[_pageFlowView currentPageIndex]] integerValue]+1]];
        if ([[refreshArray objectAtIndex:[_pageFlowView currentPageIndex]] integerValue]>6) {
            [_refresh finishRefreshingDirection:direction animation:YES];
            [TrainToast showWithText:@"刷新过于频繁，请稍后再试。" duration:1.0];
        }else
        {
        if (direction==DJRefreshDirectionTop) {
            
            [self getCarPeccDataWithPage:[_pageFlowView currentPageIndex]];
        }
        [_refresh finishRefreshingDirection:direction animation:YES];
        }
    });
}

/*******************************************************      懒加载       ******************************************************/
/*****
 *
 *  Description 懒加载轮播图数据数组
 *
 ******/
-(NSMutableArray *)CarDataListArr
{
    if (!_CarDataListArr) {
        // _CarDataListArr=[@[@"1",@"2",@"3"] mutableCopy];
        _CarDataListArr=[[NSMutableArray alloc]init];
    }
    return _CarDataListArr;
}
@end
