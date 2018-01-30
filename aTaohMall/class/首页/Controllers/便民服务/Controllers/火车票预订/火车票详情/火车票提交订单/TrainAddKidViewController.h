//
//  TrainAddKidViewController.h
//  aTaohMall
//
//  Created by JMSHT on 2017/7/17.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TrainAddKidReloadDelegate <NSObject>

-(void)TrainKid:(NSString *)Kid Name:(NSString *)name Passportseno:(NSString *)passportseno Index:(NSString *)Index;

@end
@interface TrainAddKidViewController : UIViewController

@property(nonatomic,copy) NSString *sigen;

@property(nonatomic,copy) NSString *IId;

@property(nonatomic,copy) NSString *Index;//下标

@property(nonatomic,copy) NSString *passportseno;

@property(nonatomic,weak) id <TrainAddKidReloadDelegate> delegate;

@end
