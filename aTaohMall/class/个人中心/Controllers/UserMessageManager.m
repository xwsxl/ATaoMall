//
//  UserMessageManager.m
//  aTaohMall
//
//  Created by JMSHT on 16/6/2.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import "UserMessageManager.h"

@implementation UserMessageManager

//缓存用户名
+(void)UserName:(NSString *)name
{
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
//    NSString *str=[userDefaultes stringForKey:@"myArray"];
    
    [userDefaultes setObject:name forKey:@"myName"];
    [userDefaultes synchronize];
}

//缓存用户名
+(void)UserNewName:(NSString *)newName{
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //    NSString *str=[userDefaultes stringForKey:@"myArray"];
    
    [userDefaultes setObject:newName forKey:@"new"];
    [userDefaultes synchronize];
}

//缓存密码
+(void)UserPassWord:(NSString *)password
{
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    [userDefaultes setObject:password forKey:@"password"];
    [userDefaultes synchronize];
}

//缓存手机
+(void)UserPhone:(NSString *)phone
{
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        [userDefaultes setObject:phone forKey:@"phone"];
        [userDefaultes synchronize];
    
}

//缓存sigen
+(void)UserSigen:(NSString *)sigen
{
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    [userDefaultes setObject:sigen forKey:@"sigen"];
    [userDefaultes synchronize];
}

//缓存用户留言
+(void)UserWord:(NSString *)userWord
{
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    [userDefaultes setObject:userWord forKey:@"userWord"];
    [userDefaultes synchronize];
}

//缓存用户头像
+(void)UserHeaderImage:(NSString *)portrait
{
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    [userDefaultes setObject:portrait forKey:@"header"];
    [userDefaultes synchronize];
}

//缓存登录次数
+(void)UserTime:(NSString *)time
{
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    [userDefaultes setObject:time forKey:@"time"];
    [userDefaultes synchronize];
}

//缓存用户id
+(void)UserId:(NSString *)userid
{
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    [userDefaultes setObject:userid forKey:@"userid"];
    [userDefaultes synchronize];
}

//缓存分类查看全部id
+(void)ClassifyId:(NSString *)classifyId
{
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    [userDefaultes setObject:classifyId forKey:@"classifyId"];
    [userDefaultes synchronize];
}

//缓存排序类型type
+(void)SortType:(NSString *)type
{
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    [userDefaultes setObject:type forKey:@"type"];
    [userDefaultes synchronize];
}

//缓存登录状态
+(void)LoginStatus:(NSString *)status
{
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    [userDefaultes setObject:status forKey:@"status"];
    [userDefaultes synchronize];
}

//缓存用户积分
+(void)UserInteger:(NSString *)integer
{
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    [userDefaultes setObject:integer forKey:@"integer"];
    [userDefaultes synchronize];
}

//缓存登录返回值
+(void)LoginNumber:(NSString *)number
{
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    [userDefaultes setObject:number forKey:@"number"];
    [userDefaultes synchronize];
}

//缓存回显
+(void)AttibuteBackShow:(NSString *)backshow
{
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    [userDefaultes setObject:backshow forKey:@"backshow"];
    [userDefaultes synchronize];
}

+(void)SaveShenJi:(NSString *)shenji
{
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    [userDefaultes setObject:shenji forKey:@"shenji"];
    [userDefaultes synchronize];
    
}


+(void)FenLeiStore:(NSString *)fenleistore
{
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    [userDefaultes setObject:fenleistore forKey:@"fenleistore"];
    [userDefaultes synchronize];
}
//缓存最大值
+(void)FenLeiMax:(NSString *)fenleimax
{
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    [userDefaultes setObject:fenleimax forKey:@"fenleimax"];
    [userDefaultes synchronize];
}
//缓存最小值
+(void)FenLeiMin:(NSString *)fenleimin
{
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    [userDefaultes setObject:fenleimin forKey:@"fenleimin"];
    [userDefaultes synchronize];
}

+(void)FenLeiRemove
{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:@"fenleistore"];
    [userDefaults removeObjectForKey:@"fenleimax"];
    [userDefaults removeObjectForKey:@"fenleimin"];
    [userDefaults synchronize];
    
}

+(void)RemoveFenLeiMax
{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:@"fenleimax"];
    [userDefaults synchronize];
}
+(void)RemoveFenLeiMin
{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:@"fenleimin"];
    [userDefaults synchronize];
    
}

+(void)removeShenJi
{
    
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:@"shenji"];
    [userDefaults synchronize];
}

//清除缓存数组
+(void)removeAllArray
{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:@"myArray"];
    [userDefaults removeObjectForKey:@"number"];
    [userDefaults removeObjectForKey:@"integer"];
    [userDefaults removeObjectForKey:@"status"];
    [userDefaults removeObjectForKey:@"userid"];
    [userDefaults removeObjectForKey:@"header"];
    [userDefaults removeObjectForKey:@"phone"];
//    [userDefaults removeObjectForKey:@"myName"];
    [userDefaults removeObjectForKey:@"password"];
    [userDefaults removeObjectForKey:@"new"];
    [userDefaults removeObjectForKey:@"sigen"];
    [userDefaults synchronize];
}

//缓存用户限购商品买了多少件
+(void)UserBuyDoods:(NSString *)num
{
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    [userDefaultes setObject:num forKey:@"num"];
    [userDefaultes synchronize];
}

//缓存颜色
+(void)GoodsColor:(NSString *)color
{
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    [userDefaultes setObject:color forKey:@"color"];
    [userDefaultes synchronize];
}

//缓存尺寸
+(void)GoodsSize:(NSString *)size
{
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    [userDefaultes setObject:size forKey:@"size"];
    [userDefaultes synchronize];
}

//缓存风格
+(void)GoodsStyle:(NSString *)style
{
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    [userDefaultes setObject:style forKey:@"style"];
    [userDefaultes synchronize];
}


//商品属性记录件数
+(void)RemberAttributeNumber:(NSString *)rember
{
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    [userDefaultes setObject:rember forKey:@"rember"];
    [userDefaultes synchronize];
}
//缓存面料
+(void)GoodsMianLiao:(NSString *)mianliao
{
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    [userDefaultes setObject:mianliao forKey:@"mianliao"];
    [userDefaultes synchronize];
}


//缓存颜色
+(void)GoodsColor1:(NSString *)color
{
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    [userDefaultes setObject:color forKey:@"color1"];
    [userDefaultes synchronize];
    
}

//缓存尺寸
+(void)GoodsSize1:(NSString *)size
{
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    [userDefaultes setObject:size forKey:@"size1"];
    [userDefaultes synchronize];
    
}

//缓存风格
+(void)GoodsStyle1:(NSString *)style
{
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    [userDefaultes setObject:style forKey:@"style1"];
    [userDefaultes synchronize];
}

//缓存面料
+(void)GoodsMianLiao1:(NSString *)mianliao
{
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    [userDefaultes setObject:mianliao forKey:@"mianliao1"];
    [userDefaultes synchronize];
}


//缓存颜色（购物车进商品详情再缓存）
+(void)GoodsColor2:(NSString *)color
{
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    [userDefaultes setObject:color forKey:@"color2"];
    [userDefaultes synchronize];
    
}

//缓存尺寸（购物车进商品详情再缓存）
+(void)GoodsSize2:(NSString *)size
{
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    [userDefaultes setObject:size forKey:@"size2"];
    [userDefaultes synchronize];
}

//缓存风格（购物车进商品详情再缓存）
+(void)GoodsStyle2:(NSString *)style
{
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    [userDefaultes setObject:style forKey:@"style2"];
    [userDefaultes synchronize];
}

//缓存面料（购物车进商品详情再缓存）
+(void)GoodsMianLiao2:(NSString *)mianliao
{
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    [userDefaultes setObject:mianliao forKey:@"mianliao2"];
    [userDefaultes synchronize];
    
}

//删除再次缓存
+(void)RemoveHuanCunAgain
{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:@"color2"];
    [userDefaults removeObjectForKey:@"size2"];
    [userDefaults removeObjectForKey:@"style2"];
    [userDefaults removeObjectForKey:@"mianliao2"];
    [userDefaults synchronize];
}



//缓存所选商品规格
+(void)HuanCunShangPinGuiGe:(NSString *)guige
{
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    [userDefaultes setObject:guige forKey:@"guige"];
    [userDefaultes synchronize];
    
}
//清除用户留言
+(void)removeUserWord
{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:@"userWord"];
    [userDefaults synchronize];
    
}

//图文详情缓存商品规格
+(void)TuWen:(NSString *)tuwen
{
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    [userDefaultes setObject:tuwen forKey:@"tuwen"];
    [userDefaultes synchronize];
    
}
//缓存默认商品属性
+(void)MoRen:(NSString *)moren
{
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    [userDefaultes setObject:moren forKey:@"moren"];
    [userDefaultes synchronize];
    
}

//缓存已选属性组合的库存
+(void)HuanCunShuXingStock:(NSString *)HuanCunShuXingStock
{
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    [userDefaultes setObject:HuanCunShuXingStock forKey:@"HuanCunShuXingStock"];
    [userDefaultes synchronize];
}
//删除所有属性
+(void)removeAllGoodsAttribute
{
    
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:@"color"];
    [userDefaults removeObjectForKey:@"size"];
    [userDefaults removeObjectForKey:@"style"];
    [userDefaults removeObjectForKey:@"mianliao"];
    [userDefaults removeObjectForKey:@"jianshu"];
    [userDefaults removeObjectForKey:@"rember"];
    [userDefaults removeObjectForKey:@"color1"];
    [userDefaults removeObjectForKey:@"size1"];
    [userDefaults removeObjectForKey:@"style1"];
    [userDefaults removeObjectForKey:@"mianliao1"];
    [userDefaults removeObjectForKey:@"string"];
    [userDefaults removeObjectForKey:@"string1"];
    [userDefaults removeObjectForKey:@"string5"];
    [userDefaults removeObjectForKey:@"string6"];
    [userDefaults removeObjectForKey:@"text"];
    [userDefaults removeObjectForKey:@"guige"];
    [userDefaults removeObjectForKey:@"tuwen"];
    [userDefaults removeObjectForKey:@"backshow"];
    [userDefaults removeObjectForKey:@"selectSendWay"];
    [userDefaults removeObjectForKey:@"HuanCunShuXingStock"];
    [userDefaults removeObjectForKey:@"moren"];
    [userDefaults synchronize];
}

+(void)removeYYYTTT
{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:@"color"];
    [userDefaults removeObjectForKey:@"size"];
    [userDefaults removeObjectForKey:@"style"];
    [userDefaults removeObjectForKey:@"mianliao"];
    [userDefaults removeObjectForKey:@"jianshu"];
    [userDefaults removeObjectForKey:@"rember"];
    [userDefaults removeObjectForKey:@"color1"];
    [userDefaults removeObjectForKey:@"size1"];
    [userDefaults removeObjectForKey:@"style1"];
    [userDefaults removeObjectForKey:@"mianliao1"];
    [userDefaults removeObjectForKey:@"string"];
    [userDefaults removeObjectForKey:@"string1"];
    [userDefaults removeObjectForKey:@"string5"];
    [userDefaults removeObjectForKey:@"string6"];
    [userDefaults removeObjectForKey:@"text"];
    [userDefaults removeObjectForKey:@"guige"];
    [userDefaults removeObjectForKey:@"backshow"];
    [userDefaults removeObjectForKey:@"shuxingstring"];
    [userDefaults removeObjectForKey:@"selectSendWay"];
    [userDefaults synchronize];
    
}

//记录用户选择的配送方式
+(void)SelectSendWay:(NSString *)selectSendWay
{
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    [userDefaultes setObject:selectSendWay forKey:@"selectSendWay"];
    [userDefaultes synchronize];
}

//商品属性数量

+(void)GoodsNumber:(NSString *)jianshu
{
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    [userDefaultes setObject:jianshu forKey:@"jianshu"];
    [userDefaultes synchronize];
}


//缓存勾选状态
+(void)GoodsImageSecect:(NSString *)gouxuan
{
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    [userDefaultes setObject:gouxuan forKey:@"gouxuan"];
    [userDefaultes synchronize];
    
}


//缓存购物车件数
+(void)AppDelegateCartNumber:(NSString *)appdelegateCartNumber
{
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    [userDefaultes setObject:appdelegateCartNumber forKey:@"appdelegateCartNumber"];
    [userDefaultes synchronize];
    
}

//清楚购物车缓存件数
+(void)DeleteAppDelegateCartNumber
{
    
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:@"appdelegateCartNumber"];
    [userDefaults synchronize];
}

//购物车没修改属性完成，再次缓存属性
+(void)ShuXingAgain:(NSString *)again
{
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    [userDefaultes setObject:again forKey:@"again"];
    [userDefaultes synchronize];
    
}
//清楚再次缓存
+(void)RemoveAgain
{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:@"again"];
    [userDefaults synchronize];
}


//删除勾选状态
+(void)removeAllImageSecect
{
    
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:@"gouxuan"];
    [userDefaults synchronize];
}

//清除颜色缓存
+(void)removeColor
{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:@"color"];
    [userDefaults synchronize];
    
}

//购物车修改属性缓存值，来判断属性框的高度
+(void)Height:(NSString *)height
{
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    [userDefaultes setObject:height forKey:@"height"];
    [userDefaultes synchronize];
    
}


//缓存返回的界面
+(void)CartBack:(NSString *)cartback;
{
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    [userDefaultes setObject:cartback forKey:@"cartback"];
    [userDefaultes synchronize];
    
}

//去除返回界面缓存
+(void)RemoveCartBack
{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:@"cartback"];
    [userDefaults synchronize];
    
}

//删除缓存高度
+(void)RemoveHeight
{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:@"height"];
    [userDefaults synchronize];
    
}
+(void)YTText:(NSString *)text
{
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    [userDefaultes setObject:text forKey:@"text"];
    [userDefaultes synchronize];
    
    
}
+(void)ShuXingString:(NSString *)shuxingstring
{
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    [userDefaultes setObject:shuxingstring forKey:@"shuxingstring"];
    [userDefaultes synchronize];
}

+(void)RemoveShuXingString
{
    
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:@"shuxingstring"];
    [userDefaults synchronize];
}

+(void)YTString:(NSString *)string
{
    
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:@"string"];
    [userDefaults synchronize];
}

+(void)YTString1:(NSString *)string1
{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:@"string1"];
    [userDefaults synchronize];
}

+(void)YTString5:(NSString *)string5
{
    
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:@"string5"];
    [userDefaults synchronize];
}

+(void)YTString6:(NSString *)string6
{
    
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:@"string6"];
    [userDefaults synchronize];
}

//清除尺寸缓存
+(void)removeSize
{
    
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:@"size"];
    [userDefaults synchronize];
}
//清除风格缓存
+(void)removeStyle
{
    
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:@"style"];
    [userDefaults synchronize];
}
//清除面料缓存
+(void)removeMianLiao
{
    
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:@"mianliao"];
    [userDefaults synchronize];
}
@end
