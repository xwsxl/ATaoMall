//
//  ClassifyLeftCell.m
//  aTaohMall
//
//  Created by JMSHT on 16/6/1.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import "ClassifyLeftCell.h"

@implementation ClassifyLeftCell

- (void)awakeFromNib {
    // Initialization code
}


-(void)configCellWithTitle:(NSString *)str andIndexPath:(NSIndexPath *)indexPath andSelectIndexPath:(NSIndexPath *)selectIndexPath{
    
    
    if (indexPath.section == selectIndexPath.section && indexPath.row == selectIndexPath.row){
        
        
        self.LeftNameLabel.textColor = [UIColor redColor];
    }else {
        
        self.LeftNameLabel.textColor = [UIColor blackColor];
    }
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    
    
}

@end
