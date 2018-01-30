//
//  AirBaoXianView.h
//  aTaohMall
//
//  Created by JMSHT on 2017/6/1.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AirBaoXianView : UIView

@property(nonatomic,strong)UIView           *shareListView;
@property(nonatomic,strong)UIControl        *huiseControl;

- (void)showInView:(UIView *) view;
- (void)hideInView;

@property(nonatomic,copy) NSString *Text;

@end
