//
//  NewQurtCell.m
//  aTaohMall
//
//  Created by JMSHT on 2016/12/27.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import "NewQurtCell.h"

@implementation NewQurtCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    
    
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self= [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self loadMyCell];
    }
    return self;
}

-(void)loadMyCell
{
    
    self.LogoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 40, 40)];
    
    self.LogoImageView.image = [UIImage imageNamed:@"QQ"];
    
    [self addSubview:self.LogoImageView];
    
    
    self.NameLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 10, 100, 20)];
    
    self.NameLabel.text=@"发咯发v";
    
    [self addSubview:self.NameLabel];
    
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
