//
//  AirPlaneAddPassngerViewController.h
//  aTaohMall
//
//  Created by JMSHT on 2017/5/23.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AirPlaneAddPassngerDelagate <NSObject>

-(void)AirPlaneAddPassnger;

@end
@interface AirPlaneAddPassngerViewController : UIViewController

@property(nonatomic,copy) NSString *sigen;

@property(nonatomic,weak) id <AirPlaneAddPassngerDelagate> delegate;
@end
