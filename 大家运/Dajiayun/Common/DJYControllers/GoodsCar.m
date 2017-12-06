//
//  GoodsCar.m
//  Dajiayun
//
//  Created by mac on 16/4/13.
//  Copyright © 2016年 fenghaiqiang. All rights reserved.
//

#import "GoodsCar.h"

@implementation GoodsCar

- (instancetype)initWithDict:(NSDictionary *)dic {
    
    if (self = [super init]) {
        
        [self setValue:dic[@"name"] forKey:@"name"];
        
        [self setValue:dic[@"price"] forKey:@"price"];
        
        [self setValue:dic[@"pic"] forKey:@"pic"];
        
        [self setValue:dic[@"time"] forKey:@"time"];
        
    }
    
    return self;
    
}

+ (instancetype)goodsCarWithDict:(NSDictionary *)dic {

    return [[self alloc] initWithDict:dic];
    
}

@end
