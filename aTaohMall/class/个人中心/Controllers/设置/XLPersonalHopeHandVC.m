//
//  XLPersonalHopeHandVC.m
//  aTaohMall
//
//  Created by Hawky on 2018/2/26.
//  Copyright © 2018年 ysy. All rights reserved.
//

#import "XLPersonalHopeHandVC.h"

#import "XLPersonalSatiCell.h"

#import "XLNaviVIew.h"
@interface XLPersonalHopeHandVC ()<UITableViewDataSource,UITableViewDelegate,XLNaviViewDelegate>
{
     UITableView *_tableView;
    NSArray *dataArr;
}
@end

@implementation XLPersonalHopeHandVC

- (void)viewDidLoad {
    [super viewDidLoad];

    XLNaviView *navi=[[XLNaviView alloc] initWithMessage:@"帮助" ImageName:nil];
    navi.delegate=self;
    [self.view addSubview:navi];
    dataArr=@[@"常见问题",@"如何兑换",@"支付相关",@"积分产生"];

    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight, kScreen_Width, kScreenHeight-KSafeAreaTopNaviHeight-KSafeAreaBottomHeight) style:UITableViewStyleGrouped];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.bounces=NO;
    _tableView.estimatedRowHeight=44;
    _tableView.estimatedSectionHeaderHeight=10;
    _tableView.estimatedSectionFooterHeight=0;
    _tableView.showsVerticalScrollIndicator=NO;
    [_tableView registerNib:[UINib nibWithNibName:@"XLPersonalSatiCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_tableView];
    // Do any additional setup after loading the view.
}

-(void)QurtBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XLPersonalSatiCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.nameLab.text=dataArr[indexPath.row];
    cell.detailLab.text=@"";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *url=@"";
    NSString *title=dataArr[indexPath.row];
    switch (indexPath.row) {
//            /getCommonProblem_wap.shtml?type=1常见问题    /getIntegralGeneration_wap.shtml?type=1 积分产生
//            /getPaymentRelated_wap.shtml?type=1 支付相关
//            /getHowToChange_wap.shtml?type=1 如何兑换
        case 0:
            url=@"getCommonProblem_wap.shtml?type=2";
            break;
        case 1:
            url=@"getIntegralGeneration_wap.shtml?type=2";
            break;
        case 2:
            url=@"getPaymentRelated_wap.shtml?type=2";
            break;
        case 3:
            url=@"getHowToChange_wap.shtml?type=2";
            break;
        default:
            break;
    }
    RequestServiceVC *VC=[[RequestServiceVC alloc] initWithURLStr:url withTitle:title];
    [self.navigationController pushViewController:VC animated:NO];

}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[UIView alloc]init];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [[UIView alloc]init];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
