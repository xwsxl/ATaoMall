//
//  CartUseScoreCell.m
//  aTaohMall
//
//  Created by JMSHT on 2017/1/17.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "CartUseScoreCell.h"

@implementation CartUseScoreCell

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
    
    NSLog(@"&&&&&&&&&&&=积分兑换");
    
    
    UIImageView *fenge1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 1)];
    
    fenge1.image = [UIImage imageNamed:@"分割线-拷贝"];
    
    [self addSubview:fenge1];
    
    self.UseLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 20, 30, 20)];
    
    self.UseLab.text = @"使用";
    
    self.UseLab.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:12];
    
    self.UseLab.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    
    [self addSubview:self.UseLab];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(45, 20, 70, 20)];
    
    [self addSubview:view];
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 70, 20)];
    
    imgView.image = [UIImage imageNamed:@"积分框"];
    
    [view addSubview:imgView];
    
    self.ScoreTF = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 70, 20)];
    self.ScoreTF.textColor=[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    self.ScoreTF.textAlignment=NSTextAlignmentCenter;
    self.ScoreTF.text = @"100";
    self.ScoreTF.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:12];
    [view addSubview:self.ScoreTF];
    
    self.DuiHuanLab = [[UILabel alloc] initWithFrame:CGRectMake(125, 20, [UIScreen mainScreen].bounds.size.width-170, 20)];
    
    self.DuiHuanLab.font=[UIFont fontWithName:@"PingFang-SC-Medium" size:12];
    self.DuiHuanLab.textColor =[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    self.DuiHuanLab.textAlignment = NSTextAlignmentLeft;
    self.DuiHuanLab.text = @"积分兑换￥100.00";
    
    [self addSubview:self.DuiHuanLab];
    
    
    self.ScoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 40, [UIScreen mainScreen].bounds.size.width-50, 20)];
    
    self.ScoreLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:12];
    self.ScoreLabel.textAlignment=NSTextAlignmentLeft;
    self.ScoreLabel.textColor=[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
    self.ScoreLabel.text = @"(你有10000积分，最多使用100积分)";
    
    [self addSubview:self.ScoreLabel];
    
    
    self.UseJiFenSwitch = [[UISwitch alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-80, (70-30)/2, 50, 30)];
    
    self.UseJiFenSwitch.on=YES;
    
    [self addSubview:self.UseJiFenSwitch];
    
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 70, [UIScreen mainScreen].bounds.size.width, 10)];
    lineView.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];
    
    [self addSubview:lineView];
    
    UIImageView *fenge2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 69, [UIScreen mainScreen].bounds.size.width, 1)];
    
    fenge2.image = [UIImage imageNamed:@"分割线-拷贝"];
    
    [self addSubview:fenge2];
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
