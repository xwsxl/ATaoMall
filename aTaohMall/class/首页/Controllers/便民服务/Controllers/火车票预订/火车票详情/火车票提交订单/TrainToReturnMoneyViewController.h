//
//  TrainToReturnMoneyViewController.h
//  aTaohMall
//
//  Created by JMSHT on 2017/5/16.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TrainToReturnMoneyDelegate <NSObject>

-(void)TrainToReturnMoney;

@end

@interface TrainToReturnMoneyViewController : UIViewController

@property(nonatomic,strong) NSArray *ManArray;

@property(nonatomic,copy) NSString *Date;

@property(nonatomic,copy) NSString *StartCity;

@property(nonatomic,copy) NSString *ArriveCity;

@property(nonatomic,copy) NSString *CheCi;
@property(nonatomic,copy) NSString *ordrno;
@property(nonatomic,copy)NSString *bsr_type;				//0：差额退款
@property(nonatomic,copy)NSString *integral_amount;		//		退款积分(差额退款)
@property(nonatomic,copy)NSString *refund_amount;		//		退款金额(差额退款)
@property(nonatomic,copy)NSString *order_cash;			//		实际票价
@property(nonatomic,copy)NSString *Price;			//		实际票价
@property(nonatomic,copy)NSString *sigen;







@property(nonatomic,weak) id <TrainToReturnMoneyDelegate> delegate;
@end
