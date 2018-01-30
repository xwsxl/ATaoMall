//
//  HomeLatestGoodsListVC.m
//  aTaohMall
//
//  Created by Hawky on 2017/12/29.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "HomeLatestGoodsListVC.h"
#import "YTGoodsDetailViewController.h"
#import "AllSingleShoppingModel.h"

#import "XLNaviVIew.h"
#import "XLTopSelectScroll.h"
#import "XLShoppingCollectionCell.h"
#import "XLNoDataView.h"

@interface HomeLatestGoodsListVC ()<UICollectionViewDelegate,UICollectionViewDataSource,XLNaviViewDelegate>
{
    XLNaviView *Navi;
    XLNoDataView   *noDataView;
    UICollectionView *_collectionView;
    UIView *Backview;

    NSInteger _page;
    NSInteger totalCount;
    NSInteger stutasIndex;
}

@property (nonatomic,strong)NSMutableArray *dataSource;



@end

@implementation HomeLatestGoodsListVC

static NSString * const reuseIdentifier = @"XLShoppingCollectionCell";
static NSString *headerViewIdentifier =@"hederview";


/*******************************************************      控制器生命周期       ******************************************************/
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:RGB(244, 244, 244)];
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
    [ATHRequestManager requestforgetLatestGoodsListWithParams:params successBlock:^(NSDictionary *responseObj) {

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
          //  [self initTop];
            if (!_collectionView) {
            [self SetCollectionView];
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
    [self initNavi];
   // [self SetCollectionView];
    //[self initTop];

}
//
-(void)initTop
{

    CGFloat toprigin=Height(5);
    CGFloat top=Height(10);
    CGFloat left=Width(10);


    CGFloat height=0;
    if (Backview) {
        return;
    }
    Backview=[[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, Height(10)+15+Height(10)+125+Height(10)+112+Height(5)+14+Height(10))];
    [Backview setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:Backview];
    Backview.userInteractionEnabled=YES;
    UIView *redview=[[UIView alloc] initWithFrame:CGRectMake(Width(10), Height(11), 3, 13)];
    [redview setBackgroundColor:RGB(255, 74, 74)];
    [Backview addSubview:redview];

    UILabel *titleLab=[[UILabel alloc] initWithFrame:CGRectMake(Width(15)+3, Height(10), 120, 15)];
    titleLab.text=@"最近新品";
    titleLab.textColor=RGB(51, 51, 51);
    titleLab.font=KNSFONTM(15);
    [Backview addSubview:titleLab];

    height+=Height(20)+15;
    AllSingleShoppingModel *model=self.dataSource[0];
    UIImageView *goodsIV=[[UIImageView alloc] initWithFrame:CGRectMake(Width(10), height, 125, 125)];
    [goodsIV sd_setImageWithURL:KNSURL(model.scopeimg) placeholderImage:KImage(@"default_image") options:SDWebImageProgressiveDownload];
    [Backview addSubview:goodsIV];

    UILabel *goodsNameLab=[[UILabel alloc] initWithFrame:CGRectMake(Width(20)+125, height, kScreenWidth-Width(30)-125, 44)];
    goodsNameLab.text=model.name;
    goodsNameLab.textColor=RGB(51, 51, 51);
    goodsNameLab.font=KNSFONT(15);
    goodsNameLab.numberOfLines=2;
    [Backview addSubview:goodsNameLab];

    UILabel *priceLab=[[UILabel alloc] initWithFrame:CGRectMake(Width(20)+125, height +Height(20)+39, kScreenWidth-Width(30)-125, 15)];
    priceLab.text=[NSString stringWithFormat:@"￥%@+%@积分",model.pay_maney,model.pay_integer];
    priceLab.textColor=RGB(243, 73, 73);
    priceLab.font=KNSFONT(15);
    [Backview addSubview:priceLab];

    UILabel *storeNameLab=[[UILabel alloc] initWithFrame:CGRectMake(Width(20)+125, height+125-13, kScreenWidth-Width(30)-125-100, 15)];
    storeNameLab.text=model.storename;
    storeNameLab.textColor=RGB(153, 153, 153);
    storeNameLab.font=KNSFONT(13);
    [Backview addSubview:storeNameLab];

    UILabel *numLab=[[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth-Width(10)-100, height+125-13, 100, 13)];
    numLab.text=[NSString stringWithFormat:@"%@人付款",model.amount];
    numLab.textColor=RGB(153, 153, 153);
    numLab.font=KNSFONT(13);
    numLab.textAlignment=NSTextAlignmentRight;
    [Backview addSubview:numLab];

    UIButton *goodsBut=[UIButton buttonWithType:UIButtonTypeCustom];
    goodsBut.frame=CGRectMake(0, height, kScreenWidth, 125);
    goodsBut.tag=1000;
    [goodsBut addTarget:self action:@selector(checkGoodsDetail:) forControlEvents:UIControlEventTouchUpInside];
    [Backview addSubview:goodsBut];


    height+=125+Height(10);

    for (int i=1; i<4; i++) {

        CGFloat marin=(kScreenWidth-112*3-Width(20))/2;
        AllSingleShoppingModel *model=self.dataSource[i];

        UIImageView *iv=[[UIImageView alloc] initWithFrame:CGRectMake(left+(112+marin)*(i-1), height, 112, 112)];
        [iv sd_setImageWithURL:KNSURL(model.scopeimg) placeholderImage:KImage(@"default_image") options:SDWebImageProgressiveDownload];
        [Backview addSubview:iv];

        iv.userInteractionEnabled=YES;

        UILabel *priceLab=[[UILabel alloc] initWithFrame:CGRectMake(left+(112+marin)*(i-1), height+112+Height(5), 112, 14)];
        priceLab.text=[NSString stringWithFormat:@"￥%@+%@积分",model.pay_maney,model.pay_integer];
        priceLab.textColor=RGB(243, 73, 73);
        priceLab.font=KNSFONT(14);
        [Backview addSubview:priceLab];

        UIButton *goodsBut1=[UIButton buttonWithType:UIButtonTypeCustom];
        [goodsBut1 setFrame:CGRectMake(left+(112+marin)*(i-1), height, 112, 112+Height(5)+14)];
        goodsBut1.tag=1000+i;
        [goodsBut1 addTarget:self action:@selector(checkGoodsDetail:) forControlEvents:UIControlEventTouchUpInside];
        [Backview addSubview:goodsBut1];
    }

}

-(void)initNoDataView
{
    _collectionView.hidden=YES;
    if (noDataView) {
        noDataView.hidden=NO;
        return;
    }

    noDataView=[[XLNoDataView alloc] initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight, kScreen_Width, kScreen_Height-KSafeAreaTopNaviHeight-KSafeAreaBottomHeight) AndMessage:nil ImageName:nil];
    [self.view addSubview:noDataView];

}

//初始化导航栏
-(void)initNavi
{
    Navi=[[XLNaviView alloc] initWithMessage:@"最近新品" ImageName:@""];
    Navi.delegate=self;
    [self.view addSubview:Navi];
}

//初始化collectionview
-(void)SetCollectionView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.headerReferenceSize=CGSizeMake(kScreenWidth, Height(10)+15+Height(10)+125+Height(10)+112+Height(5)+14+Height(10));
    _collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight+Height(5), kScreen_Width, kScreen_Height-KSafeAreaTopNaviHeight-Height(5)) collectionViewLayout:flowLayout];
    _collectionView.backgroundColor=[UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1.0];
    //去掉右侧滚动条
    _collectionView.showsVerticalScrollIndicator=NO;
    _collectionView.delegate=self;
    _collectionView.dataSource=self;
    [_collectionView registerClass:[XLShoppingCollectionCell class] forCellWithReuseIdentifier:reuseIdentifier];
    //注册头视图
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerViewIdentifier];
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

-(void)checkGoodsDetail:(UIButton *)sender
{

    AllSingleShoppingModel *model=self.dataSource[sender.tag-1000];

    YTGoodsDetailViewController *vc=[[YTGoodsDetailViewController alloc] init];
    vc.good_type=model.type_name;
    //    vc.gid=gid;
    vc.gid=model.gid;
    vc.type=@"1";
    vc.attribute = model.is_attribute;
    vc.ID=model.ID;

    [self.navigationController pushViewController:vc animated:NO];

}


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
    return self.dataSource.count-4;
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
    AllSingleShoppingModel *model=self.dataSource[indexPath.row+4];

    [cell1 SetDataWithImgUrl:model.scopeimg GoodsName:model.name StoreName:model.storename priceStr:model.pay_maney Interger:model.pay_integer stock:@"1"];
    return cell1;

}

//  返回头视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    //如果是头视图
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView *header=[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headerViewIdentifier forIndexPath:indexPath];
        //添加头视图的内容
        [self initTop];
        //头视图添加view
        [header addSubview:Backview];
        header.userInteractionEnabled=YES;
        return header;
    }

    return nil;
}



-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    AllSingleShoppingModel *model=self.dataSource[indexPath.row+4];

    YTGoodsDetailViewController *vc=[[YTGoodsDetailViewController alloc] init];
    vc.good_type=model.type_name;
    //    vc.gid=gid;
    vc.gid=model.ID;
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


