//
//  AirPlaneSelectCityViewController.m
//  aTaohMall
//
//  Created by JMSHT on 2017/5/18.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "AirPlaneSelectCityViewController.h"

#import "AFNetworking.h"

#import "ConverUtil.h"
#import "DESUtil.h"
#import "SecretCodeTool.h"

#import "WKProgressHUD.h"

#import "JRToast.h"

#import "MYCusIndexView.h"
#import "BMIndexView.h"
#import "GameNameCell.h"

#import "BianMinModel.h"
#import "BianMinModel.h"
#import "BMHotCell.h"

@interface AirPlaneSelectCityViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchControllerDelegate,UISearchResultsUpdating,MYCusIndexViewDelegate,BMIndexViewDelegate>
{
    
    BMIndexView *indexView;
    
    UIWebView *webView;
    UIView *loadView;
    
}

@property (nonatomic, strong) UILabel *indexLabel;

@property(strong,nonatomic) UISearchController *searchController;
@property(strong,nonatomic) UITableView *tableView;


@property (strong,nonatomic) NSMutableArray  *searchList;

@property (strong,nonatomic) NSMutableArray  *leftList;
@property (strong,nonatomic) NSMutableArray  *centerList;
@property (strong,nonatomic) NSMutableArray  *rightList;
@property (strong,nonatomic) NSMutableArray  *AllList;
@property (strong,nonatomic) NSMutableArray  *GameList;
@property (strong,nonatomic) NSMutableArray  *ResultArrM;
@property (strong,nonatomic) NSMutableArray  *HotArrM;
@property (strong,nonatomic) NSMutableArray  *GameArrM;
@property (strong,nonatomic) NSMutableArray  *GameNameArrM;
@property (strong,nonatomic) NSMutableArray  *CityNameArrM;
@property (strong,nonatomic) NSMutableArray  *FinalArrM;
@property (strong,nonatomic) NSMutableArray  *FinalArrM1;

@property (strong,nonatomic) NSMutableArray  *AirCityArrM;

@end

@implementation AirPlaneSelectCityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    _CityNameArrM = [NSMutableArray new];
    _searchList=[NSMutableArray array];
    _AllList = [NSMutableArray new];
    _GameList = [NSMutableArray new];
    _ResultArrM = [NSMutableArray new];
    _leftList = [NSMutableArray new];
    _centerList = [NSMutableArray new];
    _rightList = [NSMutableArray new];
    _HotArrM = [NSMutableArray new];
//    _GameArrM = [NSMutableArray new];
    _GameNameArrM = [NSMutableArray new];
    _AirCityArrM = [NSMutableArray new];
    
    _FinalArrM = [NSMutableArray new];
    _FinalArrM1 = [NSMutableArray new];
//    _GameList = @[@"热",@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"S",@"Y",@"Z"];
    
//    _searchList = @[@"1",@"2",@"3",@"4"];
    
    [_GameNameArrM addObject:@"1"];
    
//    _leftList = @[@"北京",@"重庆",@"成都",@"贵阳"];
//    _centerList = @[@"广州",@"深圳",@"济南",@"西安"];
//    _rightList = @[@"上海",@"武汉",@"南京",@"太原"];
    
    [self initNav];
    
    [self setControllers];
    
    [self getDatas];
    
}

-(void)getDatas
{
    
    CGRect frame = CGRectMake(0, 65+60, 80, 80);
    
    frame.size = [UIImage imageNamed:@"ring-alt(1).gif"].size;
    // 读取gif图片数据
    NSData *gif = [NSData dataWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"ring-alt(1)" ofType:@"gif"]];
    // view生成
    webView = [[UIWebView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-frame.size.width)/2, ([UIScreen mainScreen].bounds.size.height-frame.size.height)/2, frame.size.width, frame.size.height)];
    
    webView.backgroundColor = [UIColor clearColor];
    webView.userInteractionEnabled = NO;//用户不可交互
    [webView setOpaque:NO];
    [webView loadData:gif MIMEType:@"image/gif" textEncodingName:nil baseURL:nil];
    [self.view addSubview:webView];
    
    loadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    loadView.backgroundColor = [UIColor blackColor];
    
    loadView.alpha = 0.2;
    
    [self.view addSubview:loadView];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@getPlaneCityList_mob.shtml",URL_Str];
    //saveUserExchange_mob.shtml
    
    [manager POST:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
        NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];
        
        
        if (codeKey && content) {
            NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
            
//            NSLog(@"xmlStr==%@",xmlStr);
            
            
            NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
//            NSLog(@"分类查看更多书局=%@",dic);
            
            
            
            if ([dic[@"status"] isEqualToString:@"10000"]) {
                
                
                for (NSDictionary *dict in dic[@"hot_list"]) {
                    
                    BianMinModel *model = [[BianMinModel alloc] init];
    
                    model.city_code = [NSString stringWithFormat:@"%@",dict[@"city_code"]];
                    model.city_name = [NSString stringWithFormat:@"%@",dict[@"city_name"]];
                    model.city_name_full = [NSString stringWithFormat:@"%@",dict[@"city_name_full"]];
                    model.city_phoneticize = [NSString stringWithFormat:@"%@",dict[@"city_phoneticize"]];
                    model.first_letter = [NSString stringWithFormat:@"%@",dict[@"first_letter"]];
                    
                    [_HotArrM addObject:model];
                    
//                    NSLog(@"=======%@",dict[@"city_name"]);
                }
                
                for (int i = 0; i < _HotArrM.count; i++) {
                    
                    BianMinModel *model = _HotArrM[i];
                    
                    if (i==0 || i==3 || i==6 || i==9) {
                        
                        [_leftList addObject:model];
                        
                    }else if (i==1 || i==4 || i==7 || i==10){
                        
                        [_centerList addObject:model];
                        
                    }else if (i==2 || i==5 || i==8 || i==11){
                        
                        [_rightList addObject:model];
                        
                    }
                    
                }
                if ((unsigned long)[(NSArray *)dic[@"hot_list"] count] !=0) {
                    
                    [_GameList addObject:@"热"];
                    
                }
                
                if ((unsigned long)[(NSArray *)dic[@"A"] count] !=0) {
                    
                    [_GameList addObject:@"A"];
                    [_ResultArrM addObject:dic[@"A"]];
                    
                }
                
                if ((unsigned long)[(NSArray *)dic[@"B"] count] !=0) {
                    
                    [_GameList addObject:@"B"];
                    [_ResultArrM addObject:dic[@"B"]];
                }
                
                if ((unsigned long)[(NSArray *)dic[@"C"] count] !=0) {
                    
                    [_GameList addObject:@"C"];
                    [_ResultArrM addObject:dic[@"C"]];
                }
                
                if ((unsigned long)[(NSArray *)dic[@"D"] count] !=0) {
                    
                    [_GameList addObject:@"D"];
                    [_ResultArrM addObject:dic[@"D"]];
                }
                
                if ((unsigned long)[(NSArray *)dic[@"E"] count] !=0) {
                    
                    [_GameList addObject:@"E"];
                    [_ResultArrM addObject:dic[@"E"]];
                }
                
                if ((unsigned long)[(NSArray *)dic[@"F"] count] !=0) {
                    
                    [_GameList addObject:@"F"];
                    [_ResultArrM addObject:dic[@"F"]];
                }
                
                if ((unsigned long)[(NSArray *)dic[@"G"] count] !=0) {
                    
                    [_GameList addObject:@"G"];
                    [_ResultArrM addObject:dic[@"G"]];
                }
                
                if ((unsigned long)[(NSArray *)dic[@"H"] count] !=0) {
                    
                    [_GameList addObject:@"H"];
                    [_ResultArrM addObject:dic[@"H"]];
                }
                
                if ((unsigned long)[(NSArray *)dic[@"I"] count] !=0) {
                    
                    [_GameList addObject:@"I"];
                    [_ResultArrM addObject:dic[@"I"]];
                }
                
                if ((unsigned long)[(NSArray *)dic[@"J"] count] !=0) {
                    
                    [_GameList addObject:@"J"];
                    [_ResultArrM addObject:dic[@"J"]];
                }
                
                if ((unsigned long)[(NSArray *)dic[@"K"] count] !=0) {
                    
                    [_GameList addObject:@"K"];
                    [_ResultArrM addObject:dic[@"K"]];
                }
                
                if ((unsigned long)[(NSArray *)dic[@"L"] count] !=0) {
                    
                    [_GameList addObject:@"L"];
                    [_ResultArrM addObject:dic[@"L"]];
                }
                
                if ((unsigned long)[(NSArray *)dic[@"M"] count] !=0) {
                    
                    [_GameList addObject:@"M"];
                    [_ResultArrM addObject:dic[@"M"]];
                }
                
                if ((unsigned long)[(NSArray *)dic[@"N"] count] !=0) {
                    
                    [_GameList addObject:@"N"];
                    [_ResultArrM addObject:dic[@"N"]];
                }
                
                if ((unsigned long)[(NSArray *)dic[@"O"] count] !=0) {
                    
                    [_GameList addObject:@"O"];
                    [_ResultArrM addObject:dic[@"O"]];
                }
                
                if ((unsigned long)[(NSArray *)dic[@"P"] count] !=0) {
                    
                    [_GameList addObject:@"P"];
                    [_ResultArrM addObject:dic[@"P"]];
                }
                
                
                if ((unsigned long)[(NSArray *)dic[@"Q"] count] !=0) {
                    
                    [_GameList addObject:@"Q"];
                    [_ResultArrM addObject:dic[@"Q"]];
                }
                
                if ((unsigned long)[(NSArray *)dic[@"R"] count] !=0) {
                    
                    [_GameList addObject:@"R"];
                    [_ResultArrM addObject:dic[@"R"]];
                }
                
                if ((unsigned long)[(NSArray *)dic[@"S"] count] !=0) {
                    
                    [_GameList addObject:@"S"];
                    [_ResultArrM addObject:dic[@"S"]];
                }
                
                if ((unsigned long)[(NSArray *)dic[@"T"] count] !=0) {
                    
                    [_GameList addObject:@"T"];
                    [_ResultArrM addObject:dic[@"T"]];
                }
                
                if ((unsigned long)[(NSArray *)dic[@"U"] count] !=0) {
                    
                    [_GameList addObject:@"U"];
                    [_ResultArrM addObject:dic[@"U"]];
                }
                
                
                if ((unsigned long)[(NSArray *)dic[@"V"] count] !=0) {
                    
                    [_GameList addObject:@"V"];
                    [_ResultArrM addObject:dic[@"V"]];
                }
                
                if ((unsigned long)[(NSArray *)dic[@"W"] count] !=0) {
                    
                    [_GameList addObject:@"W"];
                    [_ResultArrM addObject:dic[@"W"]];
                }
                
                if ((unsigned long)[(NSArray *)dic[@"X"] count] !=0) {
                    
                    [_GameList addObject:@"X"];
                    [_ResultArrM addObject:dic[@"X"]];
                }
                
                if ((unsigned long)[(NSArray *)dic[@"Y"] count] !=0) {
                    
                    [_GameList addObject:@"Y"];
                    [_ResultArrM addObject:dic[@"Y"]];
                }
                
                if ((unsigned long)[(NSArray *)dic[@"Z"] count] !=0) {
                    
                    [_GameList addObject:@"Z"];
                    [_ResultArrM addObject:dic[@"Z"]];
                    
                    NSLog(@"======%@",dic[@"Z"]);
                    
                }
            
            
            }else{
                
                
                [JRToast showWithText:dic[@"message"] duration:1.0f];
                
            }
            
            
            for (NSDictionary *dict in _ResultArrM) {
                
                _GameArrM = [NSMutableArray new];
                
                for (NSDictionary *dict1 in dict) {
                    
                    BianMinModel *model = [[BianMinModel alloc] init];
                    
                    model.city_code = [NSString stringWithFormat:@"%@",dict1[@"city_code"]];
                    model.city_name = [NSString stringWithFormat:@"%@",dict1[@"city_name"]];
                    model.city_name_full = [NSString stringWithFormat:@"%@",dict1[@"city_name_full"]];
                    model.city_phoneticize = [NSString stringWithFormat:@"%@",dict1[@"city_phoneticize"]];
                    model.first_letter = [NSString stringWithFormat:@"%@",dict1[@"first_letter"]];
                    
                    [_CityNameArrM addObject:model.city_name];
                    
                    [_GameArrM addObject:model];
                    
                    [_FinalArrM1 addObject:model];
                    
                    
                }
                
                
                [_GameNameArrM addObject:_GameArrM];
                
            }
            
            CGFloat topSpace = 150;
            CGFloat height = self.view.frame.size.height - 200;
            indexView = [[BMIndexView alloc]initWithFrame:CGRectMake(self.view.frame.size.width-30, topSpace, 30, height)];
            indexView.cusIndexViewDelegate = self;
            indexView.GameArrM = _GameList;
            
            indexView.textFont = [UIFont fontWithName:@"PingFang-SC-Regular" size:10];
            //    indexView.textColor = [UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1.0];
            indexView.textColor = [UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
            indexView.backgroundColor = [UIColor clearColor];
            [self.view addSubview:indexView];
            
            
//            NSLog(@"====_ResultArrM===%@",_ResultArrM);
            
            [webView removeFromSuperview];
            
            [loadView removeFromSuperview];
            
            [_tableView reloadData];
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        NSLog(@"%@",error);
        
        [webView removeFromSuperview];
        
        [loadView removeFromSuperview];
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
    
    
}


#pragma mark 设置搜索控制器的属性
-(void)setControllers{
    //表格的创建
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight+56,[UIScreen  mainScreen].bounds.size.width ,[UIScreen  mainScreen].bounds.size.height-KSafeAreaTopNaviHeight-56) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerClass:[GameNameCell class] forCellReuseIdentifier:@"cell"];
    
    [self.tableView registerClass:[BMHotCell class] forCellReuseIdentifier:@"hot"];
    
    self.tableView.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1.0];
    
    //    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    //UISearchController的创建
    //创建UISearchController
    self.searchController = [[UISearchController alloc]initWithSearchResultsController:nil];
    //设置代理
    self.searchController.delegate = self;
    self.searchController.searchResultsUpdater= self;
    
    [self.searchController.searchBar sizeToFit];
    
    //设置UISearchController的显示属性，以下3个属性默认为YES
    //搜索时，背景变暗色
    self.searchController.dimsBackgroundDuringPresentation = NO;
    //搜索时，背景变模糊
    self.searchController.obscuresBackgroundDuringPresentation = NO;
    //隐藏导航栏
    self.searchController.hidesNavigationBarDuringPresentation = NO;
    
    self.searchController.searchBar.frame = CGRectMake(0, 0, self.searchController.searchBar.frame.size.width, 56);
    
    //添加到searchBar到tableView的header
   // self.tableView.tableHeaderView=self.searchController.searchBar;
    UIView *view= [[UIView alloc]initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight, kScreen_Width, 56)];
    [self.view addSubview:view];
    [view addSubview:self.searchController.searchBar];
   // [self.view addSubview:self.searchController.searchBar];
    self.searchController.searchBar.placeholder = @"中文/拼音/首字母";
    
    self.searchController.searchBar.barTintColor = [UIColor whiteColor];
    
    
    
    [self.view addSubview:self.tableView];
    
    
    
    
    
    UITextField *searchField = [_searchController.searchBar valueForKey:@"_searchField"];
    
    [searchField setTextColor:[UIColor colorWithRed:151/255.0 green:151/255.0 blue:151/255.0 alpha:1.0]];
    
    [searchField setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    [searchField setFont:[UIFont fontWithName:@"PingFang-SC-Regular" size:13]];
    
    [searchField setBackgroundColor:[UIColor colorWithRed:240/255.0 green:240/255.0 blue:246/255.0 alpha:1.0]];
    
    UISearchBar *searchBar = self.searchController.searchBar;
    UIImageView *barImageView = [[[searchBar.subviews firstObject] subviews] firstObject];
    barImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    barImageView.layer.borderWidth = 1;
    
    
    
    
    
    
    
}

- (void)didDismissSearchController:(UISearchController *)searchController
{
    NSLog(@"didDismissSearchController");
    indexView.hidden=NO;
}


- (NSArray *)getTableViewIndexList {
    NSArray *tableViewIndexList = nil;
    
    tableViewIndexList = [self getTableViewIndexList];
    
    return tableViewIndexList;
}

- (void)selectedIndex:(NSInteger)index sectionTitle:(NSString *)title {
    
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index] atScrollPosition:UITableViewScrollPositionTop animated:NO];
}

- (void)tableViewIndexTouchEnd {
    [UIView animateWithDuration:0.5 animations:^{
        _indexLabel.alpha = 0.0;
    } completion:^(BOOL finished) {
        _indexLabel.hidden = YES;
    }];
    
}


//设置区域的行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (self.searchController.active) {
        
        return _AirCityArrM.count;
        
    }else{
        
        if (section==0) {
            
            return 4;
            
        }else{
            
            NSArray *array = _GameNameArrM[section];
            
            return [array count];
        }
    }

}


- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 31)];
    view1.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:246/255.0 alpha:1.0];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(16, 0, self.view.frame.size.width-16, 31)];
    
    
    if (self.searchController.active) {
        
        UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 1)];
        
        line.image = [UIImage imageNamed:@"分割线-拷贝"];
        
        [view1 addSubview:line];
        
    }else{
        
        if (section==0) {
            
            label.text = @"热门城市";
            
            UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 1)];
            
            line.image = [UIImage imageNamed:@"分割线-拷贝"];
            
            [view1 addSubview:line];
            
        }else{
            
            label.text = _GameList[section];
        }
        
        label.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        label.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15];
        [view1 addSubview:label];
        
    }
    
    return view1;
}



-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0000000001;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [[UIView alloc]init];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (self.searchController.active) {
        
        return 1;
        
    }else{
        
        return 31;
    }
    
}

//组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.searchController.active) {
        
        return 1;
        
    }else{
        
        return _GameList.count;
        
    }
    
}

//返回单元格内容
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (self.searchController.active) {
        
        GameNameCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
        
        BianMinModel *model = _AirCityArrM[indexPath.row];
        
        cell.Name.text = model.city_name;
        
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        if (indexPath.row == _AirCityArrM.count-1) {
            
            cell.line.image = [UIImage imageNamed:@""];
        }
        
        return cell;
        
        
        
    }else{
        
        if (indexPath.section==0) {
            
            BMHotCell *cell=[tableView dequeueReusableCellWithIdentifier:@"hot"];
            
            BianMinModel *model1 = _leftList[indexPath.row];
            cell.Left.text =model1.city_name;
            
            BianMinModel *model2 = _centerList[indexPath.row];
            cell.Center.text = model2.city_name;
            
            BianMinModel *model3 = _rightList[indexPath.row];
            cell.Right.text = model3.city_name;
            
            cell.LeftUIButton.tag = indexPath.section+indexPath.row+1;
            cell.CenterUIButton.tag = indexPath.section+indexPath.row+1;
            cell.RightUIButton.tag = indexPath.section+indexPath.row+1;
            
            [cell.LeftUIButton addTarget:self action:@selector(LeftUIButton:) forControlEvents:UIControlEventTouchUpInside];
            [cell.CenterUIButton addTarget:self action:@selector(CenterUIButton:) forControlEvents:UIControlEventTouchUpInside];
            [cell.RightUIButton addTarget:self action:@selector(RightUIButton:) forControlEvents:UIControlEventTouchUpInside];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            if (indexPath.row==3) {
                
                cell.line.hidden=YES;
            }
            return cell;
            
            
        }else{
            
            
            GameNameCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
            
            NSArray *array = _GameNameArrM[indexPath.section];
            
            BianMinModel *model = array[indexPath.row];
            
            cell.Name.text = model.city_name;
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
//            if (indexPath.row==array.count-1) {
//                
//                cell.line.hidden=YES;
//            }
            
            return cell;
        }
    }
    
    
    
}


-(void)LeftUIButton:(UIButton *)sender
{
    
    NSLog(@"====Left===%@",_leftList[sender.tag-1]);
    
    BianMinModel *model = _leftList[sender.tag-1];
    
    if (_delegate && [_delegate respondsToSelector:@selector(AirPlaneSelectStation:City_Code:Type:)]) {
        
        [_delegate AirPlaneSelectStation:model.city_name City_Code:model.city_code Type:self.Type];
        
    }
    [self.navigationController popViewControllerAnimated:NO];
    self.tabBarController.tabBar.hidden=YES;
    
}

-(void)CenterUIButton:(UIButton *)sender
{
    
    NSLog(@"====Center===%@",_centerList[sender.tag-1]);
    
    BianMinModel *model = _centerList[sender.tag-1];
    
    if (_delegate && [_delegate respondsToSelector:@selector(AirPlaneSelectStation:City_Code:Type:)]) {
        
        [_delegate AirPlaneSelectStation:model.city_name City_Code:model.city_code Type:self.Type];
        
    }
    [self.navigationController popViewControllerAnimated:NO];
    self.tabBarController.tabBar.hidden=YES;
    
}

-(void)RightUIButton:(UIButton *)sender
{
    
    NSLog(@"====Right===%@",_rightList[sender.tag-1]);
    
    BianMinModel *model = _rightList[sender.tag-1];
    
    if (_delegate && [_delegate respondsToSelector:@selector(AirPlaneSelectStation:City_Code:Type:)]) {
        
        [_delegate AirPlaneSelectStation:model.city_name City_Code:model.city_code Type:self.Type];
        
    }
    [self.navigationController popViewControllerAnimated:NO];
    self.tabBarController.tabBar.hidden=YES;
    
}



//-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//
//
//
//    NSIndexPath *path =  [_tableView indexPathForRowAtPoint:CGPointMake(scrollView.contentOffset.x, scrollView.contentOffset.y)];
//
//    NSLog(@"这是第%i行%i列",path.section,path.row);
//
//
//}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"==5555==%ld=====666==%ld",_AirCityArrM.count,indexPath.row);
    
    if (self.searchController.active) {
        
        
        BianMinModel *model = _AirCityArrM[indexPath.row];
        
        if (_delegate && [_delegate respondsToSelector:@selector(AirPlaneSelectStation:City_Code:Type:)]) {
            
            [_delegate AirPlaneSelectStation:model.city_name City_Code:model.city_code Type:self.Type];
            
        }
        
        // 取消选中
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
        self.searchController.active = NO;
        
        [self.navigationController popViewControllerAnimated:NO];
        
        
    }else{
        
        if (indexPath.section==0) {
            
            
        }else{
            
            NSArray *array = _GameNameArrM[indexPath.section];
            
            BianMinModel *model = array[indexPath.row];
            
            NSLog(@"===%@",model.city_name);
            
            if (_delegate && [_delegate respondsToSelector:@selector(AirPlaneSelectStation:City_Code:Type:)]) {
                
                [_delegate AirPlaneSelectStation:model.city_name City_Code:model.city_code Type:self.Type];
                
            }
            [self.navigationController popViewControllerAnimated:NO];
            
        }
    }
    
}
#pragma mark 更新表格的显示结果
-(void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
    NSLogRect(self.searchController.searchBar.frame);
    self.searchController.searchBar.showsCancelButton = YES;
    
    UIButton *canceLBtn = [self.searchController.searchBar valueForKey:@"cancelButton"];
    [canceLBtn setTitle:@"取消" forState:UIControlStateNormal];
    [canceLBtn setTitleColor:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0] forState:UIControlStateNormal];
    
    
    [_FinalArrM removeAllObjects];
    indexView.hidden=YES;
    
    
    NSString *searchString = [self.searchController.searchBar text];
    
    NSLog(@"====searchBar===%@",[self.searchController.searchBar text]);
    
    NSPredicate *preicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", searchString];
    if (_searchList!= nil) {
        
        [_searchList removeAllObjects];
//        [_FinalArrM removeAllObjects];
        
    }
    
    
    
    //过滤数据
    self.searchList= [NSMutableArray arrayWithArray:[_CityNameArrM filteredArrayUsingPredicate:preicate]];
    
    
    [_AirCityArrM removeAllObjects];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@getQueryCity_mob.shtml",URL_Str];
    //saveUserExchange_mob.shtml
    
    NSDictionary *dict = @{@"name":[self.searchController.searchBar text]};
    
    [manager POST:url parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
        NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];
        
        
        if (codeKey && content) {
            NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
            
            //            NSLog(@"xmlStr==%@",xmlStr);
            
            
            NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            NSLog(@"搜索=%@",dic);
            
            
            
            if ([dic[@"status"] isEqualToString:@"10000"]) {
                
                
                
                NSString *string = [NSString stringWithFormat:@"%@",dic[@"list"]];
                
                
                if (string.length ==0) {
                    
                    
                }else{
                    
                    for (NSDictionary *dict in dic[@"list"]) {
                        
                        BianMinModel *model = [[BianMinModel alloc] init];
                        
                        model.city_code = [NSString stringWithFormat:@"%@",dict[@"city_code"]];
                        model.city_name = [NSString stringWithFormat:@"%@",dict[@"city_name"]];
                        model.city_name_full = [NSString stringWithFormat:@"%@",dict[@"city_name_full"]];
                        model.city_phoneticize = [NSString stringWithFormat:@"%@",dict[@"city_phoneticize"]];
                        model.first_letter = [NSString stringWithFormat:@"%@",dict[@"first_letter"]];
                        
                        [_AirCityArrM addObject:model];
                    }
                }
                
                
                
            }else{
                
                
                [JRToast showWithText:dic[@"message"] duration:1.0f];
                
            }
            
            [_tableView reloadData];
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        NSLog(@"%@",error);
        
        
    }];
    
    
    
    
    //刷新表格
    [self.tableView reloadData];
    
    
}


-(void)QurtBtnClick{
    
    self.searchController.active = NO;
    
    [self.navigationController popViewControllerAnimated:NO];
    self.tabBarController.tabBar.hidden=YES;
}

@end
