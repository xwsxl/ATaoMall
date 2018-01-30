//
//  TuiKuanGoBackView.h
//  aTaohMall
//
//  Created by JMSHT on 2017/6/27.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TuiKuanGoBackView : UIView

@property(nonatomic,strong)UIView           *shareListView;
@property(nonatomic,strong)UIView           *shareListView1;
@property(nonatomic,strong)UIView           *shareListView2;
@property(nonatomic,strong)UIView           *shareListView3;
@property(nonatomic,strong)UIView           *shareListView4;
@property(nonatomic,strong)UIControl        *huiseControl;

- (void)showInView:(UIView *) view Text:(NSString *)text;
- (void)hideInView;

@property(nonatomic,copy) NSString *Text1;
@property(nonatomic,copy) NSString *Text2;
@end
