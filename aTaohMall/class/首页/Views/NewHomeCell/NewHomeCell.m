//
//  NewHomeCell.m
//  aTaohMall
//
//  Created by JMSHT on 2017/4/10.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "NewHomeCell.h"

#define Weight [UIScreen mainScreen].bounds.size.width

@implementation NewHomeCell

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
//
//    self.TypeImgView = [[UIImageView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-376/2)/2, 0, 376/2, 133/2)];
//
//    self.TypeImgView.contentMode = UIViewContentModeScaleAspectFit;
//
//    self.TypeImgView.image = [UIImage imageNamed:@"热门商品111"];
//
//    [self addSubview:self.TypeImgView];


    self.NameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    self.NameLabel.text = @"数码产品";
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



    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
