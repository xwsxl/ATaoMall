//
//  ProjectObjectHeader.h
//  aTaohMall
//
//  Created by DingDing on 2017/8/29.
//  Copyright © 2017年 ysy. All rights reserved.
//

#ifndef ProjectObjectHeader_h
#define ProjectObjectHeader_h

/*******************************************************      系统库       ******************************************************/
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
/*******************************************************      类目       ******************************************************/
#import "NSObject+Category.h"
#import "NSString+Extension.h"
#import "UIColor+Extension.h"
#import "UIImageView+WebCache.h"
#import "UIImage+Color.h"
#import "UILabel+Extension.h"
#import "NSDateFormatter+Category.h"
#import "UIButton+badge.h"
/*******************************************************      工具类       ******************************************************/

#import "SecretCodeTool.h"
#import "DESUtil.h"
#import "TrainToast.h"
#import "NSStringHelper.h"
#import "UIAlertTools.h"
#import "AliPayRequestTools.h"
#import "XLDateTools.h"

#import "JMSHTDBDao.h"
#import "ZZLimitInputManager.h"
//#pragma mark-网络请求
#import "ATHRequestManager.h"
#import "HTTPRequestManager.h"
#import "CalculateManager.h"
/*******************************************************      第三方库       ******************************************************/
#import "AFNetworking.h"
#import "CCNetWorkManager.h"
#import "ASIFormDataRequest.h"
#import "MJRefresh.h"
#import "MJExtension.h"
//百度api
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件
#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件
#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件
#import <BaiduMapAPI_Cloud/BMKCloudSearchComponent.h>//引入云检索功能所有的头文件
#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>//引入计算工具所有的头文件
#import <BaiduMapAPI_Radar/BMKRadarComponent.h>//引入周边雷达功能所有的头文件
#import <BaiduMapAPI_Map/BMKMapView.h>//只引入所需的单个头文件
/**/
/*******************************************************      常用复用页面    ******************************************************/
//H5说明页面
#import "RequestServiceVC.h"

/*******************************************************      之前的       ******************************************************/
#import "MBProgressHUD.h"
#import "ITDPApplication.h"
#import "AppDelegate.h"
#import "UIAlertView+AFNetworking.h"

#import "MallBaseViewController.h"
#import "ZXingObjC.h"
#import "Masonry.h"
#endif /* ProjectObjectHeader_h */
