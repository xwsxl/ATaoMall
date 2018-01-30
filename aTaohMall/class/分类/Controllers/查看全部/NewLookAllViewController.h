//
//  NewLookAllViewController.h
//  aTaohMall
//
//  Created by JMSHT on 2017/4/11.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewLookAllViewController : UIViewController

@property(nonatomic,copy) NSString *titleName; //标题

@property(nonatomic,copy) NSString *classId; //二级id

@property(nonatomic,copy) NSString *type; //排序顺序

@property(nonatomic,copy) NSString *gid; //

@property(nonatomic,copy)NSString *PanDuan;//判断是否回到顶部

@property(nonatomic,copy) NSString *minimumPrice;

@property(nonatomic,copy) NSString *maximumPrice;

@property(nonatomic,copy) NSString *storeType;
@end
