//
//  BusinessModel.m
//  aTaohMall
//
//  Created by JMSHT on 16/5/19.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import "BusinessModel.h"

@implementation BusinessModel

-(NSString *)description
{
    return [NSString stringWithFormat:@"%@人进店看过,店铺号%@,店铺图片%@,店铺名%@",_click_volume,_id,_logo,_storename];
}
@end
