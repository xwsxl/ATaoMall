//
//  NewLookAllCell.m
//  aTaohMall
//
//  Created by JMSHT on 2017/3/27.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "NewLookAllCell.h"

#define YTScreen [UIScreen mainScreen].bounds.size.height/3.5

#define YTScreen1 [UIScreen mainScreen].bounds.size.width/2.5+12

#define YTScreen2 [UIScreen mainScreen].bounds.size.width/2.5+30

@implementation NewLookAllCell

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


-(void)loadMyCell{
    
    
    UIImageView *fenge1=[[UIImageView alloc] initWithFrame:CGRectMake(9, 9, 1, YTScreen-18)];
    fenge1.image=[UIImage imageNamed:@"分割线YT"];
    [self addSubview:fenge1];
    
    
    UIImageView *fenge2=[[UIImageView alloc] initWithFrame:CGRectMake(9, 9, [UIScreen mainScreen].bounds.size.width/2.5+2, 1)];
    fenge2.image=[UIImage imageNamed:@"分割线-拷贝"];
    [self addSubview:fenge2];
    
    UIImageView *fenge3=[[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2.5+10, 9, 1, YTScreen-18)];
    fenge3.image=[UIImage imageNamed:@"分割线YT"];
    [self addSubview:fenge3];
    
    UIImageView *fenge4=[[UIImageView alloc] initWithFrame:CGRectMake(9, YTScreen-10, [UIScreen mainScreen].bounds.size.width/2.5+2, 1)];
    fenge4.image=[UIImage imageNamed:@"分割线-拷贝"];
    [self addSubview:fenge4];
    
    
    self.Goods_ImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, [UIScreen mainScreen].bounds.size.width/2.5, YTScreen-20)];
//    self.Goods_ImgView.image = [UIImage imageNamed:@"BGYT"];
    [self addSubview:self.Goods_ImgView];
    
    self.Goods_Name = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2.5+30, 20, [UIScreen mainScreen].bounds.size.width/2, 40)];
    self.Goods_Name.text = @"fgvjhfbnfbnfjnb办法喝vid分vi发v方便就覅比发比防波堤";
    self.Goods_Name.numberOfLines = 2;
    self.Goods_Name.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    self.Goods_Name.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    [self addSubview:self.Goods_Name];
    
    self.Goods_storename = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2.5+30, 80, [UIScreen mainScreen].bounds.size.width/2, 20)];
    self.Goods_storename.text = @"林家集团";
    self.Goods_storename.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    self.Goods_storename.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
    [self addSubview:self.Goods_storename];
    
    
    self.Goods_Price = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2.5+30, 120, [UIScreen mainScreen].bounds.size.width/2, 20)];
    self.Goods_Price.text = @"￥10.00+10.00积分";
    self.Goods_Price.textColor = [UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
    self.Goods_Price.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    [self addSubview:self.Goods_Price];
    
    self.Goods_Amount = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2.5+30, 160, [UIScreen mainScreen].bounds.size.width/2, 17)];
    self.Goods_Amount.text = @"3人付款";
    self.Goods_Amount.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    self.Goods_Amount.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
    [self addSubview:self.Goods_Amount];
    
    UIImageView *line3=[[UIImageView alloc] initWithFrame:CGRectMake(YTScreen1, YTScreen-1, [UIScreen mainScreen].bounds.size.width-YTScreen1, 1)];
    
    line3.image=[UIImage imageNamed:@"分割线-拷贝"];
    
    [self addSubview:line3];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
