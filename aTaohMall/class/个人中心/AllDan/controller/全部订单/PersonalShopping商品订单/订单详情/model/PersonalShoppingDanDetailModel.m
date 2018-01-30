//
//  PersonalShoppingDanDetailModel.m
//  aTaohMall
//
//  Created by DingDing on 2017/11/6.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "PersonalShoppingDanDetailModel.h"

@implementation PersonalShoppingDanDetailModel
-(NSMutableArray *)order_list
{
    if (!_order_list) {
        _order_list=[NSMutableArray new];
    }
    return _order_list;
}

-(void)orderListFromArray:(NSArray *)tempArr
{
    [self.order_list removeAllObjects];
    BOOL temp=YES;
    if (tempArr&&tempArr.count>1) {
        temp=NO;
    }
    for (NSDictionary *dic in tempArr) {

        PersonalSingleShoppingDetailModel *model=[PersonalSingleShoppingDetailModel new];

        model.aid=[NSString stringWithFormat:@"%@",dic[@"aid"]];

        model.checkdate=[NSString stringWithFormat:@"%@",dic[@"checkdate"]];;

        model.company=[NSString stringWithFormat:@"%@",dic[@"company"]];;

        model.detailId=[NSString stringWithFormat:@"%@",dic[@"detailId"]];;

        model.discount_integral=[NSString stringWithFormat:@"%@",dic[@"discount_integral"]];;

        model.expressno=[NSString stringWithFormat:@"%@",dic[@"expressno"]];;

        model.freight=[NSString stringWithFormat:@"%@",dic[@"freight"]];;

        model.gid=[NSString stringWithFormat:@"%@",dic[@"gid"]];;

        model.good_type=[NSString stringWithFormat:@"%@",dic[@"good_type"]];;

        model.goods_status=[NSString stringWithFormat:@"%@",dic[@"goods_status"]];;

        model.ID=[NSString stringWithFormat:@"%@",dic[@"id"]];;

        model.integral=[NSString stringWithFormat:@"%@",dic[@"integral"]];;

        model.is_attribute=[NSString stringWithFormat:@"%@",dic[@"is_attribute"]];;

        model.mid=[NSString stringWithFormat:@"%@",dic[@"mid"]];;

        model.name=[NSString stringWithFormat:@"%@",dic[@"name"]];;

        model.number=[NSString stringWithFormat:@"%@",dic[@"number"]];;

        model.order_batchid=[NSString stringWithFormat:@"%@",dic[@"order_batchid"]];;

        model.order_type=[NSString stringWithFormat:@"%@",dic[@"order_type"]];;

        model.orderno=[NSString stringWithFormat:@"%@",dic[@"orderno"]];;

        model.pay_integer=[NSString stringWithFormat:@"%@",dic[@"pay_integer"]];;

        model.pay_money=[NSString stringWithFormat:@"%@",dic[@"pay_maney"]];;

        model.pay_order=[NSString stringWithFormat:@"%@",dic[@"pay_order"]];;

        model.pay_status=[NSString stringWithFormat:@"%@",dic[@"pay_status"]];;

        model.pay_time=[NSString stringWithFormat:@"%@",dic[@"pay_time"]];;

        model.payintegral=[NSString stringWithFormat:@"%@",dic[@"payintegral"]];;

        model.paymoney=[NSString stringWithFormat:@"%@",dic[@"paymoney"]];;

        model.phone=[NSString stringWithFormat:@"%@",dic[@"phone"]];;

        model.pice=[NSString stringWithFormat:@"%@",dic[@"pice"]];;

        model.postcode=[NSString stringWithFormat:@"%@",dic[@"postcode"]];;

        model.receipt_type=[NSString stringWithFormat:@"%@",dic[@"receipt_type"]];;

        model.refund_count=[NSString stringWithFormat:@"%@",dic[@"refund_count"]];;

        model.remark=[NSString stringWithFormat:@"%@",dic[@"remark"]];;

        model.return_goods_count=[NSString stringWithFormat:@"%@",dic[@"return_goods_count"]];;

        model.scopeimg=[NSString stringWithFormat:@"%@",dic[@"scopeimg"]];;

        model.getdate=[NSString stringWithFormat:@"%@",dic[@"getdate"]];;

        model.sigen=[NSString stringWithFormat:@"%@",dic[@"sigen"]];;

        model.state=[NSString stringWithFormat:@"%@",dic[@"state"]];;

        model.status=[NSString stringWithFormat:@"%@",dic[@"status"]];;

        model.stocks=[NSString stringWithFormat:@"%@",dic[@"stocks"]];;

        model.sys_date=[NSString stringWithFormat:@"%@",dic[@"sys_date"]];;

        model.sysdate=[NSString stringWithFormat:@"%@",dic[@"sysdate"]];;

        model.tmid=[NSString stringWithFormat:@"%@",dic[@"tmid"]];;

        model.totalIntegral=[NSString stringWithFormat:@"%@",dic[@"totalIntegral"]];;

        model.totalMoney=[NSString stringWithFormat:@"%@",dic[@"totalMoney"]];;

        model.totalfreight=[NSString stringWithFormat:@"%@",dic[@"totalfreight"]];;

        model.type=[NSString stringWithFormat:@"%@",dic[@"type"]];;

        model.uaddress=[NSString stringWithFormat:@"%@",dic[@"uaddress"]];;

        model.uid=[NSString stringWithFormat:@"%@",dic[@"uid"]];;

        model.username=[NSString stringWithFormat:@"%@",dic[@"username"]];;

        model.uphone=[NSString stringWithFormat:@"%@",dic[@"uphone"]];;

        model.usersigen=[NSString stringWithFormat:@"%@",dic[@"usersigen"]];;

        model.waybillnumber=[NSString stringWithFormat:@"%@",dic[@"waybillnumber"]];;

        model.attribute_str=[NSString stringWithFormat:@"%@",dic[@"attribute_str"]];
        if ([model.attribute_str containsString:@"null"]) {
            model.attribute_str=@"";
        }

        model.IsSingle=temp;

        [self.order_list addObject:model];
    }

}

-(CGFloat)headerHeight
{

        _headerHeight=0;
        _headerHeight+=Height(92)+Height(80)+Height(10)+Height(14)+14+Height(14);
        if (!([_buyer_message containsString:@"null"]||[_buyer_message isEqualToString:@""])) {
            CGSize size=[_buyer_message sizeWithFont:KNSFONTM(12) maxSize:CGSizeMake(kScreen_Width-Width(50), MAXFLOAT)];
            _headerHeight+=Height(80)-34+size.height;
        }
        if ([_total_status isEqualToString:@"1"]||[_total_status isEqualToString:@"2"]) {
            _headerHeight+=Height(80);
        }
    return _headerHeight;
}

-(CGFloat)footHeight
{


//运费部分所有种类都有
        _footHeight=Height(12)+12+Height(12)+14+Height(19)+1;

    if (_order_list.count==1) {
        PersonalSingleShoppingDetailModel *_DataModel=_order_list.lastObject;
        if ([_DataModel.order_type isEqualToString:@"9"]) {
            NSString *timestr=@"";
            if (_DataModel.getdate.length>7) {
                timestr=[_DataModel.getdate substringToIndex:7];
                YLog(@"%@",timestr);
            }

            if ([timestr isEqualToString:@"2017-10"]) {

                _footHeight+=Height(12)+12;
            }else if ([timestr isEqualToString:@"2017-06"])
            {

                _footHeight+=Height(12)+12;
            }else if([timestr isEqualToString:@"2017-11"])
            {

                _footHeight+=Height(12)+12;
            }

        }
    }



//订单流程时间 各有不同、但是上下空白独有
        _footHeight+=Height(20)+Height(20);
       //已退款和交易关闭只有订单号和创建时间
    PersonalSingleShoppingDetailModel *model=_order_list.lastObject;
    BOOL duihuan=(_order_list.count==1)&&[model.type isEqualToString:@"1"];
        if([_total_status isEqualToString:@"8"]||[_total_status isEqualToString:@"9"])
        {
            _footHeight+=12+Height(11)+12;
        }

        if ([_total_status isEqualToString:@"7"]) {
            _footHeight+=12*3+Height(11)*2;
        }

       //待发货有订单号和创建时间还有付款时间以及发货时间
        if([_total_status isEqualToString:@"0"]||[_total_status isEqualToString:@"1"]||[_total_status isEqualToString:@"6"])
        {
            _footHeight+=12*4+3*Height(11);
        }

        //待收货和交易完成有收货时间
        if([_total_status isEqualToString:@"2"]||[_total_status isEqualToString:@"3"]||[_total_status isEqualToString:@"4"]||[_total_status isEqualToString:@"11"]){
            _footHeight+=12*5+4*Height(11);
            if (duihuan) {
                _footHeight-=12+Height(11);
            }
        }

        //已退货退款有发货时间
        if ([_total_status isEqualToString:@"5"]||[_total_status isEqualToString:@"10"]) {
            _footHeight+=12*6+5*Height(11);
        }


//底部操作按钮
    /*
     0且商品是1的时候有退款按钮
     1的时候有物流确认收货退款
     7继续付款
     2.3.4.5.10.11有查看物流
     */
//        if (([_total_status isEqualToString:@"0"]&&(_order_list.count==1))||[_total_status isEqualToString:@"1"]||[_total_status isEqualToString:@"2"]||[_total_status isEqualToString:@"7"]||[_total_status isEqualToString:@"5"]||[_total_status isEqualToString:@"10"]||[_total_status isEqualToString:@"4"]||[_total_status isEqualToString:@"11"]) {
//            _footHeight+=1+Height(15)+27+Height(15);
//        }


    return _footHeight;
}

-(BOOL)BottomButShow
{

    _BottomButShow=NO;
    PersonalSingleShoppingDetailModel *model=_order_list.lastObject;
    if (([_total_status isEqualToString:@"0"]&&(_order_list.count==1)&&[model.type isEqualToString:@"0"])||[_total_status isEqualToString:@"1"]||[_total_status isEqualToString:@"2"]||[_total_status isEqualToString:@"7"]||[_total_status isEqualToString:@"5"]||[_total_status isEqualToString:@"10"]||[_total_status isEqualToString:@"4"]||[_total_status isEqualToString:@"11"]) {
        _BottomButShow=YES;
    }

    if ((_order_list.count==1)&&[model.type isEqualToString:@"1"]) {
        _BottomButShow=NO;
    }

    return _BottomButShow;
}
@end
