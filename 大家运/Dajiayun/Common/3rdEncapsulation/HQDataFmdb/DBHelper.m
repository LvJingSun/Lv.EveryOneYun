//
//  DBHelper.m
//  baozhifu
//
//  Created by mac on 13-8-21.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import "DBHelper.h"
#import "FMDatabase.h"

static FMDatabase *db;

@implementation DBHelper

-(id)init {
    if (self = [super init]) {
        if (db == nil) {
//            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);

            NSString *documentDirectory = [paths objectAtIndex:0];
            //dbPath： 数据库路径，在Document中。
            NSString *dbPath = [documentDirectory stringByAppendingPathComponent:@"dajiayun_DBHelper.db"];
            db= [FMDatabase databaseWithPath:dbPath];
            if (![db open]) {

                return self;
            }
            [db executeUpdate:@"CREATE TABLE IF NOT EXISTS version (type text, ver text)"];
            [db executeUpdate:@"CREATE TABLE IF NOT EXISTS city (type text, code text, name text, category text, sort text)"];
            
            
            
            [db close];
        }
    }
    return self;
}

- (NSDictionary *)queryVersion {
    NSMutableDictionary *verDict = [[NSMutableDictionary alloc] initWithCapacity:0];
    if (![db open]) {

        return verDict;
    }
    FMResultSet *rs = [db executeQuery:@"SELECT * FROM version"];

    while ([rs next]) {
        NSString *type = [rs stringForColumn:@"type"];
        NSString *ver = [rs stringForColumn:@"ver"];
        [verDict setObject:ver forKey:type];
    }
    [rs close];
    [db close];
    return verDict;
}

- (NSMutableArray *)queryCategory {
    return [self queryData:@"category" andCategory:@"0"];
}

- (NSMutableArray *)queryProject:(NSString *) categoryId {
    return [self queryData:@"category" andCategory:categoryId];
}

- (NSMutableArray *)queryCity {
    return [self queryData:@"city" andCategory:@"0"];
}

- (NSMutableArray *)queryArea:(NSString *) cityId {
    return [self queryData:@"city" andCategory:cityId];
}

- (NSMutableArray *)queryMerchant:(NSString *) areaId {
    return [self queryData:@"city" andCategory:areaId];
}
/*
 *通过父id找子城市
*/
- (NSMutableArray *)queryCityDJYParentId:(NSString *) ParentId {
    return [self queryData:@"city" andCategory:ParentId];
}

- (NSMutableArray *)queryData:(NSString *)type andCategory:(NSString *)category {
    NSMutableArray *list = [[NSMutableArray alloc] init];
    if (![db open]) {

        return list;
    }
    NSString *sql = @" SELECT * FROM city where type=? and category=?";
    FMResultSet *rs = [db executeQuery:sql, type, category];
    while ([rs next]) {
        NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithCapacity:0];
        NSString *code = [rs stringForColumn:@"code"];
        [data setObject:code forKey:@"code"];
        NSString *name = [rs stringForColumn:@"name"];
        [data setObject:name forKey:@"name"];
        [list addObject:data];
    }
    [rs close];
    [db close];
    return list;
}

- (void)updateData:(NSArray *)list andType:(NSString *)type andVersion:(NSString *)ver {
    if (![db open]) {

        return;
    }
    [db beginTransaction];
    [db executeUpdate:@"DELETE FROM version WHERE type=?", type];
    [db executeUpdate:@"INSERT INTO version (type, ver) VALUES (?,?)", type, ver];
    [db executeUpdate:@"DELETE FROM city WHERE type=?", type];
    NSString *sql = @"INSERT INTO city (type, code, name, category) VALUES (?,?,?,?)";
    for (NSDictionary *data in list) {
        if ([@"city" isEqualToString:type]) {
            [db executeUpdate:sql, type, [data objectForKey:@"CityId"], [data objectForKey:@"CityName"], [data objectForKey:@"ParentId"]];
        }
        if ([@"category" isEqualToString:type]) {
            [db executeUpdate:sql, type, [data objectForKey:@"ClassId"], [data objectForKey:@"ClassName"], [data objectForKey:@"ParentId"]];
        }
    }
    [db commit];
    [db close];
}



@end
