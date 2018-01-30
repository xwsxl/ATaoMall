//
//  ITDPApplication.h
//  InTimeDoctorPatient
//
//  Created by Kevin on 15/3/14.
//  Copyright (c) 2015年 InTimeDoctorPatient. All rights reserved.
//

#import <UIKit/UIKit.h>
// # of minutes before application times out
//#define kApplicationTimeoutInMinutes 30

// Notification that gets sent when the timeout occurs
#define kApplicationDidTimeoutNotification @"ApplicationDidTimeout"
@interface ITDPApplication : UIApplication{
  //  NSTimer *_idleTimer;
}

//- (void)resetIdleTimer;
@end
