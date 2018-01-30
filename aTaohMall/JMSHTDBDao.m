//
//  JMSHTDBDao.m
//  aTaohMall
//
//  Created by DingDing on 2017/10/12.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "JMSHTDBDao.h"

@implementation JMSHTDBDao
+(void)initJMSHTDataBaseDao
{
    [FMDBDao executeUpdate:@"CREATE  TABLE IF NOT EXISTS [MessageList] ([id] TEXT PRIMARY KEY  NOT NULL ,[content] TEXT,[des_orderno] TEXT,[gid] TEXT,[is_browse] TEXT,[mid] TEXT, [order_type]  TEXT,[orderno] TEXT,[status] TEXT,[sys_type] TEXT,[sysdate] TEXT,[title] TEXT,[uid] TEXT )"];
    
}

+(void)insertMessageIntoMessageListWith:(MessageListModel *)model
{
    NSString *sql=[NSString stringWithFormat:@"insert into MessageList([id],[content],[des_orderno],[gid],[is_browse],[mid],[order_type],[orderno],[status],[sys_type],[sysdate],[title],[uid]) values(\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\")",model.ID,model.content,model.des_orderno,model.gid,model.is_browse,model.mid,model.order_type,model.orderno,model.status,model.sys_type,model.sysdate,model.title,model.uid];
    NSLog(@"sql=%@",sql);
    BOOL result=[FMDBDao executeUpdate:sql];
    
    if (result) {
        NSLog(@"添加消息到数据库成功");
    }else
    {
        NSLog(@"添加消息到数据库失败");
        sql=[NSString stringWithFormat:@"update [MessageList] set [content]=\"%@\",[des_orderno]=\"%@\",[gid]=\"%@\",[is_browse]=\"%@\",[mid]=\"%@\",[order_type]=\"%@\",[orderno]=\"%@\",[status]=\"%@\",[sys_type]=\"%@\",[sysdate]=\"%@\",[title]=\"%@\",[uid]=\"%@\" where [id]=\"%@\"",model.content,model.des_orderno,model.gid,model.is_browse,model.mid,model.order_type,model.orderno,model.status,model.sys_type,model.sysdate,model.title,model.uid,model.ID];
      BOOL result1=[FMDBDao executeUpdate:sql];
        NSLog(@"重新添加语句sql=%@",sql);
        if (result1) {
           NSLog(@"重新添加消息到数据库成功");
        }else
        {
           NSLog(@"重新添加消息到数据库失败");
        }
        
        
    }
    
    
    
}

+(void)updateMessageInfoInMessageListwith:(MessageListModel *)model
{
    NSString *sql=[NSString stringWithFormat:@"update [MessageList] set [is_browse]=\"%@\" where id=\"%@\"",@"0",model.ID];
    BOOL result=[FMDBDao executeUpdate:sql];
    NSLog(@"sql=%@",sql);
    if (result) {
        NSLog(@"修改消息成功");
    }else
    {
        NSLog(@"修改消息失败");
    }
    
    
    
}

+(void)deleteMessageInfoInMessageListWith:(MessageListModel *)model
{
    NSString *sql=[NSString stringWithFormat:@"delete from [MessageList] where id=\"%@\"",model.ID];
    BOOL result=[FMDBDao executeUpdate:sql];
    NSLog(@"sql=%@",sql);
    if (result) {
        NSLog(@"删除消息成功");
    }else
    {
        NSLog(@"删除消息失败");
    }
    
}



+(NSArray *)getMessageListFromDatabase
{
    NSMutableArray *TempArr=[NSMutableArray new];
    
    NSString *sql=[NSString stringWithFormat:@"select * from MessageList  order by sysdate desc"];
    FMResultSet *rs=[FMDBDao executeQuery:sql];
    NSLog(@"sql=%@",sql);
    while ([rs next]) {
        MessageListModel *model=[[MessageListModel alloc] init];
        model.ID=[rs objectForColumnName:@"id"];
        model.content=[rs objectForColumnName:@"content"];
        NSString *str = model.content;
        str = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]; //去除掉首尾的空白字符和换行字符
        str = [str stringByReplacingOccurrencesOfString:@"\r" withString:@""];
        str = [str stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        model.content=str;
        model.des_orderno=[rs objectForColumnName:@"des_orderno"];
        model.gid=[rs objectForColumnName:@"gid"];
        model.is_browse=[rs objectForColumnName:@"is_browse"];
        model.mid=[rs objectForColumnName:@"mid"];
        model.order_type=[rs objectForColumnName:@"order_type"];
        model.orderno=[rs objectForColumnName:@"orderno"];
        model.status=[rs objectForColumnName:@"status"];
        model.sys_type=[rs objectForColumnName:@"sys_type"];
        model.sysdate=[rs objectForColumnName:@"sysdate"];
        model.title=[rs objectForColumnName:@"title"];
        model.uid=[rs objectForColumnName:@"uid"];
        if (model.sysdate.length>17) {
        model.sysdate=[model.sysdate substringToIndex:model.sysdate.length-3];
        }
        
        NSDateFormatter *formatter=[NSDateFormatter new];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        
        NSString *today=[formatter stringFromDate:[NSDate date]];
        if ([model.sysdate containsString:today]) {
            model.sysdate=[model.sysdate stringByReplacingOccurrencesOfString:today withString:@"今天"];
        }
        
        NSString *yesterday=[formatter stringFromDate:[[NSDate date] dateByAddingTimeInterval:-60*60*24]];
        if ([model.sysdate containsString:yesterday]) {
            model.sysdate=[model.sysdate stringByReplacingOccurrencesOfString:yesterday withString:@"昨天"];
        }
        
        
        [TempArr addObject:model];
    }
    
    
    return [TempArr copy];
}


+(MessageListModel *)getMessageInfoFromMessageListWith:(NSString *)ID
{
    NSString *sql=[NSString stringWithFormat:@"select * from MessageList where id=\"%@\"",ID];
    FMResultSet *rs=[FMDBDao executeQuery:sql];
     MessageListModel *model=[MessageListModel new];
    while ([rs next]) {
       
        model.ID=[rs objectForColumnName:@"id"];
        model.content=[rs objectForColumnName:@"content"];
       // model.des_orderno=[rs objectForColumnName:@"des_orderno"];
        model.gid=[NSString stringWithFormat:@"%@",[rs objectForColumnName:@"gid"]];
        model.is_browse=[rs objectForColumnName:@"is_browse"];
        model.mid=[rs objectForColumnName:@"mid"];
       // model.order_type=[rs objectForColumnName:@"order_type"];
        model.orderno=[rs objectForColumnName:@"orderno"];
       // model.status=[rs objectForColumnName:@"status"];
       // model.sys_type=[rs objectForColumnName:@"sys_type"];
        model.sysdate=[rs objectForColumnName:@"sysdate"];
        model.title=[rs objectForColumnName:@"title"];
        model.uid=[rs objectForColumnName:@"uid"];
       // [JMSHTDBDao insertMessageIntoMessageListWith:model];
    }
    return model;
    
}

+(NSString *)getUnreadMessageNumFromMessageList
{
    NSString *str=@"0";
    NSString *sql=[NSString stringWithFormat:@"select * from MessageList where is_browse=\"1\""];
    FMResultSet *rs=[FMDBDao executeQuery:sql];
    while ([rs next]) {
        str=@"1";
    }
    return str;
}


@end
