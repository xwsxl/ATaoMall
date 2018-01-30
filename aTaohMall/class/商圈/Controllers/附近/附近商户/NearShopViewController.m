//
//  NearShopViewController.m
//  aTaohMall
//
//  Created by JMSHT on 16/5/12.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import "NearShopViewController.h"

#import "NearShopCell.h"

#import "AFNetworking.h"

#import "ConverUtil.h"
#import "DESUtil.h"
#import "SecretCodeTool.h"

#import "CityModel.h"
#import "UIImageView+WebCache.h"

#import "GotoShopLookViewController.h"//进店看看


//刷新
#import "DJRefresh.h"
#import "DJRefreshProgressView.h"

#import "WKProgressHUD.h"

#import "HomeLookFooter.h"//点击加载更多

#import "NearByNoCell.h"
@interface NearShopViewController ()<UITableViewDataSource,UITableViewDelegate,DJRefreshDelegate,FooterViewDelegate>
{
    UITableView *_tableView;
    
    
    
    NSMutableArray *_datasArrM;
    
    int _page;
    int _currentPageNo;
    
    HomeLookFooter *footer;
    
    NSString *string10;
    
    UIView *view;
}

@property (nonatomic,strong)DJRefresh *refresh;
@property(nonatomic,strong)UILabel *lable;//暂无数据
@end

@implementation NearShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _page=0;
    _currentPageNo=1;
    
    _datasArrM=[NSMutableArray new];
    
    self.navigationController.navigationBar.hidden=YES;
    self.tabBarController.tabBar.hidden=YES;
    
    UIView *view1=[[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64)];
    view1.backgroundColor=[UIColor whiteColor];
    
    UIButton *LeftButton=[UIButton buttonWithType:UIButtonTypeCustom];
    LeftButton.frame=CGRectMake(10, 25, 30, 30);
//    [LeftButton setImage:[UIImage imageNamed:@"左返回"] forState:0];
    
    [LeftButton setBackgroundImage:[UIImage imageNamed:@"iconfont-fanhui2副本"] forState:0];
    
    [LeftButton addTarget:self action:@selector(backbtnClick) forControlEvents:UIControlEventTouchUpInside];
    [view1 addSubview:LeftButton];
    
    UILabel *titleLab=[[UILabel alloc] initWithFrame:CGRectMake(100, 25, [UIScreen mainScreen].bounds.size.width-200, 30)];
    titleLab.text=@"附近商户";
    titleLab.font=[UIFont systemFontOfSize:20];
    titleLab.textAlignment=NSTextAlignmentCenter;//居中
    
    [view1 addSubview:titleLab];
    
    
    [self.view addSubview:view1];
    
    
    self.view.frame=[UIScreen mainScreen].bounds;
    
    //创建UITableView
    [self createTableView];
    
    //获取数据
    [self getDatas];
    
    //加载数据
    WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
    
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        

        [hud dismiss:YES];
    });
    
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

-(void)getDatas
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    
    NSString *string=[NSString stringWithFormat:@"%@,%@",self.jindu,self.weidu];
    
//    NSString *string1=[NSString stringWithFormat:@"113.980066,22.543784"];
    NSLog(@"====%@",string);
    
    NSDictionary *dict=@{@"coordinates":string,@"page":[NSString stringWithFormat:@"%d",_page],@"currentPageNo":[NSString stringWithFormat:@"%d",_currentPageNo]};
    
    NSString *url=[NSString stringWithFormat:@"%@getNearbyMerchants_mob.shtml",URL_Str];
    
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
            
//            if (_page==0) {
//                
//                [_datasArrM removeAllObjects];
//            }
            
            view.hidden=YES;
            
            for (NSDictionary *dict1 in dic) {
                string10 = dict1[@"totalCount"];
                for (NSDictionary *dict2 in dict1[@"nearbyMerchantsList"]) {
                    CityModel *model=[[CityModel alloc] init];
                    NSString *distance_str=dict2[@"distance_str"];
//                    NSString *id=dict2[@"id"];
                    NSString *logo=dict2[@"logo"];
                    NSString *note=dict2[@"note"];
                    NSString *storename=dict2[@"storename"];
                    
                    model.distance_str=distance_str;
                    model.mid=dict2[@"mid"];;
                    model.logo=logo;
                    model.note=note;
                    model.storename=storename;
                    
                    [_datasArrM addObject:model];
                    
//                    if (_datasArrM.count%12==0) {
//                        
//                        footer.hidden=NO;
//                        
//                    }else{
//                        
//                        //隐藏点击加载更多
//                        footer.hidden=YES;
//                        
//                    }
                    
                    NSLog(@"========%ld",_datasArrM.count);
                    
                }
            }
//            if (_datasArrM.count%12==0) {
//                
//                footer.hidden=NO;
//                
//            }else{
//                
//                //隐藏点击加载更多
//                footer.hidden=YES;
//                
//            }
            
            if (_datasArrM.count%12==0&&_datasArrM.count !=[string10 integerValue]) {
                
                footer.hidden=NO;
                [footer.loadMoreBtn setTitle:@"点击加载更多" forState:0];
//                [footer.loadMoreBtn setTitleColor:[UIColor colorWithRed:91/255.0 green:150/255.0 blue:255/255.0 alpha:1.0] forState:0];
                footer.loadMoreBtn.enabled=YES;
                
            }else if (_datasArrM.count == [string10 integerValue]){
                footer.hidden = NO;
                footer.moreView.hidden=YES;
                [footer.loadMoreBtn setTitle:@"暂无更多数据" forState:0];
                [footer.loadMoreBtn setTitleColor:[UIColor colorWithRed:154/255.0 green:154/255.0 blue:154/255.0 alpha:1.0] forState:0];
                footer.loadMoreBtn.enabled=NO;
                
                
            }else{
                
                //隐藏点击加载更多
                footer.hidden=YES;
                
            }
            if (_datasArrM.count == 0) {
                
                [self initview];
                _refresh.topEnabled=NO;//下拉刷新
                _lable.hidden = NO;
                
            }else{
                
                _lable.hidden = YES;
                
            }
            //刷新数据
            [_tableView reloadData];
            
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
//        [WKProgressHUD popMessage:@"网络请求失败，请检查您的网络设置" inView:self.view duration:1.5 animated:YES];
        
        [self NoWebSeveice];
        
        NSLog(@"errpr = %@",error);
    }];
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
    
    _lable = [[UILabel alloc]initWithFrame:CGRectMake(0,[UIScreen mainScreen].bounds.size.height/10 , [UIScreen mainScreen].bounds.size.width, 80)];
    _lable.text = @"暂无更多数据";
    _lable.textColor = [UIColor lightGrayColor];
    _lable.textAlignment = NSTextAlignmentCenter;
    self.view.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1];
    [self.view addSubview:_lable];
    
}
-(void)createTableView
{
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64) style:UITableViewStyleGrouped];
    
    _tableView.delegate=self;
    
    _tableView.dataSource=self;
    
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    _tableView.separatorColor = [UIColor colorWithRed:212.0f/255.0f green:212.0f/255.0f blue:212.0f/255.0f alpha:1.0];
    
    [self.view addSubview:_tableView];
    
    [_tableView registerNib:[UINib nibWithNibName:@"NearShopCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    
    
    [_tableView registerNib:[UINib nibWithNibName:@"NearByNoCell" bundle:nil] forCellReuseIdentifier:@"cell1"];
    
    [_tableView registerNib:[UINib nibWithNibName:@"HomeLookFooter" bundle:nil] forHeaderFooterViewReuseIdentifier:@"header"];
    
    _refresh=[[DJRefresh alloc] initWithScrollView:_tableView delegate:self];
    _refresh.topEnabled=YES;
    _refresh.bottomEnabled=NO;
    

}

//返回
-(void)backbtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
//    self.navigationController.navigationBar.hidden=NO;
//    self.tabBarController.tabBar.hidden=NO;
}

//加载更多


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    if (_datasArrM.count==0) {
//        
//        return 1;
//    }else
    {
    
      return _datasArrM.count;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_datasArrM.count==0) {
        return 0;
    }else{
       return 100;
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
    if (_datasArrM.count==0) {
        
        NearByNoCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell1"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }else{
        
        NearShopCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
        
        CityModel *model=_datasArrM[indexPath.row];
        
 //       [cell.nearImageView sd_setImageWithURL:[NSURL URLWithString:model.logo]];
        
        [cell.nearImageView sd_setImageWithURL:[NSURL URLWithString:model.logo] placeholderImage:[UIImage imageNamed:@"default_image"] options:SDWebImageProgressiveDownload];
        cell.shopNameLabel.text=model.storename;
        cell.shopNoteLabel.text=model.note;
        cell.distenceLabel.text=[NSString stringWithFormat:@"距离%@",model.distance_str];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CityModel *model=_datasArrM[indexPath.row];
    
    GotoShopLookViewController *vc=[[GotoShopLookViewController alloc] init];
    
    vc.GetString=@"3";
    
    vc.mid=model.mid;
    
//    NSLog(@"%@",vc.mid);
    
    vc.type=@"3";
    [self.navigationController pushViewController:vc animated:NO];
    
    self.navigationController.navigationBar.hidden=YES;
    
}




- (void)refresh:(DJRefresh *)refresh didEngageRefreshDirection:(DJRefreshDirection)direction{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self addDataWithDirection:direction];
    });
    
}

- (void)addDataWithDirection:(DJRefreshDirection)direction{
    
    if (direction==DJRefreshDirectionTop) {
        
        NSLog(@"下拉刷新");
        
        _page=0;
        _currentPageNo=1;
        
        [_datasArrM removeAllObjects];
        
        //获取数据
        [self getDatas];
        
//        WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
//        
//        dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
//        dispatch_after(time, dispatch_get_main_queue(), ^{
//            
//            [hud dismiss:YES];
//        });
        
        
    }
    
    [_refresh finishRefreshingDirection:direction animation:YES];
    
    //    [self.tableView reloadData];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 44;
}


-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    footer=[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
    
    footer.delegate=self;
    if (_datasArrM.count == 0) {
        footer.hidden = YES;
    }
    return footer;
}
//加载更多数据代理方法
- (void)FooterViewClickedloadMoreData
{
    
    NSLog(@"点击加载更多");
    
    if (_datasArrM.count%12==0) {
        
        _currentPageNo=_currentPageNo+1;
        
        _page=_page+12;
        
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
        
        
    }else{
        
//        footer
    }
    
}
@end
