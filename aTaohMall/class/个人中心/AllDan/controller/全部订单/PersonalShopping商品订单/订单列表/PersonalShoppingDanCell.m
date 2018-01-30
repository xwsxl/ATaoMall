//
//  PersonalShoppingDanCell.m
//  aTaohMall
//
//  Created by DingDing on 2017/11/4.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "PersonalShoppingDanCell.h"

@implementation PersonalShoppingDanCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupSubviews];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        [self setupSubviews];
    }
    return self;
}


-(void)setupSubviews
{
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    self.backGroudView=[[UIView alloc]init];
    [self.contentView setBackgroundColor:[UIColor whiteColor]];
    [self.backGroudView setBackgroundColor:RGB(248, 248, 248)];

    [self.contentView addSubview:self.backGroudView];

    self.storeIV=[[UIImageView alloc] init];
    [self.backGroudView addSubview:self.storeIV];

    self.ActivityIV=[[UIImageView alloc] init];
    [self.imageView addSubview:self.ActivityIV];



    self.goodsNameLab=[[UILabel alloc] init];
    [self.goodsNameLab setFont:KNSFONTM(12)];
    [self.goodsNameLab setNumberOfLines:0];
    [self.goodsNameLab setTextColor:RGB(51, 51, 51)];
    [self.backGroudView addSubview:self.goodsNameLab];

    self.attrbuteLab=[[UILabel alloc] init];
    [self.attrbuteLab setFont:KNSFONTM(9)];
    [self.attrbuteLab setNumberOfLines:0];
    [self.attrbuteLab setTextColor:RGB(153, 153, 153)];
    [self.backGroudView addSubview:self.attrbuteLab];

    self.priceLab=[[UILabel alloc] init];
    [self.priceLab setFont:KNSFONTM(12)];
    [self.priceLab setTextColor:RGB(255, 93, 94)];
    [self.backGroudView addSubview:self.priceLab];

    self.goodsNumberLab=[[UILabel alloc] init];
    [self.goodsNumberLab setFont:KNSFONTM(12)];

    [self.goodsNumberLab setTextColor:RGB(51, 51, 51)];
    [self.backGroudView addSubview:self.goodsNumberLab];

    self.singleRefundBut=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.singleRefundBut setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
    self.singleRefundBut.titleLabel.font=KNSFONTM(9);
    [self.backGroudView addSubview:self.singleRefundBut];


    self.refundIV=[[UIImageView alloc] init];
    [self.contentView addSubview:self.refundIV];


    self.refundDescLab=[[UILabel alloc] init];
    [self.refundDescLab setFont:KNSFONTM(12)];
    [self.refundDescLab setTextColor:RGB(51, 51, 51)];
    [self.contentView addSubview:self.refundDescLab];

    self.totalPriceLab=[[UILabel alloc] init];
    self.totalPriceLab.textAlignment=NSTextAlignmentRight;
    [self.totalPriceLab setFont:KNSFONTM(12)];
    [self.totalPriceLab setTextColor:RGB(51, 51, 51)];
    [self.contentView addSubview:self.totalPriceLab];
    

}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [_singleRefundBut addTarget:self
                         action:@selector(refundSingleShoppingButClick:) forControlEvents:UIControlEventTouchUpInside];
     //判断是否是属性商品
    if ([_DataModel.attribute_str isEqualToString:@""]) {
        [self layoutNoAttributeSubviews];
    }else
    {
        [self layoutAttributeSubviews];
    }

}
//有属性商品布局
-(void)layoutAttributeSubviews
{
    [self.backGroudView setFrame:CGRectMake(0, 0, kScreen_Width, 100)];
    [self.singleRefundBut setFrame:CGRectZero];
    CGSize refundSize=[self.RefundStr sizeWithFont:KNSFONTM(9) maxSize:CGSizeMake(200, 10)];
    if (
        !_DataModel.isSingle&&![_DataModel.dingDanType isEqualToString:@"refundType"]&&
         ([_DataModel.status isEqualToString:@"0"]||[_DataModel.status isEqualToString:@"1"]
         ||[_DataModel.status isEqualToString:@"3"]||[_DataModel.status isEqualToString:@"4"]||[_DataModel.status isEqualToString:@"5"]||[_DataModel.status isEqualToString:@"6"]||[_DataModel.status isEqualToString:@"10"]||[_DataModel.status isEqualToString:@"11"]||([_DataModel.status isEqualToString:@"2"]&&([_DataModel.refund_count integerValue]>0||[_DataModel.return_goods_count integerValue]>0)))) {
            [self.backGroudView setFrame:CGRectMake(0, 0, kScreen_Width, 120)];
            [self.singleRefundBut setFrame:CGRectMake(kScreen_Width-Width(15)-(refundSize.width+20), 96, refundSize.width+20, 15)];
            [self.singleRefundBut.layer setCornerRadius:7.5];
            [self.singleRefundBut.layer setBorderColor:[RGB(51, 51, 51) CGColor]];
            [self.singleRefundBut.layer setBorderWidth:1];
        }
    if (!_DataModel.isSingle&&[_DataModel.dingDanType isEqualToString:@"refundType"]) {
        [self.backGroudView setFrame:CGRectMake(0, 0, kScreen_Width, 120)];
        [self.singleRefundBut setTitleColor:RGB(255, 93, 94) forState:UIControlStateNormal];
        [self.singleRefundBut setFrame:CGRectMake(kScreen_Width-Width(15)-(refundSize.width+20), 96, refundSize.width+20, 15)];
        [self.singleRefundBut.layer setCornerRadius:7.5];
        [self.singleRefundBut.layer setBorderColor:[RGB(255, 93, 94) CGColor]];
        [self.singleRefundBut.layer setBorderWidth:1];
    }
[self.ActivityIV setFrame:CGRectZero];
    if ([_DataModel.order_type isEqualToString:@"9"]) {
        NSString *timestr=@"";
        if (_DataModel.getdate.length>7) {
            timestr=[_DataModel.getdate substringToIndex:7];
            YLog(@"%@",timestr);
        }

        if ([timestr isEqualToString:@"2017-10"]) {
            [self.ActivityIV setFrame:CGRectMake(0, 0, 36, 42)];
           // [self.ActivityIV setImage:KImage(@"activ_logo")];
        }else if ([timestr isEqualToString:@"2017-06"])
        {
            [self.ActivityIV setFrame:CGRectMake(0, 0, 36, 42)];
           // [self.ActivityIV setImage:KImage(@"activ_logo1")];
        }else if([timestr isEqualToString:@"2017-11"])
        {

           // [self.ActivityIV setImage:KImage(@"activ_logo2")];
            [self.ActivityIV setFrame:CGRectMake(0, 0, 36, 42)];
        }




    }

    [self.imageView setFrame:CGRectMake(Width(15), 15, 70, 70)];
    [self.imageView.layer setCornerRadius:3];

    [self.attrbuteLab setFrame:CGRectMake(Width(28)+70, 44, kScreen_Width-Width(28)-70-15, 30)];

    [self.priceLab setFrame:CGRectMake(Width(28)+70, 76, kScreen_Width-Width(28)-70-15, 12)];

    [self.goodsNumberLab setFrame:CGRectMake(kScreen_Width-Width(15)-30, 76, 30, 11)];
    CGSize nameLabSize=[_DataModel.name sizeWithFont:KNSFONTM(12) maxSize:CGSizeMake(kScreen_Width-Width(28)-70-15, 34)];
    self.goodsNameLab.frame=CGRectMake(Width(28)+70, 12, nameLabSize.width, nameLabSize.height);

    [self.contentView setBackgroundColor:[UIColor whiteColor]];
    if (_DataModel.showBottom) {
        [self.refundIV setFrame:CGRectMake(Width(15),self.backGroudView.frame.size.height+ Height(10), 22, 22)];
        [self.refundDescLab setFrame:CGRectMake(Width(20)+22,self.backGroudView.frame.size.height +Height(15), 150, 12)];
        [self.totalPriceLab setFrame:CGRectMake(0, self.backGroudView.frame.size.height+Height(15), kScreen_Width-Width(15), 12)];
    }
    else
    {
        [self.refundIV setFrame:CGRectZero];
        [self.refundDescLab setFrame:CGRectZero];
        [self.totalPriceLab setFrame:CGRectZero];
    }
}
//无属性商品布局
-(void)layoutNoAttributeSubviews
{
    [self.backGroudView setFrame:CGRectMake(0, 0, kScreen_Width, 100)];
    [self.singleRefundBut setFrame:CGRectZero];
    //判断状态选择是否展示退款按钮 0：代付款 1：待收货 dingdantype 用于判断是否是退款订单
    CGSize refundSize=[self.RefundStr sizeWithFont:KNSFONTM(9) maxSize:CGSizeMake(200, 10)];
    if (
        !_DataModel.isSingle&&![_DataModel.dingDanType isEqualToString:@"refundType"]&&
        ([_DataModel.status isEqualToString:@"0"]||[_DataModel.status isEqualToString:@"1"]
         ||[_DataModel.status isEqualToString:@"3"]||[_DataModel.status isEqualToString:@"4"]||[_DataModel.status isEqualToString:@"5"]||[_DataModel.status isEqualToString:@"6"]||[_DataModel.status isEqualToString:@"10"]||[_DataModel.status isEqualToString:@"11"]||([_DataModel.status isEqualToString:@"2"]&&([_DataModel.refund_count integerValue]>2||[_DataModel.return_goods_count integerValue]>2)))) {
        [self.backGroudView setFrame:CGRectMake(0, 0, kScreen_Width, 120)];
        [self.singleRefundBut setFrame:CGRectMake(kScreen_Width-Width(15)-(refundSize.width+20), 96, refundSize.width+20, 15)];
        [self.singleRefundBut.layer setCornerRadius:7.5];
        [self.singleRefundBut.layer setBorderColor:[RGB(51, 51, 51) CGColor]];
        [self.singleRefundBut.layer setBorderWidth:1];
    }
    //退款列表
    if (!_DataModel.isSingle&&[_DataModel.dingDanType isEqualToString:@"refundType"]) {
        [self.backGroudView setFrame:CGRectMake(0, 0, kScreen_Width, 120)];
        [self.singleRefundBut setTitleColor:RGB(255, 93, 94) forState:UIControlStateNormal];
        [self.singleRefundBut setFrame:CGRectMake(kScreen_Width-Width(15)-(refundSize.width+20), 96, refundSize.width+20, 15)];
        [self.singleRefundBut.layer setCornerRadius:7.5];
        [self.singleRefundBut.layer setBorderColor:[RGB(255, 93, 94) CGColor]];
        [self.singleRefundBut.layer setBorderWidth:1];
    }
    [self.ActivityIV setFrame:CGRectZero];
    if ([_DataModel.order_type isEqualToString:@"9"]) {
        NSString *timestr=@"";
        if (_DataModel.getdate.length>7) {
            timestr=[_DataModel.getdate substringToIndex:7];
            YLog(@"%@",timestr);
        }

        if ([timestr isEqualToString:@"2017-10"]) {
            [self.ActivityIV setFrame:CGRectMake(0, 0, 36, 42)];
            // [self.ActivityIV setImage:KImage(@"activ_logo")];
        }else if ([timestr isEqualToString:@"2017-06"])
        {
            [self.ActivityIV setFrame:CGRectMake(0, 0, 36, 42)];
            // [self.ActivityIV setImage:KImage(@"activ_logo1")];
        }else if([timestr isEqualToString:@"2017-11"])
        {

            // [self.ActivityIV setImage:KImage(@"activ_logo2")];
            [self.ActivityIV setFrame:CGRectMake(0, 0, 36, 42)];
        }




    }
    [self.imageView setFrame:CGRectMake(Width(15), 15, 70, 70)];
    [self.imageView.layer setCornerRadius:3];
    [self.attrbuteLab setFrame:CGRectMake(Width(28)+70, 44, kScreen_Width-Width(28)-70-15, 30)];

    [self.priceLab setFrame:CGRectMake(Width(28)+70, 65, kScreen_Width-Width(28)-70-15, 12)];


    [self.goodsNumberLab setFrame:CGRectMake(kScreen_Width-Width(15)-30, 68, 30, 11)];

    CGSize nameLabSize=[_DataModel.name sizeWithFont:KNSFONTM(12) maxSize:CGSizeMake(kScreen_Width-Width(28)-70-15, 34)];

    self.goodsNameLab.frame=CGRectMake(Width(28)+70, 22, nameLabSize.width, nameLabSize.height);


    [self.contentView setBackgroundColor:[UIColor whiteColor]];
    if (_DataModel.showBottom) {
    [self.refundIV setFrame:CGRectMake(Width(15),self.backGroudView.frame.size.height+ Height(10), 22, 22)];
    [self.refundDescLab setFrame:CGRectMake(Width(20)+22,self.backGroudView.frame.size.height +Height(15), 150, 12)];
    [self.totalPriceLab setFrame:CGRectMake(0, self.backGroudView.frame.size.height+Height(15), kScreen_Width-Width(15), 12)];
    }
    else
    {
        [self.refundIV setFrame:CGRectZero];
        [self.refundDescLab setFrame:CGRectZero];
        [self.totalPriceLab setFrame:CGRectZero];
    }
}

-(void)loadData:(XLShoppingModel *)model
{
    _DataModel=model;

    [self.imageView sd_setImageWithURL:KNSURL(_DataModel.scopeimg) placeholderImage:KImage(@"default_image") options:SDWebImageProgressiveDownload];

    self.goodsNameLab.text=_DataModel.name;

    self.attrbuteLab.text=_DataModel.attribute_str;


    if ([_DataModel.dingDanType isEqualToString:@"refundType"]) {
        self.priceLab.text=@"";
    }else
    {
        self.priceLab.text=[NSString stringWithFormat:@"￥%@+%@积分",_DataModel.pay_money,_DataModel.pay_integer];
    }
    self.goodsNumberLab.text=[NSString stringWithFormat:@"x%@",_DataModel.number];

    NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:_priceLab.text];
    //
    NSRange range = [_priceLab.text rangeOfString:@"￥"];
    NSRange range1 = [_priceLab.text rangeOfString:@"+"];
    NSRange range2 = [_priceLab.text rangeOfString:@"积分"];

    [mAttStri addAttribute:NSFontAttributeName value:KNSFONTM(9) range:range];
    [mAttStri addAttribute:NSFontAttributeName value:KNSFONTM(9) range:range1];
    [mAttStri addAttribute:NSFontAttributeName value:KNSFONTM(9) range:range2];

    _priceLab.attributedText=mAttStri;

    switch ([_DataModel.status integerValue]) {
        case 0:
            self.RefundStr=@"退款";
            break;
        case 1:
            self.RefundStr=@"退款/退货";
            break;
        case 3:
            self.RefundStr=@"已退款";
            break;
        case 4:
            self.RefundStr=@"退款退货中";
            break;
        case 11:
            self.RefundStr=@"仅退款中";
            break;
        case 5:
            self.RefundStr=@"已退款退货";
            break;
        case 10:
            self.RefundStr=@"已仅退款";
            break;
        case 6:
            self.RefundStr=@"退款中";
            break;
        case 2:
            self.RefundStr=@"申请记录";
            break;
        default:
          self.RefundStr=@"";
            break;
    }

    if ([_DataModel.totalStatus isEqualToString:@"2"]) {
        self.RefundStr=@"申请记录";
    }


    if ([_DataModel.dingDanType isEqualToString:@"refundType"]) {
        self.RefundStr=@"查看详情";
    }

        [self.singleRefundBut setTitle:self.RefundStr forState:UIControlStateNormal];

    if ([_DataModel.order_type isEqualToString:@"9"]) {
        NSString *timestr=@"";
        if (_DataModel.getdate.length>7) {
            timestr=[_DataModel.getdate substringToIndex:7];
            YLog(@"%@",timestr);
        }

        if ([timestr isEqualToString:@"2017-10"]) {
            [self.ActivityIV setImage:KImage(@"activ_logo")];
        }else if ([timestr isEqualToString:@"2017-06"])
        {
        [self.ActivityIV setImage:KImage(@"activ_logo1")];

        }else if([timestr isEqualToString:@"2017-11"])
        {
        [self.ActivityIV setImage:KImage(@"activ_logo2")];
        }

    }

    if (_DataModel.showBottom) {

    self.totalPriceLab.text=[NSString stringWithFormat:@"退款金额：￥%@+%@积分",_DataModel.total_money,_DataModel.total_integral];

    NSString *colorStr=[NSString stringWithFormat:@"￥%@+%@积分",_DataModel.total_money,_DataModel.total_integral];
    NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:_totalPriceLab.text];
    //
    NSRange range = [_totalPriceLab.text rangeOfString:colorStr];

    [mAttStri addAttribute:NSFontAttributeName value:KNSFONTM(14) range:range];
    [mAttStri addAttribute:NSForegroundColorAttributeName value:RGB(63, 139, 253) range:range];

    _totalPriceLab.attributedText=mAttStri;


//    [self.lineView setImage:KImage(@"分割线-拷贝")];

    NSString *statusDescStr=@"退款中";
    NSString *ivName=@"icon_Refundreturns";
    //    3:    已退款，交易关闭
    //
    //
    //    4  和  11:    退款退货中
    //
    //    5  和  10:    已退款退货，交易关闭
    //
    //    6:    退款中
    switch ([_DataModel.status integerValue]) {
        case 3:
            statusDescStr=@"退款成功";
            self.totalPriceLab.hidden=NO;
            ivName=@"icon_Successfulrefund";
            break;
        case 4:
            statusDescStr=@"退款退货中";
            self.totalPriceLab.hidden=YES;
            ivName=@"icon_INRefund";
            break;
        case 5:
            statusDescStr=@"退款退货成功";
            self.totalPriceLab.hidden=NO;
            ivName=@"icon_Successfulrefund";
            break;
        case 6:
            statusDescStr=@"退款中";
            self.totalPriceLab.hidden=YES;
            ivName=@"icon_INRefund";
            break;
        case 10:
            statusDescStr=@"仅退款成功";
            self.totalPriceLab.hidden=NO;
            ivName=@"icon_Successfulrefund";
            break;
        case 11:
            statusDescStr=@"仅退款中";
            self.totalPriceLab.hidden=YES;
            ivName=@"icon_INRefund";
            break;
        default:
            break;
    }
    [self.refundDescLab setText:statusDescStr];
    [self.refundIV setImage:KImage(ivName)];
    }
}

-(void)refundSingleShoppingButClick:(UIButton *)sender
{
    if (_delegate&&[_delegate respondsToSelector:@selector(refundSingleShoppingWithModel: Cell:)]) {
        [_delegate refundSingleShoppingWithModel:_DataModel Cell:self];
    }
}


- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];

}

@end
