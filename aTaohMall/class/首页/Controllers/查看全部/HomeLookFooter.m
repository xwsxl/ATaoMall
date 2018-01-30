//
//  HomeLookFooter.m
//  aTaohMall
//
//  Created by JMSHT on 16/7/11.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import "HomeLookFooter.h"

@interface HomeLookFooter()

@end
@implementation HomeLookFooter

+ (instancetype)footerView
{
    return [[[NSBundle mainBundle]loadNibNamed:@"FooterView" owner:nil options:nil]lastObject];
}
- (IBAction)loadMoreBtnClick:(UIButton *)sender {
    
    NSLog(@"========self.totalCount=====%@==",self.totalCount);
    
    NSLog(@"========self.DataCount=====%@==",self.DataCount);
    
    
//    if ([self.DataCount integerValue] ==[self.totalCount integerValue]) {
//        
//        NSLog(@"~~~~~~~~~~~~~~~~~");
//        
//        self.moreView.hidden=YES;
//        
//        [self.loadMoreBtn setTitle:@"暂无更多数据" forState:0];
//        [self.loadMoreBtn setTitleColor:[UIColor colorWithRed:111/255.0 green:111/255.0 blue:111/255.0 alpha:1.0] forState:0];
////        self.loadMoreBtn.enabled=NO;
//        
//        
//    }else{
//        
        self.loadMoreBtn.hidden = YES;
        
        self.moreView.hidden = NO;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            
            self.loadMoreBtn.hidden = NO;
            
            self.moreView.hidden = YES;
            
            if ([self.delegate respondsToSelector:@selector(FooterViewClickedloadMoreData)]) {
                [self.delegate FooterViewClickedloadMoreData];
            }
            
            
        });
//    }
    
}



@end
