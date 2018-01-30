//
//  UIImage+Color.h
//  aTaohMall
//
//  Created by Zhending Shi on 2017/8/7.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Color)
- (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)imageWithBgColor:(UIColor *)color ;
+(UIImage *)imageWithImageView:(CGRect )ViewRect StartColor:(UIColor *)startColor EndColor:(UIColor *)endColor startPoint:(CGPoint )startPoint endPoint:(CGPoint )endPoint;
//截取部分图像
-(UIImage*)getSubImage:(CGRect)rect;
@end

