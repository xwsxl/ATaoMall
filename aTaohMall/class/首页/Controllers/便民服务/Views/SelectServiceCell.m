//
//  SelectServiceCell.m
//  aTaohMall
//
//  Created by JMSHT on 2017/4/27.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "SelectServiceCell.h"

@implementation SelectServiceCell

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
    self.Name = [[UILabel alloc] initWithFrame:CGRectMake(15, (51-13)/2, [UIScreen mainScreen].bounds.size.width-15, 13)];
    self.Name.text=@"";
    self.Name.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    self.Name.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15];
    [self addSubview:self.Name];
    
    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(15, 50, [UIScreen mainScreen].bounds.size.width-15, 1)];
    line.image = [UIImage imageNamed:@"分割线-拷贝"];
    [self addSubview:line];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
