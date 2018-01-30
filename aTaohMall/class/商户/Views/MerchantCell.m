//
//  MerchantCell.m
//  aTaohMall
//
//  Created by JMSHT on 2017/3/7.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "MerchantCell.h"

#define CellHeight 100
@implementation MerchantCell

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
    
    self.ShopImgView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 80, 80)];
    
    self.ShopImgView.image = [UIImage imageNamed:@"BGYT"];
    
    [self addSubview:self.ShopImgView];
    
    
    self.ShopNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(15+80+15, 10, [UIScreen mainScreen].bounds.size.width-110-20, 20)];
    self.ShopNameLabel.text = @"品鉴茶艺店铺";
    self.ShopNameLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    self.ShopNameLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:14];
    
    [self addSubview:self.ShopNameLabel];
    
    
    self.ShopTypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(15+80+15, 30, [UIScreen mainScreen].bounds.size.width-110-20, 40)];
    
    self.ShopTypeLabel.numberOfLines=2;
    
    self.ShopTypeLabel.text = @"厚度被盗号VB的都是错的女的都打瞌睡女房地产女vdfvfvvvdvs";
    self.ShopTypeLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    self.ShopTypeLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
    
    [self addSubview:self.ShopTypeLabel];
    
    
    self.LookImgView = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-60, 76, 15, 8)];
    
    self.LookImgView.image = [UIImage imageNamed:@"浏览量"];
    
    [self addSubview:self.LookImgView];
    
    
    self.NumberLabel = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-70+32, 70, 70, 20)];
    
//    self.NumberLabel.backgroundColor = [UIColor orangeColor];
    
    self.NumberLabel.text = @"13456";
    self.NumberLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    self.NumberLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:10];
    
    [self addSubview:self.NumberLabel];
    
    
    UIImageView *fenge = [[UIImageView alloc] initWithFrame:CGRectMake(0, 99, [UIScreen mainScreen].bounds.size.width, 1)];
    
    fenge.image = [UIImage imageNamed:@"分割线-拷贝"];
    
    [self addSubview:fenge];
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 5)];
    //    bgView.backgroundColor = [UIColor colorWithRed:226/255.0 green:226/255.0 blue:226/255.0 alpha:1.0];
    
    bgView.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];
    
    [self addSubview:bgView];
    
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
