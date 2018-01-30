//
//  HomeDPListCell.m
//  aTaohMall
//
//  Created by Hawky on 2017/12/30.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "HomeDPListCell.h"

@implementation HomeDPListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpSubviews];
    }
    return self;
}



-(void)setUpSubviews
{
    [self.contentView setBackgroundColor:[UIColor whiteColor]];

    self.TitleIV =[[UIImageView alloc] init];
    [self.contentView addSubview:self.TitleIV];

    self.DPNameLab=[[UILabel alloc] init];
    [self.DPNameLab setFont:KNSFONT(15)];
    [self.DPNameLab setTextColor:RGB(51, 51, 51)];
    [self.contentView addSubview:self.DPNameLab];

    self.lineIV =[[UIImageView alloc] init];
    [self.contentView addSubview:self.lineIV];

    self.DPBut=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.contentView addSubview:self.DPBut];



    self.shortLineIV =[[UIImageView alloc] init];
    [self.contentView addSubview:self.shortLineIV];

    self.good1IV=[[UIImageView alloc] init];
    [self.contentView addSubview:self.good1IV];

    self.good1But=[UIButton buttonWithType:UIButtonTypeCustom];
    self.good1But.tag=200;
    [self.contentView addSubview:self.good1But];

    self.good2IV=[[UIImageView alloc] init];
    [self.contentView addSubview:self.good2IV];


    self.good2But=[UIButton buttonWithType:UIButtonTypeCustom];
    self.good2But.tag=201;
    [self.contentView addSubview:self.good2But];

    self.good3IV=[[UIImageView alloc] init];
    [self.contentView addSubview:self.good3IV];


    self.good3But=[UIButton buttonWithType:UIButtonTypeCustom];
    self.good3But.tag=202;
    [self.contentView addSubview:self.good3But];

    [self.DPBut addTarget:self action:@selector(DPButClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.good3But addTarget:self action:@selector(GoodsButClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.good2But addTarget:self action:@selector(GoodsButClick:) forControlEvents:UIControlEventTouchUpInside];
     [self.good1But addTarget:self action:@selector(GoodsButClick:) forControlEvents:UIControlEventTouchUpInside];
}


-(void)layoutSubviews
{
    [super layoutSubviews];

//    [self.contentView setFrame:CGRectMake(Width(5), 0, kScreenWidth-Width(10), )];
    CGFloat height=0;
    [self.TitleIV setFrame:CGRectMake(0, 0, kScreenWidth-Width(10), 80*(kScreenWidth-10)/365)];
    height+=self.TitleIV.frame.size.height+Height(10);

    [self.DPNameLab setFrame:CGRectMake(Width(10), height, kScreenWidth-Width(30), 15)];
    height+=self.DPNameLab.frame.size.height+Height(10);

    [self.DPBut setFrame:CGRectMake(0, 0, kScreenWidth-Width(10), height)];


    [self.shortLineIV setFrame:CGRectZero];
    [self.good1IV setFrame:CGRectZero];
    [self.good2IV setFrame:CGRectZero];
    [self.good3IV setFrame:CGRectZero];
    [self.good1But setFrame:CGRectZero];
    [self.good2But setFrame:CGRectZero];
    [self.good3But setFrame:CGRectZero];


    if (_DataModel.good_list.count>0) {

        [self.shortLineIV setFrame:CGRectMake(Width(10), height, kScreenWidth-Width(30), 1)];
        height+=1+Height(10);
        CGFloat padding=(kScreenWidth-Width(10)-80*3)/3;

        CGFloat butwidth=80+padding;

        [self.good1IV setFrame:CGRectMake(padding/2, height, 80, 80)];
        [self.good1But setFrame:CGRectMake(padding/2, height, 80, 80)];


        if (_DataModel.good_list.count>1) {
            [self.good2IV setFrame:CGRectMake(padding/2+butwidth, height, 80, 80)];
            [self.good2But setFrame:CGRectMake(padding/2+butwidth, height, 80, 80)];

        }
        if (_DataModel.good_list.count>2) {
            [self.good3IV setFrame:CGRectMake(padding/2+2*butwidth, height, 80, 80)];
            [self.good3But setFrame:CGRectMake(padding/2+2*butwidth, height, 80, 80)];

        }
        height+=80+Height(10);
    }


    [self.lineIV setFrame:CGRectMake(0, height, kScreenWidth-Width(10), 1)];
    height+=1;
    [self.contentView setFrame:CGRectMake(Width(5), 0, kScreenWidth-Width(10), height)];

}

-(void)setDataModel:(HomeDPModel *)DataModel
{
    _DataModel=DataModel;
    [self.TitleIV sd_setImageWithURL:KNSURL(_DataModel.picpath) placeholderImage:KImage(@"default_image") options:SDWebImageProgressiveDownload];

    [self.DPNameLab setText:_DataModel.represent];
    [self.lineIV setImage:KImage(@"分割线-拷贝")];

    [self.shortLineIV setImage:KImage(@"分割线-拷贝")];

    for (int i=0; i<_DataModel.good_list.count; i++) {
        AllSingleShoppingModel *model=_DataModel.good_list[i];
        if (i==0) {
            [self.good1IV sd_setImageWithURL:KNSURL(model.scopeimg) placeholderImage:KImage(@"default_image") options:SDWebImageProgressiveDownload];
        }
        if (i==1) {
            [self.good2IV sd_setImageWithURL:KNSURL(model.scopeimg) placeholderImage:KImage(@"default_image") options:SDWebImageProgressiveDownload];
        }
        if (i==2) {
            [self.good3IV sd_setImageWithURL:KNSURL(model.scopeimg) placeholderImage:KImage(@"default_image") options:SDWebImageProgressiveDownload];
        }
    }
}

-(void)DPButClick:(UIButton *)sender
{
    if (_delegate&&[_delegate respondsToSelector:@selector(HomeDpButClickWithModel:)]) {
        [_delegate HomeDpButClickWithModel:_DataModel];
    }
}

-(void)GoodsButClick:(UIButton *)sender
{
    AllSingleShoppingModel *model=_DataModel.good_list[sender.tag-200];
    if (_delegate&&[_delegate respondsToSelector:@selector(HomeGoodsButClickWithModel:)]) {
        [_delegate HomeGoodsButClickWithModel:model];
    }
}





- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
