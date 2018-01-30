//
//  GotoShopLimitCell.m
//  aTaohMall
//
//  Created by JMSHT on 16/7/20.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import "GotoShopLimitCell.h"
#import "TimeModel.h"


#define YTScreen ([UIScreen mainScreen].bounds.size.width-35)/2

@interface GotoShopLimitCell ()


@property (nonatomic, weak)   id           m_data;
@property (nonatomic, weak)   NSIndexPath *m_tmpIndexPath;

@end

@implementation GotoShopLimitCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
    
    
}


//- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
//    
//    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//        
//        [self defaultConfig];
//        
//    }
//    
//    return self;
//}

-(instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        [self defaultConfig];
    }

    return self;
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
            
            
            self.YTTimeLabel.text  = [NSString stringWithFormat:@"剩余抢购时间 %@",[model currentTimeString]];
            
            _TimeLabel.text  = [NSString stringWithFormat:@"%@ 后开始",[model currentTimeString]];
            
            NSString *string  = [NSString stringWithFormat:@"%@",[model currentTimeString]];
            
            NSArray *b = [string componentsSeparatedByString:@":"];
            
            self.hourLabel.text=[b objectAtIndex:0];
            self.minLabel.text=[b objectAtIndex:1];
            self.secLabel.text=[b objectAtIndex:2];
            
            self.hourLabel.layer.cornerRadius  = 2;
            self.hourLabel.layer.masksToBounds = YES;
            
            self.minLabel.layer.cornerRadius  = 2;
            self.minLabel.layer.masksToBounds = YES;
            
            self.secLabel.layer.cornerRadius  = 2;
            self.secLabel.layer.masksToBounds = YES;
            
            
            
            NSLog(@"======%@===%@===%@",[b objectAtIndex:0],[b objectAtIndex:1],[b objectAtIndex:2]);
            
            if ([[b objectAtIndex:0] isEqualToString:@"00"] && [[b objectAtIndex:1] isEqualToString:@"00"] && [[b objectAtIndex:2] isEqualToString:@"00"]) {
                
                
                NSNotification *notification =[NSNotification notificationWithName:@"TimeStop3" object:nil userInfo:nil];
                //通过通知中心发送通知
                [[NSNotificationCenter defaultCenter] postNotification:notification];
                
            }
            
            
            
        }
        
//        else{
//            
//            self.YTTimeLabel.text  = [NSString stringWithFormat:@"倒计时抢购 %@",[model currentTimeString]];
//            
//            NSString *string  = [NSString stringWithFormat:@"%@",[model currentTimeString]];
//            
//            NSArray *b = [string componentsSeparatedByString:@":"];
//            
//            self.hourLabel.text=[b objectAtIndex:0];
//            self.minLabel.text=[b objectAtIndex:1];
//            self.secLabel.text=[b objectAtIndex:2];
//            
//            self.hourLabel.layer.cornerRadius  = 2;
//            self.hourLabel.layer.masksToBounds = YES;
//            
//            self.minLabel.layer.cornerRadius  = 2;
//            self.minLabel.layer.masksToBounds = YES;
//            
//            self.secLabel.layer.cornerRadius  = 2;
//            self.secLabel.layer.masksToBounds = YES;
//            
//            
//            if ([[b objectAtIndex:0] isEqualToString:@"00"] && [[b objectAtIndex:1] isEqualToString:@"00"] && [[b objectAtIndex:2] isEqualToString:@"00"]) {
//                
//                
//                NSNotification *notification =[NSNotification notificationWithName:@"TimeStop3" object:nil userInfo:nil];
//                //通过通知中心发送通知
//                [[NSNotificationCenter defaultCenter] postNotification:notification];
//                
//            }
//            
//            
//        }

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
