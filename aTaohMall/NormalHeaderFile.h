//
//  NormalHeaderFile.h
//  aTaohMall
//
//  Created by Zhending Shi on 2017/7/17.
//  Copyright © 2017年 ysy. All rights reserved.
//

#ifndef NormalHeaderFile_h
#define NormalHeaderFile_h
/*********************** 系统常用 *********************/
#define kApplication [UIApplication sharedApplication]
#define kKeyWindow [UIApplication sharedApplication].keyWindow
#define kUserDefaults [NSUserDefaults standardUserDefaults]
#define KAppDelegate (AppDelegate *)[[UIApplication sharedApplication] delegate]
#define KWindow             [[[UIApplication sharedApplication] windows] lastObject]
#define KNotificationCenter [NSNotificationCenter defaultCenter]
#define KDeviceID [[UIDevice currentDevice].identifierForVendor UUIDString] //设备唯一标识
#define CurrentSystemVersion [[[UIDevice currentDevice] systemVersion] floatValue] //获取系统版本
/*********************** 版本号 *********************/
#define kVersion_ATH [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]
#define kVersionBuild_ATH [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"]

/*********************** 代码常用 *********************/
#define KNSURL(A) [NSURL URLWithString:A]
#define KNSFONT(A) [UIFont fontWithName:@"PingFang-SC-Regular" size:A]
#define KMAXSIZE CGSizeMake(MAXFLOAT, MAXFLOAT)
#define KImage(A)  [UIImage imageNamed:A]
#define KNSFONTM(A) [UIFont fontWithName:@"PingFang-SC-Medium" size:A]
#define KNSFONTB(A) [UIFont fontWithName:@"PingFang-SC-Semibold" size:A]


#define kScreen_Size [UIScreen mainScreen].bounds.size
#define kScreen_Bounds [UIScreen mainScreen].bounds
#define kScreen_Height [UIScreen mainScreen].bounds.size.height
#define kScreen_Width [UIScreen mainScreen].bounds.size.width

//#define kScreenHeight [UIScreen mainScreen].bounds.size.height
//#define kScreenWidth [UIScreen mainScreen].bounds.size.width

#define KSafeTopHeight (kScreen_Height==812.0?24:0)
#define KSafeAreaTopNaviHeight (kScreen_Height == 812.0 ? 88 : 64)
#define KSafeAreaBottomHeight (kScreen_Height == 812.0 ? 34 : 0)


/*********************** 颜色 *********************/
// rgb颜色转换（16进制->10进制）
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
// 获取RGB颜色
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)
// 随机色
#define RandomColor RGB(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

/*******************************************************      自定义       ******************************************************/
//封装计算坐标
#define Width(A) [CalculateManager calculateWidthWithNum:A]
#define Height(A) [CalculateManager calculateHeightWithNum:A]


//重写NSLog,Debug模式下打印日志和当前行数
//#if DEBUG
//#define NSLog(format, ...) do {                                             \
//fprintf(stderr, "<%s : %d> ",                                           \
//[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String],  \
//__LINE__);                                                        \
//(NSLog)((format), ##__VA_ARGS__);                                           \
//fprintf(stderr, "-------\n");                                               \
//} while (0)
//#define NSLogRect(rect) NSLog(@"%s x:%.4f, y:%.4f, w:%.4f, h:%.4f", #rect, rect.origin.x, rect.origin.y, rect.size.width, rect.size.height)
//#define NSLogSize(size) NSLog(@"%s w:%.4f, h:%.4f", #size, size.width, size.height)
//#define NSLogPoint(point) NSLog(@"%s x:%.4f, y:%.4f", #point, point.x, point.y)
//#else
//#define NSLog(FORMAT, ...) nil
//#define NSLogRect(rect) nil
//#define NSLogSize(size) nil
//#define NSLogPoint(point) nil
//#endif

#ifdef DEBUG
//#define NSLog(FORMAT, ...) fprintf(stderr, "%s:%zd\t%s\n", [[[NSString stringWithUTF8String: __FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat: FORMAT, ## __VA_ARGS__] UTF8String]);
#define NSLog(FORMAT, ...) fprintf(stderr,"%s line:%d -> %s\n", __FUNCTION__, __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#define NSLogRect(rect) NSLog(@"%s x:%.4f, y:%.4f, w:%.4f, h:%.4f", #rect, rect.origin.x, rect.origin.y, rect.size.width, rect.size.height)
#define NSLogSize(size) NSLog(@"%s w:%.4f, h:%.4f", #size, size.width, size.height)
#define NSLogPoint(point) NSLog(@"%s x:%.4f, y:%.4f", #point, point.x, point.y)

#else

#define NSLog(FORMAT, ...) nil
#define NSLogRect(rect) nil
#define NSLogSize(size) nil
#define NSLogPoint(point) nil
#endif

#if DEBUG
#define YLog(FORMAT, ...) fprintf(stderr,"%s line:%d -> %s\n", __FUNCTION__, __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define YLog(FORMAT, ...) nil
#endif

/*******************************************************      之前的       ******************************************************/
#define MYID [[NSString alloc] initWithString:[[[UIDevice currentDevice] identifierForVendor]UUIDString]]
#define TestHttp [NSString stringWithFormat:@"http://ataoh.com/"]
//#define TestHttp [NSString stringWithFormat:@"http://120.25.81.174:8093/"]
//#define TestHttp [NSString stringWithFormat:@"http://120.25.81.174:8089/"]
//#define TestHttp [NSString stringWithFormat:@"http://192.168.1.106:8085/"]
//#define TestHttp [NSString stringWithFormat:@"http://192.168.1.107:8085/"]
//#define ImageUrl [NSString stringWithFormat:@"http://union.anzimall.com/"]
//http://120.25.81.174:8089/shtml
#define ImageUrl [NSString stringWithFormat:@""]
#define LayerColor [[UIColor colorWithWhite:0.8 alpha:1.0] CGColor]
#define HeadImgUrl [NSString stringWithFormat:@"http://image.anzimall.com/"]
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#endif /* NormalHeaderFile_h */
