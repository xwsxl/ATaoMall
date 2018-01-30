//
//  MerchantNoDataCell.m
//  aTaohMall
//
//  Created by JMSHT on 2017/3/8.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "MerchantNoDataCell.h"

@implementation MerchantNoDataCell

-(instancetype)initWithFrame:(CGRect)frame
{
    
    if (self= [super initWithFrame:frame]) {
        [self loadMyCell];
    }
    return self;
}

-(void)loadMyCell
{
    
    self.NoDataLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 60, [UIScreen mainScreen].bounds.size.width, 20)];
    
    self.NoDataLabel.text = @"暂无相关商品";
    
    self.NoDataLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    self.NoDataLabel.textAlignment = NSTextAlignmentCenter;
    
    self.NoDataLabel.font  =[UIFont fontWithName:@"PingFang-SC-Regular" size:13];
    
    [self addSubview:self.NoDataLabel];
    
    
}
@end
