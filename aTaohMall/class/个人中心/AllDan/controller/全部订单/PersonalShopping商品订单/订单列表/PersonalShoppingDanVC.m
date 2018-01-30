//
//  PersonalShoppingDanVC.m
//  aTaohMall
//
//  Created by DingDing on 2017/11/3.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "PersonalShoppingDanVC.h"
//店铺
#import "MerchantDetailViewController.h"
//订单详情
#import "PersonalShoppingDanDetailVC.h"
//物流
#import "PersonalLogisticsDetailVC.h"
#import "PersonalTwoOrMoreLogisticsDetailVC.h"
//申请退款
#import "PersonalShoppingReplyRefundVC.h"
#import "PersonalShoppingRefundTypeVC.h"
#import "PersonalShoppingRefundDanDetailVC.h"
//协商记录
#import "ConsultNounVC.h"

#import "XLNoDataView.h"

#import "PersonalShoppingDanCell.h"
#import "PersonalShoppingSectionHeaderView.h"
#import "PersonalShoppingSectionFooterView.h"

#import "XLDingDanModel.h"
#import "XLShoppingModel.h"

#import "WKProgressHUD.h"
static NSString * const XLConstPersonalShoppingDanCell=@"PersonalShoppingDanCell";
static NSString * const XLConstPersonalShoppingSectionHeaderView=@"PersonalShoppingSectionHeaderView";
static NSString * const XLConstPersonalShoppingSectionFooterView=@"PersonalShoppingSectionFooterView";

@interface PersonalShoppingDanVC ()<UITableViewDelegate,UITableViewDataSource,PersonalShoppingSectionFooterViewDelegate,PersonalShoppingSectionHeaderViewDelegate,PersonalShoppingDanCellDelegat,PersonalShoppingDanDetailVCDelegate>
{

    UIView  *_slider;//标识红线
    NSInteger selectIndex;//标识下标
    UITableView *_tableView;//内容表视图

    NSInteger totalCount;//订单总条数

    XLDingDanModel *selectModel;
}

@property (nonatomic,strong)NSMutableArray *dataSource;
@property (nonatomic,strong)NSArray *statusArray;
@property (nonatomic,strong)UISwipeGestureRecognizer *leftSwipeGesture;
@property (nonatomic,strong)UISwipeGestureRecognizer *rightSwipeGesture;
@property (nonatomic,strong)XLNoDataView *noDataView;
@property (nonatomic,assign)NSInteger page;

@end



@implementation PersonalShoppingDanVC


/*******************************************************      控制器生命周期       ******************************************************/
//视图加载
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];



}
-(void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden=YES;
}
//初始化视图
-(void)setUI
{
    [self initTopView];
    [self createTableView];
    [self InitGesture];
}

/*******************************************************      数据请求       ******************************************************/
//上拉加载更多
-(void)loadMoreData
{
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
    [ATHRequestManager requestforGetShoppingListWithParams:params successBlock:^(NSDictionary *responseObj) {
        if ([responseObj[@"status"] isEqualToString:@"10000"]) {

            if ([params[@"page"] isEqualToString:@"0"]) {
                [self.dataSource removeAllObjects];

            }
            self.page++;
            NSArray *tempArr=responseObj[@"order_list"];
            totalCount=[responseObj[@"totalCount"] integerValue];
            for (NSDictionary *orderDic in tempArr) {
                XLDingDanModel *model=[XLDingDanModel new];
                [model goodsOrderListFromArray:orderDic[@"goods_order_list"]];
                model.logo=[NSString stringWithFormat:@"%@",orderDic[@"logo"]];
                model.mid=[NSString stringWithFormat:@"%@",orderDic[@"mid"]];
                model.order_batchid=[NSString stringWithFormat:@"%@",orderDic[@"order_batchid"]];
                model.storename=[NSString stringWithFormat:@"%@",orderDic[@"storename"]];
                model.total_freight=[NSString stringWithFormat:@"%@",orderDic[@"total_freight"]];
                model.total_integral=[NSString stringWithFormat:@"%@",orderDic[@"total_integral"]];
                model.total_money=[NSString stringWithFormat:@"%@",orderDic[@"total_money"]];
                model.total_number_goods=[NSString stringWithFormat:@"%@",orderDic[@"total_number_goods"]];
                model.total_status=[NSString stringWithFormat:@"%@",orderDic[@"total_status"]];
                [_dataSource addObject:model];
            }
            if (_dataSource.count==0) {
                [self.view addSubview:self.noDataView];
            }else
            {
                [_noDataView removeFromSuperview];
            }

            [_tableView reloadData];
        }else
        {
            [TrainToast showWithText:responseObj[@"message"] duration:2.0];
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

}
/*******************************************************      初始化视图       ******************************************************/
//初始化表视图
-(void)createTableView
{
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 45, kScreen_Width, kScreen_Height-45-KSafeAreaTopNaviHeight) style:UITableViewStyleGrouped];
    NSLogRect(self.view.frame);
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;

    [_tableView registerClass:[PersonalShoppingDanCell class] forCellReuseIdentifier:XLConstPersonalShoppingDanCell];

    [_tableView registerClass:[PersonalShoppingSectionHeaderView class] forHeaderFooterViewReuseIdentifier:XLConstPersonalShoppingSectionHeaderView];
    [_tableView registerClass:[PersonalShoppingSectionFooterView class] forHeaderFooterViewReuseIdentifier:XLConstPersonalShoppingSectionFooterView];

    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    [footer setTitle:@"" forState:MJRefreshStateIdle];
    [footer setTitle:@"正在加载..." forState:MJRefreshStateRefreshing];
    [footer setTitle:@"暂无更多数据" forState:MJRefreshStateNoMoreData];
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
//初始化顶部状态视图
-(void)initTopView
{
    UIView *TopView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 45)];
    TopView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:TopView];

    NSArray *titles = @[@"全部", @"待付款", @"待发货",@"待收货",@"交易完成"];

    CGFloat Weight = [UIScreen mainScreen].bounds.size.width/5;

    for (int i = 0; i < titles.count; i++) {

        UILabel *TopLabel = [[UILabel alloc] initWithFrame:CGRectMake(Weight*i, (45-20)/2, Weight, 20)];
        TopLabel.text = titles[i];
        TopLabel.textColor = [UIColor colorWithRed:48/255.0 green:47/255.0 blue:47/255.0 alpha:1.0];
        TopLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
        TopLabel.textAlignment = NSTextAlignmentCenter;
        TopLabel.tag = 100 + i;
        [TopView addSubview:TopLabel];

        UIButton *topButon = [UIButton buttonWithType:UIButtonTypeCustom];
        topButon.frame = CGRectMake(Weight*i, 0, Weight, 45);
        topButon.tag = 200+i;
        [topButon addTarget:self action:@selector(topBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [TopView addSubview:topButon];
    }

    CGSize textSize = [titles[0] boundingRectWithSize:CGSizeMake(Weight, 3) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont fontWithName:@"PingFang-SC-Regular" size:14]} context:nil].size;

    _slider = [[UIView alloc] init];
    _slider.frame = CGRectMake((Weight-textSize.width)/2, 45-3, textSize.width, 3);
    _slider.backgroundColor = [UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
    _slider.tag = 10001;
    [TopView addSubview:_slider];

    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 44, [UIScreen mainScreen].bounds.size.width, 1)];

    line.image = [UIImage imageNamed:@"分割线-拷贝"];

    [TopView addSubview:line];

}
//左滑右滑手势
-(void)InitGesture
{
    self.leftSwipeGesture=[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    self.rightSwipeGesture=[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    self.leftSwipeGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    self.rightSwipeGesture.direction = UISwipeGestureRecognizerDirectionRight;
}

/*******************************************************      各种button执行方法、页面间的跳转       ******************************************************/
//切换订单状态
-(void)topBtnClick:(UIButton *)sender
{

    [self selectedIndexType:sender.tag-200];

}
//店铺详情
-(void)clickStoreDetail:(UIButton *)sender
{
    XLDingDanModel *model=_dataSource[sender.tag-1000];

    MerchantDetailViewController *vc=[[MerchantDetailViewController alloc] init];
    vc.mid=model.mid;
    vc.BackString = @"333";

    [self.navigationController pushViewController:vc animated:NO];
    self.navigationController.navigationBar.hidden=YES;
    NSLog(@"点击了店铺==%@",model.storename);
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

-(void)PayCallBack:(NSNotification *)text
{
    [KNotificationCenter removeObserver:self name:JMSHTPayCallBack object:nil];
    if ([text.userInfo[@"resultStatus"] isEqualToString:@"9000"]) {

        PersonalShoppingDanDetailVC *VC=[[PersonalShoppingDanDetailVC alloc] init];
        VC.myDingDanModel=selectModel;
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

#pragma mark-表视图协议
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    XLDingDanModel *model=_dataSource[section];
    return model.goods_order_list.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XLDingDanModel *model=_dataSource[indexPath.section];
    XLShoppingModel *shopModel=model.goods_order_list[indexPath.row];
    shopModel.totalStatus=model.total_status;
    PersonalShoppingDanCell *cell=[tableView dequeueReusableCellWithIdentifier:XLConstPersonalShoppingDanCell forIndexPath:indexPath];
    [cell loadData:shopModel];
    cell.delegate=self;
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    PersonalShoppingSectionHeaderView *view=[tableView dequeueReusableHeaderFooterViewWithIdentifier:XLConstPersonalShoppingSectionHeaderView];
    XLDingDanModel *model=_dataSource[section];
    view.dataModel=model;
    view.delegate=self;
    return view;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    PersonalShoppingSectionFooterView *view=[tableView dequeueReusableHeaderFooterViewWithIdentifier:XLConstPersonalShoppingSectionFooterView];
    view.dataModel=_dataSource[section];
    view.delegate=self;
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XLDingDanModel *model=_dataSource[indexPath.section];
    //只有一个商品直接返回默认值

    XLShoppingModel *shopModel=model.goods_order_list[indexPath.row];
    return shopModel.cellHeight;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 14+Height(28);
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    XLDingDanModel *model=_dataSource[section];
    return model.sectionFootHeight;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    XLDingDanModel *model=_dataSource[indexPath.section];
    PersonalShoppingDanDetailVC *vc=[[PersonalShoppingDanDetailVC alloc] init];
    vc.myDingDanModel=model;
    vc.delegate=self;
    [self.navigationController pushViewController:vc animated:NO];

}

#pragma mark-脚视图协议
//退款、退款退货
-(void)refundMoneyWithModel:(XLDingDanModel *)model
{
    XLShoppingModel *shopmodel=model.goods_order_list.firstObject;

    [self refundSingleShoppingWithModel:shopmodel Cell:nil];
    YLog(@"退款");
}
//继续付款
-(void)continuePayWithModel:(XLDingDanModel *)model
{

    YLog(@"继续付款");
    selectModel=model;
    //app付款回调
    [KNotificationCenter addObserver:self selector:@selector(PayCallBack:) name:JMSHTPayCallBack object:nil];
    [[AliPayRequestTools shareAlipayTool] ContinuePayWithOrderNum:model.order_batchid OnViewController:self AndResponseSuccess:^(NSDictionary *responseObj) {


        if ([responseObj[@"resultStatus"] isEqualToString:@"9000"]) {
            PersonalShoppingDanDetailVC *VC=[[PersonalShoppingDanDetailVC alloc] init];
            VC.myDingDanModel=selectModel;
            [self.navigationController pushViewController:VC animated:NO];

            if (selectIndex==0) {
                [self refreshData];
            }else
            {
                [self selectedIndexType:2];
            }

        }
        [KNotificationCenter removeObserver:self name:JMSHTPayCallBack object:nil];
    } failed:^(NSError *error) {
        [self refreshData];
        [KNotificationCenter removeObserver:self name:JMSHTPayCallBack object:nil];
    }];
}
//查看物流
-(void)checkLogisticInfoWithModel:(XLDingDanModel *)mdoel
{
    NSDictionary *params=@{@"order_batchid":mdoel.order_batchid};
    //检查包裹个数判断去哪个页面
    WKProgressHUD *hud=[WKProgressHUD showInView:self.view withText:nil animated:YES];
    [ATHRequestManager requestforGetLogisticsNumberWithParams:params successBlock:^(NSDictionary *responseObj) {
        if ([responseObj[@"status"] isEqualToString:@"10000"]) {
            NSInteger logisticNum=[responseObj[@"total_count"] integerValue];
            //单个包裹
            if (logisticNum==1) {
                PersonalLogisticsDetailVC *VC=[[PersonalLogisticsDetailVC alloc] init];
                VC.model=mdoel;
                [self.navigationController pushViewController:VC animated:NO];

            }else
            {
                PersonalTwoOrMoreLogisticsDetailVC *VC=[[PersonalTwoOrMoreLogisticsDetailVC alloc] init];
                VC.model=mdoel;
                [self.navigationController pushViewController:VC animated:NO];
            }
        }else
        {
            [TrainToast showWithText:responseObj[@"message"] duration:2.0];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self refreshData];
            });
        }
        [hud dismiss:YES];
    } faildBlock:^(NSError *error) {
        [hud dismiss:YES];
    }];
    YLog(@"查看物流");
}
//确认收货
-(void)sureReceiveWithModel:(XLDingDanModel *)model
{
    NSDictionary *params=@{@"sigen":[kUserDefaults objectForKey:@"sigen"],@"order_batchid":model.order_batchid};
    //调查询接口是否可以确认收货
    [ATHRequestManager requestforCheckSureReceiveGoodsWithParams:params successBlock:^(NSDictionary *responseObj) {
        //10000为可以确认收货、有确定按钮
        if ([responseObj[@"status"] isEqualToString:@"10000"]) {
            [UIAlertTools showAlertWithTitle:@"" message:responseObj[@"message"]
                                 cancelTitle:@"取消" titleArray:@[] viewController:self confirm:^(NSInteger buttonTag) {
                                     //点击了确认收货调确认收货接口
                                     if (buttonTag==0) {

                                         [ATHRequestManager requestforSureReceiveGoodsWithParams:params successBlock:^(NSDictionary *responseObj) {
                                             if ([responseObj[@"status"] isEqualToString:@"10000"]) {

                                                 PersonalShoppingDanDetailVC *vc=[[PersonalShoppingDanDetailVC alloc] init];
                                                 vc.myDingDanModel=model;
                                                 [self.navigationController pushViewController:vc animated:NO];
                                                 if (selectIndex==3) {
                                                     [self selectedIndexType:4];
                                                 }else
                                                 {
                                                     [self refreshData];
                                                 }
                                             }
                                             else
                                             {
                                                 [UIAlertTools showAlertWithTitle:@"" message:responseObj[@"message"]
                                                                      cancelTitle:@"关闭" titleArray:nil viewController:self confirm:^(NSInteger buttonTag) {
                                                                          [self refreshData];
                                                                      }];
                                             }
                                         } faildBlock:^(NSError *error) {

                                         }];
                                     }
                                 }];
        }else
        {
            [UIAlertTools showAlertWithTitle:@"" message:responseObj[@"message"]
                                 cancelTitle:@"关闭" titleArray:nil viewController:self confirm:^(NSInteger buttonTag) {
                                     [self refreshData];
                                 }];
        }

    } faildBlock:^(NSError *error) {
        [TrainToast showWithText:error.localizedDescription duration:2.0];
    }];


}
//删除订单
-(void)deleteDingDanWithModel:(XLDingDanModel *)model
{

    [UIAlertTools showAlertWithTitle:@"" message:@"确认要删除此订单吗？"
                         cancelTitle:@"取消" titleArray:@[] viewController:self confirm:^(NSInteger buttonTag) {
                             if (buttonTag==0) {
                                 YLog(@"删除订单");
                                 NSDictionary *params=@{@"sigen":[kUserDefaults objectForKey:@"sigen"],@"order_batchid":model.order_batchid};
                                 [ATHRequestManager requestforDelNotPayOrderWithParams:params successBlock:^(NSDictionary *responseObj) {
                                     if ([responseObj[@"status"] isEqualToString:@"10000"]) {
                                         NSUInteger index=[_dataSource indexOfObject:model];
                                         [_dataSource removeObject:model];
                                         [_tableView deleteSections:[NSIndexSet indexSetWithIndex:index] withRowAnimation:UITableViewRowAnimationRight];
                                     }else
                                     {
                                         [TrainToast showWithText:responseObj[@"message"] duration:2.0];
                                         dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                             [self refreshData];
                                         });

                                     }
                                 } faildBlock:^(NSError *error) {

                                 }];
                             }
                         }];
}

//查看订单详情
-(void)checkDanDetailWithModel:(XLDingDanModel *)model
{
    PersonalShoppingDanDetailVC *vc=[[PersonalShoppingDanDetailVC alloc] init];
    vc.myDingDanModel=model;
    vc.delegate=self;
    [self.navigationController pushViewController:vc animated:NO];
}

#pragma mark-头视图协议
-(void)checkStoreDetailWithModel:(XLDingDanModel *)model
{
    YLog(@"店铺详情");
    MerchantDetailViewController *vc=[[MerchantDetailViewController alloc] init];
    vc.mid=model.mid;
    vc.BackString = @"333";
    [self.navigationController pushViewController:vc animated:NO];
    self.navigationController.navigationBar.hidden=YES;
}
#pragma mark-cell的协议
//单个商品退款
-(void)refundSingleShoppingWithModel:(XLShoppingModel *)model Cell:(UITableViewCell *)cell
{
    //整个订单状态为完成、单笔订单状态为已退款、列表页显示申请记录、
    if ([model.totalStatus isEqualToString:@"2"]) {
        ConsultNounVC *VC=[[ConsultNounVC alloc] init];
        VC.DataModel=model;
        [self.navigationController pushViewController:VC animated:NO];
        return;
    }

    if ([model.status isEqualToString:@"0"]) {
        //0退款 1退货退款
        NSDictionary *params=@{@"ids":model.ID,@"refund_status":@"0"};
        [ATHRequestManager requestforgetRefundNumberWithParams:params successBlock:^(NSDictionary *responseObj) {
            if ([responseObj[@"status"] isEqualToString:@"10000"]) {
                NSString *type=[NSString stringWithFormat:@"%@",responseObj[@"total_type"]];//能否退款 0可以 1不可以
                NSString *refund_num=[NSString stringWithFormat:@"%@",responseObj[@"refund_number"]];//退款次数 2需要显示最后一次退款
                model.goodsCount=[NSString stringWithFormat:@"%@",responseObj[@"goods_count"]];

                if ([type isEqualToString:@"0"]) {
                    PersonalShoppingReplyRefundVC *VC=[[PersonalShoppingReplyRefundVC alloc] init];
                    [VC setDataModel:model AndRefundType:@"0" andRefundTime:[refund_num integerValue] andQurtAllDan:selectIndex==0?YES:NO];
                    [self.navigationController pushViewController:VC animated:NO];

                }else if ([type isEqualToString:@"1"])
                {

                    PersonalShoppingRefundDanDetailVC *VC=[[PersonalShoppingRefundDanDetailVC alloc] init];
                    VC.dataModel=model;
                    VC.kefuJieru=YES;
                    [self.navigationController pushViewController:VC animated:NO];

                }
                else
                {
                    [TrainToast showWithText:responseObj[@"message"] duration:2.0];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [self refreshData];
                    });
                }


            }else
            {
                [TrainToast showWithText:responseObj[@"message"] duration:2.0];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self refreshData];
                });
            }


        } faildBlock:^(NSError *error) {

        }];


    }else if ([model.status isEqualToString:@"1"])
    {
        //0退款 1退货退款
        NSDictionary *params=@{@"ids":model.ID,@"refund_status":@"1"};
        [ATHRequestManager requestforgetRefundNumberWithParams:params successBlock:^(NSDictionary *responseObj) {
            if ([responseObj[@"status"] isEqualToString:@"10000"]) {

                NSString *type=[NSString stringWithFormat:@"%@",responseObj[@"total_type"]];//能否退款 0可以 1不可以

                NSString *refund_num=[NSString stringWithFormat:@"%@",responseObj[@"refund_number"]];//退款次数 2需要显示最后一次退款
                model.goodsCount=[NSString stringWithFormat:@"%@",responseObj[@"goods_count"]];
                if ([type isEqualToString:@"0"]) {
                    PersonalShoppingRefundTypeVC *VC=[[PersonalShoppingRefundTypeVC alloc] init];
                    VC.dataModel=model;
                    VC.RefundTotalTime=[refund_num integerValue];
                    VC.QurtAllDan=(selectIndex==0?YES:NO);
                    YLog(@"%@",model.order_batchid);
                    [self.navigationController pushViewController:VC animated:NO];
                }else if ([type isEqualToString:@"1"])
                {

                    PersonalShoppingRefundDanDetailVC *VC=[[PersonalShoppingRefundDanDetailVC alloc] init];
                    VC.dataModel=model;
                    VC.kefuJieru=YES;
                    [self.navigationController pushViewController:VC animated:NO];

                }
                else
                {
                    [TrainToast showWithText:responseObj[@"message"] duration:2.0];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [self refreshData];
                    });
                }


            }else
            {
                [TrainToast showWithText:responseObj[@"message"] duration:2.0];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self refreshData];
                });
            }


        } faildBlock:^(NSError *error) {

        }];

    }

    else if ([model.status isEqualToString:@"3"]||[model.status isEqualToString:@"4"]||[model.status isEqualToString:@"5"]||[model.status isEqualToString:@"6"]||[model.status isEqualToString:@"10"]||[model.status isEqualToString:@"11"])
    {

        PersonalShoppingRefundDanDetailVC *VC=[[PersonalShoppingRefundDanDetailVC alloc] init];
        VC.dataModel=model;
        [self.navigationController pushViewController:VC animated:NO];

    }
    else if([model.status isEqualToString:@"2"]&&([model.refund_count integerValue]>0||[model.return_goods_count integerValue]>0))
    {

        ConsultNounVC *VC=[[ConsultNounVC alloc] init];
        VC.DataModel=model;
        [self.navigationController pushViewController:VC animated:NO];

    }
    YLog(@"单个商品退款");
}

/*******************************************************      代码提取(多是复用代码)       ******************************************************/
#pragma mark-详情协议
-(void)SelectIndexType:(NSInteger)index
{
    [self selectedIndexType:index];
}
//选择了一种状态
-(void)selectedIndexType:(NSInteger )index
{

    //判断index的位置--主要是手势操作时用到
    if (index>4) {
        selectIndex=4;
        return;
    }else if(index<0)
    {
        selectIndex=0;
        return;
    }

    selectIndex=index;
    _tableView.contentOffset=CGPointZero;
    YLog(@"----选择了第%ld个，状态为%@",index,self.statusArray[selectIndex]);
    NSArray *titles = @[@"全部", @"待付款", @"待发货",@"待收货",@"交易完成"];
    CGFloat Weight = [UIScreen mainScreen].bounds.size.width/5;
    for (int i=0; i<titles.count;i++) {
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

    //  [_dataSource removeAllObjects];
    self.page=0;
    NSDictionary *params=@{@"sigen":[kUserDefaults objectForKey:@"sigen"],@"page":[NSString stringWithFormat:@"%ld",self.page],@"status":self.statusArray[selectIndex]};
    [self getDatasWithParams:params];
}
//数据源
-(NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource=[[NSMutableArray alloc]init];
    }
    return _dataSource;
}
//初始化顶部状态标识数组、
-(NSArray *)statusArray
{
    if (!_statusArray) {
        //  空:全部订单，7:代付款订单，0:待发货订单,1:待收货订单,2:交易完成订单
        _statusArray=@[@"",@"7",@"0",@"1",@"2"];
    }
    return _statusArray;
}

-(XLNoDataView *)noDataView
{
    if (!_noDataView) {
        _noDataView=[[XLNoDataView alloc] initWithFrame:CGRectMake(0, 45, kScreen_Width, kScreen_Height-65-45)];
    }
    return _noDataView;
}

-(NSInteger)page
{
    if (!_page) {
        _page=0;
    }
    return _page;
}

@end

