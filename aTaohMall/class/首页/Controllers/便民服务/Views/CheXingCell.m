//
//  CheXingCell.m
//  aTaohMall
//
//  Created by JMSHT on 2017/5/12.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "CheXingCell.h"

@implementation CheXingCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


-(void)setArray:(NSArray *)array
{
    
    _array = array;
    
   // NSLog(@"====_array==%ld",(long)_array.count);
    
//    for (int i = 0; i < _array.count; i++) {
        
//        UILabel *OneLabel = [[UILabel alloc] initWithFrame:CGRectMake(15+(62+15)*i, 61, 62, 10)];
//        OneLabel.text = _array[i];
//        OneLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
//        OneLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:10];
//        [self addSubview:OneLabel];
        
        if (_array.count==1) {
            
            self.OneLabel.text = _array[0];
            self.TwoLabel.text = @"";
            self.ThreeLabel.text = @"";
            self.FourLabel.text = @"";
            
        }else if (_array.count == 2){
            
            self.OneLabel.text = _array[0];
            self.TwoLabel.text = _array[1];
            self.ThreeLabel.text = @"";
            self.FourLabel.text = @"";
            
        }else if (_array.count == 3){
            
            self.OneLabel.text = _array[0];
            self.TwoLabel.text = _array[1];
            self.ThreeLabel.text = _array[2];
            self.FourLabel.text = @"";
            
        }else if (_array.count == 4){
            
            self.OneLabel.text = _array[0];
            self.TwoLabel.text = _array[1];
            self.ThreeLabel.text = _array[2];
            self.FourLabel.text = _array[3];
            
        }else if (_array.count == 5){
            
            self.OneLabel.text = _array[0];
            self.TwoLabel.text = _array[1];
            self.ThreeLabel.text = _array[2];
            self.FourLabel.text = _array[3];
        }
    
    NSString *oneLabelString=[self.OneLabel.text componentsSeparatedByString:@":"].lastObject;
    NSString *twoLabelString=[self.TwoLabel.text componentsSeparatedByString:@":"].lastObject;
    NSString *threeLabelString=[self.ThreeLabel.text componentsSeparatedByString:@":"].lastObject;
    NSString *fourLabelString= [self.FourLabel.text componentsSeparatedByString:@":"].lastObject;
    if (([[oneLabelString stringByReplacingOccurrencesOfString:@"张" withString:@""] integerValue]>20)) {
        self.OneLabel.textColor=[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    }else
    {
        self.OneLabel.textColor=[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    }
    if (([[twoLabelString stringByReplacingOccurrencesOfString:@"张" withString:@""] integerValue]>20)) {
        self.TwoLabel.textColor=[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    }else
    {
        self.TwoLabel.textColor=[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    }
    if (([[threeLabelString stringByReplacingOccurrencesOfString:@"张" withString:@""] integerValue]>20)) {
        self.ThreeLabel.textColor=[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    }else
    {
        self.ThreeLabel.textColor=[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    }
    if (([[fourLabelString stringByReplacingOccurrencesOfString:@"张" withString:@""] integerValue]>20)) {
        self.FourLabel.textColor=[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    }else
    {
        self.FourLabel.textColor=[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    }
    
    
    
//    }
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
    
    self.StartTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 11, 100, 14)];
    self.StartTimeLabel.text = @"07:00";
    self.StartTimeLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    self.StartTimeLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:18];
    [self addSubview:self.StartTimeLabel];
    
    self.StartNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 36, 100, 13)];
    self.StartNameLabel.text = @"北京北";
    self.StartNameLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    self.StartNameLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    [self addSubview:self.StartNameLabel];
    
    self.TimeLabel = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.24+5, 11, [UIScreen mainScreen].bounds.size.width*0.267, 13)];
    self.TimeLabel.text = @"15时20分";
    self.TimeLabel.textAlignment = NSTextAlignmentCenter;
    self.TimeLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    self.TimeLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    [self addSubview:self.TimeLabel];
    
    self.CheCiLabel = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.24+5, 34, [UIScreen mainScreen].bounds.size.width*0.267, 11)];
    self.CheCiLabel.text = @"G321";
    self.CheCiLabel.textAlignment = NSTextAlignmentCenter;
    self.CheCiLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    self.CheCiLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    [self addSubview:self.CheCiLabel];
    
    self.Label1 = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.24, 22, 11, 11)];
    self.Label1.backgroundColor=[UIColor colorWithRed:221/255.0 green:221/255.0 blue:221/255.0 alpha:1.0];
    self.Label1.layer.cornerRadius=11/2;
    self.Label1.layer.masksToBounds=YES;
    [self addSubview:self.Label1];
    
    self.Label2 = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.24+9, 27, [UIScreen mainScreen].bounds.size.width*0.267, 2)];
    self.Label2.backgroundColor=[UIColor colorWithRed:221/255.0 green:221/255.0 blue:221/255.0 alpha:1.0];
    [self addSubview:self.Label2];
    
    self.Label3 = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.24+[UIScreen mainScreen].bounds.size.width*0.267, 22, 11, 11)];
    self.Label3.backgroundColor=[UIColor colorWithRed:221/255.0 green:221/255.0 blue:221/255.0 alpha:1.0];
    self.Label3.layer.cornerRadius=11/2;
    self.Label3.layer.masksToBounds=YES;
    [self addSubview:self.Label3];
    
    self.EndTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.60, 11, 100, 14)];
    self.EndTimeLabel.text = @"19:15";
    self.EndTimeLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    self.EndTimeLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:18];
    [self addSubview:self.EndTimeLabel];
    
    self.EndNameLabel = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.60, 36, 100, 13)];
    self.EndNameLabel.text = @"广州南";
    self.EndNameLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    self.EndNameLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    [self addSubview:self.EndNameLabel];
    
    self.PriceLabel = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-165, 31, 150, 16)];
    self.PriceLabel.text = @"￥201起";
    self.PriceLabel.textColor = [UIColor colorWithRed:251/255.0 green:88/255.0 blue:92/255.0 alpha:1.0];
    if ([UIScreen mainScreen].bounds.size.width >320) {
        
        self.PriceLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:18];
    }else{
        
        self.PriceLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15];
    }
    
    self.PriceLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:self.PriceLabel];
    
    if ([UIScreen mainScreen].bounds.size.width >320) {
        
        NSString *ShiFuPriceForColor = @"￥";
        NSString *ShiFuPriceForColor2 = @"起";
        // 创建对象.
        NSMutableAttributedString *mAttStri1 = [[NSMutableAttributedString alloc] initWithString:self.PriceLabel.text];
        //
        NSRange range1 = [self.PriceLabel.text rangeOfString:ShiFuPriceForColor];
        NSRange range2 = [self.PriceLabel.text rangeOfString:ShiFuPriceForColor2];
        
        [mAttStri1 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:20] range:range1];
        [mAttStri1 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:14] range:range2];
        [mAttStri1 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0] range:range2];
        self.PriceLabel.attributedText=mAttStri1;
        
        
    }else{
        
        NSString *ShiFuPriceForColor = @"￥";
        NSString *ShiFuPriceForColor2 = @"起";
        // 创建对象.
        NSMutableAttributedString *mAttStri1 = [[NSMutableAttributedString alloc] initWithString:self.PriceLabel.text];
        //
        NSRange range1 = [self.PriceLabel.text rangeOfString:ShiFuPriceForColor];
        NSRange range2 = [self.PriceLabel.text rangeOfString:ShiFuPriceForColor2];
        
        [mAttStri1 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:16] range:range1];
        [mAttStri1 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:12] range:range2];
        [mAttStri1 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0] range:range2];
        self.PriceLabel.attributedText=mAttStri1;
        
    }
    
    
    
    
    
    self.OneLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 61, 62, 10)];
    self.OneLabel.text = @"";
    self.OneLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    self.OneLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:10];
    [self addSubview:self.OneLabel];
    
    self.TwoLabel = [[UILabel alloc] initWithFrame:CGRectMake(96, 61, 62, 10)];
    self.TwoLabel.text = @"";
    self.TwoLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    self.TwoLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:10];
    [self addSubview:self.TwoLabel];
    
    self.ThreeLabel = [[UILabel alloc] initWithFrame:CGRectMake(177, 61, 62, 10)];
    self.ThreeLabel.text = @"";
    self.ThreeLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    self.ThreeLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:10];
    [self addSubview:self.ThreeLabel];
    
    self.FourLabel = [[UILabel alloc] initWithFrame:CGRectMake(246, 61, 62, 10)];
    self.FourLabel.text = @"";
    self.FourLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    self.FourLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:10];
    [self addSubview:self.FourLabel];
    
    
    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 79, [UIScreen mainScreen].bounds.size.width, 1)];
    line.image = [UIImage imageNamed:@"分割线-拷贝"];
    [self addSubview:line];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
