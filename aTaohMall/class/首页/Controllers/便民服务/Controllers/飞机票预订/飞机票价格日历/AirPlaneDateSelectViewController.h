//
//  AirPlaneDateSelectViewController.h
//  aTaohMall
//
//  Created by JMSHT on 2017/5/18.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalendarLogic.h"
#import "CalendarViewController.h"
//回掉代码块
typedef void (^CalendarBlock)(CalendarDayModel *model);

@interface AirPlaneDateSelectViewController : UIViewController

@property(nonatomic ,strong) UICollectionView* collectionView;//网格视图

@property(nonatomic ,strong) NSMutableArray *calendarMonth;//每个月份的中的daymodel容器数组

@property(nonatomic ,strong) CalendarLogic *Logic;

@property (nonatomic, copy) CalendarBlock calendarblock;//回调

@property (nonatomic, strong) NSString *calendartitle;//设置导航栏标题

@property(nonatomic,copy) NSString *back;

- (void)setAirPlaneToDay:(int)day ToDateforString:(NSString *)todate andString:(NSString *)str back:(NSString *)back;
- (void)setAirPlaneToDay:(int)day ToDateforString:(NSString *)todate back:(NSString *)back;//飞机初始化方法

- (void)setHotelToDay:(int)day ToDateforString:(NSString *)todate;//酒店初始化方法

- (void)setTrainToDay:(int)day ToDateforString:(NSString *)todate;//火车初始化方法

@end
