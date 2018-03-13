//
//  XLShopsCollectionCell.m
//  aTaohMall
//
//  Created by Hawky on 2018/3/9.
//  Copyright © 2018年 ysy. All rights reserved.
//

#import "XLShopsCollectionCell.h"

@implementation XLShopsCollectionCell
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

    self.moreIV=[[UIImageView alloc] init];
    [self.contentView addSubview:self.moreIV];

    self.shopsNameLab=[[UILabel alloc] init];
    [self.shopsNameLab setFont:KNSFONTM(12)];
    [self.shopsNameLab setNumberOfLines:0];
    [self.shopsNameLab setTextColor:RGB(51, 51, 51)];
    [self.contentView addSubview:self.shopsNameLab];

}

-(void)layoutSubviews
{

    [self.shopIV setFrame:CGRectMake(Width(15), 15, 70, 70)];

    [self.moreIV setFrame:CGRectMake(kScreen_Width-Width(15)-9, 42, 9, 16)];

    [self.shopsNameLab setFrame:CGRectMake(Width(15)+70+Width(10), 15, kScreen_Width-Width(40)-70-9-Width(5), 70)];

}

-(void)setDataModel:(MerchantModel *)dataModel
{
    _dataModel=dataModel;

    [self.shopIV sd_setImageWithURL:KNSURL(dataModel.logo) placeholderImage:KImage(@"default_image") options:SDWebImageRetryFailed];
    [self.moreIV setImage:KImage(@"13btn-enter")];

    [self.shopsNameLab setText:dataModel.storename];

}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
