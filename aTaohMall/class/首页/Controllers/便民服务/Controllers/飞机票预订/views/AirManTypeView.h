//
//  AirManTypeView.h
//  aTaohMall
//
//  Created by JMSHT on 2017/5/23.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AirManTypeDelegate <NSObject>

-(void)AirManType:(NSString *)type;

@end
@interface AirManTypeView : UIView

@property(nonatomic,strong)UIView           *shareListView;
@property(nonatomic,strong)UIControl        *huiseControl;

- (void)showInView:(UIView *) view;
- (void)hideInView;

@property(nonatomic,weak) id <AirManTypeDelegate> delegate;

@end
