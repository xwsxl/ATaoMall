//
//  NoDataFenLeiCell.m
//  aTaohMall
//
//  Created by JMSHT on 2017/4/11.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "NoDataFenLeiCell.h"

@implementation NoDataFenLeiCell

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
    self.LogoImgView = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenWidth-43-Width(80))/2, 10, 43, 45)];
    
    self.LogoImgView.image = [UIImage imageNamed:@"xl-无物品"];
    
    [self addSubview:self.LogoImgView];
    
    
    self.NameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0 ,45+10+10, kScreenWidth-Width(80), 20)];
    self.NameLabel.text = @"暂无商品";
    self.NameLabel.textAlignment=NSTextAlignmentCenter;
    self.NameLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    self.NameLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
    [self addSubview:self.NameLabel];

    UIView *line=[[UIView alloc] initWithFrame:CGRectMake(0, 103, kScreenWidth-Width(80), 1)];
    line.backgroundColor=RGB(225, 225, 225);
    [self addSubview:line];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
