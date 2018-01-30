//
//  LimitTimeCell.m
//  aTaohMall
//
//  Created by 阳涛 on 16/5/14.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import "LimitTimeCell.h"

#import "TimeModel.h"

@interface LimitTimeCell ()


@property (nonatomic, weak)   id           m_data;
@property (nonatomic, weak)   NSIndexPath *m_tmpIndexPath;

@end

@implementation LimitTimeCell



- (void)awakeFromNib {
}

- (NSDate *)getNowDateFromatAnDate:(NSDate *)anyDate
{
    //设置源日期时区
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];//或GMT
    //设置转换后的目标日期时区
    NSTimeZone* destinationTimeZone = [NSTimeZone localTimeZone];
    //得到源日期与世界标准时间的偏移量
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:anyDate];
    //目标日期与本地时区的偏移量
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:anyDate];
    //得到时间偏移量的差值
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    //转为现在时间
    NSDate* destinationDateNow = [[NSDate alloc] initWithTimeInterval:interval sinceDate:anyDate];
    
    return destinationDateNow;
}
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
            
            _TimeLabel.text  = [NSString stringWithFormat:@"%@ 后开始",[model currentTimeString]];
            
            NSArray *b = [_TimeLabel.text componentsSeparatedByString:@":"];
            
            NSLog(@"==%@==%@==%@",[b objectAtIndex:0],[b objectAtIndex:1],[b objectAtIndex:2]);
//            NSString *stringForColor = @"后开始";
//            
//            // 创建对象.
//            NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:_TimeLabel.text];
//            //
//            NSRange range = [_TimeLabel.text rangeOfString:stringForColor];
//            
//            [mAttStri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10] range:range];
//            
//            _TimeLabel.attributedText=mAttStri;
            
            
        }else{
            
            _TimeLabel.text  = [NSString stringWithFormat:@"%@ 后结束",[model currentTimeString]];
            
            
//            NSLog(@"======%@",_TimeLabel.text);
            
            
            NSArray *b = [_TimeLabel.text componentsSeparatedByString:@":"];
            
            NSLog(@"==%@==%@==%@",[b objectAtIndex:0],[b objectAtIndex:1],[b objectAtIndex:2]);
            
//            NSString *stringForColor = @"后停止";
//            
//            // 创建对象.
//            NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:_TimeLabel.text];
//            //
//            NSRange range = [_TimeLabel.text rangeOfString:stringForColor];
//            
//            [mAttStri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:range];
//            
//            _TimeLabel.attributedText=mAttStri;
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
