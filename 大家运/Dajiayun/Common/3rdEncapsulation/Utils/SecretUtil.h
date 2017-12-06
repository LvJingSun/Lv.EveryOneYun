//
//  USMSecretUtils.h
//  USMFramework
//
//  Created by yangHailang on 14-4-14.
//  Copyright (c) 2014年 usm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SecretUtil : NSObject 

//md5 加密方法
//返回 加密字符串
+(NSString *) md5: (NSString *) inputStr;

@end
