//
//  BMDanModel.m
//  aTaohMall
//
//  Created by Hawky on 2017/11/28.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "BMDanModel.h"

@implementation BMDanModel
//-(NSArray *)resList
//{
//    if (!_resList) {
//        _resList=[NSArray new];
//    }
//    return _resList;
//}
//
//-(void)reslistWithArray:(NSArray *)tempArr
//{
//    NSMutableArray *arr=[NSMutableArray new];
//
//    for (NSDictionary *dic in tempArr) {
//        BMSingleModel *model=[[BMSingleModel alloc] init];
//
//
//
//
//
//
//
//
//
//
//    }
//
//    _resList=[arr copy];
//}

-(CGFloat)cellHeight
{
    if (_cellHeight) {
        _cellHeight=0;
        _cellHeight=14+Height(30)+70+Height(30)+14+Height(20)+Height(20);

        if ([_status isEqualToString:@"7"]) {
            _cellHeight+=Height(12)+27+Height(12);
        }
    }
    return _cellHeight;
}

-(CGFloat)getCellHeight
{

    CGFloat cellheight=0;

        cellheight=0;

        cellheight=14+Height(30)+70+Height(30)+14+Height(20)+Height(20);

    if ([_status isEqualToString:@"0"]||([_status isEqualToString:@"3"]&&(([_is_refund isEqualToString:@"0"]&&[_order_type isEqualToString:@"4"])||[_order_type isEqualToString:@"5"]))) {
            cellheight+=Height(12)+27+Height(12);
        }
    return cellheight;

}

@end
