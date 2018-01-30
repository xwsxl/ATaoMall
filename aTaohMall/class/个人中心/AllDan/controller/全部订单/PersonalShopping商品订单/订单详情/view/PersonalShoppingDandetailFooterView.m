//
//  PersonalShoppingDandetailFooterView.m
//  aTaohMall
//
//  Created by DingDing on 2017/11/7.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "PersonalShoppingDandetailFooterView.h"
@interface PersonalShoppingDandetailFooterView()
@property (nonatomic,strong)PersonalShoppingDanDetailModel *dataModel;

/*
 总计金额花费
 */
@property (nonatomic,strong)UILabel *freightLab;
@property (nonatomic,strong)UILabel *freightPriceLab;
@property (nonatomic,strong)UILabel *payMoneyNameLab;
@property (nonatomic,strong)UILabel *payMoneyLab;

@property (nonatomic,strong)UILabel *activityLab;
@property (nonatomic,strong)UILabel *activityMoneyLab;

@property (nonatomic,strong)UIImageView *line;
/*
 订单流程时间记录
 */
@property (nonatomic,strong)UILabel *orderNoLab;
@property (nonatomic,strong)UILabel *creatTimeLab;
@property (nonatomic,strong)UILabel *payTimeLab;
@property (nonatomic,strong)UILabel *sendTimeLab;
@property (nonatomic,strong)UILabel *receiveTimeLab;
@property (nonatomic,strong)UILabel *replyTimeLab;
@property (nonatomic,strong)UILabel *refundTimeLab;
/*
 底部操作按钮
 */
@property (nonatomic,strong)UIImageView *bottomLine;
@property (nonatomic,strong)UIButton *checkLogisticsBut;
@property (nonatomic,strong)UIButton *continuePayBut;
@property (nonatomic,strong)UIButton *sureReceiveBut;
@property (nonatomic,strong)UIButton *refundBut;

@end
@implementation PersonalShoppingDandetailFooterView
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        //在这里向contentView添加控件
        [self setUpSubviews];

    }
    return self;
}


-(void)setUpSubviews
{
        [self.contentView setBackgroundColor:[UIColor whiteColor]];
/*
 总花费视图
 */
        self.freightLab=[[UILabel alloc] init];
        [self.freightLab setFont:KNSFONTM(12)];
        [self.freightLab setTextColor:RGB(51, 51, 51)];
        [self.contentView addSubview:self.freightLab];

        self.freightPriceLab=[[UILabel alloc] init];
        [self.freightPriceLab setFont:KNSFONTM(12)];
        [self.freightPriceLab setTextColor:RGB(51, 51, 51)];
        [self.contentView addSubview:self.freightPriceLab];

    self.activityLab=[[UILabel alloc] init];
    [self.activityLab setFont:KNSFONTM(12)];
    [self.activityLab setTextColor:RGB(51, 51, 51)];
    [self.contentView addSubview:self.activityLab];

    self.activityMoneyLab=[[UILabel alloc] init];
    [self.activityMoneyLab setFont:KNSFONTM(12)];
    [self.activityMoneyLab setTextColor:RGB(51, 51, 51)];
    [self.contentView addSubview:self.activityMoneyLab];

        self.payMoneyNameLab=[[UILabel alloc] init];
        [self.payMoneyNameLab setFont:KNSFONTM(14)];
        [self.payMoneyNameLab setTextColor:RGB(51, 51, 51)];
        [self.contentView addSubview:self.payMoneyNameLab];

        self.payMoneyLab=[[UILabel alloc] init];
        [self.payMoneyLab setTextColor:RGB(255, 93, 94)];
        [self.payMoneyLab setTextAlignment:NSTextAlignmentRight];
        [self.payMoneyLab setFont:KNSFONTM(14)];
        [self.contentView addSubview:self.payMoneyLab];

        self.line=[[UIImageView alloc]init];
        [self.contentView addSubview:self.line];
/*
 订单流程图
 */
        self.orderNoLab=[[UILabel alloc] init];
        [self.orderNoLab setFont:KNSFONTM(12)];
        [self.orderNoLab setTextColor:RGB(102, 102, 102)];
        [self.contentView addSubview:self.orderNoLab];

        self.creatTimeLab=[[UILabel alloc] init];
        [self.creatTimeLab setFont:KNSFONTM(12)];
        [self.creatTimeLab setTextColor:RGB(102, 102, 102)];
        [self.contentView addSubview:self.creatTimeLab];

        self.payTimeLab=[[UILabel alloc] init];
        [self.payTimeLab setFont:KNSFONTM(12)];
        [self.payTimeLab setTextColor:RGB(102, 102, 102)];
        [self.contentView addSubview:self.payTimeLab];

        self.sendTimeLab=[[UILabel alloc] init];
        [self.sendTimeLab setFont:KNSFONTM(12)];
        [self.sendTimeLab setTextColor:RGB(102, 102, 102)];
        [self.contentView addSubview:self.sendTimeLab];

        self.receiveTimeLab=[[UILabel alloc] init];
        [self.receiveTimeLab setFont:KNSFONTM(12)];
        [self.receiveTimeLab setTextColor:RGB(102, 102, 102)];
        [self.contentView addSubview:self.receiveTimeLab];

        self.replyTimeLab=[[UILabel alloc] init];
        [self.replyTimeLab setFont:KNSFONTM(12)];
        [self.replyTimeLab setTextColor:RGB(102, 102, 102)];
        [self.contentView addSubview:self.replyTimeLab];

        self.refundTimeLab=[[UILabel alloc] init];
        [self.refundTimeLab setFont:KNSFONTM(12)];
        [self.refundTimeLab setTextColor:RGB(102, 102, 102)];
        [self.contentView addSubview:self.refundTimeLab];


///*
// 底部操作视图
// */
//    self.bottomLine=[[UIImageView alloc] init];
//    [self.contentView addSubview:self.bottomLine];
//
//    self.continuePayBut=[UIButton buttonWithType:UIButtonTypeCustom];
//    [self.continuePayBut setTitleColor:RGB(255, 93, 94) forState:UIControlStateNormal];
//    self.continuePayBut.titleLabel.font=KNSFONTM(14);
//    [self.contentView addSubview:self.continuePayBut];
//
//    self.checkLogisticsBut=[UIButton buttonWithType:UIButtonTypeCustom];
//    [self.checkLogisticsBut setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
//    self.checkLogisticsBut.titleLabel.font=KNSFONTM(14);
//    [self.contentView addSubview:self.checkLogisticsBut];
//
//    self.refundBut=[UIButton buttonWithType:UIButtonTypeCustom];
//    [self.refundBut setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
//    self.refundBut.titleLabel.font=KNSFONTM(14);
//    [self.contentView addSubview:self.refundBut];
//
//    self.sureReceiveBut=[UIButton buttonWithType:UIButtonTypeCustom];
//    [self.sureReceiveBut setTitleColor:RGB(255, 93, 94) forState:UIControlStateNormal];
//    self.sureReceiveBut.titleLabel.font=KNSFONTM(14);
//    [self.contentView addSubview:self.sureReceiveBut];

}


-(void)layoutSubviews
{
        [super layoutSubviews];
        CGFloat height=0;
    /*
     总花费视图
     */
    [self.activityLab setFrame:CGRectZero];
    [self.activityMoneyLab setFrame:CGRectZero];
    if (_dataModel.order_list.count==1) {
         PersonalSingleShoppingDetailModel *_DataModel=_dataModel.order_list.lastObject;
         if ([_DataModel.order_type isEqualToString:@"9"]) {
             NSString *timestr=@"";
             if (_DataModel.getdate.length>7) {
                 timestr=[_DataModel.getdate substringToIndex:7];
                 YLog(@"%@",timestr);
             }

             if ([timestr isEqualToString:@"2017-10"]) {
                 [self.activityLab setFrame:CGRectMake(Width(15), height+Height(12), 60, 12)];
                 [self.activityMoneyLab setFrame:CGRectMake(kScreen_Width-Width(15)-120, height+Height(12), 120, 12)];
                 height+=Height(12)+12;

             }else if ([timestr isEqualToString:@"2017-06"])
             {
                 [self.activityLab setFrame:CGRectMake(Width(15), height+Height(12), 60, 12)];
                 [self.activityMoneyLab setFrame:CGRectMake(kScreen_Width-Width(15)-120, height+Height(12), 120, 12)];
            height+=Height(12)+12;
             }else if([timestr isEqualToString:@"2017-11"])
             {
                 [self.activityLab setFrame:CGRectMake(Width(15), height+Height(12), 60, 12)];
                 [self.activityMoneyLab setFrame:CGRectMake(kScreen_Width-Width(15)-120, height+Height(12), 120, 12)];
            height+=Height(12)+12;
             }

         }
     }

    
        [self.freightLab setFrame:CGRectMake(Width(15), height+Height(12), 60, 12)];
        [self.freightPriceLab setFrame:CGRectMake(kScreen_Width-Width(15)-120, height+Height(12), 120, 12)];

        [self.payMoneyNameLab setFrame:CGRectMake(Width(15), height+Height(12)+12+Height(12), 120, 14)];
        [self.payMoneyLab setFrame:CGRectMake(kScreen_Width-Width(15)-240, height+Height(12)+12+Height(12), 240, 14)];

        [self.line setFrame:CGRectMake(0, height+Height(12)+12+Height(12)+14+Height(19), kScreen_Width, 1)];

        height+=Height(12)+12+Height(12)+14+Height(19)+1;
    /*
     订单流程视图
     */



    [self.orderNoLab setFrame:CGRectMake(Width(15), height+Height(20), kScreen_Width-Width(30), 12)];
    [self.creatTimeLab setFrame:CGRectMake(Width(15), height+Height(20)+12+Height(11), kScreen_Width-Width(30), 12)];
    [self.payTimeLab setFrame:CGRectMake(Width(15), height+Height(20)+12+Height(11)+12+Height(11), kScreen_Width-Width(30), 12)];
    [self.sendTimeLab setFrame:CGRectZero];
    [self.replyTimeLab setFrame:CGRectZero];
    [self.receiveTimeLab setFrame:CGRectZero];
    [self.refundTimeLab setFrame:CGRectZero];
    height+=Height(20)+12+Height(11)+12+Height(11)+12+Height(11);

    if ([_dataModel.total_status isEqualToString:@"8"]||[_dataModel.total_status isEqualToString:@"9"]) {
        [self.payTimeLab setFrame:CGRectZero];
        height-=12+Height(11);
    }

    if ([_dataModel.total_status isEqualToString:@"0"]||[_dataModel.total_status isEqualToString:@"1"]||[_dataModel.total_status isEqualToString:@"2"]||[_dataModel.total_status isEqualToString:@"5"]||[_dataModel.total_status isEqualToString:@"10"]||[_dataModel.total_status isEqualToString:@"4"]||[_dataModel.total_status isEqualToString:@"11"]) {
        [self.sendTimeLab setFrame:CGRectMake(Width(15), height, kScreen_Width-Width(30), 12)];
        height+=12+Height(11);
    }

    if ([_dataModel.total_status isEqualToString:@"2"]) {
         PersonalSingleShoppingDetailModel *model1=_dataModel.order_list.lastObject;
        if ((_dataModel.order_list.count==1)&&[model1.type isEqualToString:@"1"]) {

        }else
        {
        [self.receiveTimeLab setFrame:CGRectMake(Width(15), height, kScreen_Width-Width(30), 12)];
        height+=12+Height(11);
        }
    }

    if ([_dataModel.total_status isEqualToString:@"3"]||[_dataModel.total_status isEqualToString:@"4"]||[_dataModel.total_status isEqualToString:@"10"]||[_dataModel.total_status isEqualToString:@"5"]||[_dataModel.total_status isEqualToString:@"6"]||[_dataModel.total_status isEqualToString:@"11"]) {
        [self.replyTimeLab setFrame:CGRectMake(Width(15), height, kScreen_Width-Width(30), 12)];
        height+=12+Height(11);
    }

    if ([_dataModel.total_status isEqualToString:@"3"]||[_dataModel.total_status isEqualToString:@"5"]||[_dataModel.total_status isEqualToString:@"10"]) {
        [self.refundTimeLab setFrame:CGRectMake(Width(15), height, kScreen_Width-Width(30), 12)];
        height+=12+Height(11);
    }


}



-(void)loadData:(PersonalShoppingDanDetailModel *)model
{
    self.dataModel=model;
/*
 总花费统计
 */

    if (_dataModel.order_list.count==1) {
        PersonalSingleShoppingDetailModel *_DataModel1=_dataModel.order_list.lastObject;
        if ([_DataModel1.order_type isEqualToString:@"9"]) {
            NSString *timestr=@"";
            if (_DataModel1.getdate.length>7) {
                timestr=[_DataModel1.getdate substringToIndex:7];
                YLog(@"%@",timestr);
            }

            if ([timestr isEqualToString:@"2017-10"]) {
                [self.activityLab setText:@"定金"];
                [self.activityMoneyLab setText:[NSString stringWithFormat:@"￥%@",_DataModel1.discount_integral]];

            }else if ([timestr isEqualToString:@"2017-06"])
            {
                [self.activityLab setText:@"优惠"];
                [self.activityMoneyLab setText:[NSString stringWithFormat:@"%@积分",_DataModel1.discount_integral]];

            }else if([timestr isEqualToString:@"2017-11"])
            {
                [self.activityLab setText:@"定金"];
                [self.activityMoneyLab setText:[NSString stringWithFormat:@"￥%@",_DataModel1.discount_integral]];

            }
            [self.activityMoneyLab setTextAlignment:NSTextAlignmentRight];
            NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:self.activityMoneyLab.text];
            NSRange range = [self.activityMoneyLab.text rangeOfString:@"￥"];
            [mAttStri addAttribute:NSFontAttributeName value:KNSFONTM(9) range:range];
            self.activityMoneyLab.attributedText=mAttStri;
        }
    }

    [self.freightLab setText:@"运费"];

    [self.freightPriceLab setText:[NSString stringWithFormat:@"￥%@",self.dataModel.total_freight]];
    [self.freightPriceLab setTextAlignment:NSTextAlignmentRight];
    NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:self.freightPriceLab.text];
    NSRange range = [self.freightPriceLab.text rangeOfString:@"￥"];
    [mAttStri addAttribute:NSFontAttributeName value:KNSFONTM(9) range:range];
    self.freightPriceLab.attributedText=mAttStri;

    [self.payMoneyNameLab setText:@"实付款(含运费)"];

    [self.payMoneyLab setText:[NSString stringWithFormat:@"￥%@+%@积分",self.dataModel.total_money,self.dataModel.total_integral]];
    NSMutableAttributedString *mAttStri1 = [[NSMutableAttributedString alloc] initWithString:self.payMoneyLab.text];
    NSRange range1 = [self.payMoneyLab.text rangeOfString:@"￥"];
    [mAttStri1 addAttribute:NSFontAttributeName value:KNSFONTM(9) range:range1];
    self.payMoneyLab.attributedText=mAttStri1;

    [self.line setImage:KImage(@"分割线-拷贝")];
/*
 订单流程记录
 */
    NSString *str=@"";

    if ([model.total_status isEqualToString:@"3"]) {
        [self.refundTimeLab setText:[NSString stringWithFormat:@"退款时间:  %@",_dataModel.sure_refund_time]];
    }else if ([model.total_status isEqualToString:@"5"]||[model.total_status isEqualToString:@"10"])
    {
        str=@"      ";
        [self.refundTimeLab setText:[NSString stringWithFormat:@"退款退货时间:  %@",_dataModel.sure_refund_time]];
    }
    [self.orderNoLab setText:[NSString stringWithFormat:@"   %@订单号:  %@",str,_dataModel.order_batchid]];
    [self.creatTimeLab setText:[NSString stringWithFormat:@"%@创建时间:  %@",str,_dataModel.sys_date]];
    [self.payTimeLab setText:[NSString stringWithFormat:@"%@付款时间:  %@",str,_dataModel.pay_time]];

    
    [self.sendTimeLab setText:[NSString stringWithFormat:@"%@发货时间:  %@",str,_dataModel.leave_date]];
    [self.receiveTimeLab setText:[NSString stringWithFormat:@"%@交易时间:  %@",str,_dataModel.checkdate]];
    [self.replyTimeLab setText:[NSString stringWithFormat:@"%@申请时间:  %@",str,_dataModel.refund_time]];



    if ([_dataModel.total_status isEqualToString:@"7"]) {

        [self.payTimeLab setText:[NSString stringWithFormat:@"付款时间:  正在等待买家付款"]];

    }
    if ([_dataModel.total_status isEqualToString:@"0"]) {

        [self.sendTimeLab setText:@"发货时间:  等待卖家发货"];
        PersonalSingleShoppingDetailModel *model1=_dataModel.order_list.lastObject;
        if ([model1.type isEqualToString:@"1"]) {
            [self.sendTimeLab setText:@"兑换时间:  未兑换"];
            //[self.receiveTimeLab setText:@"兑换时间:  未兑换"];
        }

    }else if ([_dataModel.total_status isEqualToString:@"2"])
    {
        PersonalSingleShoppingDetailModel *model1=_dataModel.order_list.lastObject;
        if ([model1.type isEqualToString:@"1"]) {
           [self.sendTimeLab setText:[NSString stringWithFormat:@"%@兑换时间:  %@",str,_dataModel.checkdate]];
        }
    }

}

-(void)continuePayButClick:(UIButton *)sender
{
    if (_delegate&&[_delegate respondsToSelector:@selector(continuePayWithModel:)]) {

        [self.delegate continuePayWithModel:_dataModel];
    }
}
-(void)sureReceiveButClick:(UIButton *)sender
{
    if (_delegate&&[_delegate respondsToSelector:@selector(sureReceiveWithModel:)]) {

        [self.delegate sureReceiveWithModel:_dataModel];
    }
}
-(void)checkLogisticButClick:(UIButton *)sender
{
    if (_delegate&&[_delegate respondsToSelector:@selector(checkLogisticInfoWithModel:)]) {

        [self.delegate checkLogisticInfoWithModel:_dataModel];
    }
}
-(void)refundButClick:(UIButton *)sender
{
    if (_delegate&&[_delegate respondsToSelector:@selector(refundMoneyWithModel:)]) {

        [self.delegate refundMoneyWithModel:_dataModel];
    }
}

@end
