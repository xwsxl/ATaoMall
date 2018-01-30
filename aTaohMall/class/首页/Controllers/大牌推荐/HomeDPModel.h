//
//  HomeDPModel.h
//  aTaohMall
//
//  Created by Hawky on 2017/12/30.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AllSingleShoppingModel.h"
@interface HomeDPModel : NSObject
/*
 "id": 26,
 "cream_name": "嗷嗷3",
 "represent": "1111",
 "picpath": "http://image.athmall.com/ATH/union/upload/homePage/c7de206b000000c0.png",
 "remarks": "",
 "good_list": [
 */

@property (nonatomic,strong)NSString *ID;
@property (nonatomic,strong)NSString *cream_name;
@property (nonatomic,strong)NSString *represent;
@property (nonatomic,strong)NSString *picpath;
@property (nonatomic,strong)NSString *remarks;
@property (nonatomic,strong)NSArray *good_list;


@property (nonatomic,assign)CGFloat cellHeight;



-(void)goodListWithArray:(NSArray *)arr;
@end
