//
//  PersonalAddRefundShoppingVC.m
//  aTaohMall
//
//  Created by Hawky on 2017/11/22.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "PersonalAddRefundShoppingVC.h"

#import "PersonalShoppingRefundView.h"



#import "XLShoppingModel.h"
@interface PersonalAddRefundShoppingVC ()<UITableViewDelegate,UITableViewDataSource,XLRedNaviViewDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_dataArr;
    NSMutableArray *_flagArr;//是否选
    UIButton *selectBut;
}
@end

@implementation PersonalAddRefundShoppingVC

- (void)viewDidLoad {
    [super viewDidLoad];
}
-(void)setOrderBatchid:(NSString *)order_batchid Status:(NSString *)status andIds:(NSString *)ids
{
    self.order_batchid=order_batchid;
    self.status=status;
    self.ids=ids;
    [self getData];
    [self initNavi];
    [self initBottomView];
    [self initTable];
}

-(void)initBottomView
{
    UIView *bottomView=[[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight-49-KSafeAreaBottomHeight, kScreenWidth, 49)];
    [bottomView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:bottomView];

    selectBut=[UIButton buttonWithType:UIButtonTypeCustom];
    selectBut.frame=CGRectMake(Width(15), 17, 15, 15);
    [selectBut setImage:KImage(@"button_nochange") forState:UIControlStateNormal];
    [selectBut addTarget:self action:@selector(selectAllShop:) forControlEvents:UIControlEventTouchUpInside];
    selectBut.selected=NO;
    [bottomView addSubview:selectBut];

    UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMake(Width(15)+17+5, 18, 120, 13)];
    lab.font=KNSFONT(13);
    lab.textColor=RGB(51, 51, 51);
    lab.text=@"全选";
    [bottomView addSubview:lab];

    UIButton *sureBut=[UIButton buttonWithType:UIButtonTypeCustom];
    sureBut.frame=CGRectMake(kScreenWidth-Width(125), 0, Width(125), 49);
    [sureBut setTitle:@"确定" forState:UIControlStateNormal];
    [sureBut setTitleColor:RGB(255, 255, 255) forState:UIControlStateNormal];
    [sureBut setBackgroundColor:RGB(255, 93, 94)];
    [sureBut addTarget:self action:@selector(sure:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:sureBut];
}

-(void)sure:(id)sender
{
    if(![_flagArr containsObject:@"1"])
    {
        [TrainToast showWithText:@"请至少选择一种退款商品" duration:2.0];
        return;
    }

    NSMutableArray *arr=[NSMutableArray new];
    for (int i=0; i<_flagArr.count; i++) {
        if ([_flagArr[i] isEqualToString:@"1"]) {
            [arr addObject:_dataArr[i]];
        }
    }
    NSArray *dataarr1=[arr copy];
    if (_delegate&&[_delegate respondsToSelector:@selector(DidSelectShoppings:andHiddenAddBut:)]) {

        BOOL ishide=NO;
        if (dataarr1.count==_dataArr.count) {
            ishide=YES;
        }
        [_delegate DidSelectShoppings:dataarr1  andHiddenAddBut:ishide];
    }
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)selectAllShop:(UIButton *)sender
{
    sender.selected=!sender.selected;
    if(selectBut.selected)
    {
        [selectBut setImage:KImage(@"xuanzhong") forState:UIControlStateNormal];
    }else
    {
        [selectBut setImage:KImage(@"button_nochange") forState:UIControlStateNormal];
    }
    for (int i=0; i<_dataArr.count; i++) {
        if (selectBut.selected) {
          _flagArr[i]=@"1";
        }else
        {
            _flagArr[i]=@"0";
        }

        UIImageView *IV=[self.view viewWithTag:10000+i];
        if ([_flagArr[i] isEqualToString:@"1"]) {
            [IV setImage:KImage(@"xuanzhong")];

        }else
        {
            [IV setImage:KImage(@"button_nochange")];
        }
    }

}

-(void)initNavi
{
    NSString *title=@"";
    if ([_status isEqualToString:@"1"]) {
        title=@"添加退款退货商品";
    }
    else if ([_status isEqualToString:@"2"])
    {
        title=@"添加仅退款商品";
    }else
    {
        title=@"添加退款商品";
    }
    XLRedNaviView *navi=[[XLRedNaviView alloc]initWithMessage:title ImageName:@""];
    navi.delegate=self;
    [self.view addSubview:navi];

}
-(void)QurtBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)initTable
{
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight, kScreenWidth, kScreenHeight-KSafeAreaTopNaviHeight-KSafeAreaBottomHeight-49) style:UITableViewStyleGrouped];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;
    [self.view addSubview:_tableView];
}

-(void)getData
{
    NSDictionary *params=@{@"order_batchid":self.order_batchid,@"status":self.status};
    NSMutableArray *arr=[[NSMutableArray alloc] init];
    if (![self.ids containsString:@"_"]) {
        [arr addObject:self.ids];
    }else
    {
    arr=[[self.ids componentsSeparatedByString:@"_"] copy];
    }
    [ATHRequestManager requestforAddRefundOrderWithParams:params successBlock:^(NSDictionary *responseObj) {
        if ([responseObj[@"status"] isEqualToString:@"10000"]) {
            _dataArr=[[NSMutableArray alloc] init];
            _flagArr=[[NSMutableArray alloc] init];
            [_dataArr removeAllObjects];
            [_flagArr removeAllObjects];
            for (NSDictionary *goodsDic in responseObj[@"order_list"]) {
                XLShoppingModel *model=[XLShoppingModel new];
                model.attribute_str=[NSString stringWithFormat:@"%@",goodsDic[@"attribute_str"]];
                if ([model.attribute_str containsString:@"null"]) {
                    model.attribute_str=@"";
                }
                model.count=[NSString stringWithFormat:@"%@",goodsDic[@"count"]];
                model.detailId=[NSString stringWithFormat:@"%@",goodsDic[@"detailId"]];
                model.gid=[NSString stringWithFormat:@"%@",goodsDic[@"gid"]];
                model.ID=[NSString stringWithFormat:@"%@",goodsDic[@"id"]];
                model.mid=[NSString stringWithFormat:@"%@",goodsDic[@"mid"]];
                model.name=[NSString stringWithFormat:@"%@",goodsDic[@"name"]];
                model.number=[NSString stringWithFormat:@"%@",goodsDic[@"number"]];
                model.order_type=[NSString stringWithFormat:@"%@",goodsDic[@"order_type"]];
                model.order_no=[NSString stringWithFormat:@"%@",goodsDic[@"orderno"]];
                model.pay_integer=[NSString stringWithFormat:@"%@",goodsDic[@"pay_integer"]];
                model.pay_money=[NSString stringWithFormat:@"%@",goodsDic[@"pay_maney"]];
                model.payinteger=[NSString stringWithFormat:@"%@",goodsDic[@"payintegral"]];
                model.paymoney=[NSString stringWithFormat:@"%@",goodsDic[@"paymoney"]];
                model.scopeimg=[NSString stringWithFormat:@"%@",goodsDic[@"scopeimg"]];
                model.status=[NSString stringWithFormat:@"%@",goodsDic[@"status"]];
                model.stocks=[NSString stringWithFormat:@"%@",goodsDic[@"stocks"]];
                model.totalfreight=[NSString stringWithFormat:@"%@",goodsDic[@"totalfreight"]];
                model.type=[NSString stringWithFormat:@"%@",goodsDic[@"type"]];
                model.order_batchid=[NSString stringWithFormat:@"%@",goodsDic[@"order_batchid"]];
                [_dataArr addObject:model];
                if ([arr containsObject:model.ID]) {
                    [_flagArr addObject:@"1"];
                }else
                {
                [_flagArr addObject:@"0"];
                }
            }
            if (![_flagArr containsObject:@"0"]) {
                selectBut.selected=YES;
                [selectBut setImage:KImage(@"xuanzhong") forState:UIControlStateNormal];
            }
            [_tableView reloadData];
        }else
        {
            [TrainToast showWithText:responseObj[@"message"] duration:2.0];
        }
    } faildBlock:^(NSError *error) {

    }];
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return Height(30)+70;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    [cell.contentView setBackgroundColor:[UIColor whiteColor]];
    UIImageView *selectIV=[[UIImageView alloc] initWithFrame:CGRectMake(Width(15), Height(15)+27.5, 15, 15)];
    if ([_flagArr[indexPath.row] isEqualToString:@"1"])
    {
        cell.selected=YES;
        [selectIV setImage:KImage(@"xuanzhong")];
    }else{
    cell.selected=NO;
    [selectIV setImage:KImage(@"button_nochange")];
    }
    [cell addSubview:selectIV];
    selectIV.tag=10000+indexPath.row;
    XLShoppingModel *model=_dataArr[indexPath.row];

    PersonalShoppingRefundView *view=[[PersonalShoppingRefundView alloc] initWithFrame:CGRectMake(Width(15)+15, 0, kScreenWidth-Width(15)-15, 70+Height(30)) AndShoppingName:model.name scopimgName:model.scopeimg attributeStr:model.attribute_str];
    [cell addSubview:view];

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    UIImageView *IV=[self.view viewWithTag:10000+indexPath.row];
    [_flagArr[indexPath.row] isEqualToString:@"0"]?(_flagArr[indexPath.row]=@"1"):(_flagArr[indexPath.row]=@"0");
    if ([_flagArr[indexPath.row] isEqualToString:@"1"]) {
        [IV setImage:KImage(@"xuanzhong")];
    }else
    {
        [IV setImage:KImage(@"button_nochange")];
    }
    BOOL selectAll=YES;

    for (NSString *str in _flagArr) {
        if ([str isEqualToString:@"0"]) {
            selectAll=NO;
        }
    }

    if (selectAll) {
        selectBut.selected=YES;

            [selectBut setImage:KImage(@"xuanzhong") forState:UIControlStateNormal];
    }else
    {
        selectBut.selected=NO;


            [selectBut setImage:KImage(@"button_nochange") forState:UIControlStateNormal];
    }

}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

@end
