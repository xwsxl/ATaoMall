//
//  FMDBDao.h
//  YFQChildPro
//
//  Created by user001 on 2017/4/27.
//  Copyright © 2017年 YFQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"
@interface FMDBDao : NSObject
+ (BOOL)executeUpdate:(NSString *)Sql;
+ (FMResultSet*)executeQuery:(NSString *)sql;
@end
