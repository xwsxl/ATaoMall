//
//  MessageListCell.h
//  aTaohMall
//
//  Created by DingDing on 2017/9/30.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJUnFoldView.h"

@interface MessageListCell : UITableViewCell

@property (nonatomic,strong)UIImageView *IsReadView;

@property (nonatomic,strong)UILabel *MsgTitleLabel;

@property (nonatomic,strong)UIImageView *LineView;

@property (nonatomic,strong)ZJUnFoldView *ContentView;

@property (nonatomic,strong)UILabel *contentLab;

@property (nonatomic,strong)UIView *BGView;

@property (nonatomic,strong)UILabel *TimeLable;

@property (nonatomic,assign)BOOL MsgIsRead;

@property (nonatomic) NSInteger height;
@end
