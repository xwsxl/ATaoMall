//
//  PersonalSingleShoppingDetailModel.m
//  aTaohMall
//
//  Created by DingDing on 2017/11/6.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "PersonalSingleShoppingDetailModel.h"

@implementation PersonalSingleShoppingDetailModel

//计算单元格高度
-(CGFloat)cellHeight
{
    if (!_cellHeight) {
        _cellHeight=100+Height(10);
        if (!_IsSingle&&([_status isEqualToString:@"0"]||[_status isEqualToString:@"1"]||[_status isEqualToString:@"3"]||[_status isEqualToString:@"4"]||[_status isEqualToString:@"5"]||[_status isEqualToString:@"6"]||[_status isEqualToString:@"10"]||[_status isEqualToString:@"11"]||([_status isEqualToString:@"2"]&&([_refund_count integerValue]>0||[_return_goods_count integerValue]>0)))) {
            _cellHeight+=20;
        }

    }
    return _cellHeight;
}




@end
