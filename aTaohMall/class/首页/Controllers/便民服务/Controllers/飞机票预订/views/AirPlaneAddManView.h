//
//  AirPlaneAddManView.h
//  aTaohMall
//
//  Created by JMSHT on 2017/5/23.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AirPlaneAddManDelegate <NSObject>

-(void)AirPlaneAddMan:(NSArray *)man;

-(void)CanClePerson:(NSArray *)man;
@end
@interface AirPlaneAddManView : UIView

@property(nonatomic,strong)UIView           *shareListView;
@property(nonatomic,strong)UIControl        *huiseControl;
@property(nonatomic,copy)NSString *PageString;
- (void)showInView:(UIView *) view;
- (void)hideInView;

@property(nonatomic,strong) NSArray *ManArray;
@property(nonatomic,copy) NSString *sigen;

@property(nonatomic,copy) NSString *TicketCount;

@property(nonatomic,copy) NSString *ManKidString;

@property(nonatomic,strong) UIScrollView *scrollView;

@property(nonatomic,weak) id <AirPlaneAddManDelegate> delegate;

@end
