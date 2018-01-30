//
//  SelectPayCardCell.h
//  aTaohMall
//
//  Created by JMSHT on 16/5/16.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyPayCardFooter.h"

@interface SelectPayCardCell : UITableViewCell<UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *BackgoundImageView;//银行背景图

@property (weak, nonatomic) IBOutlet UIImageView *BankImageView;//银行图标

@property (weak, nonatomic) IBOutlet UILabel *BankNameLabel;//银行名字

@property (weak, nonatomic) IBOutlet UILabel *BankTypeLabel;//银行类型

@property (weak, nonatomic) IBOutlet UILabel *BankNumberLabel;

@property (weak, nonatomic) IBOutlet UIButton *BankDeleteButton;

@property(nonatomic,strong) NSMutableArray *ArrM;

@property(nonatomic,assign) NSInteger indexPath;

@property(nonatomic,strong) UITableView * tableview;

@property(nonatomic,strong) NSMutableArray * datas;

@property(nonatomic,strong) MyPayCardFooter *footer;

-(void)deleteWayWithCell:(NSInteger)index;

-(void)LongPressGestureRecognizer:(UIGestureRecognizer *)gr event:(id)event;

@end
