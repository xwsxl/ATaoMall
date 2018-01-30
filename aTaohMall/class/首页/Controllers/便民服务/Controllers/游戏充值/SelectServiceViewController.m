//
//  SelectServiceViewController.m
//  aTaohMall
//
//  Created by JMSHT on 2017/4/27.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "SelectServiceViewController.h"

#import "SelectServiceCell.h"

#import "AFNetworking.h"

#import "ConverUtil.h"
#import "DESUtil.h"
#import "SecretCodeTool.h"

#import "WKProgressHUD.h"

#import "JRToast.h"

#import "BianMinModel.h"
@interface SelectServiceViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    
    UITableView *_tableView;
    UIView *view;
    NSMutableArray *_datas;
    
}
@end

@implementation SelectServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.hidden=YES;
    self.navigationItem.hidesBackButton = YES;
    
    _datas = [NSMutableArray new];
    
    [self initNav];
    
    [self getDatas];
    
    
}

-(void)getDatas
{
    //先清空数据源
    [_datas removeAllObjects];
    
    WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
    
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        
    });
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@getGameServiceArea_mob.shtml",URL_Str];
    //saveUserExchange_mob.shtml
    
    
    
    NSDictionary *dic = @{@"cardid":self.cardid};
    
    
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
            
//           NSLog(@"游戏区服=%@",dic[@"result"]);
            
            view.hidden=YES;
            
            
            
            if ([dic[@"status"] isEqualToString:@"10000"]) {
                
                NSArray *array = dic[@"result"];
                
                for (NSDictionary *dict in array) {
                    
                    BianMinModel *model = [[BianMinModel alloc] init];
                    
                    
                        
//                    model.SERVER = [NSString stringWithFormat:@"%@",dict[@"SERVER"]];
                    
                    model.SERVER = dict[@"SERVER"];
                    
                    model.AREA = [NSString stringWithFormat:@"%@",dict[@"AREA"]];
                        

                    model.qufuName = [NSString stringWithFormat:@"%@",dict[@"qufuName"]];
                    [_datas addObject:model];
                    
                    
                    
//                    NSLog(@"游戏区服=%@==%ld",[NSString stringWithFormat:@"%@",dict[@"SERVER"]],array.count);
                    
                    
                    
                }
                
                
                [self initTableView];
                
                
            }else{
                
                
                [JRToast showWithText:dic[@"message"] duration:1.0f];
                
            }
            
            
            [hud dismiss:YES];
            
            
            [_tableView reloadData];
            
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //        [WKProgressHUD popMessage:@"网络请求失败，请检查您的网络设置" inView:self.view duration:1.5 animated:YES];
        [hud dismiss:YES];
        
        [self NoWebSeveice];
        
        NSLog(@"%@",error);
    }];
}

-(void)NoWebSeveice
{
    
    view=[[UIView alloc] initWithFrame:CGRectMake(0, 65, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-65)];
    
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



//创建导航栏
-(void)initNav
{
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64)];
    
    titleView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:titleView];
    
    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, 1)];
    
    line.image = [UIImage imageNamed:@"分割线-拷贝"];
    
    [self.view addSubview:line];
    
    
    //返回按钮
    
    UIButton *Qurt = [UIButton buttonWithType:UIButtonTypeCustom];
    
    Qurt.frame = CGRectMake(10, 25, 30, 30);
    
    //    [Qurt setBackgroundImage:[UIImage imageNamed:@"iconfont-fanhui2yt"] forState:0];
    
    [Qurt setImage:[UIImage imageNamed:@"iconfont-fanhui2yt"] forState:0];
    
    
    [Qurt addTarget:self action:@selector(QurtBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [titleView addSubview:Qurt];
    
    //创建搜索
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 25, [UIScreen mainScreen].bounds.size.width-200, 30)];
    
    label.text = @"选择区服";
    
    label.textColor = [UIColor blackColor];
    
    label.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:20];
    
    label.textAlignment = NSTextAlignmentCenter;
    
    [titleView addSubview:label];
    
    
}

-(void)initTableView
{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 65, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-65) style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    [_tableView registerClass:[SelectServiceCell class] forCellReuseIdentifier:@"cell"];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _datas.count;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 51;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    SelectServiceCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    BianMinModel *model = _datas[indexPath.row];
    
//    NSArray *array = [model.SERVER componentsSeparatedByString:@"w"];
    
    cell.Name.text = [NSString stringWithFormat:@"%@",model.qufuName];
    
    return cell;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    BianMinModel *model = _datas[indexPath.row];
    
    NSLog(@"===model.SERVER===%@==model.AREA==%@",[model.SERVER class],model.AREA);
    
    NSString *SERVER = model.SERVER;
    NSString *AREA = model.AREA;
    
    if ([model.SERVER isKindOfClass:[NSString class]]) {
        
        NSLog(@"字符串");
        
    }else if ([model.SERVER isKindOfClass:[NSArray class]]){
        
        NSLog(@"数组");
        
        SERVER = @"";
        
    }
    
    if ([model.AREA isKindOfClass:[NSString class]]) {
        
        NSLog(@"字符串");
        
    }else if ([model.AREA isKindOfClass:[NSArray class]]){
        
        NSLog(@"数组");
        AREA = @"";
        
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(SelectService:AREA:Name:)]) {
        
        [_delegate SelectService:SERVER AREA:AREA Name:model.qufuName];
        
    }
    
    self.navigationController.navigationBar.hidden=YES;
    [self.navigationController popViewControllerAnimated:YES];
    
    
    
}
-(void)QurtBtnClick
{
    
    self.navigationController.navigationBar.hidden=YES;
    [self.navigationController popViewControllerAnimated:YES];
    
}
@end
