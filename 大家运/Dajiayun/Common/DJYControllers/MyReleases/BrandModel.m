//
//  BrandModel.m
//  BrandDemo
//
//  Created by mac on 16/4/21.
//  Copyright © 2016年 WJL. All rights reserved.
//

#import "BrandModel.h"
#import "CarModel.h"

@implementation BrandModel

- (instancetype)initWithDict:(NSDictionary *)dic {

    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dic];
        
        NSMutableArray *models = [NSMutableArray arrayWithCapacity:self.cars.count];
        
        for (NSDictionary *dic in self.cars) {
            
            CarModel *carModel = [CarModel carModelWithDict:dic];
            
            [models addObject:carModel];
            
        }
        
        _cars = models;
        
    }
    
    return self;
    
}

+ (instancetype)brandModelWithDict:(NSDictionary *)dic {

    return [[self alloc] initWithDict:dic];
    
}

@end
