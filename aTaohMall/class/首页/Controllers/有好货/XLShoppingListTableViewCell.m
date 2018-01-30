//
//  XLShoppingListTableViewCell.m
//  aTaohMall
//
//  Created by Hawky on 2017/12/28.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "XLShoppingListTableViewCell.h"

@interface XLShoppingListTableViewCell ()
@property (nonatomic,strong)UIImageView *shopIV;

@property (nonatomic,strong)UILabel *goodsNameLab;

@property (nonatomic,strong)UILabel *priceLab;

@property (nonatomic,strong)UILabel *storeNameLab;

@property (nonatomic,strong)UILabel *amountNumLab;

@property (nonatomic,strong)UIImageView *lineIV;


@end
@implementation XLShoppingListTableViewCell

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
    self.shopIV=[[UIImageView alloc] init];
    [self.contentView addSubview:self.shopIV];

    self.goodsNameLab=[[UILabel alloc] init];
    self.goodsNameLab.textAlignment=NSTextAlignmentLeft;
    self.goodsNameLab.textColor=RGB(51, 51, 51);
    self.goodsNameLab.font=KNSFONTM(14);
    self.goodsNameLab.numberOfLines=2;
    [self.contentView addSubview:self.goodsNameLab];

    self.priceLab=[[UILabel alloc] init];
    self.priceLab.textAlignment=NSTextAlignmentLeft;
    self.priceLab.textColor=RGB(255, 93, 94);
    self.priceLab.font=KNSFONTM(17);
    self.priceLab.numberOfLines=1;
    [self.contentView addSubview:self.priceLab];


    self.storeNameLab=[[UILabel alloc] init];
    self.storeNameLab.textAlignment=NSTextAlignmentLeft;
    self.storeNameLab.textColor=RGB(164, 164, 164);
    self.storeNameLab.numberOfLines=1;
    self.storeNameLab.font=KNSFONTM(13);
    [self.contentView addSubview:self.storeNameLab];

    self.amountNumLab=[[UILabel alloc] init];
    self.amountNumLab.textAlignment=NSTextAlignmentLeft;
    self.amountNumLab.textColor=RGB(164, 164, 164);
    self.amountNumLab.numberOfLines=1;
    self.amountNumLab.font=KNSFONTM(13);
    [self.contentView addSubview:self.amountNumLab];

    self.lineIV=[[UIImageView alloc] init];
    [self.contentView addSubview:self.lineIV];

}


-(void)layoutSubviews
{
    [super layoutSubviews];

    [self.contentView setBackgroundColor:[UIColor whiteColor]];

    CGFloat topPadding=Height(7.5);
    CGFloat leadingPadding=Width(15);




    [self.shopIV setFrame:CGRectMake(leadingPadding, topPadding, 105, 105)];

    [self.goodsNameLab setFrame:CGRectMake(105+2*leadingPadding, topPadding, kScreenWidth-105-3*leadingPadding, 44)];

    [self.priceLab setFrame:CGRectMake(105+2*leadingPadding, 3*topPadding+39, kScreenWidth-105-3*leadingPadding, 17)];
    [self.lineIV setFrame:CGRectMake(Width(15),104+Height(15), kScreen_Width-15, 1)];

    CGSize size=[self.amountNumLab.text sizeWithFont:KNSFONTM(14) maxSize:KMAXSIZE];
    [self.storeNameLab setFrame:CGRectMake(105+2*leadingPadding, topPadding+105-14, kScreenWidth-leadingPadding*3-Width(5)-size.width-105, 14)];
    [self.amountNumLab setFrame:CGRectMake(kScreenWidth-Width(15)-size.width, topPadding+105-14, size.width, 14)];

    if ([_DataModel.CELLTYPE isEqualToString:@"热销排行"]) {
        [self.storeNameLab setFrame:CGRectZero];
        [self.amountNumLab setFrame:CGRectZero];
    }


    
}



-(void)setDataModel:(AllSingleShoppingModel *)DataModel
{
    _DataModel=DataModel;

    [self.shopIV sd_setImageWithURL:KNSURL(_DataModel.scopeimg) placeholderImage:KImage(@"default_image") options:SDWebImageProgressiveDownload];

    [self.goodsNameLab setText:_DataModel.name];

    [self.priceLab setText:[NSString stringWithFormat:@"￥%@+%@积分",_DataModel.pay_maney,_DataModel.pay_integer]];
    NSString *stringForColor4 = @"积分";
    // 创建对象.
    NSMutableAttributedString *mAttStri4 = [[NSMutableAttributedString alloc] initWithString:self.priceLab.text];
    //
    NSRange range4 = [self.priceLab.text rangeOfString:stringForColor4];
    [mAttStri4 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Medium" size:14] range:range4];
    self.priceLab.attributedText=mAttStri4;

    [self.storeNameLab setText:_DataModel.storename];

    [self.amountNumLab setText:[NSString stringWithFormat:@"%@人付款",_DataModel.amount]];
    NSString *stringForColor = _DataModel.amount;
    // 创建对象.
    NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:self.amountNumLab.text];
    //
    NSRange range = [self.amountNumLab.text rangeOfString:stringForColor];
    [mAttStri addAttribute:NSForegroundColorAttributeName value:RGB(255, 82, 82) range:range];
    self.amountNumLab.attributedText=mAttStri;




    [self.lineIV setImage:KImage(@"分割线-拷贝")];


}


@end
