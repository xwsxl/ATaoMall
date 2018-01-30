//
//  PersonalShoppingDanDetailModel.h
//  aTaohMall
//
//  Created by DingDing on 2017/11/6.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PersonalSingleShoppingDetailModel.h"

@interface PersonalShoppingDanDetailModel : NSObject
@property (nonatomic,strong)NSString *buyer_message;
@property (nonatomic,strong)NSString *logo;
@property (nonatomic,strong)NSString *message;
@property (nonatomic,strong)NSString *mid;
@property (nonatomic,strong)NSString *order_batchid;

@property (nonatomic,strong)NSMutableArray *order_list;

@property (nonatomic,strong)NSString *pay_date;
@property (nonatomic,strong)NSString *storename;
@property (nonatomic,strong)NSString *total_freight;
@property (nonatomic,strong)NSString *total_integral;
@property (nonatomic,strong)NSString *total_money;
@property (nonatomic,strong)NSString *total_status;
@property (nonatomic,strong)NSString *uaddress;
@property (nonatomic,strong)NSString *uphone;
@property (nonatomic,strong)NSString *userName;
/*
 String sys_date = "";            //创建时间
String pay_time = "";            //付款时间
String leave_date = "";            //发货时间
String checkdate = "";            //交易时间
String refund_time = "";        //退款/仅退款/退款退货时间
String sure_refund_time = "";    //确认退款时间
 */
@property (nonatomic,strong)NSString *sys_date;
@property (nonatomic,strong)NSString *pay_time;
@property (nonatomic,strong)NSString *leave_date;
@property (nonatomic,strong)NSString *checkdate;
@property (nonatomic,strong)NSString *refund_time;
@property (nonatomic,strong)NSString *sure_refund_time;


//String logistics_message = "";        //物流状态说明
//String logistics_time = "";            //物流时间
@property (nonatomic,strong)NSString *logistics_message;
@property (nonatomic,strong)NSString *logistics_time;


/*
 分区头高度
 */
@property (nonatomic,assign)CGFloat headerHeight;
/*
 分区尾高度
 */
@property (nonatomic,assign)CGFloat footHeight;
/*
 */
@property (nonatomic)BOOL BottomButShow;

-(void)orderListFromArray:(NSArray *)tempArr;

@end
