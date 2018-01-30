//
//  MessageListCell.m
//  aTaohMall
//
//  Created by DingDing on 2017/9/30.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "MessageListCell.h"

@implementation MessageListCell

- (void)awakeFromNib {
    [super awakeFromNib];
   
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self= [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self loadMyCell];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        self.frame=frame;
        [self loadMyCell];
    }
    return self;
}



-(void)loadMyCell
{
    
    self.layer.backgroundColor=[UIColor clearColor].CGColor;
    
    self.backgroundColor=[UIColor clearColor];
    self.BGView=[[UIView alloc]initWithFrame:CGRectMake(10, 0, kScreen_Width-20, self.frame.size.height)];
    _BGView.layer.cornerRadius=5;
    _BGView.layer.backgroundColor=[UIColor whiteColor].CGColor;
    
    
    [self addSubview:_BGView];
    self.IsReadView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 18, 5, 5)];
    _IsReadView.image=KImage(@"icon_yuan-msg");
    [_BGView addSubview:self.IsReadView];
    
    self.MsgTitleLabel=[[UILabel alloc]initWithFrame:CGRectMake(19, 13, kScreen_Width-40, 14)];
    _MsgTitleLabel.font=KNSFONT(14);
    [_BGView addSubview:self.MsgTitleLabel];
    
    self.LineView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 40, kScreen_Width, 1)];
    _LineView.image=KImage(@"分割线-拷贝");
    [_BGView addSubview:self.LineView];
    
    
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
}

-(void)setMsgIsRead:(BOOL)MsgIsRead
{
    _MsgIsRead=MsgIsRead;
    if (MsgIsRead==YES) {
        self.IsReadView.hidden=YES;
        self.MsgTitleLabel.frame=CGRectMake(10, 13, kScreen_Width-30, 14);
    }else
    {
        self.IsReadView.hidden=NO;
        self.MsgTitleLabel.frame=CGRectMake(19, 13, kScreen_Width-40, 14);
    }
}

-(void)setHeight:(NSInteger)height
{
    _height=height;
    _BGView.frame=CGRectMake(10, 0, kScreen_Width-20, height);
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
