//
//  ContactsDao.h
//  DataBaseContact
//
//  Created by lunarboat on 15/9/7.
//  Copyright (c) 2015年 lunarboat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DatebaseUtil.h"
#import "Contact.h"

@interface ContactsDao : NSObject

//+(BOOL)createTable;
+(NSMutableArray*)queryData;
+(BOOL)deleteData:(int)memberId;
+(BOOL)insertData:(Contact*)contact;
+(BOOL)updateData:(Contact*)contact;
/**
 *  本地是否存在
 */
+(BOOL)queryDataISMember:(int)memberId;

/**
 *  从本地查找某个用户信息
 */
+(Contact*)queryDataMember:(int)memberId;

/**
 *  多线程查找
 */
+(Contact*)queryGCDDataMember:(int)memberId;

@end
