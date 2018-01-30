//
//  PeccSelectCityVC.m
//  aTaohMall
//
//  Created by Zhending Shi on 2017/7/28.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "PeccSelectCityVC.h"
#import "PeccProvinceModel.h"
#import "PeccCityModel.h"
#import "PeccDataModel.h"
#import "SelectCityCell.h"
@interface PeccSelectCityVC ()<UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray *dataArr;
    UITableView *tableview;
    NSMutableArray *flagArr;
    
    
    UIWebView *webView;
    UIView *loadView;
}

@end

@implementation PeccSelectCityVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNav];
    [self setTableView];
    [self getDatas];
 //   NSLog(@"dataArr=%@",dataArr);
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*******************************************************      视图初始化       ******************************************************/

/*****
 *
 *  Description 表头设置
 *
 ******/
-(void)changeTableHeardView
{
    
    [tableview.tableHeaderView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    if (!tableview.tableHeaderView) {
    tableview.tableHeaderView=[[UIView alloc]initWithFrame:CGRectMake(0, 66, kScreen_Width, 106)];
    }
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 10)];
    view.backgroundColor=[UIColor whiteColor];
    [tableview.tableHeaderView addSubview:view];
    
    UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(15, 17, 70, 15)];
    lab.textColor=RGB(151, 151, 151);
    lab.font=KNSFONT(15);
    lab.text=@"已选城市";
    tableview.tableHeaderView.backgroundColor=RGB(240, 240, 240);
    [tableview.tableHeaderView addSubview:lab];
    
    UIView *view2=[[UIView alloc]initWithFrame:CGRectMake(0, 39, kScreen_Width, 37)];
    view2.backgroundColor=[UIColor whiteColor];
    if (self.selectCityArr.count==0) {
        UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMake(15, 12, 200, 14)];
        lab.font=KNSFONT(14);
        lab.textColor=UIColorFromRGB(0xc7c7cd);
        lab.text=@"请添加查询城市";
        lab.textAlignment=NSTextAlignmentLeft;
        [view2 addSubview:lab];
    }else
    {
    CGFloat shift=0;
    for (int i=0; i<self.selectCityArr.count; i++) {
        UIButton *but=[UIButton buttonWithType:UIButtonTypeCustom];
        but.tag=2000+i;
        NSString *str=_selectCityArr[i];
        CGSize size=[str sizeWithFont:KNSFONT(17) maxSize:CGSizeMake(100, 100)];
        
        but.frame=CGRectMake(15+shift, 8, size.width+13+20, size.height+2);
        but.layer.cornerRadius=4;
        
        [but setTitle:_selectCityArr[i] forState:UIControlStateNormal];
        [but setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
        [but addTarget:self action:@selector(unselectCity:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *delBut=[UIButton buttonWithType:UIButtonTypeCustom];
        delBut.frame=CGRectMake(size.width+18, 4, 15, 15);
        [delBut setImage:[UIImage imageNamed:@"button_delete"] forState:UIControlStateNormal];
//        UIImageView *iv=[[UIImageView alloc]initWithFrame:CGRectMake(15+shift+size.width+5, 0, 15, 15)];
//        iv.image=[UIImage imageNamed:@"button_delete"];
        delBut.tag=2300+i;
        [delBut addTarget:self action:@selector(unselectCity:) forControlEvents:UIControlEventTouchUpInside];
        [but addSubview:delBut];
        [view2 addSubview:but];
        shift=shift+size.width+13+15+10;
    }
    }
    [tableview.tableHeaderView addSubview:view2];
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(15, 84, 70, 15)];
    label.textColor=RGB(151, 151, 151);
    label.font=KNSFONT(15);
    label.text=@"全部城市";
    [tableview.tableHeaderView addSubview:label];
    
}
/*****
 *
 *  Description 初始化表视图
 *
 ******/
-(void)setTableView
{
    if (!tableview) {
        tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight, kScreen_Width, kScreen_Height-KSafeAreaTopNaviHeight) style:UITableViewStyleGrouped];
        tableview.delegate=self;
        tableview.dataSource=self;
        [self changeTableHeardView];
        
        [self.view addSubview:tableview];
    }
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
    
    [Qurt setImage:[UIImage imageNamed:@"iconfont-fanhui2yt"] forState:0];
    
    [Qurt addTarget:self action:@selector(QurtBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [titleView addSubview:Qurt];
    
    //创建搜索
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 25+KSafeTopHeight, [UIScreen mainScreen].bounds.size.width-200, 30)];
    
    label.text = @"选择城市";
    
    label.textColor = [UIColor blackColor];
    
    label.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:19];
    
    label.textAlignment = NSTextAlignmentCenter;
    
    [titleView addSubview:label];
    
    UIButton *Show = [UIButton buttonWithType:UIButtonTypeCustom];
    
    Show.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-55, 25+KSafeTopHeight, 40, 30);
    
    [Show setTitle:@"确定" forState:0];
    
    [Show setTitleColor:[UIColor colorWithRed:63/255.0 green:139/255.0 blue:253/255.0 alpha:1.0] forState:0];
    
    Show.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15];
    
    [Show addTarget:self action:@selector(selectCity) forControlEvents:UIControlEventTouchUpInside];
    
    [titleView addSubview:Show];
}

-(void)QurtBtnClick{
    
    [self.navigationController popViewControllerAnimated:NO];
    // self.tabBarController.tabBar.hidden=NO;
    
}
/*******************************************************      协议方法       ******************************************************/
#pragma mark-UITableViewDelegate,UITableViewDataSource-表视图协议
//分区数(分区头存放省份，故分区数等于省份数)
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return dataArr.count;
}
//分区头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}
//分区头视图
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 50)];
    view.tag=1000+section;
    UILabel *proLab=[[UILabel alloc]initWithFrame:CGRectMake(15, 18, 160, 14)];
    proLab.font=KNSFONT(14);
    proLab.textColor=RGB(51, 51, 51);
    PeccDataModel *model=dataArr[section];
    proLab.text=model.model.provinceName;
    [view addSubview:proLab];
    [view setBackgroundColor:[UIColor whiteColor]];
    if (model.cityListArr.count>0) {
    UIImageView *IV=[[UIImageView alloc]initWithFrame:CGRectMake(kScreen_Width-23, 14, 8, 14)];
    IV.image=[UIImage imageNamed:@"icon_back"];
    IV.tag=1300+section;
    [view addSubview:IV];
    }else
    {
        UIImageView *IV=[[UIImageView alloc]initWithFrame:CGRectMake(kScreen_Width-30, 17, 15, 15)];
        IV.image=[UIImage imageNamed:@"button_check"];
        [view addSubview:IV];
        IV.tag=2500+section;
        IV.hidden=YES;
        for (int i=0; i<_selectCityArr.count; i++) {
            if ([proLab.text isEqualToString:_selectCityArr[i]]) {
                IV.hidden=NO;
            }
        }
    }
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(sectionClick:)];
    [view addGestureRecognizer:tap];
    
    return view;
}
//分区尾高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}
//单元格高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([flagArr[indexPath.section] isEqualToString:@"0"]) {
        return 0;
    }else
    {
        return 50;
    }
}
//每一个分区的单元格数目
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    PeccDataModel *model=dataArr[section];
    return model.cityListArr.count;
}
//单元格的内容(单元格存放城市)
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SelectCityCell *cell=[[SelectCityCell alloc]init];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    PeccDataModel *model=dataArr[indexPath.section];
    PeccCityModel *model2=model.cityListArr[indexPath.row];
    cell.textLab.text=model2.cityName;
    for (NSString *cityName in _selectCityArr) {
        if ([cityName isEqualToString:model2.cityName]) {
            cell.IV.hidden=NO;
        }
    }
    if ([model2.canQuery isEqualToString:@"false"]) {
        cell.supportLab.hidden=NO;
    }
    cell.clipsToBounds=YES;
    return cell;
}
//选中了单元格
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SelectCityCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    
    if(!cell.supportLab.hidden)
    {
        return;
    }
    if (cell.IV.hidden==YES) {
        
        if (self.selectCityArr.count<3) {
        [_selectCityArr addObject:cell.textLab.text];
            cell.IV.hidden=NO;
        }
        else
        {
            [TrainToast showWithText:@"一次最多支持查询3个城市" duration:2.0];
        }
    }else
    {
        cell.IV.hidden=YES;
        [self.selectCityArr removeObject:cell.textLab.text];
    }
    [self changeTableHeardView];
}
/*******************************************************      各种button点击、手势事件       ******************************************************/
//手势点击事件
- (void)sectionClick:(UITapGestureRecognizer *)tap{
    
    int index = tap.view.tag % 1000;
    NSMutableArray *indexArray = [[NSMutableArray alloc]init];
    PeccDataModel *model=dataArr[index];
    if (model.cityListArr.count>0) {
        
    for (int i = 0; i < model.cityListArr.count; i ++) {
        NSIndexPath *path = [NSIndexPath indexPathForRow:i inSection:index];
        [indexArray addObject:path];
    }
        
        
        UIImageView *IV=[self.view viewWithTag:index+1300];
    if ([flagArr[index] isEqualToString:@"0"]) {//展开
        flagArr[index] = @"1";
        IV.image=KImage(@"icon_down2");
        IV.frame=CGRectMake(kScreen_Width-29, 20, 14, 8);
        [tableview reloadRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationBottom];  //使用下面注释的方法就 注释掉这一句
    } else { //收起
        flagArr[index] = @"0";
        IV.image=KImage(@"icon_back");
        IV.frame=CGRectMake(kScreen_Width-23, 14, 8, 14);
        [tableview reloadRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationTop]; //使用下面注释的方法就 注释掉这一句
    }
    }else
    {
        UIImageView *IV=(UIImageView *)[self.view viewWithTag:2500+index];
        if (IV.hidden==YES) {
            if (self.selectCityArr.count<3) {
                [_selectCityArr addObject:model.model.provinceName];
                IV.hidden=NO;
            }
            else
            {
                  [TrainToast showWithText:@"一次最多支持查询3个城市" duration:2.0];
            }
            
            
            
        }else
        {
            IV.hidden=YES;
            [_selectCityArr removeObject:model.model.provinceName];
        }
        [self changeTableHeardView];
    }
 
}
/*****
 *
 *  Description 删除选中的某个城市
 *
 ******/
-(void)unselectCity:(UIButton *)sender
{
    [_selectCityArr removeObjectAtIndex:sender.tag%100];
    [tableview reloadData];
    [self changeTableHeardView];
}
/*****
 *
 *  Description 选中城市
 *
 ******/
-(void)selectCity{
    
    [self.delegate hasSelectCity:_selectCityArr];
    
    [self.navigationController popViewControllerAnimated:NO];
}

/*******************************************************      数据请求       ******************************************************/

/*****
 *
 *  Description 获取省份和城市数据
 *
 ******/
-(void)getDatas
{
   
   // tableview.hidden=YES;
    CGRect frame = CGRectMake(0, 65+60, 80, 80);
    frame.size = [UIImage imageNamed:@"ring-alt(1).gif"].size;
    // 读取gif图片数据
    NSData *gif = [NSData dataWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"ring-alt(1)" ofType:@"gif"]];
    // view生成
    webView = [[UIWebView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-frame.size.width)/2, ([UIScreen mainScreen].bounds.size.height-frame.size.height)/2, frame.size.width, frame.size.height)];
    
    webView.backgroundColor = [UIColor clearColor];
    [webView setOpaque:NO];
    webView.userInteractionEnabled = NO;//用户不可交互
    [webView loadData:gif MIMEType:@"image/gif" textEncodingName:nil baseURL:nil];
    [self.view addSubview:webView];
    
    loadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    loadView.backgroundColor = [UIColor blackColor];
    
    loadView.alpha = 0.2;
    
    [self.view addSubview:loadView];

    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@getProvinceAndCity_omb.shtml",URL_Str];
    //saveUserExchange_mob.shtml
    NSDictionary *param=nil;
    
    [manager POST:url parameters:param success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
        NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];
        
        NSLog(@"resp=%@",responseObject);
        if (codeKey && content) {
            NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
            
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
            
            NSLog(@"xmlStr==%@",xmlStr);
            
            
            NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"dic=%@",dic);
            if(!dataArr)
            {
                dataArr=[[NSMutableArray alloc]init];
            }
            
            if ([dic[@"status"] isEqualToString:@"10000"]) {
            NSArray *TempArr=[[NSArray alloc]init];
            TempArr=dic[@"list"];

            for (NSDictionary *dic in TempArr) {
                PeccDataModel *dataModel=[[PeccDataModel alloc]init];
                NSArray *cityTempArr=[[NSArray alloc]init];
               
                
                
                NSDictionary *proDic=dic[@"Province"];
                PeccProvinceModel *proModel=[[PeccProvinceModel alloc]init];
                proModel.provinceID=[NSString stringWithFormat:@"%@",proDic[@"provinceId"]];
                proModel.provinceName=[NSString stringWithFormat:@"%@",proDic[@"provinceName"]];
                proModel.create_times=[NSString stringWithFormat:@"%@",proDic[@"create_times"]];
                proModel.time=[NSString stringWithFormat:@"%@",proDic[@"time"]];
                dataModel.model=proModel;
                
                
                if ([dic[@"City_List"] isKindOfClass:[NSArray class]]) {
                    cityTempArr=dic[@"City_List"];
                for (NSDictionary *cityDic in cityTempArr) {
                    PeccCityModel *cityModel=[[PeccCityModel alloc]init];
                    cityModel.cityID=[NSString stringWithFormat:@"%@",cityDic[@"cityId"]];
                    cityModel.cityName=[NSString stringWithFormat:@"%@",cityDic[@"cityName"]];
                    cityModel.canQuery=[NSString stringWithFormat:@"%@",cityDic[@"canQuery"]];
                    [dataModel.cityListArr addObject:cityModel];
                }
                    }
                [dataArr addObject:dataModel];
            }}
            else
            {
                [TrainToast showWithText:[NSString stringWithFormat:@"%@",dic[@"message"]] duration:1.0];
            }
            
        }
       
        if (webView.superview!=nil) {
            [webView removeFromSuperview];
        }
        if (loadView.superview!=nil) {
            [loadView removeFromSuperview];
        }
        [self setFlagArr];
        [tableview reloadData];
        tableview.hidden=NO;
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        if (webView.superview!=nil) {
            [webView removeFromSuperview];
        }
        if (loadView.superview!=nil) {
            [loadView removeFromSuperview];
        }
    }];
    
}

/*******************************************************      初始化数据数组       ******************************************************/
-(NSMutableArray *)selectCityArr
{
    if (!_selectCityArr) {
        _selectCityArr=[[NSMutableArray alloc]init];
    }
    return _selectCityArr;
}
-(void)setFlagArr
{
    if (!flagArr) {
        flagArr=[[NSMutableArray alloc]init];
    }
    for (int i=0; i<dataArr.count; i++) {
        [flagArr addObject:@"0"];
    }
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
