//
//  BusinessQurtViewController.m
//  aTaohMall
//
//  Created by JMSHT on 16/5/12.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import "BusinessQurtViewController.h"
#import "BusinessQurtCell.h"

#import "CollectionFooterView.h"


#import "NearShopViewController.h"//附近商店

#import "NearByViewController.h"//附近

#import "GoodsDetailViewController.h"//商品详情

#import "AFNetworking.h"//网络请求

//加密
#import "ConverUtil.h"
#import "DESUtil.h"
#import "SecretCodeTool.h"

#import "BusinessQurtModel.h"//数据模型JSON

#import "BusinessModel.h"//模型

#import "UIImageView+WebCache.h"//异步加载图片

#import "NewGoodsDetailViewController.h"

#import "WKProgressHUD.h"

#import "GotoShopLookViewController.h"//店铺详情
#import "NineFooterView.h"
//刷新
#import "DJRefresh.h"
#import "DJRefreshProgressView.h"

#import "AppDelegate.h"

#import "NewLoginViewController.h"//注册

#import "XSInfoView.h"

#import "JRToast.h"
#import "NoCollectionViewCell.h"

#import "YTShangQuanCell.h"
@interface BusinessQurtViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,FooterViewDelegate,DJRefreshDelegate,BusinessReloadDataDelegate>
{
    UICollectionView *_collectionView;
    
    UICollectionReusableView *_footerView;
    
    NineFooterView *footer;
    NSMutableArray *_dataArr;//数据
    
    int _num;
    
    UIView *view;
    
    
    NSString *string10;
    
}

@property (nonatomic,strong)DJRefresh *refresh;
@end

@implementation BusinessQurtViewController

-(instancetype)init
{
    if (self = [super init]) {
        
        //监听通知
        //这个方法必须在post之前调用
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveNumber:) name:@"postNumber" object:nil];
        
    }
    return self;
}

//监听通知的方法
-(void)receiveNumber:(NSNotification *)notification
{
    NSString *number = notification.object;
    
    NSLog(@"========number=====%@",number);
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   
    self.automaticallyAdjustsScrollViewInsets=NO;
     self.tabBarController.tabBar.hidden = NO;
}

-(void)reloadData
{
    _num=0;
    
    [_dataArr removeAllObjects];
    
    [self getDatas];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.frame=[UIScreen mainScreen].bounds;
    self.title=@"商户";
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[UIColor colorWithRed:200 green:200 blue:200 alpha:1],[UIFont boldSystemFontOfSize:21.0f],[UIColor colorWithWhite:0.0 alpha:1], nil] forKeys:[NSArray arrayWithObjects:UITextAttributeTextColor,UITextAttributeFont,UITextAttributeTextShadowColor, nil]];

    
    self.navigationController.navigationBar.titleTextAttributes = dict;
    
    
    _num=0;
    
    //初始化数组
    _dataArr=[NSMutableArray new];
    
    
    
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"附近" style:UIBarButtonItemStylePlain target:self action:@selector(rightBtnClick)];
    
    [self createCollectionView];
    
    
    //获取数据
    [self getDatas];
    
    
    
    
}

//数据请求
-(void)getDatas
{
    
        //获取数据
    
    WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
    
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        
    });
    
    
        
        AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
        
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        NSDictionary *dict=@{@"flag":[NSString stringWithFormat:@"%d",_num]};
        
        //    NSString *url=[NSString stringWithFormat:@"%@getMoreMerchants_mob.shtml",URL_Str];
        NSString *url=[NSString stringWithFormat:@"%@getTradingArea_mob.shtml",URL_Str];
        //    NSLog(@"%@",url);
        
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
                
                NSLog(@"dict=%@",dic);
                
                
                view.hidden=YES;
                
                for (NSDictionary *dict in dic) {
                    NSLog(@"状态码 == %@",dict[@"status"]);
                    NSDictionary *dict1=dict[@"tradingAreaList"];
                    //                NSLog(@"%@",dict1);
                    string10 = dict[@"totalCount"];
                    
                    if (dict1.count==0) {
                        
                        XSInfoViewStyle *style = [[XSInfoViewStyle alloc] init];
                        style.info = @"暂无更多数据!";
                        style.layoutStyle = XSInfoViewLayoutStyleHorizontal;
                        [XSInfoView showInfoWithStyle:style onView:self.view];
                    }
                    for (NSDictionary *dict in dict1) {
                        BusinessModel *model=[[BusinessModel alloc] init];
                        NSString *click_volume=dict[@"click_volume"];
                        NSString *id=dict[@"id"];
                        NSString *logo=dict[@"logo"];
                        NSString *storename=dict[@"storename"];
                        
                        model.click_volume=click_volume;
                        model.id=id;
                        model.logo=logo;
                        model.storename=storename;

                        //                    NSLog(@"%@",model);
                        [_dataArr addObject:model];
                        
                        
                    }
                    
                    if (_dataArr.count%12==0&&_dataArr.count !=[string10 integerValue]) {
                        
                        footer.hidden=NO;
                        [footer.loadMoreBtn setTitle:@"点击加载更多" forState:0];
//                        [footer.loadMoreBtn setTitleColor:[UIColor colorWithRed:91/255.0 green:150/255.0 blue:255/255.0 alpha:1.0] forState:0];
                        footer.loadMoreBtn.enabled=YES;
                        
                    }else if (_dataArr.count == [string10 integerValue]){
                        footer.hidden = NO;
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
                
                
            }
        } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
            
//            [WKProgressHUD popMessage:@"网络请求失败，请检查您的网络设置" inView:self.view duration:1.5 animated:YES];
            [hud dismiss:YES];
            
            [self NoWebSeveice];
            
//            [JRToast showWithText:@"网络请求失败，请检查你的网络设置" duration:3.0f];
            
            NSLog(@"errpr = %@",error);
        }];
    
    
}

-(void)NoWebSeveice
{
    
    view=[[UIView alloc] initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-49)];
    
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
    
    [_dataArr removeAllObjects];
    
    [_collectionView reloadData];
    
    view.hidden=YES;
    
    WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
    
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 3ull * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        [hud dismiss:YES];
    });
    
    [self getDatas];
    
}
-(void)createCollectionView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-49-64) collectionViewLayout:flowLayout];
    
//    _collectionView.backgroundColor=[UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1.0];
    
    _collectionView.backgroundColor=[UIColor whiteColor];
    
    _collectionView.delegate=self;
    
    _collectionView.dataSource=self;
    
    _collectionView.showsVerticalScrollIndicator=NO;
    _collectionView.showsHorizontalScrollIndicator=NO;
    
    
    [self.view addSubview:_collectionView];
    
    //注册cell
    
    _footerView=[[UICollectionReusableView alloc] init];
    
    
    [_collectionView registerNib:[UINib nibWithNibName:@"BusinessQurtCell" bundle:nil] forCellWithReuseIdentifier:@"Cell"];
    
    [_collectionView registerNib:[UINib nibWithNibName:@"YTShangQuanCell" bundle:nil] forCellWithReuseIdentifier:@"YTCell"];
    
//    [_collectionView registerNib:[UINib nibWithNibName:@"CollectionFooterView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterCell"];
    
    [_collectionView registerNib:[UINib nibWithNibName:@"NoCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell1"];
    
    [_collectionView registerNib:[UINib nibWithNibName:@"NineFooterView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
    
    _refresh=[[DJRefresh alloc] initWithScrollView:_collectionView delegate:self];
    _refresh.topEnabled=YES;
    _refresh.bottomEnabled=NO;
    
    if (_type==eRefreshTypeProgress) {
        [_refresh registerClassForTopView:[DJRefreshProgressView class]];
    }
    
}

#pragma mark - CollectionView的代理方法

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (_dataArr.count==0) {
        
        return 1;
        
    }else{
        
        return _dataArr.count;
    }
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_dataArr.count==0) {
        
        NoCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cell1" forIndexPath:indexPath];
        
        return cell;
    }else{
        
//        BusinessQurtCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
        
        YTShangQuanCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"YTCell" forIndexPath:indexPath];
        
        BusinessModel *model=_dataArr[indexPath.row];
        
//        [cell.StoreImgView sd_setImageWithURL:[NSURL URLWithString:model.logo]];
        
        [cell.StoreImgView sd_setImageWithURL:[NSURL URLWithString:model.logo] placeholderImage:[UIImage imageNamed:@"default_image"] options:SDWebImageProgressiveDownload];
        cell.StoreNameLabel.text=[NSString stringWithFormat:@"[%@]",model.storename];
        cell.ClickLabel.text=[NSString stringWithFormat:@"%@人进店逛过",model.click_volume];
        
        return cell;
    }
    
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (_dataArr.count==0) {
        
        return CGSizeMake([UIScreen mainScreen].bounds.size.width, 240);
        
    }else{
        
         return CGSizeMake(([UIScreen mainScreen].bounds.size.width-35)/2, ([UIScreen mainScreen].bounds.size.height)/2.8);
    }
//    return CGSizeMake(([UIScreen mainScreen].bounds.size.width-10)/2, 210);
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
    return UIEdgeInsetsMake(5, 15, 5, 15);
}


//footer
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    footer=[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer" forIndexPath:indexPath];
    
    footer.delegate=self;
    if(_dataArr.count == 0){
    
        footer.hidden = YES;
    }
    
    
    return footer;
    
}



//返回footer的高度
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeMake([UIScreen mainScreen].bounds.size.width-20, 44);
}

//选择
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_dataArr.count==0) {
        
        
    }else{
        
        BusinessModel *model=_dataArr[indexPath.row];
        
        GotoShopLookViewController *look=[[GotoShopLookViewController alloc] init];
        
        look.GetString=@"1";
        
        look.type=@"2";
        
        look.delegate=self;
        
        look.mid=model.id;
        
        
        [self.navigationController pushViewController:look animated:NO];
        
        self.navigationController.navigationBar.hidden=YES;
        self.tabBarController.tabBar.hidden=YES;
        
    }
    
}

//右边附近按钮
-(void)rightBtnClick
{
//    NSLog(@"附近按钮被点击了");
    
    NearByViewController *nearVC=[[NearByViewController alloc] init];
    
    [self.navigationController pushViewController:nearVC animated:YES];
    self.tabBarController.tabBar.hidden=YES;
}



- (void)refresh:(DJRefresh *)refresh didEngageRefreshDirection:(DJRefreshDirection)direction{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
      [self addDataWithDirection:direction];
    });
    
}

- (void)addDataWithDirection:(DJRefreshDirection)direction{
    
    if (direction==DJRefreshDirectionTop) {
        
        NSLog(@"下拉刷新");
        
        _num=0;
        
        
        [_dataArr removeAllObjects];
         //获取数据
            [self getDatas];
        
    }
    
    [_collectionView reloadData];
    [_refresh finishRefreshingDirection:direction animation:YES];
    
    
}

//加载更多数据代理方法
- (void)FooterViewClickedloadMoreData
{
    
    NSLog(@"点击加载更多");
    
    if (_dataArr.count%12==0) {
        
        
        _num=_num+1;
        
        //获取数据
        [self getDatas];
        
    }else{
        
        
        XSInfoViewStyle *style = [[XSInfoViewStyle alloc] init];
        style.info = @"暂无更多数据!";
        style.layoutStyle = XSInfoViewLayoutStyleHorizontal;
        [XSInfoView showInfoWithStyle:style onView:self.view];
    }
}

@end
