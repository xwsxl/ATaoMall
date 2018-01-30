//
//  loadMoreCell.m
//  aTaohMall
//
//  Created by JMSHT on 2017/4/11.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "loadMoreCell.h"

#define KSWeidth [UIScreen mainScreen].bounds.size.width*0.453333

@implementation loadMoreCell

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
    
    self.LogoImgView = [[UIImageView alloc] initWithFrame:CGRectMake(16, 10, KSWeidth, KSWeidth)];
    
    self.LogoImgView.image = [UIImage imageNamed:@""];
    
    self.LogoImgView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.LogoImgView.layer.borderWidth = 5;
    [self.LogoImgView.layer setMasksToBounds:YES];
    
    [self addSubview:self.LogoImgView];
    
    
    
    UIImageView *line1 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 9, KSWeidth+2, 1)];
    
    line1.image = [UIImage imageNamed:@"分割线-拷贝"];
    
    [self addSubview:line1];
    
    UIImageView *line2 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 9, 1, KSWeidth+2)];
    
    line2.image = [UIImage imageNamed:@"分割线YT"];
    
    [self addSubview:line2];
    
    
    UIImageView *line3 = [[UIImageView alloc] initWithFrame:CGRectMake(15, KSWeidth+10, KSWeidth+2, 1)];
    
    line3.image = [UIImage imageNamed:@"分割线-拷贝"];
    
    [self addSubview:line3];
    
    
    UIImageView *line4 = [[UIImageView alloc] initWithFrame:CGRectMake(KSWeidth+16, 9, 1, KSWeidth+2)];
    
    line4.image = [UIImage imageNamed:@"分割线YT"];
    
    [self addSubview:line4];
    
    self.NameLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSWeidth+36, 21, [UIScreen mainScreen].bounds.size.width-KSWeidth-36-16, 40)];
    self.NameLabel.text = @"";
    self.NameLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    self.NameLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    self.NameLabel.numberOfLines=2;
    [self addSubview:self.NameLabel];
    
    self.StoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSWeidth+36, 70, [UIScreen mainScreen].bounds.size.width-KSWeidth-36-16, 12)];
    self.StoreLabel.text = @"";
    self.StoreLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
    self.StoreLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    [self addSubview:self.StoreLabel];
    
    
    self.PriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSWeidth+36, 101, [UIScreen mainScreen].bounds.size.width-KSWeidth-36-16, 13)];
    self.PriceLabel.text = @"";
    self.PriceLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    self.PriceLabel.textColor = [UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
    [self addSubview:self.PriceLabel];
    
    self.AmountLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSWeidth+36, 133, [UIScreen mainScreen].bounds.size.width-KSWeidth-36-16, 12)];
    self.AmountLabel.text = @"";
    self.AmountLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
    self.AmountLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    [self addSubview:self.AmountLabel];
    
    UIImageView *fenge = [[UIImageView alloc] initWithFrame:CGRectMake(KSWeidth+17, [UIScreen mainScreen].bounds.size.width*0.453333+15-1, [UIScreen mainScreen].bounds.size.width-KSWeidth-17, 1)];
    
    fenge.image = [UIImage imageNamed:@"分割线-拷贝"];
    
    [self addSubview:fenge];
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
