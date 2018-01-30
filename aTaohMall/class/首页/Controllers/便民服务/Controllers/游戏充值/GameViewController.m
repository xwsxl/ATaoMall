//
//  GameViewController.m
//  aTaohMall
//
//  Created by JMSHT on 2017/4/24.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "GameViewController.h"

#import "GameNextViewController.h"

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
@interface GameViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchControllerDelegate,UISearchResultsUpdating,MYCusIndexViewDelegate,BMIndexViewDelegate>

{
    
    UIView *view;
    BMIndexView *indexView;
    
}
@property (nonatomic, strong) UILabel *indexLabel;

@property(strong,nonatomic) UISearchController *searchController;
@property(strong,nonatomic) UITableView *tableView;
//数据源
@property (strong,nonatomic) NSMutableArray  *dataList;

@property (strong,nonatomic) NSMutableArray  *GameList;

@property (strong,nonatomic) NSMutableArray  *GameNameList;

@property (strong,nonatomic) NSMutableArray  *GameArrM;

@property (strong,nonatomic) NSMutableArray  *GameNameArrM;

@property (strong,nonatomic) NSMutableArray  *OtherArrM;

@property (strong,nonatomic) NSMutableArray  *NewArrM;

@property (strong,nonatomic) NSMutableArray  *SearchArrM;

@property (strong,nonatomic) NSMutableArray  *HotArrM;

@property (strong,nonatomic) NSMutableArray  *ResultArrM;

@property (strong,nonatomic) NSMutableArray  *FinalArrM;

@property (strong,nonatomic) NSMutableArray  *FinalArrM1;

@property (strong,nonatomic) NSMutableArray  *FinalArrM2;

@property (strong,nonatomic) NSMutableArray  *searchList;

@end

@implementation GameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.view.backgroundColor = [UIColor whiteColor];//======//
    
//    [self initNav];
    
    
    
//    self.navigationController.navigationBar.hidden=NO;
//    
//    self.navigationItem.hidesBackButton = YES;
//    
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 25, [UIScreen mainScreen].bounds.size.width-200, 30)];
//    
//    label.text = @"游戏点卡";
//    
//    label.textColor = [UIColor blackColor];
//    
//    label.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:20];
//    
//    label.textAlignment = NSTextAlignmentCenter;
//    
//    self.navigationItem.titleView = label;
//    
//    
//    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    backBtn.frame = CGRectMake(0, 0, 30, 30);
//    
//    [backBtn setImage:[UIImage imageNamed:@"iconfont-fanhui2yt"] forState:UIControlStateNormal];
//    [backBtn addTarget:self action:@selector(LeftBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    
//    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
////    self.navigationItem.leftBarButtonItem = backItem;
//    
//    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
//    spaceItem.width = - 10;
//    self.navigationItem.leftBarButtonItems = @[spaceItem, backItem];
    
    
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    
    // Do any additional setup after loading the view, typically from a nib.
    _dataList=[NSMutableArray array];
    _searchList=[NSMutableArray array];
    _GameList = [NSMutableArray new];
    _GameNameList = [NSMutableArray new];
    _OtherArrM = [NSMutableArray new];
    _GameNameArrM = [NSMutableArray new];
    _NewArrM = [NSMutableArray new];
    _SearchArrM = [NSMutableArray new];
    _HotArrM = [NSMutableArray new];
    _ResultArrM = [NSMutableArray new];
    _FinalArrM = [NSMutableArray new];
    _FinalArrM1 = [NSMutableArray new];
    _FinalArrM2 = [NSMutableArray new];
    
    [_searchList addObject:@"1"];
    
    
    [self setControllers];
    
    [self getDatas];
    
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
    
    label.text = @"游戏点卡";
    
    label.textColor = [UIColor blackColor];
    
    label.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:20];
    
    label.textAlignment = NSTextAlignmentCenter;
    
    [titleView addSubview:label];
    
    
}

#pragma mark 搜索控制器的懒加载
-(UISearchController *)searchController{
    if (!_searchController) {
        _searchController=[[UISearchController alloc]init];
    }
    return _searchController;
}
#pragma mark 表格的懒加载
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]init];
    }
    return _tableView;
}


#pragma mark 设置搜索控制器的属性
-(void)setControllers{
    //表格的创建
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 65-65,[UIScreen  mainScreen].bounds.size.width ,[UIScreen  mainScreen].bounds.size.height-65-40) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerClass:[GameNameCell class] forCellReuseIdentifier:@"cell"];
    
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
    
    self.searchController.searchBar.frame = CGRectMake(0, 0, self.searchController.searchBar.frame.size.width, 44.0);
    
    //添加到searchBar到tableView的header
    self.tableView.tableHeaderView=self.searchController.searchBar;
    
    self.searchController.searchBar.placeholder = @"输入游戏名称搜索";
    
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
    
    
//    CGFloat topSpace = 150;
//    CGFloat height = self.view.frame.size.height - 200;
//    indexView = [[BMIndexView alloc]initWithFrame:CGRectMake(self.view.frame.size.width-40, topSpace, 30, height)];
//    indexView.cusIndexViewDelegate = self;
//    indexView.GameArrM = _GameList;
//    
//    indexView.textFont = [UIFont fontWithName:@"PingFang-SC-Regular" size:11];
//    indexView.textColor = [UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1.0];
//    indexView.backgroundColor = [UIColor clearColor];
//    [self.view addSubview:indexView];
    
    
}


//设置区域的行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.searchController.active) {
        
//        NSArray *array = _HotArrM[section];
//        
//        return [array count];
        
        return [self.searchList count];
        
    }else{
        
        NSArray *array = _GameNameArrM[section];
        
        return [array count];
    }
}
//设置索引
//- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
//{
//    return @[@"热", @"A", @"B", @"C"];
////    return @[@"A", @"B", @"C"];
//}


- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 31)];
    view1.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:246/255.0 alpha:1.0];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(16, 0, self.view.frame.size.width-16, 31)];
    
//    if (self.searchList.count==0) {
//        
//        label.text = @"无相关匹配游戏";
//        
//    }else{
    
//        if (section==0) {
//            
//            label.text = @"热门游戏";
//            
//        }else{
    
            //        NSLog(@"----%c",(char)section+64);
    
    if (self.searchController.active) {
        
//        if ([_SearchArrM[section] isEqualToString:@"Hot"]) {
//            
//            label.text = @"热门游戏";
//            
//        }else{
        
//            label.text = _SearchArrM[section];
        
//        }
        
        
    }else{
        
        
        if ([_GameList[section] isEqualToString:@"热"]) {
            
            label.text = @"热门游戏";
        }else{
            
            label.text = _GameList[section];
        }
        
    }
    
    
//        }
        
//    }
    
    
    label.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    label.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15];
    [view1 addSubview:label];
    return view1;
}


//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    if (section==0) {
//        
//        return @"热门游戏";
//        
//    }else{
//    
////        NSLog(@"----%c",(char)section+64);
//        
//        return [NSString stringWithFormat:@"%c", (char)section+64];
//    }
//    
//}

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
        
        return 0.00000000001;
        
    }else{
        
        return 31;
    }
    
}

//组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.searchController.active) {
        
//        return self.searchList.count;
        return 1;
        
    }else{
        
        return _GameList.count;
        
    }
}

//返回单元格内容
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    GameNameCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    //如果searchController处于活跃状态，表格显示的数据为self.searchList
    if (self.searchController.active) {
        
//        NSArray *array = _HotArrM[indexPath.section];
//        
//        BianMinModel *model = array[indexPath.row];
//        
//        [cell.Name setText:model.cardname];
        
//        BianMinModel *model = self.searchList[indexPath.row];
        
        [cell.Name setText:self.searchList[indexPath.row]];
        
    }
    else{
        
        
        NSArray *array = _GameNameArrM[indexPath.section];
        
        BianMinModel *model = array[indexPath.row];
        
        [cell.Name setText:model.cardname];
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    

    if (self.searchController.active) {
        
        
        // 取消选中
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
        
        // 停止搜索
        
        
        BianMinModel *model = _FinalArrM[indexPath.row];
        
        NSLog(@"==%@",model.cardname);
        NSLog(@"==%@",model.Id);
        NSLog(@"==%@",model.cardid);
        
        GameNextViewController *vc = [[GameNextViewController alloc] init];
        
        vc.cardname = model.cardname;
        vc.Id =model.Id;
        vc.cardid = model.cardid;
        vc.Commitid = model.Id;
        [self.navigationController pushViewController:vc animated:NO];
        
        self.searchController.active = NO;
        
        self.navigationController.navigationBar.hidden=YES;
        
        
    }else{
        
        // 取消选中
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
        
        // 停止搜索
        self.searchController.active = NO;
        
        NSArray *array = _GameNameArrM[indexPath.section];
        
        BianMinModel *model = array[indexPath.row];
        
        NSLog(@"==%@",model.cardname);
        NSLog(@"==%@",model.Id);
        NSLog(@"==%@",model.cardid);
        
        GameNextViewController *vc = [[GameNextViewController alloc] init];
        
        vc.cardname = model.cardname;
        vc.Id =model.Id;
        vc.cardid = model.cardid;
        vc.Commitid = model.Id;
        [self.navigationController pushViewController:vc animated:NO];
        
        self.navigationController.navigationBar.hidden=YES;
    }
    
    
    
}
#pragma mark 更新表格的显示结果
-(void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
//    NSLog(@"---updateSearchResultsForSearchController====%@===%ld",[self.searchController.searchBar text],[self.searchController.searchBar text].length);
    
//    if ([self.searchController.searchBar text].length > 0) {
//        
//        NSLog(@"1111");
//        self.searchController.obscuresBackgroundDuringPresentation = YES;
//        
//    }else{
//        NSLog(@"2222");
//        self.searchController.obscuresBackgroundDuringPresentation = NO;
//    }
    [_FinalArrM removeAllObjects];
    
    indexView.hidden=YES;
    
    
    NSString *searchString = [self.searchController.searchBar text];
    NSPredicate *preicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", searchString];
    if (self.searchList!= nil) {
        [self.searchList removeAllObjects];
//        [_FinalArrM removeAllObjects];
        
    }
    
    
    
    //过滤数据
    self.searchList= [NSMutableArray arrayWithArray:[_FinalArrM2 filteredArrayUsingPredicate:preicate]];
    
    
    for (int i= 0; i < self.searchList.count; i++) {
        
        for (int j=0; j < _FinalArrM1.count; j++) {
            
            BianMinModel *model = _FinalArrM1[j];
            
            if ([model.cardname isEqualToString:self.searchList[i]]) {
                
                [_FinalArrM addObject:model];
                
            }
            
        }
    }
    
    [_HotArrM removeAllObjects];
    [_SearchArrM removeAllObjects];
    
    NSLog(@"===self.searchList==%@",self.searchList);
    
    for (NSString *str in self.searchList) {
        
        NSLog(@"==str==%@",str);
        
    }
    
    NSMutableArray *attM;
    
    for (int i = 0; i < self.searchList.count; i++) {
        
        
        attM = [NSMutableArray new];
        
        for (int j = 0; j < _NewArrM.count; j++) {
            
            BianMinModel *model = _NewArrM[j];
            
            if ([model.cardname isEqualToString:self.searchList[i]]) {
                
                if (![_SearchArrM containsObject:model.cardkey]) {
                    
                    [_SearchArrM addObject:model.cardkey];
                    
                }
                
                
                if ([attM indexOfObject:model.cardname] == NSNotFound) {
                    
                    [attM addObject:_NewArrM[j]];
                }
                
//                [attM addObject:_NewArrM[j]];
                
            }
            
        }
        
        [_HotArrM addObject:attM];
        
        
    }
//    NSLog(@"===_HotArrM===%@==_SearchArrM==%@",_HotArrM,_SearchArrM);
    
    NSLog(@"==555=_FinalArrM===%@",_FinalArrM);
    
    
    //刷新表格
    [self.tableView reloadData];
    
    
}
#pragma mark - UISearchControllerDelegate代理

//测试UISearchController的执行过程

- (void)willPresentSearchController:(UISearchController *)searchController
{
        NSLog(@"willPresentSearchController");
}

- (void)didPresentSearchController:(UISearchController *)searchController
{
        NSLog(@"didPresentSearchController");
}

- (void)willDismissSearchController:(UISearchController *)searchController
{
        NSLog(@"willDismissSearchController");
}

- (void)didDismissSearchController:(UISearchController *)searchController
{
        NSLog(@"didDismissSearchController");
    indexView.hidden=NO;
}

- (void)presentSearchController:(UISearchController *)searchController
{
        NSLog(@"presentSearchController");
}


-(void)LeftBtnClick
{
    [self.navigationController popToRootViewControllerAnimated:YES];
    self.tabBarController.tabBar.hidden=NO;
    self.tabBarController.selectedIndex=0;
}
-(void)QurtBtnClick
{
    self.searchController.active = NO;
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    self.tabBarController.tabBar.hidden=NO;
    self.tabBarController.selectedIndex=0;
}

-(void)getDatas
{
    //先清空数据源
    
    
    WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
    
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        
    });
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@getGameList_mob.shtml",URL_Str];
    //saveUserExchange_mob.shtml
    

    [manager POST:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
        NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];
        
        
        if (codeKey && content) {
            NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
            
//            NSLog(@"xmlStr=游戏分类=%@",xmlStr);
            
            
            NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            NSLog(@"游戏分类=%@",dic);
            
            
            
            view.hidden=YES;
            
            
        
            
            if ([dic[@"status"] isEqualToString:@"10000"]) {
                
                
                NSLog(@"===%@===11=%lu",dic[@"B"],(unsigned long)[(NSArray *)dic[@"A"] count]);
                
                if ((unsigned long)[(NSArray *)dic[@"bmHotGameList"] count] !=0) {
                    
                    [_GameList addObject:@"热"];
                    [_GameNameList addObject:dic[@"bmHotGameList"]];
                    
                    
                }
                
                
                if ((unsigned long)[(NSArray *)dic[@"A"] count] !=0) {
                    
                    [_GameList addObject:@"A"];
                    [_GameNameList addObject:dic[@"A"]];
                    [_ResultArrM addObject:dic[@"A"]];
                    
                }
                
                if ((unsigned long)[(NSArray *)dic[@"B"] count] !=0) {
                    
                    [_GameList addObject:@"B"];
                    [_GameNameList addObject:dic[@"B"]];
                    [_ResultArrM addObject:dic[@"B"]];
                }
                
                if ((unsigned long)[(NSArray *)dic[@"C"] count] !=0) {
                    
                    [_GameList addObject:@"C"];
                    [_GameNameList addObject:dic[@"C"]];
                    [_ResultArrM addObject:dic[@"C"]];
                }
                
                if ((unsigned long)[(NSArray *)dic[@"D"] count] !=0) {
                    
                    [_GameList addObject:@"D"];
                    [_GameNameList addObject:dic[@"D"]];
                    [_ResultArrM addObject:dic[@"D"]];
                }
                
                if ((unsigned long)[(NSArray *)dic[@"E"] count] !=0) {
                    
                    [_GameList addObject:@"E"];
                    [_GameNameList addObject:dic[@"E"]];
                    [_ResultArrM addObject:dic[@"E"]];
                }
                
                if ((unsigned long)[(NSArray *)dic[@"F"] count] !=0) {
                    
                    [_GameList addObject:@"F"];
                    [_GameNameList addObject:dic[@"F"]];
                    [_ResultArrM addObject:dic[@"F"]];
                }
                
                if ((unsigned long)[(NSArray *)dic[@"G"] count] !=0) {
                    
                    [_GameList addObject:@"G"];
                    [_GameNameList addObject:dic[@"G"]];
                    [_ResultArrM addObject:dic[@"G"]];
                }
                
                if ((unsigned long)[(NSArray *)dic[@"H"] count] !=0) {
                    
                    [_GameList addObject:@"H"];
                    [_GameNameList addObject:dic[@"H"]];
                    [_ResultArrM addObject:dic[@"H"]];
                }
                
                if ((unsigned long)[(NSArray *)dic[@"I"] count] !=0) {
                    
                    [_GameList addObject:@"I"];
                    [_GameNameList addObject:dic[@"I"]];
                    [_ResultArrM addObject:dic[@"I"]];
                }
                
                if ((unsigned long)[(NSArray *)dic[@"J"] count] !=0) {
                    
                    [_GameList addObject:@"J"];
                    [_GameNameList addObject:dic[@"J"]];
                    [_ResultArrM addObject:dic[@"J"]];
                }
                
                if ((unsigned long)[(NSArray *)dic[@"K"] count] !=0) {
                    
                    [_GameList addObject:@"K"];
                    [_GameNameList addObject:dic[@"K"]];
                    [_ResultArrM addObject:dic[@"K"]];
                }
                
                if ((unsigned long)[(NSArray *)dic[@"L"] count] !=0) {
                    
                    [_GameList addObject:@"L"];
                    [_GameNameList addObject:dic[@"L"]];
                    [_ResultArrM addObject:dic[@"L"]];
                }
                
                if ((unsigned long)[(NSArray *)dic[@"M"] count] !=0) {
                    
                    [_GameList addObject:@"M"];
                    [_GameNameList addObject:dic[@"M"]];
                    [_ResultArrM addObject:dic[@"M"]];
                }
                
                if ((unsigned long)[(NSArray *)dic[@"N"] count] !=0) {
                    
                    [_GameList addObject:@"N"];
                    [_GameNameList addObject:dic[@"N"]];
                    [_ResultArrM addObject:dic[@"N"]];
                }
                
                if ((unsigned long)[(NSArray *)dic[@"O"] count] !=0) {
                    
                    [_GameList addObject:@"O"];
                    [_GameNameList addObject:dic[@"O"]];
                    [_ResultArrM addObject:dic[@"O"]];
                }
                
                if ((unsigned long)[(NSArray *)dic[@"P"] count] !=0) {
                    
                    [_GameList addObject:@"P"];
                    [_GameNameList addObject:dic[@"P"]];
                    [_ResultArrM addObject:dic[@"P"]];
                }
                
                
                if ((unsigned long)[(NSArray *)dic[@"Q"] count] !=0) {
                    
                    [_GameList addObject:@"Q"];
                    [_GameNameList addObject:dic[@"Q"]];
                    [_ResultArrM addObject:dic[@"Q"]];
                }
                
                if ((unsigned long)[(NSArray *)dic[@"R"] count] !=0) {
                    
                    [_GameList addObject:@"R"];
                    [_GameNameList addObject:dic[@"R"]];
                    [_ResultArrM addObject:dic[@"R"]];
                }
                
                if ((unsigned long)[(NSArray *)dic[@"S"] count] !=0) {
                    
                    [_GameList addObject:@"S"];
                    [_GameNameList addObject:dic[@"S"]];
                    [_ResultArrM addObject:dic[@"S"]];
                }
                
                if ((unsigned long)[(NSArray *)dic[@"T"] count] !=0) {
                    
                    [_GameList addObject:@"T"];
                    [_GameNameList addObject:dic[@"T"]];
                    [_ResultArrM addObject:dic[@"T"]];
                }
                
                if ((unsigned long)[(NSArray *)dic[@"U"] count] !=0) {
                    
                    [_GameList addObject:@"U"];
                    [_GameNameList addObject:dic[@"U"]];
                    [_ResultArrM addObject:dic[@"U"]];
                }
                
                
                if ((unsigned long)[(NSArray *)dic[@"V"] count] !=0) {
                    
                    [_GameList addObject:@"V"];
                    [_GameNameList addObject:dic[@"V"]];
                    [_ResultArrM addObject:dic[@"V"]];
                }
                
                if ((unsigned long)[(NSArray *)dic[@"W"] count] !=0) {
                    
                    [_GameList addObject:@"W"];
                    [_GameNameList addObject:dic[@"W"]];
                    [_ResultArrM addObject:dic[@"W"]];
                }
                
                if ((unsigned long)[(NSArray *)dic[@"X"] count] !=0) {
                    
                    [_GameList addObject:@"X"];
                    [_GameNameList addObject:dic[@"X"]];
                    [_ResultArrM addObject:dic[@"X"]];
                }
                
                if ((unsigned long)[(NSArray *)dic[@"Y"] count] !=0) {
                    
                    [_GameList addObject:@"Y"];
                    [_GameNameList addObject:dic[@"Y"]];
                    [_ResultArrM addObject:dic[@"Y"]];
                }
                
                if ((unsigned long)[(NSArray *)dic[@"Z"] count] !=0) {
                    
                    [_GameList addObject:@"Z"];
                    [_GameNameList addObject:dic[@"Z"]];
                    [_ResultArrM addObject:dic[@"Z"]];
                }
            }
            
            
            [hud dismiss:YES];
            
            
//            NSLog(@"====%@",_GameNameList);
        
            
            for (NSDictionary *dict in _GameNameList) {
                
                _GameArrM = [NSMutableArray new];
                
                for (NSDictionary *dict1 in dict) {
                    
                    BianMinModel *model = [[BianMinModel alloc] init];
                    model.Id = dict1[@"id"];
                    model.cardid = dict1[@"cardid"];
                    model.cardname = dict1[@"cardname"];
                    model.cardkey = dict1[@"cardkey"];
                    
                    [_GameArrM addObject:model];
                
                    [_NewArrM addObject:model];

                    [_OtherArrM addObject:model.cardname];
                    
                }
                
                
                [_GameNameArrM addObject:_GameArrM];
                
            }
            
            
            for (NSDictionary *dict in _ResultArrM) {
                
                for (NSDictionary *dict1 in dict) {
                    
                    BianMinModel *model = [[BianMinModel alloc] init];
                    model.Id = dict1[@"id"];
                    model.cardid = dict1[@"cardid"];
                    model.cardname = dict1[@"cardname"];
                    model.cardkey = dict1[@"cardkey"];
                    
                    [_FinalArrM1 addObject:model];
                    [_FinalArrM2 addObject:model.cardname];
                    
//                    [_OtherArrM addObject:model.cardname];
                }
                
            }
            
            
            for (BianMinModel *model in _NewArrM) {
                
                NSLog(@"==_NewArrM=%@",model.cardname);
            }
            
            CGFloat topSpace = 150-65;
            CGFloat height = self.view.frame.size.height - 200;
            indexView = [[BMIndexView alloc]initWithFrame:CGRectMake(self.view.frame.size.width-30, topSpace, 30, height)];
            indexView.cusIndexViewDelegate = self;
            indexView.GameArrM = _GameList;
            
            indexView.textFont = [UIFont fontWithName:@"PingFang-SC-Regular" size:11];
            indexView.textColor = [UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1.0];
            indexView.backgroundColor = [UIColor clearColor];
            [self.view addSubview:indexView];
            
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
    
    view=[[UIView alloc] initWithFrame:CGRectMake(0, 65-65, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-65)];
    
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


@end
