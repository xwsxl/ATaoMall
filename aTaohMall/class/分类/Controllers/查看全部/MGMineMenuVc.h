//
//  MGMineMenuVc.h
//  JDSelectDemo
//
//  Created by mark on 15/8/3.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "MGBaseViewController.h"

@interface MGMineMenuVc : MGBaseViewController
- (void)setCancleBarItemHandle:(MGBasicBlock)basicBlock;

@property(nonatomic,strong) UISwipeGestureRecognizer *leftSwipeGestureRecognizer;
@property(nonatomic,strong) UISwipeGestureRecognizer *rightSwipeGestureRecognizer;

@property(nonatomic,copy) NSString *min;

@property(nonatomic,copy) NSString *max;

@property(nonatomic,copy) NSString *PanDuan;

@property(nonatomic,copy) NSString *storeType;

@end
