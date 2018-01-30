//
//  PersonalShoppingDanDetailVC.m
//  aTaohMall
//
//  Created by DingDing on 2017/11/6.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "PersonalShoppingDanDetailVC.h"
//店铺
#import "MerchantDetailViewController.h"
//商品详情
#import "YTGoodsDetailViewController.h"
//物流
#import "PersonalLogisticsDetailVC.h"
#import "PersonalTwoOrMoreLogisticsDetailVC.h"
//退款
#import "PersonalShoppingRefundTypeVC.h"
#import "PersonalShoppingReplyRefundVC.h"
//退款详情
#import "PersonalShoppingRefundDanDetailVC.h"
//协商记录
#import "ConsultNounVC.h"


#import "PersonalShoppingDanDetailModel.h"
#import "XLDingDanModel.h"

#import "PersonalShoppingSectionHeaderView.h"
#import "PersonalShoppingDanCell.h"
#import "PersonalShoppingDanDetailHeaderView.h"
#import "PersonalShoppingDandetailFooterView.h"



#import "WKProgressHUD.h"

static NSString * const XLConstPersonalShoppingDanCell=@"PersonalShoppingDanCell";
static NSString * const XLConstPersonalShoppingSectionHeaderView=@"PersonalShoppingSectionHeaderView";
static NSString * const XLConstPersonalShoppingDandetailFooterView=@"PersonalShoppingDandetailFooterView";
static NSString * const XLConstPersonalShoppingDanDetailHeaderView=@"PersonalShoppingDanDetailHeaderView";

@interface PersonalShoppingDanDetailVC ()<UITableViewDelegate,UITableViewDataSource,PersonalShoppingDanCellDelegat,PersonalShoppingDanDetailHeaderViewDelegate,PersonalShoppingDandetailFooterViewDelegate>

@property (nonatomic,strong)UIImage *BackImage;
@property (nonatomic,strong)PersonalShoppingDanDetailModel *DataModel;
@property (nonatomic,strong)UITableView *MyTableView;


/*
 底部操作按钮
 */
@property (nonatomic,strong)UIImageView *bottomLine;
@property (nonatomic,strong)UIButton *checkLogisticsBut;
@property (nonatomic,strong)UIButton *continuePayBut;
@property (nonatomic,strong)UIButton *sureReceiveBut;
@property (nonatomic,strong)UIButton *refundBut;
@property (nonatomic,strong)UIView *bottomView;

@end

@implementation PersonalShoppingDanDetailVC

/*******************************************************      控制器生命周期       ******************************************************/
- (void)viewDidLoad {

    [super viewDidLoad];
    [self SetData];
    [KNotificationCenter addObserver:self selector:@selector(PayCallBack:) name:JMSHTPayCallBack object:nil];
}
-(void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden=YES;
}

//
-(void)SetUI
{
    [self initNavi];
    [self initTableView];
    [self initBottomView];
}

//
-(void)SetData
{
    [self GetDatas];
}
//
-(void)loadData
{
    [self.view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self SetUI];
}
/*******************************************************      数据请求       ******************************************************/
//
-(void)GetDatas
{

    WKProgressHUD *hud=[WKProgressHUD showInView:self.view withText:nil animated:YES];
    NSDictionary *params=@{@"sigen":[kUserDefaults objectForKey:@"sigen"],@"order_batchid":_myDingDanModel.order_batchid};
    [ATHRequestManager requestforGetShoppingDanDetailWithParams:params successBlock:^(NSDictionary *responseObj) {

        if ([responseObj[@"status"] isEqualToString:@"10000"]) {
            [self DataModel];
            _DataModel.buyer_message=[NSString stringWithFormat:@"%@",responseObj[@"buyer_message"]];

            NSString *str =_DataModel.buyer_message;
            str = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]; //去除掉首尾的空白字符和换行字符
            str = [str stringByReplacingOccurrencesOfString:@"\r" withString:@""];
            str = [str stringByReplacingOccurrencesOfString:@"\n" withString:@""];
            _DataModel.buyer_message=str;
            _DataModel.leave_date=[NSString stringWithFormat:@"%@",responseObj[@"leave_date"]];
            _DataModel.logo=[NSString stringWithFormat:@"%@",responseObj[@"logo"]];
            _DataModel.mid=[NSString stringWithFormat:@"%@",responseObj[@"mid"]];
            _DataModel.order_batchid=[NSString stringWithFormat:@"%@",responseObj[@"order_batchid"]];
            _DataModel.pay_date=[NSString stringWithFormat:@"%@",responseObj[@"pay_date"]];
            _DataModel.storename=[NSString stringWithFormat:@"%@",responseObj[@"storename"]];
            _DataModel.sys_date=[NSString stringWithFormat:@"%@",responseObj[@"sys_date"]];
            _DataModel.total_freight=[NSString stringWithFormat:@"%@",responseObj[@"total_freight"]];
            _DataModel.total_integral=[NSString stringWithFormat:@"%@",responseObj[@"total_integral"]];
            _DataModel.total_money=[NSString stringWithFormat:@"%@",responseObj[@"total_money"]];
            _DataModel.total_status=[NSString stringWithFormat:@"%@",responseObj[@"total_status"]];
            _DataModel.uaddress=[NSString stringWithFormat:@"%@",responseObj[@"uaddress"]];
            _DataModel.uphone=[NSString stringWithFormat:@"%@",responseObj[@"uphone"]];
            _DataModel.userName=[NSString stringWithFormat:@"%@",responseObj[@"username"]];
            _DataModel.logistics_message=[NSString stringWithFormat:@"%@",responseObj[@"logistics_message"]];
            _DataModel.logistics_time=[NSString stringWithFormat:@"%@",responseObj[@"logistics_time"]];
            if ([_DataModel.logistics_time isEqualToString:@""]||[_DataModel.logistics_time containsString:@"null"]) {
                _DataModel.logistics_time=@"暂无相关物流信息。";
            }
            
            /*
             String sys_date = "";            //创建时间
             String pay_time = "";            //付款时间
             String leave_date = "";            //发货时间
             String checkdate = "";            //交易时间
             String refund_time = "";        //退款/仅退款/退款退货时间
             String sure_refund_time = "";    //确认退款时间
             */
            _DataModel.pay_time=[NSString stringWithFormat:@"%@",responseObj[@"pay_time"]];
            _DataModel.checkdate=[NSString stringWithFormat:@"%@",responseObj[@"checkdate"]];
            _DataModel.refund_time=[NSString stringWithFormat:@"%@",responseObj[@"refund_time"]];
            _DataModel.sure_refund_time=[NSString stringWithFormat:@"%@",responseObj[@"sure_refund_time"]];
            NSArray *tempArr=responseObj[@"order_list"];
            [_DataModel orderListFromArray:tempArr];
        }else
        {
            [TrainToast showWithText:responseObj[@"message"] duration:2.0];
        }
        [hud dismiss:YES];
        [self loadData];
    } faildBlock:^(NSError *error) {
        [hud dismiss:YES];
        [self loadData];
    }];
}
/*******************************************************      初始化视图       ******************************************************/
//
-(void)initNavi
{
    UIImageView *titleView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, KSafeAreaTopNaviHeight)];

    UIImage *img=[self.BackImage getSubImage:CGRectMake(0, 0, kScreen_Width, KSafeAreaTopNaviHeight)];
    [titleView setImage:img];
    titleView.userInteractionEnabled=YES;
    [self.view addSubview:titleView];

    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight-1, [UIScreen mainScreen].bounds.size.width, 1)];

    line.image = [UIImage imageNamed:@"分割线-拷贝"];

   // [self.view addSubview:line];

    //返回按钮

    UIButton *Qurt = [UIButton buttonWithType:UIButtonTypeCustom];

    Qurt.frame = CGRectMake(10, 25+KSafeTopHeight, 30, 30);

    //    [Qurt setBackgroundImage:[UIImage imageNamed:@"iconfont-fanhui2yt"] forState:0];

    [Qurt setImage:[UIImage imageNamed:@"iconfont-fanhui2"] forState:UIControlStateNormal];
 //   [Qurt setImage:[UIImage imageNamed:@"iconfont-fanhui2"] forState:UIControlStateSelected];
    [Qurt addTarget:self action:@selector(QurtBtnClick) forControlEvents:UIControlEventTouchUpInside];

    [titleView addSubview:Qurt];

    //创建搜索

    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 25+KSafeTopHeight, [UIScreen mainScreen].bounds.size.width-200, 30)];

    label.text = @"订单详情";

    label.textColor = [UIColor whiteColor];

    label.font = KNSFONT(19);

    label.textAlignment = NSTextAlignmentCenter;

    [titleView addSubview:label];

}
//
-(void)initBottomView
{

    if (!_DataModel.BottomButShow) {
        return;
    }

    self.bottomView=[[UIView alloc] init];
    self.bottomView.frame=CGRectMake(0, kScreenHeight-(1+Height(15)+27+Height(15))-KSafeAreaBottomHeight, kScreenWidth, 1+Height(15)+27+Height(15));
    [self.view addSubview:self.bottomView];

    self.bottomLine=[[UIImageView alloc] init];
    [self.bottomView addSubview:self.bottomLine];

    self.continuePayBut=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.continuePayBut setTitleColor:RGB(255, 93, 94) forState:UIControlStateNormal];
    self.continuePayBut.titleLabel.font=KNSFONTM(14);
    [self.bottomView addSubview:self.continuePayBut];

    self.checkLogisticsBut=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.checkLogisticsBut setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
    self.checkLogisticsBut.titleLabel.font=KNSFONTM(14);
    [self.bottomView addSubview:self.checkLogisticsBut];

    self.refundBut=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.refundBut setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
    self.refundBut.titleLabel.font=KNSFONTM(14);
    [self.bottomView addSubview:self.refundBut];

    self.sureReceiveBut=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.sureReceiveBut setTitleColor:RGB(255, 93, 94) forState:UIControlStateNormal];
    self.sureReceiveBut.titleLabel.font=KNSFONTM(14);
    [self.bottomView addSubview:self.sureReceiveBut];

    /*
     底部操作按钮
     */
    [self.bottomLine setImage:KImage(@"分割线-拷贝")];
    [self.continuePayBut setTitle:@"继续付款" forState:UIControlStateNormal];
    [self.refundBut setTitle:@"退款/退货" forState:UIControlStateNormal];
    if ([_DataModel.total_status isEqualToString:@"0"]) {
        [self.refundBut setTitle:@"退款" forState:UIControlStateNormal];
    }
    [self.checkLogisticsBut setTitle:@"查看物流" forState:UIControlStateNormal];
    [self.sureReceiveBut setTitle:@"确认收货" forState:UIControlStateNormal];

    /*
     底部操作按钮
     */
    [self.continuePayBut setFrame:CGRectZero];
    [self.refundBut setFrame:CGRectZero];
    [self.checkLogisticsBut setFrame:CGRectZero];
    [self.sureReceiveBut setFrame:CGRectZero];
    [self.bottomLine setFrame:CGRectZero];

    if ([_DataModel.total_status isEqualToString:@"7"]) {
        [self.bottomLine setFrame:CGRectMake(0, 0, kScreen_Width, 1)];
        [self.continuePayBut setFrame:CGRectMake(kScreen_Width-Width(15)-90,+1+Height(15), 90, 27)];
        [self.continuePayBut.layer setCornerRadius:13.5];
        [self.continuePayBut.layer setBorderColor:RGB(255, 93, 94).CGColor];
        [self.continuePayBut.layer setBorderWidth:1];
        [self.continuePayBut addTarget:self action:@selector(continuePayWithModel:) forControlEvents:UIControlEventTouchUpInside];
    }else if ([_DataModel.total_status isEqualToString:@"0"]&&(_DataModel.order_list.count ==1))
    {
        [self.bottomLine setFrame:CGRectMake(0, 0, kScreen_Width, 1)];
        [self.refundBut setFrame:CGRectMake(kScreen_Width-Width(15)-90, 0+1+Height(15), 90, 27)];
        [self.refundBut.layer setCornerRadius:13.5];
        [self.refundBut.layer setBorderColor:RGB(51, 51, 51).CGColor];
        [self.refundBut.layer setBorderWidth:1];
        [self.refundBut addTarget:self action:@selector(refundMoneyWithModel:) forControlEvents:UIControlEventTouchUpInside];

    }else if ([_DataModel.total_status isEqualToString:@"1"])
    {
        [self.bottomLine setFrame:CGRectMake(0, 0, kScreen_Width, 1)];

        [self.sureReceiveBut setFrame:CGRectMake(kScreen_Width-Width(15)-90, 0+1+Height(15), 90, 27)];
        [self.sureReceiveBut.layer setCornerRadius:13.5];
        [self.sureReceiveBut.layer setBorderColor:RGB(255, 93, 94).CGColor];
        [self.sureReceiveBut.layer setBorderWidth:1];

        [self.checkLogisticsBut setFrame:CGRectMake(kScreen_Width-Width(15)-90*2-Width(10), 0+1+Height(15), 90, 27)];
        [self.checkLogisticsBut.layer setCornerRadius:13.5];
        [self.checkLogisticsBut.layer setBorderColor:RGB(51, 51, 51).CGColor];
        [self.checkLogisticsBut.layer setBorderWidth:1];

        if (_DataModel.order_list.count ==1) {
            [self.refundBut setFrame:CGRectMake(kScreen_Width-Width(15)-90*3-Width(10)*2, 0+1+Height(15), 90, 27)];
            [self.refundBut.layer setCornerRadius:13.5];
            [self.refundBut.layer setBorderColor:RGB(51, 51, 51).CGColor];
            [self.refundBut.layer setBorderWidth:1];
            [self.refundBut addTarget:self action:@selector(refundMoneyWithModel:) forControlEvents:UIControlEventTouchUpInside];
        }
        [self.sureReceiveBut addTarget:self action:@selector(sureReceiveWithModel:) forControlEvents:UIControlEventTouchUpInside];
        [self.checkLogisticsBut addTarget:self action:@selector(checkLogisticInfoWithModel:) forControlEvents:UIControlEventTouchUpInside];

    }else if ([_DataModel.total_status isEqualToString:@"2"]||[_DataModel.total_status isEqualToString:@"5"]||[_DataModel.total_status isEqualToString:@"10"]||[_DataModel.total_status isEqualToString:@"4"]||[_DataModel.total_status isEqualToString:@"11"])
    {
        [self.bottomLine setFrame:CGRectMake(0, 0, kScreen_Width, 1)];
        [self.checkLogisticsBut setFrame:CGRectMake(kScreen_Width-Width(15)-90, 0+1+Height(15), 90, 27)];
        [self.checkLogisticsBut.layer setCornerRadius:13.5];
        [self.checkLogisticsBut.layer setBorderColor:RGB(51, 51, 51).CGColor];
        [self.checkLogisticsBut.layer setBorderWidth:1];
        [self.checkLogisticsBut addTarget:self action:@selector(checkLogisticInfoWithModel:) forControlEvents:UIControlEventTouchUpInside];
    }

    PersonalSingleShoppingDetailModel *model=_DataModel.order_list.lastObject;
    if ([model.type isEqualToString:@"1"]) {
        [self.refundBut setFrame:CGRectZero];
    }

    
}


//
-(void)initTableView
{
    CGFloat bottomHeight=0;
    if (_DataModel.BottomButShow) {
        bottomHeight=1+Height(15)+Height(15)+27;
    }

    self.MyTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight, kScreen_Width, kScreen_Height-KSafeAreaTopNaviHeight-KSafeAreaBottomHeight-bottomHeight) style:UITableViewStyleGrouped];
    self.MyTableView.showsHorizontalScrollIndicator=NO;
    _MyTableView.delegate=self;
    _MyTableView.dataSource=self;
    _MyTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _MyTableView.showsVerticalScrollIndicator=NO;
    _MyTableView.bounces=NO;
    [_MyTableView registerClass:[PersonalShoppingDanCell class] forCellReuseIdentifier:XLConstPersonalShoppingDanCell];

    [_MyTableView registerClass:[PersonalShoppingDanDetailHeaderView class] forHeaderFooterViewReuseIdentifier:XLConstPersonalShoppingDanDetailHeaderView];
    [_MyTableView registerClass:[PersonalShoppingDandetailFooterView class] forHeaderFooterViewReuseIdentifier:XLConstPersonalShoppingDandetailFooterView];
    [self.view addSubview:self.MyTableView];
}

/*******************************************************      各种button执行方法、页面间的跳转       ******************************************************/
//
-(void)QurtBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

/*******************************************************      协议方法       ******************************************************/

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return _DataModel.order_list.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    PersonalSingleShoppingDetailModel *model=_DataModel.order_list[indexPath.row];
    PersonalShoppingDanCell *cell=[tableView dequeueReusableCellWithIdentifier:XLConstPersonalShoppingDanCell forIndexPath:indexPath];
    XLShoppingModel *shopModel=[XLShoppingModel new];
    shopModel.scopeimg=model.scopeimg;
    shopModel.attribute_str=model.attribute_str;
    shopModel.name=model.name;
    shopModel.number=model.number;
    shopModel.pay_money=model.pay_money;
    shopModel.pay_integer=model.pay_integer;
    shopModel.status=model.status;
    shopModel.isSingle=_DataModel.order_list.count>1?NO:YES;
    shopModel.order_batchid=model.order_batchid;
    shopModel.order_no=model.orderno;
    shopModel.refund_count=model.refund_count;
    shopModel.return_goods_count=model.return_goods_count;
    shopModel.getdate=model.getdate;
    shopModel.order_type=model.order_type;
    shopModel.paymoney=model.paymoney;
    shopModel.payinteger=model.payintegral;
    shopModel.totalfreight=model.totalfreight;
    shopModel.ID=model.ID;
    YLog(@"%@,%@",model.getdate,shopModel.getdate);
    if ([shopModel.status isEqualToString:@"3"]||[shopModel.status isEqualToString:@"4"]||[shopModel.status isEqualToString:@"5"]||[shopModel.status isEqualToString:@"6"]||[shopModel.status isEqualToString:@"10"]||[shopModel.status isEqualToString:@"11"]||([shopModel.status isEqualToString:@"2"]&&([shopModel.refund_count integerValue]>0||[shopModel.return_goods_count integerValue]>0))) {
        shopModel.isSingle=NO;
    }

    [cell loadData:shopModel];
    cell.singleRefundBut.tag=1000+indexPath.row;
    cell.delegate=self;
  //  [cell.singleRefundBut addTarget:self action:@selector(refundSingleShopping:) forControlEvents:UIControlEventTouchUpInside];

    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    PersonalShoppingDanDetailHeaderView *view=[tableView dequeueReusableHeaderFooterViewWithIdentifier:XLConstPersonalShoppingDanDetailHeaderView];
    [view loadData:_DataModel];
    view.delegate=self;
    return view;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    PersonalShoppingDandetailFooterView *view=[tableView dequeueReusableHeaderFooterViewWithIdentifier:XLConstPersonalShoppingDandetailFooterView];
    [view loadData:_DataModel];
    view.delegate=self;
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   PersonalSingleShoppingDetailModel *model=_DataModel.order_list[indexPath.row];
    YLog(@"%@,%@,%@",model.refund_count,model.return_goods_count,model.status);
    if ([model.status isEqualToString:@"3"]||[model.status isEqualToString:@"4"]||[model.status isEqualToString:@"5"]||[model.status isEqualToString:@"6"]||[model.status isEqualToString:@"10"]||[model.status isEqualToString:@"11"]||([model.status isEqualToString:@"2"]&&([model.refund_count integerValue]>2||[model.return_goods_count integerValue]>2))) {
        model.IsSingle=NO;
    }
    return model.cellHeight;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return _DataModel.headerHeight;
   // return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    YLog(@"%lf",_DataModel.footHeight);
    return _DataModel.footHeight;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PersonalSingleShoppingDetailModel *model=_DataModel.order_list[indexPath.row];
    YTGoodsDetailViewController *VC=[[YTGoodsDetailViewController alloc] init];
    VC.gid=model.gid;
    [self.navigationController pushViewController:VC animated:NO];
    YLog(@"商品详情---%@--",model.name);
}

#pragma mark-cell协议
//单个商品退款
-(void)refundSingleShoppingWithModel:(XLShoppingModel *)model Cell:(UITableViewCell *)cell
{
    if ([model.status isEqualToString:@"0"]) {
        //0退款 1退货退款
        NSDictionary *params=@{@"ids":model.ID,@"refund_status":@"0"};
        [ATHRequestManager requestforgetRefundNumberWithParams:params successBlock:^(NSDictionary *responseObj) {
            if ([responseObj[@"status"] isEqualToString:@"10000"]) {
                NSString *type=[NSString stringWithFormat:@"%@",responseObj[@"total_type"]];
                NSString *refund_num=[NSString stringWithFormat:@"%@",responseObj[@"refund_number"]];
                model.goodsCount=[NSString stringWithFormat:@"%@",responseObj[@"goods_count"]];
                if ([type isEqualToString:@"0"]) {
                    PersonalShoppingReplyRefundVC *VC=[[PersonalShoppingReplyRefundVC alloc] init];
                    [VC setDataModel:model AndRefundType:@"0" andRefundTime:[refund_num integerValue] andQurtAllDan:NO];
                    [self.navigationController pushViewController:VC animated:NO];
                }else if ([type isEqualToString:@"1"])
                {
                    PersonalShoppingRefundDanDetailVC *VC=[[PersonalShoppingRefundDanDetailVC alloc] init];
                    VC.dataModel=model;
                    VC.kefuJieru=YES;
                    [self.navigationController pushViewController:VC animated:NO];
                }
                else
                {
                    [self SetData];
                    [TrainToast showWithText:responseObj[@"message"] duration:2.0];
                }


            }else
            {
                [self SetData];
                [TrainToast showWithText:responseObj[@"message"] duration:2.0];
            }


        } faildBlock:^(NSError *error) {

        }];


    }else if ([model.status isEqualToString:@"1"])
    {
        //0退款 1退货退款
        NSDictionary *params=@{@"ids":model.ID,@"refund_status":@"1"};
        [ATHRequestManager requestforgetRefundNumberWithParams:params successBlock:^(NSDictionary *responseObj) {
            if ([responseObj[@"status"] isEqualToString:@"10000"]) {

                NSString *type=[NSString stringWithFormat:@"%@",responseObj[@"total_type"]];

                NSString *refund_num=[NSString stringWithFormat:@"%@",responseObj[@"refund_number"]];
                model.goodsCount=[NSString stringWithFormat:@"%@",responseObj[@"goods_count"]];
                if ([type isEqualToString:@"0"]) {
                    PersonalShoppingRefundTypeVC *VC=[[PersonalShoppingRefundTypeVC alloc] init];
                    VC.dataModel=model;
                    VC.RefundTotalTime=[refund_num integerValue];

                    YLog(@"%@",model.order_batchid);
                    [self.navigationController pushViewController:VC animated:NO];
                }else if ([type isEqualToString:@"1"])
                {
                    PersonalShoppingRefundDanDetailVC *VC=[[PersonalShoppingRefundDanDetailVC alloc] init];
                    VC.dataModel=model;
                    VC.kefuJieru=YES;
                    [self.navigationController pushViewController:VC animated:NO];
                }
                else
                {
                    [self SetData];
                    [TrainToast showWithText:responseObj[@"message"] duration:2.0];
                }


            }else
            {
                [self SetData];
                [TrainToast showWithText:responseObj[@"message"] duration:2.0];
            }


        } faildBlock:^(NSError *error) {

        }];

    }

    else if ([model.status isEqualToString:@"3"]||[model.status isEqualToString:@"4"]||[model.status isEqualToString:@"5"]||[model.status isEqualToString:@"6"]||[model.status isEqualToString:@"10"]||[model.status isEqualToString:@"11"])
    {


        PersonalShoppingRefundDanDetailVC *VC=[[PersonalShoppingRefundDanDetailVC alloc] init];
        VC.dataModel=model;
        [self.navigationController pushViewController:VC animated:NO];

    }else if([model.status isEqualToString:@"2"]&&([model.refund_count integerValue]>0||[model.return_goods_count integerValue]>0))
    {
        ConsultNounVC *VC=[[ConsultNounVC alloc] init];
        VC.DataModel=model;
        [self.navigationController pushViewController:VC animated:NO];

    }






    YLog(@"单个商品退款");
}

#pragma mark-头视图协议
//查看物流
-(void)checkLogisticsInfoWithModel:(PersonalShoppingDanDetailModel *)model
{
    NSDictionary *params=@{@"order_batchid":_myDingDanModel.order_batchid};
    //检查包裹个数判断去哪个页面
    [ATHRequestManager requestforGetLogisticsNumberWithParams:params successBlock:^(NSDictionary *responseObj) {
        if ([responseObj[@"status"] isEqualToString:@"10000"]) {
            NSInteger logisticNum=[responseObj[@"total_count"] integerValue];
            //单个包裹
            if (logisticNum==1) {
                PersonalLogisticsDetailVC *VC=[[PersonalLogisticsDetailVC alloc] init];
                VC.model=_myDingDanModel;
                VC.hidesBottomBarWhenPushed=YES;
                [self.navigationController pushViewController:VC animated:NO];
            }else
            {
                PersonalTwoOrMoreLogisticsDetailVC *VC=[[PersonalTwoOrMoreLogisticsDetailVC alloc] init];
                VC.model=_myDingDanModel;
                VC.hidesBottomBarWhenPushed=YES;
                [self.navigationController pushViewController:VC animated:NO];
            }
        }else
        {
            [self SetData];
            [TrainToast showWithText:responseObj[@"message"] duration:2.0];
        }
    } faildBlock:^(NSError *error) {

    }];
    YLog(@"查看物流");
}
//查看店铺详情
-(void)checkStoreDetailWithModel:(PersonalShoppingDanDetailModel *)model
{
    YLog(@"店铺详情");
    MerchantDetailViewController *vc=[[MerchantDetailViewController alloc] init];
    vc.mid=model.mid;
    vc.BackString = @"333";
    [self.navigationController pushViewController:vc animated:NO];
    self.navigationController.navigationBar.hidden=YES;
}

-(void)PayCallBack:(NSNotification *)text
{
    if ([text.userInfo[@"resultStatus"] isEqualToString:@"9000"]) {
        [self SetData];
        if (_delegate&&[_delegate respondsToSelector:@selector(SelectIndexType:)]) {
            [_delegate SelectIndexType:2];
        }
    }else if ([text.userInfo[@"resultStatus"] isEqualToString:@"8000"]){

        [TrainToast showWithText:@"正在处理中" duration:2.0f];


    }else if ([text.userInfo[@"resultStatus"] isEqualToString:@"4000"]){


        [TrainToast showWithText:@"订单支付失败" duration:2.0f];

    }else if ([text.userInfo[@"resultStatus"] isEqualToString:@"6001"]){


    }else if ([text.userInfo[@"resultStatus"] isEqualToString:@"6002"]){

        [TrainToast showWithText:@"网络连接出错" duration:2.0f];
    }

}
#pragma mark-脚视图协议
//退款退货
-(void)refundMoneyWithModel:(PersonalShoppingDanDetailModel *)model
{
    PersonalSingleShoppingDetailModel *detailModel=_DataModel.order_list.firstObject;
    XLShoppingModel *shopModel=[XLShoppingModel new];
    shopModel.scopeimg=detailModel.scopeimg;
    shopModel.attribute_str=detailModel.attribute_str;
    shopModel.name=detailModel.name;
    shopModel.number=detailModel.number;
    shopModel.pay_money=detailModel.pay_money;
    shopModel.pay_integer=detailModel.pay_integer;
    shopModel.status=detailModel.status;
    shopModel.isSingle=_DataModel.order_list.count>1?NO:YES;
    shopModel.order_batchid=detailModel.order_batchid;
    shopModel.order_no=detailModel.orderno;
    shopModel.ID=detailModel.ID;
    shopModel.paymoney=detailModel.paymoney;
    shopModel.payinteger=detailModel.payintegral;
    shopModel.totalfreight=detailModel.totalfreight;
    [self refundSingleShoppingWithModel:shopModel Cell:nil];
    YLog(@"退款退货");
}
//继续付款
-(void)continuePayWithModel:(PersonalShoppingDanDetailModel *)model
{
    [[AliPayRequestTools shareAlipayTool] ContinuePayWithOrderNum:_DataModel.order_batchid OnViewController:self AndResponseSuccess:^(NSDictionary *responseObj) {
[self SetData];
    } failed:^(NSError *error) {
[self SetData];
    }];
    YLog(@"继续付款");
}
//查看物流
-(void)checkLogisticInfoWithModel:(PersonalShoppingDanDetailModel *)mdoel
{
    [self checkLogisticsInfoWithModel:nil];
    YLog(@"查看物流");
}
//确认收货
-(void)sureReceiveWithModel:(PersonalShoppingDanDetailModel *)model
{
    NSDictionary *params=@{@"sigen":[kUserDefaults objectForKey:@"sigen"],@"order_batchid":_DataModel.order_batchid};
    //调查询接口是否可以确认收货
    [ATHRequestManager requestforCheckSureReceiveGoodsWithParams:params successBlock:^(NSDictionary *responseObj) {
        //10000为可以确认收货、有确定按钮
        if ([responseObj[@"status"] isEqualToString:@"10000"]) {
            [UIAlertTools showAlertWithTitle:@"" message:responseObj[@"message"]
                                 cancelTitle:@"取消" titleArray:@[] viewController:self confirm:^(NSInteger buttonTag) {
                                     //点击了确认收货调确认收货接口
                                     if (buttonTag==0) {

                                         [ATHRequestManager requestforSureReceiveGoodsWithParams:params successBlock:^(NSDictionary *responseObj) {
                                             if ([responseObj[@"status"] isEqualToString:@"10000"]) {
                                                 [self SetData];
                                                 if (_delegate&&[_delegate respondsToSelector:@selector(SelectIndexType:)]) {
                                                     [_delegate SelectIndexType:4];
                                                 }
                                             }
                                             else
                                             {
                                                 [UIAlertTools showAlertWithTitle:@"" message:responseObj[@"message"]
                                                                      cancelTitle:@"关闭" titleArray:nil viewController:self confirm:^(NSInteger buttonTag) {
                                                                          [self SetData];
                                                                      }];
                                             }
                                         } faildBlock:^(NSError *error) {

                                         }];
                                     }
                                 }];
        }else
        {
            [UIAlertTools showAlertWithTitle:@"" message:responseObj[@"message"]
                                 cancelTitle:@"关闭" titleArray:nil viewController:self confirm:^(NSInteger buttonTag) {
                                     [self SetData];
                                 }];
        }

    } faildBlock:^(NSError *error) {
        [TrainToast showWithText:error.localizedDescription duration:2.0];

    }];
    YLog(@"确认收货");
}
/*******************************************************      代码提取(多是复用代码)       ******************************************************/

-(UIImage *)BackImage
{
    if (!_BackImage) {
        _BackImage=[UIImage imageWithImageView:CGRectMake(0, 0, kScreen_Width, KSafeAreaTopNaviHeight+Height(92)) StartColor:RGB(255, 52, 90) EndColor:RGB(255, 93, 94) startPoint:CGPointMake(0, 0) endPoint:CGPointMake(0, KSafeAreaTopNaviHeight+Height(92))];
    }
    return _BackImage;
}

-(PersonalShoppingDanDetailModel *)DataModel
{
    if (!_DataModel) {
        _DataModel=[[PersonalShoppingDanDetailModel alloc] init];
    }
    return _DataModel;
}

@end
