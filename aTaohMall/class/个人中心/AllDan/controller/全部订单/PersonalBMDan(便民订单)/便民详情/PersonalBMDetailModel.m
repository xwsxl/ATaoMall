//
//  PersonalBMDetailModel.m
//  aTaohMall
//
//  Created by Hawky on 2017/11/30.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "PersonalBMDetailModel.h"

@implementation PersonalBMDetailModel

-(void)setActual_time:(NSString *)actual_time
{
    _actual_time=actual_time;
    
}

-(void)getlistUserWithArray:(NSArray *)tempArr
{
    [NSObject printPropertyWithDict:tempArr.firstObject];
    NSMutableArray *arr=[NSMutableArray new];
_list_user=[[NSArray alloc] init];
    for (NSDictionary *dic in tempArr) {
        XLUserModel *model=[[XLUserModel alloc] init];
        model.passportseno=[NSString stringWithFormat:@"%@",dic[@"passportseno"]];

        model.child_name=[NSString stringWithFormat:@"%@",dic[@"child_name"]];

        model.ID=[NSString stringWithFormat:@"%@",dic[@"id"]];

        model.passengersename=[NSString stringWithFormat:@"%@",dic[@"passengersename"]];

        model.piaotypename=[NSString stringWithFormat:@"%@",dic[@"piaotypename"]];

        model.cxin=[NSString stringWithFormat:@"%@",dic[@"cxin"]];

        model.passporttypeseid=[NSString stringWithFormat:@"%@",dic[@"passporttypeseid"]];

        model.passporttypeseidname=[NSString stringWithFormat:@"%@",dic[@"passporttypeseidname"]];

        model.seat_type_name=[NSString stringWithFormat:@"%@",dic[@"seat_type_name"]];

        model.piaotype=[NSString stringWithFormat:@"%@",dic[@"piaotype"]];

        /*
         机票
         */
        model.adult_banks=[NSString stringWithFormat:@"%@",dic[@"adult_banks"]];

        model.username=[NSString stringWithFormat:@"%@",dic[@"username"]];
        
        [arr addObject:model];

    }
    self.list_user=[NSArray arrayWithArray:[arr copy]];

}

-(void)getListAirplaneWithArray:(NSArray *)tempArr
{
    [NSObject printPropertyWithDict:tempArr.firstObject];
    NSMutableArray *arr=[NSMutableArray new];
    _list_airplane=[[NSArray alloc] init];
    for (NSDictionary *dic in tempArr) {
         XLAirplaneModel *model=[[XLAirplaneModel alloc] init];
        model.start_airport=[NSString stringWithFormat:@"%@",dic[@"start_airport"]];

        model.arrive_city_name=[NSString stringWithFormat:@"%@",dic[@"arrive_city_name"]];

        model.flight_type=[NSString stringWithFormat:@"%@",dic[@"flight_type"]];

        model.start_terminal=[NSString stringWithFormat:@"%@",dic[@"start_terminal"]];

        model.airport_name=[NSString stringWithFormat:@"%@",dic[@"airport_name"]];

        model.start_time=[NSString stringWithFormat:@"%@",dic[@"start_time"]];

        model.PlaneType=[NSString stringWithFormat:@"%@",dic[@"PlaneType"]];

        model.start_city_name=[NSString stringWithFormat:@"%@",dic[@"start_city_name"]];

        model.date=[NSString stringWithFormat:@"%@",dic[@"date"]];

        model.arrive_time=[NSString stringWithFormat:@"%@",dic[@"arrive_time"]];

        model.arrive_airport=[NSString stringWithFormat:@"%@",dic[@"arrive_airport"]];

        model.airport_flight=[NSString stringWithFormat:@"%@",dic[@"airport_flight"]];

        model.plane_model=[NSString stringWithFormat:@"%@",dic[@"plane_model"]];

        model.week=[NSString stringWithFormat:@"%@",dic[@"week"]];

        model.run_time=[NSString stringWithFormat:@"%@",dic[@"run_time"]];
        [arr addObject:model];

    }
self.list_airplane=[NSArray arrayWithArray:[arr copy]];
}

-(void)getTrainListWithArray:(NSArray *)tempArr
{
    [NSObject printPropertyWithDict:tempArr.firstObject];
    NSMutableArray *arr=[NSMutableArray new];
    _list=[[NSArray alloc] init];
    for (NSDictionary *dic in tempArr) {
         XLTrainModel *model=[[XLTrainModel alloc] init];
        model.start_station_name=[NSString stringWithFormat:@"%@",dic[@"start_station_name"]];

        model.arrive_station_name=[NSString stringWithFormat:@"%@",dic[@"arrive_station_name"]];

        model.arrive_time=[NSString stringWithFormat:@"%@",dic[@"arrive_time"]];

        model.start_time=[NSString stringWithFormat:@"%@",dic[@"start_time"]];

        model.checi=[NSString stringWithFormat:@"%@",dic[@"checi"]];

        model.date=[NSString stringWithFormat:@"%@",dic[@"date"]];

        model.run_time=[NSString stringWithFormat:@"%@",dic[@"run_time"]];
        [arr addObject:model];

    }
    self.list=[NSArray arrayWithArray:[arr copy]];
}

-(void)GetIllegalList2WithArray:(NSArray *)tempArr
{
    [NSObject printPropertyWithDict:tempArr.firstObject];
    NSMutableArray *arr=[NSMutableArray new];
    for (NSDictionary *dic in tempArr) {
        _list2=[[NSArray alloc] init];
         XLIllegalModel *model=[[XLIllegalModel alloc] init];
        model.behavior=[NSString stringWithFormat:@"%@",dic[@"behavior"]];

        model.serviceFee=[NSString stringWithFormat:@"%@",dic[@"serviceFee"]];

        model.address=[NSString stringWithFormat:@"%@",dic[@"address"]];

        model.time=[NSString stringWithFormat:@"%@",dic[@"time"]];
        
        model.deductPoint=[NSString stringWithFormat:@"%@",dic[@"deductPoint"]];

        model.fine=[NSString stringWithFormat:@"%@",dic[@"fine"]];

        model.zhinajin=[NSString stringWithFormat:@"%@",dic[@"zhinajin"]];

        model.cityName=[NSString stringWithFormat:@"%@",dic[@"cityName"]];
        [arr addObject:model];
    }
    self.list2=[NSArray arrayWithArray:[arr copy]];
}

@end
