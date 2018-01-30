//
//  ITDPApplication.m
//  InTimeDoctorPatient
//
//  Created by Kevin on 15/3/14.
//  Copyright (c) 2015年 InTimeDoctorPatient. All rights reserved.
//

#import "ITDPApplication.h"

@implementation ITDPApplication
//- (void)sendEvent:(UIEvent *)event {
//    [super sendEvent:event];
//    
//    // Fire up the timer upon first event
//    if(!_idleTimer) {
//        [self resetIdleTimer];
//    }
//    
//    // Check to see if there was a touch event
//    NSSet *allTouches = [event allTouches];
//    if ([allTouches count] > 0) {
//        UITouchPhase phase = ((UITouch *)[allTouches anyObject]).phase;
//        if (phase == UITouchPhaseBegan) {
//            [self resetIdleTimer];
//        }
//    }
//}
//
//- (void)resetIdleTimer
//{
//    if (_idleTimer) {
//        [_idleTimer invalidate];
//
//    }
//    
////     Schedule a timer to fire in kApplicationTimeoutInMinutes * 60
//    int timeout = kApplicationTimeoutInMinutes * 60;
//    _idleTimer = [NSTimer scheduledTimerWithTimeInterval:timeout
//                                                   target:self
//                                                 selector:@selector(idleTimerExceeded)
//                                                 userInfo:nil 
//                                                  repeats:NO];
//    
//}
//- (void)idleTimerExceeded {
//    /* Post a notification so anyone who subscribes to it can be notified when
//     * the application times out */
//    [[NSNotificationCenter defaultCenter]
//     postNotificationName:kApplicationDidTimeoutNotification object:nil];
//}
@end
