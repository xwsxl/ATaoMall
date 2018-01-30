//
//  NineFooterView.m
//  aTaohMall
//
//  Created by JMSHT on 16/7/12.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import "NineFooterView.h"


@interface NineFooterView()


@end


@implementation NineFooterView


+ (instancetype)footerView
{
    return [[[NSBundle mainBundle]loadNibNamed:@"NineFooterView" owner:nil options:nil]lastObject];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (IBAction)loadMoreBtnClick:(UIButton *)sender {
    
    self.loadMoreBtn.hidden = YES;
    
    self.moreView.hidden = NO;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        if ([self.delegate respondsToSelector:@selector(FooterViewClickedloadMoreData)]) {
            [self.delegate FooterViewClickedloadMoreData];
        }
        
        self.loadMoreBtn.hidden = NO;
//
        self.moreView.hidden = YES;
    });
    
}

@end
