//
//  XLHomeRemenModel.m
//  aTaohMall
//
//  Created by Hawky on 2018/1/8.
//  Copyright © 2018年 ysy. All rights reserved.
//

#import "XLHomeRemenModel.h"

@implementation XLHomeRemenModel

-(void)setList:(NSArray *)list
{
    NSMutableArray *temp=[[NSMutableArray alloc] init];
    for (NSDictionary *dict1 in list) {
        AllSingleShoppingModel *model=[[AllSingleShoppingModel alloc] init];

        model.gid=[NSString stringWithFormat:@"%@",dict1[@"gid"]];
        model.mid=[NSString stringWithFormat:@"%@",dict1[@"mid"]];
        model.name=[NSString stringWithFormat:@"%@",dict1[@"name"]];
        model.scopeimg=[NSString stringWithFormat:@"%@",dict1[@"scopeimg"]];
        model.pay_integer=[NSString stringWithFormat:@"%@",dict1[@"pay_integer"]];
        model.pay_maney=[NSString stringWithFormat:@"%@",dict1[@"pay_maney"]];
        model.amount=[NSString stringWithFormat:@"%@",dict1[@"amount"]];
        model.is_attribute=[NSString stringWithFormat:@"%@",dict1[@"is_attribute"]];
        model.storename=[NSString stringWithFormat:@"%@",dict1[@"storename"]];
      //  model.hot_index=[NSString stringWithFormat:@"%@",dict1[@"hot_index"]];
        model.statu=[NSString stringWithFormat:@"%@",dict1[@"status"]];
        [temp addObject:model];
    }

    _list=[temp copy];

}

@end
