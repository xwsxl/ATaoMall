//
//  WuLiuCell.m
//  aTaohMall
//
//  Created by JMSHT on 2017/4/17.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "WuLiuCell.h"

@implementation WuLiuCell

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

    self.Small =[[UIImageView alloc] initWithFrame:CGRectMake(36, 12, 7, 7)];
    self.Small.image  =[UIImage imageNamed:@"圆点new"];
    [self addSubview:self.Small];
    
    self.line2 = [[UIImageView alloc] initWithFrame:CGRectMake(39, 0, 1, 12)];
    self.line2.image = [UIImage imageNamed:@"线"];
    [self addSubview:self.line2];
    
    self.line = [[UIImageView alloc] initWithFrame:CGRectMake(39, 12+7, 1, 80-12-7)];
    self.line.image = [UIImage imageNamed:@"线"];
    [self addSubview:self.line];
    
//    self.Name = [[UILabel alloc] initWithFrame:CGRectMake(80, 10, [UIScreen mainScreen].bounds.size.width-100, 40)];
    self.Name = [[UILabel alloc] init];
//    self.Name.text = @"[深圳市]快件已到达南山区";
    self.Name.textColor=[UIColor colorWithRed:153/255.0 green:153/255.0 blue:155/255.0 alpha:1.0];
    self.Name.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:13];
    self.Name.numberOfLines=2;
    
//    CGRect tempRect = [ScoreLabel.text boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-100,14) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFang-SC-Regular" size:11]} context:nil];
    
    [self addSubview:self.Name];
    
    self.Time = [[UILabel alloc] initWithFrame:CGRectMake(80, 50, [UIScreen mainScreen].bounds.size.width-100, 20)];
    self.Time.text = @"2017-04-09 11:31:49";
    self.Time.textColor=[UIColor colorWithRed:153/255.0 green:153/255.0 blue:155/255.0 alpha:1.0];
    self.Time.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:11];
    [self addSubview:self.Time];
    
    self.line1 = [[UIImageView alloc] initWithFrame:CGRectMake(80, 69, [UIScreen mainScreen].bounds.size.width-100, 1)];
    
    self.line1.image = [UIImage imageNamed:@"分割线-拷贝"];
    
    [self addSubview:self.line1];
    
}

-(void)setNameString:(NSString *)NameString
{
    
    _NameString = NameString;
    
    CGSize labelSize = {0,0};
    
    labelSize = [_NameString sizeWithFont:[UIFont fontWithName:@"PingFang-SC-Regular" size:13] constrainedToSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-100, 70) lineBreakMode:UILineBreakModeWordWrap];
    
    self.Name.lineBreakMode = UILineBreakModeCharacterWrap;
    self.Name.frame = CGRectMake(80, 5, [UIScreen mainScreen].bounds.size.width-100, labelSize.height);
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
