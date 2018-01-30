//
//  TrainPriceDetailViewController.h
//  aTaohMall
//
//  Created by JMSHT on 2017/7/18.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TrainPriceDetailViewController : UIViewController

@property(nonatomic,copy)NSString *bsr_type;				//0：差额退款
@property(nonatomic,copy)NSString *integral_amount;		//		退款积分(差额退款)
@property(nonatomic,copy)NSString *refund_amount;		//		退款金额(差额退款)
@property(nonatomic,copy)NSString *order_cash;			//		实际票价
@property(nonatomic,copy)NSString *Price;			//		实际票价
@end
