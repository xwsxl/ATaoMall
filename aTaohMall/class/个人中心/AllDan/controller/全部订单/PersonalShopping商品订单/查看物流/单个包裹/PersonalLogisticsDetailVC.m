//
//  LookLogisticsViewController.m
//  aTaohMall
//
//  Created by JMSHT on 2017/4/14.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "PersonalLogisticsDetailVC.h"

#import "WuLiuCell.h"
#import "QianShouCell.h"
#import "PaiSongCell.h"
#import "ShouJianCell.h"
#import "XLRedNaviView.h"

#import "PersonalLogisticsDetailModel.h"

#import "PersonalLogisticModel.h"

@interface PersonalLogisticsDetailVC ()<UITableViewDelegate,UITableViewDataSource,XLRedNaviViewDelegate>
{

    UITableView *_tableView;

    UIView *noView;
    UIView *tab;
    UILabel *GoodsName;
    UILabel *GoodsAttribute;
    UILabel *GoodsAmount;
    NSMutableArray *_datas;
    UIView *NoData;
    UIImageView *logo1;
    UILabel *goodsNumeLab;
}
@property (nonatomic,strong)PersonalLogisticModel *DataModel;

@end

@implementation PersonalLogisticsDetailVC


/*******************************************************      控制器生命周期       ******************************************************/

- (void)viewDidLoad {

    [super viewDidLoad];

    _datas = [NSMutableArray new];

    self.view.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];

    [self initNav];

    [self initWuLiuStatus];

    [self initTableView];

    if ([_model.dingDanType isEqualToString:@"refundType"]) {
        [self getRefundData];
    }else
    {
        [self getDatas];
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden=YES;
}
/*******************************************************      数据请求       ******************************************************/

-(void)getRefundData
{
    /*
     String order_batchid = request.getParameter("order_batchid");        //批次号
     String batchid = request.getParameter("batchid");                    //退款批次号
     String orderno = request.getParameter("orderno");                    //订单号
     String company = request.getParameter("company");                    //物流公司
     String logisticnumber = request.getParameter("logisticnumber");        //运单号
     */

    NSDictionary *params=@{@"order_batchid":self.model.order_batchid,@"batchid":self.model.batchid,@"orderno":self.model.orderno,@"company":self.model.company,@"logisticnumber":self.model.logisticnumber};
    WKProgressHUD *hud=[WKProgressHUD showInView:self.view withText:nil animated:YES];

    [ATHRequestManager requestforqueryUserLogisticsWithParams:params successBlock:^(NSDictionary *responseObj) {
        //10000 : 获取成功
        if ([responseObj[@"status"] isEqualToString:@"10000"]) {
            _DataModel.scopeimg=[NSString stringWithFormat:@"%@",responseObj[@"scopeimg"]];
            _DataModel.logistics_number=[NSString stringWithFormat:@"%@",responseObj[@"logisticnumber"]];
            _DataModel.order_batchid=[NSString stringWithFormat:@"%@",responseObj[@"order_batchid"]];
            _DataModel.name=[NSString stringWithFormat:@"%@",responseObj[@"name"]];
            _DataModel.company=[NSString stringWithFormat:@"%@",responseObj[@"company"]];
            _DataModel.waybillnumber=[NSString stringWithFormat:@"%@",responseObj[@"logisticnumber"]];
            _DataModel.logistics_type=[NSString stringWithFormat:@"%@",responseObj[@"logistics_type"]];
            _DataModel.goods_number=[NSString stringWithFormat:@"%@",responseObj[@"goods_number"]];
            [_DataModel remarkListForArray:responseObj[@"remark_list"]];

        }else
        {

            [TrainToast showWithText:responseObj[@"status"] duration:2.0];

        }
        [self UILoadData];
        [hud dismiss:YES];
    } faildBlock:^(NSError *error) {
        [hud dismiss:YES];
    }];

}

-(void)getDatas
{


    NSDictionary *params=@{@"order_batchid":self.model.order_batchid,@"waybillnumber":self.model.waybillnumber?self.model.waybillnumber:@""};
    //获取物流信息
    WKProgressHUD *hud=[WKProgressHUD showInView:self.view withText:nil animated:YES];
    [ATHRequestManager requestforqueryLogisticsWithParams:params successBlock:^(NSDictionary *responseObj) {
        //10000 : 获取成功
        if ([responseObj[@"status"] isEqualToString:@"10000"]) {
            _DataModel.scopeimg=[NSString stringWithFormat:@"%@",responseObj[@"scopeimg"]];
            _DataModel.logistics_number=[NSString stringWithFormat:@"%@",responseObj[@"logistics_number"]];
            _DataModel.order_batchid=[NSString stringWithFormat:@"%@",responseObj[@"order_batchid"]];
            _DataModel.name=[NSString stringWithFormat:@"%@",responseObj[@"name"]];
            _DataModel.company=[NSString stringWithFormat:@"%@",responseObj[@"company"]];
            _DataModel.waybillnumber=[NSString stringWithFormat:@"%@",responseObj[@"waybillnumber"]];
            _DataModel.logistics_type=[NSString stringWithFormat:@"%@",responseObj[@"logistics_type"]];
            _DataModel.goods_number=[NSString stringWithFormat:@"%@",responseObj[@"goods_number"]];
            [_DataModel remarkListForArray:responseObj[@"remark_list"]];

        }else
        {

            [TrainToast showWithText:responseObj[@"status"] duration:2.0];

        }
        [self UILoadData];
        [hud dismiss:YES];
    } faildBlock:^(NSError *error) {

        [hud dismiss:YES];

    }];


}


/*******************************************************      初始化视图       ******************************************************/
//
-(void)UILoadData
{


    GoodsName.text =[NSString stringWithFormat:@"物流状态：%@",_DataModel.logistics_type];
    GoodsAttribute.text =[NSString stringWithFormat:@"承运来源：%@",_DataModel.company];
    GoodsAmount.text =[NSString stringWithFormat:@"运单编号：%@",_DataModel.waybillnumber];
    [logo1 sd_setImageWithURL:[NSURL URLWithString:_DataModel.scopeimg] placeholderImage:[UIImage imageNamed:@"default_image"] options:SDWebImageProgressiveDownload];

    if ([_DataModel.goods_number floatValue]>1) {
        goodsNumeLab.hidden=NO;
        goodsNumeLab.backgroundColor=RGBA(0, 0, 0, 0.4);
        goodsNumeLab.text=[NSString stringWithFormat:@"%@种商品",_DataModel.goods_number];
    }else
    {
        goodsNumeLab.hidden=YES;
    }


    NSString *stringForColor = [NSString stringWithFormat:@"%@",_DataModel.logistics_type];
    // 创建对象.
    NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:GoodsName.text];
    //
    NSRange range = [GoodsName.text rangeOfString:stringForColor];

    [mAttStri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255/255.0 green:52/255.0 blue:90/255.0 alpha:1.0] range:range];

    GoodsName.attributedText=mAttStri;
    if (_DataModel.remark_list.count == 0 ) {
        [self initNoDataView];
        NoData.hidden = NO;
    }else{
        [_tableView reloadData];
        NoData.hidden = YES;
    }

}
//
-(void)initNav
{

    if ([_model.dingDanType isEqualToString:@"refundType"]) {
        XLRedNaviView *navi=[[XLRedNaviView alloc]initWithMessage:@"退款物流" ImageName:@""];
        navi.delegate=self;
        [self.view addSubview:navi];
    }else
    {
        XLRedNaviView *navi=[[XLRedNaviView alloc]initWithMessage:@"查看物流" ImageName:@""];
        navi.delegate=self;
        [self.view addSubview:navi];
    }


}
-(void)QurtBtnClick
{

    [self.navigationController popViewControllerAnimated:NO];

}
//
-(void)initTableView
{
    _tableView =[[UITableView alloc] initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight+90+5, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-KSafeAreaTopNaviHeight-90-5) style:UITableViewStylePlain];
    _tableView.backgroundColor=[UIColor whiteColor];

    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate=self;
    _tableView.dataSource=self;

    [self.view addSubview:_tableView];

    [_tableView registerClass:[WuLiuCell class] forCellReuseIdentifier:@"cell"];

    [_tableView registerClass:[QianShouCell class] forCellReuseIdentifier:@"cell1"];

    [_tableView registerClass:[PaiSongCell class] forCellReuseIdentifier:@"cell2"];

    [_tableView registerClass:[ShouJianCell class] forCellReuseIdentifier:@"cell3"];


}
//
-(void)initWuLiuStatus
{

    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight, [UIScreen mainScreen].bounds.size.width, 90)];
    view.backgroundColor  =[UIColor whiteColor];
    [self.view addSubview:view];

    UIImageView *fenge1 = [[UIImageView alloc] initWithFrame:CGRectMake(14, 9, 72, 1)];
    fenge1.image = [UIImage imageNamed:@"分割线-拷贝"];
    [view addSubview:fenge1];

    UIImageView *fenge2 = [[UIImageView alloc] initWithFrame:CGRectMake(14, 9, 1, 72)];
    fenge2.image = [UIImage imageNamed:@"分割线YT"];
    [view addSubview:fenge2];

    UIImageView *fenge3 = [[UIImageView alloc] initWithFrame:CGRectMake(14, 80, 72, 1)];
    fenge3.image = [UIImage imageNamed:@"分割线-拷贝"];
    [view addSubview:fenge3];

    UIImageView *fenge4 = [[UIImageView alloc] initWithFrame:CGRectMake(85, 9, 1, 72)];
    fenge4.image = [UIImage imageNamed:@"分割线YT"];
    [view addSubview:fenge4];


    logo1 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 70, 70)];

    logo1.image = [UIImage imageNamed:@""];

    //    logo.layer.cornerRadius = 4;
    logo1.layer.borderColor = [UIColor whiteColor].CGColor;
    logo1.layer.borderWidth = 5;
    [logo1.layer setMasksToBounds:YES];


    [view addSubview:logo1];


    goodsNumeLab= [[UILabel alloc] initWithFrame:CGRectMake(15, 10+70-20, 70, 20)];
    goodsNumeLab.text = @"";
    goodsNumeLab.textColor = [UIColor whiteColor];
    goodsNumeLab.textAlignment = NSTextAlignmentCenter;
    goodsNumeLab.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:11];
    [view addSubview:goodsNumeLab];

    GoodsName = [[UILabel alloc] initWithFrame:CGRectMake(95, 10, [UIScreen mainScreen].bounds.size.width-120, 20)];
    GoodsName.text = @"";
    GoodsName.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    GoodsName.textAlignment = NSTextAlignmentLeft;
    GoodsName.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:13];

    [view addSubview:GoodsName];

    GoodsAttribute = [[UILabel alloc] initWithFrame:CGRectMake(95, 35, [UIScreen mainScreen].bounds.size.width-120, 20)];
    GoodsAttribute.text = @"";
    GoodsAttribute.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    GoodsAttribute.textAlignment = NSTextAlignmentLeft;
    GoodsAttribute.numberOfLines=2;
    GoodsAttribute.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:13];
    [view addSubview:GoodsAttribute];

    GoodsAmount = [[UILabel alloc] initWithFrame:CGRectMake(95, 60, [UIScreen mainScreen].bounds.size.width-120, 20)];
    GoodsAmount.text = @"";
    GoodsAmount.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    GoodsAmount.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:13];
    [view addSubview:GoodsAmount];

    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 89, [UIScreen mainScreen].bounds.size.width, 1)];

    line.image = [UIImage imageNamed:@"分割线-拷贝"];

    [view addSubview:line];



}
//
-(void)initNoDataView
{

    NoData = [[UIView alloc] initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight+90+5, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-KSafeAreaTopNaviHeight-90-5-50)];
    NoData.backgroundColor = [UIColor whiteColor];


    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-129/2)/2, ([UIScreen mainScreen].bounds.size.height-65-90-5-50-121/2)/2, 129/2, 121/2)];
    imgView.image = [UIImage imageNamed:@"无数据"];
    [NoData addSubview:imgView];

    UILabel *NoLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, ([UIScreen mainScreen].bounds.size.height-65-90-5-50-121/2)/2+129/2+10, [UIScreen mainScreen].bounds.size.width-60, 20)];
    NoLabel.text  =@"暂无相关数据";
    NoLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:13];
    NoLabel.textColor =[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    NoLabel.textAlignment  =NSTextAlignmentCenter;
    [NoData addSubview:NoLabel];

    [self.view addSubview:NoData];

}

//
-(void)NoWebSeveice
{

    noView=[[UIView alloc] initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];

    noView.backgroundColor=[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];

    [self.view addSubview:noView];


    UIImageView *image=[[UIImageView alloc] initWithFrame:CGRectMake((noView.frame.size.width-82)/2, 100, 82, 68)];

    image.image=[UIImage imageNamed:@"网络连接失败"];

    [noView addSubview:image];


    UILabel *label1=[[UILabel alloc] initWithFrame:CGRectMake(100, 180, noView.frame.size.width-200, 20)];

    label1.text=@"网络连接失败";

    label1.textAlignment=NSTextAlignmentCenter;

    label1.font=[UIFont fontWithName:@"PingFangSC-Medium" size:15];

    label1.textColor=[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];

    [noView addSubview:label1];


    UILabel *label2=[[UILabel alloc] initWithFrame:CGRectMake(100, 210, noView.frame.size.width-200, 20)];

    label2.text=@"请检查你的网络";

    label2.textAlignment=NSTextAlignmentCenter;

    label2.font=[UIFont fontWithName:@"PingFangSC-Medium" size:12];

    label2.textColor=[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];

    [noView addSubview:label2];


    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];

    button.frame=CGRectMake(100, 250, noView.frame.size.width-200, 50);

    [button setTitle:@"重新加载" forState:0];
    button.titleLabel.font=[UIFont fontWithName:@"PingFangSC-Medium" size:12];
    [button setTitleColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0] forState:0];

    [noView addSubview:button];

    [button addTarget:self action:@selector(loadData) forControlEvents:UIControlEventTouchUpInside];

}
//
-(void)loadData{


    noView.hidden=YES;


    //   [self getDatas];

}

/*******************************************************      各种button执行方法、页面间的跳转       ******************************************************/

/*******************************************************      协议方法       ******************************************************/

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return self.DataModel.remark_list.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {

        return 80;

    }else if(indexPath.row==1){

        return 80;
    }else{

        return 70;
    }

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PersonalLogisticsDetailModel *model = _DataModel.remark_list[indexPath.row];
    YLog(@"status=%@\ntime=%@",model.status,model.time);
    if (indexPath.row==0) {

        QianShouCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];

        cell.selectionStyle = UITableViewCellSelectionStyleNone;


        cell.Name.text = model.status;
        cell.Time.text = model.time;
        cell.NameString = model.status;

        return cell;

    }else if(indexPath.row==1) {
        PaiSongCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2"];

        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        cell.Name.text = model.status;
        cell.Time.text = model.time;
        cell.NameString = model.status;

        return cell;
    }else{

        if (indexPath.row==self.DataModel.remark_list.count-1) {
            ShouJianCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell3"];

            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.Name.text = model.status;
            cell.Time.text = model.time;
            cell.NameString = model.status;

            return cell;

        }else{

            WuLiuCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];

            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.Name.text = model.status;
            cell.Time.text = model.time;
            cell.NameString = model.status;

            return cell;

        }
    }

}


/*******************************************************      代码提取(多是复用代码)       ******************************************************/


-(PersonalLogisticModel *)DataModel
{
    if (!_DataModel) {
        _DataModel=[PersonalLogisticModel new];
    }
    return _DataModel;
}

@end

