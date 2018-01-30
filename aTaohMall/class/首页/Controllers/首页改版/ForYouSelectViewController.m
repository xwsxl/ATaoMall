//
//  ForYouSelectViewController.m
//  aTaohMall
//
//  Created by JMSHT on 2017/6/21.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "ForYouSelectViewController.h"

#import "ForYouSelectCell.h"

#import "ConverUtil.h"
#import "DESUtil.h"
#import "SecretCodeTool.h"

#import "AFNetworking.h"
#import "WKProgressHUD.h"

#import "DPModel.h"
#import "TrainToast.h"

#import "UIImageView+WebCache.h"
//刷新
#import "DJRefresh.h"
#import "DJRefreshProgressView.h"
#import "YTGoodsDetailViewController.h"
@interface ForYouSelectViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    
    UITableView *_tableView;
    
    NSMutableArray *_data;
    
}
@end

@implementation ForYouSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _data = [NSMutableArray new];
    
    [self initNav];
    
    [self initTableView];
    
    [self GetDatas];
    
}

-(void)GetDatas
{
    WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
    
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        
        
    });
    
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数组NSArray类型的数据
    self.sigen=[userDefaultes stringForKey:@"sigen"];
    
    if (self.sigen.length==0) {
        
        self.sigen = @"";
        
    }
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSDictionary *dict=@{@"sigen":self.sigen};
    
    NSString *url=[NSString stringWithFormat:@"%@selectForyouToData_mob.shtml",URL_Str];
    
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
                    
                    model.DP_id = [NSString stringWithFormat:@"%@",dict[@"id"]];
                    model.mid = [NSString stringWithFormat:@"%@",dict[@"mid"]];
                    model.name = [NSString stringWithFormat:@"%@",dict[@"name"]];
                    model.status = [NSString stringWithFormat:@"%@",dict[@"status"]];
                    model.scopeimg = [NSString stringWithFormat:@"%@",dict[@"scopeimg"]];
                    model.pay_maney = [NSString stringWithFormat:@"%@",dict[@"pay_maney"]];
                    model.pay_integer = [NSString stringWithFormat:@"%@",dict[@"pay_integer"]];
                    model.storename = [NSString stringWithFormat:@"%@",dict[@"storename"]];
                    model.tid = [NSString stringWithFormat:@"%@",dict[@"tid"]];
                    model.good_type = [NSString stringWithFormat:@"%@",dict[@"good_type"]];
                    model.amount = [NSString stringWithFormat:@"%@",dict[@"amount"]];
                    model.stock = [NSString stringWithFormat:@"%@",dict[@"stock"]];
                    
                    [_data addObject:model];
                }
                
                
            }else{
                
                [TrainToast showWithText:dic[@"message"] duration:2.0f];
                
            }
            [hud dismiss:YES];
            
            [_tableView reloadData];
            
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
    
    label.text = self.TitleString;
    
    label.textColor = [UIColor blackColor];
    
    label.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:19];
    
    label.textAlignment = NSTextAlignmentCenter;
    
    [titleView addSubview:label];
    
    
}


-(void)initTableView
{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-KSafeAreaTopNaviHeight) style:UITableViewStylePlain];
    
    _tableView.delegate=self;
    
    _tableView.dataSource=self;
    
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    [self.view addSubview:_tableView];
    
    [_tableView registerClass:[ForYouSelectCell class] forCellReuseIdentifier:@"cell"];
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _data.count;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 120;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ForYouSelectCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle =  UITableViewCellSelectionStyleNone;
    
    DPModel *model = _data[indexPath.row];
    
    [cell.GoodsImgView sd_setImageWithURL:[NSURL URLWithString:model.scopeimg] placeholderImage:[UIImage imageNamed:@"default_image"] options:SDWebImageProgressiveDownload];
    
    [cell StatusString:model.status Type:model.stock];
    
    cell.GoodsNameLabel.text = model.name;
    cell.Price = [NSString stringWithFormat:@"￥%.02f+%.02f积分",[model.pay_maney floatValue],[model.pay_integer floatValue]];
    cell.GoodsStoreNameLabel.text = model.storename;
    cell.amount = model.amount;
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DPModel *model = _data[indexPath.row];

    YTGoodsDetailViewController *vc=[[YTGoodsDetailViewController alloc] init];
    
    vc.type= @"2";
    vc.ID = model.DP_id;
    vc.gid = model.DP_id;
    self.navigationController.navigationBar.hidden=YES;
//    self.tabBarController.tabBar.hidden=YES;
    [self.navigationController pushViewController:vc animated:NO];
    
}
-(void)QurtBtnClick
{
    
    [self.navigationController popViewControllerAnimated:NO];
    self.navigationController.navigationBar.hidden=YES;
    self.tabBarController.tabBar.hidden=NO;
    
}
@end
