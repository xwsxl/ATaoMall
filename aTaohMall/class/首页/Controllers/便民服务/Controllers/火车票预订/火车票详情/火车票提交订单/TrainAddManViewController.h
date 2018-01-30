//
//  TrainAddManViewController.h
//  火车票
//
//  Created by 阳涛 on 17/5/15.
//  Copyright © 2017年 yangtao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TrainAddDelegate <NSObject>

-(void)TrainReloadData;

@end
@interface TrainAddManViewController : UIViewController

@property(nonatomic,copy) NSString *sigen;

@property(nonatomic,weak) id <TrainAddDelegate> delegate;
@end
