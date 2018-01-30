//
//  BusinessQurtViewController.h
//  aTaohMall
//
//  Created by JMSHT on 16/5/12.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, eRefreshType){
    eRefreshTypeDefine=0,
    eRefreshTypeProgress=1
};


@interface BusinessQurtViewController : UIViewController


@property (nonatomic,assign)eRefreshType type;
@end
