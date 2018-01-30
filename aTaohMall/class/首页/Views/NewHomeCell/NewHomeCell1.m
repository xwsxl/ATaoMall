//
//  NewHomeCell1.m
//  aTaohMall
//
//  Created by JMSHT on 2017/4/13.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "NewHomeCell1.h"
#define Weight [UIScreen mainScreen].bounds.size.width
@implementation NewHomeCell1

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
    
//    self.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1.0];
//    self.TypeImgView = [[UIImageView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-376/2)/2, 0, 376/2, 133/2)];
//
//    self.TypeImgView.contentMode = UIViewContentModeScaleAspectFit;
//
//    self.TypeImgView.image = [UIImage imageNamed:@"限时兑换1111"];
//
//    [self addSubview:self.TypeImgView];

    self.NameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];

    self.NameLabel.text = @"食品";
    self.NameLabel.textAlignment=NSTextAlignmentCenter;
    self.NameLabel.font = KNSFONT(17);

    self.NameLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    UIImageView *MsgTitleIV1=[[UIImageView alloc] initWithFrame:CGRectMake(Width(93), 18, 56, 5)];
    [MsgTitleIV1 setImage:KImage(@"msgTitle1")];
    [self.NameLabel addSubview:MsgTitleIV1];

    UIImageView *MsgTitleIV2=[[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth-Width(93)-56, 18, 56, 5)];
    [MsgTitleIV2 setImage:KImage(@"msgTitle2")];
    [self.NameLabel addSubview:MsgTitleIV2];
    [self addSubview:self.NameLabel];
//    self.NameLabel = [[UILabel alloc] initWithFrame:CGRectMake((Weight-20-60-10)/2+30, 10, 60, 20)];
//    //    self.NameLabel.backgroundColor = [UIColor yellowColor];
//    
//    self.NameLabel.text = @"热门商品";
//    
//    self.NameLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:15];
//    
//    self.NameLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
//    
//    [self addSubview:self.NameLabel];
//    
//    UIImageView *fenge = [[UIImageView alloc] initWithFrame:CGRectMake(0, 39, [UIScreen mainScreen].bounds.size.width, 1)];
//    
//    fenge.image = [UIImage imageNamed:@"分割线-拷贝"];
//    
//    [self addSubview:fenge];
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
