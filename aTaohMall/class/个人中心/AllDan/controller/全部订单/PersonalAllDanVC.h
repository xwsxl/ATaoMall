//
//  PersonalAllDanVC.h
//  aTaohMall
//
//  Created by DingDing on 2017/11/3.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonalShoppingDanDetailVC.h"
#import "PersonalBMDetailVC.h"
@interface PersonalAllDanVC : UIViewController <PersonalShoppingDanDetailVCDelegate,PersonalBMDetailVCDelegate>

-(void)selectedDingDanType:(NSString *)type AndIndexType:(NSInteger )index;


@end
