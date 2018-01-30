//
//  TrainEditManViewController.h
//  aTaohMall
//
//  Created by JMSHT on 2017/7/13.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TrainEditDelegate <NSObject>

-(void)TrainEditData;

@end

@interface TrainEditManViewController : UIViewController

@property(nonatomic,copy) NSString *sigen;
@property(nonatomic,copy) NSString *ManId;

@property(nonatomic,copy) NSString *Username;

@property(nonatomic,copy) NSString *PassId;

@property(nonatomic,weak) id <TrainEditDelegate> delegate;

@end
