//
//  PersonalShoppingSectionHeaderView.m
//  aTaohMall
//
//  Created by DingDing on 2017/11/4.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "PersonalShoppingSectionHeaderView.h"

@interface PersonalShoppingSectionHeaderView()

@property (nonatomic,strong)UIButton *storeDetailBut;

@property (nonatomic,strong)UIImageView *storeNameIV;

@property (nonatomic,strong)UILabel *storeNameLab;

@property (nonatomic,strong)UIImageView *moreIV;

@property (nonatomic,strong)UILabel *statusLab;

@property (nonatomic,strong)UIView *backGroudView;

@end


@implementation PersonalShoppingSectionHeaderView

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
   // [self setBackgroundColor:[UIColor whiteColor]];

    self.backGroudView=[[UIView alloc]init];

    self.backGroudView.backgroundColor = [UIColor whiteColor];

    [self addSubview:self.backGroudView];


    self.storeNameIV=[[UIImageView alloc] init];
    [self.backGroudView addSubview:self.storeNameIV];

    self.storeNameLab=[[UILabel alloc] init];
    [self.storeNameLab setFont:KNSFONTM(14)];
    [self.storeNameLab setTextColor:RGB(51, 51, 51)];
    [self.backGroudView addSubview:self.storeNameLab];

    self.moreIV=[[UIImageView alloc] init];
    [self.backGroudView addSubview:self.moreIV];

    self.statusLab=[[UILabel alloc] init];
    [self.statusLab setFont:KNSFONTM(14)];
    [self.statusLab setTextColor:RGB(255, 93, 94)];
    [self.backGroudView addSubview:self.statusLab];

    self.storeDetailBut=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.backGroudView addSubview:self.storeDetailBut];

}

-(void)layoutSubviews
{
    [super layoutSubviews];
    [_backGroudView setFrame:CGRectMake(0, 0, kScreen_Width, Height(28)+14)];

    [self.storeNameIV setFrame:CGRectMake(Width(15), Height(14), 15, 14)];

    CGSize storeNameSize=[self.storeNameLab.text sizeWithFont:KNSFONTM(14) maxSize:CGSizeMake(kScreen_Width/2.0-Width(22)-15+60, 14)];
    [self.storeNameLab setFrame:CGRectMake(Width(22)+15,Height(14), storeNameSize.width, 14)];

    [self.moreIV setFrame:CGRectMake(Width(22)+15+storeNameSize.width+5, Height(17), 5, 9)];

    CGSize statusSize=[self.statusLab.text sizeWithFont:KNSFONTM(14) maxSize:CGSizeMake(kScreen_Width, 14)];
    [self.statusLab setFrame:CGRectMake(kScreen_Width-Width(15)-statusSize.width,Height(14), statusSize.width, 14)];

    [self.storeDetailBut setFrame:CGRectMake(0, 0, kScreen_Width, 14+Height(28))];
    [self.storeDetailBut addTarget:self action:@selector(storeDetailButClick:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)setDataModel:(XLDingDanModel *)dataModel
{

    _dataModel=dataModel;
    [self.storeNameIV sd_setImageWithURL:KNSURL(_dataModel.logo) placeholderImage:KImage(@"店铺111")];

    [self.storeNameLab setText:_dataModel.storename];

    NSString *statusStr=@"";
    switch ([_dataModel.total_status integerValue]) {
        case 0:
            statusStr=@"待发货";
            break;
        case 1:
            statusStr=@"待收货";
            break;
        case 2:
            statusStr=@"交易完成";
            break;
        case 3:
            statusStr=@"交易关闭";
            break;
        case 4:
            statusStr=@"退款退货中";
            break;
        case 11:
            statusStr=@"退款退货中";
            break;
        case 5:
            statusStr=@"交易关闭";
            break;
        case 10:
            statusStr=@"交易关闭";
            break;
        case 6:
            statusStr=@"退款中";
            break;
        case 7:
            statusStr=@"待付款";
            break;
        case 8:
            statusStr=@"交易关闭";
            break;
        case 9:
            statusStr=@"支付异常";
            break;
        default:
            break;
    }

    if ([_dataModel.dingDanType isEqualToString:@"refundType"]) {
        statusStr=@"";
    }
    [self.moreIV setImage:KImage(@"icon_more")];

    [self.statusLab setText:statusStr];

}

-(void)storeDetailButClick:(UIButton *)sender
{
    if (_delegate&&[_delegate respondsToSelector:@selector(checkStoreDetailWithModel:)]) {
        [_delegate checkStoreDetailWithModel:_dataModel];
    }
}


@end
