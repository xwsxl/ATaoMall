//
//  FanLiRecordViewController.m
//  aTaohMall
//
//  Created by JMSHT on 16/5/13.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import "FanLiRecordViewController.h"

#import "FanLiRecordCell.h"
#import "AFNetworking.h"

#import "ConverUtil.h"
#import "DESUtil.h"
#import "SecretCodeTool.h"

#import "PayCardModel.h"

#import "NoCell.h"

#import "FanLiFooter.h"

//刷新
#import "DJRefresh.h"
#import "DJRefreshProgressView.h"

#import "HomeLookFooter.h"//点击加载更多
#import "WKProgressHUD.h"
@interface FanLiRecordViewController ()<UITableViewDataSource,UITableViewDelegate,DJRefreshDelegate,FooterViewDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_datas;
    NSString *_page;
    
    NSString *_currentPageNo;
    
    int num1;
    int num2;
    
    HomeLookFooter *footer;
    
    NSString *string10;
    
    UIView *view;
    
}

@property (nonatomic,strong)DJRefresh *refresh;
@property(nonatomic,strong)UILabel *lable;//暂无数据
@end

@implementation FanLiRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _datas=[NSMutableArray new];
    _page=@"0";
    _currentPageNo=@"1";
    num1=0;
    num2=1;
    [self initTableView];
    //获取数据
    [self getDatas];
    
    self.view.frame=[UIScreen mainScreen].bounds;
    
    WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        
        [hud dismiss:YES];
        
        
    });
    
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
    
    _lable = [[UILabel alloc]initWithFrame:CGRectMake(0,[UIScreen mainScreen].bounds.size.height/4 , [UIScreen mainScreen].bounds.size.width, 80)];
    _lable.text = @"暂无任何推广记录";
    _lable.textColor = [UIColor lightGrayColor];
    _lable.textAlignment = NSTextAlignmentCenter;
    self.view.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1];
    [self.view addSubview:_lable];
    
}
-(void)initTableView
{
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 110, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-110) style:UITableViewStyleGrouped];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    
    [self.view addSubview:_tableView];
    
    [_tableView registerNib:[UINib nibWithNibName:@"FanLiRecordCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    [_tableView registerNib:[UINib nibWithNibName:@"NoCell" bundle:nil] forCellReuseIdentifier:@"cell1"];
    
    [_tableView registerNib:[UINib nibWithNibName:@"HomeLookFooter" bundle:nil] forHeaderFooterViewReuseIdentifier:@"header"];
    //点击加载更多
    
    
    _refresh=[[DJRefresh alloc] initWithScrollView:_tableView delegate:self];
    _refresh.topEnabled=YES;//下拉刷新
    _refresh.bottomEnabled=NO;//上拉加载
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


-(void)getDatas
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@getRebateRecords_mob.shtml",URL_Str];
    NSLog(@"=====%@",self.sigen);
    NSLog(@"=====%@",_page);
    NSLog(@"=====%@",_currentPageNo);
    NSDictionary *dic = @{@"sigen":self.sigen,@"page":_page,@"currentPageNo":_currentPageNo};
    
    //    NSDictionary *dic=nil;
    
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
            
            NSLog(@"%@",dic);
            
            
            view.hidden=YES;
            
            for (NSDictionary *dict in dic) {
                string10 = dict[@"totalCount"];
                for (NSDictionary *dict1 in dict[@"integrallist"]) {
                    PayCardModel *model=[[PayCardModel alloc] init];
                    NSString *regdate=dict1[@"regdate"];
                    NSString *total_money=dict1[@"total_money"];
                    NSString *username=dict1[@"username"];
                    
                    model.regdate=regdate;
                    model.total_money=total_money;
                    model.username=username;
                    
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
//                [footer.loadMoreBtn setTitleColor:[UIColor colorWithRed:91/255.0 green:150/255.0 blue:255/255.0 alpha:1.0] forState:0];
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
            
                [_tableView reloadData];
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        
        [self NoWebSeveice];
        
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
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    if (_datas.count==0) {
//        
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
        
    return 60;
        
    }

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (_datas.count==0) {
        
        NoCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell1"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        PayCardModel *model=_datas[indexPath.row];
        
        FanLiRecordCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.UserNameLabel.text=model.username;
        cell.DateLabel.text=model.regdate;
        cell.ScoreLabel.text=[NSString stringWithFormat:@"%.02f",[model.total_money floatValue]];
        
        return cell;
    }
    
}

//返回
- (IBAction)backBtnClick:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)refresh:(DJRefresh *)refresh didEngageRefreshDirection:(DJRefreshDirection)direction{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self addDataWithDirection:direction];
    });
    
}

- (void)addDataWithDirection:(DJRefreshDirection)direction{
    
    if (direction==DJRefreshDirectionTop) {
        
        _page=@"0";
        _currentPageNo=@"1";
        
        
        [_datas removeAllObjects];
        //获取数据
        [self getDatas];
        WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
        
        dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
        dispatch_after(time, dispatch_get_main_queue(), ^{
            
            
            
            [hud dismiss:YES];
        });
    }
    
    
    
    [_refresh finishRefreshingDirection:direction animation:YES];
    
    [_tableView reloadData];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 44;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0000000001;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[UIView alloc]init];
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    footer=[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
    
    footer.delegate=self;
    if (_datas.count == 0) {
        footer.hidden = YES;
    }
    return footer;
}
//加载更多数据代理方法
- (void)FooterViewClickedloadMoreData
{
    
    NSLog(@"点击加载更多");
    if (_datas.count%12==0) {
        
        num1=num1+12;
        
        num2=num2+1;
        
        _page=[NSString stringWithFormat:@"%d",num1];
        
        _currentPageNo=[NSString stringWithFormat:@"%d",num2];
        //获取数据
        [self getDatas];
//        WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
//        
//        dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
//        dispatch_after(time, dispatch_get_main_queue(), ^{
//
//            [hud dismiss:YES];
//            
//        });
        
    }else{
        
        
    }
}

@end
