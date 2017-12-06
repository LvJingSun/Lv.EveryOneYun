//
//  NSData+Addition.m
//
//  Created by yangHailang on 14-4-14.
//  Copyright (c) 2014年 usm. All rights reserved.
//

#import "NSData+Addition.h"

@implementation NSData (Addition)

- (NSData *)dataWithObject:(id)object
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:object];
    return data;
}

- (id)convertDataToObject
{
    NSArray *array = [NSKeyedUnarchiver unarchiveObjectWithData:self];
    return array;
}

@end
