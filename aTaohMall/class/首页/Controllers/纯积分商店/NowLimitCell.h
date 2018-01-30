//
//  NowLimitCell.h
//  aTaohMall
//
//  Created by JMSHT on 16/6/6.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

//#import "GGClockView.h"

#define TIME_CELL               @"TimeCell"
#define NOTIFICATION_TIME_CELL  @"NotificationTimeCell"
@interface NowLimitCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *GoodsImageView;

@property (weak, nonatomic) IBOutlet UILabel *GoodsNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *GoodsPriceLabel;

@property (weak, nonatomic) IBOutlet UILabel *GoodsAmountLabel;

@property (weak, nonatomic) IBOutlet UILabel *HouTingZhiLabel;

@property (weak, nonatomic) IBOutlet UILabel *TimeLabel;//显示倒计时

//@property(nonatomic,strong) GGClockView *clockView;


@property(nonatomic,copy) NSString *startString;

@property(nonatomic,copy) NSString *endString;


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
- (void)loadData:(id)data indexPath:(NSIndexPath*)indexPath;
@end
