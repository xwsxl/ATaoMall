//
//  HomeDaiPaiSuggestListVC.m
//  aTaohMall
//
//  Created by Hawky on 2017/12/30.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "HomeDaiPaiSuggestListVC.h"
#import "YTGoodsDetailViewController.h"

#import "XLNaviVIew.h"
#import "XLNoDataView.h"
#import "HomeDPListCell.h"

#import "DPCommandDetailViewController.h"

@interface HomeDaiPaiSuggestListVC ()<XLNaviViewDelegate,UITableViewDelegate,UITableViewDataSource,HomeDPListCellDelegate>
{

    UITableView *_tableView;
    XLNoDataView  *_noDataView;

    NSInteger _page;
    NSInteger totalCount;
}
@property (nonatomic,strong)NSMutableArray *dataSource;
@end

@implementation HomeDaiPaiSuggestListVC

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

    NSDictionary *params=@{@"page":[NSString stringWithFormat:@"%ld",_page]};
    WKProgressHUD *hud=[WKProgressHUD showInView:self.view withText:@"" animated:YES];

    [ATHRequestManager requestforselectBrandToDataWithParams:params successBlock:^(NSDictionary *responseObj) {

        [hud dismiss:YES];
        [_tableView.mj_footer endRefreshing];
        [_tableView.mj_header endRefreshing];
        if ([responseObj[@"status"] isEqualToString:@"10000"]) {
            _page++;
            totalCount=[responseObj[@"total_number"] integerValue];
            for (NSDictionary *dic in responseObj[@"list"]) {
                HomeDPModel *model=[[HomeDPModel alloc] init];
                /*
                "id": 26,
                "cream_name": "嗷嗷3",
                "represent": "1111",
                "picpath": "http://image.athmall.com/ATH/union/upload/homePage/c7de206b000000c0.png",
                "remarks": "",
                "good_list":*/
                model.ID=[NSString stringWithFormat:@"%@",dic[@"id"]];
                model.cream_name=[NSString stringWithFormat:@"%@",dic[@"cream_name"]];
                model.represent=[NSString stringWithFormat:@"%@",dic[@"represent"]];
                model.picpath=[NSString stringWithFormat:@"%@",dic[@"picpath"]];
                model.remarks=[NSString stringWithFormat:@"%@",dic[@"remarks"]];

                [model goodListWithArray:dic[@"good_list"]];
                [self.dataSource addObject:model];

            }
            [_tableView reloadData];
        }

    } faildBlock:^(NSError *error) {
        [hud dismiss:YES];
        [_tableView.mj_footer endRefreshing];
        [_tableView.mj_header endRefreshing];
    }];



}

/*******************************************************      初始化视图       ******************************************************/
//
-(void)initNavi
{
    XLNaviView *navi=[[XLNaviView alloc] initWithMessage:@"大牌推荐" ImageName:@""];
    navi.delegate=self;
    [self.view addSubview:navi];

}
//
-(void)initTableview
{
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight, kScreenWidth, kScreenHeight-KSafeAreaTopNaviHeight) style:UITableViewStyleGrouped];

    NSLogRect(_tableView.frame);
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.showsVerticalScrollIndicator=NO;
    _tableView.showsHorizontalScrollIndicator=NO;
    _tableView.estimatedRowHeight=0;
    _tableView.estimatedSectionFooterHeight=0;
   // _tableView.estimatedSectionHeaderHeight=0;
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [_tableView registerClass:[HomeDPListCell class] forCellReuseIdentifier:reuseIdentifier];

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
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}

//
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
//
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeDPListCell *cell=[tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.delegate=self;
    cell.DataModel=self.dataSource[indexPath.section];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

//    AllSingleShoppingModel *model=self.dataSource[indexPath.row];
//    YTGoodsDetailViewController *vc=[[YTGoodsDetailViewController alloc] init];
//    vc.good_type=model.type_name;
//    //    vc.gid=gid;
//    vc.gid=model.ID;
//    vc.type=@"1";
//    vc.attribute = model.is_attribute;
//    vc.ID=model.ID;
//    [self.navigationController pushViewController:VC animated:NO];

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeDPModel *model=self.dataSource[indexPath.section];
    return model.cellHeight;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[UIView alloc] init];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return Height(10);
}

/*******************************************************      协议方法       ******************************************************/
//
-(void)QurtBtnClick
{

    [self.navigationController popViewControllerAnimated:YES];

}
#pragma mark-cell

-(void)HomeGoodsButClickWithModel:(AllSingleShoppingModel *)model
{
    YTGoodsDetailViewController *VC=[[YTGoodsDetailViewController alloc] init];
    VC.gid=model.gid;
    [self.navigationController pushViewController:VC animated:NO];
}

-(void)HomeDpButClickWithModel:(HomeDPModel *)model
{
    DPCommandDetailViewController *VC=[[DPCommandDetailViewController alloc] init];
    VC.Title=model.cream_name;
    VC.ID=model.ID;
    [self.navigationController pushViewController:VC animated:NO];
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

