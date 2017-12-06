//
//  MOTKeyChain.h
//  MOT
//
//  Created by fenghq on 15/11/23.
//  Copyright (c) 2015年 fenghq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MOTKeyChain : NSObject

+ (void)save:(NSString *)service data:(id)data;
+ (id)load:(NSString *)service;
+ (void)delete:(NSString *)service;

@end
