//
//  SearchResultCell1.h
//  aTaohMall
//
//  Created by JMSHT on 16/5/18.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

#define TIME_CELL               @"TimeCell"
#define NOTIFICATION_TIME_CELL  @"NotificationTimeCell"
@interface SearchResultCell1 : UITableViewCell



@property (weak, nonatomic) IBOutlet UIImageView *GoodsImageView;

@property (weak, nonatomic) IBOutlet UILabel *GoodsNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *GoodsPriceLabel;

@property (weak, nonatomic) IBOutlet UILabel *HouTingZhiLabel;

@property (weak, nonatomic) IBOutlet UILabel *GoodsAmuontLabel;

@property (weak, nonatomic) IBOutlet UILabel *TimeLable;//时间显示

@property(nonatomic,copy) NSString *startString;

@property(nonatomic,copy) NSString *endString;

@property (weak, nonatomic) IBOutlet UILabel *hourLabel;

@property (weak, nonatomic) IBOutlet UILabel *minLabel;

@property (weak, nonatomic) IBOutlet UILabel *secLabel;

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
- (void)loadData:(id)data indexPath:(NSIndexPath*)indexPath;

@end
