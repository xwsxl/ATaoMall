//
//  ClassifyLeftCell.h
//  aTaohMall
//
//  Created by JMSHT on 16/6/1.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClassifyLeftCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *LeftNameLabel;//左边分类


-(void)configCellWithTitle:(NSString *)str andIndexPath:(NSIndexPath *)indexPath andSelectIndexPath:(NSIndexPath *)selectIndexPath;


@end
