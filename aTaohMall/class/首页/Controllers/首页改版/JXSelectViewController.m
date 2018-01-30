//
//  JXSelectViewController.m
//  aTaohMall
//
//  Created by JMSHT on 2017/6/21.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "JXSelectViewController.h"

#import "JXSelectCell.h"
#import "JXSelectDetailViewController.h"

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
@interface JXSelectViewController ()<UITableViewDelegate,UITableViewDataSource,DJRefreshDelegate>
{
    
    UITableView *_tableView;
    NSMutableArray *_data;
    
    int page;
    
}
@property (nonatomic,strong)DJRefresh *refresh;
@end

@implementation JXSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    page =0;
    
    _data = [NSMutableArray new];
    
    [self initNav];
    
    [self initTableView];
    
    [self getdatas];
    
}

-(void)getdatas
{
    WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
//    
//    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
//    dispatch_after(time, dispatch_get_main_queue(), ^{
//        
//        
//    });
    
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSDictionary *dict=@{@"page":[NSString stringWithFormat:@"%d",page]};
    
    NSString *url=[NSString stringWithFormat:@"%@getSelectionListingList_mob.shtml",URL_Str];
    
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
                
                for (NSDictionary *dict in dic[@"list_article"]) {
                    
                    DPModel *model = [[DPModel alloc] init];
                    
                    model.YX_id = [NSString stringWithFormat:@"%@",dict[@"id"]];
                    model.YX_name = [NSString stringWithFormat:@"%@",dict[@"summary"]];
                    model.mid = [NSString stringWithFormat:@"%@",dict[@"mid"]];
                    model.title = [NSString stringWithFormat:@"%@",dict[@"title"]];
                    model.YX_picpath = [NSString stringWithFormat:@"%@",dict[@"picpath"]];
                    model.YX_storename = [NSString stringWithFormat:@"%@",dict[@"storename"]];
                    model.recommend_good = [NSString stringWithFormat:@"%@",dict[@"recommend_good"]];
                    model.logo = [NSString stringWithFormat:@"%@",dict[@"logo"]];
                    model.browse_number = [NSString stringWithFormat:@"%@",dict[@"browse_number"]];
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
    
    label.text = @"优选清单";
    
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
    
    [_tableView registerClass:[JXSelectCell class] forCellReuseIdentifier:@"cell"];
    
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
    
    return 252;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JXSelectCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle =  UITableViewCellSelectionStyleNone;
    
    DPModel *model = _data[indexPath.row];
    
    [cell.OneImgView sd_setImageWithURL:[NSURL URLWithString:model.YX_picpath] placeholderImage:[UIImage imageNamed:@"default_image"] options:SDWebImageProgressiveDownload];
    
    cell.TuiJianLabel.text = model.YX_storename;
    
    cell.MainTitle.text = model.title;
    
    cell.OtherTitle.text = model.YX_name;
    
    [cell.LogoImgView sd_setImageWithURL:[NSURL URLWithString:model.logo] placeholderImage:[UIImage imageNamed:@"default_image"] options:SDWebImageProgressiveDownload];
    
    cell.NumberLabel.text = [NSString stringWithFormat:@"推荐了%@件单品",model.recommend_good];
    
    cell.AmountLabel.text = model.browse_number;
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    DPModel *model = _data[indexPath.row];
    
    JXSelectDetailViewController *vc = [[JXSelectDetailViewController alloc] init];
    
    vc.ID = model.YX_id;
    
    [self.navigationController pushViewController:vc animated:NO];
    

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
        
        [self getdatas];
        
        
    }else if(direction==DJRefreshDirectionBottom){
        
        page++;
        
        [self getdatas];
        
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
