//
//  CarModel.h
//  BrandDemo
//
//  Created by mac on 16/4/21.
//  Copyright © 2016年 WJL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CarModel : NSObject

@property (nonatomic, copy) NSString *carName;

- (instancetype)initWithDict:(NSDictionary *)dic;

+ (instancetype)carModelWithDict:(NSDictionary *)dic;

@end
