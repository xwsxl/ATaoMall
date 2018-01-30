//
//  NowGoingCell.m
//  aTaohMall
//
//  Created by JMSHT on 16/5/14.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import "NowGoingCell.h"


#import "GGClockView.h"

#import "TimeModel.h"

@interface NowGoingCell ()

@property (nonatomic, weak) GGClockView *clockView;
@property (nonatomic, weak)   id           m_data;
@property (nonatomic, weak)   NSIndexPath *m_tmpIndexPath;

@end

@implementation NowGoingCell


- (void)awakeFromNib {
    // Initialization code
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

//后执行
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self defaultConfig];
        
    }
    
    return self;
}

- (void)defaultConfig {
    
    [self registerNSNotificationCenter];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.2];
    
}


- (void)loadData:(id)data indexPath:(NSIndexPath *)indexPath {
    
    if ([data isMemberOfClass:[TimeModel class]]) {
        
        [self storeWeakValueWithData:data indexPath:indexPath];
        
        TimeModel *model = (TimeModel*)data;
        _TimeLabel.text  = [NSString stringWithFormat:@"%@ 后开始",[model currentTimeString]];
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
        [self loadData:self.m_data indexPath:self.m_tmpIndexPath];
    }
}

//后执行
//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
//    
//    // Configure the view for the selected state
//    
//    // Initialization code
//    
//    //日期转换为时间戳 (日期转换为秒数)
//    
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.0"];
//    
//    //当前时间
//        NSDate *date3 = [NSDate dateWithTimeIntervalSinceNow:0];
//    
//    //    NSDate *date1 = [dateFormatter dateFromString:@"2016-02-02 16:00:00.0"];
//    NSDate *date2 = [dateFormatter dateFromString:self.endString];
//    
////    NSDate *date3 = [dateFormatter dateFromString:self.startString];
//    
//    
//    NSLog(@">>>>>>>>>%@",self.endString);
//    NSLog(@">>>>>>>>>%@",self.startString);
//    
//    NSDate *num1 = [self getNowDateFromatAnDate:date3];
//    
//    NSDate *num2=[self getNowDateFromatAnDate:date2];
//    
//    NSLog(@"=========当前日期为:%@",num1);
//    NSLog(@"=========结束日期为:%@",num2);
//    
//    NSTimeInterval hh1= [num1 timeIntervalSince1970];
//    
//    NSTimeInterval hh2 = [num2 timeIntervalSince1970];
//    NSInteger times=(NSInteger)(hh2 - hh1);
//    
//    NSLog(@"--------->%ld",times);
//    
//    GGClockView *clockView = [[GGClockView alloc] init];
//    clockView.frame = self.TimeLabel.frame;
//    
//    clockView.time = times;
//    [self addSubview:clockView];
//    self.clockView = clockView;
//    
//}
@end
