//
//  MessageListModel.h
//  aTaohMall
//
//  Created by DingDing on 2017/9/30.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageListModel : NSObject

@property (nonatomic,strong)NSString *uid;
@property (nonatomic,strong)NSString *des_orderno;
@property (nonatomic,strong)NSString *mid;
@property (nonatomic,strong)NSString *orderno;
@property (nonatomic,strong)NSString *order_type;
@property (nonatomic,strong)NSString *status;
@property (nonatomic,strong)NSString *title;
@property (nonatomic,strong)NSString *content;
@property (nonatomic,strong)NSString *is_browse;
@property (nonatomic,strong)NSString *sysdate;
@property (nonatomic,strong)NSString *ID;
@property (nonatomic,strong)NSString *sys_type;
@property (nonatomic,strong)NSString *gid;
@property (nonatomic,strong)NSString *refund_batchid;

/**
 Description 消息是否展开
 */
@property (nonatomic)       BOOL                 isOpen;

/**
 Description 消息高度
 */
@property (nonatomic)       CGFloat              height;

/**
 Description 消息闭合高度
 */
@property (nonatomic)       CGFloat              close_height;

/**
 Description 消息展开高度
 */
@property (nonatomic)       CGFloat              open_height;


@end
