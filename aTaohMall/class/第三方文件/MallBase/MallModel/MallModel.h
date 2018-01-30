//
//  MallModel.h
//  Mall
//
//  Created by DingDing on 15-1-20.
//  Copyright (c) 2015年 QJM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MallModel : NSObject

@property (nonatomic,strong) NSString *sigen_;//登录sigen
@property (nonatomic,strong) NSString *code_;//验证码

@property (nonatomic,strong) NSString *id_;//商品id
@property (nonatomic,strong) NSString *name_;//商品名称
@property (nonatomic,strong) NSString *account_;//商品介绍
@property (nonatomic,strong) NSString *pice_;//商品价格
@property (nonatomic,strong) NSString *integral_;//商品兑换积分数

@property (nonatomic,strong) NSString *tid_;//商品分类
@property (nonatomic,strong) NSString *mid_;//商家id
@property (nonatomic,strong) NSString *brand_;//商品品牌
@property (nonatomic,strong) NSString *note_;//商品详情
@property (nonatomic,strong) NSString *scopeimg_;//商品搜索显示图片
@property (nonatomic,strong) NSString *advertising_;//广告位
@property (nonatomic,strong) NSString *advertisingimg_;//广告位显示图片
@property (nonatomic,strong) NSString *type_;//兑换方式 0表示线下  1表示快递上门
@property (nonatomic,strong) NSString *number_;//数量？事实是指向了生日日期
@property (nonatomic,strong) NSString *aid_;//地址,判断兑换方式 存在表示可邮寄上门  不存在表示线下兑换  有兑换码expressno
@property (nonatomic,copy) NSString *integrations; //总积分
@property (nonatomic,copy) NSString *freight_; //运费
@property (nonatomic,copy) NSString *status_;  //发货状态
@property (nonatomic,strong) NSString *gid_;//商品id
@property (nonatomic,strong) NSString *expressno_;//线下兑换码

@property (nonatomic,strong) NSString *time_;//
@property (nonatomic,strong) NSString *deduction_;//使用积分数量
@property (nonatomic,strong) NSString *money_;//金额
@property (nonatomic,strong) NSString *deductionmoney_;//实付金额
@property (nonatomic,strong) NSString *order_;//消费订单号
@property (nonatomic,strong) NSString *obtainintergral_;//消费获得积分数
@property (nonatomic,strong) NSString *consumerType_;   //消费类型
@property (nonatomic,copy) NSString *payMoneys_; //总金额

@property (nonatomic,strong) NSString *phone_;//电话

@property (nonatomic,strong) NSString *emails_;//邮箱
@property (nonatomic,strong) NSString *qq_;
@property (nonatomic,strong) NSString *sex_;


@property (nonatomic,strong) NSString *bankcardno_;//银行卡号
@property (nonatomic,strong) NSString *bank_;//银行名称
@property (nonatomic,copy) NSString *bankno_;//银行号
@property (nonatomic,copy) NSString *bankType_;  // 银行卡类型

@property (nonatomic,copy) NSString *idCardNo_; //身份证号

@property (nonatomic,copy) NSString *bank_status_;


@property (nonatomic,strong) NSString *scope_;//搜索关键字

@property (nonatomic,copy) NSString *html_;

@property (nonatomic,strong) NSString *username_;//公司名
@property (nonatomic,strong) NSString *storename_;//商铺名
@property (nonatomic,strong) NSString *logo_;//公司标识
@property (nonatomic,strong) NSString *enterpriseimg_;//企业形象图
@property (nonatomic,strong) NSString *province_;//省
@property (nonatomic,strong) NSString *city_;//城市
@property (nonatomic,strong) NSString *county_;//区域
@property (nonatomic,strong) NSString *address_;//地址
@property (nonatomic,strong) NSString *coordinates_;//经纬度
@property (nonatomic,strong) NSString *storephone_;//商铺电话
@property (nonatomic,strong) NSString *enterpriseimg2_;//企业形象图

@property (nonatomic,strong) NSString *vipphoto_;//会员卡图标
@property (nonatomic,strong) NSString *upgrade1_;//升级消费金额1
@property (nonatomic,strong) NSString *upgrade2_;
@property (nonatomic,strong) NSString *upgrade3_;
@property (nonatomic,strong) NSString *upgrade4_;
@property (nonatomic,strong) NSString *upgrade5_;
@property (nonatomic,strong) NSString *discount1_;//折扣1
@property (nonatomic,strong) NSString *discount2_;
@property (nonatomic,strong) NSString *discount3_;
@property (nonatomic,strong) NSString *discount4_;
@property (nonatomic,strong) NSString *discount5_;

@property (nonatomic,strong) NSString *element1_;//会员卡显示元素 1 显示logo  0显示空
@property (nonatomic,strong) NSString *element2_;//会员卡显示元素 1 显示名称   0显示空
@property (nonatomic,strong) NSString *element3_;//会员卡显示元素 1 显示折扣   0显示空
@property (nonatomic,strong) NSString *rulename1_;//规则名
@property (nonatomic,strong) NSString *rulename2_;
@property (nonatomic,strong) NSString *rulename3_;
@property (nonatomic,strong) NSString *rulename4_;
@property (nonatomic,strong) NSString *rulename5_;

@property (nonatomic,assign) BOOL isN;

@property (nonatomic,strong) NSString *path_; //商户异步接口url




@end
