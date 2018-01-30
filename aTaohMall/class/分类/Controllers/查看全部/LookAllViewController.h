//
//  LookAllViewController.h
//  aTaohMall
//
//  Created by JMSHT on 16/5/12.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LookAllViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *lookAllTitleLabel;//标题

@property(nonatomic,copy) NSString *titleName; //标题

@property(nonatomic,copy) NSString *classId; //二级id

@property(nonatomic,copy) NSString *type; //排序顺序

@property(nonatomic,copy) NSString *gid; //

@property (weak, nonatomic) IBOutlet UILabel *AnRenQiLabel;//按人气

@property (weak, nonatomic) IBOutlet UILabel *AnJiaGeLabel;//按价格

@property (weak, nonatomic) IBOutlet UIButton *RenQiUpButton;//人气升

@property (weak, nonatomic) IBOutlet UIButton *RenQiDownButton;//人气降

@property (weak, nonatomic) IBOutlet UIButton *JiaGeUpButton;//价格升

@property (weak, nonatomic) IBOutlet UIButton *JIaGeDownButton;//价格降

@property(nonatomic,copy)NSString *PanDuan;//判断是否回到顶部
@end
