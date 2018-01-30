//
//  FenLeiCell.m
//  aTaohMall
//
//  Created by JMSHT on 2017/4/11.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "FenLeiCell.h"

#define KSWeidth 80

@implementation FenLeiCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self= [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self loadMyCell];
    }
    return self;
}

-(void)loadMyCell
{
    
    self.LogoImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, KSWeidth, KSWeidth)];

    self.LogoImgView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.LogoImgView.layer.borderWidth = 5;
    [self.LogoImgView.layer setMasksToBounds:YES];

    [self addSubview:self.LogoImgView];
    
    
//    self.NoImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10+(KSWeidth-60)/2, (KSWeidth-60)/2+10, 60, 60)];
//    self.NoImgView.image = [UIImage imageNamed:@"已售完new"];
//    [self addSubview:self.NoImgView];
    
    
    UIImageView *line1 = [[UIImageView alloc] initWithFrame:CGRectMake(9, 9, KSWeidth+2, 1)];
    
    line1.image = [UIImage imageNamed:@"分割线-拷贝"];
    
    [self addSubview:line1];
    
    UIImageView *line2 = [[UIImageView alloc] initWithFrame:CGRectMake(9, 9, 1, KSWeidth+2)];
    
    line2.image = [UIImage imageNamed:@"分割线YT"];
    
    [self addSubview:line2];
    
    
    UIImageView *line3 = [[UIImageView alloc] initWithFrame:CGRectMake(9, KSWeidth+10, KSWeidth+2, 1)];
    
    line3.image = [UIImage imageNamed:@"分割线-拷贝"];
    
    [self addSubview:line3];
    
    
    UIImageView *line4 = [[UIImageView alloc] initWithFrame:CGRectMake(KSWeidth+10, 9, 1, KSWeidth+2)];
    
    line4.image = [UIImage imageNamed:@"分割线YT"];
    
    [self addSubview:line4];
    
    
    
    self.NameLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSWeidth+26, 10, [UIScreen mainScreen].bounds.size.width-Width(80)-KSWeidth-26-15, 18)];
    self.NameLabel.text = @"开发那不v肯呢个福你把你的就发动机比女方家妇女反击吧";
    self.NameLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:13];
    self.NameLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
    self.NameLabel.numberOfLines=1;
    [self addSubview:self.NameLabel];

    self.PriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSWeidth+26, 10+18+10, [UIScreen mainScreen].bounds.size.width-Width(80)-KSWeidth-26, 15)];
    self.PriceLabel.text = @"￥130.00+100.00积分";
    self.PriceLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15];
    self.PriceLabel.textColor = [UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
    [self addSubview:self.PriceLabel];
    
    self.StoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSWeidth+26, 80, [UIScreen mainScreen].bounds.size.width-Width(80)-KSWeidth-26, 12)];
    self.StoreLabel.text = @"林家集团";
    self.StoreLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
    self.StoreLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    [self addSubview:self.StoreLabel];
    

    self.AmountLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth-Width(80)-65-15, 80, 65, 12)];
    self.AmountLabel.text = @"363人付款";
    self.AmountLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
    self.AmountLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    [self addSubview:self.AmountLabel];
    
    UIImageView *fenge = [[UIImageView alloc] initWithFrame:CGRectMake(0, 104, [UIScreen mainScreen].bounds.size.width-Width(80), 1)];
    
    fenge.image = [UIImage imageNamed:@"分割线-拷贝"];
    
    [self addSubview:fenge];
    
    
}

-(void)Status:(NSString *)status Stock:(NSString *)stock
{
    

    
}
-(void)setStock:(NSString *)stock
{
    
    _stock = stock;
    
    
    
    
}
-(void)setStatus:(NSString *)Status
{
    
    _Status = Status;
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
