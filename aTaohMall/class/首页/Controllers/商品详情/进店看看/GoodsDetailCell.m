//
//  GoodsDetailCell.m
//  aTaohMall
//
//  Created by JMSHT on 16/5/18.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import "GoodsDetailCell.h"

@implementation GoodsDetailCell

- (void)awakeFromNib {
    // Initialization code
    //iOS实现圆形头像
    self.ShopLogoImageView.layer.masksToBounds = YES;
    self.ShopLogoImageView.layer.cornerRadius = self.ShopLogoImageView.bounds.size.width*0.5;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
@end
