//
//  MessageListVC.m
//  aTaohMall
//
//  Created by DingDing on 2017/9/30.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "MessageListVC.h"

#import "MessageListModel.h"
#import "MessageListCell.h"

#import "ZJUnFoldView.h"
#import "ZJUnFoldView+Untils.h"

#import "PersonalAllDanVC.h"
#import "PersonalShoppingDanDetailVC.h"
#import "PersonalBMDetailVC.h"
#import "PersonalRefundDanVC.h"

#import "YTGoodsDetailViewController.h"

#import "WKProgressHUD.h"

@interface MessageListVC ()<UITableViewDelegate,UITableViewDataSource,ZJunFoldViewDelegate>
{
    
    UITableView *_tableView;
  //  NSMutableArray *_dataSource;
    UIView    *noNewsView;
    
    
    UIButton *deleteBut;
    UIControl *huiseControl;
    UIView *deleteMsgView;
    NSInteger pageNum;
    NSInteger totalCount;
}
@property (nonatomic,strong)NSMutableArray *dataSource;

@property (nonatomic,strong)NSIndexPath *indexPath;

@property (nonatomic,strong)NSString *sigen;
@property (nonatomic,strong)NSString *jindu;
@property (nonatomic,strong)NSString *weidu;
@property (nonatomic,strong)NSString *MapStartAddress;
@end

@implementation MessageListVC

- (void)viewDidLoad {
    pageNum=0;
    [super viewDidLoad];

    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
    if ([[kUserDefaults objectForKey:@"status"] isEqualToString:@"YES"]) {
        [self getDatasWithPage:pageNum];
    }else
    {
        self.dataSource=[[JMSHTDBDao getMessageListFromDatabase] mutableCopy];
        [self setUI];
    }
    
    // Do any additional setup after loading the view.
    
}

-(void)getDatasWithPage:(NSInteger )page
{
    WKProgressHUD *hud=[WKProgressHUD showInView:self.view withText:nil animated:YES];
    NSDictionary *params=@{@"sigen":[kUserDefaults objectForKey:@"sigen"],@"page":[NSString stringWithFormat:@"%ld",page]};
    [ATHRequestManager requestforHomeGetMessageListWithParams:params successBlock:^(NSDictionary *responseObj) {
        NSArray *tempArr=responseObj[@"list"];
        pageNum++;
        [self.dataSource removeAllObjects];
        totalCount=[[NSString stringWithFormat:@"%@",responseObj[@"total_numbe"]] integerValue];
        for (NSDictionary *dic in tempArr) {
            MessageListModel *model=[[MessageListModel alloc]init];
            //[model setValuesForKeysWithDictionary:dic];
            model.content=[NSString stringWithFormat:@"%@",dic[@"content"]];
            NSString *str = model.content;
            str = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]; //去除掉首尾的空白字符和换行字符
            str = [str stringByReplacingOccurrencesOfString:@"\r" withString:@""];
            str = [str stringByReplacingOccurrencesOfString:@"\n" withString:@""];
            model.content=str;
            
            model.des_orderno=[NSString stringWithFormat:@"%@",dic[@"des_orderno"]];
            model.gid=[NSString stringWithFormat:@"%@",dic[@"gid"]];
            model.is_browse=[NSString stringWithFormat:@"%@",dic[@"is_browse"]];
            model.mid=[NSString stringWithFormat:@"%@",dic[@"mid"]];
            model.order_type=[NSString stringWithFormat:@"%@",dic[@"order_type"]];
            model.orderno=[NSString stringWithFormat:@"%@",dic[@"orderno"]];
            model.status=[NSString stringWithFormat:@"%@",dic[@"status"]];
            model.sysdate=[NSString stringWithFormat:@"%@",dic[@"sysdate"]];
            model.title=[NSString stringWithFormat:@"%@",dic[@"title"]];
            model.uid=[NSString stringWithFormat:@"%@",dic[@"uid"]];
            model.ID=[NSString stringWithFormat:@"%@",dic[@"id"]];
            model.sys_type=[NSString stringWithFormat:@"%@",dic[@"sys_type"]];
            model.refund_batchid=[NSString stringWithFormat:@"%@",dic[@"refund_batchid"]];
            model.isOpen=NO;
            [_dataSource addObject:model];
        
        
        }
        [hud dismiss:YES];
        [self setUI];
        
    } faildBlock:^(NSError *error) {
        [hud dismiss:YES];
        [self setUI];
    }];
    //[hud dismiss:YES];
}

- (void)loadMoreData {
    if (totalCount<=_dataSource.count) {
        [_tableView.mj_footer endRefreshingWithNoMoreData];
        return;
    }
    
    NSDictionary *params=@{@"sigen":[kUserDefaults objectForKey:@"sigen"],@"page":[NSString stringWithFormat:@"%ld",pageNum]};
    [ATHRequestManager requestforHomeGetMessageListWithParams:params successBlock:^(NSDictionary *responseObj) {
        NSArray *tempArr=responseObj[@"list"];
        totalCount=[[NSString stringWithFormat:@"%@",responseObj[@"total_numbe"]] integerValue];
        pageNum++;
       // [self.dataSource removeAllObjects];
        for (NSDictionary *dic in tempArr) {
            MessageListModel *model=[[MessageListModel alloc]init];
            
            model.content=[NSString stringWithFormat:@"%@",dic[@"content"]];
           // model.content=[model.content stringByReplacingOccurrencesOfString:@"\n" withString:@""];
            
            NSLog(@"model.content=%@",model.content);
            
            NSString *str = model.content;
            str = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]; //去除掉首尾的空白字符和换行字符
            str = [str stringByReplacingOccurrencesOfString:@"\r" withString:@""];
            str = [str stringByReplacingOccurrencesOfString:@"\n" withString:@""];
            
            model.content=str;
            
            model.des_orderno=[NSString stringWithFormat:@"%@",dic[@"des_orderno"]];
            model.gid=[NSString stringWithFormat:@"%@",dic[@"gid"]];
            model.is_browse=[NSString stringWithFormat:@"%@",dic[@"is_browse"]];
            model.mid=[NSString stringWithFormat:@"%@",dic[@"mid"]];
            model.order_type=[NSString stringWithFormat:@"%@",dic[@"order_type"]];
            model.orderno=[NSString stringWithFormat:@"%@",dic[@"orderno"]];
            model.status=[NSString stringWithFormat:@"%@",dic[@"status"]];
            model.sysdate=[NSString stringWithFormat:@"%@",dic[@"sysdate"]];
            model.title=[NSString stringWithFormat:@"%@",dic[@"title"]];
            model.uid=[NSString stringWithFormat:@"%@",dic[@"uid"]];
            model.ID=[NSString stringWithFormat:@"%@",dic[@"id"]];
            model.sys_type=[NSString stringWithFormat:@"%@",dic[@"sys_type"]];
            [_dataSource addObject:model];
            
        }
        [_tableView.mj_footer endRefreshing];
        
        [_tableView reloadData];
        
    } faildBlock:^(NSError *error) {
        
    }];
}

-(void)setUI
{
    [self initNavi];
    if (self.dataSource.count==0) {
        if (!noNewsView) {
            noNewsView=[[UIView alloc]initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight, kScreen_Width, kScreen_Height-KSafeAreaTopNaviHeight)];
            
            UIImageView *IV=[[UIImageView alloc]initWithFrame:CGRectMake((kScreen_Width-64)/2, Height(249-65), 64, 64)];
            IV.image=[UIImage imageNamed:@"icon_no-news"];
            [noNewsView addSubview:IV];

            UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMake(0, Height(326-65), kScreen_Width, 18)];
            lab.font=KNSFONT(18);
            lab.textColor=RGB(153, 153, 153);
            lab.text=@"还没有任何消息";
            lab.textAlignment=NSTextAlignmentCenter;
            [noNewsView addSubview:lab];
            [self.view addSubview:noNewsView];
        }
        noNewsView.hidden=NO;
        return;
    }else
    {
        if (noNewsView) {
            [noNewsView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview) ];
            [noNewsView removeFromSuperview];
        }
    }
    
   // self.navigationController.interactivePopGestureRecognizer.enabled=NO;
  //  self.tabBarController.tabBar.hidden=YES;
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight, kScreen_Width, kScreen_Height-KSafeAreaTopNaviHeight) style:UITableViewStyleGrouped];
    //去掉cell分割线
    if (@available(iOS 11.0, *)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    //去掉右侧滚动条
    _tableView.showsVerticalScrollIndicator=NO;
  
    _tableView.delegate=self;
    _tableView.dataSource=self;
    
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;
    [_tableView registerClass:[MessageListCell class] forCellReuseIdentifier:@"MessageListCell"];
   
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    [footer setTitle:@"" forState:MJRefreshStateIdle];
    [footer setTitle:@"正在加载..." forState:MJRefreshStateRefreshing];
    [footer setTitle:@"没有更多数据" forState:MJRefreshStateNoMoreData];
    _tableView.mj_footer = footer;
    
    [self.view addSubview:_tableView];
    
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageListModel *model=self.dataSource[indexPath.section];
    
    return model.height;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageListModel *model=self.dataSource[indexPath.section];
   // MessageListCell *cell=[[MessageListCell alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, model.height)];
    
    MessageListCell *cell=[tableView dequeueReusableCellWithIdentifier:@"MessageListCell" forIndexPath:indexPath];
    
    
    
    cell.height=model.height;
    cell.MsgTitleLabel.text=model.title;
    cell.MsgIsRead=[model.is_browse isEqualToString:@"0"]?YES:NO;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    [cell.ContentView removeFromSuperview];
    ZJUnFoldAttributedString *unFoldAttrStr = nil;
    NSMutableString *content = [[NSMutableString alloc] initWithString:model.content];
    YLog(@"%@",model.content);

        // 1.获取属性字符串：自定义内容和属性
    unFoldAttrStr = [[ZJUnFoldAttributedString alloc] initWithContent:content
                                                              contentFont:KNSFONT(12)
                                                             contentColor:[ZJUnFoldView colorWithHexString:@"#333333"]
                                                             unFoldString:@"展开>"
                                                               foldString:@"收起>"
                                                               unFoldFont:KNSFONT(12)
                                                              unFoldColor:[ZJUnFoldView colorWithHexString:@"#007aff"]
                                                              lineSpacing:1];


    // 2.添加展开视图
    ZJUnFoldView *unFoldView = [[ZJUnFoldView alloc] initWithAttributedString:unFoldAttrStr maxWidth:[UIScreen mainScreen].bounds.size.width - 50.0f isDefaultUnFold:model.isOpen foldLines:3 location:2];
    unFoldView.tag=indexPath.section+100;
    unFoldView.frame = CGRectMake(15, 60, unFoldView.frame.size.width, unFoldView.frame.size.height);
    unFoldView.delegate=self;
    cell.ContentView=unFoldView;
    [cell.BGView addSubview:cell.ContentView];
    
    
    //添加长按删除手势
    UILongPressGestureRecognizer *longPressGR = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(lpGR:)];
    
    //设定最小的长按时间 按不够这个时间不响应手势
    
    longPressGR.minimumPressDuration = 1;
    
    [cell addGestureRecognizer:longPressGR];
    
    
    return cell;
}



-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 62;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    MessageListModel *model=_dataSource[section];
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 62)];
    UILabel *TimeLable=[[UILabel alloc]initWithFrame:CGRectMake((kScreen_Width-130)/2, 20, 130, 22)];
    TimeLable.font=KNSFONT(12);
    TimeLable.textColor=RGB(255, 255, 255);
    TimeLable.textAlignment=NSTextAlignmentCenter;
//    NSDateFormatter* formatter = [NSDateFormatter new];
//    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
//    TimeLable.text=[formatter stringFromDate:[NSDate date]];
    TimeLable.text=model.sysdate;
    TimeLable.layer.cornerRadius=5;
    TimeLable.layer.backgroundColor=[RGBA(0, 0, 0, 0.3) CGColor];
    [view addSubview:TimeLable];
//    UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMake((kScreen_Width-130)/2, 20, 130, 22)];
//    lab.font=KNSFONT(12);
//
//    lab.textColor=RGB(255, 255, 255);
//    lab.textAlignment=NSTextAlignmentCenter;
//    NSDateFormatter* formatter = [NSDateFormatter new];
//    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
//
//    lab.text=[formatter stringFromDate:[NSDate date]];
//    lab.layer.cornerRadius=5;
//    lab.layer.backgroundColor=[RGBA(0, 0, 0, 0.3) CGColor];
//    [view addSubview:lab];
    
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [[UIView alloc]init];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.sigen=[kUserDefaults objectForKey:@"sigen"];
    self.jindu=[kUserDefaults objectForKey:@"jindu"];
    self.weidu=[kUserDefaults objectForKey:@"weidu"];
    self.MapStartAddress=[kUserDefaults objectForKey:@"mapStartAddress"];
    MessageListModel *model1=_dataSource[indexPath.section];
    if (!self.sigen||(self.sigen.length==0)) {
        if (![model1.is_browse isEqualToString:@"0"]) {
            model1.is_browse=@"0";
         [JMSHTDBDao updateMessageInfoInMessageListwith:model1];
         [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }
        if ([model1.gid containsString:@"null"]||[model1.gid isEqualToString:@""]) {
            
            
        }else
        {
            YTGoodsDetailViewController *vc=[[YTGoodsDetailViewController alloc]init];
            vc.gid=model1.gid;
            [self.navigationController pushViewController:vc animated:NO];
            
        }
        
       
        return;
    }
    
    if ([model1.sys_type isEqualToString:@"0"]) {
        
        if ([model1.gid containsString:@"null"]||[model1.gid isEqualToString:@""]) {
            
            
        }else
        {
            YTGoodsDetailViewController *vc=[[YTGoodsDetailViewController alloc]init];
            vc.gid=model1.gid;
            [self.navigationController pushViewController:vc animated:NO];
            
        }
        
        
        
        
    }else
    {


        NSArray *dataArr=@[@"5",@"6",@"7",@"8",@"10",@"11"];
        NSArray *arr=@[@"1",@"2",@"3",@"4",@"5",@"6"];
        if ([dataArr containsObject:model1.order_type]) {

            PersonalBMDetailVC *VC=[[PersonalBMDetailVC alloc] initWithOrderBatchid:model1.orderno AndOrderType:[arr objectAtIndex:[dataArr indexOfObject:model1.order_type]]];
            [self.navigationController pushViewController:VC animated:NO];
        }else
        {
            PersonalShoppingDanDetailVC *VC=[[PersonalShoppingDanDetailVC alloc] init];
            XLDingDanModel *model=[[XLDingDanModel alloc] init];
            model.order_batchid=model1.orderno;
            VC.myDingDanModel=model;
            [self.navigationController pushViewController:VC animated:NO];
        }


    }



    
    
    
    if ([model1.is_browse isEqualToString:@"0"]) {
        return;
    }
    model1.is_browse=@"0";
    
    NSDictionary *params=@{@"sigen":[kUserDefaults objectForKey:@"sigen"],@"id":model1.ID,@"sys_type":model1.sysdate};
    
    [ATHRequestManager requestForMessageChangePushIsReadWithParams:params successBlock:^(NSDictionary *responseObj) {
    
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        
    } faildBlock:^(NSError *error) {
        
    }];
}


-(void)lpGR:(UILongPressGestureRecognizer *)lpGR

{
    
    if (lpGR.state == UIGestureRecognizerStateBegan) {//手势开始
        
        CGPoint point = [lpGR locationInView:_tableView];
        
        self.indexPath = [_tableView indexPathForRowAtPoint:point]; // 可以获取我们在哪个cell上长按
        NSLog(@"indexPath=%ld,%ld",_indexPath.row,_indexPath.section);
        
    }
    if (!huiseControl) {
        huiseControl=[[UIControl alloc]initWithFrame:self.view.frame];
        huiseControl.backgroundColor=RGBA(0, 0, 0, 0.74);
        [huiseControl addTarget:self action:@selector(huiseCotrolclick) forControlEvents:UIControlEventTouchUpInside];
        huiseControl.alpha=0;
    }
    huiseControl.backgroundColor=RGBA(0, 0, 0, 0.74);
    if (huiseControl.superview==nil) {
        [self.view addSubview:huiseControl];
    }
    CGPoint point = [lpGR locationInView:_tableView];
    
    
    NSLog(@"%02f,%02f",point.y,_tableView.contentOffset.y);
    //while (point.y>kScreen_Height) {
        point.y=point.y-_tableView.contentOffset.y;
    //}
    
    point.y=kScreen_Height/2-Height(20);
    
    NSLog(@"check=%02f",point.y);
    if (!deleteMsgView) {
        deleteMsgView=[[UIView alloc]initWithFrame:CGRectMake(point.x, point.y, 0, 0)];
        deleteMsgView.layer.cornerRadius=5;
        deleteMsgView.layer.backgroundColor=[UIColor whiteColor].CGColor;
        deleteBut=[UIButton buttonWithType:UIButtonTypeCustom];
        deleteBut.frame=CGRectMake(0, 0, 0, 0);
        [deleteBut setTitle:@"删除消息" forState:UIControlStateNormal];
        [deleteBut setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
        [deleteBut addTarget:self action:@selector(deleteMsg:) forControlEvents:UIControlEventTouchUpInside];
        deleteBut.highlighted=NO;
        [deleteMsgView addSubview:deleteBut];
    }
    
    [self.view addSubview:deleteMsgView];
    deleteMsgView.hidden=NO;
    [UIView animateWithDuration:0.2 animations:^{
        deleteMsgView.frame=CGRectMake(Width(60), point.y, kScreen_Width-Width(120), Height(40));
        deleteBut.frame=CGRectMake(0, 0, kScreen_Width-Width(120), Height(40));
        huiseControl.alpha=1;
    }];
    
}

-(void)deleteMsg:(id)sender
{
    [self huiseCotrolclick];
    MessageListModel *model=_dataSource[self.indexPath.section];
    NSString *sigen=[NSString stringWithFormat:@"%@",[kUserDefaults objectForKey:@"sigen"]];
    if ([sigen isEqualToString:@""]||[sigen containsString:@"null"]) {
        [self.dataSource removeObjectAtIndex:self.indexPath.section];
        [JMSHTDBDao deleteMessageInfoInMessageListWith:model];
        [_tableView beginUpdates];
        
        [_tableView deleteSections:[NSIndexSet indexSetWithIndex:self.indexPath.section] withRowAnimation:UITableViewRowAnimationRight];
        
        [_tableView endUpdates];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [_tableView reloadData];
        });
    }else
    {
    
    
    NSDictionary *params=@{@"sigen":[kUserDefaults objectForKey:@"sigen"],@"id":model.ID,@"sys_type":model.sysdate};
    [ATHRequestManager requestForMessageListDeleteMsgWithParams:params successBlock:^(NSDictionary *responseObj) {
  
      [self.dataSource removeObjectAtIndex:self.indexPath.section];

        [_tableView beginUpdates];
        
        [_tableView deleteSections:[NSIndexSet indexSetWithIndex:self.indexPath.section] withRowAnimation:UITableViewRowAnimationRight];
 
        [_tableView endUpdates];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [_tableView reloadData];
        });
        
    } faildBlock:^(NSError *error) {
        
    }];
    }
    
    NSLog(@"删除消息");
}

-(void)huiseCotrolclick
{
    [UIView animateWithDuration:0.2 animations:^{
        huiseControl.alpha=0;
        
    }completion:^(BOOL finished) {
        if (deleteMsgView.superview!=nil) {
            
            [deleteMsgView removeFromSuperview];
            [deleteBut removeFromSuperview];
            deleteMsgView=nil;
            deleteBut=nil;
        }
        
    }];
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}


-(void)initNavi
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
    
   UILabel  *Titlelabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 25+KSafeTopHeight, [UIScreen mainScreen].bounds.size.width-200, 30)];
    
    Titlelabel.text = @"消息中心";
    
    Titlelabel.textColor = [UIColor blackColor];
    
    Titlelabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:19];
    
    Titlelabel.textAlignment = NSTextAlignmentCenter;
    
    [titleView addSubview:Titlelabel];
    
    
}

-(void)QurtBtnClick{
    
    [self.navigationController popViewControllerAnimated:YES];
   //  self.tabBarController.tabBar.hidden=NO;
}

-(NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource=[NSMutableArray new];
    }
    return _dataSource;
}

-(void)setIsUnfoldWithTag:(NSUInteger)tag
{
   NSInteger index=tag-100;
    NSLog(@"index=%ld",index);
    MessageListModel *model=_dataSource[index];
    model.isOpen=!model.isOpen;
    [_tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:index]] withRowAnimation:UITableViewRowAnimationNone];
    
    
   //  [_tableView reloadRowsAtIndexPaths:[array copy] withRowAnimation:UITableViewRowAnimationNone];
   // NSIndexSet *set=[[NSIndexSet alloc]initWithIndex:index];
    
  //  [_tableView reloadSections:set withRowAnimation:UITableViewRowAnimationNone];
}


@end
