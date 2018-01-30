//
//  PersonalShoppingRefundDanDetailVC.m
//  aTaohMall
//
//  Created by Hawky on 2017/11/23.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "PersonalShoppingRefundDanDetailVC.h"
//物流
#import "PersonalTwoOrMoreLogisticsDetailVC.h"
//退货物流
#import "FilloutRefundLogisticVC.h"
//协商记录
#import "ConsultNounVC.h"

#import "PersonalShoppingRefundView.h"

#import "XLShoppingModel.h"

#import "XLShoppingRefundModel.h"

@interface PersonalShoppingRefundDanDetailVC ()<XLRedNaviViewDelegate>
{
    CGFloat height;
    NSMutableArray *_dataArr;
    UIView *backView;
}
@property (nonatomic,strong)UIScrollView *scoll;

@property (nonatomic,strong)XLShoppingRefundModel *RefundDataModel;

@end

@implementation PersonalShoppingRefundDanDetailVC

/*******************************************************      控制器生命周期       ******************************************************/

//
- (void)viewDidLoad {
    [super viewDidLoad];

    if (_kefuJieru) {
        [self getKefuData];
        [KNotificationCenter addObserver:self selector:@selector(getKefuData) name:@"wuliutianxie" object:nil];
    }else
    {
    [self getDatas];
        [KNotificationCenter addObserver:self selector:@selector(getDatas) name:@"wuliutianxie" object:nil];
    }
}


/*******************************************************      数据请求       ******************************************************/
-(void)getDatas
{
    /*sigen            // 用户信息
    order_batchid        // 订单批次号
    refund_batchid        // 退款批次号
    orderno            // 订单号*/
    NSDictionary *params=@{@"sigen":[kUserDefaults objectForKey:@"sigen"],@"order_batchid":_dataModel.order_batchid,@"refund_batchid":_dataModel.refund_batchid?_dataModel.refund_batchid:@"",@"orderno":_dataModel.order_no};

//    "add_name" = 555555;
//    "add_phone" = 18664593812;
//    address = "\U6e56\U5357\U7701\U5cb3\U9633\U5e02\U6c68\U7f57\U53f3\U624b\U98df\U6307\U6307\U7eb9\U51b3\U5b9a\U7684\U65f6\U5019";
//    batchid = 6533346201711241631239154;
//    checkdate = "<null>";
//    company = "";
//    "goods_list" =     (
//                        {
//                            "attribute_str" = "<null>";
//                            name = "\U6b63\U5e38\U5546\U54c1\U65e0\U5c5e\U60271";
//                            scopeimg = "<null>";
//                        }
//                        );
//    logisticnumber = "";
//    "logistics_message" = "";
//    message = "\U83b7\U53d6\U6210\U529f\Uff01";
//    reason = "\U5f53\U65f6\U7684";
//    status = 10000;
//    sysdate = "2017-11-24 16:31:26";
//    "total_integral" = "22.00";
//    "total_money" = "0.00";
//    "total_status" = 6;
//}
    WKProgressHUD *hud=[WKProgressHUD showInView:[UIApplication sharedApplication].keyWindow withText:@"" animated:YES];
    [ATHRequestManager requestforgetRefundOrderDetailsByGoodsWithParams:params successBlock:^(NSDictionary *responseObj) {
        if ([responseObj[@"status"] isEqualToString:@"10000"]) {
            _dataArr =[NSMutableArray new];
            [_dataArr removeAllObjects];
           // [NSObject printPropertyWithDict:responseObj];
            for (NSDictionary *dic in responseObj[@"goods_list"]) {
                 XLShoppingModel *model=[XLShoppingModel new];
                model.scopeimg=[NSString stringWithFormat:@"%@",dic[@"scopeimg"]];
                model.name=[NSString stringWithFormat:@"%@",dic[@"name"]];
                model.attribute_str=[NSString stringWithFormat:@"%@",dic[@"attribute_str"]];
                model.order_no=[NSString stringWithFormat:@"%@",dic[@"orderno"]];
                [_dataArr addObject:model];
            }
              self.RefundDataModel.order_batchid=[NSString stringWithFormat:@"%@",responseObj[@"order_batchid"]];
            self.RefundDataModel.total_status=[NSString stringWithFormat:@"%@",responseObj[@"total_status"]];
            self.RefundDataModel.add_name=[NSString stringWithFormat:@"%@",responseObj[@"add_name"]];
            self.RefundDataModel.add_phone=[NSString stringWithFormat:@"%@",responseObj[@"add_phone"]];
            self.RefundDataModel.address=[NSString stringWithFormat:@"%@",responseObj[@"address"]];
            self.RefundDataModel.batchid=[NSString stringWithFormat:@"%@",responseObj[@"batchid"]];
            self.RefundDataModel.checkdate=[NSString stringWithFormat:@"%@",responseObj[@"checkdate"]];
            self.RefundDataModel.company=[NSString stringWithFormat:@"%@",responseObj[@"company"]];
            self.RefundDataModel.logisticnumber=[NSString stringWithFormat:@"%@",responseObj[@"logisticnumber"]];
            self.RefundDataModel.logistics_message=[NSString stringWithFormat:@"%@",responseObj[@"logistics_message"]];
            self.RefundDataModel.reason=[NSString stringWithFormat:@"%@",responseObj[@"reason"]];
            self.RefundDataModel.sysdate=[NSString stringWithFormat:@"%@",responseObj[@"sysdate"]];
            self.RefundDataModel.total_money=[NSString stringWithFormat:@"%@",responseObj[@"total_money"]];
            self.RefundDataModel.total_integral=[NSString stringWithFormat:@"%@",responseObj[@"total_integral"]];
            self.RefundDataModel.refun_record_number=[NSString stringWithFormat:@"%@",responseObj[@"refun_record_number"]];

        }else
        {
            [TrainToast showWithText:responseObj[@"message"] duration:2.0];
        }
        [self setUI];
        [hud dismiss:YES];

    } faildBlock:^(NSError *error) {
        [hud dismiss:YES];

    }];



}

-(void)getKefuData
{
    /*
    order_batchid  // 订单批次号
    refund_status            // 0:退款    1:退货退款
    ordernos*/
  WKProgressHUD *hud=[WKProgressHUD showInView:[UIApplication sharedApplication].keyWindow withText:@"" animated:YES];
    NSDictionary *params=@{@"order_batchid":_dataModel.order_batchid,@"refund_status":_dataModel.status,@"ordernos":_dataModel.order_no};
    [ATHRequestManager requestforgetNoRefundWithParams:params successBlock:^(NSDictionary *responseObj) {
        if ([responseObj[@"status"] isEqualToString:@"10000"]) {
            _dataArr =[NSMutableArray new];
            [_dataArr removeAllObjects];
            // [NSObject printPropertyWithDict:responseObj];
            for (NSDictionary *dic in responseObj[@"goods_list"]) {
                XLShoppingModel *model=[XLShoppingModel new];
                model.scopeimg=[NSString stringWithFormat:@"%@",dic[@"scopeimg"]];
                model.name=[NSString stringWithFormat:@"%@",dic[@"name"]];
                model.attribute_str=[NSString stringWithFormat:@"%@",dic[@"attribute_str"]];
                model.order_no=[NSString stringWithFormat:@"%@",dic[@"orderno"]];
                [_dataArr addObject:model];
            }
            self.RefundDataModel.order_batchid=[NSString stringWithFormat:@"%@",responseObj[@"order_batchid"]];
            self.RefundDataModel.total_status=[NSString stringWithFormat:@"%@",responseObj[@"total_status"]];
            self.RefundDataModel.add_name=[NSString stringWithFormat:@"%@",responseObj[@"add_name"]];
            self.RefundDataModel.add_phone=[NSString stringWithFormat:@"%@",responseObj[@"add_phone"]];
            self.RefundDataModel.address=[NSString stringWithFormat:@"%@",responseObj[@"address"]];
            self.RefundDataModel.batchid=[NSString stringWithFormat:@"%@",responseObj[@"refund_batchid"]];
            self.RefundDataModel.checkdate=[NSString stringWithFormat:@"%@",responseObj[@"checkdate"]];
            self.RefundDataModel.company=[NSString stringWithFormat:@"%@",responseObj[@"company"]];
            self.RefundDataModel.logisticnumber=[NSString stringWithFormat:@"%@",responseObj[@"logisticnumber"]];
            self.RefundDataModel.logistics_message=[NSString stringWithFormat:@"%@",responseObj[@"logistics_message"]];
            self.RefundDataModel.reason=[NSString stringWithFormat:@"%@",responseObj[@"reason"]];
            self.RefundDataModel.sysdate=[NSString stringWithFormat:@"%@",responseObj[@"sysdate"]];
            self.RefundDataModel.total_money=[NSString stringWithFormat:@"%@",responseObj[@"total_money"]];
            self.RefundDataModel.total_integral=[NSString stringWithFormat:@"%@",responseObj[@"total_integral"]];
            self.RefundDataModel.refund_status=[NSString stringWithFormat:@"%@",responseObj[@"refund_status"]];
            YLog(@"%@",self.RefundDataModel.refun_record_number);;
        }else
        {
            [TrainToast showWithText:responseObj[@"message"] duration:2.0];
        }
        [self setUI];
        [hud dismiss:YES];

    } faildBlock:^(NSError *error) {
  [hud dismiss:YES];
    }];
}


-(void)setDataModel:(XLShoppingModel *)dataModel
{
    _dataModel=dataModel;

}

/*******************************************************      初始化视图       ******************************************************/
-(void)setUI
{
//导航栏

    NSString *title=@"退款退货详情";
    if ([self.RefundDataModel.total_status isEqualToString:@"10"]||[self.RefundDataModel.total_status isEqualToString:@"11"]) {
        title=@"仅退款详情";
    }else if ([self.RefundDataModel.total_status isEqualToString:@"6"]||[self.RefundDataModel.total_status isEqualToString:@"3"]||[self.RefundDataModel.refund_status isEqualToString:@"0"])
    {
        title=@"退款详情";
    }


    XLRedNaviView *navi=[[XLRedNaviView alloc] initWithMessage:title ImageName:@""];
    navi.delegate=self;
    [self.view addSubview:navi];
    height=0;
//顶部红色模块
    UIImage *img=[UIImage imageWithImageView:CGRectMake(0, 0, kScreen_Width, KSafeAreaTopNaviHeight+Height(92)) StartColor:RGB(255, 52, 90) EndColor:RGB(255, 93, 94) startPoint:CGPointMake(0, 0) endPoint:CGPointMake(0, KSafeAreaTopNaviHeight+Height(92))];

    UIImageView *topRedIV=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, Height(92))];
    [topRedIV setImage:[img getSubImage:CGRectMake(0, KSafeAreaTopNaviHeight, kScreenWidth, Height(92))]];
    [self.scoll addSubview:topRedIV];
    height+=topRedIV.frame.size.height;

    UIImageView *statusIV=[[UIImageView alloc] init];
    [statusIV setContentMode:UIViewContentModeScaleAspectFit];
    [topRedIV addSubview:statusIV];

    UILabel *topStatusLab=[[UILabel alloc]init];
    [topStatusLab setFont:KNSFONTM(17)];
    [topStatusLab setTextColor:RGB(255, 161, 92)];

    NSString *statusStr=@"";
    NSString     *IVStr=@"";
    if (_kefuJieru) {
        statusStr=@"您已无法再进行申请退款退货";
        IVStr=@"icon_Refundandreturn";
        if ([self.RefundDataModel.refund_status isEqualToString:@"0"]) {
            statusStr=@"您已无法再进行申请退款";
            IVStr=@"icon_refound";
        }

    }
    if ([self.RefundDataModel.total_status isEqualToString:@"6"]) {
         statusStr=@"退款中";
        if (_kefuJieru) {
            statusStr=@"您已无法再进行申请退款";
        }
        IVStr=@"icon_refound";
    }else if ([self.RefundDataModel.total_status isEqualToString:@"3"])
    {
        statusStr=@"退款成功";
        IVStr=@"icon_ok_refund";
    }
    else if ([self.RefundDataModel.total_status isEqualToString:@"4"])
    {
        statusStr=@"退款退货中";
        IVStr=@"icon_Refundandreturn";
    }
    else if ([self.RefundDataModel.total_status isEqualToString:@"10"])
    {
        statusStr=@"仅退款成功";
        IVStr=@"icon_ok_refund";
    }else if ([self.RefundDataModel.total_status isEqualToString:@"5"])
    {
        statusStr=@"退款退货成功";
        IVStr=@"icon_ok_refund";
    }
    else if ([self.RefundDataModel.total_status isEqualToString:@"11"])
    {
        statusStr=@"仅退款中";
        if (_kefuJieru) {
            statusStr=@"您已无法再进行申请仅退款";
        }
        IVStr=@"icon_refound";
    }

   
    [statusIV setImage:KImage(IVStr)];
    [topStatusLab setText:statusStr];
    [topRedIV addSubview:topStatusLab];

    CGSize statusSize=[statusStr sizeWithFont:KNSFONTM(17) maxSize:CGSizeMake(kScreen_Width, 17)];
    [statusIV setFrame:CGRectMake((kScreen_Width-30-statusSize.width-Width(10))/2.0, (Height(92)-30)/2.0, 30, 30)];

    [topStatusLab setFrame:CGRectMake((kScreen_Width-30-statusSize.width-Width(10))/2.0+30+Width(10), (Height(92)-15)/2.0-4, statusSize.width, statusSize.height)];
    if (_kefuJieru) {

    }else
    {
     if ([self.RefundDataModel.total_status isEqualToString:@"A"])
    {
        statusStr=@"退款退货中";
        [statusIV setFrame:CGRectZero];
        [topStatusLab setFrame:CGRectMake(0, Height(20), kScreenWidth, 50)];
        [topStatusLab setNumberOfLines:0];
        [topStatusLab setTextAlignment:NSTextAlignmentCenter];
        [topStatusLab setText:@"退款退货中\n请退货并填写物流信息"];
    }else if ([self.RefundDataModel.total_status isEqualToString:@"B"])
    {
        statusStr=@"退款退货中";
        [statusIV setFrame:CGRectZero];
        [topStatusLab setFrame:CGRectMake(0, Height(20), kScreenWidth, 50)];
        [topStatusLab setTextAlignment:NSTextAlignmentCenter];
         [topStatusLab setNumberOfLines:0];
        [topStatusLab setText:@"退款退货中\n等待卖家收货并退款"];

    }
    }
    //区分创建状态不同差别的视图
    [self setCenterView];

    height +=Height(10);
//协商记录
    YLog(@"%@",self.RefundDataModel.refun_record_number);
    if (self.RefundDataModel.refun_record_number&&[self.RefundDataModel.refun_record_number isEqualToString:@"0"])
    {

    }else
    {

    UIButton *consultBut=[UIButton buttonWithType:UIButtonTypeCustom];
    consultBut.frame=CGRectMake(0, height, kScreenWidth, Height(40)+13);
    [consultBut setBackgroundColor:[UIColor whiteColor]];
    [consultBut addTarget:self action:@selector(consultButClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.scoll addSubview:consultBut];
    height+=consultBut.frame.size.height;

    UILabel * consultLab = [[UILabel alloc]initWithFrame:CGRectMake(Width(15), Height(20), 120, 13)];
    consultLab.font=KNSFONT(13);
    consultLab.textColor=RGB(51, 51, 51);
    consultLab.text=@"协商记录";
    [consultBut addSubview:consultLab];

    UIImageView *consultIV=[[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth-Width(15)-14, Height(20), 8, 14)];
    [consultIV setImage:KImage(@"icon_more")];
    [consultBut addSubview:consultIV];

    height+=Height(10);
    }
//退款信息
    UIView *refundInfoView=[[UIView alloc] init];
    [refundInfoView setBackgroundColor:[UIColor whiteColor]];
    [self.scoll addSubview:refundInfoView];

    UILabel * refundInfoLab = [[UILabel alloc]initWithFrame:CGRectMake(Width(15), Height(15), 120, 14)];
    refundInfoLab.font=KNSFONT(14);
    refundInfoLab.textColor=RGB(51, 51, 51);
    refundInfoLab.text=@"退款信息";
    [refundInfoView addSubview:refundInfoLab];

    UIView *shoppingView=[[UIView alloc] initWithFrame:CGRectMake(0, Height(30)+14, kScreenWidth, Height(30)+70)];
    [shoppingView setBackgroundColor:RGB(244, 244, 244)];
    [refundInfoView addSubview:shoppingView];
    if (_dataArr.count==1) {
        XLShoppingModel *model=_dataArr[0];
        PersonalShoppingRefundView *refundDetailView=[[PersonalShoppingRefundView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, Height(30)+70) AndShoppingName:model.name scopimgName:model.scopeimg attributeStr:model.attribute_str];
        [refundDetailView setBackgroundColor:RGB(244, 244, 244)];
        [shoppingView addSubview:refundDetailView];
    }
    else
    {
        UIScrollView *scroll=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, shoppingView.frame.size.width, shoppingView.frame.size.height)];
        [shoppingView addSubview:scroll];
        for (int i=0; i<_dataArr.count; i++) {
            XLShoppingModel *model=_dataArr[i];

            UIImageView *IV=[[UIImageView alloc] initWithFrame:CGRectMake(Width(15)+90*i, Height(15), 70, 70)];
            [IV sd_setImageWithURL:KNSURL(model.scopeimg)];
            [scroll addSubview:IV];
        }
        scroll.showsVerticalScrollIndicator=NO;
        scroll.showsHorizontalScrollIndicator=NO;
        scroll.contentSize=CGSizeMake(Width(30)+90*_dataArr.count-20, Height(30)+30);
    }

    NSString *str=@"";
    NSString *str1=@"";
    NSString *str2=@"";
    if ([self.RefundDataModel.total_status isEqualToString:@"4"]||[self.RefundDataModel.total_status isEqualToString:@"5"]||[self.RefundDataModel.total_status isEqualToString:@"A"]||[self.RefundDataModel.total_status isEqualToString:@"B"]||[self.RefundDataModel.refund_status isEqualToString:@"1"]) {
        str=@"退货";
        str1=@"      ";
        str2=@"   ";
    }

    CGFloat labHeight=Height(30)+14+Height(30)+70+Height(20);

    UILabel *orderNumberLab=[[UILabel alloc] initWithFrame:CGRectMake(Width(15), labHeight, kScreenWidth-Width(30), 12)];
    [orderNumberLab setFont:KNSFONT(12)];
    [orderNumberLab setTextColor:RGB(102, 102, 102)];
    [orderNumberLab setText:[NSString stringWithFormat:@"   %@订单号:  %@",str1,self.RefundDataModel.order_batchid]];
    [refundInfoView addSubview:orderNumberLab];
    labHeight +=Height(11)+12;

    UILabel *refundNoLab=[[UILabel alloc] initWithFrame:CGRectMake(Width(15), labHeight, kScreenWidth-Width(30), 12)];
    [refundNoLab setFont:KNSFONT(12)];
    [refundNoLab setTextColor:RGB(102, 102, 102)];
    [refundNoLab setText:[NSString stringWithFormat:@"退款%@编号:  %@",str,self.RefundDataModel.batchid]];
    [refundInfoView addSubview:refundNoLab];
    labHeight +=Height(11)+12;

    UILabel *refundMoneyLab=[[UILabel alloc] initWithFrame:CGRectMake(Width(15), labHeight, kScreenWidth-Width(30), 12)];
    [refundMoneyLab setFont:KNSFONT(12)];
    [refundMoneyLab setTextColor:RGB(102, 102, 102)];
    [refundMoneyLab setText: [NSString stringWithFormat:@"%@退款金额:  ￥%@+%@积分",str1,self.RefundDataModel.total_money,self.RefundDataModel.total_integral]];
    [refundInfoView addSubview:refundMoneyLab];

    NSString *colorStr=[NSString stringWithFormat:@"￥%@+%@积分",self.RefundDataModel.total_money,self.RefundDataModel.total_integral];
    NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:refundMoneyLab.text];
    //
    NSRange range = [refundMoneyLab.text rangeOfString:colorStr];

    [mAttStri addAttribute:NSFontAttributeName value:KNSFONTM(12) range:range];
    [mAttStri addAttribute:NSForegroundColorAttributeName value:RGB(255, 93, 94) range:range];

    refundMoneyLab.attributedText=mAttStri;
    labHeight +=Height(11)+12;




    UILabel *refundReasonLab=[[UILabel alloc] initWithFrame:CGRectMake(Width(15), labHeight, kScreenWidth-Width(30), 12)];
    [refundReasonLab setFont:KNSFONT(12)];
    [refundReasonLab setTextColor:RGB(102, 102, 102)];
    [refundReasonLab setText:[NSString stringWithFormat:@"退款%@原因:  %@",str,self.RefundDataModel.reason]];
    [refundInfoView addSubview:refundReasonLab];
    labHeight +=Height(11)+12;

    UILabel *refundReplyTimeLab=[[UILabel alloc] initWithFrame:CGRectMake(Width(15), labHeight, kScreenWidth-Width(30), 12)];
    [refundReplyTimeLab setFont:KNSFONT(12)];
    [refundReplyTimeLab setTextColor:RGB(102, 102, 102)];
    [refundReplyTimeLab setText: [NSString stringWithFormat:@"%@申请时间:  %@",str1,self.RefundDataModel.sysdate]];
    [refundInfoView addSubview:refundReplyTimeLab];
    labHeight +=Height(11)+12;


    if ([self.RefundDataModel.total_status isEqualToString:@"3"]||[self.RefundDataModel.total_status isEqualToString:@"5"]||[self.RefundDataModel.total_status isEqualToString:@"10"])
    {

    UILabel *refundTimeLab=[[UILabel alloc] initWithFrame:CGRectMake(Width(15), labHeight, kScreenWidth-Width(30), 12)];
    [refundTimeLab setFont:KNSFONT(12)];
    [refundTimeLab setTextColor:RGB(102, 102, 102)];
    [refundTimeLab setText:[NSString stringWithFormat:@"%@退款时间:  %@",str1,self.RefundDataModel.checkdate]];
    [refundInfoView addSubview:refundTimeLab];
    labHeight +=Height(11)+12;
    }
    refundInfoView.frame=CGRectMake(0, height, kScreenWidth, labHeight+10);
    height+=refundInfoView.frame.size.height;



    if ([self.RefundDataModel.total_status isEqualToString:@"5"]) {

        UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight-KSafeAreaBottomHeight-Height(24)-27, kScreen_Width, Height(24)+27)];
        [view setBackgroundColor: [UIColor whiteColor]];
        [self.view addSubview:view];

        UIButton *checkLogisticsBut=[UIButton buttonWithType:UIButtonTypeCustom];
        [checkLogisticsBut setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
        checkLogisticsBut.titleLabel.font=KNSFONTM(14);
        [view addSubview:checkLogisticsBut];
        [checkLogisticsBut setTitle:@"查看退货物流" forState:UIControlStateNormal];
        [checkLogisticsBut setFrame:CGRectMake(kScreen_Width-Width(15)-120, +Height(12), 120, 27)];
        [checkLogisticsBut.layer setCornerRadius:13.5];
        [checkLogisticsBut.layer setBorderColor:RGB(51, 51, 51).CGColor];
        [checkLogisticsBut.layer setBorderWidth:1];
        [checkLogisticsBut addTarget:self action:@selector(checkLogisticsButClick:) forControlEvents:UIControlEventTouchUpInside];

        UIImageView *IV=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 1)];
        [IV setImage:KImage(@"分割线-拷贝")];
        [view addSubview:IV];
        height+=view.frame.size.height;
    }

    _scoll.contentSize=CGSizeMake(kScreenWidth, height);
    _scoll.bounces=NO;
}

-(void)setCenterView
{

    if (_kefuJieru) {
        UIView *BackView=[[UIView alloc] initWithFrame:CGRectMake(0, height, kScreenWidth, Height(120))];
        height+=BackView.frame.size.height;
        [BackView setBackgroundColor:[UIColor whiteColor]];
        [self.scoll addSubview:BackView];
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(Width(15), Height(20), kScreenWidth-Width(30),38)];
        lab.font=KNSFONT(13);
        lab.numberOfLines=0;
        lab.textColor=RGB(51, 51, 51);

        if ([self.RefundDataModel.total_status isEqualToString:@"4"]||[self.RefundDataModel.total_status isEqualToString:@"5"]||[self.RefundDataModel.total_status isEqualToString:@"A"]||[self.RefundDataModel.total_status isEqualToString:@"B"]||[self.RefundDataModel.refund_status isEqualToString:@"1"]) {
        lab.text=@"申请商品中包含超过3次被商家拒绝的商品，无法再申请退款退货，如需帮助请点击客服介入";
        }else
        {
        lab.text=@"申请商品中包含超过3次被商家拒绝的商品，无法再申请退款，如需帮助请点击客服介入";
        }

        lab.backgroundColor=[UIColor whiteColor];
        [BackView addSubview:lab];

        UIButton *kefujierubut=[UIButton buttonWithType:UIButtonTypeCustom];
        [kefujierubut setFrame:CGRectMake(Width(44), Height(68), kScreen_Width-Width(88), Height(35))];
        [kefujierubut.layer setCornerRadius:Height(17.5)];
        [kefujierubut.layer setBorderWidth:1];
        [kefujierubut.layer setBorderColor:RGB(226, 226, 226).CGColor];
        [kefujierubut setTitle:@"客服介入" forState:UIControlStateNormal];
        kefujierubut.titleLabel.font=KNSFONT(15);
        [kefujierubut setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
        [kefujierubut addTarget:self action:@selector(kefujierubut:) forControlEvents:UIControlEventTouchUpInside];

        [kefujierubut setBackgroundColor:[UIColor whiteColor]];

        [BackView addSubview:kefujierubut];

        UIImageView *lineView=[[UIImageView alloc] initWithFrame:CGRectMake(0, Height(120)-1, kScreenWidth, 1)];
        [lineView setImage:KImage(@"分割线-拷贝")];
        [BackView addSubview:lineView];

        return;
    }


    if ([self.RefundDataModel.total_status isEqualToString:@"6"]) {
     //   statusStr=@"退款中";
        UIView *BackView=[[UIView alloc] initWithFrame:CGRectMake(0, height, kScreenWidth, Height(20)+13+Height(20))];
        height+=BackView.frame.size.height;
        [BackView setBackgroundColor:[UIColor whiteColor]];
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(Width(15), 0, kScreenWidth-Width(30),Height(20)+13+Height(20))];
        lab.font=KNSFONT(13);
        lab.numberOfLines=0;
        lab.textColor=RGB(51, 51, 51);
        lab.text=@"您已成功发起退款申请，请耐心等待卖家处理";
        lab.backgroundColor=[UIColor whiteColor];
        [BackView addSubview:lab];
        [self.scoll addSubview:BackView];
    }
    else if ([self.RefundDataModel.total_status isEqualToString:@"4"])
    {
     //   statusStr=@"退款退货中";
        UIView *BackView=[[UIView alloc] initWithFrame:CGRectMake(0, height, kScreenWidth, Height(20)+13+Height(20))];
        height+=BackView.frame.size.height;
        [BackView setBackgroundColor:[UIColor whiteColor]];
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(Width(15), 0, kScreenWidth-Width(30),Height(20)+13+Height(20))];
        lab.font=KNSFONT(13);
        lab.numberOfLines=0;
        lab.textColor=RGB(51, 51, 51);
        lab.text=@"您已成功发起退款退货申请，请耐心等待卖家处理";
        lab.backgroundColor=[UIColor whiteColor];
        [BackView addSubview:lab];
        [self.scoll addSubview:BackView];

    } else if ([self.RefundDataModel.total_status isEqualToString:@"11"])
    {
        //  statusStr=@"仅退款中";
        UIView *BackView=[[UIView alloc] initWithFrame:CGRectMake(0, height, kScreenWidth, Height(20)+13+Height(20))];
        height+=BackView.frame.size.height;
        [BackView setBackgroundColor:[UIColor whiteColor]];
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(Width(15), 0, kScreenWidth-Width(30),Height(20)+13+Height(20))];
        lab.font=KNSFONT(13);
        lab.numberOfLines=0;
        lab.textColor=RGB(51, 51, 51);
        lab.text=@"您已成功发起退款申请，请耐心等待卖家处理";
        lab.backgroundColor=[UIColor whiteColor];
        [BackView addSubview:lab];
        [self.scoll addSubview:BackView];

    }
    else if ([self.RefundDataModel.total_status isEqualToString:@"10"]||[self.RefundDataModel.total_status isEqualToString:@"3"]||[self.RefundDataModel.total_status isEqualToString:@"5"])
    {
     //   statusStr=@"仅退款成功";
        UIView *BackView=[[UIView alloc] initWithFrame:CGRectMake(0, height, kScreenWidth, (Height(20)+13+Height(20))*2+1)];
        height+=BackView.frame.size.height;
        [BackView setBackgroundColor:[UIColor whiteColor]];

        UILabel *refundlab = [[UILabel alloc]initWithFrame:CGRectMake(Width(15), 0, 120,Height(20)+13+Height(20))];
        refundlab.font=KNSFONT(13);
        refundlab.numberOfLines=0;
        refundlab.textColor=RGB(51, 51, 51);
        refundlab.text=@"退款金额";
        [BackView addSubview:refundlab];

        UILabel *refundMoneylab = [[UILabel alloc]initWithFrame:CGRectMake(Width(15)+120, 0, kScreenWidth-Width(30)-120,Height(20)+13+Height(20))];
        refundMoneylab.font=KNSFONT(12);
        refundMoneylab.numberOfLines=0;
        refundMoneylab.textColor=RGB(255, 93, 94);
        refundMoneylab.text=[NSString stringWithFormat:@"￥%@+%@积分",self.RefundDataModel.total_money,self.RefundDataModel.total_integral];
        refundMoneylab.textAlignment=NSTextAlignmentRight;
        [BackView addSubview:refundMoneylab];

        UIImageView *lineView=[[UIImageView alloc] initWithFrame:CGRectMake(0, Height(20)+13+Height(20), kScreenWidth, 1)];
        [lineView setImage:KImage(@"分割线-拷贝")];
        [BackView addSubview:lineView];

        UILabel *refundTlab = [[UILabel alloc]initWithFrame:CGRectMake(Width(15), Height(20)+13+Height(20)+1, 120,Height(20)+13+Height(20))];
        refundTlab.font=KNSFONT(13);
        refundTlab.numberOfLines=0;
        refundTlab.textColor=RGB(51, 51, 51);
        refundTlab.text=@"退款时间";
        [BackView addSubview:refundTlab];

        UILabel *refundTimelab = [[UILabel alloc]initWithFrame:CGRectMake(Width(15)+120, Height(20)+13+Height(20)+1, kScreenWidth-Width(30)-120,Height(20)+13+Height(20))];
        refundTimelab.font=KNSFONT(12);
        refundTimelab.numberOfLines=0;
        refundTimelab.textColor=RGB(51, 51, 51);
        refundTimelab.text=self.RefundDataModel.checkdate;
        refundTimelab.textAlignment=NSTextAlignmentRight;
        [BackView addSubview:refundTimelab];
        [self.scoll addSubview:BackView];
    }else if ([self.RefundDataModel.total_status isEqualToString:@"A"])
    {

    //    [topStatusLab setText:@"退款退货中\n请退货并填写物流信息"];
/**/
        UIView *BackView=[[UIView alloc] initWithFrame:CGRectMake(0, height, kScreenWidth, Height(20)+13+Height(20)+1)];
        height+=BackView.frame.size.height;
        [BackView setBackgroundColor:[UIColor whiteColor]];
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(Width(15), 0, kScreenWidth-Width(30),Height(20)+13+Height(20))];
        lab.font=KNSFONT(13);
        lab.numberOfLines=0;
        lab.textColor=RGB(51, 51, 51);
        lab.text=@"卖家已同意退货申请，请尽早退货";
        lab.backgroundColor=[UIColor whiteColor];

        UIImageView *lineView=[[UIImageView alloc] initWithFrame:CGRectMake(0, Height(20)+13+Height(20), kScreenWidth, 1)];
        [lineView setImage:KImage(@"分割线-拷贝")];

        [BackView addSubview:lineView];
        [BackView addSubview:lab];
        [self.scoll addSubview:BackView];
/**/
        UIView *receiveView=[[UIView alloc] initWithFrame:CGRectMake(0, height, kScreenWidth, Height(80))];
        [receiveView setBackgroundColor:[UIColor whiteColor]];
        [self.scoll addSubview:receiveView];
        height+=receiveView.frame.size.height;


        UILabel *receiverNameLab=[[UILabel alloc]init];
        [receiverNameLab setFont:KNSFONTM(14)];
        [receiverNameLab setText:[NSString stringWithFormat:@"收货人:%@",_RefundDataModel.add_name]];
        [receiverNameLab setTextColor:RGB(51, 51, 51)];
        [receiveView addSubview:receiverNameLab];

        UILabel *receiverPhoneLab=[[UILabel alloc]init];
        [receiverPhoneLab setFont:KNSFONTM(14)];
        [receiverPhoneLab setText:_RefundDataModel.add_phone];
        [receiverPhoneLab setTextColor:RGB(51, 51, 51)];
        [receiveView addSubview:receiverPhoneLab];

        UIImageView *receiveAddressIV=[[UIImageView alloc] init];
         [receiveAddressIV setImage:KImage(@"icon_address")];
        [receiveView addSubview:receiveAddressIV];

        UILabel *receiveAddressLab=[[UILabel alloc] init];
        [receiveAddressLab setFont:KNSFONTM(12)];
        [receiveAddressLab setNumberOfLines:0];
        [receiveAddressLab setText:[NSString stringWithFormat:@"收货地址:%@",_RefundDataModel.address]];
        [receiveAddressLab setTextColor:RGB(51, 51, 51)];
        [receiveView addSubview:receiveAddressLab];

        UIImageView *line=[[UIImageView alloc ] init];
        [line setImage:KImage(@"分割线-拷贝")];
        [receiveView addSubview:line];


        [receiverPhoneLab setFrame:CGRectMake(kScreen_Width-Width(15)-100, Height(14), 100, 14)];
        [receiverNameLab setFrame:CGRectMake(Width(35),Height(14), kScreen_Width-Width(35)-Width(15)-100, 14)];
        NSString *addressStr=[NSString stringWithFormat:@"收货地址:%@",_RefundDataModel.address];
        CGSize addressSize=[addressStr sizeWithFont:KNSFONTM(12) maxSize:CGSizeMake(kScreen_Width-Width(50), 34)];
        CGRect addressRect=CGRectMake(Width(35),Height(80)-(Height(80) - Height(28) - 14 -addressSize.height)/2.0-addressSize.height-4, addressSize.width, addressSize.height);
        YLog(@"%@",_RefundDataModel.address);
        [receiveAddressLab setFrame:addressRect];
        [receiveAddressIV setFrame:CGRectMake(Width(15),addressRect.origin.y+(addressRect.size.height-17)/2.0, 14, 17)];
        [line setFrame:CGRectMake(0, Height(80)-1, kScreenWidth, 1)];
/*    */
        UIView *logistView=[[UIView alloc] initWithFrame:CGRectMake(0, height, kScreenWidth, Height(120))];
        [logistView setBackgroundColor:[UIColor whiteColor]];
        [self.scoll addSubview:logistView];
        height+=logistView.frame.size.height;

        UIButton * but=[UIButton buttonWithType:UIButtonTypeCustom];
        but.frame=CGRectMake(Width(43), Height(20), kScreenWidth-Width(86), 35);
        but.layer.cornerRadius=35/2.0;
        but.layer.borderWidth=1;
        but.layer.borderColor=RGB(226, 226, 226).CGColor;
        [but setTitle:@"填写物流单号" forState:UIControlStateNormal];
        but.titleLabel.font=KNSFONT(13);
        [but setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
        [but addTarget:self action:@selector(LogisticButClick:) forControlEvents:UIControlEventTouchUpInside];
        [logistView addSubview:but];

        NSString *str=@"请填写真实物流信息，逾期未填写，退货申请将撤销,撤销后或超出保障期，将无法再次发起申请";
        CGSize size=[str sizeWithFont:KNSFONT(12) maxSize:CGSizeMake(kScreenWidth-Width(70), 120)];
        UILabel * lab1 = [[UILabel alloc]initWithFrame:CGRectMake(Width(35), Height(100)-size.height, kScreenWidth-Width(70), size.height)];
        lab1.font=KNSFONT(12);
        lab1.textColor=RGB(153, 153, 153);
        lab1.text=str;
        lab1.numberOfLines=2;
        [logistView addSubview:lab1];

    }else if ([self.RefundDataModel.total_status isEqualToString:@"B"])
    {

      //  [topStatusLab setText:@"退款退货中\n等待卖家收货并退款"];

/**/
        UIView *BackView=[[UIView alloc] initWithFrame:CGRectMake(0, height, kScreenWidth, Height(20)+13+Height(20)+1)];
        height+=BackView.frame.size.height;
        [BackView setBackgroundColor:[UIColor whiteColor]];
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(Width(15), 0, kScreenWidth-Width(30),Height(20)+13+Height(20))];
        lab.font=KNSFONT(13);
        lab.numberOfLines=0;
        lab.textColor=RGB(51, 51, 51);
        lab.text=@"如果卖家收到货并验货无误，将操作退款";
        lab.backgroundColor=[UIColor whiteColor];

        UIImageView *lineView=[[UIImageView alloc] initWithFrame:CGRectMake(0, Height(20)+13+Height(20), kScreenWidth, 1)];
        [lineView setImage:KImage(@"分割线-拷贝")];

        [BackView addSubview:lineView];
        [BackView addSubview:lab];
        [self.scoll addSubview:BackView];
/**/


        UIButton *checkLogisticsBut=[UIButton buttonWithType:UIButtonTypeCustom];
        [checkLogisticsBut setFrame:CGRectMake(0, height, kScreen_Width, Height(80))];

        [checkLogisticsBut addTarget:self action:@selector(checkLogisticsButClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.scoll addSubview:checkLogisticsBut];
          height+=Height(80);
        [checkLogisticsBut setBackgroundColor:[UIColor whiteColor]];

        UIImageView *logisticsIV=[[UIImageView alloc]init];
        [checkLogisticsBut addSubview:logisticsIV];

        UILabel *logisticsStatusLab=[[UILabel alloc]init];
        [logisticsStatusLab setFont:KNSFONTM(12)];
        [logisticsStatusLab setTextColor:RGB(255, 52, 90)];
        [logisticsStatusLab setNumberOfLines:0];
        [checkLogisticsBut addSubview:logisticsStatusLab];

        UILabel *logisticsTimeLab=[[UILabel alloc] init];
        [logisticsTimeLab setFont:KNSFONTM(12)];
        [logisticsTimeLab setTextColor:RGB(153, 153, 153)];
        [checkLogisticsBut addSubview:logisticsTimeLab];

        UIImageView *moreLogisticsIV=[[UIImageView alloc] init];
        [checkLogisticsBut addSubview:moreLogisticsIV];



        UIImageView *logisticsLine=[[UIImageView alloc] init];
        [checkLogisticsBut addSubview:logisticsLine];

        [logisticsStatusLab setText:[NSString stringWithFormat:@"退货物流:%@(%@)",_RefundDataModel.company,_RefundDataModel.logisticnumber]];
        [logisticsTimeLab setText:_RefundDataModel.logistics_message];
        [logisticsIV setImage:KImage(@"icon_car_logistic")];
        [logisticsLine setImage:KImage(@"分割线-拷贝")];
        [moreLogisticsIV setImage:KImage(@"icon_more")];


        CGSize logisticsSize=[_RefundDataModel.logistics_message sizeWithFont:KNSFONTM(12) maxSize:CGSizeMake(kScreen_Width-Width(50), 32)];

        CGFloat top=(Height(80)-logisticsSize.height-Height(13)-12)/2.0;

        [logisticsStatusLab setFrame:CGRectMake(Width(35), top, kScreenWidth-Width(50), 12)];

        [logisticsIV setFrame:CGRectMake(Width(15), top-4, 16, 15)];

        [logisticsTimeLab setFrame:CGRectMake(Width(15), Height(80)-top-logisticsSize.height-5, logisticsSize.width, logisticsSize.height)];

        [moreLogisticsIV setFrame:CGRectMake(kScreen_Width-Width(15)-8, (Height(80)-13)/2, 8, 13)];

        [logisticsLine setFrame:CGRectMake(0, Height(80)-1, kScreen_Width, 1)];
/**/
        UIView *BackView1=[[UIView alloc] initWithFrame:CGRectMake(0, height, kScreenWidth, Height(20)+13+Height(20)+1)];
        height+=BackView1.frame.size.height;
        [BackView1 setBackgroundColor:[UIColor whiteColor]];
        UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectMake(Width(15), 0, kScreenWidth-Width(30),Height(20)+13+Height(20))];
        lab1.font=KNSFONT(13);
        lab1.numberOfLines=0;
        lab1.textColor=RGB(153, 153, 153);
        lab1.text=@"如果商家收到退货包裹并确认无损将会第一时间给您退款";
        lab1.backgroundColor=[UIColor whiteColor];

        UIImageView *lineView1=[[UIImageView alloc] initWithFrame:CGRectMake(0, Height(20)+13+Height(20), kScreenWidth, 1)];
        [lineView1 setImage:KImage(@"分割线-拷贝")];

        [BackView1 addSubview:lineView1];
        [BackView1 addSubview:lab1];
        [self.scoll addSubview:BackView1];

    }





}

-(void)checkLogisticsButClick:(UIButton *)sender
{
    NSDictionary *params=@{@"order_batchid":_dataModel.order_batchid};
    XLShoppingModel *shopmodel=_dataArr.firstObject;
    XLDingDanModel *dingdanmodel=[[XLDingDanModel alloc] init];
    dingdanmodel.order_batchid=_dataModel.order_batchid;
    dingdanmodel.batchid=self.RefundDataModel.batchid;
    dingdanmodel.logisticnumber=self.RefundDataModel.logisticnumber;
    dingdanmodel.orderno=shopmodel.order_no;
    dingdanmodel.company=self.RefundDataModel.company;
    dingdanmodel.dingDanType=@"refundType";
    PersonalLogisticsDetailVC *VC=[[PersonalLogisticsDetailVC alloc] init];
    VC.model=dingdanmodel;
  //  VC.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:VC animated:NO];


    YLog(@"查看物流");
   // YLog(@"查看物流");
}

-(void)LogisticButClick:(UIButton *)sender
{
    FilloutRefundLogisticVC *VC=[[FilloutRefundLogisticVC alloc] init];
    VC.DataModel=self.RefundDataModel;
    [self.navigationController pushViewController:VC animated:NO];
    YLog(@"填写物流");
}

-(void)consultButClick:(UIButton *)sender
{
    ConsultNounVC *VC=[[ConsultNounVC alloc] init];

    VC.DataModel=_dataArr.firstObject;

    [self.navigationController pushViewController:VC animated:NO];

    YLog(@"协商记录");

}

-(void)kefujierubut:(UIButton *)sender
{
//    UIAlertController *alert=[UIAlertTools showAlertWithTitle:@"" message:@"如需帮助请拨打电话\n400 8119 789   转 2" cancelTitle:@"确认" titleArray:nil viewController:self confirm:^(NSInteger buttonTag) {
//
//    }];

    backView=[[UIView alloc] initWithFrame:kScreen_Bounds];
    backView.backgroundColor=RGBA(0, 0, 0, 0.2);
    [self.view addSubview:backView];

    NSString *str=@"如需帮助请拨打电话\n400 8119 789   转 2";
    CGSize size=[str sizeWithFont:KNSFONT(14) maxSize:KMAXSIZE];
    CGFloat height=Width(20);
    CGFloat width=(kScreen_Width-size.width)/4.0;

    CGFloat viewHeight=2*height+size.height+1+Width(40);
    UIView *whiteView=[[UIView alloc] initWithFrame:CGRectMake(width, (kScreenHeight-viewHeight)/2.0, size.width+2*width, viewHeight)];
    [whiteView setBackgroundColor:[UIColor whiteColor]];
    whiteView.layer.cornerRadius=10;
    [backView addSubview:whiteView];

    UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMake(width, height, size.width, size.height)];
    lab.font=KNSFONT(14);
    lab.textColor=RGB(51, 51, 51);
    lab.text=str;
    lab.numberOfLines=2;
    NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:str];
    //
    NSRange range = [str rangeOfString:@"400 8119 789"];

    [mAttStri addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:range];

    lab.attributedText=mAttStri;
    [whiteView addSubview:lab];

    UIButton *but=[UIButton buttonWithType:UIButtonTypeCustom];
    [but setFrame:lab.frame];
    [but addTarget:self action:@selector(callForHands) forControlEvents:UIControlEventTouchUpInside];
    [whiteView addSubview:but];

    UIView *lineView=[[UIView alloc] initWithFrame:CGRectMake(0, 2*height+size.height, size.width+2*width, 1)];
    [lineView setBackgroundColor:RGB(222, 222, 222)];
    [whiteView addSubview:lineView];

    UIButton *but1=[UIButton buttonWithType:UIButtonTypeCustom];
    [but1 setFrame:CGRectMake(0, 2*height+1+size.height, 2*width+size.width, Width(40))];
    [but1 setTitle:@"确认" forState:UIControlStateNormal];
    [but1 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [but1 addTarget:self action:@selector(cancle:) forControlEvents:UIControlEventTouchUpInside];
    [whiteView addSubview:but1];
}

-(void)cancle:(UIButton *)but
{
    for (UIView *view in backView.subviews) {
        [view removeFromSuperview];
    }
    [backView removeFromSuperview];
    backView=nil;
}


-(void)callForHands
{
    for (UIView *view in backView.subviews) {
        [view removeFromSuperview];
    }
    [backView removeFromSuperview];
    backView=nil;
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:4008119789"]];

}


-(void)QurtBtnClick
{

    [self.navigationController popViewControllerAnimated:NO];

}
/*******************************************************      各种button执行方法、页面间的跳转       ******************************************************/

/*******************************************************      协议方法       ******************************************************/

/*******************************************************      代码提取(多是复用代码)       ******************************************************/

-(XLShoppingRefundModel *)RefundDataModel
{
    if (!_RefundDataModel) {
        _RefundDataModel=[[XLShoppingRefundModel alloc] init];
    }
    return _RefundDataModel;
}

-(UIScrollView *)scoll
{
    if (!_scoll) {
        _scoll=[[UIScrollView alloc] initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight, kScreenWidth, kScreenHeight-KSafeAreaTopNaviHeight)];
        [_scoll setBackgroundColor:RGB(244, 244, 244)];
        [self.view addSubview:_scoll];
    }
    return _scoll;
}
@end
