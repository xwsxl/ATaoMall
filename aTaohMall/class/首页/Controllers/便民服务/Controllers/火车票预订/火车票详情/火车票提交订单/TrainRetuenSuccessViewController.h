//
//  TrainRetuenSuccessViewController.h
//  aTaohMall
//
//  Created by JMSHT on 2017/5/16.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TrainRetuenSuccessViewController : UIViewController

@property(nonatomic,copy)NSString *jindu;//经度

@property(nonatomic,copy)NSString *weidu;//纬度

@property(nonatomic,copy)NSString *coordinates;//纬度

@property(nonatomic,copy)NSString *MapStartAddress;//定位用户当前地址

@property(nonatomic,copy)NSString *sigen;//验签值

@property(nonatomic,copy)NSString *Train;//验签值

@property(nonatomic,copy)NSString *orderno;//验签值
@end
