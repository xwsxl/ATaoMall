//
//  HomeBigHealthyVC.m
//  aTaohMall
//
//  Created by Hawky on 2017/11/9.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "HomeBigHealthyVC.h"
#import "FristHomeCell.h"
#import "HomeCell1.h"
#import "HomeModel2.h"
#import "HomeLittleAppliancesCell.h"
#import "YTGoodsDetailViewController.h"
#import "WKProgressHUD.h"
@interface HomeBigHealthyVC ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSInteger page;
    UICollectionView *_collectionView;
    UIButton *_zhiding;
    NSInteger cellHeight;
    NSInteger totalCount;
}

@property (nonatomic,strong)NSMutableArray *dataSource;

@end

@implementation HomeBigHealthyVC

-(void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden=YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    page=0;
    [self SetUI];
    [self getDatasWithPage];
}

-(void)gotoYT
{
    [_collectionView setContentOffset:CGPointZero animated:YES];
}

-(void)SetUI
{
    [self initNavi];
    cellHeight = ([UIScreen mainScreen].bounds.size.height)/2.8;
 //   float fWidth = [UIScreen mainScreen].bounds.size.width;
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight, kScreen_Width, kScreen_Height-KSafeAreaTopNaviHeight) collectionViewLayout:flowLayout];
    _collectionView.backgroundColor=[UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1.0];
    //去掉右侧滚动条
    _collectionView.showsVerticalScrollIndicator=NO;
    _collectionView.delegate=self;
    _collectionView.dataSource=self;
    //  _collectionView.scrollEnabled=NO;
    [_collectionView registerClass:[HomeLittleAppliancesCell class] forCellWithReuseIdentifier:@"Home"];
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    [footer setTitle:@"" forState:MJRefreshStateIdle];
    [footer setTitle:@"正在加载..." forState:MJRefreshStateRefreshing];
    [footer setTitle:@"没有更多数据" forState:MJRefreshStateNoMoreData];
    _collectionView.mj_footer = footer;
    [self.view addSubview:_collectionView];

    _zhiding=[UIButton buttonWithType:UIButtonTypeCustom];
    _zhiding.hidden=YES;
    _zhiding.frame=CGRectMake(self.view.frame.size.width-44, self.view.frame.size.height-120, 44, 44);

    [_zhiding setBackgroundImage:[UIImage imageNamed:@"置顶"] forState:0];
    _zhiding.layer.masksToBounds = YES;
    _zhiding.layer.cornerRadius = _zhiding.bounds.size.width*0.5;

    [_zhiding addTarget:self action:@selector(gotoYT) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:_zhiding];
}
- (void)loadMoreData {

    if (totalCount<=_dataSource.count) {
        [_collectionView.mj_footer endRefreshingWithNoMoreData];
        return;
    }
    WKProgressHUD *hud=[WKProgressHUD showInView:self.view withText:nil animated:YES];
    NSDictionary *params=@{@"page":[NSString stringWithFormat:@"%ld",page]};
    [ATHRequestManager requestforGetMoreBigHeathyListWithParams:params successBlock:^(NSDictionary *responseObj) {
        totalCount=[[NSString stringWithFormat:@"%@",responseObj[@"total_count"]] integerValue];
        page++;
        [hud dismiss:YES];
        if (![responseObj[@"status"] isEqualToString:@"10000"]) {
            [TrainToast showWithText:responseObj[@"message"] duration:2.0];
            [_collectionView.mj_footer endRefreshingWithNoMoreData];
            return ;
        }
       //   [self.dataSource removeAllObjects];
        for (NSDictionary *dic in responseObj[@"list"]) {
            HomeModel2 *model=[[HomeModel2 alloc]init];
            model.name=[NSString stringWithFormat:@"%@",dic[@"name"]];
            model.amount=[NSString stringWithFormat:@"%@",dic[@"amount"]];
            model.gid=[NSString stringWithFormat:@"%@",dic[@"gid"]];
            model.ID=[NSString stringWithFormat:@"%@",dic[@"id"]];
            model.attribute=[NSString stringWithFormat:@"%@",dic[@"is_attribute"]];
            model.mid=[NSString stringWithFormat:@"%@",dic[@"mid"]];
            model.pay_integer=[NSString stringWithFormat:@"%@",dic[@"pay_integer"]];
            model.pay_maney=[NSString stringWithFormat:@"%@",dic[@"pay_maney"]];
            model.scopeimg=[NSString stringWithFormat:@"%@",dic[@"scopeimg"]];
            model.storename=[NSString stringWithFormat:@"%@",dic[@"storename"]];
            model.stock=[NSString stringWithFormat:@"%@",dic[@"stocks"]];
            model.good_type=[NSString stringWithFormat:@"%@",dic[@"good_type"]];
            [_dataSource addObject:model];
        }
        [_collectionView.mj_footer endRefreshing];
        NSLog(@"%ld",_dataSource.count);
        [_collectionView reloadData];
    } faildBlock:^(NSError *error) {
        [hud dismiss:YES];
    }];
}

-(void)getDatasWithPage
{
    WKProgressHUD *hud=[WKProgressHUD showInView:self.view withText:nil animated:YES];
    NSDictionary *params=@{@"page":[NSString stringWithFormat:@"%ld",page]};
    [ATHRequestManager requestforGetMoreBigHeathyListWithParams:params successBlock:^(NSDictionary *responseObj) {
        [hud dismiss:YES];
        if (![responseObj[@"status"] isEqualToString:@"10000"]) {
            [TrainToast showWithText:responseObj[@"message"] duration:2.0];
            return ;
        }
        totalCount=[responseObj[@"total_count"] integerValue];
        page++;
        [self.dataSource removeAllObjects];
        for (NSDictionary *dic in responseObj[@"list"]) {
            HomeModel2 *model=[[HomeModel2 alloc]init];
            model.name=[NSString stringWithFormat:@"%@",dic[@"name"]];
            model.amount=[NSString stringWithFormat:@"%@",dic[@"amount"]];
            model.gid=[NSString stringWithFormat:@"%@",dic[@"gid"]];
            model.ID=[NSString stringWithFormat:@"%@",dic[@"id"]];
            model.attribute=[NSString stringWithFormat:@"%@",dic[@"is_attribute"]];
            model.mid=[NSString stringWithFormat:@"%@",dic[@"mid"]];
            model.pay_integer=[NSString stringWithFormat:@"%@",dic[@"pay_integer"]];
            model.pay_maney=[NSString stringWithFormat:@"%@",dic[@"pay_maney"]];
            model.scopeimg=[NSString stringWithFormat:@"%@",dic[@"scopeimg"]];
            model.storename=[NSString stringWithFormat:@"%@",dic[@"storename"]];
            model.stock=[NSString stringWithFormat:@"%@",dic[@"stocks"]];
            model.good_type=[NSString stringWithFormat:@"%@",dic[@"good_type"]];
            [_dataSource addObject:model];
        }



        YLog(@"%@",responseObj[@"message"]);
        if (_dataSource.count==0) {
          //  _collectionView.scrollEnabled=NO;
            _collectionView.hidden=YES;
            UILabel *lab=[[UILabel alloc] init];
            [lab setText:@"暂无相关数据"];
            [lab setFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
            [lab setTextAlignment:NSTextAlignmentCenter];
            [lab setTextColor:RGB(102, 102, 102)];
            [self.view addSubview: lab];
        }else
        {
        [_collectionView setHidden:NO];
        [_collectionView reloadData];
        }
    } faildBlock:^(NSError *error) {
        [hud dismiss:YES];
    }];
}

#pragma mark - collectionView的代理方法
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{

    return CGSizeMake(([UIScreen mainScreen].bounds.size.width-2)/2-4, ([UIScreen mainScreen].bounds.size.height)/2.7);

}

//最小行间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 5;
}
//最小行内部cell的间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

//section的边距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    //上,左,下,右
    return UIEdgeInsetsMake(8, 0, 10, 0);
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    HomeLittleAppliancesCell *cell1=[collectionView dequeueReusableCellWithReuseIdentifier:@"Home" forIndexPath:indexPath];
    if (!(_dataSource.count==0)) {
        HomeModel2 *model=_dataSource[indexPath.row];
        cell1.status = model.status;//判断是否售完
        cell1.stock = model.stock;
        cell1.StrorenameLabel.text = model.storename;

        [cell1.GoodsImageView sd_setImageWithURL:[NSURL URLWithString:model.scopeimg] placeholderImage:[UIImage imageNamed:@"default_image"] options:SDWebImageProgressiveDownload];
        cell1.GoodsNameLabel.text=model.name;
        cell1.GoodsAmountLabel.text=[NSString stringWithFormat:@"%@人付款",model.amount];
        cell1.GoodsPriceLabel.text=[NSString stringWithPrice:model.pay_maney andInterger:model.pay_integer];
        cell1.GoodsPriceLabel.textColor=RGB(255, 82, 82);
        
    }

    return cell1;

}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    HomeModel2 *model=_dataSource[indexPath.row];
    NSString *attribute = @"";
    YTGoodsDetailViewController *vc=[[YTGoodsDetailViewController alloc] init];
    vc.good_type=model.good_type;
    //    vc.gid=gid;
    vc.gid=model.ID;
    vc.type=@"1";
    vc.attribute = attribute;
    //    vc.ID=gid;
    vc.ID=model.ID;
    YLog(@"id=%@,gid=%@,good_type=%@,indexpath.row=%ld",model.ID,model.gid,model.good_type,indexPath.row);

    self.navigationController.navigationBar.hidden=YES;
    self.tabBarController.tabBar.hidden=YES;
    [self.navigationController pushViewController:vc animated:NO];

}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //========//
    //使用偏移量获取当前的页
    NSInteger currentPage = scrollView.contentOffset.y / [UIScreen mainScreen].bounds.size.height;


    if (currentPage >= 1) {


        _zhiding.hidden=NO;

    }else{

        _zhiding.hidden=YES;

    }

}

-(void)initNavi
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

    UILabel  *Titlelabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 25+KSafeTopHeight, [UIScreen mainScreen].bounds.size.width-200, 30)];

    Titlelabel.text = @"大健康专区";

    Titlelabel.textColor = [UIColor blackColor];

    Titlelabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:19];

    Titlelabel.textAlignment = NSTextAlignmentCenter;

    [titleView addSubview:Titlelabel];

}

-(void)QurtBtnClick{

    [self.navigationController popViewControllerAnimated:YES];
    //  self.tabBarController.tabBar.hidden=NO;
}

-(NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource=[[NSMutableArray alloc]init];
    }
    return _dataSource;
}

@end

