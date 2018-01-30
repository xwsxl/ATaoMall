//
//  DPCommandCell.m
//  aTaohMall
//
//  Created by JMSHT on 2017/6/21.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "DPCommandCell.h"

@implementation DPCommandCell

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
    
    self.backgroundColor = [UIColor colorWithRed:228/255.0 green:233/255.0 blue:234/255.0 alpha:1.0];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(6, 10, [UIScreen mainScreen].bounds.size.width-12, 120)];
    view.backgroundColor = [UIColor whiteColor];
    [self addSubview:view];
    
    self.GoodsImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width-12, 79.5)];
//    self.GoodsImgView.contentMode = UIViewContentModeScaleAspectFit;
    self.GoodsImgView.image = [UIImage imageNamed:@"BGYT"];
    [view addSubview:self.GoodsImgView];
    
    self.GoodsNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 92.5, [UIScreen mainScreen].bounds.size.width-32, 14.5)];
    self.GoodsNameLabel.text = @"Madness 六叔（余文乐）原创潮牌";
    self.GoodsNameLabel.numberOfLines = 1;
    self.GoodsNameLabel.textColor = [UIColor colorWithRed:70/255.0 green:70/255.0 blue:70/255.0 alpha:1.0];
    self.GoodsNameLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:15];
    [view addSubview:self.GoodsNameLabel];
    
    self.line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 119, [UIScreen mainScreen].bounds.size.width-12, 1)];
    self.line.image = [UIImage imageNamed:@"分割线-拷贝"];
    
    [view addSubview:self.line];
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
