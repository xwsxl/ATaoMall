//
//  YTAddressCell.h
//  aTaohMall
//
//  Created by JMSHT on 2016/10/12.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YTAddressCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *YTNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *YTPhoneLabel;

@property (weak, nonatomic) IBOutlet UILabel *YTAddressLabel;

@property (weak, nonatomic) IBOutlet UIImageView *YTMoRenImageView;

@property (weak, nonatomic) IBOutlet UIButton *YTMoRenButton;

@property (weak, nonatomic) IBOutlet UIButton *YTBianJiButton;

@property (weak, nonatomic) IBOutlet UIButton *YTDeleteButton;

@end
