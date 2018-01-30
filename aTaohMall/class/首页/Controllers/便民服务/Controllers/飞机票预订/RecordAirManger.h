//
//  RecordAirManger.h
//  aTaohMall
//
//  Created by JMSHT on 2017/5/15.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecordAirManger : NSObject
//飞机票重复城市
+(void)SearchTextwithRepeat :(NSString *)seaTxt;
//缓存飞机票查询城市
+(void)SearchText :(NSString *)seaTxt;

//缓存飞机票日期
+(void)AirDate:(NSString *)date End:(NSString *)endDate;
//火车票重复城市
+(void)SearchTrainwithRepeat :(NSString *)seaTxt;
//缓存飞机票查询城市
+(void)SearchTrain :(NSString *)seaTxt;

//缓存飞机票日期
+(void)TrainDate:(NSString *)date Week:(NSString *)week;

//清除缓存数组
+(void)TrainremoveAllArray;

//缓存往返第一次选择信息
+(void)AirGo:(NSString *)goDate Week:(NSString *)goWeek Time:(NSString *)goTime Price:(NSString *)goPrice JiJian:(NSString *)goJiJian StartCity:(NSString *)goCity EndCity:(NSString *)endCity FlightNo:(NSString *)flightNo;

//支付缓存第一次往返数据
+(void)run_time:(NSString *)run_time start_time:(NSString *)start_time arrive_time:(NSString *)arrive_time start_airport:(NSString *)start_airport start_terminal:(NSString *)start_terminal arrive_airport:(NSString *)arrive_airport arrive_terminal:(NSString *)arrive_terminal airport_flight:(NSString *)airport_flight airport_name:(NSString *)airport_name airport_code:(NSString *)airport_code is_quick_meal:(NSString *)is_quick_meal plane_type:(NSString *)plane_type airrax:(NSString *)airrax fuel_oil:(NSString *)fuel_oil is_tehui:(NSString *)is_tehui is_spe:(NSString *)is_spe price:(NSString *)price cabin:(NSString *)cabin bookpara:(NSString *)bookpara shipping_space:(NSString *)shipping_space Text:(NSString *)text;

//缓存刷选航空公司
+(void)Airline_airway:(NSString *)airline_airway;
+(void)Shipping_space:(NSString *)shipping_space;
+(void)Plane_type:(NSString *)plane_type;

+(void)Airline_airway1:(NSString *)airline_airway;
+(void)Shipping_space1:(NSString *)shipping_space;
+(void)Plane_type1:(NSString *)plane_type;

//清楚航空公司缓存
+(void)RemoveGongSi;

//清楚舱位缓存
+(void)RemoveCangWei;

//清楚机型缓存
+(void)RemoveJiXing;

//清楚航空公司缓存
+(void)RemoveGongSi1;

//清楚舱位缓存
+(void)RemoveCangWei1;

//清楚机型缓存
+(void)RemoveJiXing1;

//清除往返缓存
+(void)RemoveAirGo;

//清除缓存数组
+(void)removeAllArray;

+(void)removeAirline_airway;

+(void)removeAirline_airway1;
@end
