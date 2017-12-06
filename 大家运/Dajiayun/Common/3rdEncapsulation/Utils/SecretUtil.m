//
//  USMSecretUtils.m
//  USMFramework
//
//  Created by yangHailang on 14-4-14.
//  Copyright (c) 2014年 usm. All rights reserved.
//

#import "SecretUtil.h"
#import "CommonCrypto/CommonDigest.h"

@implementation SecretUtil

//md5 加密方法
//返回 加密字符串
+(NSString *) md5: (NSString *) inputStr
{
    const char *cStr = [inputStr UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
        [hash appendFormat:@"%02X", result[i]];
    return [hash lowercaseString];
}

@end
