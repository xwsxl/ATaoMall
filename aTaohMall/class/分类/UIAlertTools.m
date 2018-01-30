//
//  UIAlertTools.m
//  aTaohMall
//
//  Created by DingDing on 2017/8/21.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "UIAlertTools.h"
//#import "UIAlertController+Alert.h"
#import "PersonalShoppingReplyRefundVC.h"
@implementation UIAlertTools
/**
 创建alert   titleArray数组为nil时,不创建确定按钮，否则都会创建
 
 @param title 标题
 @param message  信息
 @param cancelTitle  取消按钮的标题
 @param titleArray 按钮数组
 @param vc 由哪个vc推出
 @param confirm 按钮点击回调 -1为取消，0为确定，其它为titleArray下标
 */
+ (UIAlertController *)showAlertWithTitle:(NSString *)title
          message:(NSString *)message
      cancelTitle:(NSString *)cancelTitle
       titleArray:(NSArray *)titleArray
   viewController:(UIViewController *)vc
          confirm:(AlertViewBlock)confirm
{
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    if (cancelTitle) {
        [alert addAction:[UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            if (confirm) {
                confirm(cancelIndex);
            }
        }]];
    }
    if (titleArray)
    {
        UIAlertAction  *confirmAction = [UIAlertAction actionWithTitle:@"确认"
                                                                 style:UIAlertActionStyleDefault
                                                               handler:^(UIAlertAction * _Nonnull action) {
                                                                   if (confirm)confirm(0);
                                                               }];
        
        [alert addAction:confirmAction];
        
        if (titleArray.count>0) {
            for (NSInteger i = 0; i<titleArray.count; i++) {
                UIAlertAction  *action = [UIAlertAction actionWithTitle:titleArray[i]
                                                                  style:UIAlertActionStyleDefault
                                                                handler:^(UIAlertAction * _Nonnull action) {
                                                                    if (confirm)confirm(i);
                                                                }];
                // [action setValue:UIColorFrom16RGB(0x00AE08) forKey:@"titleTextColor"]; // 此代码 可以修改按钮颜色
                [alert addAction:action];
            }
        }
    }
    
    [vc presentViewController:alert animated:NO completion:nil];
    return alert;
}


+(UIAlertController *)showAlertCntrollerWithViewController:(UIViewController *)viewController alertControllerStyle:(UIAlertControllerStyle)alertControllerStyle title:(NSString *)title message:(NSString *)message CallBackBlock:(CallBackBlock)block cancelButtonTitle:(NSString *)cancelBtnTitle destructiveButtonTitle:(NSString *)destructiveBtnTitle otherButtonTitles:(NSString *)otherBtnTitles, ...
{
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:alertControllerStyle];

    //添加按钮
    if (cancelBtnTitle.length) {
        UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:cancelBtnTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            block(0);
        }];
        [alertController addAction:cancelAction];
    }
    if (destructiveBtnTitle.length) {
        UIAlertAction * destructiveAction = [UIAlertAction actionWithTitle:destructiveBtnTitle style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            block(1);
        }];
        [alertController addAction:destructiveAction];
    }
    if (otherBtnTitles.length) {
        UIAlertAction *otherActions = [UIAlertAction actionWithTitle:otherBtnTitles style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            (!cancelBtnTitle.length && !destructiveBtnTitle.length) ? block(0) : (((cancelBtnTitle.length && !destructiveBtnTitle.length) || (!cancelBtnTitle.length && destructiveBtnTitle.length)) ? block(1) : block(2));
        }];
        [alertController addAction:otherActions];
        /**
         *  va_list : （1）首先在函数里定义一具VA_LIST型的变量，这个变量是指向参数的指针；
         *            （2）然后用VA_START宏初始化变量刚定义的VA_LIST变量；
         *            （3）然后用VA_ARG返回可变的参数，VA_ARG的第二个参数是你要返回的参数的类型（如果函数有多个可变参数的，依次调用VA_ARG获取各个参数）；
         *            （4）最后用VA_END宏结束可变参数的获取。
         *   va_start :获取可变参数列表的第一个参数的地址;
         *   va_arg :获取当前参数，返回指定类型并将指针指向下一参数
         *   va_end :清空va_list可变参数列表：
         *
         *
         */

        va_list args;
        va_start(args, otherBtnTitles);
        if (otherBtnTitles.length) {
            NSString * otherString;
            int index = 2;
            (!cancelBtnTitle.length && !destructiveBtnTitle.length) ? (index = 0) : ((cancelBtnTitle.length && !destructiveBtnTitle.length) || (!cancelBtnTitle.length && destructiveBtnTitle.length) ? (index = 1) : (index = 2));
            while ((otherString = va_arg(args, NSString*))) {
                index ++ ;
                UIAlertAction * otherActions = [UIAlertAction actionWithTitle:otherString style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    block(index);
                }];
                [alertController addAction:otherActions];
            }
        }
        va_end(args);
    }
    [viewController presentViewController:alertController animated:YES completion:nil];

    return alertController;

}





@end
