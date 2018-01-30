//
//  NoMoreDataCell.m
//  aTaohMall
//
//  Created by JMSHT on 2017/4/11.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "NoMoreDataCell.h"

#define Height [UIScreen mainScreen].bounds.size.height-65-44
@implementation NoMoreDataCell

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
//    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-188/2)/2, 100, 188/2, 197/2)];
//    imgView.image = [UIImage imageNamed:@"没有找到相关商品"];
//    
//    [self addSubview:imgView];
//    
//    
//    UILabel *NoLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 100+197/2+39, [UIScreen mainScreen].bounds.size.width-60, 20)];
//    NoLabel.text = @"抱歉，没有找到相关商品~";
//    NoLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
//    NoLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:18];
//    NoLabel.textAlignment = NSTextAlignmentCenter;
//    [self addSubview:NoLabel];
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
