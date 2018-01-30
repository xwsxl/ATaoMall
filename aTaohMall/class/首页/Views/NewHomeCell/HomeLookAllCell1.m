//
//  HomeLookAllCell1.m
//  aTaohMall
//
//  Created by JMSHT on 16/6/15.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import "HomeLookAllCell1.h"

#define Width ([UIScreen mainScreen].bounds.size.width-5)/2

#define Height [UIScreen mainScreen].bounds.size.height/4.4
@implementation HomeLookAllCell1

- (void)awakeFromNib {
    // Initialization code
    
    
}

-(void)setStatus:(NSString *)status
{
    
    NSLog(@"===111===%f==Height==%f",self.GoodsImageView.frame.size.height,Height);
    
    _status = status;
    
    if ([_status isEqualToString:@"1"]) {
        
        UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectMake((Width-60)/2, (Height-60)/2, 60, 60)];
        view.image = [UIImage imageNamed:@"已售完new"];
        [self addSubview:view];
    }
    
}
- (void)setBounds:(CGRect)bounds {
    [super setBounds:bounds];
    self.contentView.frame = bounds;
}


@end
