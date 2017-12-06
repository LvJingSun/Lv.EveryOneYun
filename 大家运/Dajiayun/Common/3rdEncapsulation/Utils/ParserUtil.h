//
//  ParserUtils.h
//  USMFramework
//
//  Created by yangHailang on 14-4-14.
//  Copyright (c) 2014年 usm. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum{
	TYPE_HTTP_CODE_404 = 404,
	TYPE_HTTP_CODE_500 = 500,
} TYPE_HTTP_CODE;

@interface ParserUtil : NSObject

/*
 *  NSDictionary 中根据key 获得模型value
 */
+ (id) getModel:(NSDictionary*)dic forKey:(NSString*) key;

/*
 *  NSDictionary 中根据key 获得字符串value
 */
+ (NSString *) getString:(NSDictionary*)dic forKey:(NSString*) key;

/*
 *  NSArray 中根据index 获得字符串value
 */
+ (NSString *) getString:(NSArray*)dic index:(int) index;
/*
 *  NSArray 中根据index 获得model
 */
+ (id) getModel:(NSArray*)array index:(int) index;

/*
 *  NSDictionary 中根据key 获得整型value
 */
+ (int) getInt:(NSDictionary*)dic forKey:(NSString*) key;

/*
 *  NSDictionary 中根据key 获得整型value
 */
+ (NSArray*) getArray:(NSDictionary*)dic forKey:(NSString*) key;

/*
 *  NSDictionary 中根据key 获得字典
 */
+ (NSDictionary*) getDic:(NSDictionary *)dic forKey:(NSString *)key;


+ (NSArray*) jsonStringToArray:(NSString*)str;

+ (NSDictionary*)jsonDataToDictionary:(id)data;

/*
 *  NSDictionary 转 字符串
 */
+(NSString *) jsonStringWithString:(NSString *) string;
+(NSString *) jsonStringWithArray:(NSArray *)array;
+(NSString *) jsonStringWithDictionary:(NSDictionary *)dictionary;
+(NSString *) jsonStringWithObject:(id) object;

/*
 *  字符串转NSData 转 NSString
 */
+ (NSString *) dataToString:(id)data;
/*
 *  解析获取服务端错误码
 */
+ (NSString*) parserHttpError:(NSError*)error;

@end
