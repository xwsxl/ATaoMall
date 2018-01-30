//
//  DPCommandViewController.m
//  aTaohMall
//
//  Created by JMSHT on 2017/6/21.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "DPCommandViewController.h"

#import "DPCommandCell.h"

#import "DPCommandDetailViewController.h"

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
@interface DPCommandViewController ()<UITableViewDelegate,UITableViewDataSource,DJRefreshDelegate>
{
    
    UITableView *_tableView;
    NSMutableArray *_data;
    int page;
}
@property (nonatomic,strong)DJRefresh *refresh;
@end

@implementation DPCommandViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    page = 0;
    _data  = [NSMutableArray new];
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
    
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSDictionary *dict=@{@"page":[NSString stringWithFormat:@"%d",page]};
    
    NSString *url=[NSString stringWithFormat:@"%@selectBrandToData_mob.shtml",URL_Str];
    
    [manager POST:url parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        
    } success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
        NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];
        
        if (page==0) {
            
            [_data removeAllObjects];
        }
        
        
        
        if (codeKey && content) {
            NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
            
            NSLog(@"=======xmlStr%@",xmlStr);
            
            
            NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];
            
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            if ([dic[@"status"] isEqualToString:@"10000"]) {
                
                for (NSDictionary *dict in dic[@"list"]) {
                    
                    DPModel *model = [[DPModel alloc] init];
                    
                    model.DP_id = [NSString stringWithFormat:@"%@",dict[@"id"]];
                    model.cream_name = [NSString stringWithFormat:@"%@",dict[@"cream_name"]];
                    model.picpath = [NSString stringWithFormat:@"%@",dict[@"picpath"]];
                    model.remarks = [NSString stringWithFormat:@"%@",dict[@"represent"]];
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
    
    _tableView.backgroundColor = [UIColor colorWithRed:228/255.0 green:233/255.0 blue:234/255.0 alpha:1.0];
    
    [self.view addSubview:_tableView];
    
    [_tableView registerClass:[DPCommandCell class] forCellReuseIdentifier:@"cell"];
    
    _refresh=[[DJRefresh alloc] initWithScrollView:_tableView delegate:self];
    _refresh.topEnabled=YES;//下拉刷新
    _refresh.bottomEnabled=YES;//上拉加载
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _data.count;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 130;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    DPCommandCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle =  UITableViewCellSelectionStyleNone;
    
    DPModel *model = _data[indexPath.row];
    
    [cell.GoodsImgView sd_setImageWithURL:[NSURL URLWithString:model.picpath] placeholderImage:[UIImage imageNamed:@"default_image"] options:SDWebImageProgressiveDownload];
    
    cell.GoodsNameLabel.text = model.remarks;
    
    //最后一个影藏

    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    DPModel *model = _data[indexPath.row];
    
    DPCommandDetailViewController *vc = [[DPCommandDetailViewController alloc] init];
    
    vc.Title = model.cream_name;
    vc.ID = model.DP_id;
    
    [self.navigationController pushViewController:vc animated:NO];
    self.navigationController.navigationBar.hidden=YES;
    
    
}

#pragma 下拉刷新

- (void)refresh:(DJRefresh *)refresh didEngageRefreshDirection:(DJRefreshDirection)direction{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self addDataWithDirection:direction];
    });
    
}

- (void)addDataWithDirection:(DJRefreshDirection)direction{
    
    if (direction==DJRefreshDirectionTop) {
        
        page = 0;
        
        [self GetDatas];
        
        
    }else if(direction==DJRefreshDirectionBottom){
        
        page++;
        
        [self GetDatas];
        
    }
    
    
    
    [_refresh finishRefreshingDirection:direction animation:YES];
    
    [_tableView reloadData];
    
}

-(void)QurtBtnClick
{
    
    [self.navigationController popViewControllerAnimated:NO];
    self.navigationController.navigationBar.hidden=YES;
    self.tabBarController.tabBar.hidden=NO;
    
}

@end
