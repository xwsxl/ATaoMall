//
//  AirPlaneNameShowView.h
//  aTaohMall
//
//  Created by JMSHT on 2017/5/23.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AirPlaneNameShowView : UIView

@property(nonatomic,strong)UIView           *shareListView;
@property(nonatomic,strong)UIControl        *huiseControl;

- (void)showInView:(UIView *) view;
- (void)hideInView;

@end
