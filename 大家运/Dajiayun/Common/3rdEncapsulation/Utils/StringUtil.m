//
//  StringUtils.m
//  USMFramework
//
//  Created by yangHailang on 14-4-14.
//  Copyright (c) 2014年 usm. All rights reserved.
//

#import "StringUtil.h"


#define CONF_APP_SERIALID @"SerialID"

@implementation StringUtil


/*
 * 判断字符串是否为空
 */
+ (BOOL)isEmpty:(NSString*)input
{
    if (input == nil || [@"" isEqualToString:input])
        return YES;
    
    for ( int i = 0; i < input.length; i++ ){
        char c = [input characterAtIndex:i];
        if ( c != ' ' && c != '\t' && c != '\r' && c != '\n' ){
            return NO;
        }
    }
    return YES;
}

/*
 * int型转字符串
 */
+ (NSString*) intToString:(int)num
{
    return [NSString stringWithFormat:@"%d", num];
}

/*
 * 字符串长度
 */
+ (int)charCountOfString:(NSString *)string
{
    int count = 0;
    NSInteger len =string.length;
    for (NSInteger i = 0; i < len; i++)
    {
        unichar c = [string characterAtIndex:i];
        if (isblank(c) || isascii(c))
        {
            count++;
        }
        else
        {
            count += 2;
        }
    }
    return count;
}

/*
 * 中文转UTF-8
 */
+ (NSString *)chineseToUTF8:(NSString*) str
{
    NSString *textStr = (__bridge NSString*)CFURLCreateStringByAddingPercentEscapes(
                                                                                    kCFAllocatorDefault,
                                                                                    (__bridge CFStringRef)(str),
                                                                                    NULL,
                                                                                    NULL,
                                                                                    kCFStringEncodingUTF8);
    return textStr;
}


/*
 * 浮点型转百分比
 */
+ (NSString*) floatToPercent:(NSString*)str
{
    if (str == nil) {
        return nil;
    }
    float _floatData = 100*[str floatValue];
    NSString *stringFloat = [NSString stringWithFormat:@"%f",_floatData];
    
    const char *floatChars = [stringFloat UTF8String];
    NSUInteger length = [stringFloat length];
    NSUInteger zeroLength = 0;
    NSInteger i = length-1;
    for(; i>=0; i--)
    {
        if(floatChars[i] == '0') {
            zeroLength++;
        } else {
            if(floatChars[i] == '.')
                i--;
            break;
        }
    }
    NSString *returnString;
    if(i == -1) {
        returnString = @"0";
    } else {
        returnString = [stringFloat substringToIndex:i+1];
    }
    return [NSString stringWithFormat:@"%@%@", returnString ,@"%"];
}


/*
 * 去空格
 */
+ (NSString *) strTrim:(NSString*)str
{
    return [str stringByReplacingOccurrencesOfString:@" " withString:@""];
}

/*
 * 去反斜杠
 */
+ (NSString *) strBackslash:(NSString*)str
{
    return [str stringByReplacingOccurrencesOfString:@"\\" withString:@""];
}

/*
 * 验证是否是邮箱地址
 */
+ (BOOL) isEmailAddress:(NSString *)email
{
    if ([email length] == 0)
    {
        return NO;
    }
    
    NSString *emailRegex = @"^\\w+((\\-\\w+)|(\\.\\w+))*@[A-Za-z0-9]+((\\.|\\-)[A-Za-z0-9]+)*.[A-Za-z0-9]+$";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:email];
}

/*
 * 验证是否是手机号码
 */
+ (BOOL) isMobileNum:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[0,0-9])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    //    NSLog(@"phoneTest is %@",phoneTest);
    return [phoneTest evaluateWithObject:mobile];
}

/*
 * 验证是否是车牌号
 */
+ (BOOL) isCarNO:(NSString*)carNo
{
    NSString *carRegex = @"^[A-Za-z]{1}[A-Za-z_0-9]{5}$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    NSLog(@"carTest is %@",carTest);
    return [carTest evaluateWithObject:carNo];
}


+ (BOOL)isNumber:(NSString *)string
{
    NSString *regex = @"^[0-9]*$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:string];
}

/*
 * 验证英文字母
 */
+ (BOOL)isEnglishWords:(NSString *)string
{
    NSString *regex = @"^[A-Za-z]+$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:string];
}

/*
 * 验证密码：6—16位，只能包含字符、数字和 下划线
 */
+ (BOOL)isValidatePassword:(NSString *)string
{
    NSString *regex = @"^[\\w\\d_]{6,16}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:string];
}

/*
 * 验证是否为汉字。
 */
+ (BOOL)isChineseWords:(NSString *)string
{
    NSString *regex = @"^[\u4e00-\u9fa5],{0,}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:string];
}

/*
 * 验证是否为网络链接。
 */
+ (BOOL)isInternetUrl:(NSString *)string
{
    NSString *regex = @"^http://([\\w-]+\\.)+[\\w-]+(/[\\w-./?%&=]*)?$ ；^[a-zA-z]+://(w+(-w+)*)(.(w+(-w+)*))*(?S*)?$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:string];
}

/*
 * 验证是否为电话号码。
 */
+ (BOOL)isPhoneNumber:(NSString *)string
{
    NSString *regex = @"^(\(\\d{3,4}\\)|\\d{3,4}-)?\\d{7,8}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:string];
}


/*
 * 验证15或18位身份证。
 */
+ (BOOL)isIdentifyCardNumber:(NSString *)string
{
    NSString *regex = @"^\\d{15}|\\d{}18$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:string];
}

/*
 * 数组转字符串 中间自定义分隔符
 */
+ (NSString*)arrayToString:(NSArray*)array divide:(NSString*)divide
{
    NSMutableString *builder = [[NSMutableString alloc] init];
    for (id a in array) {
        if (![self isEmpty:a]) {
            [builder appendString:divide];
            [builder appendFormat:@"%@", a];
        }
    }
    if (![self isEmpty:builder]){
        return [builder substringFromIndex:1];
    }
    return @"";
}


/*
 * 创建一个uuid
 */
+ (NSString*)createUUID
{
    CFUUIDRef uuidObject = CFUUIDCreate(kCFAllocatorDefault);
    NSString *appId = (NSString *)CFBridgingRelease(CFUUIDCreateString(kCFAllocatorDefault, uuidObject));
    return appId;
}

+ (NSString*)getNoSymbolUUID
{
    NSString* str = [self createUUID];
    NSString* uuid =[str stringByReplacingOccurrencesOfString:@"-" withString:@""];
    return [uuid lowercaseString];;
}



/*
 * 创建一个uuid
 */
+ (NSString*)getAppID
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *appID = [ud objectForKey:CONF_APP_SERIALID];
    if ([StringUtil isEmpty:appID]) {
        NSString* str = [self createUUID];
        appID = [str stringByReplacingOccurrencesOfString:@"-" withString:@""];
        appID = [appID lowercaseString];
        [ud setObject:appID forKey:CONF_APP_SERIALID];
    }
    return appID;
}

@end
