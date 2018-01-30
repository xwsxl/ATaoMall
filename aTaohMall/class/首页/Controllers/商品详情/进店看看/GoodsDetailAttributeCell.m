//
//  GoodsDetailAttributeCell.m
//  aTaohMall
//
//  Created by JMSHT on 2017/2/22.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "GoodsDetailAttributeCell.h"

@implementation GoodsDetailAttributeCell

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
   
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 4)];
    
    bgView.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];
    
    [self addSubview:bgView];
    
    
    self.GoodsAttribute = [[UILabel alloc] initWithFrame:CGRectMake(20, 17, [UIScreen mainScreen].bounds.size.width-100, 20)];
    
    self.GoodsAttribute.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    
    self.GoodsAttribute.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:15];
    
    self.GoodsAttribute.textAlignment = NSTextAlignmentLeft;
    
    self.GoodsAttribute.text = @"选择 商品规格";
    
    [self addSubview:self.GoodsAttribute];
    
    self.ImgView = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-20, (45-12)/2+5, 6, 12)];
    
    self.ImgView.image = [UIImage imageNamed:@"右键进入"];
    
    [self addSubview:self.ImgView];

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
