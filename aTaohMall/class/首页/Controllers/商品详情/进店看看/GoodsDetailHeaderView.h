//
//  GoodsDetailHeaderView.h
//  aTaohMall
//
//  Created by JMSHT on 16/5/18.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>


#import "GGClockView.h"

#define TIME_CELL               @"TimeCell"
#define NOTIFICATION_TIME_CELL  @"NotificationTimeCell"


@interface GoodsDetailHeaderView : UITableViewHeaderFooterView


@property (weak, nonatomic) IBOutlet UIView *YTTimeLabel;

@property (weak, nonatomic) IBOutlet UILabel *ShiJianLabel;

@property (weak, nonatomic) IBOutlet UILabel *GoodsDetailNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *NowPriceLabel;//现在价格

@property (weak, nonatomic) IBOutlet UILabel *hourLabel;

@property (weak, nonatomic) IBOutlet UILabel *minLabel;

@property (weak, nonatomic) IBOutlet UILabel *secLabel;

@property (nonatomic, strong) GGClockView *clockView;

@property (weak, nonatomic) IBOutlet UILabel *SendMoneyLabel;

@property (weak, nonatomic) IBOutlet UIButton *SendWayButton;//配送方式

@property (weak, nonatomic) IBOutlet UILabel *AmountLabel;

@property (weak, nonatomic) IBOutlet UILabel *Pricenum;

@property (weak, nonatomic) IBOutlet UILabel *StoreNameLabel;

@property (weak, nonatomic)  NSTimer *timer;

@property (weak, nonatomic)  NSTimer *timer1;

//传入的头部数据的数组
@property(nonatomic, strong)NSArray *headerDatas;

@property(nonatomic,copy)NSString *end_time_str;

@property(nonatomic,copy)NSString *start_time_str;


@property(nonatomic,copy)NSString *goods_type;



/// 初始时间
@property (nonatomic, assign) NSTimeInterval time;


@end
