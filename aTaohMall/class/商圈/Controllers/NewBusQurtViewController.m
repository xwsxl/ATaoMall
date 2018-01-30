//
//  NewBusQurtViewController.m
//  aTaohMall
//
//  Created by JMSHT on 2016/12/27.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import "NewBusQurtViewController.h"

#import "NewQurtCell.h"

#import "ClassifySearchViewController.h"//搜索界面

//#import "NewQurtSearchViewController.h"

@interface NewBusQurtViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    
    UITableView *_tableView;
    
}
@end

@implementation NewBusQurtViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
//    self.navigationController.navigationBar.backgroundColor=[UIColor lightGrayColor];
    
    self.navigationController.navigationBar.hidden=YES;
    
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64)];
//    
//    view.backgroundColor=[UIColor lightGrayColor];
//    
//    [self.view addSubview:view];
    
    UIView *view1=[[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, KSafeAreaTopNaviHeight)];
    
    view1.backgroundColor=[UIColor colorWithRed:255/255.0 green:82/255.0 blue:83/255.0 alpha:1.0];
    
    UIImageView *searchImgView=[[UIImageView alloc] initWithFrame:CGRectMake(60, 25+KSafeTopHeight, [UIScreen mainScreen].bounds.size.width-150, 30)];
    searchImgView.image=[UIImage imageNamed:@"搜索长框"];
    [view1 addSubview:searchImgView];
    
    //搜索添加手势
    searchImgView.userInteractionEnabled = YES;
    UITapGestureRecognizer *imgRecongnizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headSearchClick:)];
    
    [searchImgView addGestureRecognizer:imgRecongnizer];
    
    UIImageView *imgView=[[UIImageView alloc] initWithFrame:CGRectMake(70, 30+KSafeTopHeight, 20, 20)];
    imgView.image=[UIImage imageNamed:@"搜索"];
    [view1 addSubview:imgView];
    
    [self.view addSubview:view1];
    
    UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(60, 30+KSafeTopHeight, 240, 20)];
    label.text=@"请输入您要搜索的商户名";
    label.textColor=[UIColor lightGrayColor];
    label.textAlignment=NSTextAlignmentCenter;
    label.font=[UIFont systemFontOfSize:14];
    [view1 addSubview:label];
    
    
    UIButton *Qurt = [UIButton buttonWithType:UIButtonTypeCustom];
    
    Qurt.frame=CGRectMake([UIScreen mainScreen].bounds.size.width-60, 25+KSafeTopHeight, 40, 30);
    
    [Qurt setTitle:@"商圈" forState:0];
    
    [Qurt setTitleColor:[UIColor blackColor] forState:0];
    
    [view1 addSubview:Qurt];
    
    Qurt.titleLabel.font=[UIFont fontWithName:@"PingFangSC-Regular" size:15];
    
    [Qurt addTarget:self action:@selector(QurtBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    [self setTableView];
    
    UIImageView *line=[[UIImageView alloc] initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight-1, [UIScreen mainScreen].bounds.size.width, 1)];
    
    line.image=[UIImage imageNamed:@"分割线-拷贝"];
    
    [self.view addSubview:line];
    
    
    
}

-(void)headSearchClick:(UITapGestureRecognizer *)Gr
{
    
    NSLog(@"11111");
    
//    NewQurtSearchViewController *vc=[[NewQurtSearchViewController alloc] init];
//    [self.navigationController pushViewController:VC animated:NO];
//    //隐藏
//    self.navigationController.navigationBar.hidden=YES;
//    self.tabBarController.tabBar.hidden=YES;
    
    
}

-(void)QurtBtnClick
{
    
    NSLog(@"====商圈===");
    
}
-(void)setTableView
{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-KSafeAreaTopNaviHeight-49-KSafeAreaBottomHeight) style:UITableViewStylePlain];
    
    _tableView.delegate=self;
    
    _tableView.dataSource=self;
    
    [self.view addSubview:_tableView];
    
    [_tableView registerClass:[NewQurtCell class] forCellReuseIdentifier:@"cell"];
    
    
    
    
    //解决分割线短缺问题
    // code1
    if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    
    // code2
    if ([_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [_tableView setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    
    
}

//解决分割线不齐全问题
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


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 20;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 60;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NewQurtCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;//加箭头
    
    
    return cell;
    
    
}
@end

