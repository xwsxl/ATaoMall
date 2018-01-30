//
//  NearShopCell.h
//  aTaohMall
//
//  Created by JMSHT on 16/5/12.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NearShopCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *nearImageView;//商户图片

@property (weak, nonatomic) IBOutlet UILabel *shopNameLabel;//商户名

@property (weak, nonatomic) IBOutlet UILabel *shopNoteLabel;//商户介绍

@property (weak, nonatomic) IBOutlet UILabel *distenceLabel;//距离
@end
