//
//  HomeGoodGoodsHotSaleVC.m
//  aTaohMall
//
//  Created by Hawky on 2017/12/29.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "HomeGoodGoodsHotSaleVC.h"
#import "YTGoodsDetailViewController.h"

#import "XLNaviVIew.h"
#import "XLNoDataView.h"
#import "XLShoppingListTableViewCell.h"

@interface HomeGoodGoodsHotSaleVC ()<XLNaviViewDelegate,UITableViewDelegate,UITableViewDataSource>
{

    UITableView *_tableView;
    XLNoDataView  *_noDataView;

    NSInteger _page;
    NSInteger totalCount;
}
@property (nonatomic,strong)NSMutableArray *dataSource;
@end

@implementation HomeGoodGoodsHotSaleVC

static NSString * const reuseIdentifier = @"XLShoppingListTableViewCell";

/*******************************************************      控制器生命周期       ******************************************************/
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTableview];
    [self initNavi];
    [self refreshData];
    if (@available(iOS 11.0, *)) {

    } else {
        self.automaticallyAdjustsScrollViewInsets =NO;
    }
}
/*******************************************************      数据请求       ******************************************************/

//上拉加载更多
-(void)loadMoreData
{
    if (totalCount==_dataSource.count) {
        [_tableView.mj_footer endRefreshingWithNoMoreData];
    }else
    {
        [self getData];
    }
}
//下拉刷新数据
-(void)refreshData
{
    _page=0;
    [self.dataSource removeAllObjects];
    [self getData];
}
//获取数据
-(void)getData
{

    NSString *ids=@"";
    for (AllSingleShoppingModel *model in self.dataSource) {
      ids=[ids stringByAppendingString:model.ID];
       ids=[ids stringByAppendingString:@","];
    }
    if (ids.length>0) {
        ids=[ids substringToIndex:ids.length-1];
    }

    NSDictionary *params=@{@"gids":ids};
    WKProgressHUD *hud=[WKProgressHUD showInView:self.view withText:@"" animated:YES];

    [ATHRequestManager requestforgetGoodSellGoodsListWithParams:params successBlock:^(NSDictionary *responseObj) {

        [hud dismiss:YES];
        [_tableView.mj_footer endRefreshing];
        [_tableView.mj_header endRefreshing];
        if ([responseObj[@"status"] isEqualToString:@"10000"]) {
            _page++;
            totalCount=[responseObj[@"total_count"] integerValue];
            for (NSDictionary *dic in responseObj[@"list"]) {
                
                AllSingleShoppingModel *model=[[AllSingleShoppingModel alloc] init];
                model.ID=[NSString stringWithFormat:@"%@",dic[@"id"]];
                model.name=[NSString stringWithFormat:@"%@",dic[@"name"]];
                model.gid=[NSString stringWithFormat:@"%@",dic[@"gid"]];
                model.mid=[NSString stringWithFormat:@"%@",dic[@"mid"]];
                model.scopeimg=[NSString stringWithFormat:@"%@",dic[@"scopeimg"]];
                model.pay_maney=[NSString stringWithFormat:@"%@",dic[@"pay_maney"]];
                model.pay_integer=[NSString stringWithFormat:@"%@",dic[@"pay_integer"]];
                model.amount=[NSString stringWithFormat:@"%@",dic[@"amount"]];
                model.is_attribute=[NSString stringWithFormat:@"%@",dic[@"is_attribute"]];
                model.storename=[NSString stringWithFormat:@"%@",dic[@"storename"]];
                [self.dataSource addObject:model];

            }
            [_tableView reloadData];
        }

    } faildBlock:^(NSError *error) {
        [hud dismiss:YES];

    }];



}

/*******************************************************      初始化视图       ******************************************************/
//
-(void)initNavi
{
    XLNaviView *navi=[[XLNaviView alloc] initWithMessage:@"好货特卖" ImageName:@""];
    navi.delegate=self;
    [self.view addSubview:navi];

}
//
-(void)initTableview
{
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight, kScreenWidth, kScreenHeight-KSafeAreaTopNaviHeight) style:UITableViewStyleGrouped];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.showsVerticalScrollIndicator=NO;
    _tableView.showsHorizontalScrollIndicator=NO;
    _tableView.estimatedRowHeight=0;
    _tableView.estimatedSectionFooterHeight=0;
    _tableView.estimatedSectionHeaderHeight=0;
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [_tableView registerClass:[XLShoppingListTableViewCell class] forCellReuseIdentifier:reuseIdentifier];

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


//
-(void)initNoDataView
{
    _tableView.hidden=YES;
    _noDataView=[[XLNoDataView alloc] initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight, kScreenWidth, kScreenHeight-KSafeAreaTopNaviHeight-KSafeAreaBottomHeight) AndMessage:nil ImageName:nil];
    [self.view addSubview:_noDataView];
}


/*******************************************************      各种button执行方法、页面间的跳转       ******************************************************/
//
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}
//
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XLShoppingListTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];

    cell.DataModel=self.dataSource[indexPath.row];

    return cell;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AllSingleShoppingModel *model=self.dataSource[indexPath.row];
    YTGoodsDetailViewController *vc=[[YTGoodsDetailViewController alloc] init];
    vc.good_type=model.type_name;
    //    vc.gid=gid;
    vc.gid=model.gid;
    vc.type=@"1";
    vc.attribute = model.is_attribute;
    vc.ID=model.ID;
    [self.navigationController pushViewController:vc animated:NO];

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return Height(15)+105;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

/*******************************************************      协议方法       ******************************************************/
//
-(void)QurtBtnClick
{

    [self.navigationController popViewControllerAnimated:YES];

}


/*******************************************************      代码提取(多是复用代码)       ******************************************************/

//
-(NSMutableArray *)dataSource
{

    if (!_dataSource) {
        _dataSource=[[NSMutableArray alloc] init];
    }
    return _dataSource;

}

@end
