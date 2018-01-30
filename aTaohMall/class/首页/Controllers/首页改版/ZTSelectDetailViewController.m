//
//  ZTSelectDetailViewController.m
//  aTaohMall
//
//  Created by JMSHT on 2017/6/21.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "ZTSelectDetailViewController.h"

#import "ZTSelectViewCell.h"
#import "ConverUtil.h"
#import "DESUtil.h"
#import "SecretCodeTool.h"

#import "AFNetworking.h"
#import "WKProgressHUD.h"

#import "DPModel.h"
#import "TrainToast.h"
#import "YTGoodsDetailViewController.h"
#import "UIImageView+WebCache.h"
@interface ZTSelectDetailViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    
    UICollectionView *_collectionView;
    NSMutableArray *_data;
}

@end

@implementation ZTSelectDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _data  =[NSMutableArray new];
    [self initNav];
    
    [self initCollectionView];
    
    [self getDatas];
    
}

-(void)getDatas
{
    //    WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
    
    
    WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
    
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        
        
    });
    
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSDictionary *dict=@{@"small_id":self.TagString};
    
    NSString *url=[NSString stringWithFormat:@"%@getSpecialTitleSmallDataList_mob.shtml",URL_Str];
    
    [manager POST:url parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        
    } success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
        NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];
        
        
        [_data removeAllObjects];
        
        
        if (codeKey && content) {
            NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
            
            NSLog(@"=======xmlStr%@",xmlStr);
            
            
            NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];
            
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            if ([dic[@"status"] isEqualToString:@"10000"]) {
                
                for (NSDictionary *dict in dic[@"list_goods"]) {
                    
                    DPModel *model = [[DPModel alloc] init];
                    
                    model.gid = [NSString stringWithFormat:@"%@",dict[@"id"]];
                    model.name = [NSString stringWithFormat:@"%@",dict[@"name"]];
                    model.pay_integer = [NSString stringWithFormat:@"%@",dict[@"pay_integer"]];
                    model.pay_maney = [NSString stringWithFormat:@"%@",dict[@"pay_maney"]];
                    model.scopeimg = [NSString stringWithFormat:@"%@",dict[@"scopeimg"]];
                    model.storename = [NSString stringWithFormat:@"%@",dict[@"storename"]];
                    model.status = [NSString stringWithFormat:@"%@",dict[@"status"]];
                    model.good_type = [NSString stringWithFormat:@"%@",dict[@"good_type"]];
                    model.stock = [NSString stringWithFormat:@"%@",dict[@"stock"]];
                    [_data addObject:model];
                }
                
                
            }else{
                
                [TrainToast showWithText:dic[@"message"] duration:2.0f];
                
            }
            [hud dismiss:YES];
            
            [_collectionView reloadData];
            
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
        [hud dismiss:YES];
        
        
        
        NSLog(@"errpr = %@",error);
    }];
}

//创建导航栏
-(void)initNav
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
    
    [Qurt setImage:[UIImage imageNamed:@"icon-back"] forState:0];
    
    
    [Qurt addTarget:self action:@selector(QurtBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [titleView addSubview:Qurt];
    
    //创建搜索
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 25+KSafeTopHeight, [UIScreen mainScreen].bounds.size.width-200, 30)];
    
    label.text = self.Title;
    
    label.textColor = [UIColor blackColor];
    
    label.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:19];
    
    label.textAlignment = NSTextAlignmentCenter;
    
    [titleView addSubview:label];
    
    
}

-(void)initCollectionView
{
    
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    
    _collectionView  = [[UICollectionView alloc] initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-KSafeAreaTopNaviHeight) collectionViewLayout:flow];
    
    _collectionView.delegate=self;
    
    _collectionView.dataSource=self;
    
    _collectionView.backgroundColor = [UIColor colorWithRed:228/255.0 green:233/255.0 blue:234/255.0 alpha:1.0];
    
    [self.view addSubview:_collectionView];
    
    [_collectionView registerClass:[ZTSelectViewCell class] forCellWithReuseIdentifier:@"cell"];
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return _data.count;
    
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake(([UIScreen mainScreen].bounds.size.width-18)/2, ([UIScreen mainScreen].bounds.size.width-18)/2+94+7);
    
}

//最小行间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 6;
}
//最小行内部cell的间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 6;
}

//section的边距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    //上,左,下,右
    return UIEdgeInsetsMake(6, 6, 6, 6);
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    ZTSelectViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    DPModel *model = _data[indexPath.row];
    
    cell.status = model.status;
    
    [cell StatusString:model.status Type:model.stock];
    
    [cell.GoodsImageView sd_setImageWithURL:[NSURL URLWithString:model.scopeimg] placeholderImage:[UIImage imageNamed:@"default_image"] options:SDWebImageProgressiveDownload];
    
    cell.GoodsNameLabel.text = model.name;
    
    cell.StrorenameLabel.text = model.storename;
    
    cell.GoodsPriceLabel.text = [NSString stringWithFormat:@"￥%.02f+%.02f积分",[model.pay_maney floatValue],[model.pay_integer floatValue]];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    DPModel *model = _data[indexPath.row];
    
    YTGoodsDetailViewController *vc=[[YTGoodsDetailViewController alloc] init];
    
    vc.type= @"3";
    vc.ID = model.gid;
    vc.gid = model.gid;
    self.navigationController.navigationBar.hidden=YES;
    //    self.tabBarController.tabBar.hidden=YES;
    [self.navigationController pushViewController:vc animated:NO];
    
}

-(void)QurtBtnClick
{
    
    [self.navigationController popViewControllerAnimated:NO];
    self.navigationController.navigationBar.hidden=YES;
    
}

@end
