//
//  AirRefundTypeVC.h
//  aTaohMall
//
//  Created by DingDing on 2017/8/24.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AirRefundTypeVC : UIViewController
@property(nonatomic,copy)NSString *orderno;//订单号
@property(nonatomic,copy)NSString *jindu;//经度
@property(nonatomic,copy)NSString *sigen;
@property(nonatomic,copy)NSString *weidu;//纬度

@property(nonatomic,copy)NSString *coordinates;//纬度

@property(nonatomic,copy)NSString *MapStartAddress;//定位用户当前地址
@end
