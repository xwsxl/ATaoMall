//
//  StoreModel.h
//  aTaohMall
//
//  Created by JMSHT on 2017/1/3.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ShopModel.h"

@interface StoreModel : NSObject


@property(nonatomic,copy) NSString *mid;

@property(nonatomic,copy) NSString *storename;

@property(nonatomic,strong) NSMutableArray *shop;


- (void)configGoodsArrayWithArray:(NSArray*)array;

/** 记录选中状态 */
@property (nonatomic, assign) BOOL selectState;

//记录店铺选中
@property (nonatomic, assign) BOOL selectShop;

/** 记录编辑按钮的状态 */
@property (nonatomic, assign) BOOL editState;
@end
