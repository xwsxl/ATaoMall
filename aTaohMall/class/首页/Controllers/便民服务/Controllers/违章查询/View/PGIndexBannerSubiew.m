//
//  PGIndexBannerSubiew.m
//  NewPagedFlowViewDemo
//
//  Created by Mars on 16/6/18.
//  Copyright © 2016年 Mars. All rights reserved.
//  Designed By PageGuo,
//  QQ:799573715
//  github:https://github.com/PageGuo/NewPagedFlowView

#import "PGIndexBannerSubiew.h"

@implementation PGIndexBannerSubiew

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
      //  self.backgroundColor=[UIColor redColor];
        [self addSubview:self.BGImageView];
        
//        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
//        
//        view.backgroundColor = [UIColor redColor];
//        
//        view.layer.cornerRadius=4;
//        
//        [self addSubview:view];
//        [view addSubview:self.mainImageView];
//        [view  addSubview:self.coverView];
//        
//        [view  addSubview:self.plateNumLab];
//        [view  addSubview:self.pendingPeccantLab];
//        [view  addSubview:self.deductMarkLab];
//        [view  addSubview:self.fineLab];
//        [view  addSubview:self.updateTimeLab];
//        [view  addSubview:self.editBut];
//        [view  addSubview:self.remarkLab];
        [self addSubview:self.mainImageView];
        [self addSubview:self.coverView];
        
        [self addSubview:self.plateNumLab];
        [self addSubview:self.pendingPeccantLab];
        [self addSubview:self.deductMarkLab];
        [self addSubview:self.fineLab];
        [self addSubview:self.updateTimeLab];
        [self addSubview:self.editBut];
        [self addSubview:self.remarkLab];
    }
    
    return self;
}

-(UIImageView *)BGImageView
{
    if (!_BGImageView) {
        _BGImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        _BGImageView.layer.cornerRadius=4;
        //_BGImageView.backgroundColor=RGB(255, 52, 90);
        _BGImageView.image=[UIImage imageNamed:@"bg"];
       // [_BGImageView setContentMode:UIViewContentModeScaleAspectFill];
    }
    return _BGImageView;
}

- (UIView *)coverView {
    if (_coverView == nil) {
        _coverView = [[UIView alloc] initWithFrame:self.bounds];
      //  _coverView.backgroundColor = [UIColor redColor];
    }
    return _coverView;
}

- (UIImageView *)mainImageView {
    
    if (_mainImageView == nil) {
        _mainImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 41, 41)];
        _mainImageView.layer.cornerRadius=20.5;
        _mainImageView.userInteractionEnabled = YES;
        _mainImageView.layer.borderWidth=1;
        _mainImageView.layer.borderColor=[[UIColor whiteColor] CGColor];
        _mainImageView.image=[UIImage imageNamed:@"icon_car1"];
       // _mainImageView.backgroundColor=RandomColor;
    }
    return _mainImageView;
}

-(UILabel *)plateNumLab
{
    if (!_plateNumLab) {
        _plateNumLab=[[UILabel alloc]initWithFrame:CGRectMake(64, 28, 80, 15)];
        _plateNumLab.font=KNSFONT(16);
        _plateNumLab.textColor=[UIColor whiteColor];
        _plateNumLab.text=@"粤B3X541";
      //  _plateNumLab.backgroundColor=RandomColor;
    }
    return _plateNumLab;
}

-(UILabel *)remarkLab
{
    if (!_remarkLab) {
        _remarkLab=[[UILabel alloc]initWithFrame:CGRectMake(160, 28, 80, 15)];
        _remarkLab.font=KNSFONT(15);
        _remarkLab.textAlignment=NSTextAlignmentCenter;
       // _remarkLab.backgroundColor=[UIColor whiteColor];
        
        _remarkLab.textColor=[UIColor whiteColor];
        
      _remarkLab.text=@"备注名";
    }
    return _remarkLab;
}


-(UILabel *)pendingPeccantLab
{
    if (!_pendingPeccantLab) {
        _pendingPeccantLab=[[UILabel alloc]initWithFrame:CGRectMake(15, 86, 70, 13)];
        _pendingPeccantLab.font=KNSFONT(14);
        _pendingPeccantLab.textColor=[UIColor whiteColor];
        _pendingPeccantLab.text=@"待处理 0";
        _pendingPeccantLab.textAlignment=NSTextAlignmentLeft;
       // _pendingPeccantLab.backgroundColor=RandomColor;
    }
    return _pendingPeccantLab;
}

-(UILabel *)deductMarkLab
{
    if (!_deductMarkLab) {
        _deductMarkLab=[[UILabel alloc]initWithFrame:CGRectMake(91, 86, 70, 13)];
        _deductMarkLab.font=KNSFONT(14);
        _deductMarkLab.textColor=[UIColor whiteColor];
      //  _deductMarkLab.backgroundColor=RandomColor;
        _deductMarkLab.textAlignment=NSTextAlignmentLeft;
        _deductMarkLab.text=@"扣分 0";
    }
    return _deductMarkLab;
}

-(UILabel *)fineLab
{
    if (!_fineLab) {
        _fineLab=[[UILabel alloc]initWithFrame:CGRectMake(161, 86, 70, 13)];
        _fineLab.font=KNSFONT(14);
        _fineLab.textColor=[UIColor whiteColor];
      //  _fineLab.backgroundColor=RandomColor;
        _fineLab.textAlignment=NSTextAlignmentLeft;
        _fineLab.text=@"罚款 0";
    }
    return _fineLab;
}

-(UILabel *)updateTimeLab
{
    if (!_updateTimeLab) {
        _updateTimeLab=[[UILabel alloc]initWithFrame:CGRectMake(15, 115, 300, 12)];
        _updateTimeLab.font=KNSFONT(12);
        _updateTimeLab.textColor=[UIColor whiteColor];
      //  _updateTimeLab.backgroundColor=RandomColor;
        _updateTimeLab.textAlignment=NSTextAlignmentLeft;
        _updateTimeLab.text=@"更新时间:  2017-06-27 15:40:39";
        
    }
    return _updateTimeLab;
}

-(UIButton *)editBut
{
    if (!_editBut) {
        _editBut=[UIButton buttonWithType:UIButtonTypeCustom];
        _editBut.frame=CGRectMake(kScreen_Width-80-45, 10, 35, 10);
        [_editBut setBackgroundImage:[UIImage imageNamed:@"btn_details"] forState:UIControlStateNormal];
        //[_editBut setBackgroundColor:RandomColor];
    }
    
    return _editBut;
}























@end
