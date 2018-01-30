//
//  TrainToast.m
//  aTaohMall
//
//  Created by JMSHT on 2017/5/15.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "TrainToast.h"

@interface TrainToast ()

- (instancetype)initWithText:(NSString *)text;
- (void)setDuration:(CGFloat)duration;

- (void)dismissToast;
- (void)toastTaped:(UIButton *)button;

- (void)showAnimation;
- (void)hideAnimation;

- (void)show;
- (void)showFromTopOffset:(CGFloat)topOffset;
- (void)showFromBottomOffset:(CGFloat)bottomOffset;

@end

@implementation TrainToast

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:[UIDevice currentDevice]];
}

- (id)initWithText:(NSString *)text{
    if (self = [super init]) {
        
        _text = [text copy];
        
        UIFont *font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
        CGSize textSize = [text boundingRectWithSize:CGSizeMake(Width(240), MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : font} context:nil].size;
        
                UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(Width(15), Width(12), Width(240), textSize.height )];
        
//        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, (98-textSize.height)/2, 214-30, textSize.height)];
        
  //      UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, (98-50)/2, 214-30, 50)];
        
        textLabel.backgroundColor = [UIColor clearColor];
        textLabel.textColor = [UIColor whiteColor];
        textLabel.textAlignment = NSTextAlignmentCenter;
        textLabel.font = font;
        textLabel.text = text;
        textLabel.numberOfLines = 0;
        
               _contentView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, Width(270), textLabel.frame.size.height+Width(24))];
       // _contentView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 214, 98)];
        
        _contentView.layer.cornerRadius = 10.0f;
        _contentView.layer.masksToBounds = YES;
        _contentView.layer.borderWidth = 1.0f;
        _contentView.layer.borderColor = [[UIColor grayColor] colorWithAlphaComponent:0.5].CGColor;
        _contentView.backgroundColor = [UIColor colorWithRed:93/255.0
                                                       green:93/255.0
                                                        blue:93/255.0
                                                       alpha:0.9f];
        [_contentView addSubview:textLabel];
        _contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [_contentView addTarget:self
                         action:@selector(toastTaped:)
               forControlEvents:UIControlEventTouchDown];
        _contentView.alpha = 0.0f;
        
        _duration = DEFAULT_DISPLAY_DURATION;
        
        // 监听屏幕方向改变的通知
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(deviceOrientationDidChanged:)
                                                     name:UIDeviceOrientationDidChangeNotification
                                                   object:[UIDevice currentDevice]];
    }
    return self;
}

- (void)deviceOrientationDidChanged:(NSNotification *)aNotification
{
    [self hideAnimation];
}

/** 设置延迟消失的时间 */
- (void)setDuration:(CGFloat)duration
{
    _duration = duration;
}

/** 移除Toast */
- (void)dismissToast
{
    [_contentView removeFromSuperview];
}

/** 点击了Toast则移除 */
- (void)toastTaped:(UIButton *)button
{
    [self hideAnimation];
}

/** 带动画改变Toast的透明度 */
- (void)showAnimation
{
    [UIView animateWithDuration:0.3 animations:^{
        _contentView.alpha = 1.0;
    }];
}

/** 先改变透明度，再移除Toast，带动画 */
- (void)hideAnimation
{
    [UIView animateWithDuration:0.3 animations:^{
        _contentView.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self dismissToast];
    }];
}

/** 显示Toast，带动画 */
- (void)show
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    _contentView.center = window.center;
    [window addSubview:_contentView];
    [self showAnimation];
    [self performSelector:@selector(hideAnimation) withObject:nil afterDelay:_duration];
}

/** 偏离顶部多少以显示Toast */
- (void)showFromTopOffset:(CGFloat)topOffset
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    _contentView.center = CGPointMake(window.center.x, topOffset + _contentView.frame.size.height / 2);
    [window addSubview:_contentView];
    [self showAnimation];
    [self performSelector:@selector(hideAnimation) withObject:nil afterDelay:_duration];
}

/** 偏离底部多少以显示Toast */
- (void)showFromBottomOffset:(CGFloat)bottomOffset
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    _contentView.center = CGPointMake(window.center.x, window.frame.size.height - (bottomOffset + _contentView.frame.size.height / 2));
    [window addSubview:_contentView];
    [self showAnimation];
    [self performSelector:@selector(hideAnimation) withObject:nil afterDelay:_duration];
}

/** 默认的Toast */
+ (void)showWithText:(NSString *)text
{
    [self showWithText:text duration:DEFAULT_DISPLAY_DURATION];
}

/** Toast显示text, 经duration时间后移除 */
+ (void)showWithText:(NSString *)text duration:(CGFloat)duration
{
    TrainToast *toast = [[TrainToast alloc] initWithText:text];
    [toast setDuration:duration];
    [toast show];
}

/** Toast显示text, 偏离顶部topOffset */
+ (void)showWithText:(NSString *)text topOffset:(CGFloat)topOffset
{
    [self showWithText:text topOffset:topOffset duration:DEFAULT_DISPLAY_DURATION];
}

/** Toast显示text, 偏离顶部topOffset, 经duration时间后移除 */
+ (void)showWithText:(NSString *)text topOffset:(CGFloat)topOffset duration:(CGFloat)duration
{
    TrainToast *toast = [[TrainToast alloc] initWithText:text];
    [toast setDuration:duration];
    [toast showFromTopOffset:topOffset];
}

/** Toast显示text, 偏离底部topOffset */
+ (void)showWithText:(NSString *)text bottomOffset:(CGFloat)bottomOffset
{
    [self showWithText:text bottomOffset:bottomOffset duration:DEFAULT_DISPLAY_DURATION];
}

/** Toast显示text, 偏离底部topOffset, 经duration时间后移除 */
+ (void)showWithText:(NSString *)text bottomOffset:(CGFloat)bottomOffset duration:(CGFloat)duration
{
    TrainToast *toast = [[TrainToast alloc] initWithText:text];
    [toast setDuration:duration];
    [toast showFromBottomOffset:bottomOffset];
}

@end
