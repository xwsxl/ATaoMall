//
//  YTChangeViewController.h
//  aTaohMall
//
//  Created by JMSHT on 2016/10/12.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YTGetGoodsAdddressDelegate <NSObject>



-(void)YTAddressReload;


@end

@interface YTChangeViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *YTNameTF;

@property (weak, nonatomic) IBOutlet UITextField *YTPhoneTF;

@property (weak, nonatomic) IBOutlet UILabel *YTAddressLabel;

@property (weak, nonatomic) IBOutlet UITextField *YTDetailTF;

@property (weak, nonatomic) IBOutlet UISwitch *YTSwitch;

@property(nonatomic,copy)NSString *sigens;

@property(nonatomic,copy)NSString *province;//省

@property(nonatomic,copy)NSString *city;

@property(nonatomic,copy)NSString *county;

@property(nonatomic,copy)NSString *defaultstate;

@property(nonatomic,copy) NSString *aid;

@property(nonatomic,copy) NSString *SwitchStatus;//开关状态

@property(nonatomic,copy) NSString *aaid;

@property(nonatomic,copy) NSString *MoRen;

@property(nonatomic,weak)id <YTGetGoodsAdddressDelegate> delegate;//代理对象

@end
