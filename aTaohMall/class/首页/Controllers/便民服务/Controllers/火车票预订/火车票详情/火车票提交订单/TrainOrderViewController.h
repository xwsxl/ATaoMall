//
//  TrainOrderViewController.h
//  火车票
//
//  Created by 阳涛 on 17/5/15.
//  Copyright © 2017年 yangtao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GGClockView.h"
@interface TrainOrderViewController : UIViewController

@property(nonatomic,copy)NSString *end_time_str;

@property(nonatomic,copy)NSString *start_time_str;

@property(nonatomic,copy)NSString *start_time1;//开始
@property(nonatomic,copy)NSString *end_time1;//结束

@property(nonatomic,copy)NSString *start_time2;//开始
@property(nonatomic,copy)NSString *end_time2;//结束
@property(nonatomic,copy)NSString *sigen;//结束

@property(nonatomic,copy)NSString *Number;//

@property(nonatomic,copy)NSString *is_accept_standing;

@property(nonatomic,copy)NSString *week;//结束
@property(nonatomic,copy)NSString *phone;//结束
@property(nonatomic,copy)NSString *userIntegral;//结束
@property(nonatomic,copy)NSString *che_type;//结束
@property(nonatomic,copy)NSString *from_stationName;//结束
@property(nonatomic,copy)NSString *orderno;//结束
@property(nonatomic,copy)NSString *checi;//结束
@property(nonatomic,copy)NSString *to_stationName;//结束
@property(nonatomic,copy)NSString *from_station_code;//结束
@property(nonatomic,copy)NSString *clientId;//结束
@property(nonatomic,copy)NSString *order_cash;//结束
@property(nonatomic,copy)NSString *arrive_time;//结束
@property(nonatomic,copy)NSString *to_station_code;//结束
@property(nonatomic,copy)NSString *price;//结束
@property(nonatomic,copy)NSString *train_date;//结束
@property(nonatomic,copy)NSString *zwcode;//结束
@property(nonatomic,copy)NSString *start_time;//结束
@property(nonatomic,copy)NSString *run_time;//结束
@property(nonatomic,copy)NSString *payintegral;//结束
@property(nonatomic,strong) NSArray *CommitArray;
@property(nonatomic,copy)NSString *service_fee;
@property (weak, nonatomic)  NSTimer *timer;


//请求支付宝参数
@property(nonatomic,copy) NSString *APP_ID;

@property(nonatomic,copy) NSString *SELLER;

@property(nonatomic,copy) NSString *RSA_PRIVAT;

@property(nonatomic,copy) NSString *Pay_orderno;

@property(nonatomic,copy) NSString *Notify_url;

@property(nonatomic,copy) NSString *ALiPay_money;

@property(nonatomic,copy) NSString *Return_url;

@property(nonatomic,copy) NSString *Money_url;

@property(nonatomic,copy)NSString *PayType;

@property(nonatomic,copy) NSString *Status;//根据状态判断支付方式

@property(nonatomic,copy) NSString *successurl;

@property(nonatomic,copy) NSString *Alipay_Goods_name;

@property(nonatomic,copy) NSString *Pay_money;

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
