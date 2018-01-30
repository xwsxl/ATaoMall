//
//  QianShouCell.m
//  aTaohMall
//
//  Created by JMSHT on 2017/4/17.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "QianShouCell.h"

@implementation QianShouCell

- (void)awakeFromNib {
    [super awakeFromNib];
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
    self.Big =[[UIImageView alloc] initWithFrame:CGRectMake(30, 12, 18, 18)];
    self.Big.image  =[UIImage imageNamed:@"选中点"];
    [self addSubview:self.Big];
    
    self.line = [[UIImageView alloc] initWithFrame:CGRectMake(39, 12+16, 1, 80-12-16)];
    self.line.image = [UIImage imageNamed:@"线"];
    [self addSubview:self.line];
    
//    self.Name = [[UILabel alloc] initWithFrame:CGRectMake(80, 12, [UIScreen mainScreen].bounds.size.width-100, 40)];
    self.Name = [[UILabel alloc] init];
//    self.Name.text = @"[深圳市]快件已签收";
    self.Name.textColor=[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
    self.Name.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:13];
    self.Name.numberOfLines=0;
    
    [self addSubview:self.Name];
    
    self.Time = [[UILabel alloc] initWithFrame:CGRectMake(80, 32+25, [UIScreen mainScreen].bounds.size.width-100, 20)];
    self.Time.text = @"2017-04-09 11:31:49";
    self.Time.textColor=[UIColor colorWithRed:153/255.0 green:153/255.0 blue:155/255.0 alpha:1.0];
    self.Time.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:11];
    [self addSubview:self.Time];
    
    UIImageView *line1 = [[UIImageView alloc] initWithFrame:CGRectMake(80, 79, [UIScreen mainScreen].bounds.size.width-100, 1)];
    
    line1.image = [UIImage imageNamed:@"分割线-拷贝"];
    
    [self addSubview:line1];
    
}

-(void)setNameString:(NSString *)NameString
{
    
    _NameString = NameString;
    
    CGSize labelSize = {0,0};
    
    labelSize = [_NameString sizeWithFont:[UIFont fontWithName:@"PingFang-SC-Regular" size:13] constrainedToSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-100, 70) lineBreakMode:UILineBreakModeWordWrap];
    
    self.Name.lineBreakMode = UILineBreakModeCharacterWrap;
    self.Name.frame = CGRectMake(80, 10, [UIScreen mainScreen].bounds.size.width-100, labelSize.height);
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
