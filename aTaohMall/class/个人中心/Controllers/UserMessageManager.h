//
//  UserMessageManager.h
//  aTaohMall
//
//  Created by JMSHT on 16/6/2.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserMessageManager : NSObject

//缓存用户名
+(void)UserName:(NSString *)name;

//缓存用户名
+(void)UserNewName:(NSString *)newName;

//缓存用户密码
+(void)UserPassWord:(NSString *)password;

//缓存手机
+(void)UserPhone:(NSString *)phone;

//缓存用户头像
+(void)UserHeaderImage:(NSString *)portrait;

//缓存sigen
+(void)UserSigen:(NSString *)sigen;

//缓存登录次数
+(void)UserTime:(NSString *)time;

//缓存用户积分
+(void)UserInteger:(NSString *)integer;

//缓存用户id
+(void)UserId:(NSString *)userid;

//缓存用户留言
+(void)UserWord:(NSString *)userWord;

//缓存分类查看全部id
+(void)ClassifyId:(NSString *)classifyId;

//缓存用户是否升级

+(void)SaveShenJi:(NSString *)shenji;

+(void)removeShenJi;

//缓存排序类型type
+(void)SortType:(NSString *)type;

//缓存登录状态
+(void)LoginStatus:(NSString *)status;

//缓存登录返回值
+(void)LoginNumber:(NSString *)number;

//清除缓存数组
+(void)removeAllArray;

//清除用户留言
+(void)removeUserWord;

//删除所有属性
+(void)removeAllGoodsAttribute;

//缓存用户限购商品买了多少件
+(void)UserBuyDoods:(NSString *)num;

//缓存颜色
+(void)GoodsColor:(NSString *)color;

//缓存尺寸
+(void)GoodsSize:(NSString *)size;

//缓存风格
+(void)GoodsStyle:(NSString *)style;

//缓存面料
+(void)GoodsMianLiao:(NSString *)mianliao;

//缓存颜色
+(void)GoodsColor1:(NSString *)color;

//缓存尺寸
+(void)GoodsSize1:(NSString *)size;

//缓存回显
+(void)AttibuteBackShow:(NSString *)backshow;

//缓存风格
+(void)GoodsStyle1:(NSString *)style;

//缓存面料
+(void)GoodsMianLiao1:(NSString *)mianliao;


//缓存颜色（购物车进商品详情再缓存）
+(void)GoodsColor2:(NSString *)color;

//缓存尺寸（购物车进商品详情再缓存）
+(void)GoodsSize2:(NSString *)size;

//缓存风格（购物车进商品详情再缓存）
+(void)GoodsStyle2:(NSString *)style;

//缓存面料（购物车进商品详情再缓存）
+(void)GoodsMianLiao2:(NSString *)mianliao;

//删除再次缓存
+(void)RemoveHuanCunAgain;

//缓存已选属性组合的库存
+(void)HuanCunShuXingStock:(NSString *)HuanCunShuXingStock;

//商品属性数量
+(void)GoodsNumber:(NSString *)jianshu;

//商品属性记录件数
+(void)RemberAttributeNumber:(NSString *)rember;

//记录用户选择的配送方式
+(void)SelectSendWay:(NSString *)selectSendWay;

//缓存所选商品规格
+(void)HuanCunShangPinGuiGe:(NSString *)guige;

//图文详情缓存商品规格
+(void)TuWen:(NSString *)tuwen;

//购物车修改属性缓存值，来判断属性框的高度
+(void)Height:(NSString *)height;

//缓存返回的界面
+(void)CartBack:(NSString *)cartback;

//缓存默认商品属性
+(void)MoRen:(NSString *)moren;

//缓存属性
+(void)ShuXingString:(NSString *)shuxingstring;

//删除属性
+(void)RemoveShuXingString;

//购物车没修改属性完成，再次缓存属性
+(void)ShuXingAgain:(NSString *)again;
//清楚再次缓存
+(void)RemoveAgain;

//去除返回界面缓存
+(void)RemoveCartBack;

//删除缓存高度
+(void)RemoveHeight;

//缓存购物车件数
+(void)AppDelegateCartNumber:(NSString *)appdelegateCartNumber;

//清楚购物车缓存件数
+(void)DeleteAppDelegateCartNumber;


//缓存勾选状态
+(void)GoodsImageSecect:(NSString *)gouxuan;

+(void)YTString:(NSString *)string;

+(void)YTString1:(NSString *)string1;

+(void)YTString5:(NSString *)string5;

+(void)YTString6:(NSString *)string6;

+(void)YTText:(NSString *)text;
//删除勾选状态
+(void)removeAllImageSecect;
//清除颜色缓存
+(void)removeColor;
//清除颜色缓存
+(void)removeYYYTTT;
//清除尺寸缓存
+(void)removeSize;
//清除风格缓存
+(void)removeStyle;
//清除面料缓存
+(void)removeMianLiao;

//缓存店铺
+(void)FenLeiStore:(NSString *)fenleistore;
//缓存最大值
+(void)FenLeiMax:(NSString *)fenleimax;
//缓存最小值
+(void)FenLeiMin:(NSString *)fenleimin;

+(void)FenLeiRemove;

+(void)RemoveFenLeiMax;
+(void)RemoveFenLeiMin;
@end
