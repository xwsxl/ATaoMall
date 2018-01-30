//
//  NewGameViewController.m
//  aTaohMall
//
//  Created by JMSHT on 2017/5/3.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "NewGameViewController.h"

#import "MYCusIndexTableView.h"

#import "GameNameCell.h"

#import "AFNetworking.h"

#import "ConverUtil.h"
#import "DESUtil.h"
#import "SecretCodeTool.h"

#import "WKProgressHUD.h"

@interface NewGameViewController ()<UITableViewDelegate,UITableViewDataSource,MYCusIndexTableViewDelegate>

@property (nonatomic, copy) NSArray *dataList;

@end

@implementation NewGameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.hidden=NO;
    
    self.navigationItem.hidesBackButton = YES;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 25, [UIScreen mainScreen].bounds.size.width-200, 30)];
    
    label.text = @"游戏点卡";
    
    label.textColor = [UIColor blackColor];
    
    label.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:20];
    
    label.textAlignment = NSTextAlignmentCenter;
    
    self.navigationItem.titleView = label;
    
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 30, 30);
    
    [backBtn setImage:[UIImage imageNamed:@"iconfont-fanhui2yt"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(LeftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    //    self.navigationItem.leftBarButtonItem = backItem;
    
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceItem.width = - 10;
    self.navigationItem.leftBarButtonItems = @[spaceItem, backItem];
    
    
    [self initUI];
    _dataList =  @[@[@"热",@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J"],@[@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J"],@[@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J"],@[@"D",@"E",@"F",@"G",@"H",@"I",@"J"],@[@"E",@"F",@"G",@"H",@"I",@"J"],@[@"F",@"G",@"H",@"I",@"J"],@[@"G",@"H",@"I",@"J"],@[@"H",@"I",@"J"],@[@"I",@"J",@"I",@"J",@"I",@"J",@"I",@"J",@"I",@"J",@"I",@"J"],@[@"J",@"k",@"J",@"k",@"J",@"k",@"J",@"k",@"J",@"k",@"J",@"k"]];
    
}

-(void)LeftBtnClick
{
    [self.navigationController popToRootViewControllerAnimated:YES];
    self.tabBarController.tabBar.hidden=NO;
    self.tabBarController.selectedIndex=0;
}

- (void)initUI {
    MYCusIndexTableView *tableView = [[MYCusIndexTableView alloc] initWithFrame:self.view.frame];
    tableView.cusIndexTableViewDelegate = self;
    [self.view addSubview:tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataList.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [(NSMutableArray *)_dataList[section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 31;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GameNameCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    if (!cell) {
        cell = [[GameNameCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellId"];
        
    }
    cell.Name.text = _dataList[indexPath.section][indexPath.row];
    return cell;
}
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 31)];
    view.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:246/255.0 alpha:1.0];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(16, 0, self.view.frame.size.width-16, 31)];
    label.text = _dataList[0][section];
    label.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    label.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15];
    [view addSubview:label];
    return view;
}

- (NSArray *)getTableViewIndexList {
    return @[@"热",@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M"];
    //    return @[@"热",@"A",@"B"];
}
@end
