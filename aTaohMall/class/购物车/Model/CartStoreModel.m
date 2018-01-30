//
//  CartStoreModel.m
//  aTaohMall
//
//  Created by JMSHT on 2017/1/18.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "CartStoreModel.h"

#import "CartGoodsModel.h"

@implementation CartStoreModel

- (void)configGoodsArrayWithArray:(NSArray*)array; {
    if (array.count > 0) {
        NSMutableArray *dataArray = [NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *dic in array) {
            CartGoodsModel *model = [[CartGoodsModel alloc]init];
            
            
            model.attribute_str = [dic objectForKey:@"attribute_str"];
            model.detailId = [dic objectForKey:@"detailId"];
            model.exchange = [dic objectForKey:@"exchange"];
            model.exchange_type = [dic objectForKey:@"exchange_type"];
            model.good_type = [dic objectForKey:@"good_type"];
            model.freight = [dic objectForKey:@"freight"];
            model.gid = [dic objectForKey:@"gid"];
            model.name = [dic objectForKey:@"name"];
            model.number = [dic objectForKey:@"number"];
            model.pay_integer = [dic objectForKey:@"pay_integer"];
            model.pay_maney = [dic objectForKey:@"pay_maney"];
            model.scopeimg = [dic objectForKey:@"scopeimg"];
            model.sid = [dic objectForKey:@"sid"];
            
            [dataArray addObject:model];
        }
        
        _goodsList = [dataArray mutableCopy];
    }
}

@end
