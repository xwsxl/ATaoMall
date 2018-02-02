//
//  ConstHeader.h
//  aTaohMall
//
//  Created by Zhending Shi on 2017/7/17.
//  Copyright © 2017年 ysy. All rights reserved.
//

#ifndef ConstHeader_h
#define ConstHeader_h

/*******************************************************      常量定义       ******************************************************/
/*
//本地
static NSString *const URL_Str=@"http://192.168.1.47:8085/";
//测试支付
static NSString *const URL_Str1=@"http://120.76.245.90:8089/pay/";
//*/

//*
//测试
static NSString *const URL_Str=@"http://120.76.245.90:8089/";
//测试支付
static NSString *const URL_Str1=@"http://120.76.245.90:8089/pay/";
//*/

/*
//线上支付
static NSString *const URL_Str1=@"http://athmall.com/pay/";
//线上
static NSString *const URL_Str=@"http://athmall.com/";
//*/

//支付
//static NSString *const strHttp=@"http://athmall.com/pay/aliWapPay.shtml?";

/*******************************************************      接口地址        ******************************************************/
//获取首页消息列表数据
static NSString *const JMSHTHomeGetMessageListStr=@"getPushInformation_mob.shtml";
//更改消息为已读
static NSString *const JMSHTMessageListChangeIsReadStr=@"changePushIntoRead_mob.shtml";
//删除一条消息
static NSString *const JMSHTMessageListDeleteMsgStr=@"daletePushRecord_mob.shtml";
//获取系统消息
static NSString *const JMSHTMessageListSystemMsgStr=@"appGetPushSysInformation_mob.shtml";

/*******************************************************      小家电       ******************************************************/
//获取小家电数据
static NSString *const JMSHTHomeGetMoreAppliancesListStr=@"getMoreHomeAppliancesList_mob.shtml";
/*******************************************************      我的页面       ******************************************************/
//登录
static NSString *const JMSHTMineLoginStr=@"login_mob.shtml";

/*******************************************************      违章       ******************************************************/

//获取车辆数据接口
static NSString *const JMSHTPeccGetCarDataStr=@"getIllegalHeadList_mob.shtml";
//获取单个车辆的违章信息
static NSString *const JMSHTPeccGetCarPeccDataStr=@"getIllegalRecord_mob.shtml";

/*******************************************************      机票       ******************************************************/
//获取能否退票信息
static NSString *const JMSHTAirGetCanRefundInfoStr=@"airOrderListRefund_mob.shtml";
//判断机票退票时间段
static NSString *const JMSHTAirGetRefundTimeStr=@"airRefundDateJudge_mob.shtml";
//确定退飞机票
static NSString *const JMSHTAirSureRefundTicketsStr=@"sureRefundAirOrder_mob.shtml";

/*******************************************************      火车票       ******************************************************/
//火车票购票流程
static NSString *const JMSHTTrainGetTicketsProgressStr=@"trainTicketProcessDetails_mob.shtml";

/*******************************************************      通知       ******************************************************/
/*****
 *
 *  Description 通知
 *
 ******/

/*******************************************************      通知       ******************************************************/
//登录
static NSString *const JMSHTLoginSuccessNoti=@"JMSHTLoginSuccessNoti";
//退出登录
static NSString *const JMSHTLogOutSuccessNoti=@"JMSHTLogOutSuccessNoti";
//购物车不显示件数
static NSString *const JMSHTShoppingCartNumberNoti=@"AppDelegateShowNumber";
//收到推送消息通知
static NSString *const JMSHTReceivePushNoti=@"JMSHTPushNoti";

//付款通知回调
static NSString *const JMSHTPayCallBack=@"resultStatus";
//便民刷新数据
static NSString *const JMSHTBMLISTReloadData=@"JMSHTBMLISTReloadData";


/*******************************************************      服务说明网址       ******************************************************/
//飞机票特殊乘客须知
static NSString *const JMSHTServiceAirSpecialPassengersInstructionsStr=@"getplanespecialpg_wap.shtml?app";
//飞机票退款须知
static NSString *const JMSHTServiceAirRefundInstructionStr=@"tuiInstru_wap.shtml?app";


/*******************************************************      关于推送       ******************************************************/
//把token值传给服务器
static NSString *const JMSHTPushPostTokenToServerStr=@"getAppPushToken_mob.shtml";
//系统消息回调更改状态
static NSString *const JMSHTAppupdatePushSystemInfoStr=@"appUpdatePushSystemInformation_mob.shtml";
//触发推送的消息更改状态回调
static NSString *const JMSHTAppUpdatePushTriggerInfoStr=@"appUpdatePushTriggerInformation_mob.shtml";
//
static NSString *const VERSION_INFO_CURRENT=@"Version_info_current";

//获取订单状态
static NSString *const JMSHTGetOrderStatusStr=@"getOrderStatus_mob.shtml";

static BOOL ISTEXTPRICE=NO;

#endif

/* ConstHeader_h */

//                            _ooOoo_
//                           o8888888o
//                           88" . "88
//                           (| -_- |)
//                            O\ = /O
//                        ____/`---'\____
//                      .   ' \\| |// `.
//                       / \\||| : |||// \
//                     / _||||| -:- |||||- \
//                       | | \\\ - /// | |
//                     | \_| ''\---/'' | |
//                      \ .-\__ `-` ___/-. /
//                   ___`. .' /--.--\ `. . __
//                ."" '< `.___\_<|>_/___.' >'"".
//               | | : `- \`.;`\ _ /`;.`/ - ` : | |
//                 \ \ `-. \_ __\ /__ _/ .-` / /
//         ======`-.____`-.___\_____/___.-`____.-'======
//                            `=---='
//
//         .............................................
//                  佛祖保佑             永无BUG
//          佛曰:
//                  写字楼里写字间，写字间里程序员；
//                  程序人员写程序，又拿程序换酒钱。
//                  酒醒只在网上坐，酒醉还来网下眠；
//                  酒醉酒醒日复日，网上网下年复年。
//                  但愿老死电脑间，不愿鞠躬老板前；
//                  奔驰宝马贵者趣，公交自行程序员。
//                  别人笑我忒疯癫，我笑自己命太贱；
//                  不见满街漂亮妹，哪个归得程序员？


