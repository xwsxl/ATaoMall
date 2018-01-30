//
//  AirPlaneHBCell.m
//  aTaohMall
//
//  Created by JMSHT on 2017/5/19.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "AirPlaneHBCell.h"

#import "Masonry.h"
@implementation AirPlaneHBCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self initUI];
        
    }
    return self;
    
}

-(void)initUI
{
    self.StartTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 20, 100, 14)];
    self.StartTimeLabel.text = @"23:45";
    self.StartTimeLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    self.StartTimeLabel.textAlignment = NSTextAlignmentLeft;
    self.StartTimeLabel.font  =[UIFont fontWithName:@"PingFang-SC-Medium" size:18];
    [self addSubview:self.StartTimeLabel];
    
    self.StartCityLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 41, 150, 10)];
    self.StartCityLabel.text = @"宝安T3";
    self.StartCityLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    self.StartCityLabel.textAlignment = NSTextAlignmentLeft;
    self.StartCityLabel.font  =[UIFont fontWithName:@"PingFang-SC-Regular" size:10];
    [self addSubview:self.StartCityLabel];
    
    self.TypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 58, [UIScreen mainScreen].bounds.size.width-30, 11)];
    self.TypeLabel.text = @"春秋9C8613(廉航)|空客A320(中)";
    self.TypeLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    self.TypeLabel.textAlignment = NSTextAlignmentLeft;
    self.TypeLabel.font  =[UIFont fontWithName:@"PingFang-SC-Regular" size:10];
    [self addSubview:self.TypeLabel];
    
    self.LongLabel = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.2667, 17, 101, 13)];
    self.LongLabel.text = @"2时10分";
    self.LongLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    self.LongLabel.textAlignment = NSTextAlignmentCenter;
    self.LongLabel.font  =[UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    [self addSubview:self.LongLabel];
    
    self.GoToImgView = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.2667, 26, 101, 8)];
    self.GoToImgView.image = [UIImage imageNamed:@"icon_arrow"];
    [self addSubview:self.GoToImgView];
    
    self.StopOverLab=[[UILabel alloc]initWithFrame:CGRectMake(kScreen_Width*0.2667, 38, 101, 11)];
    self.StopOverLab.font=KNSFONTM(11);
    self.StopOverLab.textColor=RGB(63, 139, 253);
    self.StopOverLab.text=@"经停";
    self.StopOverLab.hidden=YES;
    self.StopOverLab.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.StopOverLab];
    self.EndTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.618, 20, 100, 14)];
    self.EndTimeLabel.text = @"01:55";
//    self.EndTimeLabel.backgroundColor=[UIColor orangeColor];
    self.EndTimeLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
//    self.EndTimeLabel.textAlignment = NSTextAlignmentRight;
    self.EndTimeLabel.font  =[UIFont fontWithName:@"PingFang-SC-Medium" size:18];
    [self addSubview:self.EndTimeLabel];
    
    self.EndCityLabel = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.618-50, 41, 100, 10)];
    self.EndCityLabel.text = @"江北T2";
    self.EndCityLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    self.EndCityLabel.textAlignment = NSTextAlignmentCenter;
    self.EndCityLabel.font  =[UIFont fontWithName:@"PingFang-SC-Regular" size:10];
    [self addSubview:self.EndCityLabel];
    
    if ([UIScreen mainScreen].bounds.size.width <= 320) {
        
        self.PriceLabel = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-200-10, 20, 200, 15)];
        
    }else{
        
        self.PriceLabel = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-200-[UIScreen mainScreen].bounds.size.width*0.0773, 20, 200, 15)];
        
    }
    
    self.PriceLabel.text = @"￥600";
    self.PriceLabel.textColor = [UIColor colorWithRed:251/255.0 green:88/255.0 blue:92/255.0 alpha:1.0];
    self.PriceLabel.textAlignment = NSTextAlignmentRight;
    self.PriceLabel.font  =[UIFont fontWithName:@"PingFang-SC-Medium" size:18];
    [self addSubview:self.PriceLabel];
    
//    NSString *stringForColor = @"￥";
//    
//    // 创建对象.
//    NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:self.PriceLabel.text];
//    NSRange range = [self.PriceLabel.text rangeOfString:stringForColor];
//    [mAttStri addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Medium" size:20] range:range];
//    self.PriceLabel.attributedText=mAttStri;
    
    UIView *redView = [[UIView alloc] init];
    
    if ([UIScreen mainScreen].bounds.size.width <= 320) {
        
        redView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-20-31, 42, 31, 18);
        
    }else{
        
        redView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-40-31, 42, 31, 18);
        
        
    }
    
    [self addSubview:redView];
    
    self.RedImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 31, 18)];
    self.RedImgView.image = [UIImage imageNamed:@"square"];
    [redView addSubview:self.RedImgView];
    
    self.TicketLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 31, 18)];
    self.TicketLabel.text = @"";
    self.TicketLabel.textColor = [UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
    self.TicketLabel.textAlignment = NSTextAlignmentCenter;
    self.TicketLabel.font  =[UIFont fontWithName:@"PingFang-SC-Regular" size:10];
    [redView addSubview:self.TicketLabel];
    
    
    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 77, [UIScreen mainScreen].bounds.size.width, 1)];
    line.image = [UIImage imageNamed:@"分割线-拷贝"];
    [self addSubview:line];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
