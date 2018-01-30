//
//  MyScoreViewController.m
//  aTaohMall
//
//  Created by JMSHT on 16/5/13.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import "MyScoreViewController.h"

#import "XiaoFeiCell.h"
#import "HuoDeCell.h"

#import "AFNetworking.h"

//加密
#import "DESUtil.h"
#import "ConverUtil.h"
#import "SecretCodeTool.h"

#import "MyScoreModel.h"

#import "UIImageView+WebCache.h"

#import "UserMessageManager.h"

#import "WKProgressHUD.h"

//刷新
#import "DJRefresh.h"
#import "DJRefreshProgressView.h"
#import "XSInfoView.h"
#import "HomeLookFooter.h"//点击加载更多
#import "YTOtherLoginViewController.h"
@interface MyScoreViewController ()<UITableViewDataSource,UITableViewDelegate,DJRefreshDelegate,FooterViewDelegate>
{
    UITableView *_tableView1;
    UITableView *_tableView2;
    XiaoFeiCell *_cell1;
    HuoDeCell *_cell2;
    NSMutableArray *_datasArr1;//获取数据
    
    NSMutableArray *_datasArr2;
    HomeLookFooter *footer;
    
    int num;
    BOOL bo;//用来判断点击的是哪一个；
    NSString *string10;
    
    UIView *view;
}
@property (nonatomic,strong)DJRefresh *refresh;

@end

@implementation MyScoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.frame=[UIScreen mainScreen].bounds;
    
//    footer.hidden=NO;
    self.flag=@"1";
    
    num=1;
    _datasArr1=[NSMutableArray new];
    
    _datasArr2=[NSMutableArray new];
    //获取积分数据
//    [self getDatas1];
    
    //消费明细默认选择
    [self XiaoFeiBtnClick:_XiaoFeiButton];
//    [self initTableView1];
//    [self initTableView2];
}

-(void)getDatas1
{
    
//    WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
//    
//    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
//    dispatch_after(time, dispatch_get_main_queue(), ^{
//            [hud dismiss:YES];
//    });
        //获取数据
        
        
        //网络请求
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        NSString *url = [NSString stringWithFormat:@"%@queryUserIntegralDeductionList_mob.shtml",URL_Str];
        
        NSDictionary *dic = @{@"sigen":self.sigen,@"flag":self.flag};
        
        [manager POST:url parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            
            
            
        } success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
            NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];
            
            
            
            
            if (codeKey && content) {
                NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
                xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
                xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
                
                //NSLog(@"xmlStr%@",xmlStr);
                
                
                NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];
                
                
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                            NSLog(@"消费:%@",dic);
                
                
                view.hidden=YES;
                
                for (NSDictionary *dic1 in dic) {
                    
                    string10 = dic1[@"totalCount"];
                    MyScoreModel *model=[[MyScoreModel alloc] init];
                    model.integral=dic1[@"integral"];
                    self.MyScoreLabel.text=[NSString stringWithFormat:@"%.02f",[dic1[@"integral"] floatValue]];;
                    NSLog(@"%@",dic1[@"status"]);
                    NSLog(@"%@",dic1[@"message"]);
                    
                    self.status=dic1[@"status"];
                    
                    if ([self.status isEqualToString:@"10001"]) {
                        
                        footer.hidden=YES;
                        
                    }else{
                        
                        footer.hidden=NO;
                    }
                    for (NSDictionary *dict in dic1[@"integraldeductionlist"]) {
                        MyScoreModel *model=[[MyScoreModel alloc] init];
                        
                        
                        NSString *id=dict[@"id"];
                        NSString *ordernumber=dict[@"ordernumber"];
                        
                        model.integral1=dict[@"integral"];
                        
                        model.sysdate=dict[@"sysdate"];
                        
                        model.id=id;
                        model.ordernumber=ordernumber;
                        
                        [_datasArr1 addObject:model];
                        
                        
                        NSLog(@"#########%ld",_datasArr1.count);
                        
                                                //                    NSLog(@"%ld",_datasArr1.count);
                    }
                }
//               if (_datasArr1.count%12==0&&_datasArr1.count!=0) {
//                            
//                            footer.hidden=NO;
//                            
//                        }else{
//                            
//                            footer.hidden=YES;
//                        }
                if (_datasArr1.count%12==0&&_datasArr1.count!=0&&_datasArr1.count !=[string10 integerValue]) {
                    
                    footer.hidden=NO;
                    [footer.loadMoreBtn setTitle:@"点击加载更多" forState:0];
//                    [footer.loadMoreBtn setTitleColor:[UIColor colorWithRed:91/255.0 green:150/255.0 blue:255/255.0 alpha:1.0] forState:0];
                    footer.loadMoreBtn.enabled=YES;
                    
                }else if (_datasArr1.count == [string10 integerValue]){
                    footer.hidden = NO;
                    footer.moreView.hidden=YES;
                    [footer.loadMoreBtn setTitle:@"暂无更多数据" forState:0];
                    [footer.loadMoreBtn setTitleColor:[UIColor colorWithRed:154/255.0 green:154/255.0 blue:154/255.0 alpha:1.0] forState:0];
                    footer.loadMoreBtn.enabled=NO;
                    
                    
                }else{
                    
                    //隐藏点击加载更多
                    footer.hidden=YES;
                    
                }
                [_tableView1 reloadData];
                
                
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
//            [WKProgressHUD popMessage:@"网络请求失败，请检查您的网络设置" inView:self.view duration:1.5 animated:YES];
            
            [self NoWebSeveice];
            
            NSLog(@"%@",error);
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
    
    [self getDatas1];
    
}

//创建tableView
-(void)initTableView1
{
    _tableView1 = [[UITableView alloc] initWithFrame:CGRectMake(0, 204, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-204) style:UITableViewStyleGrouped];
    
    _tableView1.delegate=self;
    
    _tableView1.dataSource=self;
    
    [self.view addSubview:_tableView1];
    
    [_tableView1 registerNib:[UINib nibWithNibName:@"XiaoFeiCell" bundle:nil] forCellReuseIdentifier:@"cell1"];
    
    
    [_tableView1 registerNib:[UINib nibWithNibName:@"HomeLookFooter" bundle:nil] forHeaderFooterViewReuseIdentifier:@"header"];
    //点击加载更多
    
    
    _refresh=[[DJRefresh alloc] initWithScrollView:_tableView1 delegate:self];
    _refresh.topEnabled=YES;//下拉刷新
    _refresh.bottomEnabled=NO;//上拉加载
    _cell1.tag=1;
    _cell2.tag=2;
    
    _XiaoFeiButton.tag=100;
    _HuoDeButton.tag=200;
    
}

-(void)getDatas2
{
    
//    WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
//    
//    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
//    dispatch_after(time, dispatch_get_main_queue(), ^{
//         [hud dismiss:YES];
//    });

        //获取数据
        
        
        //网络请求
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        NSString *url = [NSString stringWithFormat:@"%@queryUserIntegralProduceList_mob.shtml",URL_Str];
        
        NSDictionary *dic = @{@"sigen":self.sigen,@"flag":self.flag};
        
        [manager POST:url parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            
            
            
        } success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
            NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];
            
            
            
            
            if (codeKey && content) {
                NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
                xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
                xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
                
                NSLog(@"xmlStr%@",xmlStr);
                
                
                NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];
                
                
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//                NSLog(@"获得%@",dic);
                
                view.hidden=YES;
                
                
                for (NSDictionary *dic1 in dic) {
                    
                    string10 = dic1[@"totalCount"];
                    MyScoreModel *model=[[MyScoreModel alloc] init];
                    model.integral=dic1[@"integral"];
                    
                    
                    self.MyScoreLabel.text=[NSString stringWithFormat:@"%.02f",[dic1[@"integral"] floatValue]];
                    
                    NSLog(@"%@",dic1[@"status"]);
                    NSLog(@"%@",dic1[@"message"]);
                    
                    self.status=dic1[@"status"];
                    
                    if ([self.status isEqualToString:@"10001"]) {
                        
                        footer.hidden=YES;
                        
                    }else{
                        
                        footer.hidden=NO;
                    }
                    for (NSDictionary *dict in dic1[@"integralproducelist"]) {
                        MyScoreModel *model=[[MyScoreModel alloc] init];
                        
                        
                        NSString *id=dict[@"id"];
                        NSString *ordernumber=dict[@"ordernumber"];
                        
                        model.integral1=dict[@"integral"];
                        model.sysdate=dict[@"sysdate"];
                        
                        model.id=id;
                        model.ordernumber=ordernumber;
                        model.type=dict[@"type"];
                        
                        [_datasArr2 addObject:model];
                        NSLog(@"$$$$$$$$$$$$%ld",_datasArr2.count);
                        
                        
                        //                    NSLog(@"%ld",_datasArr2.count);
                    }
                }
//                 footer.hidden = YES;
//                 if (_datasArr2.count%12==0&& _datasArr2.count!=0) {
//                            
//                            footer.hidden=NO;
//                        }else{
//                            
//                            footer.hidden=YES;
//                        }
                
                if (_datasArr2.count%12==0&&_datasArr2.count!=0&&_datasArr2.count !=[string10 integerValue]) {
                    
                    footer.hidden=NO;
                    [footer.loadMoreBtn setTitle:@"点击加载更多" forState:0];
//                    [footer.loadMoreBtn setTitleColor:[UIColor colorWithRed:91/255.0 green:150/255.0 blue:255/255.0 alpha:1.0] forState:0];
                    footer.loadMoreBtn.enabled=YES;
                    
                }else if (_datasArr2.count == [string10 integerValue]){
                    footer.hidden = NO;
                    footer.moreView.hidden=YES;
                    [footer.loadMoreBtn setTitle:@"暂无更多数据" forState:0];
                    [footer.loadMoreBtn setTitleColor:[UIColor colorWithRed:154/255.0 green:154/255.0 blue:154/255.0 alpha:1.0] forState:0];
                    footer.loadMoreBtn.enabled=NO;
                    
                    
                }else{
                    
                    //隐藏点击加载更多
                    footer.hidden=YES;
                    
                }
                [_tableView2 reloadData];
                
                
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
           
//            [WKProgressHUD popMessage:@"网络请求失败，请检查您的网络设置" inView:self.view duration:1.5 animated:YES];
            
            [self NoWebSeveice];
            
            NSLog(@"%@",error);
        }];

        
        
           
    }

//创建tableView
-(void)initTableView2
{
    _tableView2 = [[UITableView alloc] initWithFrame:CGRectMake(0, 204, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-204) style:UITableViewStyleGrouped];
    
    _tableView2.delegate=self;
    
    _tableView2.dataSource=self;
    
    [self.view addSubview:_tableView2];
    
    
    [_tableView2 registerNib:[UINib nibWithNibName:@"HuoDeCell" bundle:nil] forCellReuseIdentifier:@"cell2"];
    
    [_tableView2 registerNib:[UINib nibWithNibName:@"HomeLookFooter" bundle:nil] forHeaderFooterViewReuseIdentifier:@"header"];
    //点击加载更多
    
    
    _refresh=[[DJRefresh alloc] initWithScrollView:_tableView2 delegate:self];
    _refresh.topEnabled=YES;//下拉刷新
    _refresh.bottomEnabled=NO;//上拉加载
    
}
//[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1];
//消费明细
- (IBAction)XiaoFeiBtnClick:(UIButton *)sender {
    [_XiaoFeiButton setTitleColor:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1] forState:0];
    _xiaofeiImageView.image=[UIImage imageNamed:@"下划线.png"];
    
    [_HuoDeButton setTitleColor:[UIColor blackColor] forState:0];
    _huodeImageView.image=[UIImage imageNamed:@""];
    self.flag=@"1";
    num = 1;
   
    [_datasArr1 removeAllObjects];
    
     [self initTableView1];
    [self getDatas1];
     bo = YES;
}
//获得明细
- (IBAction)HuoDeBtnClick:(UIButton *)sender {
    
    [_HuoDeButton setTitleColor:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0] forState:0];
    _huodeImageView.image=[UIImage imageNamed:@"下划线.png"];
    
    [_XiaoFeiButton setTitleColor:[UIColor blackColor] forState:0];
    _xiaofeiImageView.image=[UIImage imageNamed:@""];
    self.flag=@"1";
    num = 1;
    
    [_datasArr2 removeAllObjects];
    
    [self initTableView2];
    [self getDatas2];
    bo = NO;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView isEqual:_tableView1]) {
        return _datasArr1.count;
    }else{
        return _datasArr2.count;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:_tableView1]) {
        return 130;
    }else{
        return 136;
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
    
    
    
    if ([tableView isEqual:_tableView1]) {
        
        
        XiaoFeiCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell1"];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        MyScoreModel *model1=_datasArr1[indexPath.row];
        
        cell.DateLabel.text=model1.sysdate;
        cell.ScoreLabel.text=[NSString stringWithFormat:@"%.02f",[model1.integral1 floatValue]];
        cell.NumberLabel.text=model1.ordernumber;
        
        return cell;
    }else{
        
        HuoDeCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell2"];
        
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        MyScoreModel *model=_datasArr2[indexPath.row];
        
        if ([model.type isEqualToString:@"1"]) {
            
           cell.HuoDeLabel.text=@"积分获得";
        }else if ([model.type isEqualToString:@"2"]){
            
            cell.HuoDeLabel.text=@"斯迈尔转入积分";
        }else if ([model.type isEqualToString:@"3"]){
            
            cell.HuoDeLabel.text=@"用户消费返润";
        }else if ([model.type isEqualToString:@"4"]){
            
            cell.HuoDeLabel.text=@"用户退款";
        }else{
            
            cell.HuoDeLabel.text=@"其他";
        }
        cell.DateLabel.text=model.sysdate;
        cell.ScoreLabel.text=model.integral1;
        cell.NumberLabel.text=model.ordernumber;
        return cell;
    }
    
}
//返回
- (IBAction)backBtnClick:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
    self.tabBarController.tabBar.hidden=NO;
}


- (void)refresh:(DJRefresh *)refresh didEngageRefreshDirection:(DJRefreshDirection)direction{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self addDataWithDirection:direction];
    });
    
}

- (void)addDataWithDirection:(DJRefreshDirection)direction{
    
    if (direction==DJRefreshDirectionTop) {
        
        self.flag=@"1";
        num = 1;
        
       
        //获取数据
        if(bo == 1){
            [_datasArr1 removeAllObjects];
            [self getDatas1];
            [_tableView1 reloadData];
            bo = 1;
        }
        if(bo == 0){
             [_datasArr2 removeAllObjects];
            [self getDatas2];
            [_tableView2 reloadData];
            bo = 0;
        }

    }
    
    
    
    [_refresh finishRefreshingDirection:direction animation:YES];
    
    
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 44;
}


-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    footer=[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
    
    footer.delegate=self;
    if(_datasArr1.count==0 && bo == 1){
        footer.hidden = YES;
    }
    if(_datasArr2.count==0 && bo == 0){
        footer.hidden = YES;
    }
    return footer;
}
//加载更多数据代理方法
- (void)FooterViewClickedloadMoreData
{
    
    NSLog(@"点击加载更多");
    num=num+1;
    
    self.flag=[NSString stringWithFormat:@"%d",num];
    //获取数据
    
    if(bo == 1){
        [self getDatas1];
    }
    if(bo == 0){
       [self getDatas2];
    }

    
        
}
@end
