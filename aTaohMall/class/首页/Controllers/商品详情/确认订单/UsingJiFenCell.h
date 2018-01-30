//
//  UsingJiFenCell.h
//  aTaohMall
//
//  Created by JMSHT on 16/5/18.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UsingJiFenCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *JiFenDuiXianLabel;//显示账号有多少积分

@property (weak, nonatomic) IBOutlet UISwitch *UseJiFenSwitch;//滑块开关

@property (weak, nonatomic) IBOutlet UILabel *ZongJiFenLabel;//总积分


@property (weak, nonatomic) IBOutlet UITextField *UseJiFenTF;//使用积分
@end
