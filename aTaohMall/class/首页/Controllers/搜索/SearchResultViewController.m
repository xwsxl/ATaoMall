//
//  SearchResultViewController.m
//  aTaohMall
//
//  Created by JMSHT on 16/5/18.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import "SearchResultViewController.h"

#import "ConverUtil.h"
#import "DESUtil.h"
#import "SecretCodeTool.h"

#import "AFNetworking.h"
#import "UIImageView+WebCache.h"

#import "SearchResultModel.h"

#import "SearchResultCell1.h"
#import "SearchResultCell2.h"
#import "SearchResultCell.h"

#import "NewGoodsDetailViewController.h"//商品详情

//刷新
#import "DJRefresh.h"
#import "DJRefreshProgressView.h"

#import "HomeLookFooter.h"//点击加载更多

#import "NoDataCell.h"

#import "WKProgressHUD.h"

#import "TimeModel.h"//倒计时model

#import "SearchManager.h"

#import "JRToast.h"

#import "YTSearchCell.h"

#import "YTGoodsDetailViewController.h"

#import "YTSearchOtherCell.h"

#import "XLShoppingCollectionCell.h"
#import "AllSingleShoppingModel.h"
#import "XLLookAllCollectionCell.h"

@interface SearchResultViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UITextFieldDelegate>
{
    NSString *_searchKeyWord;//顶部搜索词

    UICollectionView *_collectionView;
    NSMutableArray *_datasArrM;//搜索数据
    UIView *view;
    int flag;
    NSString *string10;
    NSInteger totalCount;
    BOOL IsShowGongGe;
}

@property(nonatomic,strong)UILabel *lable;//暂无数据

@end

@implementation SearchResultViewController
static NSString * const reuseIdentifier = @"XLShoppingCollectionCell";
static NSString * const reuseIdentifier1 = @"XLLookAllCollectionCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.frame=[UIScreen mainScreen].bounds;


    [self initData];
    [self initUI];

    //获取数据
    [self getDatas];
}

-(void)initData
{
    flag=1;

    _datasArrM=[NSMutableArray new];

}

-(void)initUI
{
    [self initNavi];

    //创建tableView
    [self initTableView];

}

-(void)initNavi
{
    self.searchResultTextField.returnKeyType = UIReturnKeySearch;//更改键盘的return
    self.searchResultTextField.delegate = self;

    NSString *str=_resultArrM.lastObject;
    //标题数据

    self.searchResultTextField.text=str;
    _searchKeyWord=str;

}

-(void)initview{
    
    _lable = [[UILabel alloc]initWithFrame:CGRectMake(0,[UIScreen mainScreen].bounds.size.height/10 , [UIScreen mainScreen].bounds.size.width, 80)];
    _lable.text = @"没有您要搜索的相关商品";
    _lable.tag = 100;
    _lable.textColor = [UIColor lightGrayColor];
    _lable.textAlignment = NSTextAlignmentCenter;
    self.view.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1];
    [self.view addSubview:_lable];
    
}

-(void)initTableView
{


    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight, kScreen_Width, kScreen_Height-KSafeAreaTopNaviHeight) collectionViewLayout:flowLayout];
    _collectionView.backgroundColor=[UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1.0];
    //去掉右侧滚动条
    _collectionView.showsVerticalScrollIndicator=NO;
    _collectionView.delegate=self;
    _collectionView.dataSource=self;
    [_collectionView registerClass:[XLShoppingCollectionCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [_collectionView registerClass:[XLLookAllCollectionCell class] forCellWithReuseIdentifier:reuseIdentifier1];

    [self.view addSubview:_collectionView];

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
    

    
}

-(void)NoWebSeveice
{
    if (view) {
        view.hidden=NO;
        return;
    }
    view=[[UIView alloc] initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    
    view.backgroundColor=[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];
    
    [self.view addSubview:view];
    
    
    UIImageView *image=[[UIImageView alloc] initWithFrame:CGRectMake((view.frame.size.width-82)/2, 100, 82, 68)];
    
    image.image=[UIImage imageNamed:@"网络连接失败"];
    
    [view addSubview:image];
    
    
    UILabel *label1=[[UILabel alloc] initWithFrame:CGRectMake(100, 180, view.frame.size.width-200, 20)];
    
    label1.text=@"网络连接失败";
    
    label1.textAlignment=NSTextAlignmentCenter;
    
    label1.font=[UIFont fontWithName:@"PingFangSC-Medium" size:15];
    
    label1.textColor=[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    
    [view addSubview:label1];
    
    
    UILabel *label2=[[UILabel alloc] initWithFrame:CGRectMake(100, 210, view.frame.size.width-200, 20)];
    
    label2.text=@"请检查你的网络";
    
    label2.textAlignment=NSTextAlignmentCenter;
    
    label2.font=[UIFont fontWithName:@"PingFangSC-Medium" size:12];
    
    label2.textColor=[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    
    [view addSubview:label2];
    
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    
    button.frame=CGRectMake(100, 250, view.frame.size.width-200, 50);
    
    [button setTitle:@"重新加载" forState:0];
    button.titleLabel.font=[UIFont fontWithName:@"PingFangSC-Medium" size:12];
    [button setTitleColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0] forState:0];
    
    [view addSubview:button];
    
    [button addTarget:self action:@selector(loadData) forControlEvents:UIControlEventTouchUpInside];
    
}


//上拉加载更多
-(void)loadMoreData
{
    if (totalCount==_datasArrM.count) {
        [_collectionView.mj_footer endRefreshingWithNoMoreData];
    }else
    {
        [self getDatas];
    }
}
//下拉刷新数据
-(void)refreshData
{

    flag=1;
    [self getDatas];

}

-(void)getDatas
{

    WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@getGoodsByWord_mob.shtml",URL_Str];
    
    NSDictionary *dic = @{@"word":_searchKeyWord,@"flag":[NSString stringWithFormat:@"%d",flag]};
    
    [manager POST:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
        NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];
        if (codeKey && content) {
            flag=flag+1;
            NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
            
            NSLog(@"xmlStr=%@",xmlStr);
            
            
            NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];
            
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            
            NSLog(@"=====搜索结果===%@",dic);
            
            view.hidden=YES;
            for (NSDictionary *dict1 in dic) {
                
                for (NSDictionary *dict2 in dict1[@"list_goods"]) {
                    
                    totalCount = [[NSString stringWithFormat:@"%@",dict1[@"totalCount"]] integerValue];
                    
                    AllSingleShoppingModel *model=[[AllSingleShoppingModel alloc] init];

                    model.amount = [NSString stringWithFormat:@"%@",dict2[@"amount"]];
                    model.ID=[NSString stringWithFormat:@"%@",dict2[@"id"]];

                    
                    
                    model.name=[NSString stringWithFormat:@"%@",dict2[@"name"]];
                    model.pay_integer=[NSString stringWithFormat:@"%@",dict2[@"pay_integer"]];
                    model.pay_maney=[NSString stringWithFormat:@"%@",dict2[@"pay_maney"]];
                    model.scopeimg=[NSString stringWithFormat:@"%@",dict2[@"scopeimg"]];

                    //赋值
                    model.is_attribute = [NSString stringWithFormat:@"%@",dict2[@"is_attribute"]];

                    model.storename = [NSString stringWithFormat:@"%@",dict2[@"storename"]];

                    [_datasArrM addObject:model];

                }
            }
            if (_datasArrM.count==0) {
                [self initview];
            }else
            {
                _lable.hidden=YES;
                [_collectionView.mj_header endRefreshing];
                [_collectionView.mj_footer endRefreshing];
                //刷新数据
                [_collectionView reloadData];
            }
            [hud dismiss:YES];

            
        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        [_collectionView.mj_header endRefreshing];
        [_collectionView.mj_footer endRefreshing];
        [self NoWebSeveice];
        [hud dismiss:YES];
    }];
}

-(void)loadData
{
    
    view.hidden=YES;

    
    [self getDatas];
}

#pragma mark - collectionView的代理方法
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _datasArrM.count;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (!IsShowGongGe) {
        return CGSizeMake(kScreenWidth, Width(145));
    }else
    {
        CGFloat WWW=([UIScreen mainScreen].bounds.size.width-Width(18))/2;
        CGFloat HHH=WWW+5*Height(7)+39+26+1+10;
        return CGSizeMake(WWW, HHH);
    }

}

//最小行间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    if (!IsShowGongGe) {
        return 0;
    }else
    {
        return Width(6);
    }
}
//最小行内部cell的间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    if (!IsShowGongGe) {
        return 0;
    }else
    {
        return Width(3);
    }
}

//section的边距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{

    if (!IsShowGongGe) {
        return UIEdgeInsetsMake(Width(10), 0, 0, 0  );
    }
    //上,左,下,右
    else{
        return UIEdgeInsetsMake(Width(10), Width(6), Width(6), Width(6));
    }
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (!IsShowGongGe) {
        XLLookAllCollectionCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier1 forIndexPath:indexPath];
        cell.model=_datasArrM[indexPath.row];
        return cell;
    }else
    {
        XLShoppingCollectionCell *cell1=[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
        AllSingleShoppingModel *model=_datasArrM[indexPath.row];

        [cell1 SetDataWithImgUrl:model.scopeimg GoodsName:model.name StoreName:model.storename priceStr:model.pay_maney Interger:model.pay_integer stock:@"1"];
        return cell1;
    }
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    AllSingleShoppingModel *model=_datasArrM[indexPath.row];

    YTGoodsDetailViewController *vc=[[YTGoodsDetailViewController alloc] init];
    vc.good_type=model.type_name;
    vc.gid=model.gid;
    vc.type=@"1";
    vc.attribute = model.is_attribute;
    vc.ID=model.ID;
    [self.navigationController pushViewController:vc animated:NO];

}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.text.length == 0) {
        [JRToast showWithText:@"输入的搜索内容不能为空!" duration:0.5f];
    }else{
        flag=1;
        _searchKeyWord=self.searchResultTextField.text;
        [self getDatas];
        if (_delegate &&[_delegate respondsToSelector:@selector(searchNewInformation:)]) {
            [_delegate searchNewInformation:_searchKeyWord];
        }
    }
    [textField resignFirstResponder];
    return YES;
}
- (IBAction)clickGongGeBtn:(UIButton *)sender {
    IsShowGongGe=!IsShowGongGe;
    if (IsShowGongGe) {
        [sender setImage:KImage(@"xl-btn-change") forState:UIControlStateNormal];
    }else
    {
        [sender setImage:KImage(@"xl-btn-change2") forState:UIControlStateNormal];
    }
    [_collectionView reloadData];
}


//返回
- (IBAction)backBtnClick:(UIButton *)sender {

    //    self.searchResultTextField.text = @"";
    [self.navigationController popViewControllerAnimated:YES];

}

@end
