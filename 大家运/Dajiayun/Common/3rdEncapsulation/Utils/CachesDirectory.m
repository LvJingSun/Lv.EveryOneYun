//
//  Common.m
//  CRM
//
//  Created by 冯海强 on 15/7/3.
//  Copyright (c) 2015年 YangHailang. All rights reserved.
//
#import "CachesDirectory.h"
#import <CommonCrypto/CommonDigest.h>

static NSString* const PUBLIC_KEY = @"www.Maxlinks.cn20130601";

@implementation CachesDirectory


//从磁盘中获取字典
+(NSDictionary *)GetNSCachesDirectoryPlist:(NSString *)plistname;
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    //获取完整路径
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:plistname];
    NSData *data = [NSData dataWithContentsOfFile:plistPath];
    return (NSDictionary*) [NSKeyedUnarchiver unarchiveObjectWithData:data];;
}

//文件写入磁盘
+(BOOL)writeToFilePlist:(NSString *)plistname anddic:(NSDictionary *)dic
{
    NSData *myData = [NSKeyedArchiver archivedDataWithRootObject:dic];
    //获取路径
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:plistname];
    //写入文件
   return [myData writeToFile:path atomically:YES];
    
}

//获取usdefault值
+ (id) getValueByKey:(NSString *)key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (defaults) {
        return [defaults valueForKey:key];
    }
    return nil;
}
//数据写入usdefault磁盘
+ (void) addValue:(id)object andKey:(NSString *)key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (defaults) {
        [defaults setObject:object forKey:key];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *) getServerKey {
    NSString *account = [CachesDirectory getValueByKey:CachesDirectory_MemberInfo_ACCOUNT];
    NSString *mid = [CachesDirectory getValueByKey:CachesDirectory_MemberInfo_MemberID];
    NSTimeInterval diffTime = [[CachesDirectory getValueByKey:SERVER_TIME_DIFF] doubleValue];
    NSDate *serverDate = [NSDate dateWithTimeIntervalSinceNow:diffTime];
    NSString *serverDateStr = [CachesDirectory formatDate:serverDate dateFormat:DATE_FORMAT_M];
    NSString *key = [NSString stringWithFormat:@"%@%@%@%@", account, PUBLIC_KEY, mid, serverDateStr];
    key = [key substringToIndex:(key.length- 1)];
    NSString *md5 = [CachesDirectory md5Digest:key];

    return md5;
}

+ (NSString *)md5Digest:(NSString *)str {
    
    const char *cStr = [str UTF8String];
    
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(cStr, strlen(cStr), result);
    
    return [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7],result[8], result[9], result[10], result[11], result[12],result[13], result[14], result[15]];
    
}

+ (NSDate *)getDate:(NSString *) sDate dateFormat:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    return [formatter dateFromString:sDate];
}

+ (NSString *)formatDate:(NSDate *) date dateFormat:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    return [formatter stringFromDate:date];
}

+ (NSTimeInterval) computerServerTimeDiff:(NSString *)serverDateTime {
    NSDate *serverTime = [self getDate:serverDateTime dateFormat:DATE_FORMAT];
    return  [serverTime timeIntervalSinceNow];
}


@end
