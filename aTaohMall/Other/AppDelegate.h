//
//  AppDelegate.h
//  Mall
//
//  Created by DingDing on 14-12-25.
//  Copyright (c) 2014年 QJM. All rights reserved.
//




#import <UIKit/UIKit.h>
#import "ITDPApplication.h"
#import <BaiduMapAPI_Base/BMKMapManager.h>//只引入所需的单个头文件
#import <BaiduMapAPI_Base/BMKGeneralDelegate.h>

#import "NewGoodsDetailViewController.h"//商品详情

@interface AppDelegate : UIResponder <UIApplicationDelegate,BMKGeneralDelegate>{
    
    //百度地图引擎
    
    BMKMapManager* _manger;
    
    
    NSString *mySigen;
    
    
}

@property (nonatomic,retain) NSString *mySigen;

//@property (nonatomic,retain) NewGoodsDetailViewController *newVC;
@property (nonatomic,retain) NSString *Yangtao;

@property (nonatomic,copy) NSString *myPhone;
@property (nonatomic,copy) NSString *myPassword;
@property (nonatomic,copy) NSString *myPhoto;
@property (nonatomic,copy) NSString *myIntegral;
@property (nonatomic,copy) NSString *myKey;
@property (nonatomic,copy) NSString *myUserid;

@property (nonatomic,copy) NSString *TypeString;

@property (nonatomic,copy) NSString *CartString;

@property (nonatomic,copy) NSString *sigen;

@property (nonatomic,copy) NSString *dingdanhao;  //临时

@property (nonatomic,strong) NSData *imagedata;


@property (strong, nonatomic) UIWindow *window;


@end

