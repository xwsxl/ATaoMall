//
//  BMHotCell.m
//  aTaohMall
//
//  Created by JMSHT on 2017/5/11.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "BMHotCell.h"

@implementation BMHotCell

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
    self.Left = [[UILabel alloc] initWithFrame:CGRectMake(15, (50-13)/2, 100, 13)];
    self.Left.text=@"北京";
    self.Left.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    self.Left.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15];
    [self addSubview:self.Left];
    
    self.LeftUIButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.LeftUIButton.frame = CGRectMake(15, 0, 100, 50);
    [self addSubview:self.LeftUIButton];
    
    self.Center = [[UILabel alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-100)/2, (50-13)/2, 100, 13)];
    self.Center.text=@"广州";
    self.Center.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    self.Center.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15];
    self.Center.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.Center];
    
    self.CenterUIButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.CenterUIButton.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width-100)/2, 0, 100, 50);
    [self addSubview:self.CenterUIButton];
    
    self.Right = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-137, (50-13)/2, 100, 13)];
    self.Right.text=@"上海";
    self.Right.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    self.Right.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15];
    self.Right.textAlignment = NSTextAlignmentRight;
    [self addSubview:self.Right];
    
    self.RightUIButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.RightUIButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-137, 0, 100, 50);
    [self addSubview:self.RightUIButton];
    
    self.line = [[UIImageView alloc] initWithFrame:CGRectMake(15, 49, [UIScreen mainScreen].bounds.size.width-15, 1)];
    self.line.image = [UIImage imageNamed:@"分割线-拷贝"];
    [self addSubview:self.line];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
