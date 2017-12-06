//
//  CarModel.m
//  BrandDemo
//
//  Created by mac on 16/4/21.
//  Copyright © 2016年 WJL. All rights reserved.
//

#import "CarModel.h"

@implementation CarModel

- (instancetype)initWithDict:(NSDictionary *)dic {

    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dic];
        
    }
    
    return self;
    
}

+ (instancetype)carModelWithDict:(NSDictionary *)dic {

    return [[self alloc] initWithDict:dic];
}

@end
