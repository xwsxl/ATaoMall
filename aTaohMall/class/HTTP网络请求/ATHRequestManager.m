//
//  ATHRequestManager.m
//  aTaohMall
//
//  Created by DingDing on 2017/8/17.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "ATHRequestManager.h"
#import "WKProgressHUD.h"
@implementation ATHRequestManager

/**
 网络请求辅助方法

 @param urlString URL地址
 @param parameters 参数
 @param success 成功返回
 @param faild 失败返回
 */
+(void)POST:(NSString *)urlString parameters:(id)parameters successBlock:(Success)success faildBlock:(Failure)faild
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
     manager.requestSerializer.timeoutInterval = 15;
  //  WKProgressHUD *hud=[WKProgressHUD showInView:[UIApplication sharedApplication].keyWindow  withText:nil  animated:YES];
    [manager POST:urlString parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
        NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];
        if (codeKey && content) {
            NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
            
            NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];


            success(dic);
            
        }
    //    [hud dismiss:YES];
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
      //  [hud dismiss:YES];
        faild(error);
    }];
}
/*******************************************************      首页改版       ******************************************************/
/**
 获取有好货数据

 @param params <#params description#>
 @param success <#success description#>
 @param faild <#faild description#>
 */
+(void)requestforgetGoodGoodsListWithParams:(id)params successBlock:(Success)success faildBlock:(Failure)faild
{
    NSString *url=[NSString stringWithFormat:@"%@%@",URL_Str,@"getGoodGoodsList_mob.shtml"];
    NSLog(@"获取海外购物佳楼层数据params=%@",params);
    [ATHRequestManager POST:url parameters:params successBlock:^(NSDictionary *responseObj) {
        YLog(@"===获取海外购物佳楼层数据===responseOBj=%@",responseObj);
        success(responseObj);
    } faildBlock:^(NSError *error) {
        faild(error);
    }];

}
/**
 获取大牌推荐列表数据

 @param params <#params description#>
 @param success <#success description#>
 @param faild <#faild description#>
 */
+(void)requestforselectBrandToDataWithParams:(id)params successBlock:(Success)success faildBlock:(Failure)faild
{
    NSString *url=[NSString stringWithFormat:@"%@%@",URL_Str,@"selectBrandToData_mob.shtml"];
    NSLog(@"获取大牌推荐列表数据params=%@",params);
    [ATHRequestManager POST:url parameters:params successBlock:^(NSDictionary *responseObj) {
        YLog(@"===获取大牌推荐列表数据===responseOBj=%@",responseObj);
        success(responseObj);
    } faildBlock:^(NSError *error) {
        faild(error);
    }];

}

/**
 获取好货特卖数据

 @param params <#params description#>
 @param success <#success description#>
 @param faild <#faild description#>
 */
+(void)requestforgetGoodSellGoodsListWithParams:(id)params successBlock:(Success)success faildBlock:(Failure)faild
{
    NSString *url=[NSString stringWithFormat:@"%@%@",URL_Str,@"getGoodSellGoodsList_mob.shtml"];
    NSLog(@" 获取好货特卖数据params=%@",params);
    [ATHRequestManager POST:url parameters:params successBlock:^(NSDictionary *responseObj) {
        YLog(@"=== 获取好货特卖数据===responseOBj=%@",responseObj);
        success(responseObj);
    } faildBlock:^(NSError *error) {
        faild(error);
    }];

}


/**
 获取极客驿站商品列表

 @param params <#params description#>
 @param success <#success description#>
 @param faild <#faild description#>
 */
+(void)requestforgetGeekPostGoodsListWithParams:(id)params successBlock:(Success)success faildBlock:(Failure)faild
{
    NSString *url=[NSString stringWithFormat:@"%@%@",URL_Str,@"getGeekPostGoodsList_mob.shtml"];
    NSLog(@"获取极客驿站商品列表params=%@",params);
    [ATHRequestManager POST:url parameters:params successBlock:^(NSDictionary *responseObj) {
        YLog(@"===获取极客驿站商品列表===responseOBj=%@",responseObj);
        success(responseObj);
    } faildBlock:^(NSError *error) {
        faild(error);
    }];

}
/**
获取最近新品商品列表

 @param params <#params description#>
 @param success <#success description#>
 @param faild <#faild description#>
*/
+(void)requestforgetLatestGoodsListWithParams:(id)params successBlock:(Success)success faildBlock:(Failure)faild
{
    NSString *url=[NSString stringWithFormat:@"%@%@",URL_Str,@"getLatestGoodsList_mob.shtml"];
    NSLog(@"获取最近新品商品列表params=%@",params);
    [ATHRequestManager POST:url parameters:params successBlock:^(NSDictionary *responseObj) {
        YLog(@"===获取最近新品商品列表===responseOBj=%@",responseObj);
        success(responseObj);
    } faildBlock:^(NSError *error) {
        faild(error);
    }];

}

/**
 <!-- 获取热销排行顶部类型 -->

 @param params <#params description#>
 @param success <#success description#>
 @param faild <#faild description#>
 */
+(void)requestforgetHotSalesHeadTypeWithParams:(id)params successBlock:(Success)success faildBlock:(Failure)faild
{
    NSString *url=[NSString stringWithFormat:@"%@%@",URL_Str,@"getHotSalesHeadType_mob.shtml"];
    NSLog(@"获取热销排行顶部类型params=%@",params);
    [ATHRequestManager POST:url parameters:params successBlock:^(NSDictionary *responseObj) {
        YLog(@"===获取热销排行顶部类型===responseOBj=%@",responseObj);
        success(responseObj);
    } faildBlock:^(NSError *error) {
        faild(error);
    }];

}


/**
获取热销类型对应商品集合
 @param params <#params description#>
 @param success <#success description#>
 @param faild <#faild description#>
 */
+(void)requestforgetHotSalesGoodsListWithParams:(id)params successBlock:(Success)success faildBlock:(Failure)faild
{
    NSString *url=[NSString stringWithFormat:@"%@%@",URL_Str,@"getHotSalesGoodsList_mob.shtml"];
    NSLog(@"获取热销类型对应商品集合params=%@",params);
    [ATHRequestManager POST:url parameters:params successBlock:^(NSDictionary *responseObj) {
        YLog(@"===获取热销类型对应商品集合===responseOBj=%@",responseObj);
        success(responseObj);
    } faildBlock:^(NSError *error) {
        faild(error);
    }];

}

/**
 获取海外购物佳楼层数据

 @param params <#params description#>
 @param success <#success description#>
 @param faild <#faild description#>
 */
+(void)requestforgetShopJiaNameWithParams:(id)params successBlock:(Success)success faildBlock:(Failure)faild
{
    NSString *url=[NSString stringWithFormat:@"%@%@",URL_Str,@"getShopJiaName_mob.shtml"];
    NSLog(@"获取海外购物佳楼层数据params=%@",params);
    [ATHRequestManager POST:url parameters:params successBlock:^(NSDictionary *responseObj) {
        YLog(@"===获取海外购物佳楼层数据===responseOBj=%@",responseObj);
        success(responseObj);
    } faildBlock:^(NSError *error) {
        faild(error);
    }];

}
/**
 获取海外购物佳楼层商品

 @param params <#params description#>
 @param success <#success description#>
 @param faild <#faild description#>
 */
+(void)requestforgetShopJiaGoodsWithParams:(id)params successBlock:(Success)success faildBlock:(Failure)faild
{
    NSString *url=[NSString stringWithFormat:@"%@%@",URL_Str,@"getShopJiaGoods_mob.shtml"];
    NSLog(@"获取海外购物佳楼层数据params=%@",params);
    [ATHRequestManager POST:url parameters:params successBlock:^(NSDictionary *responseObj) {
        YLog(@"===获取海外购物佳楼层数据===responseOBj=%@",responseObj);
        success(responseObj);
    } faildBlock:^(NSError *error) {
        faild(error);
    }];

}
/*******************************************************      订单列表整合       ******************************************************/
/**
 获取商品订单数据

 @param params <#params description#>
 @param success <#success description#>
 @param faild <#faild description#>
 */
+(void)requestforGetShoppingListWithParams:(id)params successBlock:(Success)success faildBlock:(Failure)faild
{
    NSString *url=[NSString stringWithFormat:@"%@%@",URL_Str,@"getOrderListByGoods_mob.shtml"];
    NSLog(@"获取商品订单数据params=%@",params);
    [ATHRequestManager POST:url parameters:params successBlock:^(NSDictionary *responseObj) {
        YLog(@"===获取商品订单数据===responseOBj=%@",responseObj);
        success(responseObj);
    } faildBlock:^(NSError *error) {
        faild(error);
    }];


}

/**
 获取商品订单详情数据

 @param params <#params description#>
 @param success <#success description#>
 @param faild <#faild description#>
 */
+(void)requestforGetShoppingDanDetailWithParams:(id)params successBlock:(Success)success faildBlock:(Failure)faild
{
    NSString *url=[NSString stringWithFormat:@"%@%@",URL_Str,@"getOrderDetailsByGoods_mob.shtml"];
    NSLog(@"获取商品订单详情数据params=%@",params);
    [ATHRequestManager POST:url parameters:params successBlock:^(NSDictionary *responseObj) {
        YLog(@"===获取商品订单详情数据===responseOBj=%@",responseObj);
        success(responseObj);
    } faildBlock:^(NSError *error) {
        faild(error);
    }];


}

/**
 判断是否可以确认收货

 @param params <#params description#>
 @param success <#success description#>
 @param faild <#faild description#>
 */
+(void)requestforCheckSureReceiveGoodsWithParams:(id)params successBlock:(Success)success faildBlock:(Failure)faild
{
    NSString *url=[NSString stringWithFormat:@"%@%@",URL_Str,@"isOrderConfirmReceipt_mob.shtml"];
    NSLog(@"确认收货params=%@",params);
    [ATHRequestManager POST:url parameters:params successBlock:^(NSDictionary *responseObj) {
        YLog(@"===确认收货===responseOBj=%@",responseObj);
        success(responseObj);
    } faildBlock:^(NSError *error) {
        faild(error);
    }];

}
/**
 确认收货

 @param params <#params description#>
 @param success <#success description#>
 @param faild <#faild description#>
 */
+(void)requestforSureReceiveGoodsWithParams:(id)params successBlock:(Success)success faildBlock:(Failure)faild
{
    NSString *url=[NSString stringWithFormat:@"%@%@",URL_Str,@"orderConfirmReceipt_mob.shtml"];
    NSLog(@"确认收货params=%@",params);
    [ATHRequestManager POST:url parameters:params successBlock:^(NSDictionary *responseObj) {
        YLog(@"===确认收货===responseOBj=%@",responseObj);
        success(responseObj);
    } faildBlock:^(NSError *error) {
        faild(error);
    }];

}
/**
 查询物流判断包裹个数

 @param params <#params description#>
 @param success <#success description#>
 @param faild <#faild description#>
 */
+(void)requestforGetLogisticsNumberWithParams:(id)params successBlock:(Success)success faildBlock:(Failure)faild
{
    NSString *url=[NSString stringWithFormat:@"%@%@",URL_Str,@"getLogisticsNumber_mob.shtml"];
    NSLog(@"查询物流判断包裹个数params=%@",params);
    [ATHRequestManager POST:url parameters:params successBlock:^(NSDictionary *responseObj) {
        YLog(@"===查询物流判断包裹个数===responseOBj=%@",responseObj);
        success(responseObj);
    } faildBlock:^(NSError *error) {
        faild(error);
    }];

}
/**
 查询物流详细信息

 入参数：
 order_batchid        // 订单号批次号

 waybillnumber        // 运单号  （注：从订单详情(订单列表) 点击 查询物流 传空，  从包裹列表查询物流 传对应的 运单号）
 @param params <#params description#>
 @param success <#success description#>
 @param faild <#faild description#>
 */
+(void)requestforqueryLogisticsWithParams:(id)params successBlock:(Success)success faildBlock:(Failure)faild
{
    NSString *url=[NSString stringWithFormat:@"%@%@",URL_Str,@"queryLogistics_mob.shtml"];
    NSLog(@"查询物流params=%@",params);
    [ATHRequestManager POST:url parameters:params successBlock:^(NSDictionary *responseObj) {
        YLog(@"===查询物流===responseOBj=%@",responseObj);
        success(responseObj);
    } faildBlock:^(NSError *error) {
        [TrainToast showWithText:error.localizedDescription duration:2.0];
        faild(error);
    }];

}
/**
 删除订单
 @param params <#params description#>
 @param success <#success description#>
 @param faild <#faild description#>
 */
+(void)requestforDelNotPayOrderWithParams:(id)params successBlock:(Success)success faildBlock:(Failure)faild
{
    NSString *url=[NSString stringWithFormat:@"%@%@",URL_Str,@"delNotPayOrder_mob.shtml"];
    NSLog(@"删除订单params=%@",params);
    [ATHRequestManager POST:url parameters:params successBlock:^(NSDictionary *responseObj) {
        YLog(@"===删除订单===responseOBj=%@",responseObj);
        success(responseObj);
    } faildBlock:^(NSError *error) {
        faild(error);
    }];

}
/**
 退款订单列表
 @param params <#params description#>
 @param success <#success description#>
 @param faild <#faild description#>
 */
+(void)requestforGetOrderRefundListByGoodsWithParams:(id)params successBlock:(Success)success faildBlock:(Failure)faild
{
    NSString *url=[NSString stringWithFormat:@"%@%@",URL_Str,@"getOrderRefundListByGoods_mob.shtml"];
    NSLog(@"退款订单列表params=%@",params);
    [ATHRequestManager POST:url parameters:params successBlock:^(NSDictionary *responseObj) {
        YLog(@"===退款订单列表===responseOBj=%@",responseObj);
        success(responseObj);
    } faildBlock:^(NSError *error) {
        faild(error);
    }];

}

/**
添加退款商品
 @param params <#params description#>
 @param success <#success description#>
 @param faild <#faild description#>
 */
+(void)requestforAddRefundOrderWithParams:(id)params successBlock:(Success)success faildBlock:(Failure)faild
{
    NSString *url=[NSString stringWithFormat:@"%@%@",URL_Str,@"addRefundOrder_mob.shtml"];
    NSLog(@"添加退款商品params=%@",params);
    [ATHRequestManager POST:url parameters:params successBlock:^(NSDictionary *responseObj) {
        YLog(@"===添加退款商品===responseOBj=%@",responseObj);
        success(responseObj);
    } faildBlock:^(NSError *error) {
        faild(error);
    }];

}
/**
 退款详情
 @param params <#params description#>
 @param success <#success description#>
 @param faild <#faild description#>
 */
+(void)requestforgetRefundOrderDetailsByGoodsWithParams:(id)params successBlock:(Success)success faildBlock:(Failure)faild
{
    NSString *url=[NSString stringWithFormat:@"%@%@",URL_Str,@"getRefundOrderDetailsByGoods_mob.shtml"];
    NSLog(@"退款详情params=%@",params);
    [ATHRequestManager POST:url parameters:params successBlock:^(NSDictionary *responseObj) {
        YLog(@"===退款详情===responseOBj=%@",responseObj);
        success(responseObj);
    } faildBlock:^(NSError *error) {
        faild(error);
    }];

}
/**
 退款次数
 @param params <#params description#>
 @param success <#success description#>
 @param faild <#faild description#>
 */
+(void)requestforgetRefundNumberWithParams:(id)params successBlock:(Success)success faildBlock:(Failure)faild
{
    NSString *url=[NSString stringWithFormat:@"%@%@",URL_Str,@"getRefundNumber_mob.shtml"];
    NSLog(@"退款次数params=%@",params);
    [ATHRequestManager POST:url parameters:params successBlock:^(NSDictionary *responseObj) {
        YLog(@"===退款次数===responseOBj=%@",responseObj);
        success(responseObj);
    } faildBlock:^(NSError *error) {
        faild(error);
    }];

}

/**
 协商记录
 @param params <#params description#>
 @param success <#success description#>
 @param faild <#faild description#>
 */
+(void)requestforgetRefunRecordWithParams:(id)params successBlock:(Success)success faildBlock:(Failure)faild
{
    NSString *url=[NSString stringWithFormat:@"%@%@",URL_Str,@"getRefunRecord_mob.shtml"];
    NSLog(@"协商记录params=%@",params);
    [ATHRequestManager POST:url parameters:params successBlock:^(NSDictionary *responseObj) {
        YLog(@"===协商记录===responseOBj=%@",responseObj);
        success(responseObj);
    } faildBlock:^(NSError *error) {
        faild(error);
    }];

}



/**
 客服介入
 @param params <#params description#>
 @param success <#success description#>
 @param faild <#faild description#>
 */
+(void)requestforgetNoRefundWithParams:(id)params successBlock:(Success)success faildBlock:(Failure)faild
{
    NSString *url=[NSString stringWithFormat:@"%@%@",URL_Str,@"getNoRefund_mob.shtml"];
    NSLog(@"<!-- 无法退款，客服介入页面 -->params=%@",params);
    [ATHRequestManager POST:url parameters:params successBlock:^(NSDictionary *responseObj) {
        YLog(@"===<!-- 无法退款，客服介入页面 -->===responseOBj=%@",responseObj);
        success(responseObj);
    } faildBlock:^(NSError *error) {
        faild(error);
    }];

}



/**
 退货物流
 @param params <#params description#>
 @param success <#success description#>
 @param faild <#faild description#>
 */
+(void)requestforqueryUserLogisticsWithParams:(id)params successBlock:(Success)success faildBlock:(Failure)faild
{
    NSString *url=[NSString stringWithFormat:@"%@%@",URL_Str,@"queryUserLogistics_mob.shtml"];
    NSLog(@"<!-- 查看用户退货退款物流信息 -->params=%@",params);
    [ATHRequestManager POST:url parameters:params successBlock:^(NSDictionary *responseObj) {
        YLog(@"===<!-- 查看用户退货退款物流信息 -->===responseOBj=%@",responseObj);
        success(responseObj);
    } faildBlock:^(NSError *error) {
        faild(error);
    }];

}
/**
 便民列表
 @param params <#params description#>
 @param success <#success description#>
 @param faild <#faild description#>
 */
+(void)requestforgetOrderListByBMWithParams:(id)params successBlock:(Success)success faildBlock:(Failure)faild
{
    NSString *url=[NSString stringWithFormat:@"%@%@",URL_Str,@"getOrderListBy_BM_mob.shtml"];
    NSLog(@"便民列表params=%@",params);
    [ATHRequestManager POST:url parameters:params successBlock:^(NSDictionary *responseObj) {
        YLog(@"===便民列表===responseOBj=%@",responseObj);
        success(responseObj);
    } faildBlock:^(NSError *error) {
        faild(error);
    }];

}

/**
 话费
 @param params <#params description#>
 @param success <#success description#>
 @param faild <#faild description#>
 */
+(void)requestforgetOrderDetailsByPhoneWithParams:(id)params successBlock:(Success)success faildBlock:(Failure)faild
{
    NSString *url=[NSString stringWithFormat:@"%@%@",URL_Str,@"getOrderDetailsBy_phone_mob.shtml"];
    NSLog(@"话费params=%@",params);
    [ATHRequestManager POST:url parameters:params successBlock:^(NSDictionary *responseObj) {
        YLog(@"===话费===responseOBj=%@",responseObj);
        success(responseObj);
    } faildBlock:^(NSError *error) {
        faild(error);
    }];

}
/**
 违章详情
 @param params <#params description#>
 @param success <#success description#>
 @param faild <#faild description#>
 */
+(void)requestforillegalOrderDetailsWithParams:(id)params successBlock:(Success)success faildBlock:(Failure)faild
{
    NSString *url=[NSString stringWithFormat:@"%@%@",URL_Str,@"illegalOrderDetails_mob.shtml"];
    NSLog(@"违章详情params=%@",params);
    [ATHRequestManager POST:url parameters:params successBlock:^(NSDictionary *responseObj) {
        YLog(@"===违章详情===responseOBj=%@",responseObj);
        success(responseObj);
    } faildBlock:^(NSError *error) {
        faild(error);
    }];

}
/**
 飞机票详情
 @param params <#params description#>
 @param success <#success description#>
 @param faild <#faild description#>
 */
+(void)requestforgetOrderDetailsByAirplaneWithParams:(id)params successBlock:(Success)success faildBlock:(Failure)faild
{
    NSString *url=[NSString stringWithFormat:@"%@%@",URL_Str,@"getOrderDetailsBy_airplane_mob.shtml"];
    NSLog(@"飞机票详情params=%@",params);
    [ATHRequestManager POST:url parameters:params successBlock:^(NSDictionary *responseObj) {
        YLog(@"===飞机票详情===responseOBj=%@",responseObj);
        success(responseObj);
    } faildBlock:^(NSError *error) {
        faild(error);
    }];

}
/**
 火车票详情
 @param params <#params description#>
 @param success <#success description#>
 @param faild <#faild description#>
 */
+(void)requestforgetOrderDetailsByTrainWithParams:(id)params successBlock:(Success)success faildBlock:(Failure)faild
{
    NSString *url=[NSString stringWithFormat:@"%@%@",URL_Str,@"getOrderDetailsBy_train_mob.shtml"];
    NSLog(@"火车票详情params=%@",params);
    [ATHRequestManager POST:url parameters:params successBlock:^(NSDictionary *responseObj) {
        YLog(@"===火车票详情===responseOBj=%@",responseObj);
        success(responseObj);
    } faildBlock:^(NSError *error) {
        faild(error);
    }];

}
/**
 在处理中
 @param params <#params description#>
 @param success <#success description#>
 @param faild <#faild description#>
 */
+(void)requestforgetOrderCountWithParams:(id)params successBlock:(Success)success faildBlock:(Failure)faild
{
    NSString *url=[NSString stringWithFormat:@"%@%@",URL_Str,@"getOrderCount_mob.shtml"];
    NSLog(@"在处理中params=%@",params);
    [ATHRequestManager POST:url parameters:params successBlock:^(NSDictionary *responseObj) {
        YLog(@"===在处理中===responseOBj=%@",responseObj);
        success(responseObj);
    } faildBlock:^(NSError *error) {
        faild(error);
    }];

}



/*******************************************************      小家电专场       ******************************************************/

/**
 获取数据
 
 @param params <#params description#>
 @param success <#success description#>
 @param faild <#faild description#>
 */
+(void)requestforGetMoreAppliancesListWithParams:(id)params successBlock:(Success)success faildBlock:(Failure)faild
{
    NSString *url=[NSString stringWithFormat:@"%@%@",URL_Str,JMSHTHomeGetMoreAppliancesListStr];
    NSLog(@"获取小家电数据params=%@",params);
    [ATHRequestManager POST:url parameters:params successBlock:^(NSDictionary *responseObj) {
        YLog(@"===获取小家电数据===responseOBj=%@",responseObj);
        success(responseObj);
    } faildBlock:^(NSError *error) {
        faild(error);
    }];
    
    
}

/**
 大健康专区获取数据

 @param params <#params description#>
 @param success <#success description#>
 @param faild <#faild description#>
 */
+(void)requestforGetMoreBigHeathyListWithParams:(id)params successBlock:(Success)success faildBlock:(Failure)faild
{
    NSString *url=[NSString stringWithFormat:@"%@%@",URL_Str,@"getHealthGoodsList_mob.shtml"];
    NSLog(@"获取大健康数据params=%@",params);
    [ATHRequestManager POST:url parameters:params successBlock:^(NSDictionary *responseObj) {
        YLog(@"===获取大健康数据===responseOBj=%@",responseObj);
        success(responseObj);
    } faildBlock:^(NSError *error) {
        faild(error);
    }];


}
/*******************************************************      推送       ******************************************************/

/**
 上传token值

 @param params <#params description#>
 @param success <#success description#>
 @param faild <#faild description#>
 */
+(void)requestforPostTokenToServerWithParams:(id)params successBlock:(Success)success faildBlock:(Failure)faild
{
    NSString *url=[NSString stringWithFormat:@"%@%@",URL_Str,JMSHTPushPostTokenToServerStr];
    NSLog(@"上传token值params=%@",params);
    [ATHRequestManager POST:url parameters:params successBlock:^(NSDictionary *responseObj) {
        YLog(@"===上传token值===responseOBj=%@",responseObj);
        success(responseObj);
    } faildBlock:^(NSError *error) {
        faild(error);
    }];
    

}


/**
 删除无效token值

 @param params <#params description#>
 @param success <#success description#>
 @param faild <#faild description#>
 */
+(void)requestforDeleteTokenToServerWithParams:(id)params successBlock:(Success)success faildBlock:(Failure)faild
{
    NSString *url=[NSString stringWithFormat:@"%@%@",URL_Str,@"appUpdateIOSToken_mob.shtml"];
    NSLog(@"删除无效token值params=%@",params);
    [ATHRequestManager POST:url parameters:params successBlock:^(NSDictionary *responseObj) {
        YLog(@"===删除token值===responseOBj=%@,message=%@",responseObj,responseObj[@"message"]);
        success(responseObj);
    } faildBlock:^(NSError *error) {
        faild(error);
    }];


}

/**
 修改系统消息状态
 
 @param params <#params description#>
 @param success <#success description#>
 @param faild <#faild description#>
 */
+(void)requestforUpdateAppPushSystemInfoWithParams:(id)params successBlock:(Success)success faildBlock:(Failure)faild
{
    NSString *url=[NSString stringWithFormat:@"%@%@",URL_Str,JMSHTAppupdatePushSystemInfoStr];
    NSLog(@"修改系统通知状态params=%@",params);
    [ATHRequestManager POST:url parameters:params successBlock:^(NSDictionary *responseObj) {
        YLog(@"===修改系统通知状态===responseOBj=%@",responseObj);
        success(responseObj);
    } faildBlock:^(NSError *error) {
        YLog(@"errorororor");
        faild(error);
    }];
    
}
/**
 修改服务器触发推送消息状态
 
 @param params <#params description#>
 @param success <#success description#>
 @param faild <#faild description#>
 */
+(void)requestforAppUpdatePushTriggerInfoWithParams:(id)params successBlock:(Success)success faildBlock:(Failure)faild
{
    NSString *url=[NSString stringWithFormat:@"%@%@",URL_Str,JMSHTAppUpdatePushTriggerInfoStr];
    NSLog(@"修改触发通知状态params=%@",params);
    [ATHRequestManager POST:url parameters:params successBlock:^(NSDictionary *responseObj) {
        YLog(@"===修改触发通知状态===responseOBj=%@",responseObj);
        success(responseObj);
    } faildBlock:^(NSError *error) {
        faild(error);
    }];
}
/**
 消息列表

 @param params <#params description#>
 @param success <#success description#>
 @param faild <#faild description#>
 */
+(void)requestforHomeGetMessageListWithParams:(id)params successBlock:(Success)success faildBlock:(Failure)faild
{
    NSString *url=[NSString stringWithFormat:@"%@%@",URL_Str,JMSHTHomeGetMessageListStr];
    NSLog(@"消息列表params=%@",params);
    [ATHRequestManager POST:url parameters:params successBlock:^(NSDictionary *responseObj) {
        YLog(@"===消息===responseOBj=%@",responseObj);
        success(responseObj);
    } faildBlock:^(NSError *error) {
        faild(error);
    }];
    
    
}

/**
 更改为已读

 @param params <#params description#>
 @param success <#success description#>
 @param faild <#faild description#>
 */
+(void)requestForMessageChangePushIsReadWithParams:(id)params successBlock:(Success)success faildBlock:(Failure)faild
{
    NSString *url=[NSString stringWithFormat:@"%@%@",URL_Str,JMSHTMessageListChangeIsReadStr];
    NSLog(@"消息设置为已读params=%@",params);
    [ATHRequestManager POST:url parameters:params successBlock:^(NSDictionary *responseObj) {
        YLog(@"===消息设置为已读===responseOBj=%@",responseObj);
        success(responseObj);
    } faildBlock:^(NSError *error) {
        faild(error);
    }];
}
/**
 删除消息
 
 @param params <#params description#>
 @param success <#success description#>
 @param faild <#faild description#>
 */
+(void)requestForMessageListDeleteMsgWithParams:(id)params successBlock:(Success)success faildBlock:(Failure)faild
{
    NSString *url=[NSString stringWithFormat:@"%@%@",URL_Str,JMSHTMessageListDeleteMsgStr];
    NSLog(@"删除消息params=%@",params);
    [ATHRequestManager POST:url parameters:params successBlock:^(NSDictionary *responseObj) {
        YLog(@"===删除消息===responseOBj=%@",responseObj);
        success(responseObj);
    } faildBlock:^(NSError *error) {
        faild(error);
    }];
}

/**
 获取单条系统消息详细记录//未登录
 
 @param params <#params description#>
 @param success <#success description#>
 @param faild <#faild description#>
 */
+(void)requestForMessageListSystemMsgWithParams:(id)params successBlock:(Success)success faildBlock:(Failure)faild
{
    NSString *url=[NSString stringWithFormat:@"%@%@",URL_Str,JMSHTMessageListSystemMsgStr];
    NSLog(@"获取一条系统消息params=%@",params);
    [ATHRequestManager POST:url parameters:params successBlock:^(NSDictionary *responseObj) {
        YLog(@"===获取单条系统消息===responseOBj=%@",responseObj);
        success(responseObj);
    } faildBlock:^(NSError *error) {
        faild(error);
    }];
}
/**
 获取单条系统消息详细记录//登录
 
 @param params <#params description#>
 @param success <#success description#>
 @param faild <#faild description#>
 */
+(void)requestForMessageListSystemMsgLogInWithParams:(id)params successBlock:(Success)success faildBlock:(Failure)faild
{
    NSString *url=[NSString stringWithFormat:@"%@%@",URL_Str,@"appGetPushInformationList_mob"];
    NSLog(@"获取系统消息登录params=%@",params);
    [ATHRequestManager POST:url parameters:params successBlock:^(NSDictionary *responseObj) {
        YLog(@"===获取单条系统消息登录===responseOBj=%@",responseObj);
        success(responseObj);
    } faildBlock:^(NSError *error) {
        faild(error);
    }];
}
/**
 获取订单实时数据
 
 @param params <#params description#>
 @param success <#success description#>
 @param faild <#faild description#>
 */
+(void)requestForGetOrderStatusWithParams:(id)params successBlock:(Success)success faildBlock:(Failure)faild
{
    NSString *url=[NSString stringWithFormat:@"%@%@",URL_Str,JMSHTGetOrderStatusStr];
    NSLog(@"获取订单状态params=%@",params);
    [ATHRequestManager POST:url parameters:params successBlock:^(NSDictionary *responseObj) {
        YLog(@"===获取订单状态===responseOBj=%@",responseObj);
        success(responseObj);
    } faildBlock:^(NSError *error) {
        faild(error);
    }];
}

/**
 获取未读消息数目
 @param params <#params description#>
 @param success <#success description#>
 @param faild <#faild description#>
 */
+(void)requestForGetUnreadMessageNumWithParams:(id)params successBlock:(Success)success faildBlock:(Failure)faild
{
    NSString *url=[NSString stringWithFormat:@"%@%@",URL_Str,@"getUsreUnreadMessage_mob.shtml"];
    NSLog(@"获取未读消息数目params=%@",params);
    [ATHRequestManager POST:url parameters:params successBlock:^(NSDictionary *responseObj) {
        YLog(@"===获取未读消息数目===responseOBj=%@",responseObj);
        success(responseObj);
    } faildBlock:^(NSError *error) {
        faild(error);
    }];
}





/*******************************************************      引导页       ******************************************************/

/**
 引导页接口

 @param params <#params description#>
 @param success <#success description#>
 @param faild <#faild description#>
 */
+(void)requestforAppdelegateWithParams:(id)params successBlock:(Success)success faildBlock:(Failure)faild
{
    NSString *url=[NSString stringWithFormat:@"%@%@",URL_Str,@"getAppStartInformation_mob.shtml"];
    NSLog(@"启动页params=%@",params);
    [ATHRequestManager POST:url parameters:params successBlock:^(NSDictionary *responseObj) {
        YLog(@"===启动===responseOBj=%@",responseObj);
        success(responseObj);
    } faildBlock:^(NSError *error) {
         faild(error);
    }];
    
}
/*******************************************************      我的页面       ******************************************************/
/**
 登录接口

 @param params <#params description#>
 @param success <#success description#>
 @param faild <#faild description#>
 */
+(void)requestforMineLogInWithParams:(id)params successBlock:(Success)success faildBlock:(Failure)faild
{
    NSString *loginStr=[NSString stringWithFormat:@"%@%@",URL_Str,JMSHTMineLoginStr];
    NSLog(@"登录params=%@",params);
    [ATHRequestManager POST:loginStr parameters:params successBlock:^(NSDictionary *responseObj) {
        YLog(@"===登录===responseOBj=%@",responseObj);
        success(responseObj);
    } faildBlock:^(NSError *error) {
        faild(error);
    }];
}



#pragma mark-违章
/**
 获取车辆数据接口

 @param params <#params description#>
 @param success <#success description#>
 @param faild <#faild description#>
 */
+(void)requestForCarDataWithParams:(id)params successBlock:(Success)success faildBlock:(Failure)faild
{
   NSString *getCarDataStr=[NSString stringWithFormat:@"%@%@",URL_Str,JMSHTPeccGetCarDataStr];
   
    [ATHRequestManager POST:getCarDataStr parameters:params successBlock:^(NSDictionary *responseObj) {
        YLog(@"===获取车辆信息===responseOBj=%@",responseObj);
        success(responseObj);
    } faildBlock:^(NSError *error) {
        faild(error);
    }];
    
}

/**
 获取单个车辆的违章信息

 @param params <#params description#>
 @param success <#success description#>
 @param faild <#faild description#>
 */
+(void)requestForCarPeccDataWithParams:(id)params successBlock:(Success)success faildBlock:(Failure)faild
{
    NSString *getCarPeccDataStr=[NSString stringWithFormat:@"%@%@",URL_Str,JMSHTPeccGetCarPeccDataStr];
    [ATHRequestManager POST:getCarPeccDataStr parameters:params successBlock:^(NSDictionary *responseObj) {
        NSLog(@"========= 获取单个车辆的违章信息=%@",responseObj);
        success(responseObj);
    } faildBlock:^(NSError *error) {
        faild(error);
    }];
}
/*******************************************************      飞机票       ******************************************************/
/**
 获取能否退票信息
 
 @param params <#params description#>
 @param success <#success description#>
 @param faild <#faild description#>
 */
+(void)requestForCanRefundInfoWithParams:(id)params successBlock:(Success)success faildBlock:(Failure)faild
{
    NSString *getCanRefundInfoStr=[NSString stringWithFormat:@"%@%@",URL_Str,JMSHTAirGetCanRefundInfoStr];
    [ATHRequestManager POST:getCanRefundInfoStr parameters:params successBlock:^(NSDictionary *responseObj) {
        NSLog(@"=========获取能否退票信息=%@",responseObj);
        success(responseObj);
    } faildBlock:^(NSError *error) {
        faild(error);
    }];
    
}

/**
 判断机票退票时间段

 @param success <#success description#>
 @param faild <#faild description#>
 */
+(void)requestForRefundDataConfirmSuccessBlock:(Success)success faildBlock:(Failure)faild
{
    NSString *URL=[NSString stringWithFormat:@"%@%@",URL_Str,JMSHTAirGetRefundTimeStr];
    [ATHRequestManager POST:URL parameters:nil successBlock:^(NSDictionary *responseObj) {
        NSLog(@"=========获取退票时间信息=%@",responseObj);
        success(responseObj);
    } faildBlock:^(NSError *error) {
        faild(error);
    }];
    
}

/**
 确定退票

 @param params <#params description#>
 @param success <#success description#>
 @param faild <#faild description#>
 */
+(void)requestForSureRefundAirOrderWithParams:(NSDictionary *)params successBlock:(Success)success faildBlock:(Failure)faild
{
    NSString *url=[NSString stringWithFormat:@"%@%@",URL_Str,JMSHTAirSureRefundTicketsStr];
    [ATHRequestManager POST:url parameters:params successBlock:^(NSDictionary *responseObj) {
        NSLog(@"=========确定退票=%@",responseObj);
        success(responseObj);
    } faildBlock:^(NSError *error) {
        faild(error);
    }];
}

/*******************************************************      火车票       ******************************************************/

/**
 购票流程

 @param params <#params description#>
 @param success <#success description#>
 @param faild <#faild description#>
 */
+(void)requestForTicketsProgressWithParams:(NSDictionary *)params successBlock:(Success)success faildBlock:(Failure)faild
{
    NSString *url=[NSString stringWithFormat:@"%@%@",URL_Str,JMSHTTrainGetTicketsProgressStr];
    
    [ATHRequestManager POST:url parameters:params successBlock:^(NSDictionary *responseObj) {
        NSLog(@"=========购票流程=params=%@=responseObj=%@",params,responseObj);
        success(responseObj);
    } faildBlock:^(NSError *error) {
        faild(error);
    }];
}

@end
