//
//  RecordAirManger.m
//  aTaohMall
//
//  Created by JMSHT on 2017/5/15.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "RecordAirManger.h"

@implementation RecordAirManger


//飞机票重复城市
+(void)SearchTextwithRepeat :(NSString *)seaTxt
{
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数组NSArray类型的数据
    NSArray *myArray = [userDefaultes arrayForKey:@"Air"];
    // NSArray --> NSMutableArray
    NSMutableArray *searTXT = [myArray mutableCopy];

    [searTXT removeObject:seaTxt];
    [searTXT addObject:seaTxt];

    [userDefaultes setObject:searTXT forKey:@"Air"];
    [userDefaultes synchronize];
}

//缓存搜索数组
+(void)SearchText :(NSString *)seaTxt
{
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数组NSArray类型的数据
    NSArray *myArray = [userDefaultes arrayForKey:@"Air"];
    if (myArray.count > 0) {//先取出数组，判断是否有值，有值继续添加，无值创建数组
        
    }else{
        myArray = [NSArray array];
    }
    // NSArray --> NSMutableArray
    NSMutableArray *searTXT = [myArray mutableCopy];
    [searTXT addObject:seaTxt];
    while (searTXT.count >= 5)
    {
        [searTXT removeObjectAtIndex:0];
    }
    //将上述数据全部存储到NSUserDefaults中
    //        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaultes setObject:searTXT forKey:@"Air"];
    [userDefaultes synchronize];
    
}

//缓存飞机票查询城市
+(void)SearchTrainwithRepeat :(NSString *)seaTxt
{
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数组NSArray类型的数据
    NSArray *myArray = [userDefaultes arrayForKey:@"Train"];
    // NSArray --> NSMutableArray
    NSMutableArray *searTXT = [myArray mutableCopy];

    [searTXT removeObject:seaTxt];
    [searTXT addObject:seaTxt];

    [userDefaultes setObject:searTXT forKey:@"Train"];
    [userDefaultes synchronize];
}

//缓存飞机票查询城市
+(void)SearchTrain :(NSString *)seaTxt
{
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数组NSArray类型的数据
    NSArray *myArray = [userDefaultes arrayForKey:@"Train"];
    if (myArray.count > 0) {//先取出数组，判断是否有值，有值继续添加，无值创建数组
        
    }else{
        myArray = [NSArray array];
    }
    // NSArray --> NSMutableArray
    NSMutableArray *searTXT = [myArray mutableCopy];
    [searTXT addObject:seaTxt];
    while (searTXT.count >= 5)
    {
        [searTXT removeObjectAtIndex:0];
    }
    [userDefaultes setObject:searTXT forKey:@"Train"];
    [userDefaultes synchronize];
}

//缓存飞机票日期
+(void)TrainDate:(NSString *)date Week:(NSString *)week
{
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    [userDefaultes setObject:date forKey:@"TrainDate"];
    [userDefaultes setObject:date forKey:@"TrainWeek"];
    [userDefaultes synchronize];
    
}

+(void)Airline_airway:(NSString *)airline_airway
{
    
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    [userDefaultes setObject:airline_airway forKey:@"airline_airway"];
    [userDefaultes synchronize];
    
}

+(void)Shipping_space:(NSString *)shipping_space
{
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    [userDefaultes setObject:shipping_space forKey:@"shipping_space"];
    [userDefaultes synchronize];
    
}
+(void)Plane_type:(NSString *)plane_type
{
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    [userDefaultes setObject:plane_type forKey:@"plane_type"];
    [userDefaultes synchronize];
    
}

+(void)Airline_airway1:(NSString *)airline_airway
{
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数组NSArray类型的数据
    NSArray *myArray = [userDefaultes arrayForKey:@"airline_airway1"];
    if (myArray.count > 0) {//先取出数组，判断是否有值，有值继续添加，无值创建数组
        
    }else{
        myArray = [NSArray array];
    }
    // NSArray --> NSMutableArray
    NSMutableArray *searTXT = [myArray mutableCopy];
    [searTXT addObject:airline_airway];
    //    if(searTXT.count > 5)
    //    {
    //        [searTXT removeObjectAtIndex:0];
    //    }
    //将上述数据全部存储到NSUserDefaults中
    //        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaultes setObject:searTXT forKey:@"airline_airway1"];
    [userDefaultes synchronize];
    
}

+(void)Shipping_space1:(NSString *)shipping_space
{
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数组NSArray类型的数据
    NSArray *myArray = [userDefaultes arrayForKey:@"shipping_space1"];
    if (myArray.count > 0) {//先取出数组，判断是否有值，有值继续添加，无值创建数组
        
    }else{
        myArray = [NSArray array];
    }
    // NSArray --> NSMutableArray
    NSMutableArray *searTXT = [myArray mutableCopy];
    [searTXT addObject:shipping_space];
    //    if(searTXT.count > 5)
    //    {
    //        [searTXT removeObjectAtIndex:0];
    //    }
    //将上述数据全部存储到NSUserDefaults中
    //        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaultes setObject:searTXT forKey:@"shipping_space1"];
    [userDefaultes synchronize];
    
}
+(void)Plane_type1:(NSString *)plane_type
{
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数组NSArray类型的数据
    NSArray *myArray = [userDefaultes arrayForKey:@"plane_type1"];
    if (myArray.count > 0) {//先取出数组，判断是否有值，有值继续添加，无值创建数组
        
    }else{
        myArray = [NSArray array];
    }
    // NSArray --> NSMutableArray
    NSMutableArray *searTXT = [myArray mutableCopy];
    [searTXT addObject:plane_type];
    //    if(searTXT.count > 5)
    //    {
    //        [searTXT removeObjectAtIndex:0];
    //    }
    //将上述数据全部存储到NSUserDefaults中
    //        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaultes setObject:searTXT forKey:@"plane_type1"];
    [userDefaultes synchronize];
    
}

+(void)AirDate:(NSString *)date End:(NSString *)endDate
{
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    [userDefaultes setObject:date forKey:@"AirDate"];
    [userDefaultes setObject:endDate forKey:@"endDate"];
    [userDefaultes synchronize];
}

//缓存往返第一次选择信息
+(void)AirGo:(NSString *)goDate Week:(NSString *)goWeek Time:(NSString *)goTime Price:(NSString *)goPrice JiJian:(NSString *)goJiJian StartCity:(NSString *)goCity EndCity:(NSString *)endCity FlightNo:(NSString *)flightNo
{
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    [userDefaultes setObject:goDate forKey:@"goDate"];
    [userDefaultes setObject:goWeek forKey:@"goWeek"];
    [userDefaultes setObject:goTime forKey:@"goTime"];
    [userDefaultes setObject:goPrice forKey:@"goPrice"];
    [userDefaultes setObject:goJiJian forKey:@"goJiJian"];
    [userDefaultes setObject:goCity forKey:@"goCity"];
    [userDefaultes setObject:endCity forKey:@"endCity"];
    [userDefaultes setObject:flightNo forKey:@"flightNo"];
    [userDefaultes synchronize];
    
}

//支付缓存第一次往返数据
+(void)run_time:(NSString *)run_time start_time:(NSString *)start_time arrive_time:(NSString *)arrive_time start_airport:(NSString *)start_airport start_terminal:(NSString *)start_terminal arrive_airport:(NSString *)arrive_airport arrive_terminal:(NSString *)arrive_terminal airport_flight:(NSString *)airport_flight airport_name:(NSString *)airport_name airport_code:(NSString *)airport_code is_quick_meal:(NSString *)is_quick_meal plane_type:(NSString *)plane_type airrax:(NSString *)airrax fuel_oil:(NSString *)fuel_oil is_tehui:(NSString *)is_tehui is_spe:(NSString *)is_spe price:(NSString *)price cabin:(NSString *)cabin bookpara:(NSString *)bookpara shipping_space:(NSString *)shipping_space Text:(NSString *)text
{
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    
    [userDefaultes setObject:run_time forKey:@"run_time"];
    [userDefaultes setObject:start_time forKey:@"start_time"];
    [userDefaultes setObject:arrive_time forKey:@"arrive_time"];
    [userDefaultes setObject:start_airport forKey:@"start_airport"];
    [userDefaultes setObject:start_terminal forKey:@"start_terminal"];
    [userDefaultes setObject:arrive_airport forKey:@"arrive_airport"];
    [userDefaultes setObject:arrive_terminal forKey:@"arrive_terminal"];
    [userDefaultes setObject:airport_flight forKey:@"airport_flight"];
    
    [userDefaultes setObject:airport_name forKey:@"airport_name"];
    [userDefaultes setObject:airport_code forKey:@"airport_code"];
    [userDefaultes setObject:is_quick_meal forKey:@"is_quick_meal"];
    [userDefaultes setObject:plane_type forKey:@"plane_type"];
    [userDefaultes setObject:airrax forKey:@"airrax"];
    [userDefaultes setObject:fuel_oil forKey:@"fuel_oil"];
    [userDefaultes setObject:is_tehui forKey:@"is_tehui"];
    [userDefaultes setObject:is_spe forKey:@"is_spe"];
    [userDefaultes setObject:price forKey:@"Payprice"];
    [userDefaultes setObject:cabin forKey:@"cabin"];
    [userDefaultes setObject:bookpara forKey:@"bookpara"];
    [userDefaultes setObject:shipping_space forKey:@"shipping_space"];
    [userDefaultes setObject:text forKey:@"texttext"];
    [userDefaultes synchronize];
    
    
}
//清除往返缓存
+(void)RemoveAirGo
{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:@"goDate"];
    [userDefaults removeObjectForKey:@"goWeek"];
    [userDefaults removeObjectForKey:@"goTime"];
    [userDefaults removeObjectForKey:@"goPrice"];
    [userDefaults removeObjectForKey:@"goJiJian"];
    [userDefaults removeObjectForKey:@"goCity"];
    [userDefaults removeObjectForKey:@"endCity"];
    [userDefaults removeObjectForKey:@"flightNo"];
    
    [userDefaults removeObjectForKey:@"run_time"];
    [userDefaults removeObjectForKey:@"start_time"];
    [userDefaults removeObjectForKey:@"arrive_time"];
    [userDefaults removeObjectForKey:@"start_airport"];
    [userDefaults removeObjectForKey:@"start_terminal"];
    [userDefaults removeObjectForKey:@"arrive_airport"];
    [userDefaults removeObjectForKey:@"arrive_terminal"];
    [userDefaults removeObjectForKey:@"airport_flight"];
    
    [userDefaults removeObjectForKey:@"airport_name"];
    [userDefaults removeObjectForKey:@"airport_code"];
    [userDefaults removeObjectForKey:@"is_quick_meal"];
    [userDefaults removeObjectForKey:@"plane_type"];
    [userDefaults removeObjectForKey:@"airrax"];
    [userDefaults removeObjectForKey:@"fuel_oil"];
    [userDefaults removeObjectForKey:@"is_tehui"];
    [userDefaults removeObjectForKey:@"is_spe"];
    [userDefaults removeObjectForKey:@"Payprice"];
    [userDefaults removeObjectForKey:@"cabin"];
    [userDefaults removeObjectForKey:@"bookpara"];
    [userDefaults removeObjectForKey:@"shipping_space"];
    [userDefaults removeObjectForKey:@"texttext"];
    [userDefaults synchronize];
    
}

+(void)RemoveDate
{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:@"AirDate"];
    [userDefaults removeObjectForKey:@"endDate"];
    [userDefaults synchronize];
    
}


//清楚航空公司缓存
+(void)RemoveGongSi
{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:@"airline_airway"];
    [userDefaults synchronize];
    
}

//清楚舱位缓存
+(void)RemoveCangWei
{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:@"shipping_space"];
    [userDefaults synchronize];
    
}

//清楚机型缓存
+(void)RemoveJiXing
{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:@"plane_type"];
    [userDefaults synchronize];
    
}

+(void)removeAirline_airway
{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:@"airline_airway"];
    [userDefaults removeObjectForKey:@"plane_type"];
    [userDefaults removeObjectForKey:@"shipping_space"];
    [userDefaults synchronize];
    
}


//清楚航空公司缓存
+(void)RemoveGongSi1
{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:@"airline_airway1"];
    [userDefaults synchronize];
    
}

//清楚舱位缓存
+(void)RemoveCangWei1
{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:@"shipping_space1"];
    [userDefaults synchronize];
    
}

//清楚机型缓存
+(void)RemoveJiXing1
{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:@"plane_type1"];
    [userDefaults synchronize];
    
}

+(void)removeAirline_airway1
{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:@"airline_airway1"];
    [userDefaults removeObjectForKey:@"plane_type1"];
    [userDefaults removeObjectForKey:@"shipping_space1"];
    [userDefaults synchronize];
    
}

+(void)removeAllArray{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:@"Air"];
    [userDefaults synchronize];
}

//清除缓存数组
+(void)TrainremoveAllArray
{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:@"Train"];
    [userDefaults synchronize];
    
}

@end
