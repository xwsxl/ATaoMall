//
//  PeccancecyInfoModel.h
//  aTaohMall
//
//  Created by Zhending Shi on 2017/7/25.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "PeccancecyBaseModel.h"

@interface PeccancecyInfoModel : PeccancecyBaseModel
//车牌号
@property(nonatomic,copy)NSString *PlateNumberStr;
//违章地点
@property(nonatomic,copy)NSString *PeccancecyPlaceStr;
//违章类型
@property(nonatomic,copy)NSString *PeccancecyTypeStr;
//违章时间
@property(nonatomic,copy)NSString *PeccancecyTimeStr;
//扣分
@property(nonatomic,copy)NSString *PeccancecyDecuteMarksStr;
//罚款
@property(nonatomic,copy)NSString *PeccancecyFineStr;

@property(nonatomic,copy)NSString *city;

@property(nonatomic,copy)NSString *note;

@property(nonatomic,copy)NSString *type;

@property(nonatomic,copy)NSString *zhiNaJin;

@property(nonatomic,copy)NSString *deductPointType;

@property(nonatomic,copy)NSString *serviceFee;

@property(nonatomic,copy)NSString *canHandle;

@property(nonatomic,copy)NSString *behavior;

@property(nonatomic,copy)NSString *peccID;


@end
