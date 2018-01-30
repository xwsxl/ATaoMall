//
//  AirNoticeView.m
//  aTaohMall
//
//  Created by JMSHT on 2017/7/14.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "AirNoticeView.h"

@interface AirNoticeView()<UITextViewDelegate>
{
    
    UITextView *_textView;
    
}

@property (assign, nonatomic) BOOL isSelect;

@end
#define UIBounds [[UIScreen mainScreen] bounds] //window外框大小
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:a]

@implementation AirNoticeView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.hidden = YES;
        _huiseControl=[[UIControl alloc]initWithFrame:CGRectMake(0, 0, UIBounds.size.width, UIBounds.size.height)];
        _huiseControl.backgroundColor=RGBACOLOR(0, 0, 0, 0.74);
        [_huiseControl addTarget:self action:@selector(huiseControlClick) forControlEvents:UIControlEventTouchUpInside];
        _huiseControl.alpha=0;
        //        self.backgroundColor = [UIColor whiteColor];
        
        
        _shareListView = [[UIView alloc]initWithFrame:CGRectMake(50, 0, UIBounds.size.width-30-100, 180)];
        _shareListView.backgroundColor = RGBACOLOR(255, 255, 255, 0);
        _shareListView.layer.cornerRadius = 10;
        _shareListView.layer.masksToBounds = YES;
        [self addSubview:_shareListView];
        
        UIView *selectView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UIBounds.size.width-30, 180)];
        selectView.backgroundColor = [UIColor whiteColor];
        [_shareListView addSubview:selectView];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, UIBounds.size.width-30-100-40, 80)];
        titleLabel.text = @"所退机票可能存在只退机建燃油费+保险费的风险，具体退还金额以航空公司审核为准。退票前建议先咨询客服4008-119-789 转2，请谨慎退票！";
        titleLabel.numberOfLines = 0;
        titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:14];
        titleLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
//        [selectView addSubview:titleLabel];
        
        
        _textView = [[UITextView alloc] initWithFrame:CGRectMake(20, 20, UIBounds.size.width-30-100-40, 100)];
        _textView.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:14];
        _textView.backgroundColor = [UIColor whiteColor];
        _textView.delegate = self;
        _textView.editable = NO;        //必须禁止输入，否则点击将弹出输入键盘
        _textView.scrollEnabled = YES;
        [selectView addSubview:_textView];
        
        [self protocolIsSelect:self.isSelect];
        
        
        UIImageView *ImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 120, UIBounds.size.width-30, 1)];
        ImgView.image = [UIImage imageNamed:@"分割线-拷贝"];
        [selectView addSubview:ImgView];
        
        UIImageView *ImgView1 = [[UIImageView alloc] initWithFrame:CGRectMake((UIBounds.size.width-30-100)/2, 120, 1, 60)];
        ImgView1.image = [UIImage imageNamed:@"分割线-拷贝"];
        [selectView addSubview:ImgView1];
        
        UIButton *CancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        CancleButton.frame = CGRectMake(0, 120, (UIBounds.size.width-30-100)/2, 60);
        CancleButton.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:14];
        [CancleButton setTitleColor:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0] forState:0];
        [CancleButton setTitle:@"取消退票" forState:0];
        [CancleButton addTarget:self action:@selector(CancleButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [selectView addSubview:CancleButton];
        
        UIButton *KidButton = [UIButton buttonWithType:UIButtonTypeCustom];
        KidButton.frame = CGRectMake((UIBounds.size.width-30-100)/2+1, 120, (UIBounds.size.width-30-100)/2, 60);
        KidButton.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:14];
        [KidButton setTitleColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0] forState:0];
        [KidButton setTitle:@"继续退票" forState:0];
        [KidButton addTarget:self action:@selector(KidBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [selectView addSubview:KidButton];
        
        
    }
    return self;
}


-(BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    
    //    UITextView *text=(UITextView *)sender;
    [UIMenuController sharedMenuController].menuVisible = NO;  //donot display the menu
    [_textView resignFirstResponder];                     //do not allow the user to selected anything
    return NO;
    
}

- (void)protocolIsSelect:(BOOL)select {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"所退机票可能存在只退机建燃油费+保险费的风险，具体退还金额以航空公司审核为准。退票前建议先咨询客服4008-119-789 转2，请谨慎退票！"];
    [attributedString addAttribute:NSLinkAttributeName
                             value:@"zhifubao://"
                             range:[[attributedString string] rangeOfString:@"4008-119-789"]];
    [attributedString addAttribute:NSLinkAttributeName
                             value:@"weixin://"
                             range:[[attributedString string] rangeOfString:@"《关于禁止携带危险品乘机的通知》"]];
    [attributedString addAttribute:NSLinkAttributeName
                             value:@"jianhang://"
                             range:[[attributedString string] rangeOfString:@"《特殊旅客购票须知》"]];
    
    NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
    
    NSMutableAttributedString *imageString = [NSMutableAttributedString attributedStringWithAttachment:textAttachment];
    [imageString addAttribute:NSLinkAttributeName
                        value:@"checkbox://"
                        range:NSMakeRange(0, imageString.length)];
    [attributedString insertAttributedString:imageString atIndex:0];
    
    [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Medium" size:14] range:NSMakeRange(0, attributedString.length)];
    _textView.attributedText = attributedString;
    _textView.linkTextAttributes = @{NSForegroundColorAttributeName: [UIColor colorWithRed:43/255.0 green:143/255.0 blue:255/255.0 alpha:1.0],
                                     NSUnderlineColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0],
                                     NSUnderlineStyleAttributeName: @(NSUnderlinePatternSolid)};
    
    _textView.delegate = self;
    _textView.editable = NO;        //必须禁止输入，否则点击将弹出输入键盘
    _textView.scrollEnabled = NO;
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange {
    if ([[URL scheme] isEqualToString:@"jianhang"]) {
        NSLog(@"建行支付---------------");
        
        
        
        return NO;
    } else if ([[URL scheme] isEqualToString:@"zhifubao"]) {
        NSLog(@"支付宝支付---------------");
        
        NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",@"4008-119-789"];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        
        return NO;
    } else if ([[URL scheme] isEqualToString:@"weixin"]) {
        NSLog(@"微信支付---------------");
        
        
        
        return NO;
    } else if ([[URL scheme] isEqualToString:@"checkbox"]) {
        self.isSelect = !self.isSelect;
        [self protocolIsSelect:self.isSelect];
        return NO;
    }
    return YES;
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
        self.frame = CGRectMake(15,(UIBounds.size.height - 180)/2, UIBounds.size.width-30, 180);
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


-(void)CancleButtonClick
{
    
    [self hideInView];
}

-(void)KidBtnClick
{
    
    if (_delegate && [_delegate respondsToSelector:@selector(AirNoticeViewRelodate)]) {
        
        [_delegate AirNoticeViewRelodate];
        
    }
    [self hideInView];
}

-(void)huiseControlClick{
//    [self hideInView];
}

@end
