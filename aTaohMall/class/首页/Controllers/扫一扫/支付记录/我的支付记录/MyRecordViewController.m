//
//  MyRecordViewController.m
//  aTaohMall
//
//  Created by JMSHT on 16/5/10.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import "MyRecordViewController.h"

#import "AFNetworking.h"

//加密
#import "ConverUtil.h"
#import "DESUtil.h"
#import "SecretCodeTool.h"

#import "MallModel.h"
#import "BillPayTableViewCell.h"


//刷新
#import "DJRefresh.h"
#import "DJRefreshProgressView.h"

#import "HomeLookFooter.h"//点击加载更多

#import "WKProgressHUD.h"
@interface MyRecordViewController ()<UITableViewDataSource,UITableViewDelegate,DJRefreshDelegate,FooterViewDelegate>
{
    UITableView *_tableView;
    NSMutableArray *billPayArray1;
    UIAlertController *alertController;
    
    UIScrollView *_scrollView1;
    int flag;
    
    HomeLookFooter *footer;
    
    int currentPageNo;
    
    NSString *string10;
    
    UIView *view;
    
    
}
@property (weak, nonatomic) IBOutlet UIButton *LaodMoreButton;

@property (nonatomic,strong)DJRefresh *refresh;

@property(nonatomic,strong)UILabel *lable;//暂无数据

@end

@implementation MyRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.frame=[UIScreen mainScreen].bounds;
    flag = 0;
    currentPageNo=1;
    
    billPayArray1=[NSMutableArray new];
    
    //获取数据
        [self BillPayDataHttp];
    WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
    
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{

        [hud dismiss:YES];
    });
    
    
    [self createTableView];
    
    
    // code1
    if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    
    // code2
    if ([_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [_tableView setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
}

-(void)createTableView
{
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0,60+KSafeAreaTopNaviHeight, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-60-KSafeAreaTopNaviHeight) style:UITableViewStyleGrouped];
    
    _tableView.delegate=self;
    
    _tableView.dataSource=self;
    
    
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    _tableView.separatorColor = [UIColor colorWithRed:212.0f/255.0f green:212.0f/255.0f blue:212.0f/255.0f alpha:1.0];
    
    
    [_tableView registerNib:[UINib nibWithNibName:@"BillPayTableViewCell" bundle:nil] forCellReuseIdentifier:@"RecordCell"];
    
    [_tableView registerNib:[UINib nibWithNibName:@"HomeLookFooter" bundle:nil] forHeaderFooterViewReuseIdentifier:@"header"];
    
    [self.view addSubview:_tableView];
    
    
    _refresh=[[DJRefresh alloc] initWithScrollView:_tableView delegate:self];
    _refresh.topEnabled=YES;//下拉刷新
    _refresh.bottomEnabled=NO;//上拉加载
}



//支付记录请求
- (void)BillPayDataHttp{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    NSString *urlStr = TestHttp;
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSString *url = [NSString stringWithFormat:@"%@getPayRecord_mob.shtml",URL_Str];
    //  NSLog(@"sigennenen===%@",app.mySigen);
//    NSString *str = [NSString stringWithFormat:@"%d",flag];
    
    NSLog(@"sigennenen===%@",self.sigens1);
    
    NSDictionary *dic = @{@"sigen":self.sigens1,@"page":[NSString stringWithFormat:@"%d",flag],@"currentPageNo":[NSString stringWithFormat:@"%d",currentPageNo]};
    
    
    [manager POST:url parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
        NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];
        
        if (codeKey && content) {
            NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
            
            NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            
            NSLog(@"支付记录+%@",dic);
            view.hidden=YES;
            
            for (NSDictionary *dic1 in dic ) {
                
                string10=dic1[@"totalCount"];
                
               
                for (NSDictionary *billPayDic in dic1[@"list"])    {
                    MallModel *model = [[MallModel alloc]init];
                    
                    model.sigen_ = billPayDic[@"sigen"];
                    model.time_ = billPayDic[@"sysdate"];
                    model.name_ = billPayDic[@"merchant_name"];
                    model.integral_ = billPayDic[@"integral"];
                    
                    [billPayArray1 addObject:model];
                    //sysdate时间merchant_name商家名称integral积分
                    
//                    if (billPayArray1.count%12==0) {
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
            if (billPayArray1.count == 0) {
                
                [self initview];
                _refresh.topEnabled=NO;//下拉刷新
                _lable.hidden = NO;
                
            }else{
                
                _lable.hidden = YES;
                
            }
            
            if (billPayArray1.count%12==0&&billPayArray1.count !=[string10 integerValue]) {
                
                footer.hidden=NO;
                [footer.loadMoreBtn setTitle:@"点击加载更多" forState:0];
                [footer.loadMoreBtn setTitleColor:[UIColor colorWithRed:91/255.0 green:150/255.0 blue:255/255.0 alpha:1.0] forState:0];
                footer.loadMoreBtn.enabled=YES;
                
            }else if (billPayArray1.count == [string10 integerValue]){
                
                footer.moreView.hidden=YES;
                [footer.loadMoreBtn setTitle:@"暂无更多数据" forState:0];
                [footer.loadMoreBtn setTitleColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0] forState:0];
                footer.loadMoreBtn.enabled=NO;
                
                
            }else{
                
                //隐藏点击加载更多
                footer.hidden=YES;
                
            }
            
            [_tableView reloadData];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
//        alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"服务器连接失败!请检查网络或联系客服" preferredStyle:UIAlertControllerStyleAlert];
//        [alertController addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleCancel handler:nil]];
//        
//        [self presentViewController:alertController animated:YES completion:nil];
        
        [self NoWebSeveice];
        
    }];
    
    
    
}


-(void)NoWebSeveice
{
    
    view=[[UIView alloc] initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    
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
    
    [self BillPayDataHttp];
    
}
-(void)initview{
    
    _lable = [[UILabel alloc]initWithFrame:CGRectMake(0,[UIScreen mainScreen].bounds.size.height/4 , [UIScreen mainScreen].bounds.size.width, 80)];
    _lable.text = @"暂无更多数据";
    _lable.textColor = [UIColor lightGrayColor];
    _lable.textAlignment = NSTextAlignmentCenter;
    self.view.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1];
    [self.view addSubview:_lable];
    
}

- (IBAction)backBtnClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return billPayArray1.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
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

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *BillPayDataCellID = @"RecordCell";
    BillPayTableViewCell *Cell = [tableView dequeueReusableCellWithIdentifier:BillPayDataCellID];
    
    if (!(billPayArray1.count==0)) {
        MallModel *model = billPayArray1[indexPath.row];
        Cell.payDateLab.text = [NSString stringWithFormat:@"%@",model.time_];
        Cell.payMoneyLab.text = [NSString stringWithFormat:@"%.02f元",[model.integral_ floatValue]];
        Cell.payNameLab.text = [NSString stringWithFormat:@"%@",model.name_];
        
        
        Cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    
    return Cell;
}
//- (void)footView{
//    
//    UIView *views = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
//    
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake( views.frame.size.width/3, 150, 200, 20)];
//    label.text = @"还没任何支付记录哦";
//    label.textColor = [UIColor grayColor];
//    label.font = [UIFont systemFontOfSize:12.0];
//    
//    [views addSubview:label];
//    _tableView.tableFooterView = views;
//}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BillPayTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RecordCell"];
    cell.backgroundColor = [UIColor whiteColor];
    
    
}


- (void)refresh:(DJRefresh *)refresh didEngageRefreshDirection:(DJRefreshDirection)direction{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self addDataWithDirection:direction];
    });
    
}

- (void)addDataWithDirection:(DJRefreshDirection)direction{
    
    if (direction==DJRefreshDirectionTop) {
        
        flag=0;
        currentPageNo=1;
        
        [billPayArray1 removeAllObjects];
        
        //获取数据
        [self BillPayDataHttp];
        
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

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.00000000000001;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[UIView alloc] init];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 44;
}


-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    footer=[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
    
    footer.DataCount=[NSString stringWithFormat:@"%ld",(unsigned long)billPayArray1.count];
    footer.totalCount=string10;
    
    footer.delegate=self;
    if (billPayArray1.count == 0) {
        footer.hidden = YES;
    }
    return footer;
}
//加载更多数据代理方法
- (void)FooterViewClickedloadMoreData
{
    
    NSLog(@"点击加载更多");
    
    
    if (billPayArray1.count%12==0) {
        
        flag=flag+12;
        
        currentPageNo=currentPageNo+1;
        
        
        //获取数据
        [self BillPayDataHttp];
        
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


@end
