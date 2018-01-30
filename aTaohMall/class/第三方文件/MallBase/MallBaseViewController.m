//
//  MallBaseViewController.m
//  Mall
//
//  Created by DingDing on 14-12-25.
//  Copyright (c) 2014年 QJM. All rights reserved.
//

#import "MallBaseViewController.h"

@implementation MallBaseViewController


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    NSLog(@" ------ 现在打开的是: %@ ---------",NSStringFromClass([self class]));
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
}


- (void)logTouchInfo:(UITouch *)touch{
    
    CGPoint locInSelf = [touch locationInView:self.view];
    CGPoint locInWin = [touch locationInView:nil];
    NSLog(@"    touch.locationInView = {%2.3f, %2.3f}", locInSelf.x, locInSelf.y);
    NSLog(@"    touch.locationInWin = {%2.3f, %2.3f}", locInWin.x, locInWin.y);
    NSLog(@"    touch.phase = %ld", (long)touch.phase);
    NSLog(@"    touch.tapCount = %ld", (unsigned long)touch.tapCount);
    
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"touchesBegan - touch count = %ld", (unsigned long)[touches count]);
    for(UITouch *touch in event.allTouches) {
        [self logTouchInfo:touch];
        
        NSLog(@"===============");
        NSLog(@"===============");
        NSLog(@"===============");
        NSLog(@"===============");
        NSLog(@"===============");
        NSLog(@"===============");
        NSLog(@"===============");
        NSLog(@"===============");
        
    }
}

@end
