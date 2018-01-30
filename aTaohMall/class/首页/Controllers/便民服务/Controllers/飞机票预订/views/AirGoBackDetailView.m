//
//  AirGoBackDetailView.m
//  aTaohMall
//
//  Created by JMSHT on 2017/5/23.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "AirGoBackDetailView.h"

#import "AFNetworking.h"

#import "ConverUtil.h"
#import "DESUtil.h"
#import "SecretCodeTool.h"
#import "AirSelectView.h"

#import "WKProgressHUD.h"

#import "JRToast.h"
#define UIBounds [[UIScreen mainScreen] bounds] //window外框大小
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:a]

@interface AirGoBackDetailView()
{
    UILabel *Companylabel;
    UILabel *StartTime;
    UILabel *StartName;
    UILabel *EndTime;
    UILabel *EndName;
    UILabel *longLabel;
    UIImageView *GOGO;
    UILabel *Datelabel;
    UILabel *StopOverLab;
    
    
    UILabel *Companylabel1;
    UILabel *StartTime1;
    UILabel *StartName1;
    UILabel *EndTime1;
    UILabel *EndName1;
    UILabel *longLabel1;
    UIImageView *GOGO1;
    UILabel *Datelabel1;
    UILabel *StopOverLab1;
}
@end

@implementation AirGoBackDetailView

-(void)Time:(NSString *)gotime Flight:(NSString *)goflightNo Back:(NSString *)backtime backFlight:(NSString *)backFlight
{
    
    _gotime = gotime;
    _goflightNo = goflightNo;
    _backtime = backtime;
    _backFlight = backFlight;
    
    [self getPriceChange];
    
}

//判断票价改变
-(void)getPriceChange
{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@getFlightInformation_mob.shtml",URL_Str];
    //saveUserExchange_mob.shtml
    
    NSDictionary *dict = @{@"go_time":_gotime,@"go_plane_number":_goflightNo,@"return_time":_backtime,@"return_plane_number":_backFlight};
 //   WKProgressHUD *hud=[WKProgressHUD showInView:self animated:YES];
    [manager POST:url parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
        NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];
        
        
        if (codeKey && content) {
            NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
            
            NSLog(@"xmlStr=航班信息=%@",xmlStr);
            
            
            NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
                        NSLog(@"往返票=%@",dic);
            
            
            
            if ([dic[@"status"] isEqualToString:@"10000"]) {
                
                
                GOGO.image = [UIImage imageNamed:@"icon_arrow"];
                GOGO1.image = [UIImage imageNamed:@"icon_arrow"];
                
                NSLog(@"====%@",dic[@"go_base"]);
                NSLog(@"====%@",dic[@"return_base"]);
                Companylabel.text = [NSString stringWithFormat:@"%@%@",dic[@"go_base"][@"CarrinerName"],dic[@"go_base"][@"FlightNo"]];
                Companylabel1.text = [NSString stringWithFormat:@"%@%@",dic[@"return_base"][@"CarrinerName"],dic[@"return_base"][@"FlightNo"]];
                
                self.Air_OffTime = [NSString stringWithFormat:@"%@",dic[@"go_base"][@"OffTime"]];
                self.ArriveTime= [NSString stringWithFormat:@"%@",dic[@"go_base"][@"ArriveTime"]];
                self.Air_StartPortName = [NSString stringWithFormat:@"%@",dic[@"go_base"][@"StartPortName"]];
                self.Air_StartT = [NSString stringWithFormat:@"%@",dic[@"go_base"][@"StartT"]];
                self.Air_EndPortName = [NSString stringWithFormat:@"%@",dic[@"go_base"][@"EndPortName"]];
                self.Air_EndT = [NSString stringWithFormat:@"%@",dic[@"go_base"][@"EndT"]];
                self.Air_RunTime = [NSString stringWithFormat:@"%@",dic[@"go_base"][@"RunTime"]];
                self.Air_Meat = [NSString stringWithFormat:@"%@",dic[@"go_base"][@"Meat"]];
                self.Air_PlaneType = [NSString stringWithFormat:@"%@",dic[@"go_base"][@"PlaneType"]];
                self.Air_PlaneModel = [NSString stringWithFormat:@"%@",dic[@"go_base"][@"PlaneModel"]];
                
                self.Air_OffTime1 = [NSString stringWithFormat:@"%@",dic[@"return_base"][@"OffTime"]];
                self.ArriveTime1= [NSString stringWithFormat:@"%@",dic[@"return_base"][@"ArriveTime"]];
                self.Air_StartPortName1 = [NSString stringWithFormat:@"%@",dic[@"return_base"][@"StartPortName"]];
                self.Air_StartT1 = [NSString stringWithFormat:@"%@",dic[@"return_base"][@"StartT"]];
                self.Air_EndPortName1 = [NSString stringWithFormat:@"%@",dic[@"return_base"][@"EndPortName"]];
                self.Air_EndT1 = [NSString stringWithFormat:@"%@",dic[@"return_base"][@"EndT"]];
                self.Air_RunTime1 = [NSString stringWithFormat:@"%@",dic[@"return_base"][@"RunTime"]];
                self.Air_Meat1 = [NSString stringWithFormat:@"%@",dic[@"return_base"][@"Meat"]];
                self.Air_PlaneType1 = [NSString stringWithFormat:@"%@",dic[@"return_base"][@"PlaneType"]];
                self.Air_PlaneModel1 = [NSString stringWithFormat:@"%@",dic[@"return_base"][@"PlaneModel"]];
                
                NSArray *date = [self.Air_OffTime componentsSeparatedByString:@" "];
                NSArray *array = [date[1] componentsSeparatedByString:@":"];
                
                StartTime.text = [NSString stringWithFormat:@"%@:%@",array[0],array[1]];
                
                StartName.text = [NSString stringWithFormat:@"%@%@",self.Air_StartPortName,self.Air_StartT];
                
                NSArray *date2 = [self.Air_OffTime1 componentsSeparatedByString:@" "];
                NSArray *array2 = [date2[1] componentsSeparatedByString:@":"];
                
                StartTime1.text = [NSString stringWithFormat:@"%@:%@",array2[0],array2[1]];
                
                StartName1.text = [NSString stringWithFormat:@"%@%@",self.Air_StartPortName1,self.Air_StartT1];
                
                
                NSArray *date1 = [self.ArriveTime componentsSeparatedByString:@" "];
                NSArray *array1 = [date1[1] componentsSeparatedByString:@":"];
                
                EndTime.text = [NSString stringWithFormat:@"%@:%@",array1[0],array1[1]];
                
                EndName.text = [NSString stringWithFormat:@"%@%@",self.Air_EndPortName,self.Air_EndT];
                
                
                longLabel.text = [NSString stringWithFormat:@"%@",self.Air_RunTime];
                
                
                NSArray *date3 = [self.ArriveTime1 componentsSeparatedByString:@" "];
                NSArray *array3 = [date3[1] componentsSeparatedByString:@":"];
                
                EndTime1.text = [NSString stringWithFormat:@"%@:%@",array3[0],array3[1]];
                
                EndName1.text = [NSString stringWithFormat:@"%@%@",self.Air_EndPortName1,self.Air_EndT1];
                
                
                longLabel1.text = [NSString stringWithFormat:@"%@",self.Air_RunTime1];

                
                
                NSString *Meat;
                NSString *Meat1;
                
                if ([self.Air_Meat isEqualToString:@"0"]) {
                    
                    Meat = @"无餐";
                    
                }else if ([self.Air_Meat isEqualToString:@"1"]){
                    
                    Meat = @"有餐";
                }
                
                
                Datelabel.text = [NSString stringWithFormat:@"%@(%@) | %@",self.Air_PlaneType,self.Air_PlaneModel,Meat];
                if ([self.Air_PlaneModel isEqualToString:@""]) {
                    Datelabel.text=[NSString stringWithFormat:@"%@ |%@",self.Air_PlaneType,Meat];
                }
                if ([dic[@"go_base"][@"ByPass"] isEqualToString:@"1"]) {
                    Datelabel.text=[Datelabel.text stringByAppendingString:@"| 经停"];
                    
                }
                
                if ([self.Air_Meat1 isEqualToString:@"0"]) {
                    
                    Meat1 = @"无餐";
                    
                }else if ([self.Air_Meat1 isEqualToString:@"1"]){
                    
                    Meat1 = @"有餐";
                }
                
                
                Datelabel1.text = [NSString stringWithFormat:@"%@(%@) | %@",self.Air_PlaneType1,self.Air_PlaneModel1,Meat1];
                if ([self.Air_PlaneModel1 isEqualToString:@""]) {
                    Datelabel1.text=[NSString stringWithFormat:@"%@ |%@",self.Air_PlaneType1,Meat1];
                }
                if ([dic[@"return_base"][@"ByPass"] isEqualToString:@"1"]) {
                    Datelabel1.text=[Datelabel1.text stringByAppendingString:@"| 经停"];
                    
                }
            }else{
                
                
                [JRToast showWithText:dic[@"message"] duration:2.0f];
                
            }
            
       //     [hud dismiss:YES];
        }
       // [hud dismiss:YES];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
       // [hud dismiss:YES];
        NSLog(@"%@",error);
        
    }];
    
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.hidden = YES;
        _huiseControl=[[UIControl alloc]initWithFrame:CGRectMake(0, 0, UIBounds.size.width, UIBounds.size.height)];
        _huiseControl.backgroundColor=RGBACOLOR(0, 0, 0, 0.74);
        [_huiseControl addTarget:self action:@selector(huiseControlClick) forControlEvents:UIControlEventTouchUpInside];
        _huiseControl.alpha=0;
        //        self.backgroundColor = [UIColor whiteColor];
        
        
        _shareListView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, UIBounds.size.width-30, 133)];
        _shareListView.backgroundColor = RGBACOLOR(255, 255, 255, 0);
        _shareListView.layer.cornerRadius = 10;
        _shareListView.layer.masksToBounds = YES;
        [self addSubview:_shareListView];
        
        
        _shareListView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 143, UIBounds.size.width-30, 133)];
        _shareListView1.backgroundColor = RGBACOLOR(255, 255, 255, 1);
        _shareListView1.layer.cornerRadius = 10;
        _shareListView1.layer.masksToBounds = YES;
        [self addSubview:_shareListView1];
        
        
        UIView *selectView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UIBounds.size.width-30, 133)];
        selectView.backgroundColor = [UIColor whiteColor];
        [_shareListView addSubview:selectView];
        
        UIView *selectView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UIBounds.size.width-30, 133)];
        selectView1.backgroundColor = [UIColor whiteColor];
        [_shareListView1 addSubview:selectView1];

        
        
        Companylabel = [[UILabel alloc] initWithFrame:CGRectMake(42, 28, 200, 12)];
        Companylabel.text = @"";
        Companylabel.textColor = [UIColor blackColor];
        Companylabel.font = [UIFont fontWithName:@"PingFang-SC-Light" size:12];
        [selectView addSubview:Companylabel];
        
//        UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(115, 31, 20, 5)];
//        line.image = [UIImage imageNamed:@"icon_small-arrow-"];
//        [selectView addSubview:line];
//        
//        UILabel *BanCilabel = [[UILabel alloc] initWithFrame:CGRectMake(139, 28, 130, 12)];
//        BanCilabel.text = @"实际承运：深航ZH9429";
//        BanCilabel.textColor = [UIColor blackColor];
//        BanCilabel.font = [UIFont fontWithName:@"PingFang-SC-Light" size:12];
//        [selectView addSubview:BanCilabel];
        
        UIView *TimeView  = [[UIView alloc] initWithFrame:CGRectMake(42, 48, [UIScreen mainScreen].bounds.size.width-30-84, 18)];
        [selectView addSubview:TimeView];
        
        UIView *NameView  = [[UIView alloc] initWithFrame:CGRectMake(0, 72, [UIScreen mainScreen].bounds.size.width-30, 12)];
        [selectView addSubview:NameView];
        
        StartTime = [[UILabel alloc] initWithFrame:CGRectMake(0, 3, 100, 14)];
        StartTime.text = @"";
        StartTime.textColor = [UIColor blackColor];
        StartTime.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:18];
        [TimeView addSubview:StartTime];
        
        StartName = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ([UIScreen mainScreen].bounds.size.width-30)/2, 12)];
        StartName.text = @"";
        StartName.textColor = [UIColor blackColor];
        StartName.textAlignment = NSTextAlignmentCenter;
        StartName.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
        [NameView addSubview:StartName];
        
        EndTime = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-30-84-100, 3, 100, 14)];
        EndTime.text = @"";
        EndTime.textColor = [UIColor blackColor];
        EndTime.textAlignment = NSTextAlignmentRight;
        EndTime.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:18];
        [TimeView addSubview:EndTime];
        
        EndName = [[UILabel alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-30)/2, 0, ([UIScreen mainScreen].bounds.size.width-30)/2, 12)];
        EndName.text = @"";
        EndName.textColor = [UIColor blackColor];
        EndName.textAlignment = NSTextAlignmentCenter;
        EndName.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
        [NameView addSubview:EndName];
        
        longLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width-30-84, 13)];
        longLabel.text = @"";
        longLabel.textColor = [UIColor blackColor];
        longLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
        longLabel.textAlignment = NSTextAlignmentCenter;
        [TimeView addSubview:longLabel];
        
        GOGO = [[UIImageView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-30-84-101)/2, 10, 101, 8)];
        GOGO.image = [UIImage imageNamed:@""];
        [TimeView addSubview:GOGO];
        StopOverLab =[[UILabel alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-30-84-101)/2, 20, 101, 14)];
        StopOverLab.text=@"";
        StopOverLab.textColor=[UIColor blackColor];
        StopOverLab.textAlignment=NSTextAlignmentCenter;
        StopOverLab.font=KNSFONT(15);
        [TimeView addSubview:StopOverLab];
        
        Datelabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 93, [UIScreen mainScreen].bounds.size.width-190, 13)];
        Datelabel.text = @"";
        Datelabel.textColor = [UIColor blackColor];
        Datelabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
        Datelabel.textAlignment = NSTextAlignmentCenter;
        [selectView addSubview:Datelabel];
        
        
        Companylabel1 = [[UILabel alloc] initWithFrame:CGRectMake(42, 28, 200, 12)];
        Companylabel1.text = @"";
        Companylabel1.textColor = [UIColor blackColor];
        Companylabel1.font = [UIFont fontWithName:@"PingFang-SC-Light" size:12];
        [selectView1 addSubview:Companylabel1];
        
//        UIImageView *line1 = [[UIImageView alloc] initWithFrame:CGRectMake(115, 31, 20, 5)];
//        line1.image = [UIImage imageNamed:@"icon_small-arrow-"];
//        [selectView1 addSubview:line1];
//        
//        UILabel *BanCilabel1 = [[UILabel alloc] initWithFrame:CGRectMake(139, 28, 130, 12)];
//        BanCilabel1.text = @"实际承运：深航ZH9429";
//        BanCilabel1.textColor = [UIColor blackColor];
//        BanCilabel1.font = [UIFont fontWithName:@"PingFang-SC-Light" size:12];
//        [selectView1 addSubview:BanCilabel1];
        
        UIView *TimeView1  = [[UIView alloc] initWithFrame:CGRectMake(42, 48, [UIScreen mainScreen].bounds.size.width-30-84, 18)];
        [selectView1 addSubview:TimeView1];
        
        UIView *NameView1  = [[UIView alloc] initWithFrame:CGRectMake(0, 72, [UIScreen mainScreen].bounds.size.width-30, 12)];
        [selectView1 addSubview:NameView1];
        
        StartTime1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 3, 100, 14)];
        StartTime1.text = @"";
        StartTime1.textColor = [UIColor blackColor];
        StartTime1.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:18];
        [TimeView1 addSubview:StartTime1];
        
        StartName1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ([UIScreen mainScreen].bounds.size.width-30)/2, 12)];
        StartName1.text = @"";
        StartName1.textColor = [UIColor blackColor];
        StartName1.textAlignment = NSTextAlignmentCenter;
        StartName1.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
        [NameView1 addSubview:StartName1];
        
        EndTime1 = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-30-84-100, 3 , 100, 14)];
        EndTime1.text = @"";
        EndTime1.textColor = [UIColor blackColor];
        EndTime1.textAlignment = NSTextAlignmentRight;
        EndTime1.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:18];
        [TimeView1 addSubview:EndTime1];
        
        EndName1 = [[UILabel alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-30)/2, 0, ([UIScreen mainScreen].bounds.size.width-30)/2, 12)];
        EndName1.text = @"";
        EndName1.textColor = [UIColor blackColor];
        EndName1.textAlignment = NSTextAlignmentCenter;
        EndName1.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
        [NameView1 addSubview:EndName1];
        
        longLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width-30-84, 13)];
        longLabel1.text = @"";
        longLabel1.textColor = [UIColor blackColor];
        longLabel1.textAlignment = NSTextAlignmentCenter;
        longLabel1.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
        longLabel.textAlignment = NSTextAlignmentCenter;
        [TimeView1 addSubview:longLabel1];
        
        GOGO1 = [[UIImageView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-30-84-101)/2, 10, 101, 8)];
        GOGO1.image = [UIImage imageNamed:@""];
        [TimeView1 addSubview:GOGO1];
        StopOverLab1 =[[UILabel alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-30-84-101)/2, 20, 101, 14)];
        StopOverLab1.text=@"";
        StopOverLab1.textColor=[UIColor blackColor];
        StopOverLab1.textAlignment=NSTextAlignmentCenter;
        StopOverLab1.font=KNSFONT(15);
        [TimeView1 addSubview:StopOverLab1];
        
        
        Datelabel1 = [[UILabel alloc] initWithFrame:CGRectMake(80, 93, [UIScreen mainScreen].bounds.size.width-190, 13)];
        Datelabel1.text = @"";
        Datelabel1.textColor = [UIColor blackColor];
        Datelabel1.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
        Datelabel1.textAlignment = NSTextAlignmentCenter;
        [selectView1 addSubview:Datelabel1];
        
        
        UIImageView *GoImgView = [[UIImageView alloc] initWithFrame:CGRectMake(11, 10, 20, 20)];
        GoImgView.image = [UIImage imageNamed:@"icon-qu"];
        [selectView addSubview:GoImgView];
        
        UIImageView *BackImgView = [[UIImageView alloc] initWithFrame:CGRectMake(11, 10, 20, 20)];
        BackImgView.image = [UIImage imageNamed:@"icon-fan-hui"];
        [selectView1 addSubview:BackImgView];
        
        
        
    }
    return self;
}


- (void)showInView:(UIView *) view {
    if (self.isHidden) {
        self.hidden = NO;
        if (_huiseControl.superview==nil) {
            [view addSubview:_huiseControl];
        }
        [UIView animateWithDuration:0.2 animations:^{
            _huiseControl.alpha=1;
        }];
        CATransition *animation = [CATransition  animation];
        animation.delegate = self;
        animation.duration = 0.2f;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        animation.type = kCATransitionPush;
        animation.subtype = kCATransitionFromTop;
        [self.layer addAnimation:animation forKey:@"animation1"];
        self.frame = CGRectMake(15,(UIBounds.size.height-133*2-10)/2, UIBounds.size.width-30, 276);
        [view addSubview:self];
    }
}


- (void)hideInView {
    if (!self.isHidden) {
        self.hidden = YES;
        CATransition *animation = [CATransition  animation];
        animation.delegate = self;
        animation.duration = 0.2f;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        animation.type = kCATransitionPush;
        animation.subtype = kCATransitionFromBottom;
        [self.layer addAnimation:animation forKey:@"animtion2"];
        [UIView animateWithDuration:0.2 animations:^{
            _huiseControl.alpha=0;
        }completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }
}


-(void)huiseControlClick{
    [self hideInView];
}


@end
