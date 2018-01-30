//
//  JD_ScreeningViewController.h
//  aTaohMall
//
//  Created by JMSHT on 2017/4/24.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AF_ScreeningViewControllerDelegate <NSObject>
//确定代理
- (void)determineButtonTouchEvent;

@end

@interface JD_ScreeningViewController : UIViewController

- (void)setCancleBarItemHandle:(MGBasicBlock)basicBlock;

@property(nonatomic,strong) UISwipeGestureRecognizer *leftSwipeGestureRecognizer;
@property(nonatomic,strong) UISwipeGestureRecognizer *rightSwipeGestureRecognizer;

@property(nonatomic,copy) NSString *min;

@property(nonatomic,copy) NSString *max;

@property(nonatomic,copy) NSString *PanDuan;

@property(nonatomic,copy) NSString *storeType;

@property (assign, nonatomic) CGFloat width;

@property (assign, nonatomic) id<AF_ScreeningViewControllerDelegate> delegate;

@end
