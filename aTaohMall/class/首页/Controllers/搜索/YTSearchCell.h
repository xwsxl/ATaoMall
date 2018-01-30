//
//  YTSearchCell.h
//  aTaohMall
//
//  Created by JMSHT on 2016/11/17.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchResultModel.h"

#define TIME_CELL               @"TimeCell"
#define NOTIFICATION_TIME_CELL  @"NotificationTimeCell"

@interface YTSearchCell : UITableViewCell


@property (nonatomic, weak)   id           m_data;
@property (nonatomic, weak)   NSIndexPath *m_tmpIndexPath;

@property(nonatomic,strong)SearchResultModel *model;

@property(strong,nonatomic)UIImageView *GoodsImageView;

@property(strong,nonatomic)UILabel *GoodsNameLabel;

@property(strong,nonatomic)UILabel *GoodsPriceLabel;

@property(strong,nonatomic)UILabel *GoodsAmountLabel;

@property(strong,nonatomic)UILabel *StorenameLabel;

@property(strong,nonatomic)UILabel *HourLabel;
@property(strong,nonatomic)UILabel *MinLabel;
@property(strong,nonatomic)UILabel *SecLabel;

@property(strong,nonatomic)UILabel *TimeTitleLabel;


@property(strong,nonatomic)UIView *YTView;


@property(nonatomic,copy) NSString *startString;

@property(nonatomic,copy) NSString *endString;


@property(strong,nonatomic)UIImageView *NoBuyImageView;


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
 *  在cell上面构建views
 */
//- (void)buildViews;

/**
 *  == [子类可以重写] ==
 *
 *  加载数据
 *
 *  @param data      数据
 *  @param indexPath 数据编号
 */
- (void)loadData:(id)data indexPath:(NSIndexPath*)indexPath andString:(NSString *)string  andStatus:(NSString *)status;

@end
