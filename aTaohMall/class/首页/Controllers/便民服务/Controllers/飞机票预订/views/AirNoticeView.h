//
//  AirNoticeView.h
//  aTaohMall
//
//  Created by JMSHT on 2017/7/14.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AirNoticeViewDelegate <NSObject>

-(void)AirNoticeViewRelodate;

@end
@interface AirNoticeView : UIView

@property(nonatomic,strong)UIView           *shareListView;
@property(nonatomic,strong)UIControl        *huiseControl;

- (void)showInView:(UIView *) view;
- (void)hideInView;

@property(nonatomic,weak) id <AirNoticeViewDelegate> delegate;
@end
