//
//  PersonalTwoOrMoreLogisticsDetailVC.m
//  aTaohMall
//
//  Created by Hawky on 2017/11/16.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "PersonalTwoOrMoreLogisticsDetailVC.h"




#import "PersonalLogisticsCell.h"

#import "PersonalLogisticModel.h"

#import "XLRedNaviView.h"


@interface PersonalTwoOrMoreLogisticsDetailVC ()<UITableViewDelegate,UITableViewDataSource,XLRedNaviViewDelegate>
{
    UITableView *_MyTableView;


}
@property (nonatomic,strong)NSMutableArray *dataArr;

@end

@implementation PersonalTwoOrMoreLogisticsDetailVC




/*******************************************************      控制器生命周期       ******************************************************/
//
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavi];
    [self GetData];

}
-(void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden=YES;
}

/*******************************************************      数据请求       ******************************************************/

//
-(void)GetData
{

    NSDictionary *params=@{@"order_batchid":self.model.order_batchid,@"waybillnumber":@""};
    WKProgressHUD *hud=[WKProgressHUD showInView:self.view  withText:nil animated:YES];
    [ATHRequestManager requestforqueryLogisticsWithParams:params successBlock:^(NSDictionary *responseObj) {

        if ([responseObj[@"status"] isEqualToString:@"10000"]) {
            for (NSDictionary *dic in responseObj[@"logistics_list"]) {
                PersonalLogisticModel *model=[[PersonalLogisticModel alloc] init];
                model.scopeimg=[NSString stringWithFormat:@"%@",dic[@"scopeimg"]];
                model.logistics_type=[NSString stringWithFormat:@"%@",dic[@"logistics_type"]];
                model.goods_number=[NSString stringWithFormat:@"%@",dic[@"goods_number"]];
                model.name=[NSString stringWithFormat:@"%@",dic[@"name"]];
                model.company=[NSString stringWithFormat:@"%@",dic[@"company"]];
                model.waybillnumber=[NSString stringWithFormat:@"%@",dic[@"waybillnumber"]];
                model.logistics_remark=[NSString stringWithFormat:@"%@",dic[@"logistics_remark"]];
                [self.dataArr addObject:model];
            }

        }else
        {
            [TrainToast showWithText:responseObj[@"message"] duration:2.0];
        }
        [self setUI];
        [hud dismiss:YES];
    } faildBlock:^(NSError *error) {

        [self setUI];
        [hud dismiss:YES];
    }];
}

/*******************************************************      初始化视图       ******************************************************/
//
-(void)setUI
{
    [self initTableView];
}
//
-(void)initNavi
{

    XLRedNaviView *navi=[[XLRedNaviView alloc] initWithMessage:@"查看物流" ImageName:@""];
    navi.delegate=self;
    [self.view addSubview:navi];

}
//
-(void)initTableView
{
    _MyTableView =[[UITableView alloc] initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight, kScreen_Width, kScreen_Height-KSafeAreaTopNaviHeight) style:UITableViewStyleGrouped];
    _MyTableView.delegate=self;
    _MyTableView.dataSource=self;
    _MyTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _MyTableView.estimatedRowHeight = 0;
    _MyTableView.estimatedSectionHeaderHeight = 0;
    _MyTableView.estimatedSectionFooterHeight = 0;
    [self.view addSubview:_MyTableView];
    [_MyTableView registerClass:[PersonalLogisticsCell class] forCellReuseIdentifier:@"cell"];

}
//
/*******************************************************      各种button执行方法、页面间的跳转       ******************************************************/

/*******************************************************      协议方法       ******************************************************/

//
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    YLog(@"%ld",_dataArr.count);
    return self.dataArr.count;
}
//
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return Height(30)+82;
}
//
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PersonalLogisticsCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.dataModel=_dataArr[indexPath.row];
    return cell;
}
//
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PersonalLogisticsDetailVC *VC=[[PersonalLogisticsDetailVC alloc] init];

    self.model.waybillnumber=[(PersonalLogisticModel *)_dataArr[indexPath.row] waybillnumber];
    VC.model=self.model;
    [self.navigationController pushViewController:VC animated:NO];
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return Height(10);
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 34;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{

    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width,33)];

    UILabel *lab=[[UILabel alloc] init];
    [lab setFrame:CGRectMake(Width(15), Height(10), kScreen_Width-30, 14)];
    [lab setFont:KNSFONT(14)];
    [lab setTextColor:RGB(51, 51, 51)];
    [lab setText:[NSString stringWithFormat:@"共%ld个包裹",_dataArr.count]];
    [view addSubview:lab];
    return view;

}

/*******************************************************      代码提取(多是复用代码)       ******************************************************/
//
-(void)QurtBtnClick
{

    [self.navigationController popViewControllerAnimated:NO];

}

//
-(NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr=[NSMutableArray new];
    }
    return _dataArr;
}


@end

