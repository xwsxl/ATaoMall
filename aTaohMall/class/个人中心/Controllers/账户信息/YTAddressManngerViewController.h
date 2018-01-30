//
//  YTAddressManngerViewController.h
//  aTaohMall
//
//  Created by JMSHT on 2016/10/12.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GetGoodsAdddressDelegate <NSObject>

-(void)setUserNameWithString:(NSString *)name andPhoneWithString:(NSString *)phone andDetailAddressWithString:(NSString *)address andType:(NSString *)type andIDWithString:(NSString *)addressID andAddressReloadString:(NSString *)reload;

-(void)AddressReload;

-(void)AddressReload:(NSInteger)count;

//当删除最后一条收货地址时
-(void)DeleteTheLastAddress;

@end

@interface YTAddressManngerViewController : UIViewController


@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,copy)NSString *sigens;

@property(nonatomic,strong)UILabel *NoDatasLabel;

@property(nonatomic,copy) NSString *aid;

@property(nonatomic,copy) NSString *back;

@property(nonatomic,copy) NSString *YTString;

@property(nonatomic,weak)id <GetGoodsAdddressDelegate> delegate;//代理对象

@property(nonatomic,copy) NSString *deleteString;
@end
