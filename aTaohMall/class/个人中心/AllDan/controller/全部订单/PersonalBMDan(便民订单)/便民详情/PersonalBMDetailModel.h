//
//  PersonalBMDetailModel.h
//  aTaohMall
//
//  Created by Hawky on 2017/11/30.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XLUserModel.h"
#import "XLTrainModel.h"
#import "XLIllegalModel.h"
#import "XLAirplaneModel.h"




@interface PersonalBMDetailModel : NSObject
@property (nonatomic, copy) NSString *phone;

@property (nonatomic, copy) NSString *paymoney;

@property (nonatomic, copy) NSString *message;

@property (nonatomic, copy) NSString *end_date;

@property (nonatomic, copy) NSString *is_aviation_accident_insurance;

@property (nonatomic, copy) NSString *dishonour_start_time;

@property (nonatomic, copy) NSString *linkman_name;

@property (nonatomic, copy) NSString *orderno;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *logo;

@property (nonatomic, copy) NSString *payintegral;

@property (nonatomic, copy) NSString *refund_type;

@property (nonatomic, strong) NSArray *list_user;

@property (nonatomic, copy) NSString *actual_time;

@property (nonatomic, strong) NSArray *list_airplane;

@property (nonatomic, copy) NSString *dishonour_arrive_time;

@property (nonatomic, copy) NSString *status;

@property (nonatomic, copy) NSString *getdate;

/*
 话费和流量
 */
@property (nonatomic, copy) NSString *alone_integral;

@property (nonatomic, copy) NSString *storename;

//@property (nonatomic, copy) NSString *phone;
//
//@property (nonatomic, copy) NSString *paymoney;

@property (nonatomic, copy) NSString *card_name;

//@property (nonatomic, copy) NSString *message;
//
//@property (nonatomic, copy) NSString *end_date;

@property (nonatomic, copy) NSString *order_type;

//@property (nonatomic, copy) NSString *payintegral;
//
//@property (nonatomic, copy) NSString *orderno;
//
//@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *refund_date;

@property (nonatomic, copy) NSString *alone_money;

@property (nonatomic, copy) NSString *number;

@property (nonatomic, copy) NSString *scopeimg;

@property (nonatomic, copy) NSString *arrive_date;

//@property (nonatomic, copy) NSString *status;
//
//@property (nonatomic, copy) NSString *getdate;

/*
 火车票
 */
//@property (nonatomic, copy) NSString *phone;
//
//@property (nonatomic, copy) NSString *paymoney;
//
//@property (nonatomic, copy) NSString *message;
//
//@property (nonatomic, copy) NSString *end_date;
//
//@property (nonatomic, copy) NSString *payintegral;

@property (nonatomic, copy) NSString *service_charge;

@property (nonatomic, copy) NSString *order_id;

//@property (nonatomic, copy) NSString *orderno;
//
//@property (nonatomic, copy) NSString *type;
//
//@property (nonatomic, copy) NSString *logo;

@property (nonatomic, copy) NSString *refunds_date;

//@property (nonatomic, copy) NSString *refund_type;
//
//@property (nonatomic, strong) NSArray *list_user;
//
//@property (nonatomic, copy) NSString *actual_time;

@property (nonatomic, strong) NSArray *list;

@property (nonatomic, copy) NSString *ticket_code;

//@property (nonatomic, copy) NSString *dishonour_arrive_time;
//
//@property (nonatomic, copy) NSString *status;
//
//@property (nonatomic, copy) NSString *getdate;
/*
 违章
 */
@property (nonatomic, copy) NSString *carNo;

@property (nonatomic, copy) NSString *dishonour_time;

@property (nonatomic, copy) NSString *uid;

//@property (nonatomic, copy) NSString *paymoney;
//
//@property (nonatomic, copy) NSString *message;
//
//@property (nonatomic, copy) NSString *order_type;
//
//@property (nonatomic, copy) NSString *payintegral;

@property (nonatomic, copy) NSString *contactName;

//@property (nonatomic, copy) NSString *orderno;

@property (nonatomic, copy) NSString *sta;

@property (nonatomic, copy) NSString *tel;

@property (nonatomic, copy) NSString *totalfreight;

@property (nonatomic, strong) NSArray *list2;

//@property (nonatomic, copy) NSString *status;

@property (nonatomic, copy) NSString *pay_time;

@property (nonatomic,strong)NSString *is_refund;

-(void)getlistUserWithArray:(NSArray *)tempArr;
-(void)getListAirplaneWithArray:(NSArray *)tempArr;
-(void)getTrainListWithArray:(NSArray *)tempArr;
-(void)GetIllegalList2WithArray:(NSArray *)tempArr;

@end
