//
//  PersonalBMDanCell.m
//  aTaohMall
//
//  Created by Hawky on 2017/11/29.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "PersonalBMDanCell.h"
@interface PersonalBMDanCell ()
@property (nonatomic,strong)BMDanModel *dataModel;

@property (nonatomic,strong)UIImageView *storeIV;
@property (nonatomic,strong)UILabel *storeNameLab;
@property (nonatomic,strong)UIImageView *moreIV;
@property (nonatomic,strong)UILabel *statusLab;
@property (nonatomic,strong)UIButton *storeDetailBut;

@property (nonatomic,strong)UIButton *backBut;

@property (nonatomic,strong)UIImageView *ShoppingIV;
@property (nonatomic,strong)UILabel *stationLab;
@property (nonatomic,strong)UILabel *startTimeLab;
@property (nonatomic,strong)UILabel *priceLab;
@property (nonatomic,strong)UILabel *numLab;

@property (nonatomic,strong)UILabel *totalLab;
@property (nonatomic,strong)UILabel *freightLab;

@property (nonatomic,strong)UIImageView *lineIV;
@property (nonatomic,strong)UIButton *continuePayBut;
@property (nonatomic,strong)UIButton *refundMoneyBut;


@end
@implementation PersonalBMDanCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpSubviews];
    }
    return self;
}

-(void)setUpSubviews
{
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    [self.contentView setBackgroundColor:[UIColor whiteColor]];

/*
 */
    self.storeDetailBut=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.contentView addSubview:self.storeDetailBut];

    self.storeIV=[[UIImageView alloc] init];
    [self.contentView addSubview:self.storeIV];

    self.storeNameLab=[[UILabel alloc] init];
    [self.storeNameLab setFont:KNSFONTM(14)];
    [self.storeNameLab setTextColor:RGB(51, 51, 51)];
    [self.contentView addSubview:self.storeNameLab];

    self.moreIV=[[UIImageView alloc] init];
    [self.contentView addSubview:self.moreIV];

    self.statusLab=[[UILabel alloc] init];
    [self.statusLab setFont:KNSFONTM(14)];
    [self.statusLab setTextColor:RGB(255, 93, 94)];
    [self.contentView addSubview:self.statusLab];


/*
 */
    self.backBut=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.backBut setBackgroundColor:RGB(244, 244, 244)];
    [self.contentView addSubview:self.backBut];

    self.ShoppingIV=[[UIImageView alloc] init];
    [self.backBut addSubview:self.ShoppingIV];

    self.stationLab=[[UILabel alloc] init];
    [self.stationLab setFont:KNSFONTM(12)];
    [self.stationLab setTextColor:RGB(51, 51, 51)];
    [self.backBut addSubview:self.stationLab];

    self.startTimeLab=[[UILabel alloc] init];
    [self.startTimeLab setFont:KNSFONTM(12)];
    [self.startTimeLab setTextColor:RGB(51, 51, 51)];
    [self.backBut addSubview:self.startTimeLab];

    self.priceLab=[[UILabel alloc] init];
    [self.priceLab setFont:KNSFONTM(12)];
    [self.priceLab setTextColor:RGB(255, 93, 94)];
    [self.backBut addSubview:self.priceLab];

    self.numLab=[[UILabel alloc] init];
    [self.numLab setFont:KNSFONTM(12)];
    [self.numLab setTextColor:RGB(51, 51, 51)];
    [self.numLab setTextAlignment:NSTextAlignmentRight];
    [self.backBut addSubview:self.numLab];

    self.totalLab=[[UILabel alloc] init];
    [self.totalLab setFont:KNSFONTM(15)];
    [self.totalLab setTextColor:RGB(255, 93, 94)];
    [self.totalLab setTextAlignment:NSTextAlignmentRight];
    [self.contentView addSubview:self.totalLab];

    self.freightLab=[[UILabel alloc] init];
    [self.freightLab setTextAlignment:NSTextAlignmentRight];
    [self.freightLab setFont:KNSFONTM(12)];
    [self.freightLab setTextColor:RGB(51, 51, 51)];
    [self.contentView addSubview:self.freightLab];

/*
 */
    self.lineIV=[[UIImageView alloc] init];
    [self.contentView addSubview:self.lineIV];

    self.continuePayBut=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.continuePayBut setTitleColor:RGB(255, 93, 94) forState:UIControlStateNormal];
    self.continuePayBut.titleLabel.font=KNSFONTM(14);
    [self.contentView addSubview:self.continuePayBut];

    self.refundMoneyBut=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.refundMoneyBut setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
    self.refundMoneyBut.titleLabel.font=KNSFONTM(14);
    [self.contentView addSubview:self.refundMoneyBut];



}
-(void)layoutSubviews
{
    [super layoutSubviews];

    CGFloat height=0;
    [self.storeIV setFrame:CGRectMake(Width(15), Height(14), 15, 14)];

    CGSize storeNameSize=[self.storeNameLab.text sizeWithFont:KNSFONTM(14) maxSize:CGSizeMake(kScreen_Width/2.0-Width(22)-15+60, 14)];
    [self.storeNameLab setFrame:CGRectMake(Width(22)+15,Height(14), storeNameSize.width, 14)];

    [self.moreIV setFrame:CGRectMake(Width(22)+15+storeNameSize.width+5, Height(15), 8, 13)];

    CGSize statusSize=[self.statusLab.text sizeWithFont:KNSFONTM(14) maxSize:CGSizeMake(kScreen_Width, 14)];
    [self.statusLab setFrame:CGRectMake(kScreen_Width-Width(15)-statusSize.width,Height(14), statusSize.width, 14)];

    [self.storeDetailBut setFrame:CGRectMake(0, 0, kScreen_Width, 14+Height(28))];
    [self.storeDetailBut addTarget:self action:@selector(storeDetailButClick:) forControlEvents:UIControlEventTouchUpInside];
    height+=Height(30)+14;

    [self.backBut setFrame:CGRectMake(0, height, kScreenWidth, Height(30)+70)];
    [self.backBut addTarget:self action:@selector(backButClick:) forControlEvents:UIControlEventTouchUpInside];
    height+=self.backBut.frame.size.height;

    [self.ShoppingIV setFrame:CGRectMake(Width(15), Height(15), 70, 70)];

    [self.stationLab setFrame:CGRectMake(Width(25)+70, Height(25), kScreenWidth-Width(40)-70, 14)];
    [self.startTimeLab setFrame:CGRectZero];
    [self.priceLab setFrame:CGRectMake(Width(25)+70,Height(30)+70-Height(25)-12, kScreenWidth-Width(40)-70-20, 12)];
    if ([_dataModel.order_type isEqualToString:@"6"]) {
        [self.numLab setFrame:CGRectZero];
    }else
    {
        [self.numLab setFrame:CGRectMake(kScreenWidth-Width(15)-20, Height(30)+70-Height(25)-12, 20, 12)];
    }
    if ([_dataModel.order_type isEqualToString:@"4"]||[_dataModel.order_type isEqualToString:@"5"]) {
        [self.stationLab setFrame:CGRectMake(Width(25)+70, Height(20), kScreenWidth-Width(40)-70, 14)];
        [self.startTimeLab setFrame:CGRectMake(Width(25)+70, Height(20)+12+Height(12), kScreenWidth-Width(40)-70-20, 12)];
        [self.priceLab setFrame:CGRectMake(Width(25)+70,Height(30)+70-Height(20)-12, kScreenWidth-Width(40)-70-20, 12)];
        [self.numLab setFrame:CGRectMake(kScreenWidth-Width(15)-20, Height(30)+70-Height(20)-12, 20, 12)];
    }
    BOOL HasFreight=(![_dataModel.service_charge isEqualToString:@""]&&![_dataModel.service_charge containsString:@"null"]&&[_dataModel.service_charge floatValue]!=0);
    if (HasFreight) {
        [self.totalLab setFrame:CGRectMake(Width(15), height+Height(8), kScreenWidth-Width(30), 15)];
        [self.freightLab setFrame:CGRectMake(Width(15), height+Height(17)+15, kScreen_Width-Width(30), 12)];
    }else
    {
        [self.totalLab setFrame:CGRectMake(Width(15), height+Height(20), kScreenWidth-Width(30), 15)];
        [self.freightLab setFrame:CGRectZero];
    }
    height+=Height(20)+Height(20)+15;

    [self.continuePayBut setFrame:CGRectZero];
    [self.refundMoneyBut setFrame:CGRectZero];
    [self.continuePayBut addTarget:self action:@selector(continuePayButClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.refundMoneyBut addTarget:self action:@selector(refundMoneyButClick:) forControlEvents:UIControlEventTouchUpInside];

    [self.lineIV setFrame:CGRectZero];

    if ([_dataModel.status isEqualToString:@"0"]) {
        [self.lineIV setFrame:CGRectMake(0, height, kScreenWidth, 1)];
        [self.continuePayBut setFrame:CGRectMake(kScreenWidth-90-Width(15), height+Height(12), 90, 27)];
        [self.continuePayBut.layer setCornerRadius:13.5];
        [self.continuePayBut.layer setBorderWidth:1];
        [self.continuePayBut.layer setBorderColor:RGB(255, 93, 94).CGColor];
    }

    if ([_dataModel.status isEqualToString:@"3"]&&(([_dataModel.is_refund isEqualToString:@"0"]&&[_dataModel.order_type isEqualToString:@"4"])||[_dataModel.order_type isEqualToString:@"5"])) {
        [self.lineIV setFrame:CGRectMake(0, height, kScreenWidth, 1)];
        [self.refundMoneyBut setFrame:CGRectMake(kScreenWidth-90-Width(15), height+Height(12), 90, 27)];
        [self.refundMoneyBut.layer setCornerRadius:13.5];
        [self.refundMoneyBut.layer setBorderWidth:1];
        [self.refundMoneyBut.layer setBorderColor:RGB(51, 51, 51).CGColor];
    }

}




-(void)loadDataWithModel:(BMDanModel *)model
{
    _dataModel=model;
    [self.storeIV setImage:KImage(@"店铺111")];

    [self.storeNameLab setText:_dataModel.storename];

    [self.moreIV setImage:KImage(@"icon_more")];
    NSString *statusStr=@"";


    //  order_type :   1 话费  2 流量   3 游戏  4 机票购买  5:火车购买 6.违章查询
    //0：未付款     1：未付款交易关闭   2：已付款（充值中） 3：交易完成（充值成功） 4：退款中（充值失败） 5：已付款，交易关闭（退   6：交易失败（异常订单）

    switch ([_dataModel.status integerValue]) {
        case 0:
            statusStr=@"待付款";
            break;
        case 1:
            statusStr=@"交易关闭";
            break;
        case 2:
            if ([_dataModel.order_type isEqualToString:@"1"]||[_dataModel.order_type isEqualToString:@"2"]) {
               statusStr=@"充值中";
            }else if([_dataModel.order_type isEqualToString:@"4"]||[_dataModel.order_type isEqualToString:@"5"])
            {

                statusStr=@"出票中";

            }else
            {
                statusStr=@"缴费中";
            }

            break;
        case 3:
            statusStr=@"交易成功";
            break;
        case 4:
            statusStr=@"退款中";
            break;
        case 5:
            statusStr=@"已退款";
            break;
        case 6:
            statusStr=@"支付异常";
            break;
        default:
            break;
    }



    [self.statusLab setText:statusStr];

    [self.ShoppingIV sd_setImageWithURL:KNSURL(_dataModel.scopeimg) placeholderImage:KImage(@"default_image") options:SDWebImageProgressiveDownload];

    NSString *nameStr=@"";
    [self.stationLab setFont:KNSFONTM(12)];
    if ([_dataModel.order_type isEqualToString:@"1"]||[_dataModel.order_type isEqualToString:@"2"]||[_dataModel.order_type isEqualToString:@"3"]) {
        nameStr=_dataModel.name;
        [self.stationLab setText:nameStr];
    }else if([_dataModel.order_type isEqualToString:@"4"])
    {
        nameStr=[NSString stringWithFormat:@"%@  %@ %@",_dataModel.name,_dataModel.airport_name,_dataModel.airport_flight];
        [self.stationLab setText:nameStr];
        NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:self.stationLab.text];
        //
        NSRange range = [self.stationLab.text rangeOfString:_dataModel.name];

        [mAttStri addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:14] range:range];

        self.stationLab.attributedText=mAttStri;

    }else if([_dataModel.order_type isEqualToString:@"5"]){
        nameStr=[NSString stringWithFormat:@"%@  %@ %@",_dataModel.name,_dataModel.che_type,_dataModel.checi];
        [self.stationLab setText:nameStr];
        NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:self.stationLab.text];
        //
        NSRange range = [self.stationLab.text rangeOfString:_dataModel.name];

        [mAttStri addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:14] range:range];

        self.stationLab.attributedText=mAttStri;

    }else if([_dataModel.order_type isEqualToString:@"6"]){
        nameStr=_dataModel.CarNo;
        [self.stationLab setText:nameStr];
        [self.stationLab setFont:[UIFont boldSystemFontOfSize:14]];
    }

    if ([_dataModel.order_type isEqualToString:@"4"]||[_dataModel.order_type isEqualToString:@"5"]) {
        [self.startTimeLab setText:[NSString stringWithFormat:@"出发时间:%@",_dataModel.start_time]];
    }else
    {
        [self.startTimeLab setText:@""];
    }

    NSString *priceStr=@"";
    if ([_dataModel.order_type isEqualToString:@"6"]) {
        
        priceStr=[NSString stringWithFormat:@"扣%@分 罚%@元",_dataModel.total_deductPoint,_dataModel.total_fine];

        [self.priceLab setText:priceStr];
        NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:self.priceLab.text];
        NSString *str1=@"扣";
        NSString *str2=@"分 罚";
        NSString *str3=@"元";
        NSRange range1 = [self.priceLab.text rangeOfString:str1];
        NSRange range2 = [self.priceLab.text rangeOfString:str2];
        NSRange range3 = [self.priceLab.text rangeOfString:str3];
        [mAttStri addAttribute:NSForegroundColorAttributeName value:RGB(51, 51, 51) range:range1];
        [mAttStri addAttribute:NSForegroundColorAttributeName value:RGB(51, 51, 51) range:range2];
        [mAttStri addAttribute:NSForegroundColorAttributeName value:RGB(51, 51, 51) range:range3];
        self.priceLab.attributedText=mAttStri;
    }else
    {
        priceStr=[NSString stringWithFormat:@"￥%@+%@积分",_dataModel.pay_money,_dataModel.pay_integral];

        [self.priceLab setText:priceStr];
        NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:self.priceLab.text];
        NSString *str1=@"￥";
        NSString *str2=@"积分";
        NSRange range1 = [self.priceLab.text rangeOfString:str1];
        NSRange range2 = [self.priceLab.text rangeOfString:str2];
        [mAttStri addAttribute:NSFontAttributeName value:KNSFONTM(9) range:range1];
        [mAttStri addAttribute:NSFontAttributeName value:KNSFONTM(9) range:range2];
        self.priceLab.attributedText=mAttStri;

    }
    [self.numLab setText:[NSString stringWithFormat:@"x%@",_dataModel.number]];

    NSString *totalStr=[NSString stringWithFormat:@"共%@件商品  合计：￥%@+%@积分",_dataModel.number,_dataModel.paymoney,_dataModel.payintegral];
    [self.totalLab setText:totalStr];
    NSString *colorstr=[NSString stringWithFormat:@"共%@件商品  合计：",_dataModel.number];
    NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:self.totalLab.text];
    NSRange range1 = [self.totalLab.text rangeOfString:colorstr];
    [mAttStri addAttribute:NSForegroundColorAttributeName value:RGB(51, 51, 51) range:range1];
    [mAttStri addAttribute:NSFontAttributeName value:KNSFONT(12) range:range1];
    self.totalLab.attributedText=mAttStri;


    [self.freightLab setText:[NSString stringWithFormat:@"(含服务费￥%@)",_dataModel.service_charge]];

    [self.lineIV setImage:KImage(@"分割线-拷贝")];
    [self.continuePayBut setTitle:@"继续付款" forState:UIControlStateNormal];
    [self.refundMoneyBut setTitle:@"退款" forState:UIControlStateNormal];

}

-(void)refundMoneyButClick:(UIButton *)sender
{
    if (_delegate&&[_delegate respondsToSelector:@selector(RefundMoneyWithModel:)]) {
        [_delegate RefundMoneyWithModel:_dataModel];
    }
}

-(void)storeDetailButClick:(UIButton *)sender
{
    if (_delegate&&[_delegate respondsToSelector:@selector(CheckMerchantDetailWithModel:)]) {
        [_delegate CheckMerchantDetailWithModel:_dataModel];
    }
}
-(void)continuePayButClick:(UIButton *)sender
{
    if (_delegate&&[_delegate respondsToSelector:@selector(ContinuePayWithModel:)]) {
        [_delegate ContinuePayWithModel:_dataModel];
    }
}
-(void)backButClick:(UIButton *)sender
{
    if (_delegate&&[_delegate respondsToSelector:@selector(CheckBMDanDetailWithModel:)]) {
        [_delegate CheckBMDanDetailWithModel:_dataModel];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
