
//
//  GoodsDetailView.m
//  AddShoppingCart
//
//  Created by 主用户 on 16/4/13.
//  Copyright © 2016年 江萧. All rights reserved.
//

#import "GoodsDetailView.h"

@implementation GoodsDetailView
@synthesize bt_addSize;
-(instancetype)initWithFrame:(CGRect)frame andImageArr:(NSArray *)imageArr
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
        self.showsHorizontalScrollIndicator = NO;
        self.pagingEnabled = YES;
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 470)];
        view.backgroundColor = [UIColor whiteColor];
        [self addSubview:view];
        

        
        //尺码选择
        bt_addSize = [[MsButton alloc] initWithFrame:CGRectMake(0, view.frame.size.height+10, self.frame.size.width, 50) Head:nil Message:nil];
        bt_addSize.msgLabel.frame = CGRectMake(0, bt_addSize.frame.size.height-1, bt_addSize.frame.size.width, 1);
        bt_addSize.msgLabel.backgroundColor = [UIColor lightGrayColor];
        
        bt_addSize.headLabel.frame = CGRectMake(10, 0, bt_addSize.frame.size.width -50, bt_addSize.frame.size.height);
        bt_addSize.backgroundColor = [UIColor whiteColor];
        bt_addSize.jiantou.image = [UIImage imageNamed:@"set_ico_r@3x"];
        bt_addSize.jiantou.frame = CGRectMake(bt_addSize.frame.size.width-15, (bt_addSize.frame.size.height-16)/2, 10, 16);
        [self addSubview:bt_addSize];
        
        
    }
    return self;
}
-(void)initdata:(NSDictionary *)dic
{
    //传进来的字典里面包含以下信息
    
    bt_addSize.headLabel.text = @"选择 颜色 尺码";
    
}
#pragma -imageweb

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
