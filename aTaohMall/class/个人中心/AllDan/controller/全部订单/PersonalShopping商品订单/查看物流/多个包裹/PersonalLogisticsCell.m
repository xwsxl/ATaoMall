//
//  PersonalLogisticsCell.m
//  aTaohMall
//
//  Created by Hawky on 2017/11/17.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "PersonalLogisticsCell.h"

@interface PersonalLogisticsCell ()

@property (nonatomic,strong)UIImageView *scopeimgIV;

@property (nonatomic,strong)UILabel *nameLab;

@property (nonatomic,strong)UILabel *statusDetailLab;

@property (nonatomic,strong)UILabel *statusLab;

@property (nonatomic,strong)UILabel *companyLab;

@property (nonatomic,strong)UILabel *goodsNumLab;

@end

@implementation PersonalLogisticsCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self SetUpSubviews];
    }
    return self;
}

-(void)SetUpSubviews
{
    _scopeimgIV=[[UIImageView alloc] init];
    [self.contentView addSubview:_scopeimgIV];

    _nameLab=[[UILabel alloc] init];
    [_nameLab setFont:KNSFONT(12)];
    [_nameLab setTextColor:RGB(51, 51, 51)];
    [self.contentView addSubview:_nameLab];

    _statusDetailLab=[[UILabel alloc] init];
    [_statusDetailLab setFont:KNSFONT(11)];
    [_statusDetailLab setTextColor:RGB(153, 153, 153)];
    [self.contentView addSubview:_statusDetailLab];

    _statusLab=[[UILabel alloc] init];
    [_statusLab setFont:KNSFONT(11)];
    [_statusLab setTextColor:RGB(255, 52, 90)];
    [self.contentView addSubview:_statusLab];

    _companyLab=[[UILabel alloc] init];
    [_companyLab setFont:KNSFONT(12)];
    [_companyLab setTextColor:RGB(153, 153, 153)];

    [self.contentView addSubview:_companyLab];


    _goodsNumLab=[[UILabel alloc] init];
    [_goodsNumLab setFont:KNSFONT(11)];
    [_goodsNumLab setBackgroundColor:RGBA(0, 0, 0, 0.4)];
    [_goodsNumLab setTextAlignment:NSTextAlignmentCenter];
    [_goodsNumLab setTextColor:RGB(255, 255, 255)];
    [_scopeimgIV addSubview:_goodsNumLab];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    [_companyLab setFrame:CGRectMake(Width(15), Height(10), kScreen_Width-Width(30), 12)];

    [_scopeimgIV setFrame:CGRectMake(15, Height(20)+12, 70, 70)];

    if ([_dataModel.goods_number integerValue]>1) {
        [_goodsNumLab setFrame:CGRectMake(0, 50, 70, 20)];
    }else
    {
        [_goodsNumLab setFrame:CGRectZero];
    }

    [_nameLab setFrame:CGRectMake(Width(25)+70, Height(24)+12, kScreen_Width-Width(40)-70, 12)];

    [_statusDetailLab setFrame:CGRectMake(Width(25)+70, Height(38)+12+12,kScreen_Width-Width(40)-70 , 12)];

    [_statusLab setFrame:CGRectMake(Width(25)+70, Height(52)+12+12+11, kScreen_Width-Width(40)-70, 11)];

}


-(void)setDataModel:(PersonalLogisticModel *)dataModel
{
    _dataModel=dataModel;
    [_scopeimgIV sd_setImageWithURL:KNSURL(_dataModel.scopeimg) placeholderImage:KImage(@"default_image") options:SDWebImageProgressiveDownload];
    [_goodsNumLab setText:[NSString stringWithFormat:@"%@种商品",_dataModel.goods_number]];
    [_statusLab setText:_dataModel.logistics_type];
    [_nameLab setText:_dataModel.name];
    [_companyLab setText:[NSString stringWithFormat:@"%@:  %@",_dataModel.company,_dataModel.waybillnumber]];
    YLog(@"%@",_dataModel.logistics_remark);
    [_statusDetailLab setText:_dataModel.logistics_remark];
}

@end
