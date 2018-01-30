//
//  GotoShopLimitCell.h
//  aTaohMall
//
//  Created by JMSHT on 16/7/20.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GGClockView.h"

#define TIME_CELL               @"TimeCell"
#define NOTIFICATION_TIME_CELL  @"NotificationTimeCell"

@interface GotoShopLimitCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *GoosImageView;

@property (weak, nonatomic) IBOutlet UILabel *GoodsNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *GoodsPriceLabel;

@property (weak, nonatomic) IBOutlet UILabel *GoodsAmountLabel;

@property (weak, nonatomic) IBOutlet UILabel *TimeLabel;

@property (weak, nonatomic) IBOutlet UILabel *Timetext;

@property (weak, nonatomic) IBOutlet UILabel *hourLabel;

@property (weak, nonatomic) IBOutlet UILabel *minLabel;

@property (weak, nonatomic) IBOutlet UILabel *secLabel;

@property (weak, nonatomic) IBOutlet UILabel *YTTimeLabel;


@property (weak, nonatomic)  NSTimer *timer;

/// 初始时间
@property (nonatomic, assign) NSTimeInterval time;

@property (nonatomic, strong) GGClockView *clockView;

@property(nonatomic,copy)NSString *status;//商品状态

@property(nonatomic,copy)NSString *end_time_str;

@property(nonatomic,copy)NSString *start_time_str;

@property(nonatomic,copy)NSString *current_time_stamp;

// 获取table view cell 的indexPath
@property (nonatomic, weak) NSIndexPath *m_indexPath;

@property (nonatomic)       BOOL         m_isDisplayed;

/**
 *  == [子类可以重写] ==
 *
 *  配置cell的默认属性
 */
- (void)defaultConfig;


/**
 *  == [子类可以重写] ==
 *
 *  加载数据
 *
 *  @param data      数据
 *  @param indexPath 数据编号
 */
- (void)loadData:(id)data indexPath:(NSIndexPath*)indexPath type:(NSString *)string ;

@end
