//
//  CheCiChangeView.h
//  aTaohMall
//
//  Created by JMSHT on 2017/5/15.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CheCiChangeDelegate <NSObject>

-(void)Price:(NSString *)Price ZW:(NSString *)zw Array:(NSArray *)array Is_accept_standing:(NSString *)is_accept_standing;

@end
@interface CheCiChangeView : UIView

@property(nonatomic,strong)UIView           *shareListView;
@property(nonatomic,strong)UIControl        *huiseControl;
@property(nonatomic,strong)NSArray *Array;
- (void)showInView:(UIView *) view;
- (void)hideInView;

@property(nonatomic,weak) id <CheCiChangeDelegate> delegate;

@end
