//
//  DatebaseUtil.m
//  DataBaseContact
//
//  Created by lunarboat on 15/9/7.
//  Copyright (c) 2015年 lunarboat. All rights reserved.
//

#import "DatebaseUtil.h"

@implementation DatebaseUtil

+(FMDatabase*)shareDateBase{
    static FMDatabase *db = nil;
    if (db == nil) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        
        NSString *documentDirectory = [paths objectAtIndex:0];
        //dbPath： 数据库路径，在Document中。
        NSString *dbPath = [documentDirectory stringByAppendingPathComponent:@"DJYcontacts.db"];
        
        db = [[FMDatabase alloc]initWithPath:dbPath];
    }
    return db;
}

+(FMDatabaseQueue *)getSharedDatabaseQueue
 {
    static FMDatabaseQueue *my_FMDatabaseQueue=nil;
       if (!my_FMDatabaseQueue) {
           NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
           NSString *documentDirectory = [paths objectAtIndex:0];
            NSString *dbPath = [documentDirectory stringByAppendingPathComponent:@"DJYcontacts.db"];
            my_FMDatabaseQueue = [FMDatabaseQueue databaseQueueWithPath:dbPath];
        }
        return my_FMDatabaseQueue;
}

@end
