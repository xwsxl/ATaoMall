//
//  GotoShopLookViewController.h
//  aTaohMall
//
//  Created by JMSHT on 16/5/16.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BusinessQurtViewController.h"

@protocol BusinessReloadDataDelegate <NSObject>

-(void)reloadData;

-(void)reloadData1;

@end
@interface GotoShopLookViewController : UIViewController

@property(nonatomic,copy)NSString *mid;

@property(nonatomic,copy)NSString *type;//判断返回界面

@property(nonatomic,copy)NSString *BackString;//判断tabbar是否影藏

@property(nonatomic,copy)NSString *GetString;//判断来源于几级界面

@property(nonatomic,weak) id  <BusinessReloadDataDelegate> delegate;

@end
