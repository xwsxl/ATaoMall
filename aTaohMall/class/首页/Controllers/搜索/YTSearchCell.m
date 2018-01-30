//
//  YTSearchCell.m
//  aTaohMall
//
//  Created by JMSHT on 2016/11/17.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import "YTSearchCell.h"

#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "TimeModel.h"
#define YTScreen ((kScreenHeight==812.0)?667:kScreenHeight)/3.5

#define YTScreen1 [UIScreen mainScreen].bounds.size.width/2.5+12

#define YTScreen2 [UIScreen mainScreen].bounds.size.width/2.5+30


@interface YTSearchCell ()

@end

@implementation YTSearchCell

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
  
    UIImageView *fenge1=[[UIImageView alloc] initWithFrame:CGRectMake(9, 9, 1, YTScreen-18)];
    fenge1.image=[UIImage imageNamed:@"分割线YT"];
    [self addSubview:fenge1];
    
    
    UIImageView *fenge2=[[UIImageView alloc] initWithFrame:CGRectMake(9, 9, [UIScreen mainScreen].bounds.size.width/2.5+2, 1)];
    fenge2.image=[UIImage imageNamed:@"分割线-拷贝"];
    [self addSubview:fenge2];
    
    UIImageView *fenge3=[[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2.5+10, 9, 1, YTScreen-18)];
    fenge3.image=[UIImage imageNamed:@"分割线YT"];
    [self addSubview:fenge3];
    
    UIImageView *fenge4=[[UIImageView alloc] initWithFrame:CGRectMake(9, YTScreen-10, [UIScreen mainScreen].bounds.size.width/2.5+2, 1)];
    fenge4.image=[UIImage imageNamed:@"分割线-拷贝"];
    [self addSubview:fenge4];
    
    self.GoodsImageView=[[UIImageView alloc] initWithFrame:CGRectMake(10, 10, [UIScreen mainScreen].bounds.size.width/2.5, YTScreen-20)];
    [self addSubview:self.GoodsImageView];
    
    
    self.GoodsNameLabel=[[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2.5+30, 20, [UIScreen mainScreen].bounds.size.width/2-20, 45)];
    self.GoodsNameLabel.textColor=[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    self.GoodsNameLabel.font=[UIFont fontWithName:@"PingFangSC-Regular" size:14];
    self.GoodsNameLabel.numberOfLines=2;
    [self addSubview:self.GoodsNameLabel];
    
    self.StorenameLabel=[[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2.5+30, 65, [UIScreen mainScreen].bounds.size.width/2-20, 20)];
    self.StorenameLabel.textColor=[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    self.StorenameLabel.font=[UIFont fontWithName:@"PingFangSC-Regular" size:12];
//    self.StorenameLabel.text = @"林家集团";
    [self addSubview:self.StorenameLabel];
    
    
    self.GoodsPriceLabel=[[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2.5+30, 95, [UIScreen mainScreen].bounds.size.width/2-20, 20)];
    self.GoodsPriceLabel.textColor=[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
    self.GoodsPriceLabel.font=[UIFont fontWithName:@"PingFangSC-Regular" size:14];
//    self.GoodsPriceLabel.numberOfLines=2;
    [self addSubview:self.GoodsPriceLabel];
    
    
    self.GoodsAmountLabel=[[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2.5+30, 115, [UIScreen mainScreen].bounds.size.width/2-20, 17)];
    self.GoodsAmountLabel.textColor=[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    self.GoodsAmountLabel.font=[UIFont fontWithName:@"PingFangSC-Regular" size:12];
    [self addSubview:self.GoodsAmountLabel];
    
    
    self.YTView=[[UIView alloc] initWithFrame:CGRectMake(YTScreen2, 137, [UIScreen mainScreen].bounds.size.width/2-20, 15)];
    
    [self addSubview:self.YTView];
    
    
    self.TimeTitleLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 70, 15)];
    self.TimeTitleLabel.textColor=[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    self.TimeTitleLabel.text=@"倒计时抢购:";
    self.TimeTitleLabel.font=[UIFont fontWithName:@"PingFangSC-Semibold" size:12];
    [self.YTView addSubview:self.TimeTitleLabel];
    
    self.HourLabel=[[UILabel alloc] initWithFrame:CGRectMake(70, 0, 15, 15)];
    self.HourLabel.textColor=[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    self.HourLabel.text=@"20";
    self.HourLabel.textAlignment=NSTextAlignmentCenter;
    self.HourLabel.backgroundColor=[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
    self.HourLabel.font=[UIFont fontWithName:@"PingFangSC-Regular" size:10];
    [self.YTView addSubview:self.HourLabel];
    
    UILabel *line1=[[UILabel alloc] initWithFrame:CGRectMake(85, 0, 10, 15)];
    line1.textColor=[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
    line1.text=@":";
    line1.textAlignment=NSTextAlignmentCenter;
    line1.font=[UIFont fontWithName:@"PingFangSC-Regular" size:10];
    [self.YTView addSubview:line1];
    
    self.MinLabel=[[UILabel alloc] initWithFrame:CGRectMake(95, 0, 15, 15)];
    self.MinLabel.textColor=[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    self.MinLabel.text=@"28";
    self.MinLabel.textAlignment=NSTextAlignmentCenter;
    self.MinLabel.backgroundColor=[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
    self.MinLabel.font=[UIFont fontWithName:@"PingFangSC-Regular" size:10];
    [self.YTView addSubview:self.MinLabel];
    
    UILabel *line2=[[UILabel alloc] initWithFrame:CGRectMake(110, 0, 10, 15)];
    line2.textColor=[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
    line2.text=@":";
    line2.textAlignment=NSTextAlignmentCenter;
    line2.font=[UIFont fontWithName:@"PingFangSC-Regular" size:10];
    [self.YTView addSubview:line2];
    
    self.SecLabel=[[UILabel alloc] initWithFrame:CGRectMake(120, 0, 15, 15)];
    self.SecLabel.textColor=[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    self.SecLabel.text=@"07";
    self.SecLabel.textAlignment=NSTextAlignmentCenter;
    self.SecLabel.backgroundColor=[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
    self.SecLabel.font=[UIFont fontWithName:@"PingFangSC-Regular" size:10];
    [self.YTView addSubview:self.SecLabel];
    
    UIImageView *line3=[[UIImageView alloc] initWithFrame:CGRectMake(YTScreen1, YTScreen-1, [UIScreen mainScreen].bounds.size.width-YTScreen1, 1)];
    
    line3.image=[UIImage imageNamed:@"分割线-拷贝"];
    
    [self addSubview:line3];
    
    
}

-(void)setModel:(SearchResultModel *)model
{
    _model=model;
    
    //赋值
    
    NSNull *null=[[NSNull alloc] init];
    
    if (![_model.scopeimg isEqual:null]) {
        //                [cell.goodsImageView sd_setImageWithURL:[NSURL URLWithString:model.scopeimg]];
        
        [self.GoodsImageView sd_setImageWithURL:[NSURL URLWithString:_model.scopeimg] placeholderImage:[UIImage imageNamed:@"default_image"] options:SDWebImageProgressiveDownload];
        
//        [self.GoodsImageView setContentMode:UIViewContentModeScaleAspectFill];
        
        
    }
    self.GoodsNameLabel.text=_model.name;
    
    self.StorenameLabel.text = _model.storename;
    
    if ([_model.pay_integer isEqualToString:@""] || [_model.pay_integer isEqualToString:@"0"] || [_model.pay_integer isEqualToString:@"0.00"]) {
        
        self.GoodsPriceLabel.text=[NSString stringWithFormat:@"￥%.02f",[_model.pay_maney floatValue]];
        
    }else if ([_model.pay_maney isEqualToString:@""] || [_model.pay_maney isEqualToString:@"0"] || [_model.pay_maney isEqualToString:@"0.00"]){
        
        self.GoodsPriceLabel.text=[NSString stringWithFormat:@"%.02f积分",[_model.pay_integer floatValue]];
        
    }else{
        
        
//        if ([_model.integral_type isEqualToString:@"1"]) {
//            
//            self.GoodsPriceLabel.text=[NSString stringWithFormat:@"%.02f积分+￥%.02f",[_model.pay_integer floatValue],[_model.pay_maney floatValue]];
//            
//        }else{
//            
//            self.GoodsPriceLabel.text=[NSString stringWithFormat:@"￥%.02f+%.02f积分",[_model.pay_maney floatValue],[_model.pay_integer floatValue]];
//            
//        }
        
        self.GoodsPriceLabel.text=[NSString stringWithFormat:@"￥%.02f+%.02f积分",[_model.pay_maney floatValue],[_model.pay_integer floatValue]];
        
    }
    
    self.GoodsAmountLabel.text=[NSString stringWithFormat:@"%@人付款",_model.amount];
    
    
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.0"];
//    NSDate *end=[dateFormatter dateFromString:cell.startString];
//    NSDate *timedata = [NSDate date];
//    
//    NSTimeInterval _end=[end timeIntervalSince1970];
//    
//    NSTimeInterval _start=[timedata timeIntervalSince1970];
//    
//    NSInteger time=(NSInteger)(_end - _start);
//    
//    TimeModel *model2 = [[TimeModel alloc]init];
//    model2.m_countNum = (int)time;
//    [cell loadData:model2 indexPath:indexPath];
//    
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    
    
    
}

- (void)loadData:(id)data indexPath:(NSIndexPath *)indexPath andString:(NSString *)string andStatus:(NSString *)status{
    
    if ([data isMemberOfClass:[TimeModel class]]) {
        
        [self storeWeakValueWithData:data indexPath:indexPath];
        
        TimeModel *model = (TimeModel*)data;
        
//        if ([string isEqualToString:@"1"]) {
            
            
//            NSLog(@"==%@",[NSString stringWithFormat:@"%@ 后开始",[model currentTimeString]]);
            
            NSString *string  = [NSString stringWithFormat:@"%@",[model currentTimeString]];
            
            NSArray *b = [string componentsSeparatedByString:@":"];
            
            self.HourLabel.text=[b objectAtIndex:0];
            self.MinLabel.text=[b objectAtIndex:1];
            self.SecLabel.text=[b objectAtIndex:2];
            
            self.HourLabel.layer.cornerRadius  = 2;
            self.HourLabel.layer.masksToBounds = YES;
            
            self.MinLabel.layer.cornerRadius  = 2;
            self.MinLabel.layer.masksToBounds = YES;
            
            self.SecLabel.layer.cornerRadius  = 2;
            self.SecLabel.layer.masksToBounds = YES;
        
        
        if ([self.HourLabel.text isEqualToString:@"00"] && [self.MinLabel.text isEqualToString:@"00"] && [self.SecLabel.text isEqualToString:@"00"]) {
            
            
//            NSNotification *notification =[NSNotification notificationWithName:@"TimeStop1" object:nil userInfo:nil];
//            //通过通知中心发送通知
//            [[NSNotificationCenter defaultCenter] postNotification:notification];
            
        }

    }
    
}

- (void)storeWeakValueWithData:(id)data indexPath:(NSIndexPath *)indexPath {
    
    self.m_data         = data;
    self.m_tmpIndexPath = indexPath;
}

- (void)dealloc {
    
    [self removeNSNotificationCenter];
}

#pragma mark - 通知中心
- (void)registerNSNotificationCenter {
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(notificationCenterEvent:)
                                                 name:NOTIFICATION_TIME_CELL
                                               object:nil];
}

- (void)removeNSNotificationCenter {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NOTIFICATION_TIME_CELL object:nil];
}

- (void)notificationCenterEvent:(id)sender {
    
    if (self.m_isDisplayed) {
        [self loadData:self.m_data indexPath:self.m_tmpIndexPath andString:@"" andStatus:@""];
    }
}


@end
