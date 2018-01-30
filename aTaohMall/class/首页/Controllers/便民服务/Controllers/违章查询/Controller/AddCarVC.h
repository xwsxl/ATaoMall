//
//  AddCarVC.h
//  aTaohMall
//
//  Created by Zhending Shi on 2017/7/25.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CarInfoModel.h"

@protocol AddCarRefreshDelegate <NSObject>

-(void)refreshData;

@end
@interface AddCarVC : UIViewController

@property(nonatomic,strong)CarInfoModel *CarModel;

@property(nonatomic,weak)id<AddCarRefreshDelegate> delegate;
-(void)setViewWithModel:(CarInfoModel *)CarModel;
@end
