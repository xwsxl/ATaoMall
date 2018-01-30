//
//  PersonalShoppingSectionFooterView.m
//  aTaohMall
//
//  Created by DingDing on 2017/11/4.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "PersonalShoppingSectionFooterView.h"
@interface PersonalShoppingSectionFooterView()

@property (nonatomic,strong)UILabel *totalPriceLab;

@property (nonatomic,strong)UILabel *activityLab;

@property (nonatomic,strong)UILabel *FreightLab;

@property (nonatomic,strong)UIImageView *lineView;

@property (nonatomic,strong)UIView *backGroudView;

@property (nonatomic,strong)UIButton *continuePayBut;

@property (nonatomic,strong)UIButton *refundBut;

@property (nonatomic,strong)UIButton *checkLogisticBut;

@property (nonatomic,strong)UIButton *sureReceiveBut;

@property (nonatomic,strong)UIButton *deleteDingdanBut;

@property (nonatomic,strong)UIButton *checkDanDetailBut;
@end

@implementation PersonalShoppingSectionFooterView

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
    self.backGroudView=[[UIView alloc] init];
    [self.backGroudView setBackgroundColor:[UIColor whiteColor]];
    [self.contentView addSubview:self.backGroudView];

    self.totalPriceLab=[[UILabel alloc] init];
    self.totalPriceLab.textAlignment=NSTextAlignmentRight;
    [self.totalPriceLab setFont:KNSFONTM(12)];
    [self.totalPriceLab setTextColor:RGB(51, 51, 51)];
    [self.backGroudView addSubview:self.totalPriceLab];

    self.FreightLab=[[UILabel alloc] init];
    self.FreightLab.textAlignment=NSTextAlignmentRight;
    [self.FreightLab setFont:KNSFONTM(12)];
    [self.FreightLab setTextColor:RGB(102, 102, 102)];
    [self.backGroudView addSubview:self.FreightLab];

    self.activityLab=[[UILabel alloc] init];
    self.activityLab.textAlignment=NSTextAlignmentRight;
    [self.activityLab setFont:KNSFONTM(12)];
    [self.activityLab setTextColor:RGB(102, 102, 102)];
    [self.backGroudView addSubview:self.activityLab];


    self.checkDanDetailBut=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.backGroudView addSubview:self.checkDanDetailBut];


    self.lineView=[[UIImageView alloc] init];
    [self.contentView addSubview:self.lineView];

    self.continuePayBut=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.continuePayBut setTitleColor:RGB(255, 93, 94) forState:UIControlStateNormal];
    self.continuePayBut.titleLabel.font=KNSFONTM(14);
    [self.backGroudView addSubview:self.continuePayBut];

    self.refundBut=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.refundBut setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
    self.refundBut.titleLabel.font=KNSFONTM(14);
    [self.backGroudView addSubview:self.refundBut];

    self.checkLogisticBut=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.checkLogisticBut setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
    self.checkLogisticBut.titleLabel.font=KNSFONTM(14);
    [self.backGroudView addSubview:self.checkLogisticBut];

    self.sureReceiveBut=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.sureReceiveBut setTitleColor:RGB(255, 93, 94) forState:UIControlStateNormal];
    self.sureReceiveBut.titleLabel.font=KNSFONTM(14);
    [self.backGroudView addSubview:self.sureReceiveBut];

    self.deleteDingdanBut=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.deleteDingdanBut setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
    self.deleteDingdanBut.titleLabel.font=KNSFONTM(14);
    [self.backGroudView addSubview:self.deleteDingdanBut];

}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.userInteractionEnabled=YES;
    [self.backGroudView setFrame:CGRectMake(0, 0, kScreen_Width, 54+Height(61))];
        CGFloat height=0;
    [self.totalPriceLab setFrame:CGRectMake(0, Height(10), kScreen_Width-Width(15), 15)];
    height+=Height(10)+15+Height(7);
    [self.activityLab setFrame:CGRectZero];
    if (_dataModel.goods_order_list.count==1) {
        XLShoppingModel *_DataModel=_dataModel.goods_order_list.lastObject;
        if ([_DataModel.order_type isEqualToString:@"9"]) {
            NSString *timestr=@"";
            if (_DataModel.getdate.length>7) {
                timestr=[_DataModel.getdate substringToIndex:7];
                YLog(@"%@",timestr);
            }

            if ([timestr isEqualToString:@"2017-10"]) {
                [self.activityLab setFrame:CGRectMake(0, height, kScreen_Width-Width(15), 12)];
                height+=Height(7)+12;
            }else if ([timestr isEqualToString:@"2017-06"])
            {
                [self.activityLab setFrame:CGRectMake(0, height, kScreen_Width-Width(15), 12)];
                 height+=Height(7)+12;
            }else if([timestr isEqualToString:@"2017-11"])
            {
                [self.activityLab setFrame:CGRectMake(0, height, kScreen_Width-Width(15), 12)];
                 height+=Height(7)+12;
            }

        }
    }

    [self.FreightLab setFrame:CGRectMake(0, height, kScreen_Width-Width(15), 12)];
    height+=Height(20)+12;

    [self.lineView setFrame:CGRectMake(0, height, kScreen_Width, 1)];

    [self.checkDanDetailBut setFrame:CGRectMake(0, 0, kScreen_Width, height)];
    [self.checkDanDetailBut addTarget:self action:@selector(checkDanDetailButClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.refundBut setFrame:CGRectZero];

    [self.continuePayBut setFrame:CGRectZero];

    [self.sureReceiveBut setFrame:CGRectZero];

    [self.checkLogisticBut setFrame:CGRectZero];

    [self.deleteDingdanBut setFrame:CGRectZero];








    [self.refundBut addTarget:self action:@selector(refundButClick:) forControlEvents:UIControlEventTouchUpInside];

    [self.continuePayBut addTarget:self action:@selector(continuePayButClick:) forControlEvents:UIControlEventTouchUpInside];

    [self.sureReceiveBut addTarget:self action:@selector(sureReceiveButClick:) forControlEvents:UIControlEventTouchUpInside];

    [self.checkLogisticBut addTarget:self action:@selector(checkLogisticButClick:) forControlEvents:UIControlEventTouchUpInside];

    [self.deleteDingdanBut addTarget:self action:@selector(deleteDingDanButClick:) forControlEvents:UIControlEventTouchUpInside];
    //0:待发货 1:待收货 7：代付款 8：未付款，交易关闭
    if ([_dataModel.total_status isEqualToString:@"0"]&&(_dataModel.goods_order_list.count==1)) {
//待发货有退款按钮
        [self.refundBut setFrame:CGRectMake(kScreen_Width-Width(15)-90, height+Height(12), 90, 27)];

        self.refundBut.layer.cornerRadius=13.5;
        self.refundBut.layer.borderWidth=1;
        self.refundBut.layer.borderColor=[RGB(51, 51, 51) CGColor];

    }else if([_dataModel.total_status isEqualToString:@"1"])
    {
        //待收货有退款退货按钮、查看物流、确认收货按钮
        if (_dataModel.goods_order_list.count==1) {
        [self.refundBut setFrame:CGRectMake(kScreen_Width-Width(15)-90*3-Width(10)*2, height+Height(12), 90, 27)];
        self.refundBut.layer.cornerRadius=13.5;
        self.refundBut.layer.borderWidth=1;
        self.refundBut.layer.borderColor=[RGB(51, 51, 51) CGColor];
        }

        [self.checkLogisticBut setFrame:CGRectMake(kScreen_Width-Width(15)-90*2-Width(10), height+Height(12), 90, 27)];
        self.checkLogisticBut.layer.cornerRadius=13.5;
        self.checkLogisticBut.layer.borderWidth=1;
        self.checkLogisticBut.layer.borderColor=[RGB(51, 51, 51) CGColor];

        [self.sureReceiveBut setFrame:CGRectMake(kScreen_Width-Width(15)-90, height+Height(12), 90, 27)];
        self.sureReceiveBut.layer.cornerRadius=13.5;
        self.sureReceiveBut.layer.borderWidth=1;
        self.sureReceiveBut.layer.borderColor=[RGB(255, 93, 94) CGColor];

    }else if([_dataModel.total_status isEqualToString:@"7"])
    {
        //代付款继续付款按钮
        [self.continuePayBut setFrame:CGRectMake(kScreen_Width-Width(15)-90, height+Height(12), 90, 27)];
        self.continuePayBut.layer.cornerRadius=13.5;
        self.continuePayBut.layer.borderWidth=1;
        self.continuePayBut.layer.borderColor=[RGB(255, 93, 94) CGColor];

    }else if([_dataModel.total_status isEqualToString:@"2"])
    {
        //代付款继续付款按钮
        [self.checkLogisticBut setFrame:CGRectMake(kScreen_Width-Width(15)-90, height+Height(12), 90, 27)];
        self.checkLogisticBut.layer.cornerRadius=13.5;
        self.checkLogisticBut.layer.borderWidth=1;
        self.checkLogisticBut.layer.borderColor=[RGB(51, 51, 51) CGColor];

    }else if([_dataModel.total_status isEqualToString:@"8"])
    {
         //未付款交易关闭的删除订单按钮
        [self.deleteDingdanBut setFrame:CGRectMake(kScreen_Width-Width(15)-90, height+Height(12), 90, 27)];
        self.deleteDingdanBut.layer.cornerRadius=13.5;
        self.deleteDingdanBut.layer.borderWidth=1;
        self.deleteDingdanBut.layer.borderColor=[RGB(51, 51, 51) CGColor];
    }else
    {
        height-=Height(24)+27;
    }
        height+=Height(24)+27;


    if (_dataModel.goods_order_list.count==1) {

        XLShoppingModel *model=_dataModel.goods_order_list.lastObject;
        if ([model.type isEqualToString:@"1"]) {
            [self.refundBut setFrame:CGRectZero];

            [self.continuePayBut setFrame:CGRectZero];

            [self.sureReceiveBut setFrame:CGRectZero];

            [self.checkLogisticBut setFrame:CGRectZero];

            [self.deleteDingdanBut setFrame:CGRectZero];
             height-=Height(24)+27;
        }


    }

 [self.backGroudView setFrame:CGRectMake(0, 0, kScreen_Width, height-1)];

}

-(void)setDataModel:(XLDingDanModel *)dataModel
{
    _dataModel=dataModel;
    self.totalPriceLab.text=[NSString stringWithFormat:@"共%@件商品    合计：￥%@+%@积分",_dataModel.total_number_goods,_dataModel.total_money,_dataModel.total_integral];

    NSString *colorStr=[NSString stringWithFormat:@"￥%@+%@积分",_dataModel.total_money,_dataModel.total_integral];
    NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:_totalPriceLab.text];
    //
    NSRange range = [_totalPriceLab.text rangeOfString:colorStr];

    [mAttStri addAttribute:NSFontAttributeName value:KNSFONTM(15) range:range];
    [mAttStri addAttribute:NSForegroundColorAttributeName value:RGB(255, 93, 94) range:range];

    _totalPriceLab.attributedText=mAttStri;


    if (_dataModel.goods_order_list.count==1) {
        XLShoppingModel *_DataModel=_dataModel.goods_order_list.lastObject;
        if ([_DataModel.order_type isEqualToString:@"9"]) {
            NSString *timestr=@"";
            if (_DataModel.getdate.length>7) {
                timestr=[_DataModel.getdate substringToIndex:7];
                YLog(@"%@",timestr);
            }

            if ([timestr isEqualToString:@"2017-10"]) {

                [self.activityLab setText:[NSString stringWithFormat:@"含定金:￥%@",_DataModel.discount_integral]];
            }else if ([timestr isEqualToString:@"2017-06"])
            {

                [self.activityLab setText:[NSString stringWithFormat:@"含优惠:%@积分",_DataModel.discount_integral]];
            }else if([timestr isEqualToString:@"2017-11"])
            {
                [self.activityLab setText:[NSString stringWithFormat:@"含定金:￥%@",_DataModel.discount_integral]];
            }

        }
    }




    self.FreightLab.text=[NSString stringWithFormat:@"(含运费￥%@)",_dataModel.total_freight];

    [self.lineView setImage:KImage(@"分割线-拷贝")];

    [self.continuePayBut setTitle:@"继续付款" forState:UIControlStateNormal];

    NSString *refundStr=@"";
    if ([_dataModel.total_status isEqualToString:@"0"]) {
        refundStr=@"退款";
    }else if([_dataModel.total_status isEqualToString:@"1"])
    {
        refundStr=@"退款/退货";
    }

    [self.refundBut setTitle:refundStr forState:UIControlStateNormal];

    [self.checkLogisticBut setTitle:@"查看物流" forState:UIControlStateNormal];

    [self.sureReceiveBut setTitle:@"确认收货" forState:UIControlStateNormal];

    [self.deleteDingdanBut setTitle:@"删除订单" forState:UIControlStateNormal];
}

-(void)refundButClick:(UIButton *)sender
{
    if (_delegate&&[_delegate respondsToSelector:@selector(refundMoneyWithModel:)]) {

    [self.delegate refundMoneyWithModel:_dataModel];
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
-(void)deleteDingDanButClick:(UIButton *)sender
{
    if (_delegate&&[_delegate respondsToSelector:@selector(deleteDingDanWithModel:)]) {

        [self.delegate deleteDingDanWithModel:_dataModel];
    }
}

-(void)checkDanDetailButClick:(UIButton *)sender
{
    if (_delegate&&[_delegate respondsToSelector:@selector(checkDanDetailWithModel:)]) {
        [self.delegate checkDanDetailWithModel:_dataModel];
    }
}

@end
