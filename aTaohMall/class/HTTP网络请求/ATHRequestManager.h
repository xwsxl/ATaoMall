//
//  ATHRequestManager.h
//  aTaohMall
//
//  Created by DingDing on 2017/8/17.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^Result)(id responseObj,NSError *error);
//请求数据成功的Block
typedef void(^Success)(NSDictionary *responseObj);
//请求失败的Block
typedef void(^Failure)(NSError *error);

@interface ATHRequestManager : NSObject
/*******************************************************      首页改版       ******************************************************/
/**
获取大牌推荐列表数据

@param params <#params description#>
@param success <#success description#>
@param faild <#faild description#>
*/
+(void)requestforselectBrandToDataWithParams:(id)params successBlock:(Success)success faildBlock:(Failure)faild;
/**
获取好货特卖数据

@param params <#params description#>
@param success <#success description#>
@param faild <#faild description#>
*/
+(void)requestforgetGoodSellGoodsListWithParams:(id)params successBlock:(Success)success faildBlock:(Failure)faild;
/**
获取极客驿站商品列表

@param params <#params description#>
@param success <#success description#>
@param faild <#faild description#>
*/
+(void)requestforgetGeekPostGoodsListWithParams:(id)params successBlock:(Success)success faildBlock:(Failure)faild;
/**
 获取最近新品商品列表

 @param params <#params description#>
 @param success <#success description#>
 @param faild <#faild description#>
 */
+(void)requestforgetLatestGoodsListWithParams:(id)params successBlock:(Success)success faildBlock:(Failure)faild;

/**
 <!-- 获取热销排行顶部类型 -->

 @param params <#params description#>
 @param success <#success description#>
 @param faild <#faild description#>
 */
+(void)requestforgetHotSalesHeadTypeWithParams:(id)params successBlock:(Success)success faildBlock:(Failure)faild;


/**
 获取热销类型对应商品集合
 @param params <#params description#>
 @param success <#success description#>
 @param faild <#faild description#>
 */
+(void)requestforgetHotSalesGoodsListWithParams:(id)params successBlock:(Success)success faildBlock:(Failure)faild;
/**
获取有好货数据

@param params <#params description#>
@param success <#success description#>
@param faild <#faild description#>
*/
+(void)requestforgetGoodGoodsListWithParams:(id)params successBlock:(Success)success faildBlock:(Failure)faild;
/**
 获取海外购物佳楼层数据

 @param params <#params description#>
 @param success <#success description#>
 @param faild <#faild description#>
 */
+(void)requestforgetShopJiaNameWithParams:(id)params successBlock:(Success)success faildBlock:(Failure)faild;

/**
 获取海外购物佳楼层商品

 @param params <#params description#>
 @param success <#success description#>
 @param faild <#faild description#>
 */
+(void)requestforgetShopJiaGoodsWithParams:(id)params successBlock:(Success)success faildBlock:(Failure)faild;
/*******************************************************      订单列表整合       ******************************************************/
/**
 获取商品订单数据

 @param params <#params description#>
 @param success <#success description#>
 @param faild <#faild description#>
 */
+(void)requestforGetShoppingListWithParams:(id)params successBlock:(Success)success faildBlock:(Failure)faild;

/**
 获取商品订单详情数据

 @param params <#params description#>
 @param success <#success description#>
 @param faild <#faild description#>
 */
+(void)requestforGetShoppingDanDetailWithParams:(id)params successBlock:(Success)success faildBlock:(Failure)faild;
/**
 判断是否可以确认收货

 @param params <#params description#>
 @param success <#success description#>
 @param faild <#faild description#>
 */
+(void)requestforCheckSureReceiveGoodsWithParams:(id)params successBlock:(Success)success faildBlock:(Failure)faild;
/**
 确认收货

 @param params <#params description#>
 @param success <#success description#>
 @param faild <#faild description#>
 */
+(void)requestforSureReceiveGoodsWithParams:(id)params successBlock:(Success)success faildBlock:(Failure)faild;


/**
 查询物流判断包裹个数

 @param params <#params description#>
 @param success <#success description#>
 @param faild <#faild description#>
 */
+(void)requestforGetLogisticsNumberWithParams:(id)params successBlock:(Success)success faildBlock:(Failure)faild;
/**
 查询物流详细信息

 入参数：
 order_batchid        // 订单号批次号

 waybillnumber        // 运单号  （注：从订单详情(订单列表) 点击 查询物流 传空，  从包裹列表查询物流 传对应的 运单号）
 @param params <#params description#>
 @param success <#success description#>
 @param faild <#faild description#>
 */
+(void)requestforqueryLogisticsWithParams:(id)params successBlock:(Success)success faildBlock:(Failure)faild;
/**
 删除订单
 @param params <#params description#>
 @param success <#success description#>
 @param faild <#faild description#>
 */
+(void)requestforDelNotPayOrderWithParams:(id)params successBlock:(Success)success faildBlock:(Failure)faild;
/**
 退款订单列表
 @param params <#params description#>
 @param success <#success description#>
 @param faild <#faild description#>
 */
+(void)requestforGetOrderRefundListByGoodsWithParams:(id)params successBlock:(Success)success faildBlock:(Failure)faild;
/**
 添加退款商品
 @param params <#params description#>
 @param success <#success description#>
 @param faild <#faild description#>
 */
+(void)requestforAddRefundOrderWithParams:(id)params successBlock:(Success)success faildBlock:(Failure)faild;
/**
 退款详情
 @param params <#params description#>
 @param success <#success description#>
 @param faild <#faild description#>
 */
+(void)requestforgetRefundOrderDetailsByGoodsWithParams:(id)params successBlock:(Success)success faildBlock:(Failure)faild;
/**
 退款次数
 @param params <#params description#>
 @param success <#success description#>
 @param faild <#faild description#>
 */
+(void)requestforgetRefundNumberWithParams:(id)params successBlock:(Success)success faildBlock:(Failure)faild;
/**
 协商记录
 @param params <#params description#>
 @param success <#success description#>
 @param faild <#faild description#>
 */
+(void)requestforgetRefunRecordWithParams:(id)params successBlock:(Success)success faildBlock:(Failure)faild;
/**
 客服介入
 @param params <#params description#>
 @param success <#success description#>
 @param faild <#faild description#>
 */
+(void)requestforgetNoRefundWithParams:(id)params successBlock:(Success)success faildBlock:(Failure)faild;
/**
 退货物流
 @param params <#params description#>
 @param success <#success description#>
 @param faild <#faild description#>
 */
+(void)requestforqueryUserLogisticsWithParams:(id)params successBlock:(Success)success faildBlock:(Failure)faild;
/**
 便民列表
 @param params <#params description#>
 @param success <#success description#>
 @param faild <#faild description#>
 */
+(void)requestforgetOrderListByBMWithParams:(id)params successBlock:(Success)success faildBlock:(Failure)faild;
/**
 话费
 @param params <#params description#>
 @param success <#success description#>
 @param faild <#faild description#>
 */
+(void)requestforgetOrderDetailsByPhoneWithParams:(id)params successBlock:(Success)success faildBlock:(Failure)faild;
/**
 违章详情
 @param params <#params description#>
 @param success <#success description#>
 @param faild <#faild description#>
 */
+(void)requestforillegalOrderDetailsWithParams:(id)params successBlock:(Success)success faildBlock:(Failure)faild;
/**
 飞机票详情
 @param params <#params description#>
 @param success <#success description#>
 @param faild <#faild description#>
 */
+(void)requestforgetOrderDetailsByAirplaneWithParams:(id)params successBlock:(Success)success faildBlock:(Failure)faild;
/**
 火车票详情
 @param params <#params description#>
 @param success <#success description#>
 @param faild <#faild description#>
 */
+(void)requestforgetOrderDetailsByTrainWithParams:(id)params successBlock:(Success)success faildBlock:(Failure)faild;
/**
 在处理中
 @param params <#params description#>
 @param success <#success description#>
 @param faild <#faild description#>
 */
+(void)requestforgetOrderCountWithParams:(id)params successBlock:(Success)success faildBlock:(Failure)faild;
/*******************************************************      小家电专场       ******************************************************/

/**
 获取数据
 
 @param params <#params description#>
 @param success <#success description#>
 @param faild <#faild description#>
 */
+(void)requestforGetMoreAppliancesListWithParams:(id)params successBlock:(Success)success faildBlock:(Failure)faild;

/**
 大健康专区获取数据

 @param params <#params description#>
 @param success <#success description#>
 @param faild <#faild description#>
 */
+(void)requestforGetMoreBigHeathyListWithParams:(id)params successBlock:(Success)success faildBlock:(Failure)faild;
/*******************************************************      引导页       ******************************************************/

/**
 引导页接口
 
 @param params <#params description#>
 @param success <#success description#>
 @param faild <#faild description#>
 */
+(void)requestforAppdelegateWithParams:(id)params successBlock:(Success)success faildBlock:(Failure)faild;
/*******************************************************      我的页面       ******************************************************/
/**
 登录接口
 
 @param params <#params description#>
 @param success <#success description#>
 @param faild <#faild description#>
 */
+(void)requestforMineLogInWithParams:(id)params successBlock:(Success)success faildBlock:(Failure)faild;

/*******************************************************      违章       ******************************************************/
/**
 获取车辆数据接口
 
 @param params <#params description#>
 @param success <#success description#>
 @param faild <#faild description#>
 */
+(void)requestForCarDataWithParams:(id)params successBlock:(Success)success faildBlock:(Failure)faild;
/**
 获取单个车辆的违章信息
 
 @param params <#params description#>
 @param success <#success description#>
 @param faild <#faild description#>
 */
+(void)requestForCarPeccDataWithParams:(id)params successBlock:(Success)success faildBlock:(Failure)faild;

/*******************************************************      飞机票       ******************************************************/
/**
 获取能否退票信息

 @param params <#params description#>
 @param success <#success description#>
 @param faild <#faild description#>
 */
+(void)requestForCanRefundInfoWithParams:(id)params successBlock:(Success)success faildBlock:(Failure)faild;
/**
 判断机票退票时间段
 
 @param success <#success description#>
 @param faild <#faild description#>
 */
+(void)requestForRefundDataConfirmSuccessBlock:(Success)success faildBlock:(Failure)faild;

/**
 确定退票
 
 @param params <#params description#>
 @param success <#success description#>
 @param faild <#faild description#>
 */
+(void)requestForSureRefundAirOrderWithParams:(NSDictionary *)params successBlock:(Success)success faildBlock:(Failure)faild;

/*******************************************************      火车票       ******************************************************/
/**
 购票流程
 
 @param params <#params description#>
 @param success <#success description#>
 @param faild <#faild description#>
 */
+(void)requestForTicketsProgressWithParams:(NSDictionary *)params successBlock:(Success)success faildBlock:(Failure)faild;


/*******************************************************      推送       ******************************************************/

/**
 上传token值
 
 @param params <#params description#>
 @param success <#success description#>
 @param faild <#faild description#>
 */
+(void)requestforPostTokenToServerWithParams:(id)params successBlock:(Success)success faildBlock:(Failure)faild;
/**
 删除无效token值

 @param params <#params description#>
 @param success <#success description#>
 @param faild <#faild description#>
 */
+(void)requestforDeleteTokenToServerWithParams:(id)params successBlock:(Success)success faildBlock:(Failure)faild;
///**
// 修改系统消息状态
//
// @param params <#params description#>
// @param success <#success description#>
// @param faild <#faild description#>
// */
//+(void)requestforUpdateAppPushSystemInfoWithParams:(id)params successBlock:(Success)success faildBlock:(Failure)faild;

/**
 修改服务器触发推送消息状态
 
 @param params <#params description#>
 @param success <#success description#>
 @param faild <#faild description#>
 */
+(void)requestforAppUpdatePushTriggerInfoWithParams:(id)params successBlock:(Success)success faildBlock:(Failure)faild;


/**
 消息列表
 
 @param params <#params description#>
 @param success <#success description#>
 @param faild <#faild description#>
 */
+(void)requestforHomeGetMessageListWithParams:(id)params successBlock:(Success)success faildBlock:(Failure)faild;

/**
 更改为已读
 
 @param params <#params description#>
 @param success <#success description#>
 @param faild <#faild description#>
 */
+(void)requestForMessageChangePushIsReadWithParams:(id)params successBlock:(Success)success faildBlock:(Failure)faild;
/**
 删除消息
 
 @param params <#params description#>
 @param success <#success description#>
 @param faild <#faild description#>
 */
+(void)requestForMessageListDeleteMsgWithParams:(id)params successBlock:(Success)success faildBlock:(Failure)faild;
/**
 获取单条系统消息详细记录
 
 @param params <#params description#>
 @param success <#success description#>
 @param faild <#faild description#>
 */
+(void)requestForMessageListSystemMsgWithParams:(id)params successBlock:(Success)success faildBlock:(Failure)faild;
/**
 获取订单实时数据
 
 @param params <#params description#>
 @param success <#success description#>
 @param faild <#faild description#>
 */
+(void)requestForGetOrderStatusWithParams:(id)params successBlock:(Success)success faildBlock:(Failure)faild;
/**
 获取未读消息数目
 @param params <#params description#>
 @param success <#success description#>
 @param faild <#faild description#>
 */
+(void)requestForGetUnreadMessageNumWithParams:(id)params successBlock:(Success)success faildBlock:(Failure)faild;
/**
 获取单条系统消息详细记录//登录
 
 @param params <#params description#>
 @param success <#success description#>
 @param faild <#faild description#>
 */
+(void)requestForMessageListSystemMsgLogInWithParams:(id)params successBlock:(Success)success faildBlock:(Failure)faild;
@end
