//
//  CartStoreModel.h
//  aTaohMall
//
//  Created by JMSHT on 2017/1/18.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CartGoodsModel.h"

@interface CartStoreModel : NSObject

@property(nonatomic,copy) NSString *mid;

@property(nonatomic,copy) NSString *storename;

@property(nonatomic,copy) NSString *remark;

@property(nonatomic,strong) NSMutableArray *goodsList;

- (void)configGoodsArrayWithArray:(NSArray*)array;

@end
