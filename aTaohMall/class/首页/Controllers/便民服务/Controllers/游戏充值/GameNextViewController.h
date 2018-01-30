//
//  GameNextViewController.h
//  aTaohMall
//
//  Created by JMSHT on 2017/4/27.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameNextViewController : UIViewController

@property(nonatomic,copy) NSString *cardname;

@property(nonatomic,copy) NSString *Id;

@property(nonatomic,copy) NSString *cardid;

@property(nonatomic,copy) NSString *seveiceid;
@property(nonatomic,copy) NSString *sigen;

@property(nonatomic,copy) NSString *Max;
@property(nonatomic,copy) NSString *Min;
@property(nonatomic,copy) NSString *istype;//是否有游戏点卡&&交易寄售	0：没有1：有

@property(nonatomic,copy) NSString *isnull;//是否有区服  0：没有  1：有

@property(nonatomic,copy) NSString *is_traffic_permit;//是否需要通行证   0：没有1：有

@property(nonatomic,copy) NSString *conversion_rate;//转换游戏币 币值（如1元=1Q币）

@property(nonatomic,copy) NSString *game_currency_name;//转换游戏币单位（如 点券）

@property(nonatomic,copy) NSString *Commitprice;

@property(nonatomic,copy) NSString *Commitid;

@property(nonatomic,copy) NSString *Commitcardid;

@property(nonatomic,copy) NSString *Commitcardnum;

@property(nonatomic,copy) NSString *Commitgame_userid;

@property(nonatomic,copy) NSString *Commitcardname;

@property(nonatomic,copy) NSString *Commitgame_area;

@property(nonatomic,copy) NSString *Commitpervalue;

@property(nonatomic,copy) NSString *Commitgame_srv;

@property(nonatomic,copy) NSString *Commitis_traffic_permit;

@property(nonatomic,copy) NSString *recharge_type;

@property(nonatomic,copy) NSString *cardname_type;

@property(nonatomic,copy) NSString *ChangeString;

@end
