//
//  ClassifyModel.h
//  aTaohMall
//
//  Created by JMSHT on 16/5/30.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClassifyModel : NSObject

@property(nonatomic,copy)NSString *GoodsId;//分类id

@property(nonatomic,copy)NSString *gid;

@property(nonatomic,copy)NSString *name;//分类

@property(nonatomic,copy)NSString *goods_name;//商品介绍

@property(nonatomic,copy)NSString *name1;//分类子分类

@property(nonatomic,copy)NSString *logo1;//分类图片

@property(nonatomic,copy)NSString *storename;

@property (nonatomic,strong)NSArray *goodsList;

@property (nonatomic,strong)NSArray *SelectedBrand_list;

@property (nonatomic,strong)NSArray *SmallClass_list;


@end
