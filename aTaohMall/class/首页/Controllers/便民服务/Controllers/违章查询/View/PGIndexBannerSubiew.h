//
//  PGIndexBannerSubiew.h
//  NewPagedFlowViewDemo
//
//  Created by Mars on 16/6/18.
//  Copyright © 2016年 Mars. All rights reserved.
//  Designed By PageGuo,
//  QQ:799573715
//  github:https://github.com/PageGuo/NewPagedFlowView

/******************************
 
 可以根据自己的需要再次重写view
 
 ******************************/

#import <UIKit/UIKit.h>

@interface PGIndexBannerSubiew : UIView

/**
 *  主图
 */
@property (nonatomic, strong) UIImageView *mainImageView;
@property (nonatomic,strong) UIImageView *BGImageView;
/**
 *  用来变色的view
 */
@property (nonatomic, strong) UIView *coverView;

@property (nonatomic, strong) UILabel *plateNumLab;

@property (nonatomic, strong) UIButton *editBut;

@property (nonatomic, strong) UILabel *pendingPeccantLab;

@property (nonatomic, strong) UILabel *deductMarkLab;

@property (nonatomic, strong) UILabel *fineLab;

@property (nonatomic, strong) UILabel *updateTimeLab;

@property (nonatomic,strong) UILabel *remarkLab;

@end
