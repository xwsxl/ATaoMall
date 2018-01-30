//
//  CarInfoModel.h
//  aTaohMall
//
//  Created by Zhending Shi on 2017/7/25.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "PeccancecyBaseModel.h"

@interface CarInfoModel : PeccancecyBaseModel
@property(nonatomic,copy)NSString *carID;
//车牌号
@property(nonatomic,copy)NSString *PlateNumberStr;
//要查询的城市列表
@property(nonatomic,strong)NSMutableArray *CityListArr;
//车架号
@property(nonatomic,copy)NSString *FrameNumberStr;
//发动机号
@property(nonatomic,copy)NSString *EngineNumberStr;
//备注名
@property(nonatomic,copy)NSString *RemarkNameStr;
//行驶证路径
@property(nonatomic,copy)NSString *DrivingLicenceStr;

//待处理违章
@property(nonatomic,copy)NSString *PendingPeccancecyStr;
@property(nonatomic,strong)NSMutableArray *PendingPeccancecyArr;
//总扣分数
@property(nonatomic,copy)NSString *TotalDeductMarkStr;
//总罚款数
@property(nonatomic,copy)NSString *TotalFineStr;
//更新时间
@property(nonatomic,copy)NSString *UpdateTimeStr;


@end
