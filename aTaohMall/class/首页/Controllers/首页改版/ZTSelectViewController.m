//
//  ZTSelectViewController.m
//  aTaohMall
//
//  Created by JMSHT on 2017/6/21.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "ZTSelectViewController.h"

#import "ZTSelectViewCell.h"
#import "ZTSelectDetailViewController.h"
#import "DPHeaderView.h"
#import "ZTSelectViewCell.h"
#import "MWHCHedaerView.h"
#import "DPOtherHeaderView.h"
#import "ConverUtil.h"
#import "DESUtil.h"
#import "SecretCodeTool.h"

#import "AFNetworking.h"
#import "WKProgressHUD.h"

#import "DPModel.h"
#import "TrainToast.h"
#import "YTGoodsDetailViewController.h"
#import "UIImageView+WebCache.h"
@interface ZTSelectViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    
    UICollectionView *_collectionView;
    
    
    NSMutableArray *_data;
    
    NSMutableArray *_Small;
    
}
@end

@implementation ZTSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _data  =[NSMutableArray new];
    
    _Small  =[NSMutableArray new];
    
    [self initNav];
    
//    [self initTopView];
    
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
    
    NSDictionary *dict=@{@"type":self.TypeString};
    
    NSString *url=[NSString stringWithFormat:@"%@getSpecialTitleData_mob.shtml",URL_Str];
    
    [manager POST:url parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        
    } success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
        NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];
        
        
        [_data removeAllObjects];
        
        [_Small removeAllObjects];
        
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
                
                for (NSDictionary *dict in dic[@"list_small"]) {
                    
                    DPModel *model = [[DPModel alloc] init];
                    
                    model.small_id = [NSString stringWithFormat:@"%@",dict[@"id"]];
                    model.small_name = [NSString stringWithFormat:@"%@",dict[@"small_name"]];
                    
                    [_Small addObject:model];
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
    
    [_collectionView registerClass:[DPHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    
    [_collectionView registerClass:[MWHCHedaerView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header1"];
    
    [_collectionView registerClass:[DPOtherHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header2"];
     
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    
    return 1;
    
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return _data.count;
    
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake(([UIScreen mainScreen].bounds.size.width-18)/2, ([UIScreen mainScreen].bounds.size.width-18)/2+94+7);
    
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    
    if ([self.Type isEqualToString:@"1"]) {
        
        return CGSizeMake([UIScreen mainScreen].bounds.size.width, 83);
        
    }else if ([self.Type isEqualToString:@"2"]) {
        
        return CGSizeMake([UIScreen mainScreen].bounds.size.width, 83);
        
    }else if ([self.Type isEqualToString:@"3"]) {
        
        return CGSizeMake([UIScreen mainScreen].bounds.size.width, 83);
        
    }else{
        
        return CGSizeMake([UIScreen mainScreen].bounds.size.width, 64);
    }
    
    
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

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    if ([self.Type isEqualToString:@"1"]) {
        
        MWHCHedaerView *header=[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header1" forIndexPath:indexPath];
        
        header.Array = _Small;
        
        header.OneTitle.text = @"零食生鲜";
        header.TwoTitle.text = @"休闲食品";
        header.ThreeTitle.text = @"营养滋补";
        header.FourTitle.text = @"热销名酒";
        
        header.OneImgView.image = [UIImage imageNamed:@"img-shengxian"];
        header.TwoImgView.image = [UIImage imageNamed:@"img-food"];
        header.ThreeImgView.image = [UIImage imageNamed:@"img-yingyang"];
        header.FourImgView.image = [UIImage imageNamed:@"img-jiu"];
        
        [header.OneButton addTarget:self action:@selector(MWOneBtnCLick1:) forControlEvents:UIControlEventTouchUpInside];
        [header.TwoButton addTarget:self action:@selector(MWTwoBtnCLick1:) forControlEvents:UIControlEventTouchUpInside];
        [header.ThreeButton addTarget:self action:@selector(MWThreeBtnCLick1:) forControlEvents:UIControlEventTouchUpInside];
        [header.FourButton addTarget:self action:@selector(MWFourBtnCLick1:) forControlEvents:UIControlEventTouchUpInside];
        
        return header;
        
    }else if ([self.Type isEqualToString:@"2"]) {
        
        MWHCHedaerView *header=[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header1" forIndexPath:indexPath];
        header.Array = _Small;
        header.OneTitle.text = @"身体护理";
        header.TwoTitle.text = @"香水彩妆";
        header.ThreeTitle.text = @"热销面膜";
        header.FourTitle.text = @"洗发护发";
        
        header.OneImgView.image = [UIImage imageNamed:@"img-body"];
        header.TwoImgView.image = [UIImage imageNamed:@"img-xiangshui"];
        header.ThreeImgView.image = [UIImage imageNamed:@"img-mianmo"];
        header.FourImgView.image = [UIImage imageNamed:@"img-xifa"];
        
        [header.OneButton addTarget:self action:@selector(MWOneBtnCLick2:) forControlEvents:UIControlEventTouchUpInside];
        [header.TwoButton addTarget:self action:@selector(MWTwoBtnCLick2:) forControlEvents:UIControlEventTouchUpInside];
        [header.ThreeButton addTarget:self action:@selector(MWThreeBtnCLick2:) forControlEvents:UIControlEventTouchUpInside];
        [header.FourButton addTarget:self action:@selector(MWFourBtnCLick2:) forControlEvents:UIControlEventTouchUpInside];
        
        return header;
        
    }else if ([self.Type isEqualToString:@"3"]) {
        
        MWHCHedaerView *header=[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header1" forIndexPath:indexPath];
        header.Array = _Small;
        header.OneTitle.text = @"运动鞋服";
        header.TwoTitle.text = @"户外装备";
        header.ThreeTitle.text = @"休闲户外";
        header.FourTitle.text = @"智能运动";
        
        header.OneImgView.image = [UIImage imageNamed:@"img-shengxian"];
        header.TwoImgView.image = [UIImage imageNamed:@"img-food"];
        header.ThreeImgView.image = [UIImage imageNamed:@"img-yingyang"];
        header.FourImgView.image = [UIImage imageNamed:@"img-zhineng"];
        
        [header.OneButton addTarget:self action:@selector(MWOneBtnCLick3:) forControlEvents:UIControlEventTouchUpInside];
        [header.TwoButton addTarget:self action:@selector(MWTwoBtnCLick3:) forControlEvents:UIControlEventTouchUpInside];
        [header.ThreeButton addTarget:self action:@selector(MWThreeBtnCLick3:) forControlEvents:UIControlEventTouchUpInside];
        [header.FourButton addTarget:self action:@selector(MWFourBtnCLick3:) forControlEvents:UIControlEventTouchUpInside];
        
        return header;
        
    }else if([self.Type isEqualToString:@"4"]){
        
        DPOtherHeaderView *header=[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header2" forIndexPath:indexPath];
        
        header.Array = _Small;
        header.OneTitle.text = @"服装";
        header.TwoTitle.text = @"鞋靴";
        header.ThreeTitle.text = @"箱包";
        header.FourTitle.text = @"珠宝配饰";
        
        header.OneImgView.image = [UIImage imageNamed:@"icon-fuzhuang"];
        header.TwoImgView.image = [UIImage imageNamed:@"icon-shoes"];
        header.ThreeImgView.image = [UIImage imageNamed:@"icon-bag"];
        header.FourImgView.image = [UIImage imageNamed:@"icon-watch"];
        
        
        [header.OneButton addTarget:self action:@selector(DPOneBtnCLick4:) forControlEvents:UIControlEventTouchUpInside];
        [header.TwoButton addTarget:self action:@selector(DPTwoBtnCLick4:) forControlEvents:UIControlEventTouchUpInside];
        [header.ThreeButton addTarget:self action:@selector(DPThreeBtnCLick4:) forControlEvents:UIControlEventTouchUpInside];
        [header.FourButton addTarget:self action:@selector(DPFourBtnCLick4:) forControlEvents:UIControlEventTouchUpInside];
        
        return header;
        
    }else if([self.Type isEqualToString:@"5"]){
        
        DPOtherHeaderView *header=[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header2" forIndexPath:indexPath];
        
        header.Array = _Small;
        header.OneTitle.text = @"床上用品";
        header.TwoTitle.text = @"厨具";
        header.ThreeTitle.text = @"居家日用";
        header.FourTitle.text = @"家居建材";
        
        header.OneImgView.image = [UIImage imageNamed:@"icon-chuang"];
        header.TwoImgView.image = [UIImage imageNamed:@"icon-chuju"];
        header.ThreeImgView.image = [UIImage imageNamed:@"icon-jujia"];
        header.FourImgView.image = [UIImage imageNamed:@"icon-jiaju666"];
        
        
        [header.OneButton addTarget:self action:@selector(DPOneBtnCLick5:) forControlEvents:UIControlEventTouchUpInside];
        [header.TwoButton addTarget:self action:@selector(DPTwoBtnCLick5:) forControlEvents:UIControlEventTouchUpInside];
        [header.ThreeButton addTarget:self action:@selector(DPThreeBtnCLick5:) forControlEvents:UIControlEventTouchUpInside];
        [header.FourButton addTarget:self action:@selector(DPFourBtnCLick5:) forControlEvents:UIControlEventTouchUpInside];
        
        return header;
        
    }else if([self.Type isEqualToString:@"6"]){
        
        DPOtherHeaderView *header=[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header2" forIndexPath:indexPath];
        
        header.Array = _Small;
        header.OneTitle.text = @"电脑";
        header.TwoTitle.text = @"数码";
        header.ThreeTitle.text = @"手机";
        header.FourTitle.text = @"配件";
        
        header.OneImgView.image = [UIImage imageNamed:@"icon-computer"];
        header.TwoImgView.image = [UIImage imageNamed:@"icon-shuma"];
        header.ThreeImgView.image = [UIImage imageNamed:@"icon-tel"];
        header.FourImgView.image = [UIImage imageNamed:@"icon-peijian"];
        
        
        [header.OneButton addTarget:self action:@selector(DPOneBtnCLick6:) forControlEvents:UIControlEventTouchUpInside];
        [header.TwoButton addTarget:self action:@selector(DPTwoBtnCLick6:) forControlEvents:UIControlEventTouchUpInside];
        [header.ThreeButton addTarget:self action:@selector(DPThreeBtnCLick6:) forControlEvents:UIControlEventTouchUpInside];
        [header.FourButton addTarget:self action:@selector(DPFourBtnCLick6:) forControlEvents:UIControlEventTouchUpInside];
        
        return header;
        
    }else if([self.Type isEqualToString:@"7"]){
        
        DPOtherHeaderView *header=[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header2" forIndexPath:indexPath];
        
        header.Array = _Small;
        header.OneTitle.text = @"奶粉辅食";
        header.TwoTitle.text = @"尿裤湿巾";
        header.ThreeTitle.text = @"童装童鞋";
        header.FourTitle.text = @"玩具";
        
        header.OneImgView.image = [UIImage imageNamed:@"icon-naifen"];
        header.TwoImgView.image = [UIImage imageNamed:@"icon-niaobu"];
        header.ThreeImgView.image = [UIImage imageNamed:@"icon-tongxie"];
        header.FourImgView.image = [UIImage imageNamed:@"icon-toy"];
        
        
        [header.OneButton addTarget:self action:@selector(DPOneBtnCLick7:) forControlEvents:UIControlEventTouchUpInside];
        [header.TwoButton addTarget:self action:@selector(DPTwoBtnCLick7:) forControlEvents:UIControlEventTouchUpInside];
        [header.ThreeButton addTarget:self action:@selector(DPThreeBtnCLick7:) forControlEvents:UIControlEventTouchUpInside];
        [header.FourButton addTarget:self action:@selector(DPFourBtnCLick7:) forControlEvents:UIControlEventTouchUpInside];
        
        return header;
        
    }else{
        
        
        DPHeaderView *header=[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
        header.Array = _Small;
        [header.OneButton addTarget:self action:@selector(DPOneBtnCLick8:) forControlEvents:UIControlEventTouchUpInside];
        [header.TwoButton addTarget:self action:@selector(DPTwoBtnCLick8:) forControlEvents:UIControlEventTouchUpInside];
        [header.ThreeButton addTarget:self action:@selector(DPThreeBtnCLick8:) forControlEvents:UIControlEventTouchUpInside];
        [header.FourButton addTarget:self action:@selector(DPFourBtnCLick8:) forControlEvents:UIControlEventTouchUpInside];
        
        return header;
    }
    
    
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

-(void)DPOneBtnCLick4:(UIButton *)sender
{
    UILabel *label = (UILabel *)[sender.superview viewWithTag:sender.tag+100];
    
    NSLog(@"=====%ld====%@",(long)sender.tag,label.text);
    ZTSelectDetailViewController *vc = [[ZTSelectDetailViewController alloc] init];
    
    vc.Title = label.text;
    
    vc.TagString = [NSString stringWithFormat:@"%ld",(long)sender.tag];
    
    [self.navigationController pushViewController:vc animated:NO];
    
    self.navigationController.navigationBar.hidden=YES;
    
}

-(void)DPTwoBtnCLick4:(UIButton *)sender
{
    UILabel *label = (UILabel *)[sender.superview viewWithTag:sender.tag+100];
    
    NSLog(@"=====%ld====%@",(long)sender.tag,label.text);
    ZTSelectDetailViewController *vc = [[ZTSelectDetailViewController alloc] init];
    
    vc.Title = label.text;
    
    vc.TagString = [NSString stringWithFormat:@"%ld",(long)sender.tag];
    
    [self.navigationController pushViewController:vc animated:NO];
    
    self.navigationController.navigationBar.hidden=YES;
}

-(void)DPThreeBtnCLick4:(UIButton *)sender
{
    UILabel *label = (UILabel *)[sender.superview viewWithTag:sender.tag+100];
    
    NSLog(@"=====%ld====%@",(long)sender.tag,label.text);
    ZTSelectDetailViewController *vc = [[ZTSelectDetailViewController alloc] init];
    
    vc.Title = label.text;
    
    vc.TagString = [NSString stringWithFormat:@"%ld",(long)sender.tag];
    
    [self.navigationController pushViewController:vc animated:NO];
    
    self.navigationController.navigationBar.hidden=YES;
    
}

-(void)DPFourBtnCLick4:(UIButton *)sender
{
    UILabel *label = (UILabel *)[sender.superview viewWithTag:sender.tag+100];
    
    NSLog(@"=====%ld====%@",(long)sender.tag,label.text);
    ZTSelectDetailViewController *vc = [[ZTSelectDetailViewController alloc] init];
    
    vc.Title = label.text;
    
    vc.TagString = [NSString stringWithFormat:@"%ld",(long)sender.tag];
    
    [self.navigationController pushViewController:vc animated:NO];
    
    self.navigationController.navigationBar.hidden=YES;
    
}

-(void)DPOneBtnCLick5:(UIButton *)sender
{
    UILabel *label = (UILabel *)[sender.superview viewWithTag:sender.tag+100];
    
    NSLog(@"=====%ld====%@",(long)sender.tag,label.text);
    ZTSelectDetailViewController *vc = [[ZTSelectDetailViewController alloc] init];
    
    vc.Title = label.text;
    
    vc.TagString = [NSString stringWithFormat:@"%ld",(long)sender.tag];
    
    [self.navigationController pushViewController:vc animated:NO];
    
    self.navigationController.navigationBar.hidden=YES;
    
}

-(void)DPTwoBtnCLick5:(UIButton *)sender
{
    UILabel *label = (UILabel *)[sender.superview viewWithTag:sender.tag+100];
    
    NSLog(@"=====%ld====%@",(long)sender.tag,label.text);
    ZTSelectDetailViewController *vc = [[ZTSelectDetailViewController alloc] init];
    
    vc.Title = label.text;
    
    vc.TagString = [NSString stringWithFormat:@"%ld",(long)sender.tag];
    
    [self.navigationController pushViewController:vc animated:NO];
    
    self.navigationController.navigationBar.hidden=YES;
}

-(void)DPThreeBtnCLick5:(UIButton *)sender
{
    UILabel *label = (UILabel *)[sender.superview viewWithTag:sender.tag+100];
    
    NSLog(@"=====%ld====%@",(long)sender.tag,label.text);
    ZTSelectDetailViewController *vc = [[ZTSelectDetailViewController alloc] init];
    
    vc.Title = label.text;
    
    vc.TagString = [NSString stringWithFormat:@"%ld",(long)sender.tag];
    
    [self.navigationController pushViewController:vc animated:NO];
    
    self.navigationController.navigationBar.hidden=YES;
    
}

-(void)DPFourBtnCLick5:(UIButton *)sender
{
    UILabel *label = (UILabel *)[sender.superview viewWithTag:sender.tag+100];
    
    NSLog(@"=====%ld====%@",(long)sender.tag,label.text);
    ZTSelectDetailViewController *vc = [[ZTSelectDetailViewController alloc] init];
    
    vc.Title = label.text;
    
    vc.TagString = [NSString stringWithFormat:@"%ld",(long)sender.tag];
    
    [self.navigationController pushViewController:vc animated:NO];
    
    self.navigationController.navigationBar.hidden=YES;
    
}


-(void)DPOneBtnCLick6:(UIButton *)sender
{
    UILabel *label = (UILabel *)[sender.superview viewWithTag:sender.tag+100];
    
    NSLog(@"=====%ld====%@",(long)sender.tag,label.text);
    ZTSelectDetailViewController *vc = [[ZTSelectDetailViewController alloc] init];
    
    vc.Title = label.text;
    
    vc.TagString = [NSString stringWithFormat:@"%ld",(long)sender.tag];
    
    [self.navigationController pushViewController:vc animated:NO];
    
    self.navigationController.navigationBar.hidden=YES;
    
}

-(void)DPTwoBtnCLick6:(UIButton *)sender
{
    UILabel *label = (UILabel *)[sender.superview viewWithTag:sender.tag+100];
    
    NSLog(@"=====%ld====%@",(long)sender.tag,label.text);
    ZTSelectDetailViewController *vc = [[ZTSelectDetailViewController alloc] init];
    
    vc.Title = label.text;
    
    vc.TagString = [NSString stringWithFormat:@"%ld",(long)sender.tag];
    
    [self.navigationController pushViewController:vc animated:NO];
    
    self.navigationController.navigationBar.hidden=YES;
}

-(void)DPThreeBtnCLick6:(UIButton *)sender
{
    UILabel *label = (UILabel *)[sender.superview viewWithTag:sender.tag+100];
    
    NSLog(@"=====%ld====%@",(long)sender.tag,label.text);
    ZTSelectDetailViewController *vc = [[ZTSelectDetailViewController alloc] init];
    
    vc.Title = label.text;
    
    vc.TagString = [NSString stringWithFormat:@"%ld",(long)sender.tag];
    
    [self.navigationController pushViewController:vc animated:NO];
    
    self.navigationController.navigationBar.hidden=YES;
    
}

-(void)DPFourBtnCLick6:(UIButton *)sender
{
    UILabel *label = (UILabel *)[sender.superview viewWithTag:sender.tag+100];
    
    NSLog(@"=====%ld====%@",(long)sender.tag,label.text);
    ZTSelectDetailViewController *vc = [[ZTSelectDetailViewController alloc] init];
    
    vc.Title = label.text;
    
    vc.TagString = [NSString stringWithFormat:@"%ld",(long)sender.tag];
    
    [self.navigationController pushViewController:vc animated:NO];
    
    self.navigationController.navigationBar.hidden=YES;
    
}

-(void)DPOneBtnCLick7:(UIButton *)sender
{
    UILabel *label = (UILabel *)[sender.superview viewWithTag:sender.tag+100];
    
    NSLog(@"=====%ld====%@",(long)sender.tag,label.text);
    ZTSelectDetailViewController *vc = [[ZTSelectDetailViewController alloc] init];
    
    vc.Title = label.text;
    
    vc.TagString = [NSString stringWithFormat:@"%ld",(long)sender.tag];
    
    [self.navigationController pushViewController:vc animated:NO];
    
    self.navigationController.navigationBar.hidden=YES;
    
}

-(void)DPTwoBtnCLick7:(UIButton *)sender
{
    UILabel *label = (UILabel *)[sender.superview viewWithTag:sender.tag+100];
    
    NSLog(@"=====%ld====%@",(long)sender.tag,label.text);
    ZTSelectDetailViewController *vc = [[ZTSelectDetailViewController alloc] init];
    
    vc.Title = label.text;
    
    vc.TagString = [NSString stringWithFormat:@"%ld",(long)sender.tag];
    
    [self.navigationController pushViewController:vc animated:NO];
    
    self.navigationController.navigationBar.hidden=YES;
}

-(void)DPThreeBtnCLick7:(UIButton *)sender
{
    UILabel *label = (UILabel *)[sender.superview viewWithTag:sender.tag+100];
    
    NSLog(@"=====%ld====%@",(long)sender.tag,label.text);
    ZTSelectDetailViewController *vc = [[ZTSelectDetailViewController alloc] init];
    
    vc.Title = label.text;
    
    vc.TagString = [NSString stringWithFormat:@"%ld",(long)sender.tag];
    
    [self.navigationController pushViewController:vc animated:NO];
    
    self.navigationController.navigationBar.hidden=YES;
    
}

-(void)DPFourBtnCLick7:(UIButton *)sender
{
    UILabel *label = (UILabel *)[sender.superview viewWithTag:sender.tag+100];
    
    NSLog(@"=====%ld====%@",(long)sender.tag,label.text);
    ZTSelectDetailViewController *vc = [[ZTSelectDetailViewController alloc] init];
    
    vc.Title = label.text;
    
    vc.TagString = [NSString stringWithFormat:@"%ld",(long)sender.tag];
    
    [self.navigationController pushViewController:vc animated:NO];
    
    self.navigationController.navigationBar.hidden=YES;
    
}

-(void)DPOneBtnCLick8:(UIButton *)sender
{
    UILabel *label = (UILabel *)[sender.superview viewWithTag:sender.tag+100];
    
    NSLog(@"=====%ld====%@",(long)sender.tag,label.text);
    ZTSelectDetailViewController *vc = [[ZTSelectDetailViewController alloc] init];
    
    vc.Title = label.text;
    
    vc.TagString = [NSString stringWithFormat:@"%ld",(long)sender.tag];
    
    [self.navigationController pushViewController:vc animated:NO];
    
    self.navigationController.navigationBar.hidden=YES;
    
}

-(void)DPTwoBtnCLick8:(UIButton *)sender
{
    UILabel *label = (UILabel *)[sender.superview viewWithTag:sender.tag+100];
    
    NSLog(@"=====%ld====%@",(long)sender.tag,label.text);
    ZTSelectDetailViewController *vc = [[ZTSelectDetailViewController alloc] init];
    
    vc.Title = label.text;
    
    vc.TagString = [NSString stringWithFormat:@"%ld",(long)sender.tag];
    
    [self.navigationController pushViewController:vc animated:NO];
    
    self.navigationController.navigationBar.hidden=YES;
}

-(void)DPThreeBtnCLick8:(UIButton *)sender
{
    UILabel *label = (UILabel *)[sender.superview viewWithTag:sender.tag+100];
    
    NSLog(@"=====%ld====%@",(long)sender.tag,label.text);
    ZTSelectDetailViewController *vc = [[ZTSelectDetailViewController alloc] init];
    
    vc.Title = label.text;
    
    vc.TagString = [NSString stringWithFormat:@"%ld",(long)sender.tag];
    
    [self.navigationController pushViewController:vc animated:NO];
    
    self.navigationController.navigationBar.hidden=YES;
    
}

-(void)DPFourBtnCLick8:(UIButton *)sender
{
    UILabel *label = (UILabel *)[sender.superview viewWithTag:sender.tag+100];
    
    NSLog(@"=====%ld====%@",(long)sender.tag,label.text);
    ZTSelectDetailViewController *vc = [[ZTSelectDetailViewController alloc] init];
    
    vc.Title = label.text;
    
    vc.TagString = [NSString stringWithFormat:@"%ld",(long)sender.tag];
    
    [self.navigationController pushViewController:vc animated:NO];
    
    self.navigationController.navigationBar.hidden=YES;
    
}

-(void)MWOneBtnCLick1:(UIButton *)sender
{
    UILabel *label = (UILabel *)[sender.superview viewWithTag:sender.tag+100];
    
    NSLog(@"=====%ld====%@",(long)sender.tag,label.text);
    ZTSelectDetailViewController *vc = [[ZTSelectDetailViewController alloc] init];
    
    vc.Title = label.text;
    
    vc.TagString = [NSString stringWithFormat:@"%ld",(long)sender.tag];
    
    [self.navigationController pushViewController:vc animated:NO];
    
    self.navigationController.navigationBar.hidden=YES;
    
}

-(void)MWTwoBtnCLick1:(UIButton *)sender
{
    UILabel *label = (UILabel *)[sender.superview viewWithTag:sender.tag+100];
    
    NSLog(@"=====%ld====%@",(long)sender.tag,label.text);
    ZTSelectDetailViewController *vc = [[ZTSelectDetailViewController alloc] init];
    
    vc.Title = label.text;
    
    vc.TagString = [NSString stringWithFormat:@"%ld",(long)sender.tag];
    
    [self.navigationController pushViewController:vc animated:NO];
    
    self.navigationController.navigationBar.hidden=YES;
}

-(void)MWThreeBtnCLick1:(UIButton *)sender
{
    UILabel *label = (UILabel *)[sender.superview viewWithTag:sender.tag+100];
    
    NSLog(@"=====%ld====%@",(long)sender.tag,label.text);
    ZTSelectDetailViewController *vc = [[ZTSelectDetailViewController alloc] init];
    
    vc.Title = label.text;
    
    vc.TagString = [NSString stringWithFormat:@"%ld",(long)sender.tag];
    
    [self.navigationController pushViewController:vc animated:NO];
    
    self.navigationController.navigationBar.hidden=YES;
    
}

-(void)MWFourBtnCLick1:(UIButton *)sender
{
    UILabel *label = (UILabel *)[sender.superview viewWithTag:sender.tag+100];
    
    NSLog(@"=====%ld====%@",(long)sender.tag,label.text);
    ZTSelectDetailViewController *vc = [[ZTSelectDetailViewController alloc] init];
    
    vc.Title = label.text;
    
    vc.TagString = [NSString stringWithFormat:@"%ld",(long)sender.tag];
    
    [self.navigationController pushViewController:vc animated:NO];
    
    self.navigationController.navigationBar.hidden=YES;
    
}

-(void)MWOneBtnCLick2:(UIButton *)sender
{
    UILabel *label = (UILabel *)[sender.superview viewWithTag:sender.tag+100];
    
    NSLog(@"=====%ld====%@",(long)sender.tag,label.text);
    ZTSelectDetailViewController *vc = [[ZTSelectDetailViewController alloc] init];
    
    vc.Title = label.text;
    
    vc.TagString = [NSString stringWithFormat:@"%ld",(long)sender.tag];
    
    [self.navigationController pushViewController:vc animated:NO];
    
    self.navigationController.navigationBar.hidden=YES;
    
}

-(void)MWTwoBtnCLick2:(UIButton *)sender
{
    UILabel *label = (UILabel *)[sender.superview viewWithTag:sender.tag+100];
    
    NSLog(@"=====%ld====%@",(long)sender.tag,label.text);
    ZTSelectDetailViewController *vc = [[ZTSelectDetailViewController alloc] init];
    
    vc.Title = label.text;
    
    vc.TagString = [NSString stringWithFormat:@"%ld",(long)sender.tag];
    
    [self.navigationController pushViewController:vc animated:NO];
    
    self.navigationController.navigationBar.hidden=YES;
}

-(void)MWThreeBtnCLick2:(UIButton *)sender
{
    UILabel *label = (UILabel *)[sender.superview viewWithTag:sender.tag+100];
    
    NSLog(@"=====%ld====%@",(long)sender.tag,label.text);
    ZTSelectDetailViewController *vc = [[ZTSelectDetailViewController alloc] init];
    
    vc.Title = label.text;
    
    vc.TagString = [NSString stringWithFormat:@"%ld",(long)sender.tag];
    
    [self.navigationController pushViewController:vc animated:NO];
    
    self.navigationController.navigationBar.hidden=YES;
    
}

-(void)MWFourBtnCLick2:(UIButton *)sender
{
    UILabel *label = (UILabel *)[sender.superview viewWithTag:sender.tag+100];
    
    NSLog(@"=====%ld====%@",(long)sender.tag,label.text);
    ZTSelectDetailViewController *vc = [[ZTSelectDetailViewController alloc] init];
    
    vc.Title = label.text;
    
    vc.TagString = [NSString stringWithFormat:@"%ld",(long)sender.tag];
    
    [self.navigationController pushViewController:vc animated:NO];
    
    self.navigationController.navigationBar.hidden=YES;
    
}

-(void)MWOneBtnCLick3:(UIButton *)sender
{
    UILabel *label = (UILabel *)[sender.superview viewWithTag:sender.tag+100];
    
    NSLog(@"=====%ld====%@",(long)sender.tag,label.text);
    ZTSelectDetailViewController *vc = [[ZTSelectDetailViewController alloc] init];
    
    vc.Title = label.text;
    
    vc.TagString = [NSString stringWithFormat:@"%ld",(long)sender.tag];
    
    [self.navigationController pushViewController:vc animated:NO];
    
    self.navigationController.navigationBar.hidden=YES;
    
}

-(void)MWTwoBtnCLick3:(UIButton *)sender
{
    UILabel *label = (UILabel *)[sender.superview viewWithTag:sender.tag+100];
    
    NSLog(@"=====%ld====%@",(long)sender.tag,label.text);
    ZTSelectDetailViewController *vc = [[ZTSelectDetailViewController alloc] init];
    
    vc.Title = label.text;
    
    vc.TagString = [NSString stringWithFormat:@"%ld",(long)sender.tag];
    
    [self.navigationController pushViewController:vc animated:NO];
    
    self.navigationController.navigationBar.hidden=YES;
}

-(void)MWThreeBtnCLick3:(UIButton *)sender
{
    UILabel *label = (UILabel *)[sender.superview viewWithTag:sender.tag+100];
    
    NSLog(@"=====%ld====%@",(long)sender.tag,label.text);
    ZTSelectDetailViewController *vc = [[ZTSelectDetailViewController alloc] init];
    
    vc.Title = label.text;
    
    vc.TagString = [NSString stringWithFormat:@"%ld",(long)sender.tag];
    
    [self.navigationController pushViewController:vc animated:NO];
    
    self.navigationController.navigationBar.hidden=YES;
    
}

-(void)MWFourBtnCLick3:(UIButton *)sender
{
    UILabel *label = (UILabel *)[sender.superview viewWithTag:sender.tag+100];
    
    NSLog(@"=====%ld====%@",(long)sender.tag,label.text);
    ZTSelectDetailViewController *vc = [[ZTSelectDetailViewController alloc] init];
    
    vc.Title = label.text;
    
    vc.TagString = [NSString stringWithFormat:@"%ld",(long)sender.tag];
    
    [self.navigationController pushViewController:vc animated:NO];
    
    self.navigationController.navigationBar.hidden=YES;
    
}

-(void)QurtBtnClick
{
    
    [self.navigationController popViewControllerAnimated:NO];
    self.navigationController.navigationBar.hidden=YES;
    self.tabBarController.tabBar.hidden=NO;
    
}

@end
