//
//  HomeLookAllViewController.m
//  aTaohMall
//
//  Created by JMSHT on 16/6/15.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import "HomeLookAllViewController.h"

#import "AFNetworking.h"

#import "ConverUtil.h"
#import "DESUtil.h"
#import "SecretCodeTool.h"

#import "HomeLookAllModel.h"

#import "LookAllCell.h"

#import "NewLookAllCell.h"
#import "UIImageView+WebCache.h"

#import "NewGoodsDetailViewController.h"//商品详情

#import "WKProgressHUD.h"

//刷新
#import "DJRefresh.h"
#import "DJRefreshProgressView.h"

#import "HomeLookFooter.h"//点击加载更多

#import "UserMessageManager.h"

#import "NoDataCell.h"

#import "YTGoodsDetailViewController.h"
@interface HomeLookAllViewController ()<UITableViewDataSource,UITableViewDelegate,DJRefreshDelegate,FooterViewDelegate>
{
    NSMutableArray *_datas;
    
    UITableView *_tableView;
    
    HomeLookFooter *footer;
    
    int page;
    int currentPageNo;
    
    NSMutableArray *_typeArrM;
    
    NSString *string10;
    
    UIView *view;
    
}

@property (nonatomic,strong)DJRefresh *refresh;
@property(nonatomic,strong)UILabel *lable;//暂无数据

@end

@implementation HomeLookAllViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _datas=[NSMutableArray new];
    self.view.frame=[UIScreen mainScreen].bounds;
    _typeArrM=[NSMutableArray new];
    
    self.type=@"1";
    
    self.PanDuan=@"0";
    [_typeArrM addObject:self.type];
    
    page=0;
    currentPageNo=1;
    
    self.AnRenQiLabel.textColor=[UIColor redColor];
    
    [self.RenQiDownButton setBackgroundImage:[UIImage imageNamed:@"排序下1@2x"] forState:0];
    
    
    //获取数据
    [self getDatas];
    [self initTableView];
    WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        [hud dismiss:YES];
    });
    
    //    [self getDatas];
    
    // code1
    if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    
    // code2
    if ([_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [_tableView setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    
}
-(void)initview{
    
    _lable = [[UILabel alloc]initWithFrame:CGRectMake(0,[UIScreen mainScreen].bounds.size.height/10 , [UIScreen mainScreen].bounds.size.width, 80)];
    _lable.text = @"暂无更多数据";
    _lable.textColor = [UIColor lightGrayColor];
    _lable.textAlignment = NSTextAlignmentCenter;
    self.view.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1];
    [self.view addSubview:_lable];
    
}
-(void)initTableView
{
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 115, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-115) style:UITableViewStyleGrouped];
    
    _tableView.delegate=self;
    
    _tableView.dataSource=self;
    
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    _tableView.separatorColor = [UIColor colorWithRed:212.0f/255.0f green:212.0f/255.0f blue:212.0f/255.0f alpha:1.0];

    
    [self.view addSubview:_tableView];
    
    [_tableView registerNib:[UINib nibWithNibName:@"LookAllCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    [_tableView registerNib:[UINib nibWithNibName:@"NoDataCell" bundle:nil] forCellReuseIdentifier:@"cell2"];
    
    [_tableView registerClass:[NewLookAllCell class] forCellReuseIdentifier:@"cell3"];
    
    [_tableView registerNib:[UINib nibWithNibName:@"HomeLookFooter" bundle:nil] forHeaderFooterViewReuseIdentifier:@"header"];
    //点击加载更多
    
    
    _refresh=[[DJRefresh alloc] initWithScrollView:_tableView delegate:self];
    _refresh.topEnabled=YES;//下拉刷新
    _refresh.bottomEnabled=NO;//上拉加载
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //    if (_datas.count==0) {
    //        return 1;
    //    }else
    {
        return _datas.count;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_datas.count==0) {
        return 0;
    }else{
        
//        return [UIScreen mainScreen].bounds.size.height/4+8;
        return [UIScreen mainScreen].bounds.size.height/3.5;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (_datas.count==0) {
        
        NoDataCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell2"];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
        
    }else{
        
        HomeLookAllModel *model=_datas[indexPath.row];
        
//        LookAllCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
        
        NewLookAllCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell3"];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
//        [cell.GoodsImageView sd_setImageWithURL:[NSURL URLWithString:model.scopeimg]];
        
//        [cell.GoodsImageView sd_setImageWithURL:[NSURL URLWithString:model.scopeimg] placeholderImage:[UIImage imageNamed:@"default_image"] options:SDWebImageProgressiveDownload options:SDWebImageRetryFailed];
        
        [cell.Goods_ImgView sd_setImageWithURL:[NSURL URLWithString:model.scopeimg] placeholderImage:[UIImage imageNamed:@"default_image"] options:SDWebImageProgressiveDownload];
        
        cell.Goods_Name.text=model.name;
        cell.Goods_storename.text = model.storename;
        cell.Goods_Amount.text=[NSString stringWithFormat:@"%@人付款",model.amount];
        
        //        cell.GoodsPriceLabel.text=[NSString stringWithFormat:@"￥%@+%@积分",model.pay_maney,model.pay_integer];
        
        if ([model.pay_integer isEqualToString:@"0"] || [model.pay_integer isEqualToString:@"0.00"]) {
            
            cell.Goods_Price.text=[NSString stringWithFormat:@"￥%.02f",[model.pay_maney floatValue]];
            
        }else if ([model.pay_maney isEqualToString:@"0"] || [model.pay_maney isEqualToString:@"0.00"]){
            
            cell.Goods_Price.text=[NSString stringWithFormat:@"%.02f积分",[model.pay_integer floatValue]];
            
        }else{
            cell.Goods_Price.text=[NSString stringWithFormat:@"￥%.02f+%.02f积分",[model.pay_maney floatValue],[model.pay_integer floatValue]];
        }
        return cell;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0000000001;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[UIView alloc]init];
}
-(void)getDatas
{
    
    //    [_datas removeAllObjects];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@getHomePageAllGoods_mob.shtml",URL_Str];
    
    
    NSLog(@"===self.classId==%@",self.classId);
    NSLog(@"===self.type==%@",self.type);
    NSLog(@"==page===%d",page);
    NSLog(@"==currentPageNo===%d",currentPageNo);
    
    NSDictionary *dic = @{@"classId":self.classId,@"type":self.type,@"page":[NSString stringWithFormat:@"%d",page],@"currentPageNo":[NSString stringWithFormat:@"%d",currentPageNo]};//,@"status":@"3"};
    
    [manager POST:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
        NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];
        
        if (codeKey && content) {
            NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
            
            //NSLog(@"xmlStr%@",xmlStr);
            
            
            NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];
            
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
//            NSLog(@"77777777%@",dic);
            
            view.hidden=YES;
            
            
//            if (page == 0) {
                
                
 //               [_datas removeAllObjects];
//                [_typeArrM removeAllObjects];
                
//            }
            
            
            for (NSDictionary *dict1 in dic) {
                
                string10=dict1[@"totalCount"];
                
                for (NSDictionary *dict2 in dict1[@"resultList"]) {
                    HomeLookAllModel *model=[[HomeLookAllModel alloc] init];
                    
                    model.amount=dict2[@"amount"];
                    model.end_time_str=dict2[@"end_time_str"];
                    model.id=dict2[@"id"];
                    model.name=dict2[@"name"];
                    
                    NSLog(@"=====%@===%@==",model.name,model.id);
                    model.storename = dict2[@"storename"];
                    model.pay_integer=dict2[@"pay_integer"];
                    model.pay_maney=dict2[@"pay_maney"];
                    model.scopeimg=dict2[@"scopeimg"];
                    model.start_time_str=dict2[@"start_time_str"];
                    model.total_price=dict2[@"total_price"];
                    model.type=dict2[@"type"];
                    model.good_type=dict2[@"good_type"];
                    model.attribute = dict2[@"is_attribute"];
                    [_datas addObject:model];
                    
                    
                }
            }
            if (_datas.count == 0) {
                [self initview];
                _refresh.topEnabled=NO;//下拉刷新
                _lable.hidden = NO;
            }else{
                _lable.hidden = YES;
            }

            if (_datas.count%12==0&&_datas.count !=[string10 integerValue]) {
                
                footer.hidden=NO;
                [footer.loadMoreBtn setTitle:@"点击加载更多" forState:0];
//               [footer.loadMoreBtn setTitleColor:[UIColor colorWithRed:91/255.0 green:150/255.0 blue:255/255.0 alpha:1.0] forState:0];
                footer.loadMoreBtn.enabled=YES;
                
            }else if (_datas.count == [string10 integerValue]){
                footer.hidden = NO;
                footer.moreView.hidden=YES;
                [footer.loadMoreBtn setTitle:@"暂无更多数据" forState:0];
                [footer.loadMoreBtn setTitleColor:[UIColor colorWithRed:154/255.0 green:154/255.0 blue:154/255.0 alpha:1.0] forState:0];
                footer.loadMoreBtn.enabled=NO;
                
                
            }else{
                
                //隐藏点击加载更多
                footer.hidden=YES;
                
            }

            
            
            NSLog(@"===puanduan======%@",self.PanDuan);
            
            if ([self.PanDuan isEqualToString:@"0"]) {
                
                
                //回到头部
                [_tableView setContentOffset:CGPointZero animated:YES];
                
            }else{
                
//                [self addDataWithDirection:DJRefreshDirectionTop];
                
            }
            
            
            [_tableView reloadData];
            
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
//        [WKProgressHUD popMessage:@"网络请求失败，请检查您的网络设置" inView:self.view duration:1.5 animated:YES];
        
        [self NoWebSeveice];
        
        NSLog(@"%@",error);
    }];
}


-(void)NoWebSeveice
{
    
    view=[[UIView alloc] initWithFrame:CGRectMake(0, 644, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    
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

-(void)loadData{
    
    WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
    
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        [hud dismiss:YES];
    });
    
    [self getDatas];
    
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)])
    {
        [cell setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
    {
        [cell setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeLookAllModel *model=_datas[indexPath.row];
    
//    NewGoodsDetailViewController *vc=[[NewGoodsDetailViewController alloc] init];
    
    YTGoodsDetailViewController *vc=[[YTGoodsDetailViewController alloc] init];
    vc.ID=model.id;
    vc.gid=model.id;
    vc.good_type=model.good_type;
    vc.attribute = model.attribute;
    vc.Attribute_back=@"2";
    
    [self.navigationController pushViewController:vc animated:NO];
    
    self.navigationController.navigationBar.hidden=YES;
}



- (IBAction)backBtnClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
    self.tabBarController.tabBar.hidden=NO;
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
        
//        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
//        //读取数组NSArray类型的数据
//        self.type=[userDefaultes stringForKey:@"type"];
        
        for (NSString *string in _typeArrM) {
            
            self.type=string;
        }
        
        NSLog(@"===sort======%@",self.type);
        
        [_datas removeAllObjects];
        [_typeArrM removeAllObjects];
        
        
        //获取数据
        [self getDatas];
        //
        //        WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
        //
        //        dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
        //        dispatch_after(time, dispatch_get_main_queue(), ^{
        //
        //            [hud dismiss:YES];
        //        });
    }
    
    
    
    [_refresh finishRefreshingDirection:direction animation:YES];
    
    [_tableView reloadData];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 44;
}


-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    footer=[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
    
    
    footer.DataCount=[NSString stringWithFormat:@"%ld",(unsigned long)_datas.count];
    footer.totalCount=string10;
    
    
    footer.delegate=self;
    if (_datas.count == 0) {
        footer.hidden = YES;
    }
    return footer;
}
//加载更多数据代理方法
- (void)FooterViewClickedloadMoreData
{
    
    self.PanDuan=@"1";
    NSLog(@"点击加载更多");
    
//    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
//    //读取数组NSArray类型的数据
//    self.type=[userDefaultes stringForKey:@"type"];
//
    
    for (NSString *string in _typeArrM) {
        
        self.type=string;
    }
    NSLog(@"===sort======%@",self.type);
    
    //    NSLog(@">>>>>>%@",[userDefaultes stringForKey:@"classifyId"]);
    
    if (_datas.count%12==0) {
        
        currentPageNo=currentPageNo+1;
        
        page=page+12;
        
        //获取数据
        [self getDatas];
        
        //        WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
        //
        //        dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
        //        dispatch_after(time, dispatch_get_main_queue(), ^{
        //
        //
        //            [hud dismiss:YES];
        //
        //        });
        
        
        [_tableView reloadData];
        
    }else{
        
        //        footer
    }
}

//按人气

- (IBAction)AnRenQiBtnClick:(UIButton *)sender {
    
    
    sender.selected=!sender.selected;
    
    //去掉蓝色背景
    sender.tintColor=[UIColor clearColor];
    
    if (sender.selected) {
        
        
        self.type=@"2";
        self.PanDuan=@"0";
        page=0;
        currentPageNo=1;
        
        //        //缓存排序type
        //        [UserMessageManager SortType:self.type];
        
        [_typeArrM removeAllObjects];
        
        [_typeArrM addObject:self.type];
        
        self.AnRenQiLabel.textColor=[UIColor redColor];
        self.AnJiaGeLabel.textColor=[UIColor blackColor];
        
        
        [self.RenQiDownButton setBackgroundImage:[UIImage imageNamed:@"排序下@2x"] forState:0];
        [self.RenQiUpButton setBackgroundImage:[UIImage imageNamed:@"排序上1@2x"] forState:0];
        
        [self.JiaGeDownButton setBackgroundImage:[UIImage imageNamed:@"排序下@2x"] forState:0];
        [self.JiaGeUpButton setBackgroundImage:[UIImage imageNamed:@"排序上@2x"] forState:0];
        
        [_datas removeAllObjects];
        
        
        
        //获取数据
        [self getDatas];
        
        
        [_tableView reloadData];
        
        WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
        
        dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
        dispatch_after(time, dispatch_get_main_queue(), ^{
            
            
            
            [hud dismiss:YES];
        });
        
    }else{
        
        self.PanDuan=@"0";
        self.type=@"1";
        
        page=0;
        currentPageNo=1;
        
        //        //缓存排序type
        //        [UserMessageManager SortType:self.type];
        
        [_typeArrM removeAllObjects];
        
        [_typeArrM addObject:self.type];
        
        self.AnRenQiLabel.textColor=[UIColor redColor];
        self.AnJiaGeLabel.textColor=[UIColor blackColor];
        
        [self.RenQiDownButton setBackgroundImage:[UIImage imageNamed:@"排序下1@2x"] forState:0];
        [self.RenQiUpButton setBackgroundImage:[UIImage imageNamed:@"排序上@2x"] forState:0];
        
        [self.JiaGeDownButton setBackgroundImage:[UIImage imageNamed:@"排序下@2x"] forState:0];
        [self.JiaGeUpButton setBackgroundImage:[UIImage imageNamed:@"排序上@2x"] forState:0];
        
        [_datas removeAllObjects];
        
        //回到头部
//        [_tableView setContentOffset:CGPointZero animated:YES];
        
        //获取数据
        [self getDatas];
        
        [_tableView reloadData];
        
        WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
        
        dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
        dispatch_after(time, dispatch_get_main_queue(), ^{
            
            
            
            [hud dismiss:YES];
        });
    }
    
    
}

//按价格

- (IBAction)AnJiaGeBtnClick:(UIButton *)sender {
    
    
    
    sender.selected=!sender.selected;
    
    //去掉蓝色背景
    sender.tintColor=[UIColor clearColor];
    
    if (sender.selected) {
        
        
        self.type=@"3";
        self.PanDuan=@"0";
        page=0;
        currentPageNo=1;
        
        //        //缓存排序type
        //        [UserMessageManager SortType:self.type];
        
        
        [_typeArrM removeAllObjects];
        
        [_typeArrM addObject:self.type];
        
        
        self.AnRenQiLabel.textColor=[UIColor blackColor];
        self.AnJiaGeLabel.textColor=[UIColor redColor];
        
        [self.RenQiDownButton setBackgroundImage:[UIImage imageNamed:@"排序下@2x"] forState:0];
        [self.RenQiUpButton setBackgroundImage:[UIImage imageNamed:@"排序上@2x"] forState:0];
        
        [self.JiaGeDownButton setBackgroundImage:[UIImage imageNamed:@"排序下1@2x"] forState:0];
        [self.JiaGeUpButton setBackgroundImage:[UIImage imageNamed:@"排序上@2x"] forState:0];
        
        [_datas removeAllObjects];
        
        //回到头部
//        [_tableView setContentOffset:CGPointZero animated:YES];
        
        //获取数据
        [self getDatas];
        
        [_tableView reloadData];
        WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
        
        dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
        dispatch_after(time, dispatch_get_main_queue(), ^{
            
            
            
            [hud dismiss:YES];
        });
        
        
    }else{
        
        self.type=@"4";
        
        self.PanDuan=@"0";
        page=0;
        currentPageNo=1;
        
        //        //缓存排序type
        //        [UserMessageManager SortType:self.type];
        
        [_typeArrM removeAllObjects];
        
        [_typeArrM addObject:self.type];
        
        
        self.AnRenQiLabel.textColor=[UIColor blackColor];
        self.AnJiaGeLabel.textColor=[UIColor redColor];
        [self.RenQiDownButton setBackgroundImage:[UIImage imageNamed:@"排序下@2x"] forState:0];
        [self.RenQiUpButton setBackgroundImage:[UIImage imageNamed:@"排序上@2x"] forState:0];
        
        [self.JiaGeDownButton setBackgroundImage:[UIImage imageNamed:@"排序下@2x"] forState:0];
        [self.JiaGeUpButton setBackgroundImage:[UIImage imageNamed:@"排序上1@2x"] forState:0];
        
        [_datas removeAllObjects];
        
        //回到头部
//        [_tableView setContentOffset:CGPointZero animated:YES];
        
        //获取数据
        [self getDatas];
        
        
        [_tableView reloadData];
        WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
        
        dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
        dispatch_after(time, dispatch_get_main_queue(), ^{
            
            
            
            [hud dismiss:YES];
        });
        
        
    }
}

@end
