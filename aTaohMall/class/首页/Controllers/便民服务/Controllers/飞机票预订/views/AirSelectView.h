//
//  AirSelectView.h
//  aTaohMall
//
//  Created by JMSHT on 2017/5/19.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AirSelectDelegate <NSObject>

-(void)AirSelect:(NSString *)airline_airway Space:(NSString *)shipping_space Type:(NSString *)plane_type;

-(void)ChangeString:(NSString *)airline_airway Space:(NSString *)shipping_space Type:(NSString *)plane_type;
-(void)ChangeString;

@end
@interface AirSelectView : UIView

@property(nonatomic,strong)UIView           *shareListView;
@property(nonatomic,strong)UIControl        *huiseControl;

@property(nonatomic,strong)NSArray *AirArray;

@property(nonatomic,strong)NSArray *ModelArray;

@property(nonatomic,strong)NSArray *TypeArray;

-(void)AirArray:(NSArray *)AirArray ModelArray:(NSArray *)ModelArray TypeArray:(NSArray *)TypeArray;

- (void)showInView:(UIView *) view;
- (void)hideInView;
@property(nonatomic,weak) id <AirSelectDelegate> delegate;

@end
