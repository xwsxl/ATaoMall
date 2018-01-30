//
//  PersonalAddRefundShoppingVC.h
//  aTaohMall
//
//  Created by Hawky on 2017/11/22.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PersonalAddRefundShoppingVCDelegate<NSObject>

-(void)DidSelectShoppings:(NSArray *)shoppingArr andHiddenAddBut:(BOOL )ishide;

@end



@interface PersonalAddRefundShoppingVC : UIViewController

@property (nonatomic,strong)NSString *order_batchid;

@property (nonatomic,strong)NSString *status;

@property (nonatomic,strong)NSString *ids;

@property (nonatomic,weak)id<PersonalAddRefundShoppingVCDelegate> delegate;

-(void)setOrderBatchid:(NSString *)order_batchid Status:(NSString *)status andIds:(NSString *)ids;

@end
