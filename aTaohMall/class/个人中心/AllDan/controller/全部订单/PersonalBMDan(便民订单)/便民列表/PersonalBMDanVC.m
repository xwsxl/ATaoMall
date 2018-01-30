//
//  PersonalBMDanVC.m
//  aTaohMall
//
//  Created by DingDing on 2017/11/3.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "PersonalBMDanVC.h"
#import "PersonalBMDetailVC.h"
//店铺
#import "BMNewGameAndPhoneViewController.h"
#import "BMPlaneAndTrainViewController.h"
#import "PeccantViewController.h"
//退款
#import "TrainToReturnMoneyViewController.h"
#import "AirApplyRefundVC.h"

#import "PersonalBMDanCell.h"

#import "BianMinModel.h"

#import "BMDanModel.h"

@interface PersonalBMDanVC ()<UITableViewDelegate,UITableViewDataSource,PersonalBMDanCellDelegate,PersonalBMDetailVCDelegate>
{
    UIScrollView *topView;//顶部筛选视图
    UIView  *_slider;//标识红线
    NSInteger selectIndex;//标识下标
    UITableView *_tableView;

    NSInteger totalCount;//订单总条数
    BMDanModel *SelectModel;
}
@property (nonatomic,strong)NSMutableArray *dataSource;
@property (nonatomic,strong)NSArray *statusArray;
@property (nonatomic,strong)UISwipeGestureRecognizer *leftSwipeGesture;
@property (nonatomic,strong)UISwipeGestureRecognizer *rightSwipeGesture;
@property (nonatomic,strong)XLNoDataView *noDataView;
@property (nonatomic,assign)NSInteger page;
@end

@implementation PersonalBMDanVC
/*******************************************************      控制器生命周期       ******************************************************/
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
   // [self getDatasWithParams:nil];
  //  [self getNumdatas];
     [KNotificationCenter addObserver:self selector:@selector(BMListReloadData:) name:JMSHTBMLISTReloadData object:nil];
}

-(void)setUI
{
    [self initTopView];
    [self InitGesture];
    [self createTableView];
}
/*******************************************************      数据请求       ******************************************************/
//上拉加载更多
-(void)loadMoreData
{
    YLog(@"%ld,%ld",totalCount,_dataSource.count);

    if (totalCount==_dataSource.count) {
        [_tableView.mj_footer endRefreshingWithNoMoreData];
    }else
    {
        NSDictionary *params=@{@"sigen":[kUserDefaults objectForKey:@"sigen"],@"page":[NSString stringWithFormat:@"%ld",self.page],@"status":self.statusArray[selectIndex]};
        [self getDatasWithParams:params];
    }
}
//下拉刷新数据
-(void)refreshData
{
    self.page=0;
    NSDictionary *params=@{@"sigen":[kUserDefaults objectForKey:@"sigen"],@"page":[NSString stringWithFormat:@"%ld",self.page],@"status":self.statusArray[selectIndex]};
    [self getDatasWithParams:params];
}
//加载数据
-(void)getDatasWithParams:(NSDictionary *)params
{
    if (!params) {
        //sigen值为获取用户id page表示分页、status表示状态、空:全部订单，7:代付款订单，0:待发货订单,1:待收货订单,2:交易完成订单
        params=@{@"sigen":[kUserDefaults objectForKey:@"sigen"],@"page":[NSString stringWithFormat:@"%ld",self.page],@"status":@""};
    }

    WKProgressHUD *hud=[WKProgressHUD showInView:[UIApplication sharedApplication].keyWindow withText:nil animated:YES];
    [self.view removeGestureRecognizer:self.leftSwipeGesture];
    [self.view removeGestureRecognizer:self.rightSwipeGesture];
    [ATHRequestManager requestforgetOrderListByBMWithParams:params successBlock:^(NSDictionary *responseObj) {
        if ([responseObj[@"status"] isEqualToString:@"10000"]) {

            if ([params[@"page"] isEqualToString:@"0"]) {
                [self.dataSource removeAllObjects];
                 _tableView.contentOffset=CGPointZero;
            }

            self.page++;
            NSArray *tempArr=responseObj[@"resList"];
            totalCount=[responseObj[@"total_count"] integerValue];
            [NSObject printPropertyWithDict:responseObj];
            for (NSDictionary *orderDic in tempArr) {
                BMDanModel *model=[[BMDanModel alloc] init];
                model.airport_flight = [NSString stringWithFormat:@"%@",orderDic[@"airport_flight"]];
                model.airport_name =[NSString stringWithFormat:@"%@",orderDic[@"airport_name"]];
                model.getdate = [NSString stringWithFormat:@"%@",orderDic[@"getdate"]];
                model.ID = [NSString stringWithFormat:@"%@",orderDic[@"id"]];
                model.name = [NSString stringWithFormat:@"%@",orderDic[@"name"]];
                model.number =[NSString stringWithFormat:@"%@",orderDic[@"number"]];
                model.order_type = [NSString stringWithFormat:@"%@",orderDic[@"order_type"]];
                model.orderno = [NSString stringWithFormat:@"%@",orderDic[@"orderno"]];
                model.pay_integral = [NSString stringWithFormat:@"%@",orderDic[@"pay_integral"]];
                model.pay_money =[NSString stringWithFormat:@"%@",orderDic[@"pay_money"]];
                model.pay_order = [NSString stringWithFormat:@"%@",orderDic[@"pay_order"]];
                model.pay_status =[NSString stringWithFormat:@"%@",orderDic[@"pay_status"]];
                model.payintegral = [NSString stringWithFormat:@"%@",orderDic[@"payintegral"]];
                model.paymoney = [NSString stringWithFormat:@"%@",orderDic[@"paymoney"]];
                model.phone = [NSString stringWithFormat:@"%@",orderDic[@"phone"]];
                model.remark = [NSString stringWithFormat:@"%@",orderDic[@"remark"]];
                model.scopeimg = [NSString stringWithFormat:@"%@",orderDic[@"scopeimg"]];
                model.service_charge = [NSString stringWithFormat:@"%@",orderDic[@"service_charge"]];
                model.start_time = [NSString stringWithFormat:@"%@",orderDic[@"start_time"]];
                model.state =[NSString stringWithFormat:@"%@",orderDic[@"state"]];
                model.status = [NSString stringWithFormat:@"%@",orderDic[@"status"]];
                model.storename = [NSString stringWithFormat:@"%@",orderDic[@"storename"]];
                model.che_type = [NSString stringWithFormat:@"%@",orderDic[@"che_type"]];
                model.checi = [NSString stringWithFormat:@"%@",orderDic[@"checi"]];
                model.CarNo = [NSString stringWithFormat:@"%@",orderDic[@"carNo"]];
                model.total_deductPoint = [NSString stringWithFormat:@"%@",orderDic[@"total_deductPoint"]];
                model.uid = [NSString stringWithFormat:@"%@",orderDic[@"uid"]];
                model.total_fine = [NSString stringWithFormat:@"%@",orderDic[@"total_fine"]];
                model.is_refund=[NSString stringWithFormat:@"%@",orderDic[@"is_refund"]];
                [_dataSource addObject:model];
            }
            if (_dataSource.count==0) {
                [self.view addSubview:self.noDataView];
            }else
            {
                [_noDataView removeFromSuperview];
            }
            [_tableView reloadData];
        }
        [_tableView.mj_footer endRefreshing];
        [_tableView.mj_header endRefreshing];
        [self.view addGestureRecognizer:self.leftSwipeGesture];
        [self.view addGestureRecognizer:self.rightSwipeGesture];
        [hud dismiss:YES];

    } faildBlock:^(NSError *error) {
        [_tableView.mj_footer endRefreshing];
        [_tableView.mj_header endRefreshing];
        [self.view addGestureRecognizer:self.leftSwipeGesture];
        [self.view addGestureRecognizer:self.rightSwipeGesture];
        [hud dismiss:YES];
    }];
    [self getNumdatas];
}
//待处理
-(void)getNumdatas
{
    [ATHRequestManager requestforgetOrderCountWithParams:@{@"sigen":[kUserDefaults objectForKey:@"sigen"]} successBlock:^(NSDictionary *responseObj) {
        NSMutableArray *numArr=[[NSMutableArray alloc] init];
        if ([responseObj[@"status"] isEqualToString:@"10000"]) {
            [numArr addObject:[NSString stringWithFormat:@"%@",responseObj[@"Pending_Payment"]]];
            [numArr addObject:[NSString stringWithFormat:@"%@",responseObj[@"Processing"]]];
            [numArr addObject:[NSString stringWithFormat:@"%@",responseObj[@"Refunding"]]];
            for (int i=1; i<4; i++) {
                UIButton *but=[self.view viewWithTag:300+i];
                if ([numArr[i-1] containsString:@"null"]||([numArr[i-1] integerValue]==0)) {
                    but.badgeValue=nil;
                }else
                {
                    but.badgeValue=numArr[i-1];
                }
            }
        }
    } faildBlock:^(NSError *error) {

    }];
}
/*******************************************************      初始化视图       ******************************************************/

//初始化表视图
-(void)createTableView
{
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 45, kScreen_Width, kScreen_Height-45-65) style:UITableViewStyleGrouped];
    NSLogRect(self.view.frame);
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;
    [_tableView registerClass:[PersonalBMDanCell class] forCellReuseIdentifier:@"cell"];

    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
   // [footer setBackgroundColor:[UIColor whiteColor]];
    [footer setTitle:@"" forState:MJRefreshStateIdle];
    [footer setTitle:@"正在加载..." forState:MJRefreshStateRefreshing];
    [footer setTitle:@"没有更多数据" forState:MJRefreshStateNoMoreData];
    _tableView.mj_footer = footer;

    MJRefreshGifHeader *header=[MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    NSMutableArray *idleImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=60; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_anim__000%zd", i]];
        [idleImages addObject:image];
    }
    [header setImages:idleImages forState:MJRefreshStateIdle];

    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=3; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_loading_0%zd", i]];
        [refreshingImages addObject:image];
    }
    [header setImages:refreshingImages forState:MJRefreshStatePulling];

    // 设置正在刷新状态的动画图片
    [header setImages:refreshingImages forState:MJRefreshStateRefreshing];

    _tableView.mj_header=header;
    [self.view addSubview:_tableView];



}
//左滑右滑手势
-(void)InitGesture
{
    self.leftSwipeGesture=[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    self.rightSwipeGesture=[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    self.leftSwipeGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    self.rightSwipeGesture.direction = UISwipeGestureRecognizerDirectionRight;
}



//初始化顶部选择视图
-(void)initTopView
{
    topView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 45)];
    topView.backgroundColor=[UIColor whiteColor];
    topView.showsHorizontalScrollIndicator=NO;
    [self.view addSubview:topView];

     NSArray *titles=@[@"全部",@"待付款",@"处理中",@"退款中",@"已退款",@"交易成功",@"交易关闭"];
    CGFloat Weight = [UIScreen mainScreen].bounds.size.width/5;
    topView.contentSize=CGSizeMake(Weight*7, 45);

    for (int i = 0; i < titles.count; i++) {

        UILabel *TopLabel = [[UILabel alloc] initWithFrame:CGRectMake(Weight*i, (45-20)/2, Weight, 20)];
        TopLabel.text = titles[i];
        TopLabel.textColor = [UIColor colorWithRed:48/255.0 green:47/255.0 blue:47/255.0 alpha:1.0];
        TopLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
        TopLabel.textAlignment = NSTextAlignmentCenter;
        TopLabel.tag = 100 + i;
        [topView addSubview:TopLabel];

        UIButton *numbut = [UIButton buttonWithType:UIButtonTypeCustom];
        numbut.frame = CGRectMake(Weight*i, (45-30)/2, Weight+15, 45);
        numbut.tag = 300+i;
        [topView addSubview:numbut];

        UIButton *topButon = [UIButton buttonWithType:UIButtonTypeCustom];
        topButon.frame = CGRectMake(Weight*i, 0, Weight, 45);
        topButon.tag = 200+i;
        [topButon addTarget:self action:@selector(topBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [topView addSubview:topButon];


    }

    CGSize textSize = [titles[0] boundingRectWithSize:CGSizeMake(Weight, 3) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont fontWithName:@"PingFang-SC-Regular" size:14]} context:nil].size;

    _slider = [[UIView alloc] init];
    _slider.frame = CGRectMake((Weight-textSize.width)/2, 45-3, textSize.width, 3);
    _slider.backgroundColor = [UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
    _slider.tag = 10001;
    [topView addSubview:_slider];

    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 44, Weight*7, 1)];

    line.image = [UIImage imageNamed:@"分割线-拷贝"];

    [topView addSubview:line];

}


/*******************************************************      各种button执行方法、页面间的跳转       ******************************************************/
//切换了顶部一个类型
-(void)topBtnClick:(UIButton *)sender
{
    [self selectedIndexType:sender.tag-200];
}
//手势触发事件
-(void)handleSwipe:(UISwipeGestureRecognizer *)sender
{
    if (sender.direction==UISwipeGestureRecognizerDirectionLeft) {
        [self selectedIndexType:++selectIndex];

    }else if (sender.direction==UISwipeGestureRecognizerDirectionRight)
    {

        [self selectedIndexType:--selectIndex];
    }

}


/*******************************************************      协议方法       ******************************************************/
#pragma mark-表视图协议
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PersonalBMDanCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    [cell loadDataWithModel:_dataSource[indexPath.section]];
    cell.delegate=self;
    return cell;

}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{

    return [[UIView alloc] init];
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{

    return [[UIView alloc] init];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BMDanModel *model=_dataSource[indexPath.section];
    YLog(@"%.2f,%@",model.cellHeight,model.ID);
    return [model getCellHeight];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{

    return 10;

}



-(void)PayCallBack:(NSNotification *)text
{
     [KNotificationCenter removeObserver:self name:JMSHTPayCallBack object:nil];
    if ([text.userInfo[@"resultStatus"] isEqualToString:@"9000"]) {
        PersonalBMDetailVC *VC=[[PersonalBMDetailVC alloc] initWithOrderBatchid:SelectModel.orderno AndOrderType:SelectModel.order_type];
        [self.navigationController pushViewController:VC animated:NO];
        if (selectIndex==0) {
            [self refreshData];
        }else
        {
            [self selectedIndexType:2];
        }


    }else if ([text.userInfo[@"resultStatus"] isEqualToString:@"8000"]){

        [TrainToast showWithText:@"正在处理中" duration:2.0f];


    }else if ([text.userInfo[@"resultStatus"] isEqualToString:@"4000"]){


        [TrainToast showWithText:@"订单支付失败" duration:2.0f];

    }else if ([text.userInfo[@"resultStatus"] isEqualToString:@"6001"]){


    }else if ([text.userInfo[@"resultStatus"] isEqualToString:@"6002"]){

        [TrainToast showWithText:@"网络连接出错" duration:2.0f];
    }

}
#pragma mark-cell协议
-(void)CheckMerchantDetailWithModel:(BMDanModel *)model
{
    if ([model.order_type isEqualToString:@"1"]) {

        BMNewGameAndPhoneViewController *vc = [[BMNewGameAndPhoneViewController alloc] init];

        vc.tag0 = 100;

        [self.navigationController pushViewController:vc animated:NO];


    }else if ([model.order_type isEqualToString:@"2"]){

        BMNewGameAndPhoneViewController *vc = [[BMNewGameAndPhoneViewController alloc] init];

        vc.tag1 = 101;

        [self.navigationController pushViewController:vc animated:NO];


    }else if ([model.order_type isEqualToString:@"3"]){

        BMNewGameAndPhoneViewController *vc = [[BMNewGameAndPhoneViewController alloc] init];

        vc.tag2 = 102;

        [self.navigationController pushViewController:vc animated:NO];

    }else if ([model.order_type isEqualToString:@"4"]){

        BMPlaneAndTrainViewController *vc = [[BMPlaneAndTrainViewController alloc] init];

        vc.tag0 = 100;

        [self.navigationController pushViewController:vc animated:NO];

    }else if([model.order_type isEqualToString:@"5"]){

        BMPlaneAndTrainViewController *vc = [[BMPlaneAndTrainViewController alloc] init];

        vc.tag1 = 101;

        [self.navigationController pushViewController:vc animated:NO];

    }else if([model.order_type isEqualToString:@"6"])
    {
        PeccantViewController *vc=[[PeccantViewController alloc]init];

        [self.navigationController pushViewController:vc animated:NO];

    }
    YLog(@"店铺");
    
}

-(void)CheckBMDanDetailWithModel:(BMDanModel *)model
{
    PersonalBMDetailVC *VC=[[PersonalBMDetailVC alloc] initWithOrderBatchid:model.orderno AndOrderType:model.order_type];
    VC.delegate=self;
    [self.navigationController pushViewController:VC animated:NO];
    YLog(@"详情");

}

-(void)ContinuePayWithModel:(BMDanModel *)model
{
    SelectModel=model;
    [KNotificationCenter addObserver:self selector:@selector(PayCallBack:) name:JMSHTPayCallBack object:nil];
    [[AliPayRequestTools shareAlipayTool] BMContinuePayWithOrderNum:model.orderno OnViewController:self AndResponseSuccess:^(NSDictionary *responseObj) {
        PersonalBMDetailVC *VC=[[PersonalBMDetailVC alloc] initWithOrderBatchid:SelectModel.orderno AndOrderType:SelectModel.order_type];
        [self.navigationController pushViewController:VC animated:NO];
        if (selectIndex==0) {
            [self refreshData];
        }else
        {
            [self selectedIndexType:2];
        }
        [KNotificationCenter removeObserver:self name:JMSHTPayCallBack object:nil];
    } failed:^(NSError *error) {
        [self refreshData];
        [KNotificationCenter removeObserver:self name:JMSHTPayCallBack object:nil];
    }];

    YLog(@"继续付款");
}

-(void)RefundMoneyWithModel:(BMDanModel *)model
{
    if([model.order_type isEqualToString:@"5"]){//火车票退款

        TrainToReturnMoneyViewController *vc = [[TrainToReturnMoneyViewController alloc] init];
        vc.ordrno = model.orderno;
        [self.navigationController pushViewController:vc animated:NO];
        self.navigationController.navigationBar.hidden = YES;

    }else if ([model.order_type isEqualToString:@"4"]){//飞机票退款

        AirApplyRefundVC *VC=[[AirApplyRefundVC alloc]init];
        VC.orderno=model.orderno;
        [self.navigationController pushViewController:VC animated:NO];

    }
    YLog(@"退款");

}

#pragma mark-详情协议
-(void)BMDetailSelectIndexType:(NSInteger)index
{
    [self selectedIndexType:index];
}

//
-(void)BMListReloadData:(NSNotification *)noti
{

    NSDictionary *param=noti.userInfo;


    [self selectedIndexType:[param[@"status"] integerValue]];

}
/*******************************************************      代码提取(多是复用代码)       ******************************************************/

-(void)selectedIndexType:(NSInteger )index
{
    //判断index的位置--主要是手势操作时用到
    if (index>6) {
        selectIndex=6;
        return;
    }else if(index<0)
    {
        selectIndex=0;
        return;
    }

    selectIndex=index;
    NSArray *titles=@[@"全部",@"代付款",@"处理中",@"退款中",@"已退款",@"交易成功",@"交易关闭"];
    CGFloat Weight = [UIScreen mainScreen].bounds.size.width/5;

    for (int i=0; i<titles.count; i++) {
        UILabel *lab=[self.view viewWithTag:100+i];
        if (selectIndex==i) {
            CGSize textSize = [titles[i] boundingRectWithSize:CGSizeMake(Weight, 3) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont fontWithName:@"PingFang-SC-Regular" size:14]} context:nil].size;

            UIView *slider = [self.view viewWithTag:10001];
            [UIView animateWithDuration:0.25 animations:^{
                slider.frame = CGRectMake((Weight-textSize.width)/2+Weight*selectIndex, 45-3, textSize.width, 3);
            } completion:nil];
            lab.textColor=RGB(255, 93, 94);
        }else
        {
            lab.textColor=RGB(51, 51, 51);
        }


    }

    //选中居中
    CGFloat scollWidth=0;
    scollWidth=(selectIndex-2)*Weight;
    if (scollWidth<0) {
        scollWidth=0;
    }
    else if (scollWidth>(topView.contentSize.width-kScreen_Width))
    {
        scollWidth=topView.contentSize.width-kScreen_Width;
    }
    [UIView animateWithDuration:0.2 animations:^{
         topView.contentOffset=CGPointMake(scollWidth, 0);
    }];

    //刷新数据
    self.page=0;
    NSDictionary *params=@{@"sigen":[kUserDefaults objectForKey:@"sigen"],@"page":[NSString stringWithFormat:@"%ld",self.page],@"status":self.statusArray[selectIndex]};
    [self getDatasWithParams:params];

}


-(NSArray *)statusArray
{
    if (!_statusArray) {
        _statusArray=@[@"",@"0",@"2",@"4",@"5",@"3",@"1"];
    }
    return _statusArray;
}

-(NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource=[NSMutableArray new];
    }
    return _dataSource;
}


-(XLNoDataView *)noDataView
{
    if (!_noDataView) {
        _noDataView=[[XLNoDataView alloc] initWithFrame:CGRectMake(0, 45, kScreen_Width, kScreen_Height-65-45)];
    }
    return _noDataView;
}

@end
