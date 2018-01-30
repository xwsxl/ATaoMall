//
//  PeccSelectCityVC.h
//  aTaohMall
//
//  Created by Zhending Shi on 2017/7/28.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SelectCityDelegate <NSObject>

-(void)hasSelectCity:(NSMutableArray *)array;

@end


@interface PeccSelectCityVC : UIViewController
@property(nonatomic,strong)NSMutableArray *selectCityArr;
@property(nonatomic,weak)id<SelectCityDelegate> delegate;
@end
