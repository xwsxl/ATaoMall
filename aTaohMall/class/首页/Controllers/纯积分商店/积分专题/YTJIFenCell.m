//
//  YTJIFenCell.m
//  aTaohMall
//
//  Created by JMSHT on 2016/11/16.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import "YTJIFenCell.h"

#define YTScreen ([UIScreen mainScreen].bounds.size.width-35)/2
@implementation YTJIFenCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.NoBuyImageView=[[UIImageView alloc] initWithFrame:CGRectMake((YTScreen -61)/2, 32, 61, 61)];
    
    self.NoBuyImageView.image=[UIImage imageNamed:@"抢光了"];
    
    [self addSubview:self.NoBuyImageView];
    
    
}

@end
