//
//  MerchantDetailCell.h
//  aTaohMall
//
//  Created by JMSHT on 2017/3/8.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GGClockView.h"

#define TIME_CELL               @"TimeCell"
#define NOTIFICATION_TIME_CELL  @"NotificationTimeCell"

@interface MerchantDetailCell : UICollectionViewCell

@property(nonatomic,strong) UIImageView *GoodsImgView;

@property(nonatomic,strong) UILabel *GoodsNameLabel;

@property(nonatomic,strong) UILabel *GoodsPriceLabel;

@property(nonatomic,strong) UILabel *GoodsNumberLabel;

@property(nonatomic,strong) UILabel *GoodsTimeLabel;


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
