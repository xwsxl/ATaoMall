//
//  JMSHTDBDao.h
//  aTaohMall
//
//  Created by DingDing on 2017/10/12.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDBDao.h"
#import "FMDB.h"
#import "MessageListModel.h"

@interface JMSHTDBDao : NSObject

+(void)initJMSHTDataBaseDao;

+(void)insertMessageIntoMessageListWith:(MessageListModel *)model;

+(void)updateMessageInfoInMessageListwith:(MessageListModel *)model;

+(void)deleteMessageInfoInMessageListWith:(MessageListModel *)model;

+(NSArray *)getMessageListFromDatabase;


+(MessageListModel *)getMessageInfoFromMessageListWith:(NSString *)ID;

+(NSString *)getUnreadMessageNumFromMessageList;
@end
