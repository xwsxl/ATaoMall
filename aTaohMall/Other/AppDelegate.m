//
//  AppDelegate.m
//  Mall
//
//  Created by DingDing on 14-12-25.
//  Copyright (c) 2014年 QJM. All rights reserved.
//


#import "AppDelegate.h"
#import "MallBaseTabBarController.h"

#import "ATHLoginViewController.h"
#import "ConverUtil.h"
#import "DESUtil.h"
#import "SecretCodeTool.h"

#import "AFNetworking.h"
/* 系统版本 */
#define SYSTEM_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
// 导航颜色
#define kNavTintClr                             kCyColorFromHex(0x0b4da2)

#import "Order.h"
#import "APAuthV2Info.h"
#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>
#import "PersonalAllDanVC.h"
#import "JRToast.h"
#import "UserMessageManager.h"

#import <AddressBook/AddressBook.h>
//＝＝＝＝＝＝＝＝＝＝ShareSDK头文件＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
//以下是ShareSDK必须添加的依赖库：
//1、libicucore.dylib
//2、libz.dylib
//3、libstdc++.dylib
//4、JavaScriptCore.framework

//＝＝＝＝＝＝＝＝＝＝以下是各个平台SDK的头文件，根据需要继承的平台添加＝＝＝
//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
//以下是腾讯SDK的依赖库：
//libsqlite3.dylib

//微信SDK头文件
#import "WXApi.h"
//以下是微信SDK的依赖库：
//libsqlite3.dylib

//新浪微博SDK头文件
#import "WeiboSDK.h"
//新浪微博SDK需要在项目Build Settings中的Other Linker Flags添加"-ObjC"
//以下是新浪微博SDK的依赖库：
//ImageIO.framework
//libsqlite3.dylib
//AdSupport.framework

//人人SDK头文件
#import <RennSDK/RennSDK.h>

//Kakao SDK头文件
#import <KakaoOpenSDK/KakaoOpenSDK.h>

//支付宝SDK
#import "APOpenAPI.h"

//易信SDK头文件
#import "YXApi.h"

#import <TencentOpenAPI/TencentOAuth.h>
//Facebook Messenger SDK
#import <FBSDKMessengerShareKit/FBSDKMessengerSharer.h>

#import "NewHomeViewController.h"//首页

#import "ClassifyViewController.h"//分类

#import "BusinessQurtViewController.h"//商圈

#import "CartViewController.h"//购物车

#import "PersonaViewController.h"//个人中心

#import "MerchantViewController.h"

#import "DetailViewController.h"

#import "AppStartADVC.h"
#import "AppStartVC.h"
#import "IQKeyboardManager.h"

#import "YTGoodsDetailViewController.h"
#import "JMSHTDBDao.h"
#import <Bugly/Bugly.h>
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
@interface AppDelegate ()<WXApiDelegate,UITabBarControllerDelegate,UISplitViewControllerDelegate,UNUserNotificationCenterDelegate>
{
    AppStartADVC *VC;
    UITabBarController *tabBarController;
    
    CartViewController *vc4;
    
}
@property (nonatomic,assign)NSInteger bedgeNum;
@end

@implementation AppDelegate



@synthesize mySigen;

//@synthesize newVC=_newVC;
//@synthesize Yangtao;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //公司用AK码：ha4WFiuoWot3MGXg0FlsqDKp
    //4MENM3ITb7je1ZoGfHrDtzlie9o4YRWy
    [JMSHTDBDao initJMSHTDataBaseDao];
    [Bugly startWithAppId:@"561c7a81b4"];
    //注册推送
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
        //iOS10特有
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        // 必须写代理，不然无法监听通知的接收与点击
        center.delegate = self;
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert | UNAuthorizationOptionBadge | UNAuthorizationOptionSound) completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (granted) {
                // 点击允许
                NSLog(@"IOS10通知注册成功");
                [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
              //      NSLog(@"%@", settings);
                }];
            } else {
                // 点击不允许
                NSLog(@"IOS10通知注册失败");
            }
        }];
    }else if ([[UIDevice currentDevice].systemVersion floatValue] >8.0){
        //iOS8 - iOS10
        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeSound | UIUserNotificationTypeBadge categories:nil]];
        
    }else if ([[UIDevice currentDevice].systemVersion floatValue] < 8.0) {
        //iOS8系统以下
        [application registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound];
    }
        
    
    // 注册获得device Token
    [[UIApplication sharedApplication] registerForRemoteNotifications];
    
    _manger = [[BMKMapManager alloc] init];
    BOOL flag = [_manger start:@"4MENM3ITb7je1ZoGfHrDtzlie9o4YRWy" generalDelegate:self];
    if (!flag) {
        NSLog(@"start error!");
    }

    IQKeyboardManager *keyboardManager = [IQKeyboardManager sharedManager]; // 获取类库的单例变量

    keyboardManager.enable = YES; // 控制整个功能是否启用

    keyboardManager.shouldResignOnTouchOutside = YES; // 控制点击背景是否收起键盘

    keyboardManager.shouldToolbarUsesTextFieldTintColor = YES; // 控制键盘上的工具条文字颜色是否用户自定义

    keyboardManager.toolbarManageBehaviour = IQAutoToolbarBySubviews; // 有多个输入框时，可以通过点击Toolbar 上的“前一个”“后一个”按钮来实现移动到不同的输入框

    keyboardManager.enableAutoToolbar = YES; // 控制是否显示键盘上的工具条

    keyboardManager.shouldShowTextFieldPlaceholder = YES; // 是否显示占位文字

    keyboardManager.placeholderFont = [UIFont boldSystemFontOfSize:17]; // 设置占位文字的字体

    keyboardManager.keyboardDistanceFromTextField = 10.0f;

    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    self.window.backgroundColor = [UIColor whiteColor];
    
    [self.window makeKeyWindow];
    
    VC=[[AppStartADVC alloc]init];
    self.window.rootViewController =VC;
   
    [UserMessageManager removeAllGoodsAttribute];
    [UserMessageManager removeAllImageSecect];
    
    [self initNavSetting];
    
    

    
    
    /**
     *  设置ShareSDK的appKey，如果尚未在ShareSDK官网注册过App，请移步到http://mob.com/login 登录后台进行应用注册，
     *  在将生成的AppKey传入到此方法中。我们Demo提供的appKey为内部测试使用，可能会修改配置信息，请不要使用。
     *  方法中的第二个参数用于指定要使用哪些社交平台，以数组形式传入。第三个参数为需要连接社交平台SDK时触发，
     *  在此事件中写入连接代码。第四个参数则为配置本地社交平台时触发，根据返回的平台类型来配置平台信息。
     *  如果您使用的时服务端托管平台信息时，第二、四项参数可以传入nil，第三项参数则根据服务端托管平台来决定要连接的社交SDK。
     */
    [ShareSDK registerApp:@"19d5784cbb7f4"
          activePlatforms:@[
                            @(SSDKPlatformTypeSinaWeibo),
                            @(SSDKPlatformTypeTencentWeibo),
                            @(SSDKPlatformTypeMail),
                            @(SSDKPlatformTypeSMS),
                            @(SSDKPlatformTypeCopy),
                            @(SSDKPlatformTypeFacebook),
                            @(SSDKPlatformTypeTwitter),
                            @(SSDKPlatformTypeWechat),
                            @(SSDKPlatformTypeQQ),
                            @(SSDKPlatformTypeDouBan),
                            @(SSDKPlatformTypeRenren),
                            @(SSDKPlatformTypeKaixin),
                            @(SSDKPlatformTypeGooglePlus),
                            @(SSDKPlatformTypePocket),
                            @(SSDKPlatformTypeInstagram),
                            @(SSDKPlatformTypeLinkedIn),
                            @(SSDKPlatformTypeTumblr),
                            @(SSDKPlatformTypeFlickr),
                            @(SSDKPlatformTypeWhatsApp),
                            @(SSDKPlatformTypeYouDaoNote),
                            @(SSDKPlatformTypeLine),
                            @(SSDKPlatformTypeYinXiang),
                            @(SSDKPlatformTypeEvernote),
                            @(SSDKPlatformTypeYinXiang),
                            @(SSDKPlatformTypeAliPaySocial),
                            @(SSDKPlatformTypePinterest),
                            @(SSDKPlatformTypeKakao),
                            @(SSDKPlatformSubTypeKakaoTalk),
                            @(SSDKPlatformSubTypeKakaoStory),
                            @(SSDKPlatformTypeDropbox),
                            @(SSDKPlatformTypeVKontakte),
                            @(SSDKPlatformTypeMingDao),
                            @(SSDKPlatformTypePrint),
                            @(SSDKPlatformTypeYiXin),
                            @(SSDKPlatformTypeInstapaper),
                            @(SSDKPlatformTypeFacebookMessenger),
                            @(SSDKPlatformTypeAliPaySocialTimeline)
                            ]
                 onImport:^(SSDKPlatformType platformType) {
                     
                     switch (platformType)
                     {
                         case SSDKPlatformTypeWechat:
                             //                             [ShareSDKConnector connectWeChat:[WXApi class]];
                             [ShareSDKConnector connectWeChat:[WXApi class] delegate:self];
                             break;
                         case SSDKPlatformTypeQQ:
                             [ShareSDKConnector connectQQ:[QQApiInterface class]
                                        tencentOAuthClass:[TencentOAuth class]];
                             break;
                         case SSDKPlatformTypeSinaWeibo:
                             [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                             break;
                         case SSDKPlatformTypeRenren:
                             [ShareSDKConnector connectRenren:[RennClient class]];
                             break;
                         case SSDKPlatformTypeKakao:
                             [ShareSDKConnector connectKaKao:[KOSession class]];
                             break;
                         case SSDKPlatformTypeAliPaySocial:
                             [ShareSDKConnector connectAliPaySocial:[APOpenAPI class]];
                             break;
                         case SSDKPlatformTypeYiXin:
                             [ShareSDKConnector connectYiXin:[YXApi class]];
                             break;
                         case SSDKPlatformTypeFacebookMessenger:
                             [ShareSDKConnector connectFacebookMessenger:[FBSDKMessengerSharer class]];
                             break;
                         default:
                             break;
                     }
                 }
          onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
              
              switch (platformType)
              {
                      //http://www.sharesdk.cn
                  case SSDKPlatformTypeSinaWeibo:
                      //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                      [appInfo SSDKSetupSinaWeiboByAppKey:@"3988885215"
                                                appSecret:@"b0be48c31722c033d1f1d6d22f35af57"
                                              redirectUri:@"http://weibo.com"
                                                 authType:SSDKAuthTypeBoth];
                      break;
                  case SSDKPlatformTypeTencentWeibo:
                      //设置腾讯微博应用信息，其中authType设置为只用Web形式授权
                      [appInfo SSDKSetupTencentWeiboByAppKey:@"801307650"
                                                   appSecret:@"ae36f4ee3946e1cbb98d6965b0b2ff5c"
                                                 redirectUri:@"http://www.sharesdk.cn"];
                      break;
                  case SSDKPlatformTypeFacebook:
                      //设置Facebook应用信息，其中authType设置为只用SSO形式授权
                      [appInfo SSDKSetupFacebookByApiKey:@"107704292745179"
                                               appSecret:@"38053202e1a5fe26c80c753071f0b573"
                                                authType:SSDKAuthTypeBoth];
                      break;
                  case SSDKPlatformTypeTwitter:
                      [appInfo SSDKSetupTwitterByConsumerKey:@"LRBM0H75rWrU9gNHvlEAA2aOy"
                                              consumerSecret:@"gbeWsZvA9ELJSdoBzJ5oLKX0TU09UOwrzdGfo9Tg7DjyGuMe8G"
                                                 redirectUri:@"http://mob.com"];
                      break;
                      //微信
                  case SSDKPlatformTypeWechat:
                      [appInfo SSDKSetupWeChatByAppId:@"wx14de8c928e80ca5f"
                                            appSecret:@"9550731eac0de82ebb3d47ae4404c069"];
                      break;
                  case SSDKPlatformTypeQQ:
                      [appInfo SSDKSetupQQByAppId:@"1105805557"
                                           appKey:@"xWjwv7HGcZy91RM5"
                                         authType:SSDKAuthTypeBoth];
                      break;
                  case SSDKPlatformTypeDouBan:
                      [appInfo SSDKSetupDouBanByApiKey:@"02e2cbe5ca06de5908a863b15e149b0b"
                                                secret:@"9f1e7b4f71304f2f"
                                           redirectUri:@"http://www.sharesdk.cn"];
                      break;
                  case SSDKPlatformTypeRenren:
                      [appInfo SSDKSetupRenRenByAppId:@"226427"
                                               appKey:@"fc5b8aed373c4c27a05b712acba0f8c3"
                                            secretKey:@"f29df781abdd4f49beca5a2194676ca4"
                                             authType:SSDKAuthTypeBoth];
                      break;
                  case SSDKPlatformTypeKaixin:
                      [appInfo SSDKSetupKaiXinByApiKey:@"358443394194887cee81ff5890870c7c"
                                             secretKey:@"da32179d859c016169f66d90b6db2a23"
                                           redirectUri:@"http://www.sharesdk.cn/"];
                      break;
                  case SSDKPlatformTypeGooglePlus:
                      
                      [appInfo SSDKSetupGooglePlusByClientID:@"232554794995.apps.googleusercontent.com"
                                                clientSecret:@"PEdFgtrMw97aCvf0joQj7EMk"
                                                 redirectUri:@"http://localhost"];
                      break;
                  case SSDKPlatformTypePocket:
                      [appInfo SSDKSetupPocketByConsumerKey:@"11496-de7c8c5eb25b2c9fcdc2b627"
                                                redirectUri:@"pocketapp1234"
                                                   authType:SSDKAuthTypeBoth];
                      break;
                  case SSDKPlatformTypeInstagram:
                      [appInfo SSDKSetupInstagramByClientID:@"ff68e3216b4f4f989121aa1c2962d058"
                                               clientSecret:@"1b2e82f110264869b3505c3fe34e31a1"
                                                redirectUri:@"http://sharesdk.cn"];
                      break;
                  case SSDKPlatformTypeLinkedIn:
                      [appInfo SSDKSetupLinkedInByApiKey:@"ejo5ibkye3vo"
                                               secretKey:@"cC7B2jpxITqPLZ5M"
                                             redirectUrl:@"http://sharesdk.cn"];
                      break;
                  case SSDKPlatformTypeTumblr:
                      [appInfo SSDKSetupTumblrByConsumerKey:@"2QUXqO9fcgGdtGG1FcvML6ZunIQzAEL8xY6hIaxdJnDti2DYwM"
                                             consumerSecret:@"3Rt0sPFj7u2g39mEVB3IBpOzKnM3JnTtxX2bao2JKk4VV1gtNo"
                                                callbackUrl:@"http://sharesdk.cn"];
                      break;
                  case SSDKPlatformTypeFlickr:
                      [appInfo SSDKSetupFlickrByApiKey:@"33d833ee6b6fca49943363282dd313dd"
                                             apiSecret:@"3a2c5b42a8fbb8bb"];
                      break;
                  case SSDKPlatformTypeYouDaoNote:
                      [appInfo SSDKSetupYouDaoNoteByConsumerKey:@"dcde25dca105bcc36884ed4534dab940"
                                                 consumerSecret:@"d98217b4020e7f1874263795f44838fe"
                                                  oauthCallback:@"http://www.sharesdk.cn/"];
                      break;
                      
                      //印象笔记分为国内版和国际版，注意区分平台
                      //设置印象笔记（中国版）应用信息
                  case SSDKPlatformTypeYinXiang:
                      
                      //设置印象笔记（国际版）应用信息
                  case SSDKPlatformTypeEvernote:
                      [appInfo SSDKSetupEvernoteByConsumerKey:@"sharesdk-7807"
                                               consumerSecret:@"d05bf86993836004"
                                                      sandbox:YES];
                      break;
                  case SSDKPlatformTypeKakao:
                      [appInfo SSDKSetupKaKaoByAppKey:@"48d3f524e4a636b08d81b3ceb50f1003"
                                           restApiKey:@"ac360fa50b5002637590d24108e6cb10"
                                          redirectUri:@"http://www.mob.com/oauth"
                                             authType:SSDKAuthTypeBoth];
                      break;
                  case SSDKPlatformTypeAliPaySocial:
                      [appInfo SSDKSetupAliPaySocialByAppId:@"2015072400185895"];
                      break;
                  case SSDKPlatformTypePinterest:
                      [appInfo SSDKSetupPinterestByClientId:@"4797078908495202393"];
                      break;
                  case SSDKPlatformTypeDropbox:
                      [appInfo SSDKSetupDropboxByAppKey:@"i5vw2mex1zcgjcj"
                                              appSecret:@"3i9xifsgb4omr0s"
                                          oauthCallback:@"https://www.sharesdk.cn"];
                      break;
                  case SSDKPlatformTypeVKontakte:
                      [appInfo SSDKSetupVKontakteByApplicationId:@"5312801"
                                                       secretKey:@"ZHG2wGymmNUCRLG2r6CY"];
                      break;
                  case SSDKPlatformTypeMingDao:
                      [appInfo SSDKSetupMingDaoByAppKey:@"EEEE9578D1D431D3215D8C21BF5357E3"
                                              appSecret:@"5EDE59F37B3EFA8F65EEFB9976A4E933"
                                            redirectUri:@"http://sharesdk.cn"];
                      break;
                  case SSDKPlatformTypeYiXin:
                      [appInfo SSDKSetupYiXinByAppId:@"yx0d9a9f9088ea44d78680f3274da1765f"
                                           appSecret:@"1a5bd421ae089c3"
                                         redirectUri:@"https://open.yixin.im/resource/oauth2_callback.html"
                                            authType:SSDKAuthTypeBoth];
                      break;
                  case SSDKPlatformTypeInstapaper:
                      [appInfo SSDKSetupInstapaperByConsumerKey:@"4rDJORmcOcSAZL1YpqGHRI605xUvrLbOhkJ07yO0wWrYrc61FA"
                                                 consumerSecret:@"GNr1GespOQbrm8nvd7rlUsyRQsIo3boIbMguAl9gfpdL0aKZWe"];
                      break;
                  default:
                      break;
              }
          }];
    
    return YES;
}

-(void)UpdateSigenAndToken
{
    NSString *sigen=[NSString stringWithFormat:@"%@",[kUserDefaults stringForKey:@"sigen"]];
    
    if ([sigen containsString:@"null"]||[sigen isEqualToString:@""]) {
        sigen=@"";
    }else
    {
        sigen=[kUserDefaults stringForKey:@"sigen"];
    }
    NSString *token=[NSString stringWithFormat:@"%@",[kUserDefaults objectForKey:@"token"]];
    if ([token isEqualToString:@"(null)"]||token.length==0) {
        return;
    }
    
    
        NSDictionary *params=@{@"sigen":sigen,@"token":token};
    
    
    
    [ATHRequestManager requestforPostTokenToServerWithParams:params successBlock:^(NSDictionary *responseObj) {
        
    } faildBlock:^(NSError *error) {
        
    }];
    
}
// 获得Device Token

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    NSString *devicetoken=[NSString  stringWithFormat:@"%@",deviceToken];
    NSLog(@"devicetoken=%@",deviceToken);
    devicetoken =[devicetoken stringByReplacingOccurrencesOfString:@"<" withString:@""];
    devicetoken =[devicetoken stringByReplacingOccurrencesOfString:@" " withString:@""];
    devicetoken =[devicetoken stringByReplacingOccurrencesOfString:@">" withString:@""];
    [KNotificationCenter addObserver:self selector:@selector(UpdateSigenAndToken) name:JMSHTLoginSuccessNoti object:nil];
    [KNotificationCenter addObserver:self selector:@selector(UpdateSigenAndToken) name:JMSHTLogOutSuccessNoti object:nil];
    NSString *oldToken=[NSString stringWithFormat:@"%@",[kUserDefaults  objectForKey:@"token"]];
    YLog(@"oldtoken=%@",oldToken);
    if ([oldToken isEqualToString:@""]||[oldToken containsString:@"null"]) {

    }else if(![oldToken isEqualToString:devicetoken])
    {
        NSDictionary *param=@{@"oldtoken":oldToken};
        [ATHRequestManager requestforDeleteTokenToServerWithParams:param successBlock:^(NSDictionary *responseObj) {

        } faildBlock:^(NSError *error) {

        }];
    }


    [kUserDefaults removeObjectForKey:@"token"];
    [kUserDefaults setObject:devicetoken forKey:@"token"];
  //  [self UpdateSigenAndToken];
    NSLog(@"token=%@", [NSString stringWithFormat:@"Device Token: %@", devicetoken]);
    
}
// 获得Device Token失败
- (void)application:(UIApplication *)application
didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

// iOS 10收到通知

- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler{
    NSDictionary * userInfo = notification.request.content.userInfo;
    UNNotificationRequest *request = notification.request; // 收到推送的请求
    UNNotificationContent *content = request.content; // 收到推送的消息内容
    NSNumber *badge = content.badge;  // 推送消息的角标
    NSString *body = content.body;    // 推送消息体
    UNNotificationSound *sound = content.sound;  // 推送消息的声音
    NSString *subtitle = content.subtitle;  // 推送消息的副标题
    NSString *title = content.title;  // 推送消息的标题
    
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        NSLog(@"iOS10 前台收到远程通知:%@", userInfo);

        
    }
    else {
        // 判断为本地通知
        NSLog(@"iOS10 前台收到本地通知:{\\\\nbody:%@，\\\\ntitle:%@,\\\\nsubtitle:%@,\\\\nbadge：%@，\\\\nsound：%@，\\\\nuserInfo：%@\\\\n}",body,title,subtitle,badge,sound,userInfo);
    }
    completionHandler(UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以设置
}
// 通知的点击事件
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)())completionHandler{
    
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    UNNotificationRequest *request = response.notification.request; // 收到推送的请求
    UNNotificationContent *content = request.content; // 收到推送的消息内容
    NSNumber *badge = content.badge;  // 推送消息的角标
    NSString *body = content.body;    // 推送消息体
    UNNotificationSound *sound = content.sound;  // 推送消息的声音
    NSString *subtitle = content.subtitle;  // 推送消息的副标题
    NSString *title = content.title;  // 推送消息的标题
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        NSLog(@"iOS10 收到远程通知:%@", userInfo);
        
//        NSNotification *noti=[[NSNotification alloc]initWithName:JMSHTReceivePushNoti object:nil userInfo:userInfo];
//        [KNotificationCenter postNotification:noti];
        [KNotificationCenter postNotificationName:JMSHTReceivePushNoti object:nil userInfo:userInfo];
    }
    else {
        // 判断为本地通知
        NSLog(@"iOS10 收到本地通知:{\\\\nbody:%@，\\\\ntitle:%@,\\\\nsubtitle:%@,\\\\nbadge：%@，\\\\nsound：%@，\\\\nuserInfo：%@\\\\n}",body,title,subtitle,badge,sound,userInfo);
    }
    if (!_bedgeNum) {
        _bedgeNum=0;
    }
    if (_bedgeNum>0) {
        _bedgeNum--;
    }
    // Warning: UNUserNotificationCenter delegate received call to -userNotificationCenter:didReceiveNotificationResponse:withCompletionHandler: but the completion handler was never called.
    completionHandler();  // 系统要求执行这个方法
    
}


- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo
fetchCompletionHandler:
(void (^)(UIBackgroundFetchResult))completionHandler {
    
//    NSNotification *noti=[[NSNotification alloc]initWithName:JMSHTReceivePushNoti object:nil userInfo:userInfo];
//    [KNotificationCenter postNotification:noti];
    NSLog(@"iOS7及以上系统，收到通知:%@",userInfo);
    NSLog(@"debug");
    
    NSDictionary *dic = userInfo[@"parm"];
    NSLog(@"========推送消息==%@",dic);
    if (!_bedgeNum) {
        _bedgeNum=0;
    }
    self.bedgeNum++;

       NSString *msgid=[NSString stringWithFormat:@"%@",dic[@"pid"]];
    if ([dic[@"type"] isEqualToString:@"1"]) {

            NSDictionary *param =@{@"id":msgid};
            [ATHRequestManager requestForMessageListSystemMsgWithParams:param successBlock:^(NSDictionary *responseObj) {
                NSLog(@"存储消息%@",responseObj);
                NSArray *tempArr=responseObj[@"list"];
                for (NSDictionary *dic in tempArr) {
                    MessageListModel *model=[MessageListModel new];
                    model.content=[NSString stringWithFormat:@"%@",dic[@"content"]];
                    model.gid=[NSString stringWithFormat:@"%@",dic[@"gid"]];
                    model.ID=[NSString stringWithFormat:@"%@",dic[@"id"]];
                    model.title=[NSString stringWithFormat:@"%@",dic[@"title"]];
                    model.sysdate=[NSString stringWithFormat:@"%@",dic[@"sysdate"]];
                    model.is_browse=[NSString stringWithFormat:@"1"];
                    [JMSHTDBDao insertMessageIntoMessageListWith:model];
                }
            } faildBlock:^(NSError *error) {
                
            }];
    }else if([dic[@"type"] isEqualToString:@"2"])
    {
        NSDictionary *params=@{@"is_push":@0,@"id":msgid,@"type":@2};
        [ATHRequestManager requestforAppUpdatePushTriggerInfoWithParams:params successBlock:^(NSDictionary *responseObj) {
            NSLog(@"存储消息%@",responseObj);
            NSArray *tempArr=responseObj[@"list"];
            for (NSDictionary *dic in tempArr) {
                NSString *sysType=[NSString stringWithFormat:@"%@",dic[@"sys_type"]];
                
                if ([sysType isEqualToString:@"0"]) {
                MessageListModel *model=[MessageListModel new];
                model.content=[NSString stringWithFormat:@"%@",dic[@"content"]];
                model.gid=[NSString stringWithFormat:@"%@",dic[@"gid"]];
                model.ID=[NSString stringWithFormat:@"%@",dic[@"id"]];
                model.title=[NSString stringWithFormat:@"%@",dic[@"title"]];
                model.sysdate=[NSString stringWithFormat:@"%@",dic[@"sysdate"]];
                model.is_browse=[NSString stringWithFormat:@"1"];
                [JMSHTDBDao insertMessageIntoMessageListWith:model];
                    
                }
            }
        } faildBlock:^(NSError *error) {
            
        }];
    }
    
    completionHandler(UIBackgroundFetchResultNewData);
}
- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forLocalNotification:(UILocalNotification *)notification completionHandler:(void(^)())completionHandler NS_AVAILABLE_IOS(8_0);
{
    NSLog(@"d点击本地通知");
}
- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void(^)())completionHandler NS_AVAILABLE_IOS(8_0);
{
    NSLog(@"点击通知栏通知");
}

//自动登录
-(void)autoLogin
{
    
    if ([kUserDefaults objectForKey:@"new"]!=nil&&[kUserDefaults objectForKey:@"password"]!=nil) {
    
    
    NSString *account=[NSString stringWithFormat:@"%@",[kUserDefaults objectForKey:@"new"]];
    NSString *password=[NSString stringWithFormat:@"%@",[kUserDefaults objectForKey:@"password"]];
    NSLog(@"acc=%@=========pass=%@",account,password);
    
    if (account.length>0&&password.length>0) {
        NSDictionary *dic=@{@"phone":[kUserDefaults objectForKey:@"new"],@"password":[kUserDefaults objectForKey:@"password"]};
        [ATHRequestManager requestforMineLogInWithParams:dic successBlock:^(NSDictionary *responseObj) {
            
            for (NSDictionary *dic in responseObj) {
            if ([[NSString stringWithFormat:@"%@",dic[@"status"]] isEqualToString:@"10000"]) {
                NSNull *null=[[NSNull alloc]init];
                //缓存用户sigen'
                [UserMessageManager UserSigen:dic[@"sigen"]];
                //缓存手机号
                if (![dic[@"phone"] isEqual:null]) {
                    
                    [UserMessageManager UserPhone:dic[@"phone"]];
                }
                //缓存用户积分
                [UserMessageManager UserInteger:dic[@"integral"]];
                [UserMessageManager LoginNumber:dic[@"status"]];
                if ([dic[@"portrait"] isEqual:null] || [dic[@"portrait"] isEqualToString:@""]) {
                    //缓存头像
                    [UserMessageManager UserHeaderImage:@"头像"];
                }else{
                    
                    //缓存头像
                    [UserMessageManager UserHeaderImage:dic[@"portrait"]];
                }
                //缓存userid
                [UserMessageManager UserId:dic[@"userid"]];
            }else
            {
                
                [UserMessageManager removeAllArray];
                [UserMessageManager LoginStatus:@"NO"];
           
            }
            }
        } faildBlock:^(NSError *error) {
            //登录失败发送通知
            [UserMessageManager removeAllArray];
            [UserMessageManager LoginStatus:@"NO"];
           
        }];
    }
    else
    {
            //登录失败发送通知
           [UserMessageManager removeAllArray];
           [UserMessageManager LoginStatus:@"NO"];
    }
    }
    [self SetTabbarController];
}
//获取购物车件数
-(void)SetTabbarController
{
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    
    self.sigen = [userDefaultes stringForKey:@"sigen"];
    
    if (self.sigen.length > 0) {
        
        [HTTPRequestManager POST:@"getShoppingSum_mob.shtml" NSDictWithString:@{@"sigen":self.sigen} parameters:nil result:^(id responseObj, NSError *error) {
            
            
          //  NSLog(@"==获取购物车件数==%@===",responseObj);
            
            if (responseObj) {
                
                
                if ([responseObj[@"status"] isEqualToString:@"10000"]) {
                    
                    
                    if ([responseObj[@"goods_sum"] isEqualToString:@"0"]) {
                        
                        
                    }else{
                        
                        self.CartString = responseObj[@"goods_sum"];
                        
                        [UserMessageManager AppDelegateCartNumber:responseObj[@"goods_sum"]];
                        
                        
                    }
                    
                }
            
            }else{
                
                
                NSLog(@"error");
                
            }
            
            
        }];
        
        
        NewHomeViewController *vc1=[[NewHomeViewController alloc] init];
        UINavigationController *nav1=[[UINavigationController alloc] initWithRootViewController:vc1];
        
        ClassifyViewController *vc2=[[ClassifyViewController alloc] init];
        UINavigationController *nav2=[[UINavigationController alloc] initWithRootViewController:vc2];
        
//        MerchantViewController *vc3=[[MerchantViewController alloc] init];
//        UINavigationController *nav3=[[UINavigationController alloc] initWithRootViewController:vc3];
        
        vc4=[[CartViewController alloc] init];
        UINavigationController *nav4=[[UINavigationController alloc] initWithRootViewController:vc4];
        
        PersonaViewController *vc5=[[PersonaViewController alloc] init];
        UINavigationController *nav5=[[UINavigationController alloc] initWithRootViewController:vc5];
        
        vc1.tabBarItem=[[UITabBarItem alloc] initWithTitle:@"首页" image:[UIImage imageNamed:@"首页111"] selectedImage:[UIImage imageNamed:@"首页选中413"]];
        
        vc2.tabBarItem=[[UITabBarItem alloc] initWithTitle:@"分类" image:[UIImage imageNamed:@"分类111-"] selectedImage:[UIImage imageNamed:@"分类选中413"]];
        
    //    vc3.tabBarItem=[[UITabBarItem alloc] initWithTitle:@"商户" image:[UIImage imageNamed:@"商户413"] selectedImage:[UIImage imageNamed:@"商户选中413"]];
        
        vc4.tabBarItem=[[UITabBarItem alloc] initWithTitle:@"购物车" image:[UIImage imageNamed:@"购物车666"] selectedImage:[UIImage imageNamed:@"购物车-选中413"]];
         vc5.tabBarItem=[[UITabBarItem alloc] initWithTitle:@"我的" image:[UIImage imageNamed:@"我的111"] selectedImage:[UIImage imageNamed:@"我的选中413"]];
        
        if ([userDefaultes stringForKey:@"appdelegateCartNumber"].length==0 || [[userDefaultes stringForKey:@"appdelegateCartNumber"] isEqualToString:@"0"]) {
            
            vc4.tabBarItem.badgeValue = nil;
            
        }else{
            
            vc4.tabBarItem.badgeValue = [userDefaultes stringForKey:@"appdelegateCartNumber"];
            
        }
        
        
        NSLog(@"*****5555****%@",[userDefaultes stringForKey:@"appdelegateCartNumber"]);
        
        NSLog(@"*****6666****%@",self.CartString);
        
       
        
        
        tabBarController=[[UITabBarController alloc] init];
        tabBarController.viewControllers=@[nav1,nav2,nav4,nav5];
        //改变TabBar的默认颜色
        tabBarController.tabBar.tintColor=[UIColor colorWithRed:255/255.0 green:91/255.0 blue:94/255.0 alpha:1.0];
        
        self.window.rootViewController=tabBarController;
        
        
    }else{
        
        
        
        NewHomeViewController *vc1=[[NewHomeViewController alloc] init];
        UINavigationController *nav1=[[UINavigationController alloc] initWithRootViewController:vc1];
        
        ClassifyViewController *vc2=[[ClassifyViewController alloc] init];
        UINavigationController *nav2=[[UINavigationController alloc] initWithRootViewController:vc2];
        
//        MerchantViewController *vc3=[[MerchantViewController alloc] init];
//        UINavigationController *nav3=[[UINavigationController alloc] initWithRootViewController:vc3];
        
        vc4=[[CartViewController alloc] init];
        UINavigationController *nav4=[[UINavigationController alloc] initWithRootViewController:vc4];
        
        PersonaViewController *vc5=[[PersonaViewController alloc] init];
        UINavigationController *nav5=[[UINavigationController alloc] initWithRootViewController:vc5];
        
        vc1.tabBarItem=[[UITabBarItem alloc] initWithTitle:@"首页" image:[UIImage imageNamed:@"首页111"] selectedImage:[UIImage imageNamed:@"首页选中413"]];
        
        vc2.tabBarItem=[[UITabBarItem alloc] initWithTitle:@"分类" image:[UIImage imageNamed:@"分类111-"] selectedImage:[UIImage imageNamed:@"分类选中413"]];
        
    //    vc3.tabBarItem=[[UITabBarItem alloc] initWithTitle:@"商户" image:[UIImage imageNamed:@"商户413"] selectedImage:[UIImage imageNamed:@"商户选中413"]];
        
        vc4.tabBarItem=[[UITabBarItem alloc] initWithTitle:@"购物车" image:[UIImage imageNamed:@"购物车666"] selectedImage:[UIImage imageNamed:@"购物车-选中413"]];
        
        vc5.tabBarItem=[[UITabBarItem alloc] initWithTitle:@"我的" image:[UIImage imageNamed:@"我的111"] selectedImage:[UIImage imageNamed:@"我的选中413"]];
        
        
        tabBarController=[[UITabBarController alloc] init];
        tabBarController.viewControllers=@[nav1,nav2,nav4,nav5];
        //改变TabBar的默认颜色

        tabBarController.tabBar.tintColor=[UIColor colorWithRed:255/255.0 green:91/255.0 blue:94/255.0 alpha:1.0];
        //tabBarController.tabBar.tintColor=[UIColor whiteColor];
        self.window.rootViewController=tabBarController;
        
    }
    
}


-(void)onResp:(BaseResp *)resp
{
    NSLog(@"The response of wechat.");
}


-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options
{
    
    
    
    if ([url.host isEqualToString:@"safepay"]) {
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url
                                                  standbyCallback:^(NSDictionary *resultDic) {
                                                      NSLog(@"result = %@====%@",resultDic,resultDic[@"resultStatus"]);
                                                      
                                                      //立即购买跳确认订单
                                                      NSDictionary *dict1 =[[NSDictionary alloc] initWithObjectsAndKeys:resultDic[@"resultStatus"],@"resultStatus", nil];
                                                      
                                                      
                                                      NSNotification *notification1 = [[NSNotification alloc] initWithName:@"resultStatus" object:nil userInfo:dict1];
                                                      
                                                      //通过通知中心发送通知
                                                      [[NSNotificationCenter defaultCenter] postNotification:notification1];

                                                      
                                                      
                                                  }]; }
    
    
    return YES;
}



//
#pragma mark - 百度地图引擎回调
- (void)onGetNetworkState:(int)iError
{
    if (0 == iError) {
        //NSLog(@"联网成功");
    }else{
        NSLog(@"onGetNetworkState %d",iError);
    }
}

- (void)onGetPermissionState:(int)iError
{
    if (0 == iError) {
        // 引擎启动成功 才能使用Baidu地图
        //NSLog(@"授权成功");
    }else {
        NSLog(@"onGetPermissionState %d",iError);
    }
}




- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
    NSLog(@"applicationWillResignActive");
    
    
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    NSLog(@"applicationDidEnterBackground");
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
    NSLog(@"applicationWillEnterForeground");
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    //活跃状态
    NSLog(@"applicationDidBecomeActive");
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
    NSLog(@"applicationWillTerminate");
    
}



#pragma mark - private method
- (void)initNavSetting
{
    //导航背景颜色
    if (SYSTEM_VERSION >= 8.0) {
        CLLocationManager *locationManager = [[CLLocationManager alloc] init];
        //获取授权认证
//        [locationManager requestAlwaysAuthorization];
        [locationManager requestWhenInUseAuthorization];
    }
    
    if (SYSTEM_VERSION >= 7.0) {
        
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
//        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
//        [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:251/255.0 green:67/255.0 blue:76/255.0 alpha:1.0]];
        
        [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
        
    } else {
        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"nav_bg"] forBarMetrics:UIBarMetricsDefault];
        
    }
    
    //标题颜色
    NSDictionary *selectedState = @{NSForegroundColorAttributeName : [UIColor blackColor]};
    [[UINavigationBar appearance] setTitleTextAttributes:selectedState];
}


#pragma mark - Split view

- (BOOL)splitViewController:(UISplitViewController *)splitViewController collapseSecondaryViewController:(UIViewController *)secondaryViewController ontoPrimaryViewController:(UIViewController *)primaryViewController {
    if ([secondaryViewController isKindOfClass:[UINavigationController class]] && [[(UINavigationController *)secondaryViewController topViewController] isKindOfClass:[DetailViewController class]] && ([(DetailViewController *)[(UINavigationController *)secondaryViewController topViewController] detailItem] == nil)) {
        // Return YES to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
        return YES;
    } else {
        return NO;
    }
}

-(void)setBedgeNum:(NSInteger)bedgeNum
{
    _bedgeNum=bedgeNum;
    [[UIApplication sharedApplication]setApplicationIconBadgeNumber:_bedgeNum];
}
@end
