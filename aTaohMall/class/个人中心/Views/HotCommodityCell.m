//
//  HotCommodityCell.m
//  aTaohMall
//
//  Created by DingDing on 2017/9/19.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "HotCommodityCell.h"

@implementation HotCommodityCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
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
    
    
    
    
}
@end
