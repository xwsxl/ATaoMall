//
//  MerchantDetailCell.m
//  aTaohMall
//
//  Created by JMSHT on 2017/3/8.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "MerchantDetailCell.h"

#import "TimeModel.h"
#define HeightTools (kScreen_Height<=1334/2?kScreen_Height/2.3:kScreen_Height/2.5)
#define Height ([UIScreen mainScreen].bounds.size.height <= 568.00000 ? ([UIScreen mainScreen].bounds.size.height)/1.9:HeightTools)

@interface MerchantDetailCell ()


@property (nonatomic, weak)   id           m_data;
@property (nonatomic, weak)   NSIndexPath *m_tmpIndexPath;

@end

@implementation MerchantDetailCell

-(instancetype)initWithFrame:(CGRect)frame
{
    
    if (self= [super initWithFrame:frame]) {
        [self loadMyCell];
        
       [self defaultConfig];
    }
    return self;
}

-(void)loadMyCell
{
    
    self.GoodsImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ([UIScreen mainScreen].bounds.size.width-15)/2, 180)];
    
    self.GoodsImgView.image = [UIImage imageNamed:@"BGYT"];
    
    [self addSubview:self.GoodsImgView];
    
    self.GoodsTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 160, ([UIScreen mainScreen].bounds.size.width-15)/2, 20)];
    self.GoodsTimeLabel.text = @"倒计时抢购 20:28:07";
    self.GoodsTimeLabel.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.46];
    
    self.GoodsTimeLabel.textColor = [UIColor whiteColor];
    
    self.GoodsTimeLabel.textAlignment = NSTextAlignmentCenter;
    self.GoodsTimeLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:11];
    
    [self addSubview:self.GoodsTimeLabel];
    
    self.GoodsNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 190, ([UIScreen mainScreen].bounds.size.width-15)/2-20, 50)];
    self.GoodsNameLabel.text = @"打机边的的肯定vv女包扫除是的女女女但是vd";
    self.GoodsNameLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    
    self.GoodsNameLabel.numberOfLines=2;
    self.GoodsNameLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15];
    
    [self addSubview:self.GoodsNameLabel];
    
    
    self.GoodsPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 240, ([UIScreen mainScreen].bounds.size.width-15)/2-20, 20)];
    self.GoodsPriceLabel.text = @"￥259.00+10.00";
    self.GoodsPriceLabel.textColor = [UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
    self.GoodsPriceLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    
    [self addSubview:self.GoodsPriceLabel];
    
    
    self.GoodsNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 270, ([UIScreen mainScreen].bounds.size.width-15)/2-20, 20)];
    self.GoodsNumberLabel.text = @"200人付款";
    self.GoodsNumberLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    self.GoodsNumberLabel.textAlignment = NSTextAlignmentRight;
    self.GoodsNumberLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
    
    [self addSubview:self.GoodsNumberLabel];
    
    
    UIImageView *fenge = [[UIImageView alloc] initWithFrame:CGRectMake(0, Height-1, ([UIScreen mainScreen].bounds.size.width-15)/2, 1)];
    
    fenge.image = [UIImage imageNamed:@"分割线-拷贝"];
    
    [self addSubview:fenge];
    
}



- (void)defaultConfig {
    
    [self registerNSNotificationCenter];
    //    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.2];
    
}



- (void)loadData:(id)data indexPath:(NSIndexPath *)indexPath type:(NSString *)string{
    
    if ([data isMemberOfClass:[TimeModel class]]) {
        
        [self storeWeakValueWithData:data indexPath:indexPath];
        
        TimeModel *model = (TimeModel*)data;
        
        if ([string isEqualToString:@"1"]) {
            
            self.GoodsTimeLabel.text  = [NSString stringWithFormat:@"剩余抢购时间 %@",[model currentTimeString]];

            NSString *string  = [NSString stringWithFormat:@"%@",[model currentTimeString]];
            
            NSArray *b = [string componentsSeparatedByString:@":"];
            
            
//            NSLog(@"======%@===%@===%@",[b objectAtIndex:0],[b objectAtIndex:1],[b objectAtIndex:2]);
            
            if ([[b objectAtIndex:0] isEqualToString:@"00"] && [[b objectAtIndex:1] isEqualToString:@"00"] && [[b objectAtIndex:2] isEqualToString:@"00"]) {
                
                NSNotification *notification1 =[NSNotification notificationWithName:@"TimeStop666" object:nil userInfo:nil];
                //通过通知中心发送通知
                [[NSNotificationCenter defaultCenter] postNotification:notification1];
                
            }
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
        [self loadData:self.m_data indexPath:self.m_tmpIndexPath type:@""];
    }
}

@end
