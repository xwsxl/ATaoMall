//
//  FailureHeaderView.m
//  aTaohMall
//
//  Created by JMSHT on 2017/1/4.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "FailureHeaderView.h"


#define HeaderHeight [[UIScreen mainScreen] bounds].size.height*0.1049

@implementation FailureHeaderView


- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        
        [self setUI];
        
    }
    return self;
}


-(void)setUI{
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, HeaderHeight*0.1428)];
    
    bgView.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];
    
    [self.contentView addSubview:bgView];
    
    UIImageView *line1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0.5)];
    
    line1.image = [UIImage imageNamed:@"分割线e2"];
    
    [bgView addSubview:line1];
    
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, (HeaderHeight-30-HeaderHeight*0.1428)/2+HeaderHeight*0.1428, 100, 30)];
    
    _titleLabel.text = @"失效商品";
    
    _titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:14];
    
    _titleLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    
    [self addSubview:_titleLabel];
    
    _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _deleteButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-100, (HeaderHeight-22-HeaderHeight*0.1428)/2+HeaderHeight*0.1428, 80, 22);
    [_deleteButton setTitle:@"清空失效商品" forState:0];
    [_deleteButton setTitleColor:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0] forState:0];
    _deleteButton.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:11];
    
    _deleteButton.layer.cornerRadius = 2.5;
    _deleteButton.layer.borderColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0].CGColor;
    _deleteButton.layer.borderWidth = 1;
    
    _deleteButton.layer.cornerRadius  = 2.5;
    _deleteButton.layer.masksToBounds = YES;
    
    
//    [_deleteButton setBackgroundImage:[UIImage imageNamed:@"积分框"] forState:0];
    
    [_deleteButton addTarget:self action:@selector(deleteBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:_deleteButton];
    
    
    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(45, HeaderHeight-0.5, [UIScreen mainScreen].bounds.size.width-45, 0.5)];
    
    line.image = [UIImage imageNamed:@"分割线e2"];
    
    [self addSubview:line];
    
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setSelectBtnTag:(NSInteger)selectBtnTag{
    if (_deleteButton.tag == selectBtnTag) {
        
    }else{
        _selectBtnTag = selectBtnTag;
        _deleteButton.tag = selectBtnTag;
    }
    _selectBtnTag = selectBtnTag;
    _deleteButton.tag = selectBtnTag;
}


-(void)deleteBtnClick
{
    
    
    NSLog(@"===清空失效数据=====");
    
}
@end
