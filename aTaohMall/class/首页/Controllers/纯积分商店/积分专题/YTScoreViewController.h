//
//  YTScoreViewController.h
//  aTaohMall
//
//  Created by JMSHT on 2016/11/14.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GGClockView.h"
@interface YTScoreViewController : UIViewController

@property(nonatomic,strong)UILabel *YTHourLabel;

@property(nonatomic,strong)UILabel *YTMinLabel;
@property(nonatomic,strong)UILabel *YTSecLabel;


@property(nonatomic,copy)NSString *end_time_str;

@property(nonatomic,copy)NSString *start_time_str;

@property(nonatomic,copy)NSString *gid;

@property(nonatomic,copy)NSString *String;

@property(nonatomic,copy)NSString *status;

@property(nonatomic,copy)NSString *good_type;

@property(nonatomic,copy)NSString *good_status;

@property(nonatomic,copy)  NSString *attribute;//商品属性；

@property(nonatomic,copy)NSString *BoolString;

@property(nonatomic,copy)NSString *TypeString;
@property(nonatomic,copy)NSString *WebString;

@property(nonatomic,copy)NSString *start_time1;//开始
@property(nonatomic,copy)NSString *end_time1;//结束

@property(nonatomic,copy)NSString *start_time2;//开始
@property(nonatomic,copy)NSString *end_time2;//结束


@property (weak, nonatomic)  NSTimer *timer;

/// 初始时间
@property (nonatomic, assign) NSTimeInterval time;

// 获取table view cell 的indexPath
@property (nonatomic, weak) NSIndexPath *m_indexPath;

@property (nonatomic)       BOOL         m_isDisplayed;

/**
 *  == [子类可以重写] ==
 *
 *  配置cell的默认属性
 */
- (void)defaultConfig;

- (void)loadData:(id)data type:(NSString *)string;
@end
