//
//  CheXingCell.h
//  aTaohMall
//
//  Created by JMSHT on 2017/5/12.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CheXingCell : UITableViewCell

@property(nonatomic,strong) UILabel *StartTimeLabel;

@property(nonatomic,strong) UILabel *EndTimeLabel;

@property(nonatomic,strong) UILabel *StartNameLabel;

@property(nonatomic,strong) UILabel *EndNameLabel;

@property(nonatomic,strong) UILabel *TimeLabel;//运行时间

@property(nonatomic,strong) UILabel *CheCiLabel;//车次

@property(nonatomic,strong) UILabel *PriceLabel;

@property(nonatomic,strong) UILabel *OneLabel;

@property(nonatomic,strong) UILabel *TwoLabel;

@property(nonatomic,strong) UILabel *ThreeLabel;

@property(nonatomic,strong) UILabel *FourLabel;

@property(nonatomic,strong) UILabel *Label1;

@property(nonatomic,strong) UILabel *Label2;

@property(nonatomic,strong) UILabel *Label3;

@property(nonatomic,strong) NSArray *array;

@end
