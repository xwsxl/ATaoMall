//
//  YTWebViewViewController.m
//  aTaohMall
//
//  Created by JMSHT on 2016/10/9.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import "YTWebViewViewController.h"
#import "MJRefresh.h"
#import "YTGoodsDetailViewController.h"
@interface YTWebViewViewController ()<MJRefreshBaseViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    
    UITableView *_tableView;
    
    //刷新头
    MJRefreshHeaderView *refreshHeaderView;
}
@end

@implementation YTWebViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [refreshHeaderView  endRefreshing];
    
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64)];
    
    _tableView.delegate=self;
    
    _tableView.dataSource=self;
    
    _tableView.backgroundColor=[UIColor orangeColor];
    
    [self.view addSubview:_tableView];
    
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    //创建刷新头 和 刷新尾
    refreshHeaderView = [[MJRefreshHeaderView alloc] initWithScrollView:_tableView];

    
    //设置代理
    refreshHeaderView.delegate = self;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 50;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    return cell;
    
}


#pragma  mark - MJRefreshBaseViewDelegate
//开始刷新
-(void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    //刷新头部, 下拉刷新
    if (refreshView == refreshHeaderView) {
        
        YTGoodsDetailViewController *vc=[[YTGoodsDetailViewController alloc] init];
        
        [self.navigationController pushViewController:vc animated:NO];
        
        self.navigationController.navigationBar.hidden=YES;
    }
    
    
}
-(void)dealloc
{
    //释放资源(移除kvo)
    [refreshHeaderView free];
}
@end
