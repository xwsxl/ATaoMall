//
//  GotoShopLookHeaderView.h
//  aTaohMall
//
//  Created by JMSHT on 16/5/16.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GotoShopLookHeaderView : UICollectionReusableView

@property (weak, nonatomic) IBOutlet UIImageView *ShopImageView;

@property (weak, nonatomic) IBOutlet UIButton *ShopAddressButton;

@property (weak, nonatomic) IBOutlet UILabel *ShopNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *ShopTypeLabel;

@property (weak, nonatomic) IBOutlet UILabel *ShopReduceLabel;
@end
