//
//  MerchantMapViewController.h
//  aTaohMall
//
//  Created by JMSHT on 2017/3/8.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMessageComposeViewController.h>

@interface MerchantMapViewController : UIViewController

@property(nonatomic,copy)NSString *jindu;//经度

@property(nonatomic,copy)NSString *weidu;//纬度

@property(nonatomic,copy)NSString *BackString;//判断返回

@property(nonatomic,copy)NSString *AddressString;//店铺详情进入需要显示地质资料

@property(nonatomic,copy)NSString *NameString;//店铺名

@property(nonatomic,copy)NSString *LogoString;//店铺logo

@property(nonatomic,copy)NSString *TypeString;//店铺类型

@property(nonatomic,copy)NSString *LongString;//店铺距离

@property(nonatomic,copy)NSString *NewAddressString;//店铺地址

@property(nonatomic,copy)NSString *coordinates;//纬度

@property(nonatomic,copy)NSString *merchants_coordinates;//店铺经纬度

@property(nonatomic,copy)NSString *Distance;//距离

@property(nonatomic,copy)NSString *string1;//距离
@property(nonatomic,copy)NSString *string2;//距离
@property(nonatomic,copy)NSString *string3;//距离
@property(nonatomic,copy)NSString *string4;//距离
@property(nonatomic,copy)NSString *string5;//距离

@property(nonatomic,copy)NSString *Name;//店铺名

@property(nonatomic,copy)NSString *mid;//店铺Id

@property(nonatomic,copy)NSString *MMMMid;//店铺Id

@property(nonatomic,copy)NSString *MapStartAddress;//定位用户当前地址

@property(nonatomic,copy)NSString *MapEndAddress;//定位用户当前地址

@property(nonatomic,copy)NSString *TagString;//店铺Id

@property(nonatomic,copy)NSString *ImgString;//判断大头针图片

@property(nonatomic,strong) UIImageView *LogoImgView;//店铺logo

@property(nonatomic,strong) UIImageView *RedImgView;//

@property(nonatomic,strong) UIImageView *LeftImgView;

@property(nonatomic,strong) UILabel *NameLabel;

@property(nonatomic,strong) UILabel *LongLabel;

@property(nonatomic,strong) UILabel *TypeLabel;

@property(nonatomic,strong) UILabel *AddressLabel;

@property(nonatomic,strong) UIView *TabView;

@property(nonatomic,strong) UIView *TagView;

@end
