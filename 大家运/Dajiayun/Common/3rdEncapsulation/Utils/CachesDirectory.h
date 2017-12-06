//
//  Common.h
//  CRM
//
//  Created by 冯海强 on 15/7/3.
//  Copyright (c) 2015年 YangHailang. All rights reserved.
//

#import <Foundation/Foundation.h>
//保存当前登录人信息
static NSString * CachesDirectory_MemberInfo_ACCOUNT   = @"CachesDirectory_MemberInfo_ACCOUNT";
static NSString * CachesDirectory_MemberInfo_PhotoMid   = @"CachesDirectory_MemberInfo_PhotoMid";
static NSString * CachesDirectory_MemberInfo_PhotoBig   = @"CachesDirectory_MemberInfo_PhotoBig";
static NSString * CachesDirectory_MemberInfo_MemberCode   = @"CachesDirectory_MemberInfo_MemberCode";
static NSString * CachesDirectory_MemberInfo_Phone   = @"CachesDirectory_MemberInfo_Phone";
static NSString * CachesDirectory_MemberInfo_NickName   = @"CachesDirectory_MemberInfo_NickName";
static NSString * CachesDirectory_MemberInfo_MemberID   = @"CachesDirectory_MemberInfo_MemberID";
static NSString * CachesDirectory_MemberInfo_MemberRole   = @"CachesDirectory_MemberInfo_MemberRole";
static NSString * CachesDirectory_MemberInfo_VersionNumber   = @"CachesDirectory_MemberInfo_VersionNumber";
static NSString * CachesDirectory_MemberInfo_AppPkgUrl   = @"CachesDirectory_MemberInfo_AppPkgUrl";
static NSString * CachesDirectory_MemberInfo_CoreIntro   = @"CachesDirectory_MemberInfo_CoreIntro";
static NSString * CachesDirectory_MemberInfo_DiQu   = @"CachesDirectory_MemberInfo_DiQu";
static NSString * CachesDirectory_MemberInfo_FrontCover   = @"CachesDirectory_MemberInfo_FrontCover";

static NSString * const SERVER_TIME_DIFF = @"serverTimeDiff";

//保存接口信息
static NSString * CachesDirectory_dajiayun_   = @"CachesDirectory_dajiayun_";


static NSString * const DATE_FORMAT = @"yyyy-MM-dd HH:mm:ss";

static NSString * const DATE_FORMAT_M = @"yyyyMMddHHmm";


@interface CachesDirectory : NSObject
//从本地沙盒中获取plist字典文件
+(NSDictionary *)GetNSCachesDirectoryPlist:(NSString *)plistname;
//写入本地沙盒plist文件
+(BOOL)writeToFilePlist:(NSString *)plistname anddic:(NSDictionary *)dic;

//获取usdefault值
+ (id) getValueByKey:(NSString *)key;
//数据写入usdefault磁盘
+ (void) addValue:(id)object andKey:(NSString *)key;
//获取MD5KEY
+ (NSString *) getServerKey;
@end
