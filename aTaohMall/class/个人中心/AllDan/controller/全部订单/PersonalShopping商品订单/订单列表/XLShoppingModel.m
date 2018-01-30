//
//  XLShoppingModel.m
//  aTaohMall
//
//  Created by DingDing on 2017/11/3.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "XLShoppingModel.h"

@implementation XLShoppingModel
-(NSString *)goodsCount
{
    if (!_goodsCount) {
        _goodsCount=@"1";
    }
    return _goodsCount;
}
//计算单元格高度
-(CGFloat)cellHeight
{

    if (!_cellHeight) {
        _cellHeight=100+Height(10);
//不是单个商品且有退款按钮 高度增加20
        if (!_isSingle&&([_status isEqualToString:@"0"]||[_status isEqualToString:@"1"]||[_status isEqualToString:@"3"]||[_status isEqualToString:@"4"]||[_status isEqualToString:@"5"]||[_status isEqualToString:@"6"]||[_status isEqualToString:@"10"]||[_status isEqualToString:@"11"]||([_status isEqualToString:@"2"]&&([_refund_count integerValue]>0||[_return_goods_count integerValue]>0)))){
            _cellHeight+=20;
        }
        if ([_dingDanType isEqualToString:@"refundType"]&&_showBottom) {
            _cellHeight+=Height(20)+12;
        }
        
    }
    return _cellHeight;
}
-(NSString *)dingDanType
{
    if (!_dingDanType) {
        _dingDanType=@"";
    }
    return _dingDanType;
}
-(NSString *)totalStatus
{
    if (!_totalStatus) {
        _totalStatus=@"";
    }
    return _totalStatus;
}
@end
