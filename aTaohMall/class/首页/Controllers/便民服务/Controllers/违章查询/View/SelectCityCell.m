//
//  SelectCityCell.m
//  aTaohMall
//
//  Created by Zhending Shi on 2017/8/1.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "SelectCityCell.h"

@implementation SelectCityCell

-(instancetype)init
{
    if ([super init]) {
        [self initMainView];
    }
    return self;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    [self initMainView];
}

-(void)initMainView
{
    [self addSubview:self.textLab];
    [self addSubview:self.supportLab];
    [self addSubview:self.IV];
    _supportLab.hidden=YES;
    _IV.hidden=YES;
}

-(UILabel *)textLab
{
    if (!_textLab) {
        _textLab=[[UILabel alloc]initWithFrame:CGRectMake(25, 18, 180, 14)];
        _textLab.textAlignment=NSTextAlignmentLeft;
        _textLab.font=KNSFONT(14);
        _textLab.textColor=RGB(51, 51, 51);
    }
    return _textLab;
}

-(UILabel *)supportLab
{
    if (!_supportLab) {
        _supportLab=[[UILabel alloc]initWithFrame:CGRectMake(kScreen_Width-75, 19, 60, 13)];
        _supportLab.font=KNSFONT(13);
        _supportLab.textColor=RGB(255, 0, 0);
        _supportLab.text=@"暂不支持";
    }
    return _supportLab;
}
-(UIImageView *)IV
{
    if (!_IV) {
       _IV=[[UIImageView alloc]initWithFrame:CGRectMake(kScreen_Width-30, 17, 15, 15)];
        _IV.image=[UIImage imageNamed:@"button_check"];
        
    }
    return _IV;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end
