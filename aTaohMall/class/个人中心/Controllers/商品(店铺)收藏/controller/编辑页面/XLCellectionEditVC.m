//
//  XLCellectionEditVC.m
//  aTaohMall
//
//  Created by Hawky on 2018/3/12.
//  Copyright © 2018年 ysy. All rights reserved.
//

#import "XLCellectionEditVC.h"
#import "XLNaviVIew.h"
@interface XLCellectionEditVC ()<UITableViewDelegate,UITableViewDataSource,XLNaviViewDelegate>
{
    UITableView *_tableView;
    BOOL isShopsEdit;
}

@end

@implementation XLCellectionEditVC

#pragma mark - 控制器生命周期
/*****  <#desc#> *****/
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}

/*****  <#desc#> *****/
-(void)setUI
{
    [self initNavi];
    [self initTableview];

}

/*****  <#desc#> *****/
-(void)initNavi
{
    XLNaviView *navi=[[XLNaviView alloc] initWithMessage:@"编辑" ImageName:@""];
    navi.delegate=self;
    [self.view addSubview:navi];

}

/*****  <#desc#> *****/
-(void)initTableview
{
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-KSafeAreaTopNaviHeight) style:UITableViewStyleGrouped];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.showsVerticalScrollIndicator=NO;
    _tableView.showsHorizontalScrollIndicator=NO;
    _tableView.estimatedRowHeight=0;
    _tableView.estimatedSectionFooterHeight=0;
    _tableView.estimatedSectionHeaderHeight=0;
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;

   // [_tableView registerClass:[XLGoodsCollectionCell class] forCellReuseIdentifier:XLGoodsCollectionCellReuse];
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

#pragma mark - NaviDelegate
/*****  退出 *****/
-(void)QurtBtnClick
{
    [self.navigationController popViewControllerAnimated:NO];
}

#pragma mark - TableViewDelegate

#pragma mark - getter and setter
/*****  在给商品数据赋值的时候 *****/
-(void)setGoodsDataSource:(NSArray *)goodsDataSource
{
    _goodsDataSource=goodsDataSource;
    isShopsEdit=NO;
    [_tableView reloadData];
}

/*****  在给商铺数据赋值的时候 *****/
-(void)setShopsDataSource:(NSArray *)shopsDataSource
{
    _shopsDataSource=shopsDataSource;
    isShopsEdit=YES;
    [_tableView reloadData];
}
@end
