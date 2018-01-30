//
//  GameNameCell.m
//  aTaohMall
//
//  Created by JMSHT on 2017/5/3.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "GameNameCell.h"

@implementation GameNameCell

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
    self.Name = [[UILabel alloc] initWithFrame:CGRectMake(16, (50-13)/2, [UIScreen mainScreen].bounds.size.width-16, 13)];
    self.Name.text=@"艾欧尼亚-电信";
    self.Name.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    self.Name.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15];
    [self addSubview:self.Name];
    
    self.line = [[UIImageView alloc] initWithFrame:CGRectMake(16, 49, [UIScreen mainScreen].bounds.size.width-16, 1)];
    self.line.image = [UIImage imageNamed:@"分割线-拷贝"];
    [self addSubview:self.line];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
