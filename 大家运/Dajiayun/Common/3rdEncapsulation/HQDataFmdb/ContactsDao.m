//
//  ContactsDao.m
//  DataBaseContact
//
//  Created by lunarboat on 15/9/7.
//  Copyright (c) 2015年 lunarboat. All rights reserved.
//

#import "ContactsDao.h"


@implementation ContactsDao

+(NSMutableArray*)queryData{
    NSMutableArray *array = [[NSMutableArray alloc]init];
    FMDatabase *db = [DatebaseUtil shareDateBase];
    if (![db open]) {
        [db close];
        return nil;
    }
    [db setShouldCacheStatements:YES];
    FMResultSet *rs = [db executeQuery:@"SELECT * FROM contacts"];
    while ([rs next]) {
        Contact *contact = [[Contact alloc]init];
//        contact.memberId = [rs intForColumn:@"contact_id"];
//        contact.name = [rs stringForColumn:@"contact_name"];
//        contact.number = [rs stringForColumn:@"contact_number"];
        contact.memberId = [rs intForColumn:@"contact_memberId"];
        contact.nickName = [rs stringForColumn:@"contact_nickName"];
        contact.phone = [rs stringForColumn:@"contact_phone"];
        contact.photoMid = [rs stringForColumn:@"contact_photoMid"];

        [array addObject:contact];
    }
    [rs close];
    [db close];
    return array;
}
+(BOOL)insertData:(Contact*)contact{
    BOOL result = NO;
    FMDatabase *db = [DatebaseUtil shareDateBase];
    if (![db open]) {
        [db close];
        return NO;
    }
    [db setShouldCacheStatements:YES];
    
    if ([db tableExists:@"contacts"]) {
        result = YES;
    }else{
        if ([db executeUpdate:@"CREATE TABLE contacts(contact_memberId INTEGER PRIMARY KEY, contact_nickName TEXT, contact_phone TEXT , contact_photoMid TEXT)"]) {
            result = YES;
        }
    }
    
    if ([db executeUpdate:@"INSERT INTO contacts(contact_memberId,contact_nickName,contact_phone,contact_photoMid) VALUES (?,?,?,?)",@(contact.memberId),contact.nickName,contact.phone,contact.photoMid]) {
        result = YES;
    }
    [db close];
    return result;
}
+(BOOL)deleteData:(int)memberId{
    BOOL result = NO;
    FMDatabase *db = [DatebaseUtil shareDateBase];
    if (![db open]) {
        [db close];
        return NO;
    }
    [db setShouldCacheStatements:YES];
    if ([db executeUpdate:@"DELETE FROM contacts WHERE contact_memberId = (?)",@(memberId)]) {
        result = YES;
    }
    [db close];
    return result;
}
+(BOOL)updateData:(Contact*)contact{
    BOOL result = NO;
    FMDatabase *db = [DatebaseUtil shareDateBase];
    if (![db open]) {
        [db close];
        return NO;
    }
    [db setShouldCacheStatements:YES];
    if ([db executeUpdate:@"UPDATE contacts SET contact_nickName = (?),contact_phone = (?),contact_photoMid = (?) WHERE contact_memberId = (?)",contact.nickName,contact.photoMid,contact.photoMid,@(contact.memberId)]) {
        result = YES;
    }
    [db close];
    return result;
}

+(Contact*)queryDataMember:(int)memberId{
    FMDatabase *db = [DatebaseUtil shareDateBase];
    if (![db open]) {
        [db close];
        return nil;
    }
    [db setShouldCacheStatements:YES];
    FMResultSet *rs = [db executeQuery:@"SELECT * FROM contacts WHERE contact_memberId = (?)",@(memberId)];
    Contact *contact = [[Contact alloc]init];
    while ([rs next]) {
        contact.memberId = [rs intForColumn:@"contact_memberId"];
        contact.nickName = [rs stringForColumn:@"contact_nickName"];
        contact.phone = [rs stringForColumn:@"contact_phone"];
        contact.photoMid = [rs stringForColumn:@"contact_photoMid"];
    }
    [rs close];
    [db close];
    return contact;
}

+(BOOL)queryDataISMember:(int)memberId{
    FMDatabase *db = [DatebaseUtil shareDateBase];
    if (![db open]) {
        [db close];
        return NO;
    }
    [db setShouldCacheStatements:YES];
    FMResultSet *rs = [db executeQuery:@"SELECT * FROM contacts WHERE contact_memberId = (?)",@(memberId)];
    Contact *contact = nil;
    while ([rs next]) {
        contact.memberId = [rs intForColumn:@"contact_memberId"];
        contact.nickName = [rs stringForColumn:@"contact_nickName"];
        contact.phone = [rs stringForColumn:@"contact_phone"];
        contact.photoMid = [rs stringForColumn:@"contact_photoMid"];
        [rs close];
        [db close];
        return YES;
    }
    [rs close];
    [db close];
    return NO;
}

+(Contact*)queryGCDDataMember:(int)memberId
{
    FMDatabaseQueue *queue = [DatebaseUtil getSharedDatabaseQueue];
    Contact *contact = [[Contact alloc]init];
    [queue inDatabase:^(FMDatabase *db) {
        //打开数据库
        if ([db open]) {
            FMResultSet *rs = [db executeQuery:@"SELECT * FROM contacts WHERE contact_memberId = (?)",@(memberId)];
            while ([rs next]) {
                contact.memberId = [rs intForColumn:@"contact_memberId"];
                contact.nickName = [rs stringForColumn:@"contact_nickName"];
                contact.phone = [rs stringForColumn:@"contact_phone"];
                contact.photoMid = [rs stringForColumn:@"contact_photoMid"];
            }
        }

    }];
    return contact;
}

@end
