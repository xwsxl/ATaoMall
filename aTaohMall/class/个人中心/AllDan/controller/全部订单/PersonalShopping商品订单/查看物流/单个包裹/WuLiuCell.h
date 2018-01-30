//
//  WuLiuCell.h
//  aTaohMall
//
//  Created by JMSHT on 2017/4/17.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WuLiuCell : UITableViewCell

@property (nonatomic, strong) UIImageView *Big;

@property (nonatomic, strong) UIImageView *Small;

@property (nonatomic, strong) UIImageView *line;//店铺图片

@property (nonatomic, strong) UIImageView *line2;//店铺图片

@property (nonatomic, strong) UIImageView *line1;

@property (nonatomic, strong) UILabel *Name;//选中图片

@property (nonatomic, strong) UILabel *Time;//头部勾选

@property(nonatomic,copy) NSString *NameString;

@end
