//
//  FMDBDao.m
//  YFQChildPro
//
//  Created by user001 on 2017/4/27.
//  Copyright © 2017年 YFQ. All rights reserved.
//

#import "FMDBDao.h"

@implementation FMDBDao
+ (FMDatabaseQueue*)sharedFMDBManager
{
    
    FMDatabaseQueue *FMDBHelper;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString * fullPathToFile= [documentsDirectory  stringByAppendingFormat:@"/JMSHTDAO.sp"];
    @synchronized(self){
        FMDBHelper = [FMDatabaseQueue databaseQueueWithPath:fullPathToFile];
    }
    
    return FMDBHelper;
}


+ (BOOL)executeUpdate:(NSString *)Sql
{
    
    __block BOOL flag=NO;
    if (!Sql) {
        return flag;
    }
    
    [[FMDBDao sharedFMDBManager] inDatabase:^(FMDatabase *db) {
        flag=[db executeUpdate:Sql];
    }];
    return flag;
    
}
+ (FMResultSet*)executeQuery:(NSString *)sql
{
    
    __block  FMResultSet *rs=nil;
    [[FMDBDao sharedFMDBManager] inDatabase:^(FMDatabase *db) {
        rs=[db executeQuery:sql];
    }];
    return rs;
}
@end
