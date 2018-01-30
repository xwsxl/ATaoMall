//
//  AirPlaneHBCell.h
//  aTaohMall
//
//  Created by JMSHT on 2017/5/19.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AirPlaneHBCell : UITableViewCell

@property(nonatomic,strong) UILabel *StartTimeLabel;

@property(nonatomic,strong) UILabel *StartCityLabel;

@property(nonatomic,strong) UILabel *EndTimeLabel;

@property(nonatomic,strong) UILabel *EndCityLabel;

@property(nonatomic,strong) UILabel *LongLabel;

@property(nonatomic,strong) UILabel *PriceLabel;

@property(nonatomic,strong) UILabel *TicketLabel;

@property(nonatomic,strong) UILabel *TypeLabel;

@property(nonatomic,strong) UIImageView *GoToImgView;

@property(nonatomic,strong) UIImageView *RedImgView;

@property (nonatomic,strong) UILabel *StopOverLab;
@end
