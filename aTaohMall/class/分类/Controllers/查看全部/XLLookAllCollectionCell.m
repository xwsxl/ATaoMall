//
//  XLLookAllCollectionCell.m
//  aTaohMall
//
//  Created by Hawky on 2018/1/26.
//  Copyright © 2018年 ysy. All rights reserved.
//

#import "XLLookAllCollectionCell.h"

@implementation XLLookAllCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        [self loadMyCell];
    }
    return self;
}

-(void)loadMyCell{
    self.backgroundColor=[UIColor whiteColor];
    self.Goods_ImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Width(140), Width(140))];

    [self addSubview:self.Goods_ImgView];

    self.Goods_Name = [[UILabel alloc] initWithFrame:CGRectMake(Width(150), Width(11), kScreenWidth-Width(160), 40)];
    self.Goods_Name.text = @"fgvjhfbnfbnfjnb办法喝vid分vi发v方便就覅比发比防波堤";
    self.Goods_Name.numberOfLines = 2;
    self.Goods_Name.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    self.Goods_Name.textColor = [UIColor colorWithRed:74/255.0 green:74/255.0 blue:74/255.0 alpha:1.0];
    [self addSubview:self.Goods_Name];

    self.Goods_Price = [[UILabel alloc] initWithFrame:CGRectMake(Width(150), Width(70), kScreenWidth-Width(160), 20)];
    self.Goods_Price.text = @"￥10.00+10.00积分";
    self.Goods_Price.textColor = [UIColor colorWithRed:243/255.0 green:73/255.0 blue:73/255.0 alpha:1.0];
    self.Goods_Price.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:17];
    [self addSubview:self.Goods_Price];


    self.Goods_storename = [[UILabel alloc] initWithFrame:CGRectMake(Width(150), Width(114), kScreenWidth-Width(150)-Width(80), 16)];
    self.Goods_storename.text = @"林家集团";
    self.Goods_storename.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    self.Goods_storename.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
    [self addSubview:self.Goods_storename];

    self.Goods_Amount = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth-Width(75), Width(114), Width(65), 16)];
    self.Goods_Amount.text = @"3人付款";
    self.Goods_Amount.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    self.Goods_Amount.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
    [self addSubview:self.Goods_Amount];

    UIImageView *line3=[[UIImageView alloc] initWithFrame:CGRectMake(Width(150), Width(145)-1, kScreenWidth-Width(150), 1)];

    line3.image=[UIImage imageNamed:@"分割线-拷贝"];

    [self addSubview:line3];

}

-(void)setModel:(AllSingleShoppingModel *)model
{
    _model=model;
    [self.Goods_ImgView sd_setImageWithURL:KNSURL(model.scopeimg) placeholderImage:KImage(@"default_image") options:SDWebImageProgressiveDownload];
    [self.Goods_Name setText:model.name];
    [self.Goods_Price setText:[NSString stringWithFormat:@"￥%@+%@积分",model.pay_maney,model.pay_integer]];
    [self.Goods_storename setText:model.storename];
    [self.Goods_Amount setText:[NSString stringWithFormat:@"%@人付款",model.amount]];
}

@end
