//
//  SettingPassWordViewController.h
//  aTaohMall
//
//  Created by JMSHT on 16/5/18.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

//协议实现反向传值
@protocol OutMessageDelegate <NSObject>

-(void)outStatus;

@end
@interface SettingPassWordViewController : UIViewController

@property(nonatomic,weak)id <OutMessageDelegate> delegate;//代理对象
@end
