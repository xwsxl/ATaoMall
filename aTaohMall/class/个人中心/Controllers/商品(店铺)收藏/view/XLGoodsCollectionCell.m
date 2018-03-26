//
//  XLGoodsCollectionCell.m
//  aTaohMall
//
//  Created by Hawky on 2018/3/9.
//  Copyright © 2018年 ysy. All rights reserved.
//

#import "XLGoodsCollectionCell.h"

@implementation XLGoodsCollectionCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpSubviews];
    }
    return self;
}

-(void)setUpSubviews
{
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    [self.contentView setBackgroundColor:[UIColor whiteColor]];
    self.shopIV=[[UIImageView alloc] init];
    [self.contentView addSubview:self.shopIV];

    self.unusedIV=[[UIImageView alloc] init];
    [self.contentView addSubview:self.unusedIV];

    self.goodsNameLab=[[UILabel alloc] init];
    [self.goodsNameLab setFont:KNSFONTM(12)];
    [self.goodsNameLab setTextColor:RGB(51, 51, 51)];
    [self.goodsNameLab setNumberOfLines:0];
    [self.contentView addSubview:self.goodsNameLab];

    self.priceLab=[[UILabel alloc] init];
    [self.priceLab setFont:KNSFONTM(12)];
    [self.priceLab setTextColor:RGB(255, 93, 94)];
    [self.contentView addSubview:self.priceLab];

    self.selectBut=[[UIButton alloc] init];
    self.selectBut.userInteractionEnabled=NO;
    [self.contentView addSubview:self.selectBut];


}

-(void)layoutSubviews
{
    if (_isEdit) {

        [self.selectBut setFrame:CGRectMake(Width(10), 0, 26, 100)];

        [self.shopIV setFrame:CGRectMake(Width(15)+26, 15, 70, 70)];

        [self.unusedIV setFrame:CGRectMake(Width(15)+5+26, 15+5, 60, 60)];

        [self.goodsNameLab setFrame:CGRectMake(Width(15)+70+Width(10)+26, 20, kScreen_Width-Width(40)-70-26, 40)];

        [self.priceLab setFrame:CGRectMake(Width(15)+70+Width(10)+26, 100-25-13, kScreen_Width-Width(40)-70-26, 13)];

    }else
    {
    [self.selectBut setFrame:CGRectZero];

    [self.shopIV setFrame:CGRectMake(Width(15), 15, 70, 70)];

    [self.unusedIV setFrame:CGRectMake(Width(15)+5, 15+5, 60, 60)];

    [self.goodsNameLab setFrame:CGRectMake(Width(15)+70+Width(10), 20, kScreen_Width-Width(40)-70, 40)];

    [self.priceLab setFrame:CGRectMake(Width(15)+70+Width(10), 100-25-13, kScreen_Width-Width(40)-70, 13)];
    }



}

-(void)setDataModel:(AllSingleShoppingModel *)dataModel
{
    _dataModel=dataModel;

    [self.shopIV sd_setImageWithURL:KNSURL(dataModel.scopeimg) placeholderImage:KImage(@"default_image") options:SDWebImageRetryFailed];
    [self.unusedIV setImage:KImage(@"13icon_invalidcommodities")];
    if ([dataModel.statu isEqualToString:@"1"]) {
        self.unusedIV.hidden=NO;
    }else
    {
        self.unusedIV.hidden=YES;
    }
    [self.goodsNameLab setText:dataModel.name];
    [self.priceLab setText:[NSString stringWithFormat:@"￥%@+%@积分",dataModel.pay_maney,dataModel.pay_integer]];

    [self.selectBut setImage:KImage(@"13btn_unselected") forState:UIControlStateNormal];

}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void)setIsEdit:(BOOL)isEdit
{
    _isEdit=isEdit;
}

@end
