//
//  JXSelectCell.m
//  aTaohMall
//
//  Created by JMSHT on 2017/6/21.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "JXSelectCell.h"

@implementation JXSelectCell

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
    
    
    self.MainTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, [UIScreen mainScreen].bounds.size.width-20, 17.5)];
    self.MainTitle.text = @"蕾丝连衣裙，尽显大家闺秀淑女气质";
    self.MainTitle.numberOfLines = 1;
    self.MainTitle.textColor = [UIColor colorWithRed:70/255.0 green:70/255.0 blue:70/255.0 alpha:1.0];
    self.MainTitle.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:17];
    [self addSubview:self.MainTitle];
    
    self.OtherTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 33, [UIScreen mainScreen].bounds.size.width-20, 13.5)];
    self.OtherTitle.text = @"舒适优雅 尽显柔情";
    self.OtherTitle.textColor = [UIColor colorWithRed:164/255.0 green:164/255.0 blue:164/255.0 alpha:1.0];
    self.OtherTitle.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    [self addSubview:self.OtherTitle];
    
    self.OneImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 57, [UIScreen mainScreen].bounds.size.width-20, 134)];
    self.OneImgView.image = [UIImage imageNamed:@"BGYT"];
    [self addSubview:self.OneImgView];
    
//    self.TwoImgView = [[UIImageView alloc] initWithFrame:CGRectMake(20+([UIScreen mainScreen].bounds.size.width-40)/3, 60, ([UIScreen mainScreen].bounds.size.width-40)/3, 100)];
//    self.TwoImgView.image = [UIImage imageNamed:@"BGYT"];
//    [self addSubview:self.TwoImgView];
//    
//    self.ThreeImgView = [[UIImageView alloc] initWithFrame:CGRectMake(30+([UIScreen mainScreen].bounds.size.width-40)/3*2, 60, ([UIScreen mainScreen].bounds.size.width-40)/3, 100)];
//    self.ThreeImgView.image = [UIImage imageNamed:@"BGYT"];
//    [self addSubview:self.ThreeImgView];
    
    self.LogoImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 201, 31, 31)];
    self.LogoImgView.image = [UIImage imageNamed:@"BGYT"];
    self.LogoImgView.layer.cornerRadius = 15.5;
    self.LogoImgView.layer.masksToBounds=YES;
    [self addSubview:self.LogoImgView];
    
    self.TuiJianLabel = [[UILabel alloc] initWithFrame:CGRectMake(45.5, 204, [UIScreen mainScreen].bounds.size.width-60, 11.5)];
    self.TuiJianLabel.text = @"4Dplayer";
    self.TuiJianLabel.textColor = [UIColor colorWithRed:70/255.0 green:70/255.0 blue:70/255.0 alpha:1.0];
    self.TuiJianLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:12];
    [self addSubview:self.TuiJianLabel];
    
    self.NumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(45.5, 218.5, [UIScreen mainScreen].bounds.size.width-60, 11.5)];
    self.NumberLabel.text = @"推荐了16件单品";
    self.NumberLabel.textColor = [UIColor colorWithRed:164/255.0 green:164/255.0 blue:164/255.0 alpha:1.0];
    self.NumberLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
    [self addSubview:self.NumberLabel];
    
    UIImageView *line1 = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-60, 219, 14, 11)];
    line1.image = [UIImage imageNamed:@"icon-kan"];
    
    [self addSubview:line1];
    
    self.AmountLabel = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-70+32, 219, 70, 10)];
    self.AmountLabel.text = @"2170";
    self.AmountLabel.textAlignment = NSTextAlignmentLeft;
    self.AmountLabel.textColor = [UIColor colorWithRed:164/255.0 green:164/255.0 blue:164/255.0 alpha:1.0];
    self.AmountLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:13];
    [self addSubview:self.AmountLabel];
    
    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 241, [UIScreen mainScreen].bounds.size.width, 1)];
    line.image = [UIImage imageNamed:@"fengexian"];
    
    [self addSubview:line];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 242, [UIScreen mainScreen].bounds.size.width, 10)];
    view.backgroundColor = [UIColor colorWithRed:228/255.0 green:233/255.0 blue:234/255.0 alpha:1.0];
    [self addSubview:view];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
