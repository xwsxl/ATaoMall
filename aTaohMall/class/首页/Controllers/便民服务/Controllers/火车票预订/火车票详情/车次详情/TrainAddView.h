//
//  TrainAddView.h
//  aTaohMall
//
//  Created by JMSHT on 2017/5/16.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TrainAddManDelegate <NSObject>

-(void)TrainAddMan:(NSArray *)man;

@end
@interface TrainAddView : UIView

@property(nonatomic,strong)UIView           *shareListView;
@property(nonatomic,strong)UIControl        *huiseControl;
@property(nonatomic,copy) NSString *sigen;
@property(nonatomic,strong) UIScrollView *scrollView;

@property(nonatomic,strong) NSArray *ManArray;

@property(nonatomic,copy) NSString *TicketCount;

@property(nonatomic,copy) NSString *Number;

- (void)showInView:(UIView *) view;
- (void)hideInView;

@property(nonatomic,weak) id <TrainAddManDelegate> delegate;

@end
