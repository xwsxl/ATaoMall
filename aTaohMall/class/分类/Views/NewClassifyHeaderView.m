//
//  NewClassifyHeaderView.m
//  aTaohMall
//
//  Created by JMSHT on 2017/4/10.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "NewClassifyHeaderView.h"

@implementation NewClassifyHeaderView


//-(instancetype)initWithFrame:(CGRect)frame
//{
//    
//    if (self= [super initWithFrame:frame]) {
//        [self loadMyCell];
//    }
//    return self;
//}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        //在这里向contentView添加控件
        
        [self loadMyCell];
        
    }
    return self;
}


-(void)loadMyCell
{

    NSLog(@"********fgeghgh**********");
    
    self.backgroundColor=[UIColor redColor];
    
    self.bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 12, 19, 15)];
    
    self.bgImgView.contentMode = UIViewContentModeCenter;
    
    [self addSubview:self.bgImgView];
    
    self.NameLabel = [[UILabel alloc] initWithFrame:CGRectMake(32, 10, 55, 20)];
    
    self.NameLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:15];
    
    self.NameLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    
    [self addSubview:self.NameLabel];
    
    self.MoreButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    self.MoreButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-[UIScreen mainScreen].bounds.size.width/3-80, 10, 50, 20);
    
    [self.MoreButton setTitle:@"更多" forState:0];
    
    [self.MoreButton setTitleColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0] forState:0];
    self.MoreButton.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    
    [self addSubview:self.MoreButton];
    
    self.logoImgView = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-[UIScreen mainScreen].bounds.size.width/3-30, 10, 20, 20)];
    self.logoImgView.image = [UIImage imageNamed:@"iconfont-enter111"];
    
    [self addSubview:self.logoImgView];
    
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
