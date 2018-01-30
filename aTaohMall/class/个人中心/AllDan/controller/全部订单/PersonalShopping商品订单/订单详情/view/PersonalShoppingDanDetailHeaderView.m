//
//  PersonalShoppingDanDetailHeaderView.m
//  aTaohMall
//
//  Created by DingDing on 2017/11/7.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "PersonalShoppingDanDetailHeaderView.h"
@interface PersonalShoppingDanDetailHeaderView()
{
    NSString *statusStr;
    NSString *statusIVName;
}
@property (nonatomic,strong)PersonalShoppingDanDetailModel *dataModel;

/*
顶部状态视图
 */
@property (nonatomic,strong)UIImageView *topBackIV;

@property (nonatomic,strong)UIImageView *topStatusIV;

@property (nonatomic,strong)UILabel *topStatusLab;
/*
物流信息
 */
@property (nonatomic,strong)UIImageView *logisticsIV;

@property (nonatomic,strong)UILabel *logisticsStatusLab;

@property (nonatomic,strong)UILabel *logisticsTimeLab;

@property (nonatomic,strong)UIImageView *moreLogisticsIV;

@property (nonatomic,strong)UIButton *checkLogisticsBut;

@property (nonatomic,strong)UIImageView *logisticsLine;
/*
收货人信息
 */
@property (nonatomic,strong)UILabel *receiverNameLab;

@property (nonatomic,strong)UILabel *receiverPhoneLab;

@property (nonatomic,strong)UILabel *receiveAddressLab;

@property (nonatomic,strong)UIImageView *receiveAddressIV;


/*
买家留言
 */
@property (nonatomic,strong)UIImageView *line;

@property (nonatomic,strong)UILabel *buyerMessageTitleLab;

@property (nonatomic,strong)UIImageView *buyerMessageIV;

@property (nonatomic,strong)UILabel *buyerMessageLab;

@property (nonatomic,strong)UIView *fengeView;
/*
店铺
 */
@property (nonatomic,strong)UIButton *storeDetailBut;

@property (nonatomic,strong)UIImageView *storeNameIV;

@property (nonatomic,strong)UILabel *storeNameLab;

@property (nonatomic,strong)UIImageView *moreIV;



@property (nonatomic,strong)UIImage *BackImage;

@end
@implementation PersonalShoppingDanDetailHeaderView
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        //在这里向contentView添加控件
        [self setUpSubviews];
    }

    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        [self setUpSubviews];
    }
    return self;
}

-(void)setUpSubviews
{
  //  self.userInteractionEnabled=YES;
    [self.contentView setBackgroundColor:[UIColor whiteColor]];

/*
顶部状态
 */
    self.topBackIV=[[UIImageView alloc] init];
    [self.contentView addSubview:self.topBackIV];

    self.topStatusIV=[[UIImageView alloc] init];
    [self.topBackIV addSubview:self.topStatusIV];

    self.topStatusLab=[[UILabel alloc]init];
    [self.topStatusLab setFont:KNSFONTM(17)];
    [self.topStatusLab setTextColor:RGB(255, 161, 92)];
    [self.topBackIV addSubview:self.topStatusLab];
/*
物流信息
 */
    self.logisticsIV=[[UIImageView alloc]init];
    [self.contentView addSubview:self.logisticsIV];

    self.logisticsStatusLab=[[UILabel alloc]init];
    [self.logisticsStatusLab setFont:KNSFONTM(12)];
    [self.logisticsStatusLab setTextColor:RGB(255, 52, 90)];
    [self.logisticsStatusLab setNumberOfLines:0];
    [self.contentView addSubview:self.logisticsStatusLab];

    self.logisticsTimeLab=[[UILabel alloc] init];
    [self.logisticsTimeLab setFont:KNSFONTM(12)];
    [self.logisticsTimeLab setTextColor:RGB(153, 153, 153)];
    [self.contentView addSubview:self.logisticsTimeLab];

    self.moreLogisticsIV=[[UIImageView alloc] init];
    [self.contentView addSubview:self.moreLogisticsIV];

    self.checkLogisticsBut=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.contentView addSubview:self.checkLogisticsBut];

    self.logisticsLine=[[UIImageView alloc] init];
    [self.contentView addSubview:self.logisticsLine];
/*
收货人信息
 */
    self.receiverNameLab=[[UILabel alloc]init];
    [self.receiverNameLab setFont:KNSFONTM(14)];
    [self.receiverNameLab setTextColor:RGB(51, 51, 51)];
    [self.contentView addSubview:self.receiverNameLab];

    self.receiverPhoneLab=[[UILabel alloc]init];
    [self.receiverPhoneLab setFont:KNSFONTM(14)];
    [self.receiverPhoneLab setTextColor:RGB(51, 51, 51)];
    [self.contentView addSubview:self.receiverPhoneLab];

    self.receiveAddressIV=[[UIImageView alloc] init];
    [self.contentView addSubview:self.receiveAddressIV];

    self.receiveAddressLab=[[UILabel alloc] init];
    [self.receiveAddressLab setFont:KNSFONTM(12)];
    [self.receiveAddressLab setNumberOfLines:0];
    [self.receiveAddressLab setTextColor:RGB(51, 51, 51)];
    [self.contentView addSubview:self.receiveAddressLab];

/*
买家留言
 */
    self.buyerMessageTitleLab=[[UILabel alloc]init];
    [self.buyerMessageTitleLab setFont:KNSFONTM(14)];
    [self.buyerMessageTitleLab setTextColor:RGB(51, 51, 51)];
    [self.contentView addSubview:self.buyerMessageTitleLab];

    self.buyerMessageIV=[[UIImageView alloc] init];
    [self.contentView addSubview:self.buyerMessageIV];

    self.buyerMessageLab=[[UILabel alloc]init];
    [self.buyerMessageLab setFont:KNSFONTM(12)];
    [self.buyerMessageLab setNumberOfLines:0];
    [self.buyerMessageLab setTextColor:RGB(51, 51, 51)];
    [self.contentView addSubview:self.buyerMessageLab];

    self.fengeView=[[UIView alloc] init];
    [self.fengeView setBackgroundColor:RGB(244, 244, 244)];
    [self.contentView addSubview:self.fengeView];

   self.line=[[UIImageView alloc ] init];
    [self.contentView addSubview:self.line];
/*
店铺
 */
    self.storeNameIV=[[UIImageView alloc] init];
    [self.contentView addSubview:self.storeNameIV];

    self.storeNameLab=[[UILabel alloc] init];
    [self.storeNameLab setFont:KNSFONTM(14)];
    [self.storeNameLab setTextColor:RGB(51, 51, 51)];
    [self.contentView addSubview:self.storeNameLab];

    self.moreIV=[[UIImageView alloc] init];
    [self.contentView addSubview:self.moreIV];

    self.storeDetailBut=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.contentView addSubview:self.storeDetailBut];

}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat height=0;
/*
 顶部状态视图
 */
    [self.topBackIV setFrame:CGRectMake(0, height, kScreen_Width, Height(92))];
    CGSize statusSize=[statusStr sizeWithFont:KNSFONTM(17) maxSize:CGSizeMake(kScreen_Width, 17)];
    [self.topStatusIV setFrame:CGRectMake((kScreen_Width-30-statusSize.width-Width(10))/2.0, (Height(92)-30)/2.0, 30, 30)];
    [self.topStatusIV setContentMode:UIViewContentModeScaleAspectFit];
    [self.topStatusLab setFrame:CGRectMake((kScreen_Width-30-statusSize.width-Width(10))/2.0+30+Width(10), (Height(92)-15)/2.0-4, statusSize.width, statusSize.height)];

    height+=Height(92);
/*
物流信息
 */
    [self.logisticsIV setFrame:CGRectZero];
    [self.logisticsStatusLab setFrame:CGRectZero];
    [self.logisticsTimeLab setFrame:CGRectZero];
    [self.moreLogisticsIV setFrame:CGRectZero];
    [self.checkLogisticsBut setFrame:CGRectZero];
    [self.logisticsLine setFrame:CGRectZero];
    if ([_dataModel.total_status isEqualToString:@"1"]||[_dataModel.total_status isEqualToString:@"2"]) {

        CGSize logisticsSize=[_dataModel.logistics_message sizeWithFont:KNSFONTM(12) maxSize:CGSizeMake(kScreen_Width-Width(50), 32)];

        CGFloat top=(Height(80)-logisticsSize.height-Height(13)-12)/2.0;

        [self.logisticsStatusLab setFrame:CGRectMake(Width(35), top+height-5, logisticsSize.width, logisticsSize.height)];

        [self.logisticsIV setFrame:CGRectMake(Width(15), top-4+height, 16, 15)];

        [self.logisticsTimeLab setFrame:CGRectMake(Width(15), Height(80)-top-12+height, 240, 12)];

        [self.moreLogisticsIV setFrame:CGRectMake(kScreen_Width-Width(15)-8, (Height(80)-13)/2+height, 8, 13)];

        [self.logisticsLine setFrame:CGRectMake(0, Height(80)-1+height, kScreen_Width, 1)];

        [self.checkLogisticsBut setFrame:CGRectMake(0, height, kScreen_Width, Height(80))];

        [self.checkLogisticsBut addTarget:self action:@selector(checkLogisticsButClick:) forControlEvents:UIControlEventTouchUpInside];

        height+=Height(80);
    }

/*
收货人信息视图
 */
    [self.receiverNameLab setFrame:CGRectMake(Width(35),height+Height(14), kScreen_Width-Width(35)-Width(15)-100, 14)];
    [self.receiverPhoneLab setFrame:CGRectMake(kScreen_Width-Width(15)-100, height+Height(14), 100, 14)];
   // NSString *addressStr=[NSString stringWithFormat:@"收货地址:%@",@"中华人民共和国中央人民政府在今天成立了，最是那一低头的温柔，像一朵水莲花不胜凉风的娇羞"];
    NSString *addressStr=[NSString stringWithFormat:@"收货地址:%@",_dataModel.uaddress];
    CGSize addressSize=[addressStr sizeWithFont:KNSFONTM(12) maxSize:CGSizeMake(kScreen_Width-Width(50), 34)];
    CGRect addressRect=CGRectMake(Width(35),height+Height(80)-(Height(80) - Height(28) - 14 -addressSize.height)/2.0-addressSize.height-4, addressSize.width, addressSize.height);
    YLog(@"%@",_dataModel.uaddress);
    [self.receiveAddressLab setFrame:addressRect];
    [self.receiveAddressIV setFrame:CGRectMake(Width(15),addressRect.origin.y+(addressRect.size.height-17)/2.0, 14, 17)];

    height+=Height(80);
    [self.line setFrame:CGRectMake(0, height-1, kScreen_Width, 1)];
/*
留言视图
 */
    [self.buyerMessageTitleLab setFrame:CGRectZero];
    [self.buyerMessageLab setFrame:CGRectZero];
    [self.buyerMessageIV setFrame:CGRectZero];
    if (!([_dataModel.buyer_message isEqualToString:@""]||[_dataModel.buyer_message containsString:@"null"])) {

        CGSize messageSize=[_dataModel.buyer_message sizeWithFont:KNSFONTM(12) maxSize:CGSizeMake(kScreen_Width-Width(50), MAXFLOAT)];

        CGRect messageRect=CGRectMake(Width(35), height+Height(80)-34+messageSize.height-(Height(80)-34+messageSize.height - Height(28) - 14 -messageSize.height)/2.0-messageSize.height-4, messageSize.width, messageSize.height);



        [self.buyerMessageTitleLab setFrame:CGRectMake(Width(35),height+Height(14), kScreen_Width-Width(35)-Width(15)-100, 14)];

        [self.buyerMessageLab setFrame:messageRect];
        
        [self.buyerMessageIV setFrame:CGRectMake(Width(15),messageRect.origin.y+4, 13, 13)];

        height+=Height(80)-34+messageSize.height;
    }

//分割线
    [self.fengeView setFrame:CGRectMake(0, height, kScreen_Width, Height(10))];

    height+=Height(10);
/*
进店看看视图
 */
    [self.storeNameIV setFrame:CGRectMake(Width(15),height+Height(14), 15, 14)];
    CGSize storeNameSize=[self.storeNameLab.text sizeWithFont:KNSFONTM(14) maxSize:CGSizeMake(kScreen_Width/2.0-Width(22)-15+60, 14)];
    [self.storeNameLab setFrame:CGRectMake(Width(22)+15,height+Height(14), storeNameSize.width, 14)];

    [self.moreIV setFrame:CGRectMake(Width(22)+15+storeNameSize.width+5, height+Height(17), 5, 9)];

    [self.storeDetailBut setFrame:CGRectMake(0, height, kScreen_Width, 14+Height(28))];

    [self.storeDetailBut addTarget:self action:@selector(storeDetailButClick:) forControlEvents:UIControlEventTouchUpInside];
    height+=Height(80);
}

-(void)loadData:(PersonalShoppingDanDetailModel *)model
{
    _dataModel=model;
/*
顶部状态
 */
    [self.topBackIV setImage:[self.BackImage getSubImage:CGRectMake(0, KSafeAreaTopNaviHeight, kScreen_Width, Height(92))]];
    switch ([model.total_status integerValue]) {
        case 0:
            statusStr=@"买家已付款";
            statusIVName=@"icon_Paymentalreadypaid";
            break;
        case 1:
            statusStr=@"卖家已发货";
            statusIVName=@"icon_Shipped";
            break;
        case 2:
            statusStr=@"交易成功";
            statusIVName=@"icon_Successfultrade";
            break;
        case 3:
            statusStr=@"已退款，交易关闭";
            statusIVName=@"icon_Transactionclosed";
            break;
        case 4:
            statusStr=@"退款退货中";
            statusIVName=@"icon_Refundandreturn";
            break;
        case 5:
            statusStr=@"已退款退货,交易关闭";
            statusIVName=@"icon_Transactionclosed";
            break;
        case 6:
            statusStr=@"退款中";
            statusIVName=@"icon_refound";
            break;
        case 7:
            statusStr=@"等待买家付款";
            statusIVName=@"icon_Pending-payment";
            break;
        case 8:
            statusStr=@"买家未付款,交易关闭";
            statusIVName=@"icon_Transactionclosed";
            break;
        case 9:
            statusStr=@"交易失败,订单关闭";
            statusIVName=@"icon_Transactionclosed";
            break;
        case 10:
            statusStr=@"已退款退货,交易关闭";
            statusIVName=@"icon_Transactionclosed";
            break;
        case 11:
            statusStr=@"退款退货中";
            statusIVName=@"icon_Refundandreturn";
            break;



        default:
            statusStr=@"";
            statusIVName=@"";
            break;
    }

    [self.topStatusIV setImage:KImage(statusIVName)];
    self.topStatusIV.contentMode=UIViewContentModeScaleAspectFit;
    [self.topStatusLab setText:statusStr];
/*
 物流信息
 */
    [self.logisticsStatusLab setText:_dataModel.logistics_message];
    [self.logisticsTimeLab setText:_dataModel.logistics_time];
    [self.logisticsIV setImage:KImage(@"icon_car_logistic")];
    [self.logisticsLine setImage:KImage(@"分割线-拷贝")];
    [self.moreLogisticsIV setImage:KImage(@"icon_more")];
/*
收货人信息
 */
    [self.receiverNameLab setText:[NSString stringWithFormat:@"收货人:%@",_dataModel.userName]];
    [self.receiverPhoneLab setText:_dataModel.uphone];

    [self.receiveAddressIV setImage:KImage(@"icon_address")];
    [self.receiveAddressLab setText:[NSString stringWithFormat:@"收货地址:%@",_dataModel.uaddress]];

    [self.line setImage:KImage(@"分割线-拷贝")];
/*
买家留言
 */
    [self.buyerMessageIV setImage:KImage(@"icon_message")];
    [self.buyerMessageTitleLab setText:@"买家留言"];
    [self.buyerMessageLab setText:_dataModel.buyer_message];
/*
店铺
 */
    [self.storeNameIV sd_setImageWithURL:KNSURL(_dataModel.logo) placeholderImage:KImage(@"店铺111")];
    [self.storeNameLab setText:_dataModel.storename];
    [self.moreIV setImage:KImage(@"icon_more")];
    
}


-(void)storeDetailButClick:(UIButton *)sender
{

    if (_delegate&&[_delegate respondsToSelector:@selector(checkStoreDetailWithModel:)]) {
        [_delegate checkStoreDetailWithModel:_dataModel];
    }
}

-(void)checkLogisticsButClick:(UIButton *)sender
{
    if (_delegate&&[_delegate respondsToSelector:@selector(checkLogisticsInfoWithModel:)]) {
        [_delegate checkLogisticsInfoWithModel:_dataModel];
    }
}


-(UIImage *)BackImage
{
    if (!_BackImage) {
        _BackImage=[UIImage imageWithImageView:CGRectMake(0, 0, kScreen_Width, KSafeAreaTopNaviHeight+Height(92)) StartColor:RGB(255, 52, 90) EndColor:RGB(255, 93, 94) startPoint:CGPointMake(0, 0) endPoint:CGPointMake(0, KSafeAreaTopNaviHeight+Height(92))];
    }
    return _BackImage;
}

@end
