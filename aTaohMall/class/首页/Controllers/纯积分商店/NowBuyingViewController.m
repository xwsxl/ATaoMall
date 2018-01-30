//
//  NowBuyingViewController.m
//  aTaohMall
//
//  Created by JMSHT on 16/6/6.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import "NowBuyingViewController.h"

#import "UIImageView+WebCache.h"
#import "AFNetworking.h"

#import "ConverUtil.h"
#import "DESUtil.h"
#import "SecretCodeTool.h"

#import "ChunJiFenModel.h"

#import "NowGoingCell.h"

#import "NewGoodsDetailViewController.h"//商品详情

#import "WKProgressHUD.h"

#import "ChunJIFenNoCell.h"

//刷新
#import "DJRefresh.h"
#import "DJRefreshProgressView.h"

#import "HomeLookFooter.h"//点击加载更多
#import "UserMessageManager.h"
#import "TimeModel.h"

#import "YTGoodsDetailViewController.h"
#define fwidth [UIScreen mainScreen].bounds.size.width //全屏的宽
#define fheight [UIScreen mainScreen].bounds.size.height //全屏的高
@interface NowBuyingViewController ()<UITableViewDataSource,UITableViewDelegate,DJRefreshDelegate,FooterViewDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_datasArrM;
    
    HomeLookFooter *footer;
    UIView *view;
    int page;
    int currentPageNo;
    NSMutableArray *_typeArrM;
    
    NSString *string10;
}

@property (nonatomic,strong)DJRefresh *refresh;
@property (nonatomic, strong) NSTimer        *m_timer; //定时器
@property(nonatomic,strong)UILabel *lable;//暂无数据

@end

@implementation NowBuyingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.frame=[UIScreen mainScreen].bounds;
    _datasArrM=[NSMutableArray new];
    
    [self initTableView];
    
    self.type=@"1";
    self.PanDuan=@"0";
    _typeArrM=[NSMutableArray new];
    [_typeArrM addObject:self.type];
    
    page=0;
    currentPageNo=1;
    
//    [_datasArrM addObject:self.type];
    
    self.AnRenQiLabel.textColor=[UIColor redColor];
    
    [self.RenQiDownButton setBackgroundImage:[UIImage imageNamed:@"排序下1@2x"] forState:0];
    
    
    //获取数据
    [self getDatas];
    
    WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
    
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        [hud dismiss:YES];
    });
    [self createTimer];
//    [self getDatas];
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
    //    [self.RenQiButton setTitleColor:[UIColor redColor] forState:0];
    //    [self.RenQiDownButton setBackgroundImage:[UIImage imageNamed:@"排序下1@2x"] forState:0];
    
    
    
//    [_datasArrM removeAllObjects];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@getMoreIntegralGoods_mob.shtml",URL_Str];
    
    NSDictionary *dic = @{@"status":@"0",@"type":self.type,@"page":[NSString stringWithFormat:@"%d",page],@"currentPageNo":[NSString stringWithFormat:@"%d",currentPageNo]};
    
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
            for (NSDictionary *dict1 in dic) {
                
                string10=dict1[@"totalCount"];
                
                for (NSDictionary *dict2 in dict1[@"integralGoodsList"]) {
                    ChunJiFenModel *model=[[ChunJiFenModel alloc] init];
                    
//                    NSString *amount=dict2[@"amount"];
//                    NSString *end_time_str=dict2[@"end_time_str"];
//                    NSString *good_type=dict2[@"good_type"];
//                    NSString *id=dict2[@"id"];
//                    NSString *name=dict2[@"name"];
//                    NSString *pay_integer=dict2[@"pay_integer"];
//                    NSString *pay_maney=dict2[@"pay_maney"];
//                    NSString *scopeimg=dict2[@"scopeimg"];
//                    NSString *start_time_str=dict2[@"start_time_str"];
//                    NSString *type =dict2[@"type"];
//                    NSString *status =dict2[@"status"];
//                    
//                    NSLog(@"===amount==%@",amount);
//                    NSLog(@"===end_time_str==%@",end_time_str);
//                    NSLog(@"===good_type==%@",good_type);
//                    NSLog(@"===id==%@",id);
//                    NSLog(@"===name==%@",name);
//                    NSLog(@"===pay_integer==%@",pay_integer);
//                    NSLog(@"===pay_maney==%@",pay_maney);
//                    NSLog(@"===start_time_str==%@",start_time_str);
//                    NSLog(@"===scopeimg==%@",scopeimg);
//                    NSLog(@"===type==%@",type);
//                    NSLog(@"===status==%@",status);
                    
                    model.amount=dict2[@"amount"];
                    model.end_time_str=dict2[@"end_time_str"];
                    model.good_type=dict2[@"good_type"];
                    model.id=dict2[@"id"];
                    model.name=dict2[@"name"];
                    model.pay_integer=dict2[@"pay_integer"];
                    model.pay_maney=dict2[@"pay_maney"];
                    model.scopeimg=dict2[@"scopeimg"];
                    model.start_time_str=dict2[@"start_time_str"];
                    model.type=dict2[@"type"];
                    model.status=dict2[@"status"];
                    model.attribute = dict2[@"is_attribute"];
                    
                    [_datasArrM addObject:model];
                    
                    
                }
            }
            if (_datasArrM.count == 0) {
                [self initview];
                _refresh.topEnabled=NO;//下拉刷新
                _lable.hidden = NO;
            }else{
                _lable.hidden = YES;
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
                [footer.loadMoreBtn setTitleColor:[UIColor colorWithRed:91/255.0 green:150/255.0 blue:255/255.0 alpha:1.0] forState:0];
                footer.loadMoreBtn.enabled=YES;
                
            }else if (_datasArrM.count == [string10 integerValue]){
                footer.hidden = NO;
                footer.moreView.hidden=YES;
                [footer.loadMoreBtn setTitle:@"暂无更多数据" forState:0];
                [footer.loadMoreBtn setTitleColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0] forState:0];
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
    
}//创建tableView
-(void)initTableView
{
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 64+50, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-114) style:UITableViewStyleGrouped];
    
    _tableView.delegate=self;
    
    _tableView.dataSource=self;
    
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    _tableView.separatorColor = [UIColor colorWithRed:212.0f/255.0f green:212.0f/255.0f blue:212.0f/255.0f alpha:1.0];
    
    [self.view addSubview:_tableView];
    
    [_tableView registerNib:[UINib nibWithNibName:@"NowGoingCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [_tableView registerNib:[UINib nibWithNibName:@"ChunJIFenNoCell" bundle:nil] forCellReuseIdentifier:@"noCell"];
    
    [_tableView registerNib:[UINib nibWithNibName:@"HomeLookFooter" bundle:nil] forHeaderFooterViewReuseIdentifier:@"header"];
    //点击加载更多
    
    
    _refresh=[[DJRefresh alloc] initWithScrollView:_tableView delegate:self];
    _refresh.topEnabled=YES;//下拉刷新
    _refresh.bottomEnabled=NO;//上拉加载
    
}
- (void)createTimer {
    
    self.m_timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(timerEvent) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_m_timer forMode:NSRunLoopCommonModes];
}

- (void)timerEvent {
    
    [_tableView reloadData];
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0000000001;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[UIView alloc]init];
}
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
    }else
    {
        
       return fheight*3/10;
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (_datasArrM.count==0) {
        NowGoingCell *cell=[tableView dequeueReusableCellWithIdentifier:@"Cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        
        ChunJiFenModel *model=_datasArrM[indexPath.row];
        
//        NSLog(@"=====%@===%@",model.start_time_str,model.end_time_str);
        
        NowGoingCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //去除覆盖
        //
        //    NowGoingCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        //    //根据indexPath准确地取出一行，而不是从cell重用队列中取出
        //    if (cell == nil) {
        //        cell = [[NowGoingCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:@"cell"];
        //    }
        //
        cell.startString=model.start_time_str;
        cell.endString=model.end_time_str;
        
        NSLog(@"=====%@===%@",cell.startString,cell.endString);
        
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.0"];
        NSDate *end=[dateFormatter dateFromString:cell.startString];
        NSDate *timedata = [NSDate date];
        
        NSTimeInterval _end=[end timeIntervalSince1970];
        
        NSTimeInterval _start=[timedata timeIntervalSince1970];
        
        NSInteger time=(NSInteger)(_end - _start);
        TimeModel *model2 = [[TimeModel alloc]init];
        model2.m_countNum = (int)time;
        
         [cell loadData:model2 indexPath:indexPath];
        if (time<=0) {
            
//            cell.TimeLabel.hidden=YES;
            cell.HouKaiShiLabel.hidden=YES;
            
            
            cell.TimeLabel.text=@"已开始抢购";
            
            UILabel *newLabel2=[[UILabel alloc] initWithFrame:CGRectMake(25, 45, 95, 20)];
            newLabel2.text=@"已开始抢购";
            newLabel2.textAlignment=NSTextAlignmentCenter;
            newLabel2.textColor=[UIColor whiteColor];
            newLabel2.font=[UIFont systemFontOfSize:13];
//            [cell addSubview:newLabel2];
            
        }
       
        
//        [cell.GoodsImageView sd_setImageWithURL:[NSURL URLWithString:model.scopeimg]];
        
        [cell.GoodsImageView sd_setImageWithURL:[NSURL URLWithString:model.scopeimg] placeholderImage:[UIImage imageNamed:@"default_image"] options:SDWebImageProgressiveDownload];
        cell.GoodsNameLabel.text=model.name;
        cell.GoodsAmountLabel.text=[NSString stringWithFormat:@"%@人付款",model.amount];
        if ([model.pay_integer isEqualToString:@"0.00"]) {
            cell.GoodsPriceLabel.text=[NSString stringWithFormat:@"￥%.02f",[model.pay_maney floatValue]];
        }else if ([model.pay_maney isEqualToString:@"0.00"]){
            cell.GoodsPriceLabel.text=[NSString stringWithFormat:@"%.02f积分",[model.pay_integer floatValue]];
        }else{
            cell.GoodsPriceLabel.text=[NSString stringWithFormat:@"￥%.02f+%.02f积分",[model.pay_maney floatValue],[model.pay_integer floatValue]];
        }
        
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChunJiFenModel *model=_datasArrM[indexPath.row];
    
//    NewGoodsDetailViewController *vc=[[NewGoodsDetailViewController alloc] init];
    
    
    YTGoodsDetailViewController *vc=[[YTGoodsDetailViewController alloc] init];
    vc.gid=model.id;
    vc.good_type=model.good_type;
//    vc.good_type=model.good_type;
    vc.status=model.status;
    vc.attribute = model.attribute;
    vc.Attribute_back=@"3";
    vc.ID=model.id;
    [self.navigationController pushViewController:vc animated:NO];
    
    self.navigationController.navigationBar.hidden=YES;
    
}

//返回
- (IBAction)backBtnClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)RenQiUpBtnClick:(UIButton *)sender {
    self.type=@"2";
    
    [self.AnRenQiButton setTitleColor:[UIColor redColor] forState:0];
    [self.AnJiaGeButton setTitleColor:[UIColor blackColor] forState:0];
    
    
    [self.RenQiDownButton setBackgroundImage:[UIImage imageNamed:@"排序下@2x"] forState:0];
    [self.RenQiUpButton setBackgroundImage:[UIImage imageNamed:@"排序上1@2x"] forState:0];
    
    [self.JisGeDownButton setBackgroundImage:[UIImage imageNamed:@"排序下@2x"] forState:0];
    [self.JiaGeUpButton setBackgroundImage:[UIImage imageNamed:@"排序上@2x"] forState:0];
    
    
    //获取数据
    [self getDatas];
    
    WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
    
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{

        [hud dismiss:YES];
    });
}

- (IBAction)RenQiDownBtnClick:(UIButton *)sender {
    self.type=@"1";
    
    [self.AnRenQiButton setTitleColor:[UIColor redColor] forState:0];
    [self.AnJiaGeButton setTitleColor:[UIColor blackColor] forState:0];
    
    [self.RenQiDownButton setBackgroundImage:[UIImage imageNamed:@"排序下1@2x"] forState:0];
    [self.RenQiUpButton setBackgroundImage:[UIImage imageNamed:@"排序上@2x"] forState:0];
    
    [self.JisGeDownButton setBackgroundImage:[UIImage imageNamed:@"排序下@2x"] forState:0];
    [self.JiaGeUpButton setBackgroundImage:[UIImage imageNamed:@"排序上@2x"] forState:0];
    //获取数据
    [self getDatas];
    
    WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
    
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        

        [hud dismiss:YES];
    });
    
}

- (IBAction)JIaGeUpBtnClick:(UIButton *)sender {
    self.type=@"4";
    
    
    [self.AnRenQiButton setTitleColor:[UIColor blackColor] forState:0];
    [self.AnJiaGeButton setTitleColor:[UIColor redColor] forState:0];
    
    
    [self.RenQiDownButton setBackgroundImage:[UIImage imageNamed:@"排序下@2x"] forState:0];
    [self.RenQiUpButton setBackgroundImage:[UIImage imageNamed:@"排序上@2x"] forState:0];
    
    [self.JisGeDownButton setBackgroundImage:[UIImage imageNamed:@"排序下@2x"] forState:0];
    [self.JiaGeUpButton setBackgroundImage:[UIImage imageNamed:@"排序上1@2x"] forState:0];
    
    //获取数据
    [self getDatas];
    
    WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
    
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        

        [hud dismiss:YES];
    });
}

- (IBAction)JiaGeDownBtnClick:(UIButton *)sender {
    self.type=@"3";
    
    [self.AnRenQiButton setTitleColor:[UIColor blackColor] forState:0];
    [self.AnJiaGeButton setTitleColor:[UIColor redColor] forState:0];
    
    [self.RenQiDownButton setBackgroundImage:[UIImage imageNamed:@"排序下@2x"] forState:0];
    [self.RenQiUpButton setBackgroundImage:[UIImage imageNamed:@"排序上@2x"] forState:0];
    
    [self.JisGeDownButton setBackgroundImage:[UIImage imageNamed:@"排序下1@2x"] forState:0];
    [self.JiaGeUpButton setBackgroundImage:[UIImage imageNamed:@"排序上@2x"] forState:0];
    
    //获取数据
    [self getDatas];
    
    WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
    
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        

        [hud dismiss:YES];
    });
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
        
        [_typeArrM removeAllObjects];
        
//        NSLog(@"===sort======%@",self.type);
        
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
    
    [_tableView reloadData];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 44;
}


-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    footer=[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
    
    footer.DataCount=[NSString stringWithFormat:@"%ld",(unsigned long)_datasArrM.count];
    footer.totalCount=string10;
    
    footer.delegate=self;
    if(_datasArrM.count == 0)
    {
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
    
    for (NSString *string in _typeArrM) {
        
        self.type=string;
    }
    
    NSLog(@"===sort======%@",self.type);
    
    //    NSLog(@">>>>>>%@",[userDefaultes stringForKey:@"classifyId"]);
    
    if (_datasArrM.count%12==0) {
        
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
        
        [self.JisGeDownButton setBackgroundImage:[UIImage imageNamed:@"排序下@2x"] forState:0];
        [self.JiaGeUpButton setBackgroundImage:[UIImage imageNamed:@"排序上@2x"] forState:0];
        
        [_datasArrM removeAllObjects];
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
        
        [self.JisGeDownButton setBackgroundImage:[UIImage imageNamed:@"排序下@2x"] forState:0];
        [self.JiaGeUpButton setBackgroundImage:[UIImage imageNamed:@"排序上@2x"] forState:0];
        
        [_datasArrM removeAllObjects];
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
        
        self.PanDuan=@"0";
        self.type=@"3";
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
        
        [self.JisGeDownButton setBackgroundImage:[UIImage imageNamed:@"排序下1@2x"] forState:0];
        [self.JiaGeUpButton setBackgroundImage:[UIImage imageNamed:@"排序上@2x"] forState:0];
        [_datasArrM removeAllObjects];
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
        self.type=@"4";
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
        
        [self.JisGeDownButton setBackgroundImage:[UIImage imageNamed:@"排序下@2x"] forState:0];
        [self.JiaGeUpButton setBackgroundImage:[UIImage imageNamed:@"排序上1@2x"] forState:0];
        
        [_datasArrM removeAllObjects];
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
