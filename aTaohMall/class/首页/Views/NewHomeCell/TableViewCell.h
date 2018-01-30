//
//  TableViewCell.h
//  aTaohMall
//
//  Created by JMSHT on 16/5/10.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *HomeLookMoreButton;//首页查看全部

@property (weak, nonatomic) IBOutlet UILabel *HomeTypeLabel;

@property (weak, nonatomic) IBOutlet UIImageView *HomeTypeImageView;

@end
