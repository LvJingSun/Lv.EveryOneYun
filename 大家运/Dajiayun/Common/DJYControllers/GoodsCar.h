//
//  GoodsCar.h
//  Dajiayun
//
//  Created by mac on 16/4/13.
//  Copyright © 2016年 fenghaiqiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodsCar : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *price;

@property (nonatomic, copy) NSString *pic;

@property (nonatomic, copy) NSString *time;

- (instancetype)initWithDict:(NSDictionary *)dic;

+ (instancetype)goodsCarWithDict:(NSDictionary *)dic;

@end
