//
//  StringUtils.h
//  USMFramework
//
//  Created by yangHailang on 14-4-14.
//  Copyright (c) 2014年 usm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StringUtil : NSObject  


/*
 * 判断字符串是否为空
 */
+ (BOOL) isEmpty:(NSString*)input;

/*
 * 字符串长度
 */
+ (int)charCountOfString:(NSString *)string;

/*
 * int型转字符串
 */
+ (NSString*) intToString:(int)num;

/*
 * 中文转UTF-8
 */
+ (NSString *) chineseToUTF8:(NSString*) str;

/*
 * 浮点型转百分比
 */
+ (NSString*) floatToPercent:(NSString*)str;

/*
 * 去空格
 */
+ (NSString *) strTrim:(NSString*)str;

/*
 * 去反斜杠
 */
+ (NSString *) strBackslash:(NSString*)str;

/*
 * 验证是否是邮箱地址
 */
+ (BOOL) isEmailAddress:(NSString *)email;

/*
 * 验证是否是手机号码
 */
+ (BOOL) isMobileNum:(NSString *)mobile;

/*
 * 验证是否是车牌号
 */
+ (BOOL) isCarNO:(NSString*)carNo;

/*
 * 全是数字。
 */
+ (BOOL)isNumber:(NSString *)string;

/*
 * 验证英文字母
 */
+ (BOOL)isEnglishWords:(NSString *)string;

/*
 * 验证密码：6—16位，只能包含字符、数字和 下划线
 */
+ (BOOL)isValidatePassword:(NSString *)string;

/*
 * 验证是否为汉字。
 */
+ (BOOL)isChineseWords:(NSString *)string;//

/*
 * 验证是否为网络链接。
 */
+ (BOOL)isInternetUrl:(NSString *)string;

//正确格式为：XXXX-XXXXXXX，XXXX-XXXXXXXX，XXX-XXXXXXX，XXX-XXXXXXXX，XXXXXXX，XXXXXXXX
/*
 * 验证是否为电话号码。
 */
+ (BOOL)isPhoneNumber:(NSString *)string;


/*
 * 验证15或18位身份证。
 */
+ (BOOL)isIdentifyCardNumber:(NSString *)string;

+ (NSString*)arrayToString:(NSArray*)array divide:(NSString*)divide;


/*
 * 创建一个uuid
 */
+ (NSString*)createUUID;


/*
 * 创建一个没有符号的uuid
 */
+ (NSString*)getNoSymbolUUID;

/*
 * 创建一个appid
 */
+ (NSString*)getAppID;


@end
