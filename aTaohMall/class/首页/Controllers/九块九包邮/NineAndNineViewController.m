//
//  NineAndNineViewController.m
//  aTaohMall
//
//  Created by 阳涛 on 16/5/14.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import "NineAndNineViewController.h"

#import "NineNineCell.h"

#import "AFNetworking.h"

#import "NineModel.h"

#import "UIImageView+WebCache.h"

//加密
#import "DESUtil.h"
#import "ConverUtil.h"
#import "SecretCodeTool.h"


#import "NewGoodsDetailViewController.h"//商品详情


#import "CollectionFooterView.h"


#import "WKProgressHUD.h"

#import "NineFooterView.h"

//刷新
#import "DJRefresh.h"
#import "DJRefreshProgressView.h"

#import "XSInfoView.h"

#import "NoCollectionViewCell.h"

#import "YTGoodsDetailViewController.h"
@interface NineAndNineViewController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate,FooterViewDelegate,DJRefreshDelegate>
{
    UICollectionView *_collectionView;
    NSMutableArray *_datasArray;
    
    NSMutableArray *_dataSource;
    
    
    NSString *str;
    
    UIView *view;

    NineFooterView *footer;
    
    int page;
    
    int currentPageNo;
    
    NSString *string10;//数据的总条数
}


@property (nonatomic,strong)DJRefresh *refresh;

@end

@implementation NineAndNineViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     self.tabBarController.tabBar.hidden=YES;
    

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _datasArray=[NSMutableArray new];
    
    _dataSource=[NSMutableArray new];
    self.view.frame=[UIScreen mainScreen].bounds;
    //初始化
    str=@"";
    
    page=0;
    currentPageNo=1;
    
    [self createCollectionView];
    //获取数据
        [self getDatas];
    
    WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
    
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        [hud dismiss:YES];
    });
    
    
    self.tabBarController.tabBar.hidden=YES;
    
    self.view.tag=200;
}

-(void)createCollectionView
{
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    
    _collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-KSafeAreaTopNaviHeight) collectionViewLayout:flowLayout];
    
    _collectionView.backgroundColor=[UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1.0];
    
    _collectionView.delegate=self;
    
    _collectionView.dataSource=self;
    
    [self.view addSubview:_collectionView];
    
    
    _refresh=[[DJRefresh alloc] initWithScrollView:_collectionView delegate:self];
    _refresh.topEnabled=YES;//下拉刷新
    _refresh.bottomEnabled=NO;//上拉加载
    
    //注册cell
    [_collectionView registerNib:[UINib nibWithNibName:@"NineNineCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    
    [_collectionView registerNib:[UINib nibWithNibName:@"NoCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell1"];
    
    [_collectionView registerNib:[UINib nibWithNibName:@"NineFooterView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
    
    
}

-(void)NoWebSeveice
{
    
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

-(void)loadData
{
    
    WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
    
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        [hud dismiss:YES];
    });
    
    NSLog(@"===YTYTY==");
    
    [self getDatas];
    
    
}
-(void)getDatas
{
    //如果数据源空，则隐藏按钮
    
    
    WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
    
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        
    });
    
    //清空数据源
//    [_datasArray removeAllObjects];
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSDictionary *dict=@{@"page":[NSString stringWithFormat:@"%d",page],@"currentPageNo":[NSString stringWithFormat:@"%d",currentPageNo]};
    
    NSLog(@"===str==%@",str);
//    NSDictionary *dict=nil;
    
    NSString *url=[NSString stringWithFormat:@"%@getNineGoods_mob.shtml",URL_Str];
    
    [manager POST:url parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        
    } success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
        NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];
        
        if (codeKey && content) {
            NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
            
            
            NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];
            
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
//            NSLog(@"nine=%@",xmlStr);
            
            view.hidden=YES;
            
            for (NSDictionary *dict in dic) {
                NSDictionary *dict1=dict[@"nineGoodsList"];
                 string10=dict[@"totalCount"];
                for (NSDictionary *dict2 in dict1) {
                    NineModel *model=[[NineModel alloc] init];
                    model.amount=dict2[@"amount"];
                    model.gid=dict2[@"id"];
                    model.money=dict2[@"pay_maney"];
                    model.name=dict2[@"name"];
                    model.picture_address=dict2[@"scopeimg"];
                    model.product_address=dict2[@"product_address"];
                    model.type_name=dict2[@"type_name"];
                    model.tid=dict2[@"tid"];
                    model.attribute = dict2[@"is_attribute"];
                    model.storename = dict2[@"storename"];
//                    NSLog(@"%@",dict2[@"picture_address"]);
                    
//                    [_datasArray addObject:model];
                    
//                    NSLog(@"==========%ld",_datasArray.count);
                    [_dataSource addObject:model];
                    
//                    NSLog(@"=====%ld",_dataSource.count);
                    
                }
            }
            if (_dataSource.count%12==0&&_dataSource.count !=[string10 integerValue]) {
                
                footer.hidden=NO;
                [footer.loadMoreBtn setTitle:@"点击加载更多" forState:0];
//                [footer.loadMoreBtn setTitleColor:[UIColor colorWithRed:91/255.0 green:150/255.0 blue:255/255.0 alpha:1.0] forState:0];
                footer.loadMoreBtn.enabled=YES;
                
            }else if (_dataSource.count == [string10 integerValue]){
                 footer.hidden=NO;
                footer.moreView.hidden=YES;
                [footer.loadMoreBtn setTitle:@"暂无更多数据" forState:0];
                [footer.loadMoreBtn setTitleColor:[UIColor colorWithRed:154/255.0 green:154/255.0 blue:154/255.0 alpha:1.0] forState:0];
                footer.loadMoreBtn.enabled=NO;
                
                
            }else{
                
                //隐藏点击加载更多
                footer.hidden=YES;
                
            }

            [hud dismiss:YES];
            
            //刷新数据
            [_collectionView reloadData];
            
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
        [hud dismiss:YES];
        
        [self NoWebSeveice];
        
        NSLog(@"errpr = %@",error);
    }];
}
#pragma mark - 代理方法
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (_dataSource.count==0) {
        
        return 1;
        
    }
    else
    {
        
        return _dataSource.count;
    }
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_dataSource.count==0) {
        
        return CGSizeMake([UIScreen mainScreen].bounds.size.width, 0);
        
    }else{
        
        return CGSizeMake(([UIScreen mainScreen].bounds.size.width-5)/2, ([UIScreen mainScreen].bounds.size.height-40)/2.5);
    }
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_dataSource.count==0) {
        
        NoCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cell1" forIndexPath:indexPath];
        
        return cell;
    }else{
        
        NineNineCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
        
        NineModel *model=_dataSource[indexPath.row];
        
        cell.StorenameLabel.text = model.storename;
        cell.nameLabel.text=model.name;
        cell.payLabel.text=[NSString stringWithFormat:@"%@人付款",model.amount];
        cell.priceLabel.text=[NSString stringWithFormat:@"￥%.02f",[model.money floatValue]];
        
        [cell.NineImgView sd_setImageWithURL:[NSURL URLWithString:model.picture_address] placeholderImage:[UIImage imageNamed:@"default_image"] options:SDWebImageProgressiveDownload];
        
        return cell;
    }
    
}

//最小行间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 5;
}
//最小行内部cell的间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 5;
}

//section的边距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    //上,左,下,右
    return UIEdgeInsetsMake(0, 0, 5, 0);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"%ld",indexPath.row);
    
    NineModel *model=_dataSource[indexPath.row];
    
//    NewGoodsDetailViewController *vc=[[NewGoodsDetailViewController alloc] init];
    
//    YTGoodsDetailViewController *vc=[[YTGoodsDetailViewController alloc] init];
//    vc.type=@"2";//判断返回界面
//    
//    vc.gid=model.gid;
//    
//    vc.attribute = model.attribute ;
//    
//    vc.Attribute_back=@"2";
    
    
    YTGoodsDetailViewController *yt=[[YTGoodsDetailViewController alloc] init];
    
    yt.gid=model.gid;
    yt.ID=model.gid;

    
    yt.type=@"2";//判断返回界面
    
    
    yt.attribute = model.attribute ;
    
    yt.Attribute_back=@"2";
    
    [self.navigationController pushViewController:yt animated:NO];
    
    self.navigationController.navigationBar.hidden=YES;
}

//footer
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    footer=[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer" forIndexPath:indexPath];
    
    footer.delegate=self;
    if (_dataSource.count == 0) {
        footer.hidden = YES;
    }
    return footer;
    
}



//返回footer的高度
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeMake([UIScreen mainScreen].bounds.size.width-20, 44);
}

//返回
- (IBAction)backBtnClick:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
    self.tabBarController.tabBar.hidden=NO;
}




-(void)ReloadDatas
{
    
    WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
    
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        
    });
    
        [HTTPRequestManager POST:@"getNineGoods_mob.shtml" NSDictWithString:@{@"page":[NSString stringWithFormat:@"%d",page],@"currentPageNo":[NSString stringWithFormat:@"%d",currentPageNo]} parameters:nil result:^(id responseObj, NSError *error) {
    
    
            NSLog(@"==responseObj==%@===",responseObj);
    
            if (responseObj) {
    
                for (NSDictionary *dic in responseObj) {
    
                    view.hidden=YES;
                    
                    NSDictionary *dict1=dic[@"nineGoodsList"];
                    string10=dic[@"totalCount"];
                    for (NSDictionary *dict2 in dict1) {
                        NineModel *model=[[NineModel alloc] init];
                        model.amount=dict2[@"amount"];
                        model.gid=dict2[@"id"];
                        model.money=dict2[@"pay_maney"];
                        model.name=dict2[@"name"];
                        model.picture_address=dict2[@"scopeimg"];
                        model.product_address=dict2[@"product_address"];
                        model.type_name=dict2[@"type_name"];
                        model.tid=dict2[@"tid"];
                        model.attribute = dict2[@"is_attribute"];
                            
                        
                        
                        [_dataSource addObject:model];
                            
                        _dataSource = [NSMutableArray arrayWithArray:_dataSource];
                            
                            
                    }
                    if (_dataSource.count%12==0&&_dataSource.count !=[string10 integerValue]) {
                        
                        footer.hidden=NO;
                        [footer.loadMoreBtn setTitle:@"点击加载更多" forState:0];
                        footer.loadMoreBtn.enabled=YES;
                        
                    }else if (_dataSource.count == [string10 integerValue]){
                        footer.hidden=NO;
                        footer.moreView.hidden=YES;
                        [footer.loadMoreBtn setTitle:@"暂无更多数据" forState:0];
                        [footer.loadMoreBtn setTitleColor:[UIColor colorWithRed:154/255.0 green:154/255.0 blue:154/255.0 alpha:1.0] forState:0];
                        footer.loadMoreBtn.enabled=NO;
                        
                        
                    }else{
                        
                        //隐藏点击加载更多
                        footer.hidden=YES;
                        
                    }
                    
                    [hud dismiss:YES];
                    
                    //刷新数据
                    [_collectionView reloadData];
    
                }
    
            }else{
    
    
                NSLog(@"error");
                
                [hud dismiss:YES];
                
                [self NoWebSeveice];
                
                
            }
            
            
        }];
    
    
    
}
- (void)refresh:(DJRefresh *)refresh didEngageRefreshDirection:(DJRefreshDirection)direction{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self addDataWithDirection:direction];
    });
    
}

- (void)addDataWithDirection:(DJRefreshDirection)direction{
    
    if (direction==DJRefreshDirectionTop) {
        
        page=0;
        
        currentPageNo=1;
        
        [_dataSource removeAllObjects];
        //获取数据
        [self getDatas];
        
//        [self ReloadDatas];
        

    }
    
    
    
    [_refresh finishRefreshingDirection:direction animation:YES];
    
    [_collectionView reloadData];
    
}


//加载更多数据代理方法
- (void)FooterViewClickedloadMoreData
{
    
    NSLog(@"点击加载更多");
    
    if (_dataSource.count%12==0) {
        
        str=self.NineId;
        
        page=page+12;
        
        currentPageNo=currentPageNo+1;
        
        //获取数据
            [self getDatas];
//        WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
//        dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
//        dispatch_after(time, dispatch_get_main_queue(), ^{
//
//            [hud dismiss:YES];
//            
//        });
        
    }else{
        
        
//        XSInfoViewStyle *style = [[XSInfoViewStyle alloc] init];
//        style.info = @"暂无更多数据!";
//        style.layoutStyle = XSInfoViewLayoutStyleHorizontal;
//        [XSInfoView showInfoWithStyle:style onView:self.view];
    }
}


@end
