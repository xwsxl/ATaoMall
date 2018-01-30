//
//  TrainMingXiView.h
//  aTaohMall
//
//  Created by JMSHT on 2017/7/17.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TrainMingXiDelegate <NSObject>

-(void)TrainmingXi;

@end
@interface TrainMingXiView : UIView

@property(nonatomic,strong)UIView           *shareListView;
@property(nonatomic,strong)UIControl        *huiseControl;

- (void)showInView:(UIView *) view;
- (void)hideInView;

-(void)Price:(NSString *)price JiJian:(NSString *)fei BaoXian:(NSString *)interger;

@property(nonatomic,weak) id <TrainMingXiDelegate> delegate;

@end
