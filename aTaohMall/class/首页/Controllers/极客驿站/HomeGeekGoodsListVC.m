//
//  HomeGeekGoodsListVC.m
//  aTaohMall
//
//  Created by Hawky on 2017/12/29.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "HomeGeekGoodsListVC.h"
#import "YTGoodsDetailViewController.h"
#import "AllSingleShoppingModel.h"

#import "XLNaviVIew.h"
#import "XLTopSelectScroll.h"
#import "XLShoppingCollectionCell.h"
#import "XLNoDataView.h"

@interface HomeGeekGoodsListVC ()<UICollectionViewDelegate,UICollectionViewDataSource,XLNaviViewDelegate>
{
    XLNaviView *Navi;
    XLNoDataView   *noDataView;
    UICollectionView *_collectionView;


    NSInteger _page;
    NSInteger totalCount;
    NSInteger stutasIndex;
}

@property (nonatomic,strong)NSMutableArray *dataSource;



@end

@implementation HomeGeekGoodsListVC

static NSString * const reuseIdentifier = @"XLShoppingCollectionCell";

/*******************************************************      控制器生命周期       ******************************************************/
- (void)viewDidLoad {
    [super viewDidLoad];
    [self SetUI];
    [self SetData];
    if (@available(iOS 11.0, *)) {

    } else {
        self.automaticallyAdjustsScrollViewInsets =NO;
    }
}
/*******************************************************      数据请求       ******************************************************/
//初始化数据
-(void)SetData
{
    [self refreshData];
}



//上拉加载更多
-(void)loadMoreData
{
    if (totalCount==_dataSource.count) {
        [_collectionView.mj_footer endRefreshingWithNoMoreData];
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
    [ATHRequestManager requestforgetGeekPostGoodsListWithParams:params successBlock:^(NSDictionary *responseObj) {

        if ([responseObj[@"status"] isEqualToString:@"10000"]) {
            _page++;
            totalCount=[[NSString stringWithFormat:@"%@",responseObj[@"total_count"]] integerValue];
            NSArray *temp=responseObj[@"list"];
            for (NSDictionary *dic in temp) {
                AllSingleShoppingModel *model=[[AllSingleShoppingModel alloc] init];

                model.ID=[NSString stringWithFormat:@"%@",dic[@"id"]];

                model.mid=[NSString stringWithFormat:@"%@",dic[@"mid"]];

                model.money=[NSString stringWithFormat:@"%@",dic[@"money"]];

                model.product_address=[NSString stringWithFormat:@"%@",dic[@"product_address"]];

                model.state=[NSString stringWithFormat:@"%@",dic[@"state"]];

                model.amount=[NSString stringWithFormat:@"%@",dic[@"amount"]];

                model.syadate=[NSString stringWithFormat:@"%@",dic[@"syadate"]];

                model.is_attribute=[NSString stringWithFormat:@"%@",dic[@"is_attribute"]];

                model.storename=[NSString stringWithFormat:@"%@",dic[@"storename"]];

                model.type_name=[NSString stringWithFormat:@"%@",dic[@"type_name"]];

                model.gid=[NSString stringWithFormat:@"%@",dic[@"gid"]];

                model.pay_integer=[NSString stringWithFormat:@"%@",dic[@"pay_integer"]];

                model.pay_maney=[NSString stringWithFormat:@"%@",dic[@"pay_maney"]];

                model.scopeimg=[NSString stringWithFormat:@"%@",dic[@"scopeimg"]];

                model.floor=[NSString stringWithFormat:@"%@",dic[@"floor"]];

                model.picture_address=[NSString stringWithFormat:@"%@",dic[@"picture_address"]];

                model.createdate=[NSString stringWithFormat:@"%@",dic[@"createdate"]];

                model.name=[NSString stringWithFormat:@"%@",dic[@"name"]];

                model.sequence=[NSString stringWithFormat:@"%@",dic[@"sequence"]];

                [self.dataSource addObject:model];
            }

            if (self.dataSource.count==0) {
                [self initNoDataView];
            }else
            {

                if (noDataView) {
                    noDataView.hidden=YES;
                }
                _collectionView.hidden=NO;
                [_collectionView reloadData];
            }
        }else
        {

            [TrainToast showWithText:responseObj[@"message"] duration:2.0];

        }
        [hud dismiss:YES];
        [_collectionView.mj_header endRefreshing];
        [_collectionView.mj_footer endRefreshing];

    } faildBlock:^(NSError *error) {
        [hud dismiss:YES];
        [_collectionView.mj_header endRefreshing];
        [_collectionView.mj_footer endRefreshing];

    }];





}

/*******************************************************      初始化视图       ******************************************************/
//初始化
-(void)SetUI
{
  //  [self initNavi];
    [self SetCollectionView];
    [self initTop];

}


//
-(void)initTop
{

    UIImageView *imgIV=[[UIImageView alloc] initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight, kScreenWidth, Width(155))];
    [imgIV setImage:KImage(@"xlhome-Geek")];
    [self.view addSubview:imgIV];

}

-(void)initNoDataView
{
    _collectionView.hidden=YES;
    if (noDataView) {
        noDataView.hidden=NO;
        return;
    }

    noDataView=[[XLNoDataView alloc] initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight+Width(155), kScreen_Width, kScreen_Height-KSafeAreaTopNaviHeight-Width(155)-KSafeAreaBottomHeight) AndMessage:nil ImageName:nil];
    [self.view addSubview:noDataView];

}

-(void)setNaviTitle:(NSString *)naviTitle
{
    _naviTitle=naviTitle;
    [self initNavi];
}

//初始化导航栏
-(void)initNavi
{

    Navi=[[XLNaviView alloc] initWithMessage:_naviTitle ImageName:@""];
    Navi.delegate=self;
    [self.view addSubview:Navi];
}

//初始化collectionview
-(void)SetCollectionView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight+Width(155), kScreen_Width, kScreen_Height-KSafeAreaTopNaviHeight-Width(155)) collectionViewLayout:flowLayout];
    _collectionView.backgroundColor=[UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1.0];
    //去掉右侧滚动条
    _collectionView.showsVerticalScrollIndicator=NO;
    _collectionView.delegate=self;
    _collectionView.dataSource=self;
    [_collectionView registerClass:[XLShoppingCollectionCell class] forCellWithReuseIdentifier:reuseIdentifier];
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    [footer setTitle:@"" forState:MJRefreshStateIdle];
    [footer setTitle:@"正在加载..." forState:MJRefreshStateRefreshing];
    [footer setTitle:@"暂无更多数据" forState:MJRefreshStateNoMoreData];
    _collectionView.mj_footer = footer;

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

    _collectionView.mj_header=header;
    [self.view addSubview:_collectionView];
}
/*******************************************************      各种button执行方法、页面间的跳转       ******************************************************/




/*******************************************************      协议方法       ******************************************************/
#pragma mark-navi
//返回上一级页面
-(void)QurtBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - collectionView的代理方法
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat WWW=([UIScreen mainScreen].bounds.size.width-Width(18))/2;
    CGFloat HHH=WWW+5*Height(7)+39+26+1+10;
    return CGSizeMake(WWW, HHH);

}

//最小行间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return Width(6);
}
//最小行内部cell的间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return Width(3);
}

//section的边距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    //上,左,下,右
    return UIEdgeInsetsMake(Width(6), Width(6), Width(6), Width(6));
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    XLShoppingCollectionCell *cell1=[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    AllSingleShoppingModel *model=self.dataSource[indexPath.row];

    [cell1 SetDataWithImgUrl:model.scopeimg GoodsName:model.name StoreName:model.storename priceStr:model.pay_maney Interger:model.pay_integer stock:@"1"];
    return cell1;

}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
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

