//
//  LookAllViewController.m
//  aTaohMall
//
//  Created by JMSHT on 16/5/12.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import "LookAllViewController.h"

#import "LookAllCell.h"

#import "AFNetworking.h"

#import "ConverUtil.h"
#import "DESUtil.h"
#import "SecretCodeTool.h"

#import "WKProgressHUD.h"

#import "goodListModel.h"

#import "UIImageView+WebCache.h"

#import "NewGoodsDetailViewController.h"//商品详情

#import "NoDataCell.h"

//刷新
#import "DJRefresh.h"
#import "DJRefreshProgressView.h"

#import "HomeLookFooter.h"//点击加载更多

#import "UserMessageManager.h"//缓存数据

#import "NewLookAllCell.h"
#import "YTGoodsDetailViewController.h"
@interface LookAllViewController ()<UITableViewDelegate,UITableViewDataSource,DJRefreshDelegate,FooterViewDelegate>
{
    UITableView *_tableView;
    
    NSMutableArray *_datas;
    
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

@implementation LookAllViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.frame=[UIScreen mainScreen].bounds;
    self.lookAllTitleLabel.text=self.titleName;
    
    _datas=[NSMutableArray new];
    
    [self createTableView];
    
    
    //缓存用户sigen
    [UserMessageManager ClassifyId:self.gid];
    
    self.type=@"1";
    
    self.PanDuan=@"0";
    
    
    _typeArrM=[NSMutableArray new];
    [_typeArrM addObject:self.type];
    
    
    page=0;
    currentPageNo=1;
    
    self.AnRenQiLabel.textColor=[UIColor redColor];
    
    [self.RenQiDownButton setBackgroundImage:[UIImage imageNamed:@"排序下1@2x"] forState:0];
    
    //获取数据
    [self getDatas];
    
    WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
    
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        
 
        [hud dismiss:YES];
    });
    
}

-(void)getDatas
{
    //先清空数据源
//    [_datas removeAllObjects];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@getClassificationWhole_mob.shtml",URL_Str];
    //saveUserExchange_mob.shtml
    
    NSLog(@"=====%@",self.gid);
    NSLog(@"=====%@",self.type);
    NSLog(@"==page===%d",page);
    NSLog(@"==currentPageNo===%d",currentPageNo);
    
    
    NSDictionary *dic = @{@"classId":self.gid,@"type":self.type,@"page":[NSString stringWithFormat:@"%d",page],@"currentPageNo":[NSString stringWithFormat:@"%d",currentPageNo]};
    
    
    [manager POST:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
        NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];
        
        
        
        
        if (codeKey && content) {
            NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
            
            NSLog(@"xmlStr%@",xmlStr);
            
            
            NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
//            NSLog(@"分类查看更多书局=%@",dic);
            
            view.hidden=YES;
            
            for (NSDictionary *dict in dic) {
                
                string10=dict[@"totalCount"];
                
                for (NSDictionary *dict1 in dict[@"resultList"]) {
                    
                    goodListModel *model=[[goodListModel alloc] init];
                    
                    model.amount=dict1[@"amount"];//付款人数
                    model.gid=dict1[@"id"];
                    model.name=dict1[@"name"];
                    model.scopeimg=dict1[@"scopeimg"];
                    model.pay_integer=dict1[@"pay_integer"];
                    model.pay_maney=dict1[@"pay_maney"];
                    model.attribute = dict1[@"is_attribute"];
                    model.storename = dict1[@"storename"];
                    [_datas addObject:model];
                    
//                    if (_datas.count%12==0) {
//                        
//                        footer.hidden=NO;
//                        
//                    }else{
//                        
//                        //隐藏点击加载更多
//                        footer.hidden=YES;
//                        
//                    }
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
//                [footer.loadMoreBtn setTitleColor:[UIColor colorWithRed:91/255.0 green:150/255.0 blue:255/255.0 alpha:1.0] forState:0];
                footer.loadMoreBtn.enabled=YES;
                
            }else if (_datas.count == [string10 integerValue]){
                
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
    
    view=[[UIView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    
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
-(void)initview{
    
    _lable = [[UILabel alloc]initWithFrame:CGRectMake(0,[UIScreen mainScreen].bounds.size.height/4 , [UIScreen mainScreen].bounds.size.width, 80)];
    _lable.text = @"暂无更多数据";
    _lable.textColor = [UIColor lightGrayColor];
    _lable.textAlignment = NSTextAlignmentCenter;
    self.view.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1];
    [self.view addSubview:_lable];
    
}
-(void)createTableView
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
//        return 0;
//    }else
    {
        return _datas.count;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_datas.count==0) {
        return 0;
    }else
    {
    
//       return [UIScreen mainScreen].bounds.size.height/4;
        
        return [UIScreen mainScreen].bounds.size.height/3.5;
        
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
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSNull *null=[[NSNull alloc] init];
    
    if (_datas.count==0) {
       NoDataCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
    
//        goodListModel *model=_datas[indexPath.row];
//        
//        LookAllCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        
//        if (![model.scopeimg isEqual:null] && ![model.scopeimg isEqualToString:@""]) {
//            
////            [cell.GoodsImageView sd_setImageWithURL:[NSURL URLWithString:model.scopeimg]];
//            
//            [cell.GoodsImageView sd_setImageWithURL:[NSURL URLWithString:model.scopeimg] placeholderImage:[UIImage imageNamed:@"default_image"] options:SDWebImageProgressiveDownload];
//        }
//        
//        
//        cell.GoodsAmountLabel.text=[NSString stringWithFormat:@"%@人付款",model.amount];
//        
//        cell.GoodsNameLabel.text=model.name;
//        
//        if ([model.pay_maney isEqualToString:@""] || [model.pay_maney isEqualToString:@"0"] || [model.pay_maney isEqualToString:@"0.00"]) {
//            
//            cell.GoodsPriceLabel.text=[NSString stringWithFormat:@"%.02f积分",[model.pay_integer floatValue]];
//            
//        }else if ([model.pay_integer isEqualToString:@""] || [model.pay_integer isEqualToString:@"0"] || [model.pay_integer isEqualToString:@"0.00"]){
//            
//            cell.GoodsPriceLabel.text=[NSString stringWithFormat:@"￥%.02f",[model.pay_maney floatValue]];
//            
//        }else{
//            
//            cell.GoodsPriceLabel.text=[NSString stringWithFormat:@"￥%.02f+%.02f积分",[model.pay_maney floatValue],[model.pay_integer floatValue]];
//        }
        
        NewLookAllCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell3"];
        
        goodListModel *model=_datas[indexPath.row];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (![model.scopeimg isEqual:null] && ![model.scopeimg isEqualToString:@""]) {
            
            //            [cell.GoodsImageView sd_setImageWithURL:[NSURL URLWithString:model.scopeimg]];
            
            [cell.Goods_ImgView sd_setImageWithURL:[NSURL URLWithString:model.scopeimg] placeholderImage:[UIImage imageNamed:@"default_image"] options:SDWebImageProgressiveDownload];
        }
        
        
        cell.Goods_Amount.text=[NSString stringWithFormat:@"%@人付款",model.amount];
        
        cell.Goods_Name.text=model.name;
        
        cell.Goods_storename.text = model.storename;
        
        if ([model.pay_maney isEqualToString:@""] || [model.pay_maney isEqualToString:@"0"] || [model.pay_maney isEqualToString:@"0.00"]) {
            
            cell.Goods_Price.text=[NSString stringWithFormat:@"%.02f积分",[model.pay_integer floatValue]];
            
        }else if ([model.pay_integer isEqualToString:@""] || [model.pay_integer isEqualToString:@"0"] || [model.pay_integer isEqualToString:@"0.00"]){
            
            cell.Goods_Price.text=[NSString stringWithFormat:@"￥%.02f",[model.pay_maney floatValue]];
            
        }else{
            
            cell.Goods_Price.text=[NSString stringWithFormat:@"￥%.02f+%.02f积分",[model.pay_maney floatValue],[model.pay_integer floatValue]];
            
        }
        
        return cell;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    goodListModel *model=_datas[indexPath.row];
    
//    NewGoodsDetailViewController *vc=[[NewGoodsDetailViewController alloc] init];
    
    YTGoodsDetailViewController *vc=[[YTGoodsDetailViewController alloc] init];
    
    vc.gid=model.gid;
    vc.ID=model.gid;
    vc.attribute = model.attribute;
    
    vc.Attribute_back=@"2";
    
    [self.navigationController pushViewController:vc animated:NO];
    
    self.navigationController.navigationBar.hidden=YES;
    
}
//返回
- (IBAction)backBtnClick:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
//    self.navigationController.navigationBar.hidden=NO;
    
    self.tabBarController.tabBar.hidden=NO;
}

//人气升
- (IBAction)RenQiUpBtnClick:(UIButton *)sender {
    
    self.type=@"2";
    
    self.AnRenQiLabel.textColor=[UIColor redColor];
    self.AnJiaGeLabel.textColor=[UIColor blackColor];
    
    
    [self.RenQiDownButton setBackgroundImage:[UIImage imageNamed:@"排序下@2x"] forState:0];
    [self.RenQiUpButton setBackgroundImage:[UIImage imageNamed:@"排序上1@2x"] forState:0];
    
    [self.JIaGeDownButton setBackgroundImage:[UIImage imageNamed:@"排序下@2x"] forState:0];
    [self.JiaGeUpButton setBackgroundImage:[UIImage imageNamed:@"排序上@2x"] forState:0];
    
    //获取数据
    [self getDatas];
    
    WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
    
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        

        [hud dismiss:YES];
    });
    
    [_tableView reloadData];
}
//人气降
- (IBAction)RenQiDownBtnClick:(UIButton *)sender {
    
    self.type=@"1";
    
    self.AnRenQiLabel.textColor=[UIColor redColor];
    self.AnJiaGeLabel.textColor=[UIColor blackColor];
    
    [self.RenQiDownButton setBackgroundImage:[UIImage imageNamed:@"排序下1@2x"] forState:0];
    [self.RenQiUpButton setBackgroundImage:[UIImage imageNamed:@"排序上@2x"] forState:0];
    
    [self.JIaGeDownButton setBackgroundImage:[UIImage imageNamed:@"排序下@2x"] forState:0];
    [self.JiaGeUpButton setBackgroundImage:[UIImage imageNamed:@"排序上@2x"] forState:0];
    
    //获取数据
    [self getDatas];
    
    WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
    
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        

        [hud dismiss:YES];
    });
    
    [_tableView reloadData];
}

//价格升
- (IBAction)JiaGeUpBtnClick:(UIButton *)sender {
    
    self.type=@"4";
    
    self.AnRenQiLabel.textColor=[UIColor blackColor];
    self.AnJiaGeLabel.textColor=[UIColor redColor];
    [self.RenQiDownButton setBackgroundImage:[UIImage imageNamed:@"排序下@2x"] forState:0];
    [self.RenQiUpButton setBackgroundImage:[UIImage imageNamed:@"排序上@2x"] forState:0];
    
    [self.JIaGeDownButton setBackgroundImage:[UIImage imageNamed:@"排序下@2x"] forState:0];
    [self.JiaGeUpButton setBackgroundImage:[UIImage imageNamed:@"排序上1@2x"] forState:0];
    
    //获取数据
    [self getDatas];
    
    WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
    
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        

        [hud dismiss:YES];
    });
    
    [_tableView reloadData];
    
}

//价格降
- (IBAction)JiaGeDownBtnClick:(UIButton *)sender {
    
    self.type=@"3";
    
    self.AnRenQiLabel.textColor=[UIColor blackColor];
    self.AnJiaGeLabel.textColor=[UIColor redColor];
    
    [self.RenQiDownButton setBackgroundImage:[UIImage imageNamed:@"排序下@2x"] forState:0];
    [self.RenQiUpButton setBackgroundImage:[UIImage imageNamed:@"排序上@2x"] forState:0];
    
    [self.JIaGeDownButton setBackgroundImage:[UIImage imageNamed:@"排序下1@2x"] forState:0];
    [self.JiaGeUpButton setBackgroundImage:[UIImage imageNamed:@"排序上@2x"] forState:0];
    
    //获取数据
    [self getDatas];
    
    WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
    
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        

        [hud dismiss:YES];
    });
    
    [_tableView reloadData];
    
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
        
        [_typeArrM removeAllObjects];
        [_datas removeAllObjects];
        
        NSLog(@"===sort======%@",self.type);
        //获取数据
        [self getDatas];
        
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
    if (_datas.count==0) {
        footer.hidden = YES;
    }
    
    
    return footer;
}
//加载更多数据代理方法
- (void)FooterViewClickedloadMoreData
{
    NSLog(@"点击加载更多");
    
    self.PanDuan=@"1";
//    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
//    //读取数组NSArray类型的数据
//    self.type=[userDefaultes stringForKey:@"type"];
    
    for (NSString *string in _typeArrM) {
        
        self.type=string;
    }
    
    NSLog(@"===sort======%@",self.type);
    
//    NSLog(@">>>>>>%@",[userDefaultes stringForKey:@"classifyId"]);
    
    if (_datas.count%12==0) {
        
        currentPageNo=currentPageNo+1;
        
        page=page+1;
        
        //获取数据
        [self getDatas];
        
        [_tableView reloadData];
        
    }else{
        
    }
}

//按人气

- (IBAction)AnRenQiBtnCLick:(UIButton *)sender {
    
    sender.selected=!sender.selected;
    
    //去掉蓝色背景
    sender.tintColor=[UIColor clearColor];
    
    if (sender.selected) {
        
        self.PanDuan=@"0";
        self.type=@"2";
        
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
        
        [self.JIaGeDownButton setBackgroundImage:[UIImage imageNamed:@"排序下@2x"] forState:0];
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
        
        [_typeArrM removeAllObjects];
        
        [_typeArrM addObject:self.type];
        
        self.AnRenQiLabel.textColor=[UIColor redColor];
        self.AnJiaGeLabel.textColor=[UIColor blackColor];
        
        [self.RenQiDownButton setBackgroundImage:[UIImage imageNamed:@"排序下1@2x"] forState:0];
        [self.RenQiUpButton setBackgroundImage:[UIImage imageNamed:@"排序上@2x"] forState:0];
        
        [self.JIaGeDownButton setBackgroundImage:[UIImage imageNamed:@"排序下@2x"] forState:0];
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
        
        [self.JIaGeDownButton setBackgroundImage:[UIImage imageNamed:@"排序下1@2x"] forState:0];
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
        
        [self.JIaGeDownButton setBackgroundImage:[UIImage imageNamed:@"排序下@2x"] forState:0];
        [self.JiaGeUpButton setBackgroundImage:[UIImage imageNamed:@"排序上1@2x"] forState:0];
        
        [_datas removeAllObjects];
        
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

//-(void)readNSUserDefaults{//取出缓存的数据
//    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
//    //读取数组NSArray类型的数据
//    self.UserName=[userDefaultes stringForKey:@"myArray"];
//    self.portrait=[userDefaultes stringForKey:@"header"];
//    
//    self.again=[userDefaultes stringForKey:@"time"];
//    [_tableView reloadData];
//    //    NSLog(@"UserName======%@",name);
//}
@end
