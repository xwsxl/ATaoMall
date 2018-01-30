//
//  PersonalShoppingDanDetailVC.h
//  aTaohMall
//
//  Created by DingDing on 2017/11/6.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XLShoppingModel.h"
#import "XLDingDanModel.h"

@protocol PersonalShoppingDanDetailVCDelegate<NSObject>

-(void)SelectIndexType:(NSInteger )index;

@end

@interface PersonalShoppingDanDetailVC : UIViewController

@property (nonatomic,strong)XLDingDanModel *myDingDanModel;

@property (nonatomic,weak)id<PersonalShoppingDanDetailVCDelegate> delegate;

@end
