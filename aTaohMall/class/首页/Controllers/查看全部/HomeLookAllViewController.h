//
//  HomeLookAllViewController.h
//  aTaohMall
//
//  Created by JMSHT on 16/6/15.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

//typedef NS_ENUM(NSInteger, eRefreshType){
//    eRefreshTypeDefine=0,
//    eRefreshTypeProgress=1
//};

@interface HomeLookAllViewController : UIViewController


@property (weak, nonatomic) IBOutlet UILabel *TitleLabel;

@property(nonatomic,copy)NSString *TitleName;//标题

@property(nonatomic,copy)NSString *classId;

@property(nonatomic,copy)NSString *type;//排序类型

@property (weak, nonatomic) IBOutlet UILabel *AnRenQiLabel;

@property (weak, nonatomic) IBOutlet UILabel *AnJiaGeLabel;

@property (weak, nonatomic) IBOutlet UIButton *RenQiDownButton;

@property (weak, nonatomic) IBOutlet UIButton *RenQiUpButton;

@property (weak, nonatomic) IBOutlet UIButton *JiaGeUpButton;

@property (weak, nonatomic) IBOutlet UIButton *JiaGeDownButton;

//@property (nonatomic,assign)eRefreshType Ftype;


@property(nonatomic,copy)NSString *PanDuan;//判断是否回到顶部
@end
