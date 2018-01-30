//
//  PersonalShoppingRefundListVC.m
//  aTaohMall
//
//  Created by Hawky on 2017/11/23.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "PersonalShoppingRefundListVC.h"

#import "PersonalShoppingRefundDanDetailVC.h"
//店铺
#import "MerchantDetailViewController.h"

#import "PersonalShoppingDanCell.h"
#import "PersonalShoppingSectionHeaderView.h"
#import "PersonalShoppingRefundFooterView.h"
#import "XLNoDataView.h"

static NSString * const XLConstPersonalShoppingDanCell=@"PersonalShoppingDanCell";
static NSString * const XLConstPersonalShoppingSectionHeaderView=@"PersonalShoppingSectionHeaderView";
static NSString * const XLConstPersonalShoppingRefundFooterView=@"PersonalShoppingRefundFooterView";


@interface PersonalShoppingRefundListVC ()<UITableViewDelegate,UITableViewDataSource,PersonalShoppingDanCellDelegat,PersonalShoppingSectionHeaderViewDelegate,PersonalShoppingRefundFooterViewDelegate>
{
    NSInteger totalCount;
}

@property (nonatomic,strong)NSMutableArray *dataSource;
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,assign)NSInteger page;
@property (nonatomic,strong)XLNoDataView *noDataView;

@end

@implementation PersonalShoppingRefundListVC


/*******************************************************      控制器生命周期       ******************************************************/
//
- (void)viewDidLoad {
    [super viewDidLoad];
    [self getDatasWithParams:nil];
    [self setUI];
}

//
-(void)setUI
{
    [self initTopView];
    [self initTableView];
}
/*******************************************************      数据请求       ******************************************************/

//上拉加载更多
-(void)loadMoreData
{
    if (totalCount==_dataSource.count) {
        [_tableView.mj_footer endRefreshingWithNoMoreData];
    }else
    {
        NSDictionary *params=@{@"sigen":[kUserDefaults objectForKey:@"sigen"],@"page":[NSString stringWithFormat:@"%ld",self.page]};
        [self getDatasWithParams:params];
    }
}
//下拉刷新数据
-(void)refreshData
{
    self.page=0;
    NSDictionary *params=@{@"sigen":[kUserDefaults objectForKey:@"sigen"],@"page":[NSString stringWithFormat:@"%ld",self.page]};
    [self getDatasWithParams:params];
}
//加载数据
-(void)getDatasWithParams:(NSDictionary *)params
{
    if (!params) {
        //sigen值为获取用户id page表示分页，从0开始、status表示状态、空:全部订单，7:代付款订单，0:待发货订单,1:待收货订单,2:交易完成订单
        params=@{@"sigen":[kUserDefaults objectForKey:@"sigen"],@"page":[NSString stringWithFormat:@"%ld",self.page]};
    }

    WKProgressHUD *hud=[WKProgressHUD showInView:self.view.window withText:nil animated:YES];
    [ATHRequestManager requestforGetOrderRefundListByGoodsWithParams:params successBlock:^(NSDictionary *responseObj) {

        if ([responseObj[@"status"] isEqualToString:@"10000"]) {

            if ([params[@"page"] isEqualToString:@"0"]) {
                [self.dataSource removeAllObjects];
            }
            self.page++;
            NSArray *tempArr=responseObj[@"order_list"];
            totalCount=[responseObj[@"totalCount"] integerValue];
            for (NSDictionary *orderDic in tempArr) {
                XLDingDanModel *model=[XLDingDanModel new];
                [model goodsOrderListFromArray:orderDic[@"goods_order_list"] withType:@"refundType"];
                model.logo=[NSString stringWithFormat:@"%@",orderDic[@"logo"]];
                model.mid=[NSString stringWithFormat:@"%@",orderDic[@"mid"]];
                model.order_batchid=[NSString stringWithFormat:@"%@",orderDic[@"order_batchid"]];
                model.storename=[NSString stringWithFormat:@"%@",orderDic[@"storename"]];

                model.total_freight=[NSString stringWithFormat:@"%@",orderDic[@"total_freight"]];



                CGFloat totalMoney=0;
                CGFloat totalInteger=0;

                for (NSDictionary *dic in orderDic[@"goods_order_list"]) {
                    NSString *str=[NSString stringWithFormat:@"%@",dic[@"returns_money"]];
                    NSString *str2=[NSString stringWithFormat:@"%@",dic[@"returns_integral"]];

                    if ([str isEqualToString:@""]||[str containsString:@"null"]) {
                        str=@"0";
                    }
                    if ([str2 isEqualToString:@""]||[str2 containsString:@"null"]) {
                        str2=@"0";
                    }
                         totalMoney=totalMoney+[str floatValue];
                        totalInteger=totalInteger+[str2 floatValue];




                    YLog(@"%.2f,%@,%.2f,%@",totalMoney,dic[@"returns_money"],totalInteger,dic[@"returns_integral"]);
                }
                model.total_money=[NSString stringWithFormat:@"%.2f",totalMoney];
                model.total_integral=[NSString stringWithFormat:@"%.2f",totalInteger];

                model.total_number_goods=[NSString stringWithFormat:@"%@",orderDic[@"total_number_goods"]];
                model.total_status=[NSString stringWithFormat:@"%@",orderDic[@"total_status"]];
                model.dingDanType=@"refundType";
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

        [hud dismiss:YES];

    } faildBlock:^(NSError *error) {
        [_tableView.mj_footer endRefreshing];
        [_tableView.mj_header endRefreshing];
        [hud dismiss:YES];
    }];

}

/*******************************************************      初始化视图       ******************************************************/
//
-(void)initTopView
{

    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 15+Height(30))];
    [view setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:view];

    UILabel *titleLab=[[UILabel alloc] initWithFrame:CGRectMake(0, Height(15), kScreen_Width, 14)];
    [titleLab setFont:KNSFONTM(14)];
    [titleLab setText:@"退款订单"];
    [titleLab setTextColor:RGB(51, 51, 51)];
    [titleLab setTextAlignment:NSTextAlignmentCenter];
    [view addSubview:titleLab];

    UIImageView *IV=[[UIImageView alloc]initWithFrame:CGRectMake(0, Height(30)+14, kScreen_Width, 1)];
    IV.image=[UIImage imageNamed:@"分割线-拷贝"];
    [view addSubview:IV];


}
//
-(void)initTableView
{
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, Height(30)+15, kScreen_Width, kScreen_Height-Height(30)-15-65) style:UITableViewStyleGrouped];
    NSLogRect(self.view.frame);
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;

    [_tableView registerClass:[PersonalShoppingDanCell class] forCellReuseIdentifier:XLConstPersonalShoppingDanCell];

    [_tableView registerClass:[PersonalShoppingSectionHeaderView class] forHeaderFooterViewReuseIdentifier:XLConstPersonalShoppingSectionHeaderView];

    [_tableView registerClass:[PersonalShoppingRefundFooterView class] forHeaderFooterViewReuseIdentifier:XLConstPersonalShoppingRefundFooterView];

    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
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
/*******************************************************      各种button执行方法、页面间的跳转       ******************************************************/
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
    PersonalShoppingRefundFooterView *view=[tableView dequeueReusableHeaderFooterViewWithIdentifier:XLConstPersonalShoppingRefundFooterView];
    XLDingDanModel *model=_dataSource[section];
    view.dataModel=model;
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
    return model.refundFootHeight;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

/*******************************************************      协议方法       ******************************************************/

/*
 查看详情
 */
-(void)refundSingleShoppingWithModel:(XLShoppingModel *)model Cell:(UITableViewCell *)cell
{
    NSIndexPath *indexPath=[_tableView indexPathForCell:cell];
    XLDingDanModel *model1=_dataSource[indexPath.section];

    XLShoppingModel *datamodel=model1.goods_order_list[indexPath.row];
    PersonalShoppingRefundDanDetailVC *VC=[[PersonalShoppingRefundDanDetailVC alloc] init];
    datamodel.order_batchid=model1.order_batchid;
    VC.dataModel=datamodel;
    [self.navigationController pushViewController:VC animated:NO];

}

/*
进店看看
 */
-(void)checkStoreDetailWithModel:(XLDingDanModel *)model
{
    YLog(@"店铺详情");
    MerchantDetailViewController *vc=[[MerchantDetailViewController alloc] init];
    vc.mid=model.mid;
    vc.BackString = @"333";
    [self.navigationController pushViewController:vc animated:NO];
    self.navigationController.navigationBar.hidden=YES;
}
/*
查看详情
 */
-(void)checkDetailInfoWithModel:(XLDingDanModel *)mdoel
{
    XLShoppingModel *model=mdoel.goods_order_list[0];
    model.order_batchid=mdoel.order_batchid;

    PersonalShoppingRefundDanDetailVC *VC=[[PersonalShoppingRefundDanDetailVC alloc] init];
    VC.dataModel=model;
    [self.navigationController pushViewController:VC animated:NO];

}

/*******************************************************      代码提取(多是复用代码)       ******************************************************/

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

-(NSInteger)page
{
    if (!_page) {
        _page=0;
    }
    return _page;
}


@end
