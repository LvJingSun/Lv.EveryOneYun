//
//  ParserUtils.m
//  USMFramework
//
//  Created by yangHailang on 14-4-14.
//  Copyright (c) 2014年 usm. All rights reserved.
//

#import "ParserUtil.h"
#import "StringUtil.h"
#import "NSData+Addition.h"

@implementation ParserUtil

/*
 *  NSDictionary 中根据key 获得模型value
 */
+ (id) getModel:(NSDictionary*)dic forKey:(NSString*) key
{
    id value = @"";
    if (dic ) {
        @try {
            id _value = [dic objectForKey:key];
            if (_value == nil || _value == [NSNull null]) {
                value = nil;
            }else{
                value = _value;
            }
        }
        @catch (NSException *exception) {
        }
    }
    return value;
}

/*
 *  NSDictionary 中根据key 获得字符串value
 */
+ (NSString *) getString:(NSDictionary*)dic forKey:(NSString*) key
{
    NSString *value = @"";
    if (dic ) {
        @try {
            id _value = [dic objectForKey:key];
            if (_value == nil || _value == [NSNull null]) {
                value = @"";
            }else{
                value = [NSString stringWithFormat:@"%@", _value];
            }
        }
        @catch (NSException *exception) {
        }
    }
    return value;
}

/*
 *  NSArray 中根据index 获得字符串value
 */
+ (NSString *) getString:(NSArray*)array index:(int) index
{
    NSString *value = @"";
    @try {
        id _value = [array objectAtIndex:index];
        if (_value == nil || _value == [NSNull null]) {
            value = @"";
        }else{
            value = [NSString stringWithFormat:@"%@", _value];
        }
    }
    @catch (NSException *exception) {
    }
    return value;
}

/*
 *  NSArray 中根据index 获得model
 */
+ (id) getModel:(NSArray*)array index:(int) index
{
    id value ;
    @try {
      value= array.count>index?[array objectAtIndex:index]:nil;
    }
    @catch (NSException *exception) {
    }
    return value;
}

/*
 *  NSDictionary 中根据key 获得整型value
 */
+ (int) getInt:(NSDictionary*)dic forKey:(NSString*) key
{
    int value = -1;
    if (dic ) {
        @try {
            value = [[dic objectForKey:key] intValue];
        }
        @catch (NSException *exception) {
        }
    }
    return value;
}

/*
 *  NSDictionary 中根据key 获得数组
 */
+ (NSArray*) getArray:(NSDictionary*)dic forKey:(NSString*) key
{
    NSArray *array = [[NSArray alloc] init];
    if (dic ) {
        @try {
            array = [dic objectForKey:key];
        }
        @catch (NSException *exception) {
        }
    }
    return array;
}

/*
 *  NSDictionary 中根据key 获得字典
 */
+ (NSDictionary*) getDic:(NSDictionary *)dic forKey:(NSString *)key
{
    NSDictionary *mDic = nil;
    if (dic ) {
        @try {
            id v = [dic objectForKey:key];
            if (v != [NSNull null] && ![[NSString stringWithFormat:@"%@", v] isEqualToString:@"(null)"]) {
                mDic =[dic objectForKey:key];
            }
        }
        @catch (NSException *exception) {
        }
    }
    return mDic;
}

+ (NSArray*) jsonStringToArray:(NSString*)str
{
    if ([StringUtil isEmpty:str]) {
        return nil;
    }
    NSString * jsonString = str;
    NSStringEncoding  encoding = NSUTF8StringEncoding;
    NSData * jsonData = [jsonString dataUsingEncoding:encoding];
    NSError * error=nil;
    NSArray * parsedData = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
    return parsedData;
}

+ (NSDictionary*) jsonDataToDictionary:(id)data
{
    if (data == nil) {
        return nil;
    }
    
    [data dataWithObject:data];
    
    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"jsonstr: %@", str);
    NSError * error=nil;
    NSDictionary * parsedData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    return parsedData;
}


/*
 *  字符串转NSDictionary
 */
//+ (NSDictionary*)stringToDictionary:(NSString*)str
//{
//    return [str objectFromJSONStringWithParseOptions:JKParseOptionLooseUnicode];
//}


+(NSString *) jsonStringWithString:(NSString *) string
{
    return [NSString stringWithFormat:@"\"%@\"",
            [[string stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"] stringByReplacingOccurrencesOfString:@"\""withString:@"\\\""]
            ];
}

+(NSString *) jsonStringWithArray:(NSArray *)array
{
    NSMutableString *reString = [NSMutableString string];
    [reString appendString:@"["];
    NSMutableArray *values = [NSMutableArray array];
    for (id valueObj in array) {
        NSString *value = [self jsonStringWithObject:valueObj];
        if (value) {
            [values addObject:[NSString stringWithFormat:@"%@",value]];
        }
    }
    [reString appendFormat:@"%@",[values componentsJoinedByString:@","]];
    [reString appendString:@"]"];
    return reString;
}

+(NSString *) jsonStringWithDictionary:(NSDictionary *)dictionary
{
    NSArray *keys = [dictionary allKeys];
    NSMutableString *reString = [NSMutableString string];
    [reString appendString:@"{"];
    NSMutableArray *keyValues = [NSMutableArray array];
    for (int i=0; i<[keys count]; i++) {
        NSString *name = [keys objectAtIndex:i];
        id valueObj = [dictionary objectForKey:name];
        NSString *value = [self jsonStringWithObject:valueObj];
        if (value) {
            [keyValues addObject:[NSString stringWithFormat:@"\"%@\":%@",name,value]];
        }
    }
    [reString appendFormat:@"%@",[keyValues componentsJoinedByString:@","]];
    [reString appendString:@"}"];
    return reString;
}

+(NSString *) jsonStringWithObject:(id) object
{
    NSString *value = nil;
    if (!object) {
        return value;
    }
    
    if ([object isKindOfClass:[NSString class]]) {
        value = [self jsonStringWithString:object];
    }else if([object isKindOfClass:[NSDictionary class]]){
        value = [self jsonStringWithDictionary:object];
    }else if([object isKindOfClass:[NSArray class]]){
        value = [self jsonStringWithArray:object];
    }else{
        value = @"0";
    }
    return value;
}


/*
 *  字符串转NSData 转 NSString
 */
+ (NSString*) dataToString:(id)data
{
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}


/*
 *  解析获取服务端错误码
 */
+ (NSString*) parserHttpError:(NSError*)error
{
    NSInteger code = error.code;
    NSString *codeStr;
    switch (code) {
		case TYPE_HTTP_CODE_404:
			codeStr = @"404 服务器找不资源!";
			break;
		case TYPE_HTTP_CODE_500:
            codeStr = @"500 服务器遇到错误，无法完成请求!";
			break;
		default:
            codeStr = [NSString stringWithFormat:@"%@", @"网络或服务器故障,暂时无法连接!"];
			break;
	}
    return codeStr;
}



@end
