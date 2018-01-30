//
//  UIAlertTools.h
//  aTaohMall
//
//  Created by DingDing on 2017/8/21.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import <Foundation/Foundation.h>
#define cancelIndex    (-1)
@interface UIAlertTools : NSObject
typedef void(^AlertViewBlock)(NSInteger buttonTag);


/**
 创建alert   titleArray数组为nil时,不创建确定按钮，否则都会创建

 @param title 标题
 @param message  信息
 @param cancelTitle  取消按钮的标题
 @param titleArray 按钮数组
 @param vc 由哪个vc推出
 @param confirm 按钮点击回调 -1为取消，0为确定，其它为titleArray下标
 */
+(UIAlertController *)showAlertWithTitle:(NSString *)title
          message:(NSString *)message
      cancelTitle:(NSString *)cancelTitle
       titleArray:(NSArray *)titleArray
   viewController:(UIViewController *)vc
          confirm:(AlertViewBlock)confirm;

typedef void (^CallBackBlock)(NSInteger btnIndex);

/**
 自定义封装的UIAlertController方法

 @param viewController       显示的vc
 @param alertControllerStyle UIAlertControllerStyle 样式
 @param title                标题
 @param message              提示信息
 @param block                回调block
 @param cancelBtnTitle       取消button标题
 @param destructiveBtnTitle  红色的按钮
 @param otherBtnTitles       其他button标题
 */
+ (UIAlertController *)showAlertCntrollerWithViewController:(UIViewController*)viewController alertControllerStyle:(UIAlertControllerStyle)alertControllerStyle title:(NSString*)title message:(NSString*)message CallBackBlock:(CallBackBlock)block cancelButtonTitle:(NSString *)cancelBtnTitle
                      destructiveButtonTitle:(NSString *)destructiveBtnTitle
                           otherButtonTitles:(NSString *)otherBtnTitles,...NS_REQUIRES_NIL_TERMINATION;
@end
