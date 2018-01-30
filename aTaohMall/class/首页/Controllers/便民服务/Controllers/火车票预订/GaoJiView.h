//
//  GaoJiView.h
//  aTaohMall
//
//  Created by JMSHT on 2017/5/12.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol GaoJiDelegate <NSObject>

-(void)fromString:(NSString *)fromString ToStationString:(NSString *)toStationString SitTypeString:(NSString *)typeString;
-(void)setUnselect;

@end
@interface GaoJiView : UIView

@property(nonatomic,strong)UIView           *shareListView;
@property(nonatomic,strong)UIControl        *huiseControl;

@property(nonatomic,strong)NSArray *start;
@property(nonatomic,strong)NSArray *end;
@property(nonatomic,strong)NSArray *sitType;
@property(nonatomic,weak)id <GaoJiDelegate> delegate;

- (void)showInView:(UIView *) view;
- (void)hideInView;
- (id)initWithFrame:(CGRect)frame withStart:(NSArray *)startArray andEndArray:(NSArray *)endArray;
//@property(nonatomic,weak) id <PaiXuDelegate> delegate;

@end
