//
//  AirOneDetailView.m
//  aTaohMall
//
//  Created by JMSHT on 2017/5/22.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "AirOneDetailView.h"

#import "AFNetworking.h"

#import "ConverUtil.h"
#import "DESUtil.h"
#import "SecretCodeTool.h"
#import "AirSelectView.h"

#import "WKProgressHUD.h"

#import "JRToast.h"
#define UIBounds [[UIScreen mainScreen] bounds] //window外框大小
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:a]

@interface AirOneDetailView()
{
    UILabel *Companylabel;
    UILabel *StartTime;
    UILabel *StartName;
    UILabel *EndTime;
    UILabel *EndName;
    UILabel *longLabel;
    UIImageView *GOGO;
    UILabel *Datelabel;
    UIView *TimeView;
    UILabel *StopOverLab;
}
@end
@implementation AirOneDetailView

-(void)Time:(NSString *)time Flight:(NSString *)flightNo
{
    
    _flightNo = flightNo;
    
    _time = time;
    
    NSLog(@"===self.flightNo===%@===time==%@",_flightNo,time);
    
    [self getPriceChange];
    
}
//判断票价改变
-(void)getPriceChange
{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@getFlightInformation_mob.shtml",URL_Str];
    //saveUserExchange_mob.shtml
    
    NSDictionary *dict = @{@"go_time":_time,@"go_plane_number":_flightNo,@"return_time":@"",@"return_plane_number":@""};
    
   //  WKProgressHUD *hud=[WKProgressHUD showInView:_huiseControl animated:YES];
    
    [manager POST:url parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
        NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];
        
        
        if (codeKey && content) {
            NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
            
//            NSLog(@"xmlStr=航班信息=%@",xmlStr);
            
            
            NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
                       NSLog(@"哈哈哈哈哈哈=%@",dic);
            
            
            
            if ([dic[@"status"] isEqualToString:@"10000"]) {
                
              
                GOGO.image = [UIImage imageNamed:@"icon_arrow"];
                
                NSLog(@"====%@",dic[@"go_base"]);
                
                Companylabel.text = [NSString stringWithFormat:@"%@%@",dic[@"go_base"][@"CarrinerName"],dic[@"go_base"][@"FlightNo"]];
                
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
                
                NSArray *date = [self.Air_OffTime componentsSeparatedByString:@" "];
                NSArray *array = [date[1] componentsSeparatedByString:@":"];
                
                StartTime.text = [NSString stringWithFormat:@"%@:%@",array[0],array[1]];
                
                StartName.text = [NSString stringWithFormat:@"%@%@",self.Air_StartPortName,self.Air_StartT];
                
                
                NSArray *date1 = [self.ArriveTime componentsSeparatedByString:@" "];
                NSArray *array1 = [date1[1] componentsSeparatedByString:@":"];
                
                EndTime.text = [NSString stringWithFormat:@"%@:%@",array1[0],array1[1]];
        
                EndName.text = [NSString stringWithFormat:@"%@%@",self.Air_EndPortName,self.Air_EndT];

                
                longLabel.text = [NSString stringWithFormat:@"%@",self.Air_RunTime];
                
                NSString *Meat;
                
                if ([self.Air_Meat isEqualToString:@"0"]) {
                    
                    Meat = @"无餐";
                    
                }else if ([self.Air_Meat isEqualToString:@"1"]){
                    
                    Meat = @"有餐";
                }
//                if ([dic[@"go_base"][@"ByPass"] isEqualToString:@"1"]) {
//                    StopOverLab.text=@"经停";
//                    
//                }else
//                {
//                    StopOverLab.text=@"";
//                }
                
                
                
                Datelabel.text = [NSString stringWithFormat:@"%@(%@) | %@",self.Air_PlaneType,self.Air_PlaneModel,Meat];
                if ([self.Air_PlaneModel isEqualToString:@""]) {
                    Datelabel.text=[NSString stringWithFormat:@"%@ |%@",self.Air_PlaneType,Meat];
                }
                if ([dic[@"go_base"][@"ByPass"] isEqualToString:@"1"]) {
                    Datelabel.text=[Datelabel.text stringByAppendingString:@"| 经停"];
                    
                }
                
                
            }else{
                
                
                [JRToast showWithText:dic[@"message"] duration:2.0f];
                
            }
 
       //     [hud dismiss:YES];
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        NSLog(@"%@",error);
      //  [hud dismiss:YES];
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
        
        
        
        
        UIView *selectView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UIBounds.size.width-30, 133)];
        selectView.backgroundColor = [UIColor whiteColor];
        [_shareListView addSubview:selectView];
        
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
        
        TimeView  = [[UIView alloc] initWithFrame:CGRectMake(42, 48, [UIScreen mainScreen].bounds.size.width-30-84, 18)];
        [selectView addSubview:TimeView];
        
        StartTime = [[UILabel alloc] initWithFrame:CGRectMake(0, 3, 100, 14)];
        StartTime.text = @"";
        StartTime.textColor = [UIColor blackColor];
        StartTime.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:18];
        [TimeView addSubview:StartTime];
        
        StartName = [[UILabel alloc] initWithFrame:CGRectMake(0, 72, ([UIScreen mainScreen].bounds.size.width-30)/2, 12)];
        StartName.text = @"";
        StartName.textColor = [UIColor blackColor];
        StartName.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
        StartName.textAlignment = NSTextAlignmentCenter;
        [selectView addSubview:StartName];
        
        EndTime = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-30-84-100, 3, 100, 14)];
        EndTime.text = @"";
        EndTime.textColor = [UIColor blackColor];
        EndTime.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:18];
        EndTime.textAlignment = NSTextAlignmentRight;
        [TimeView addSubview:EndTime];
        
        EndName = [[UILabel alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-30)/2, 73, ([UIScreen mainScreen].bounds.size.width-30)/2, 12)];
        EndName.text = @"";
        EndName.textColor = [UIColor blackColor];
        EndName.textAlignment = NSTextAlignmentCenter;
        EndName.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
        [selectView addSubview:EndName];
        
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
        self.frame = CGRectMake(15,200, UIBounds.size.width-30, 133);
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
