//
//  XLDingDanModel.m
//  aTaohMall
//
//  Created by DingDing on 2017/11/3.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "XLDingDanModel.h"

@implementation XLDingDanModel
-(NSMutableArray *)goods_order_list
{
    if (!_goods_order_list) {
        _goods_order_list=[[NSMutableArray alloc] init];
    }
    return _goods_order_list;
}

-(void)goodsOrderListFromArray:(NSArray *)tempArr withType:(NSString *)type
{
    [self.goods_order_list removeAllObjects];
    if ([tempArr isEqual:[[NSNull alloc] init]]) {
        return;
    }
    BOOL temp=YES;
    if (tempArr&&tempArr.count>1) {
        temp=NO;
    }
    for (NSDictionary *goodsDic in tempArr) {
        XLShoppingModel *model=[XLShoppingModel new];
        model.attribute_str=[NSString stringWithFormat:@"%@",goodsDic[@"attribute_str"]];
        if ([model.attribute_str containsString:@"null"]) {
            model.attribute_str=@"";
        }
        model.count=[NSString stringWithFormat:@"%@",goodsDic[@"count"]];
        model.detailId=[NSString stringWithFormat:@"%@",goodsDic[@"detailId"]];
        model.gid=[NSString stringWithFormat:@"%@",goodsDic[@"gid"]];
        model.ID=[NSString stringWithFormat:@"%@",goodsDic[@"id"]];
        model.mid=[NSString stringWithFormat:@"%@",goodsDic[@"mid"]];
        model.name=[NSString stringWithFormat:@"%@",goodsDic[@"name"]];
        model.number=[NSString stringWithFormat:@"%@",goodsDic[@"number"]];
        model.order_type=[NSString stringWithFormat:@"%@",goodsDic[@"order_type"]];
        model.order_no=[NSString stringWithFormat:@"%@",goodsDic[@"orderno"]];
        model.pay_integer=[NSString stringWithFormat:@"%@",goodsDic[@"pay_integer"]];
        model.pay_money=[NSString stringWithFormat:@"%@",goodsDic[@"pay_maney"]];
        model.payinteger=[NSString stringWithFormat:@"%@",goodsDic[@"payintegral"]];
        model.paymoney=[NSString stringWithFormat:@"%@",goodsDic[@"paymoney"]];
        model.scopeimg=[NSString stringWithFormat:@"%@",goodsDic[@"scopeimg"]];
        model.status=[NSString stringWithFormat:@"%@",goodsDic[@"status"]];
        model.stocks=[NSString stringWithFormat:@"%@",goodsDic[@"stocks"]];
        model.totalfreight=[NSString stringWithFormat:@"%@",goodsDic[@"totalfreight"]];
        model.type=[NSString stringWithFormat:@"%@",goodsDic[@"type"]];
        model.order_batchid=[NSString stringWithFormat:@"%@",goodsDic[@"order_batchid"]];
        model.refund_batchid=[NSString stringWithFormat:@"%@",goodsDic[@"batchid"]];
        model.refund_count=[NSString stringWithFormat:@"%@",goodsDic[@"refund_count"]];
        model.return_goods_count=[NSString stringWithFormat:@"%@",goodsDic[@"return_goods_count"]];
        model.getdate=[NSString stringWithFormat:@"%@",goodsDic[@"getdate"]];

        model.discount_integral=[NSString stringWithFormat:@"%@",goodsDic[@"discount_integral"]];

        model.total_money=[NSString stringWithFormat:@"%@",goodsDic[@"returns_money"]];
        model.total_integral=[NSString stringWithFormat:@"%@",goodsDic[@"returns_integral"]];
        model.isSingle=temp;
        model.dingDanType=type;
        [self.goods_order_list addObject:model];
    }

    for (int i=0; i<self.goods_order_list.count; i++) {
        XLShoppingModel *model=self.goods_order_list[i];
        model.showBottom=YES;
        int j=i+1;
        if (j<self.goods_order_list.count) {
            XLShoppingModel *model1=self.goods_order_list[j];
            if ([model.refund_batchid isEqualToString:model1.refund_batchid]) {
                model.showBottom=NO;
                model1.showBottom=YES;
                model1.total_money=[NSString stringWithFormat:@"%.2f",[model.total_money floatValue]+[model1.total_money floatValue]];
                model1.total_integral=[NSString stringWithFormat:@"%.2f",[model.total_integral floatValue]+[model1.total_integral floatValue]];
            }
            [self.goods_order_list replaceObjectAtIndex:j withObject:model1];
        }

        [self.goods_order_list replaceObjectAtIndex:i withObject:model];

    }







}

//解析方法
-(void)goodsOrderListFromArray:(NSArray *)tempArr
{
    [self.goods_order_list removeAllObjects];
    if ([tempArr isEqual:[[NSNull alloc] init]]) {
        return;
    }
    BOOL temp=YES;
    if (tempArr&&tempArr.count>1) {
        temp=NO;
    }
    for (NSDictionary *goodsDic in tempArr) {
        XLShoppingModel *model=[XLShoppingModel new];
        model.attribute_str=[NSString stringWithFormat:@"%@",goodsDic[@"attribute_str"]];
        if ([model.attribute_str containsString:@"null"]) {
            model.attribute_str=@"";
        }
        model.count=[NSString stringWithFormat:@"%@",goodsDic[@"count"]];
        model.detailId=[NSString stringWithFormat:@"%@",goodsDic[@"detailId"]];
        model.gid=[NSString stringWithFormat:@"%@",goodsDic[@"gid"]];
        model.ID=[NSString stringWithFormat:@"%@",goodsDic[@"id"]];
        model.mid=[NSString stringWithFormat:@"%@",goodsDic[@"mid"]];
        model.name=[NSString stringWithFormat:@"%@",goodsDic[@"name"]];
        model.number=[NSString stringWithFormat:@"%@",goodsDic[@"number"]];
        model.order_type=[NSString stringWithFormat:@"%@",goodsDic[@"order_type"]];
        model.order_no=[NSString stringWithFormat:@"%@",goodsDic[@"orderno"]];
        model.pay_integer=[NSString stringWithFormat:@"%@",goodsDic[@"pay_integer"]];
        model.pay_money=[NSString stringWithFormat:@"%@",goodsDic[@"pay_maney"]];
        model.payinteger=[NSString stringWithFormat:@"%@",goodsDic[@"payintegral"]];
        model.paymoney=[NSString stringWithFormat:@"%@",goodsDic[@"paymoney"]];
        model.scopeimg=[NSString stringWithFormat:@"%@",goodsDic[@"scopeimg"]];
        model.status=[NSString stringWithFormat:@"%@",goodsDic[@"status"]];
        model.stocks=[NSString stringWithFormat:@"%@",goodsDic[@"stocks"]];
        model.totalfreight=[NSString stringWithFormat:@"%@",goodsDic[@"totalfreight"]];
        model.type=[NSString stringWithFormat:@"%@",goodsDic[@"type"]];
        model.order_batchid=[NSString stringWithFormat:@"%@",goodsDic[@"order_batchid"]];
        model.refund_count=[NSString stringWithFormat:@"%@",goodsDic[@"refund_count"]];
        model.return_goods_count=[NSString stringWithFormat:@"%@",goodsDic[@"return_goods_count"]];
        model.getdate=[NSString stringWithFormat:@"%@",goodsDic[@"getdate"]];
         model.discount_integral=[NSString stringWithFormat:@"%@",goodsDic[@"discount_integral"]];
        model.isSingle=temp;
        [self.goods_order_list addObject:model];
    }
}

//计算分区尾高度
-(CGFloat)sectionFootHeight
{
    if (!_sectionFootHeight) {
        _sectionFootHeight=0;
        _sectionFootHeight+=Height(10)+15+Height(7)+12+Height(20)+Height(10);
        //0：代发货，1：待收货  有退款按钮   7：代付款 有继续付款按钮 2
         XLShoppingModel *model=_goods_order_list.lastObject;
        if (([_total_status isEqualToString:@"0"] &&(_goods_order_list.count==1))||[_total_status isEqualToString:@"1"]||[_total_status isEqualToString:@"7"]||[_total_status isEqualToString:@"8"]||[_total_status isEqualToString:@"2"]) {
            _sectionFootHeight+=Height(24)+27;
        }
        if (_goods_order_list.count==1&&([model.type isEqualToString:@"1"])) {
            _sectionFootHeight-=Height(24)+27;
        }

        if (_goods_order_list.count==1) {
            XLShoppingModel *_DataModel=_goods_order_list.lastObject;
            if ([_DataModel.order_type isEqualToString:@"9"]) {
                NSString *timestr=@"";
                if (_DataModel.getdate.length>7) {
                    timestr=[_DataModel.getdate substringToIndex:7];
                    YLog(@"%@",timestr);
                }

                if ([timestr isEqualToString:@"2017-10"]) {

                    _sectionFootHeight+=Height(7)+12;
                }else if ([timestr isEqualToString:@"2017-06"])
                {

                    _sectionFootHeight+=Height(7)+12;
                }else if([timestr isEqualToString:@"2017-11"])
                {

                    _sectionFootHeight+=Height(7)+12;
                }

            }
        }
    }
    return _sectionFootHeight;
}

-(CGFloat)refundFootHeight
{
    if (!_sectionFootHeight) {
        _sectionFootHeight=1+Height(10);
      //  _sectionFootHeight=Height(30)+12+Height(10)+1+Height(24)+27;
        if (_goods_order_list.count==1) {
        _sectionFootHeight=1+Height(24)+27+Height(10);
        }
    }
    return _sectionFootHeight;
}


-(instancetype)initWithPersonalShoppingDetailModel:(PersonalShoppingDanDetailModel *)model
{

    if (self=[super init]) {


    }
    return self;
}

-(NSString *)dingDanType
{
    if (!_dingDanType) {
        _dingDanType=@"";
    }
    return _dingDanType;
}


@end
