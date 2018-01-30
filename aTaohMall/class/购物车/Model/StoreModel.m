//
//  StoreModel.m
//  aTaohMall
//
//  Created by JMSHT on 2017/1/3.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "StoreModel.h"

#import "ShopModel.h"

@implementation StoreModel

- (void)configGoodsArrayWithArray:(NSArray*)array{
    if (array.count > 0) {
        NSMutableArray *dataArray = [NSMutableArray arrayWithCapacity:0];
        
        _shop = [NSMutableArray new];//实例化数组对象
        
        for (NSDictionary *dic in array) {
            ShopModel *model = [[ShopModel alloc]init];
            
            model.count = [dic objectForKey:@"count"];
            model.name = [dic objectForKey:@"name"];
            model.attribute_str = [dic objectForKey:@"attribute_str"];
            model.detailId = [dic objectForKey:@"detailId"];
            model.exchange_type = [dic objectForKey:@"exchange_type"];
            
//            NSLog(@"====model.exchange_type====%@",model.exchange_type);
            
            model.gid = [dic objectForKey:@"gid"];
            model.good_type = [dic objectForKey:@"good_type"];
            model.mid = [dic objectForKey:@"mid"];
            model.number = [dic objectForKey:@"number"];
            model.pay_integer =[NSString stringWithFormat:@"%@",[dic objectForKey:@"pay_integer"]];
            model.pay_maney = [NSString stringWithFormat:@"%@",[dic objectForKey:@"pay_maney"]];
            model.scopeimg = [dic objectForKey:@"scopeimg"];
            model.sid = [dic objectForKey:@"sid"];
            model.status = [dic objectForKey:@"status"];
            model.status1 = [dic objectForKey:@"status1"];
            model.stock = [dic objectForKey:@"stock"];
            model.smallIds = [dic objectForKey:@"smallIds"];
            model.attribute  = [dic objectForKey:@"attribute"];
            
            model.YYYYYYYYY = [dic objectForKey:@"stock"];
            model.TTTTTTTTT = [dic objectForKey:@"stock"];
            
            [dataArray addObject:model];
            
            if ([model.pay_integer isEqualToString:@"<null>"]||[model.pay_integer isEqualToString:@"(null)"]) {
                model.pay_integer=@"0.0";
            }
            NSLog(@"==pay_integer==%@==pay_maney==%@===%@",model.pay_integer,model.pay_maney,model.name);
            
        }
        
        _shop = [dataArray mutableCopy];
    }
}


@end
