//
//  ATHBreakRulesUpImgViewController.h
//  违章查询
//
//  Created by JMSHT on 2017/7/27.
//  Copyright © 2017年 yt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PecOrderModel.h"
@interface ATHBreakRulesUpImgViewController : UIViewController
@property(nonatomic,strong)PecOrderModel *orderModel;
@property(nonatomic,copy)NSString *papersType;
@property(nonatomic,copy)NSString *count;
@end
