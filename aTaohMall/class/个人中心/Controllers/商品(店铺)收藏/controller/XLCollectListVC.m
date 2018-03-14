//
//  XLCollectListVC.m
//  aTaohMall
//
//  Created by Hawky on 2018/3/7.
//  Copyright © 2018年 ysy. All rights reserved.
//

#import "XLCollectListVC.h"
#import "YTGoodsDetailViewController.h"
#import "MerchantDetailViewController.h"

#import "AllSingleShoppingModel.h"
#import "MerchantModel.h"

#import "XLGoodsCollectionCell.h"
#import "XLShopsCollectionCell.h"

#import "LYEmptyViewHeader.h"
#import "MyDIYEmpty.h"
#define SELECTGOODS [_selectIndex isEqualToString:@"1"]
@interface XLCollectListVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    UIScrollView *_scroll;
    UITableView *_tableView;
    UITableView *_tableView2;
    NSString *_searchWord;
    NSMutableArray *_tempArrM;
    BOOL _isEdit;
}
@property (nonatomic,strong)UIView *normalNavi;
@property (nonatomic,strong)UIView *searchNavi;
@property (nonatomic,strong)NSMutableArray *goodsDataSource;
@property (nonatomic,strong)NSMutableArray *shopsDataSource;
@property (nonatomic,assign)NSInteger goodsPage;
@property (nonatomic,assign)NSInteger shopsPage;
@property (nonatomic,assign)NSInteger invalid_totalCount;
@property (nonatomic,assign)NSInteger totalCount;
@property (nonatomic,strong)NSString *selectIndex;
@property (nonatomic, strong) UISwipeGestureRecognizer *leftSwipeGestureRecognizer;
@property (nonatomic, strong) UISwipeGestureRecognizer *rightSwipeGestureRecognizer;

@end
static NSString *const XLGoodsCollectionCellReuse=@"XLGoodsCollectionCell";
static NSString *const XLShopsCollectionCellReuse=@"XLShopsCollectionCell";

@implementation XLCollectListVC

#pragma mark - life cycle
/*****  <#desc#> *****/
- (void)viewDidLoad {
    [super viewDidLoad];
    _tempArrM=[[NSMutableArray alloc] init];
    [self SetUI];
}

/*****  布局主视图  *****/
-(void)SetUI
{
    [self initNormalNavi];
    [self initSearchNavi];
    [self initTableView];
}

/*****  初始化普通导航栏 *****/
-(void)initNormalNavi
{

    [self.view addSubview:self.normalNavi];
    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight-1, [UIScreen mainScreen].bounds.size.width, 1)];
    line.image = [UIImage imageNamed:@"分割线-拷贝"];
    [self.normalNavi addSubview:line];
/*****  normalNavi *****/
    //返回按钮
    UIButton *Qurt = [UIButton buttonWithType:UIButtonTypeCustom];
    Qurt.frame = CGRectMake(10, 25+KSafeTopHeight, 30, 30);
    [Qurt setImage:[UIImage imageNamed:@"iconfont-fanhui2yt"] forState:0];
    [Qurt addTarget:self action:@selector(QurtBtnClick2) forControlEvents:UIControlEventTouchUpInside];
    [self.normalNavi addSubview:Qurt];

    UIButton * searchBut=[UIButton buttonWithType:UIButtonTypeCustom];
    searchBut.frame=CGRectMake(kScreen_Width-12-15, KSafeTopHeight+27, 12, 33);
    [searchBut setImage:KImage(@"13btn_search") forState:UIControlStateNormal];
    [searchBut addTarget:self action:@selector(searchButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    searchBut.hidden=YES;
    searchBut.tag=100;
    [self.normalNavi addSubview:searchBut];

    UIButton * editBut=[UIButton buttonWithType:UIButtonTypeCustom];
    editBut.frame=CGRectMake(kScreen_Width-38-19, KSafeTopHeight+26, 24, 34);
    [editBut setImage:KImage(@"13btn_editor") forState:UIControlStateNormal];
    editBut.hidden=YES;
    editBut.tag=101;
    [editBut addTarget:self action:@selector(editButClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.normalNavi addSubview:editBut];

    CGFloat butWidth=(kScreen_Width-57-40)/2;

    UIButton *goodsBut=[UIButton buttonWithType:UIButtonTypeCustom];
    goodsBut.frame=CGRectMake(40, KSafeTopHeight+22, butWidth, 43);
    [goodsBut setTitle:@"商品" forState:UIControlStateNormal];
    [goodsBut addTarget:self action:@selector(goodsButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    goodsBut.tag=200;
    [self.normalNavi addSubview:goodsBut];

    UIButton *shopsBut=[UIButton buttonWithType:UIButtonTypeCustom];
    shopsBut.frame=CGRectMake(40+butWidth, KSafeTopHeight+22, butWidth, 43);
    [shopsBut setTitle:@"店铺" forState:UIControlStateNormal];
    [shopsBut addTarget:self action:@selector(shopsButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    shopsBut.tag=201;
    [self.normalNavi addSubview:shopsBut];


    CGFloat x=(butWidth-51)/2+40;
    UIView *sliderView=[[UIView alloc] initWithFrame:CGRectMake(x, KSafeAreaTopNaviHeight-3, 51, 3)];
    sliderView.backgroundColor=RGB(255, 93, 94);
    sliderView.tag=300;
    [self.normalNavi addSubview:sliderView];

}

/*****  初始化搜索导航栏 *****/
-(void)initSearchNavi
{

    [self.view addSubview:self.searchNavi];
    self.searchNavi.hidden=YES;
    /*****  searchNavi *****/
    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight-1, [UIScreen mainScreen].bounds.size.width, 1)];
    line.image = [UIImage imageNamed:@"分割线-拷贝"];
    [self.searchNavi addSubview:line];

    UITextField *searchTextField=[[UITextField alloc] init];
    UIImageView *searchBackView=[[UIImageView alloc] init];
    UIImageView *searchIcon1=[[UIImageView alloc] init];
    [searchBackView setImage:KImage(@"搜索长框")];
    [searchIcon1 setImage:KImage(@"xl-Search Icon")];


    [self.searchNavi addSubview:searchBackView];
    [self.searchNavi addSubview:searchIcon1];
    [self.searchNavi addSubview:searchTextField];

    searchBackView.frame=CGRectMake(15, 27+KSafeTopHeight, kScreen_Width-30-30-10, 32);
    searchIcon1.frame=CGRectMake(30, 37+KSafeTopHeight, 14, 14);
    searchTextField.frame=CGRectMake(30+14+5, 34+KSafeTopHeight, kScreen_Width-30-14-5-30-15-10-15, 20);
    searchTextField.tag=500;
    searchTextField.clearButtonMode=UITextFieldViewModeWhileEditing;
    [searchTextField addTarget:self action:@selector(changeValue:) forControlEvents:UIControlEventEditingChanged];
    searchTextField.returnKeyType = UIReturnKeySearch;//更改键盘的return
    searchTextField.contentVerticalAlignment=NSTextAlignmentCenter;
    searchTextField.delegate = self;
    searchTextField.font=KNSFONT(14);


    UIButton *rightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame=CGRectMake(kScreen_Width-15-30, 28+KSafeTopHeight, 40, 30);
    [rightBtn setTitle:@"取消" forState:UIControlStateNormal];
    [rightBtn setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
    rightBtn.titleLabel.font=KNSFONT(14);
    [rightBtn addTarget:self action:@selector(cancleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.searchNavi addSubview:rightBtn];

}

/*****  初始化表视图 *****/
-(void)initTableView
{
    _scroll=[[UIScrollView alloc] initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight, kScreenWidth, kScreenHeight-KSafeAreaTopNaviHeight)];
    _scroll.scrollEnabled=NO;
    _scroll.userInteractionEnabled=YES;
   // _scroll.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_scroll];

//    self.leftSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
//    self.rightSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
//
//    self.leftSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
//    self.rightSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
//
//    [_scroll addGestureRecognizer:self.leftSwipeGestureRecognizer];
//    [_scroll addGestureRecognizer:self.rightSwipeGestureRecognizer];

    UIButton * but=[UIButton buttonWithType:UIButtonTypeCustom];
    but.frame=CGRectMake(kScreen_Width-Width(25)-50, kScreenHeight-Height(127)-50, 50, 50);
    but.titleLabel.font=KNSFONTM(12);
    but.titleLabel.numberOfLines=0;
    but.hidden=YES;
    but.tag=400;
    but.titleLabel.textAlignment=NSTextAlignmentCenter;
    but.layer.cornerRadius=25;
    but.backgroundColor=RGBA(0, 0, 0, 0.6);
    [but setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-KSafeAreaTopNaviHeight) style:UITableViewStyleGrouped];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.showsVerticalScrollIndicator=NO;
    _tableView.showsHorizontalScrollIndicator=NO;
    _tableView.estimatedRowHeight=0;
    _tableView.estimatedSectionFooterHeight=0;
    _tableView.estimatedSectionHeaderHeight=0;
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;

    [_tableView registerClass:[XLGoodsCollectionCell class] forCellReuseIdentifier:XLGoodsCollectionCellReuse];
    _tableView.ly_emptyView=[MyDIYEmpty emptyActionViewWithImageStr:@"13icon_collectionempty" titleStr:@"" detailStr:@"" btnTitleStr:@"还没有任何收藏呢，不如去首页逛逛~" btnClickBlock:^{

        self.tabBarController.selectedIndex=0;
        [self.navigationController popToRootViewControllerAnimated:NO];

    }];

    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    // [footer setBackgroundColor:[UIColor whiteColor]];
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
    [_scroll addSubview:_tableView];
    [_scroll addSubview:but];
    if (1) {
    _tableView2=[[UITableView alloc] initWithFrame:CGRectMake(kScreen_Width, 0, kScreenWidth, kScreenHeight-KSafeAreaTopNaviHeight) style:UITableViewStyleGrouped];
    _tableView2.delegate=self;
    _tableView2.dataSource=self;
    _tableView2.showsVerticalScrollIndicator=NO;
    _tableView2.showsHorizontalScrollIndicator=NO;
    _tableView2.estimatedRowHeight=0;
    _tableView2.estimatedSectionFooterHeight=0;
    _tableView2.estimatedSectionHeaderHeight=0;
    _tableView2.separatorStyle=UITableViewCellSeparatorStyleNone;
    _tableView2.ly_emptyView=[MyDIYEmpty emptyActionViewWithImageStr:@"13icon_storesempty" titleStr:@"" detailStr:@"" btnTitleStr:@"您还没有收藏过任何店铺！何不去首页逛逛~" btnClickBlock:^{

            self.tabBarController.selectedIndex=0;
            [self.navigationController popToRootViewControllerAnimated:NO];

    }];
    [_tableView2 registerClass:[XLShopsCollectionCell class] forCellReuseIdentifier:XLShopsCollectionCellReuse];
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    // [footer setBackgroundColor:[UIColor whiteColor]];
    [footer setTitle:@"" forState:MJRefreshStateIdle];
    [footer setTitle:@"正在加载..." forState:MJRefreshStateRefreshing];
    [footer setTitle:@"暂无更多数据" forState:MJRefreshStateNoMoreData];
    _tableView2.mj_footer = footer;

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

    _tableView2.mj_header=header;
    [_scroll addSubview:_tableView2];
    }

}

#pragma mark - 数据请求

/*****  取消搜索 *****/
-(void)cancleButtonClick:(UIButton *)sender
{
    self.normalNavi.hidden=NO;
    self.searchNavi.hidden=YES;


    _searchWord=@"";
    UITextField *textfield=[self.view viewWithTag:500];
    [textfield resignFirstResponder];

    if (SELECTGOODS) {
        self.goodsPage=0;
        self.goodsDataSource=[_tempArrM mutableCopy];
        [_tableView.ly_emptyView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [_tableView.ly_emptyView removeFromSuperview];
        _tableView.ly_emptyView=nil;
        _tableView.ly_emptyView=[MyDIYEmpty emptyActionViewWithImageStr:@"13icon_collectionempty" titleStr:@"" detailStr:@"" btnTitleStr:@"还没有任何收藏呢，不如去首页逛逛~" btnClickBlock:^{

            self.tabBarController.selectedIndex=0;
            [self.navigationController popToRootViewControllerAnimated:NO];

        }];

        [self goodsButtonClick:nil];
    }else
    {
        self.shopsPage=0;
        self.shopsDataSource=[_tempArrM mutableCopy];
        [_tableView2.ly_emptyView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];

        [_tableView2.ly_emptyView removeFromSuperview];
        _tableView2.ly_emptyView=nil;

        _tableView2.ly_emptyView=[MyDIYEmpty emptyActionViewWithImageStr:@"13icon_storesempty" titleStr:@"" detailStr:@"" btnTitleStr:@"您还没有收藏过任何店铺！何不去首页逛逛~" btnClickBlock:^{

            self.tabBarController.selectedIndex=0;
            [self.navigationController popToRootViewControllerAnimated:NO];

        }];

        [self shopsButtonClick:nil];
    }
    [self getdatas];
}

/*****  <#desc#> *****/
-(void)loadMoreData
{
    /*sigen：
    type：类型：1商品2商铺（这里传2）
    name：店铺名
    page：页数 从0开始每页递增1*/

    [self getdatas];
}

/*****  <#desc#> *****/
-(void)refreshData
{
    SELECTGOODS?(self.goodsPage=0):(self.shopsPage=0);
    [self getdatas];
}

/*****  <#desc#> *****/
-(void)getdatas
{
    if (!_searchWord) {
        _searchWord=@"";
    }
    SELECTGOODS?[self getGoodsData]:[self getShopsData];
}

/*****  获取商品数据 *****/
-(void)getGoodsData
{
    NSDictionary *params=@{@"sigen":[kUserDefaults objectForKey:@"sigen"],@"type":_selectIndex,@"name":_searchWord,@"page":[NSNumber numberWithInteger:self.goodsPage]};
    NSString *url=[NSString stringWithFormat:@"%@getCollectionList_mob.shtml",URL_Str];
    WKProgressHUD *hud=[WKProgressHUD showInView:self.view withText:nil animated:YES];
    [ATHRequestManager POST:url parameters:params successBlock:^(NSDictionary *responseObj) {
        YLog(@"responseobj=%@",responseObj);
        if ([responseObj[@"status"] isEqualToString:@"10000"]) {

            if (self.goodsPage == 0) {
                [self.goodsDataSource removeAllObjects];
            }
            self.goodsPage++;
            self.invalid_totalCount = [responseObj[@"invalid_totalCount"] integerValue];
            self.totalCount = [responseObj[@"totalCount"] integerValue];

            for (NSDictionary *dic in responseObj[@"list"]) {
                AllSingleShoppingModel *model = [[AllSingleShoppingModel alloc] init];
                model.gid=[NSString stringWithFormat:@"%@",dic[@"gid"]];
                model.collectionID=[NSString stringWithFormat:@"%@",dic[@"id"]];
                model.scopeimg=[NSString stringWithFormat:@"%@",dic[@"logo"]];
                model.name=[NSString stringWithFormat:@"%@",dic[@"name"]];
                model.pay_integer=[NSString stringWithFormat:@"%@",dic[@"payIntegral"]];
                model.pay_maney=[NSString stringWithFormat:@"%@",dic[@"payMoney"]];
                model.statu=[NSString stringWithFormat:@"%@",dic[@"status"]];
                [self.goodsDataSource addObject:model];
            }

            if (self.goodsDataSource.count>=self.totalCount&&(self.totalCount!=0)) {
                [_tableView.mj_header endRefreshing];
                [_tableView.mj_footer endRefreshingWithNoMoreData];
            }
            else
            {
                [_tableView.mj_header endRefreshing];
                [_tableView.mj_footer endRefreshing];
            }
        }else
        {
            [TrainToast showWithText:responseObj[@"message"] duration:2.0];
            [_tableView.mj_header endRefreshing];
            [_tableView.mj_footer endRefreshing];
            YLog(@"params=%@",params);
        }
        [_tableView reloadData];
        [hud dismiss:YES];
        UIButton *searchBut = [self.view viewWithTag:100];
        UIButton *editBut = [self.view viewWithTag:101];
        if (_goodsDataSource.count>0) {
            searchBut.hidden = NO;
            editBut.hidden = NO;
        }else
        {
            searchBut.hidden = YES;
            editBut.hidden = YES;
        }
    } faildBlock:^(NSError *error) {
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];
        [TrainToast showWithText:error.localizedDescription duration:2.0];
        [hud dismiss:YES];
    }];
}

/*****  获取店铺数据 *****/
-(void)getShopsData
{
    NSDictionary *params = @{@"sigen":[kUserDefaults objectForKey:@"sigen"],@"type":_selectIndex,@"name":_searchWord,@"page":[NSNumber numberWithInteger:self.shopsPage]};
    NSString *url = [NSString stringWithFormat:@"%@getCollectionList_mob.shtml",URL_Str];
    WKProgressHUD *hud=[WKProgressHUD showInView:self.view withText:nil animated:YES];
    [ATHRequestManager POST:url parameters:params successBlock:^(NSDictionary *responseObj) {
        YLog(@"responseobj = %@",responseObj);
        if ([responseObj[@"status"] isEqualToString:@"10000"]) {
            if (self.shopsPage==0) {
                [self.shopsDataSource removeAllObjects];
            }
            self.shopsPage++;

            for (NSDictionary *dic in responseObj[@"list"]) {
                MerchantModel *model = [[MerchantModel alloc] init];
                model.mid=[NSString stringWithFormat:@"%@",dic[@"gid"]];
                model.logo=[NSString stringWithFormat:@"%@",dic[@"logo"]];
                model.storename=[NSString stringWithFormat:@"%@",dic[@"name"]];
                model.status=[NSString stringWithFormat:@"%@",dic[@"status"]];
                model.collectionId=[NSString stringWithFormat:@"%@",dic[@"id"]];
                [self.shopsDataSource addObject:model];
            }

            if (self.shopsDataSource.count >= [responseObj[@"totalCount"] integerValue]&&(self.shopsDataSource.count!=0)) {
                [_tableView2.mj_header endRefreshing];
                [_tableView2.mj_footer endRefreshingWithNoMoreData];
            }else
            {
                [_tableView2.mj_header endRefreshing];
                [_tableView2.mj_footer endRefreshing];
            }
        }else
        {
        [_tableView2.mj_header endRefreshing];
        [_tableView2.mj_footer endRefreshing];
        }

        [_tableView2 reloadData];
        [hud dismiss:YES];
        if (!SELECTGOODS) {
            UIButton *searchBut = [self.view viewWithTag:100];
            UIButton *editBut = [self.view viewWithTag:101];
            if (_shopsDataSource.count>0) {
                searchBut.hidden=NO;
                editBut.hidden=NO;
            }else
            {
                searchBut.hidden=YES;
                editBut.hidden=YES;
            }
        }
    } faildBlock:^(NSError *error) {
        [_tableView2.mj_header endRefreshing];
        [_tableView2.mj_footer endRefreshing];
        [TrainToast showWithText:error.localizedDescription duration:2.0];
        [hud dismiss:YES];
    }];

}

#pragma mark - events

/*****  编辑 *****/
-(void)editButClick:(UIButton *)sender
{
    _isEdit=!_isEdit;
    if (_isEdit) {
        YLog(@"1234567890");
    }
    if (SELECTGOODS) {
        [_tableView reloadData];
    }else
    {
        [_tableView2 reloadData];
    }

}

/*****  监听改变的值 *****/
-(void)changeValue:(UITextField *)TextField
{

}

/*****  滑动切换 *****/
- (void)handleSwipes:(UISwipeGestureRecognizer *)sender
{
    if (sender.direction == UISwipeGestureRecognizerDirectionLeft) {

        if (SELECTGOODS) {
            [self shopsButtonClick:nil];
        }
    }
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        NSLog(@"右滑");
        if (!SELECTGOODS) {
            [self goodsButtonClick:nil];
        }
    }
}

/*****  切换成商铺收藏 *****/
-(void)shopsButtonClick:(UIButton *)sender
{
    self.selectIndex=@"2";
    if (!_shopsDataSource) {
        [self getdatas];
    }else
    {
        UIButton *searchBut = [self.view viewWithTag:100];
        UIButton *editBut = [self.view viewWithTag:101];
        if (_shopsDataSource.count>0) {
            searchBut.hidden = NO;
            editBut.hidden = NO;
        }else
        {
            searchBut.hidden = YES;
            editBut.hidden = YES;
        }
    }
    [_scroll setContentOffset:CGPointMake(kScreen_Width, 0) animated:YES];
}

/*****  切换成商品收藏 *****/
-(void)goodsButtonClick:(UIButton *)sender
{
    self.selectIndex=@"1";
    if (!_goodsDataSource) {
        [self getdatas];
    }else
    {
        UIButton *searchBut = [self.view viewWithTag:100];
        UIButton *editBut = [self.view viewWithTag:101];
        if (_goodsDataSource.count>0) {
            searchBut.hidden = NO;
            editBut.hidden = NO;
        }else
        {
            searchBut.hidden = YES;
            editBut.hidden = YES;
        }
    }
    [_scroll setContentOffset:CGPointZero animated:YES];
}

/*****  切换成搜索页面 *****/
-(void)searchButtonClick:(UIButton *)sender
{
    YLog(@"搜索");
    self.normalNavi.hidden=YES;
    self.searchNavi.hidden=NO;
    UITextField *textfield=[self.view viewWithTag:500];
    if (SELECTGOODS) {
        textfield.placeholder=@"搜索您收藏的商品";
    }else
    {
        textfield.placeholder=@"搜索您收藏的店铺";
    }
    [textfield becomeFirstResponder];

    if (SELECTGOODS) {
        _tempArrM=[self.goodsDataSource mutableCopy];
    }else
    {
        _tempArrM=[self.shopsDataSource mutableCopy];
    }

//    self.leftSwipeGestureRecognizer.enabled=NO;
//    self.rightSwipeGestureRecognizer.enabled=NO;
}

/*****  退出当前控制器 *****/
-(void)QurtBtnClick2
{
    [self.navigationController popViewControllerAnimated:NO];
}

#pragma mark - tableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger count=SELECTGOODS?self.goodsDataSource.count:self.shopsDataSource.count;
    if (count==0) {
        tableView.backgroundColor=[UIColor whiteColor];
    }else
    {
        tableView.backgroundColor=RGB(244, 244, 244);
    }
    return count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (SELECTGOODS) {
        XLGoodsCollectionCell *cell=[tableView dequeueReusableCellWithIdentifier:XLGoodsCollectionCellReuse];
        cell.dataModel=self.goodsDataSource[indexPath.row];
        [cell.selectBut addTarget:self action:@selector(selectButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        cell.selectBut.tag=2000+indexPath.row;
        cell.isEdit=_isEdit;
        return cell;
    }else
    {

        XLShopsCollectionCell *cell=[tableView dequeueReusableCellWithIdentifier:XLShopsCollectionCellReuse];
        cell.dataModel=self.shopsDataSource[indexPath.row];
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (SELECTGOODS) {

        AllSingleShoppingModel *model=self.goodsDataSource[indexPath.row];
        if ([model.statu isEqualToString:@"1"]) {

        }else
        {
        YTGoodsDetailViewController *vc=[[YTGoodsDetailViewController alloc] init];
        vc.gid=model.gid;
        [self.navigationController pushViewController:vc animated:NO];
        }
    }else
    {
        MerchantModel *model=self.shopsDataSource[indexPath.row];
        MerchantDetailViewController *vc=[[MerchantDetailViewController alloc] init];
        vc.mid=model.mid;
        [self.navigationController pushViewController:vc animated:NO];
    }
}


 -(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"取消收藏";
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (SELECTGOODS) {
        [self.goodsDataSource removeObjectAtIndex:indexPath.row];
        [_tableView deleteRowAtIndexPath:indexPath withRowAnimation:UITableViewRowAnimationAutomatic];
    }else
    {
        [self.shopsDataSource removeObjectAtIndex:indexPath.row];
        [_tableView2 deleteRowAtIndexPath:indexPath withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}


#pragma mark - textFiledDelegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
//    self.leftSwipeGestureRecognizer.enabled=YES;
//    self.rightSwipeGestureRecognizer.enabled=YES;
    SELECTGOODS?(self.goodsPage=0):(self.shopsPage=0);
    _searchWord=textField.text;

    if (SELECTGOODS) {
        [_tableView.ly_emptyView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [_tableView.ly_emptyView removeFromSuperview];
        _tableView.ly_emptyView=nil;
        _tableView.ly_emptyView=[MyDIYEmpty emptyActionViewWithImageStr:@"xl-img-empty" titleStr:@"" detailStr:@"" btnTitleStr:@"找不到商品哦，用其他关键字试试吧~" btnClickBlock:^{

        }];
    }else
    {
        [_tableView2.ly_emptyView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];

        [_tableView2.ly_emptyView removeFromSuperview];
        _tableView2.ly_emptyView=nil;

        _tableView2.ly_emptyView=[MyDIYEmpty emptyActionViewWithImageStr:@"xl-img-empty" titleStr:@"" detailStr:@"" btnTitleStr:@"找不到店铺哦，用其他关键字试试吧~" btnClickBlock:^{

        }];
    }
    [self getdatas];
    return YES;
}

#pragma mark - getter and setter
/*****  顶部选择框 *****/
-(void)setSelectIndex:(NSString *)selectIndex{
    _selectIndex=selectIndex;
    CGFloat butWidth=(kScreen_Width-57-40)/2;
    CGFloat x=(butWidth-51)/2+40;
    /*****  1为商品 2位商铺 *****/
    if ([_selectIndex isEqualToString:@"1"]) {
        UIButton *goodsBut=[self.view viewWithTag:200];
        UIButton *shopsBut=[self.view viewWithTag:201];
        UIView *sliderView=[self.view viewWithTag:300];
        goodsBut.userInteractionEnabled=NO;
        shopsBut.userInteractionEnabled=YES;
        [UIView animateWithDuration:0.2 animations:^{
            [goodsBut setTitleColor:RGB(255, 93, 94) forState:0];
            [shopsBut setTitleColor:RGB(51, 51, 51) forState:0];
            [sliderView setFrame:CGRectMake(x, KSafeAreaTopNaviHeight-3, 51, 3)];
        }];
    }else
    {
        UIButton *goodsBut=[self.view viewWithTag:200];
        UIButton *shopsBut=[self.view viewWithTag:201];
        UIView *sliderView=[self.view viewWithTag:300];
        goodsBut.userInteractionEnabled=YES;
        shopsBut.userInteractionEnabled=NO;
        [UIView animateWithDuration:0.2 animations:^{
            [goodsBut setTitleColor:RGB(51, 51, 51) forState:0];
            [shopsBut setTitleColor:RGB(255, 93, 94) forState:0];
            [sliderView setFrame:CGRectMake(x+butWidth, KSafeAreaTopNaviHeight-3, 51, 3)];
        }];
    }

}

/*****  导航栏 *****/
-(UIView *)normalNavi
{
    if (!_normalNavi) {
        _normalNavi = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, KSafeAreaTopNaviHeight)];
        _normalNavi.userInteractionEnabled=YES;
    }
    return _normalNavi;
}

/*****  <#desc#> *****/
-(UIView *)searchNavi
{
    if (!_searchNavi) {
        _searchNavi = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, KSafeAreaTopNaviHeight)];
    }
    return _searchNavi;
}

/*****  商品数据源 *****/
-(NSMutableArray *)goodsDataSource
{
    if (!_goodsDataSource) {
        _goodsDataSource = [[NSMutableArray alloc] init];
    }

    return _goodsDataSource;
}

/*****  商铺数据 *****/
-(NSMutableArray *)shopsDataSource
{
    if (!_shopsDataSource) {
        _shopsDataSource = [[NSMutableArray alloc] init];
    }

    return _shopsDataSource;
}

/*****  <#desc#> *****/
-(NSInteger)goodsPage
{
    if (!_goodsPage) {
        _goodsPage=0;
    }
    return _goodsPage;
}

/*****  <#desc#> *****/
-(NSInteger)shopsPage
{
    if (!_shopsPage) {
        _shopsPage=0;
    }
    return _shopsPage;
}

/*****  <#desc#> *****/
-(void)setInvalid_totalCount:(NSInteger)invalid_totalCount
{
    _invalid_totalCount=invalid_totalCount;
    UIButton *but=[self.view viewWithTag:400];
    if (_invalid_totalCount>0) {
        but.hidden=NO;
        [but setTitle:[NSString stringWithFormat:@"%ld\n件失效",_invalid_totalCount] forState:UIControlStateNormal];
    }else
    {
        but.hidden=YES;
    }
}

/*****  <#desc#> *****/
-(void)setIsSelectshop:(BOOL)isSelectshop
{
    _isSelectshop=isSelectshop;
    if (isSelectshop) {
        [self shopsButtonClick:nil];
    }else
    {
        [self goodsButtonClick:nil];
    }
}
@end
