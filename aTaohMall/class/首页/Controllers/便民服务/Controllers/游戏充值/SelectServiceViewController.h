//
//  SelectServiceViewController.h
//  aTaohMall
//
//  Created by JMSHT on 2017/4/27.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SelectServiceDelegate <NSObject>

-(void)SelectService:(NSString *)SERVER AREA:(NSString *)AREA Name:(NSString *)qufuName;

@end
@interface SelectServiceViewController : UIViewController

@property(nonatomic,copy) NSString *cardid;

@property(nonatomic,weak) id <SelectServiceDelegate> delegate;


@end
