//
//  DingDanDetailCell.m
//  aTaohMall
//
//  Created by JMSHT on 16/5/18.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import "DingDanDetailCell.h"

@implementation DingDanDetailCell

- (void)awakeFromNib {
    // Initialization code
    
    
}


//纯积分限购数为1时，输入框不可点击
-(void)setYTCount:(NSString *)YTCount
{
    
    _YTCount=YTCount;
    
    NSLog(@"++++_YTCount++++%@+++++",_YTCount);
    
    if ([_YTCount isEqualToString:@"1"]) {
        
        self.YTNumberTF.enabled=NO;
        
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
