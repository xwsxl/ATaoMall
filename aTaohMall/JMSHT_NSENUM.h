//
//  JMSHT_NSENUM.h
//  aTaohMall
//
//  Created by Zhending Shi on 2017/7/17.
//  Copyright © 2017年 ysy. All rights reserved.
//

#ifndef JMSHT_NSENUM_h
#define JMSHT_NSENUM_h

/*******************************************************      枚举       ******************************************************/

/**
 登录状态判定

 - LoginState_login: 登录
 - LoginState_quit: 退出
 */
typedef NS_ENUM(NSInteger,LoginState)
{
    LoginState_login=0,
    LoginState_quit
};

/**
 大小比较枚举

 - XLComparedResult_Descending: 降序
 - XLComparedResult_Same: 相等
 - XLComparedResult_Ascending: 升序
 */
typedef NS_ENUM(NSInteger,XLComparedResult)
{
    XLComparedResult_Descending=-1,
    XLComparedResult_Same,
    XLComparedResult_Ascending
};







/*******************************************************      别名       ******************************************************/

typedef void (^MGBasicBlock)();

#endif /* JMSHT_NSENUM_h */
//
//                       .::::.
//                     .::::::::.
//                    :::::::::::
//                 ..:::::::::::'
//              '::::::::::::'
//                .::::::::::            Fuck You
//           '::::::::::::::..
//                ..::::::::::::.
//              ``::::::::::::::::
//               ::::``:::::::::'        .:::.
//              ::::'   ':::::'       .::::::::.
//            .::::'      ::::     .:::::::'::::.
//           .:::'       :::::  .:::::::::' ':::::.
//          .::'        :::::.:::::::::'      ':::::.
//         .::'         ::::::::::::::'         ``::::.
//     ...:::           ::::::::::::'              ``::.
//    ```` ':.          ':::::::::'                  ::::..
//                       '.:::::'                    ':'````..
