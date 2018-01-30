//
//  CartDingDanHeader.h
//  aTaohMall
//
//  Created by JMSHT on 2017/1/17.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CartStoreModel.h"

@protocol GoToLookDelegate <NSObject>

/** 进入商店 */
- (void)GoToLookShopStore:(NSString *)mid;

@end

@interface CartDingDanHeader : UITableViewHeaderFooterView


@property(nonatomic,strong) UIImageView *ShopImg;

@property(nonatomic,strong) UILabel *ShopLab;

@property(nonatomic,strong) UIButton *ShopButton;

@property (nonatomic, strong) CartStoreModel *carModel;

@property (nonatomic, weak)  id<GoToLookDelegate>delegate;

@end
