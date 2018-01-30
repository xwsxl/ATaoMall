//
//  UpLookCell.m
//  aTaohMall
//
//  Created by JMSHT on 2016/12/28.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import "UpLookCell.h"

@implementation UpLookCell

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
    
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 5)];
    
    view.backgroundColor=[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];
    
    [self addSubview:view];
    
    self.ImgView = [[UIImageView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-122)/2, 25, 22, 22)];
    
    self.ImgView .image = [UIImage imageNamed:@"上拉"];
    
    [self addSubview:self.ImgView];
    
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-120)/2+20, 25, 100, 22)];
    
    self.titleLabel.text=@"上拉查看图文详情";
    self.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
    self.titleLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
    
    
    self.titleLabel.textAlignment=NSTextAlignmentLeft;
    
    [self addSubview:self.titleLabel];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
